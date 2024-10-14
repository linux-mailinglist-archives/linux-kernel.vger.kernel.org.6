Return-Path: <linux-kernel+bounces-364023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A1899CA02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 758D1B24397
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C434D1A4B69;
	Mon, 14 Oct 2024 12:24:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69D07E574;
	Mon, 14 Oct 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908650; cv=none; b=KHP0q1ciOlJtOHBaB1CbOGmtN81OnBHsZL9l2exxhGbR5bZgsS3FtAAjGnZkAoOK5hbJQ27t5vD8Ujel22eECv1B12nP6o35JRTPIn5ZHtWxHeg3JEs5StfIS0uAHZxAM+Cp6i7mnrA6LC9i7LiPPf65PZRWQbpOeU/jd5Ds7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908650; c=relaxed/simple;
	bh=Le0e0kUNrDFWDkroBhdDWVbxdg0w8tcg9r/v0Nd3f28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwJRMNAH8WGT9WzT2ZUK9FstwwqgQ41pywwEtG4tFNeXf8QMcAAbKf4ac11a+1b6jiGoBcIHi4NEMkO9xntamypS8lQa2yvKUszmzVt6zhqU3B4Qh12PaEwLlDPLr6jW7L95Zl8WFEWLiRu6ekwdEMbaOYUd/uDwWTd04CWRPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 322411007;
	Mon, 14 Oct 2024 05:24:37 -0700 (PDT)
Received: from [10.57.86.130] (unknown [10.57.86.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2053C3F71E;
	Mon, 14 Oct 2024 05:24:03 -0700 (PDT)
Message-ID: <6926988e-5532-457f-9e1a-135b03585c5d@arm.com>
Date: Mon, 14 Oct 2024 13:24:02 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zw0CyAlSmaxOCZJl@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 12:38, Mark Brown wrote:
> On Mon, Oct 14, 2024 at 11:58:29AM +0100, Ryan Roberts wrote:
>> To prepare for supporting boot-time page size selection, refactor code
>> to remove assumptions about PAGE_SIZE being compile-time constant. Code
>> intended to be equivalent when compile-time page size is active.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

No problem, will fix this in the next round (where I anticipate sending more
targetted serieses to maintainers).

> 
>> ***NOTE***
>> Any confused maintainers may want to read the cover note here for context:
>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
> As documented in submitting-patches.rst please send patches to the 
> maintainers for the code you would like to change.  The normal kernel
> workflow is that people apply patches from their inboxes, if they aren't
> copied they are likely to not see the patch at all and it is much more
> difficult to apply patches.

Sure. I think you're implying that you would have liked to be in To: for this
patch? I went to quite a lot of trouble to ensure all maintainers were at least
in the To: field for patches touching their code. But get_maintainer.pl lists
you as a supporter, not a maintainer when I ran this patch through. Could you
clarify what would have been the correct thing to do? I could include all
reviewers and supporters as well as maintainers but then I'd be banging up
against the limits for some of the patches.

Or perhaps I've misunderstood the point you're making here.

> 
>> -static const struct snd_pcm_hardware dummy_dma_hardware = {
>> +static DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(struct snd_pcm_hardware, dummy_dma_hardware, {
>>  	/* Random values to keep userspace happy when checking constraints */
>>  	.info			= SNDRV_PCM_INFO_INTERLEAVED |
>>  				  SNDRV_PCM_INFO_BLOCK_TRANSFER,
>> @@ -107,7 +107,7 @@ static const struct snd_pcm_hardware dummy_dma_hardware = {
>>  	.period_bytes_max	= PAGE_SIZE*2,
>>  	.periods_min		= 2,
>>  	.periods_max		= 128,
>> -};
>> +});
> 
> It's probably better to just use PAGE_SIZE_MAX here and avoid the
> deferred patching, like the comment says we don't particularly care what
> the value actually is here given that it's a dummy.

OK, so would that be:

	.buffer_bytes_max	= 128*1024,
	.period_bytes_min	= PAGE_SIZE_MAX,      <<<<<
	.period_bytes_max	= PAGE_SIZE_MAX*2,    <<<<<
	.periods_min		= 2,
	.periods_max		= 128,

?

It's not really clear to me how all the parameters interact; the buffer size
128K, which, if PAGE_SIZE_MAX is 64K, would hold 1 period of the maximum size.
But periods_min is 2. So not sure that works? Or perhaps I'm trying to apply too
much meaning to the param names...

Thanks,
Ryan



