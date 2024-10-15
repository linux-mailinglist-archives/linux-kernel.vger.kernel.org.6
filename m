Return-Path: <linux-kernel+bounces-365681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D299E5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096D81F241C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A70A1D9A42;
	Tue, 15 Oct 2024 11:35:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B71E7666;
	Tue, 15 Oct 2024 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992131; cv=none; b=JC7vjwbeQO/Zn3sBy5sKAbKyCCSOHybQ6X3VwBEPJhqeRd9GlNn6rFViNYHUYTWLjW+4t0kMoDwpw7CGIn4FoofhzXWSdhLeEsin2p5/AGVkGsohT9y+RwIwUK08zjSk6xs+XZvojGapIR/Dq2EylaiQDXcJkbtdOT95DUE+QPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992131; c=relaxed/simple;
	bh=53rF6c5jakcS+ik3mitMUiEe/F1PijH5LdoA3YfLRmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiJneA6gQl2AQsm7VdfmYAbJuXRfVwheqAJWtDJdJK4ceUgIK/T4DLg9Pd+TlHtQtrS5h2dQ+i1VbFmPYmFtvB7JxsN771KmAcWvfPS0y8Zp9xlcMLsqCQoyKg5cm8lWlFIcJ+QwXey+a1lvO9qXQfg3InJmyrVjchnx83MjaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16B0B1007;
	Tue, 15 Oct 2024 04:35:58 -0700 (PDT)
Received: from [10.57.86.207] (unknown [10.57.86.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE23D3F51B;
	Tue, 15 Oct 2024 04:35:24 -0700 (PDT)
Message-ID: <6258fd24-e708-444b-88a3-792c14527817@arm.com>
Date: Tue, 15 Oct 2024 12:35:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 22/57] sound: Remove PAGE_SIZE compile-time
 constant assumption
Content-Language: en-GB
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Kalesh Singh <kaleshsingh@google.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>,
 Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-sound@vger.kernel.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-22-ryan.roberts@arm.com>
 <Zw0CyAlSmaxOCZJl@finisterre.sirena.org.uk>
 <6926988e-5532-457f-9e1a-135b03585c5d@arm.com>
 <Zw1AWEpQYBDyBar6@finisterre.sirena.org.uk>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zw1AWEpQYBDyBar6@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 17:01, Mark Brown wrote:
> On Mon, Oct 14, 2024 at 01:24:02PM +0100, Ryan Roberts wrote:
>> On 14/10/2024 12:38, Mark Brown wrote:
>>> On Mon, Oct 14, 2024 at 11:58:29AM +0100, Ryan Roberts wrote:
> 
>>>> ***NOTE***
>>>> Any confused maintainers may want to read the cover note here for context:
>>>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>>> As documented in submitting-patches.rst please send patches to the 
>>> maintainers for the code you would like to change.  The normal kernel
>>> workflow is that people apply patches from their inboxes, if they aren't
>>> copied they are likely to not see the patch at all and it is much more
>>> difficult to apply patches.
> 
>> Sure. I think you're implying that you would have liked to be in To: for this
>> patch? I went to quite a lot of trouble to ensure all maintainers were at least
>> in the To: field for patches touching their code. But get_maintainer.pl lists
>> you as a supporter, not a maintainer when I ran this patch through. Could you
>> clarify what would have been the correct thing to do? I could include all
>> reviewers and supporters as well as maintainers but then I'd be banging up
>> against the limits for some of the patches.
> 
> The entry in MAINTAINERS for me is a M:, supporter is just the usual
> get_maintainers noise.  Supported is exactly equivalent to a maintainer.

Ugh, In my head I always thought "supporter" was somebody who engaged with the
subsystem but did not have an official role (like a football supporter). But now
that I've gone and read the MAINTAINERS file, I see it's actually referring to
status (supported vs maintained). Sorry about this. Due to this buggy filtering,
I've missed a few others off other patches in this series. I'll fix that by
forwarding to them.

> Generally if you're going to filter people you should be filtering less
> specific matches out rather than more and if you're looking to filter
> very aggressively look at who actually commits changes to whatever
> you're trying to change, less specific maintainers will generally
> delegate down to the more specific ones.
> 
>>> It's probably better to just use PAGE_SIZE_MAX here and avoid the
>>> deferred patching, like the comment says we don't particularly care what
>>> the value actually is here given that it's a dummy.
> 
>> OK, so would that be:
> 
>> 	.buffer_bytes_max	= 128*1024,
>> 	.period_bytes_min	= PAGE_SIZE_MAX,      <<<<<
>> 	.period_bytes_max	= PAGE_SIZE_MAX*2,    <<<<<
>> 	.periods_min		= 2,
>> 	.periods_max		= 128,
> 
>> It's not really clear to me how all the parameters interact; the buffer size
>> 128K, which, if PAGE_SIZE_MAX is 64K, would hold 1 period of the maximum size.
>> But periods_min is 2. So not sure that works? Or perhaps I'm trying to apply too
>> much meaning to the param names...
> 
> Like Takashi says just using absolute numbers here is probably just as
> sensible, the numbers are there to stop userspace tripping over itself
> but like I say it shouldn't ever get as far as actually using them for
> anything.  So long as we end up with some numbers that don't need any
> late init patching the specifics aren't super important, the use of
> PAGE_SIZE was kind of random.

OK, I'll post a respin of this patch independently of the rest of the series,
given it no longer has a dependency.

Thanks,
Ryan


