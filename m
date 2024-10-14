Return-Path: <linux-kernel+bounces-364064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB099CAB7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E611C216CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872EC1A76B9;
	Mon, 14 Oct 2024 12:52:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75AA1E4A6;
	Mon, 14 Oct 2024 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910364; cv=none; b=u9+HswUvlTFshiifpRuWF7cxpll4qYEQGTGUAY7Bhz0GPcnzpFkH2bO3rdHlaGl4E7aVMJaitc7+YFtsCz++WZW9R6kjleVHlRFww1Sk/OjX7y/GAKBC4iO1pxUtW5cE1KfKt/0CkGjXAjP83FzmolDQLIX2uDGCPrOZmGaL2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910364; c=relaxed/simple;
	bh=458ho3Gm2j1lXgX8YZMKNcsGXPvTarfh65XlkNE2CGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6X27E89MpjVUOzd5bubms4V6IwTGEg/6By0mB2FrxU30uYMiqYZ2eEHXMryt0SLP2e6wjXjcwN4s2nSgXhiHrwEYF6emNKFasazkvV0p7yp1a0D3uNbDbOkgukhJ0eRw23anY3se0BE+8zW0Ao/ikmb2E1aSuizAArJ9ojredY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87E011007;
	Mon, 14 Oct 2024 05:53:11 -0700 (PDT)
Received: from [10.57.86.130] (unknown [10.57.86.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 507043F71E;
	Mon, 14 Oct 2024 05:52:38 -0700 (PDT)
Message-ID: <5e9ee10b-fc15-4c6a-a666-0d80ec8bdd9a@arm.com>
Date: Mon, 14 Oct 2024 13:52:36 +0100
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
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
 <6926988e-5532-457f-9e1a-135b03585c5d@arm.com> <8734kyyhzh.wl-tiwai@suse.de>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8734kyyhzh.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 13:41, Takashi Iwai wrote:
> On Mon, 14 Oct 2024 14:24:02 +0200,
> Ryan Roberts wrote:
>>
>> On 14/10/2024 12:38, Mark Brown wrote:
>>> On Mon, Oct 14, 2024 at 11:58:29AM +0100, Ryan Roberts wrote:
>>>> -static const struct snd_pcm_hardware dummy_dma_hardware = {
>>>> +static DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(struct snd_pcm_hardware, dummy_dma_hardware, {
>>>>  	/* Random values to keep userspace happy when checking constraints */
>>>>  	.info			= SNDRV_PCM_INFO_INTERLEAVED |
>>>>  				  SNDRV_PCM_INFO_BLOCK_TRANSFER,
>>>> @@ -107,7 +107,7 @@ static const struct snd_pcm_hardware dummy_dma_hardware = {
>>>>  	.period_bytes_max	= PAGE_SIZE*2,
>>>>  	.periods_min		= 2,
>>>>  	.periods_max		= 128,
>>>> -};
>>>> +});
>>>
>>> It's probably better to just use PAGE_SIZE_MAX here and avoid the
>>> deferred patching, like the comment says we don't particularly care what
>>> the value actually is here given that it's a dummy.
>>
>> OK, so would that be:
>>
>> 	.buffer_bytes_max	= 128*1024,
>> 	.period_bytes_min	= PAGE_SIZE_MAX,      <<<<<
>> 	.period_bytes_max	= PAGE_SIZE_MAX*2,    <<<<<
>> 	.periods_min		= 2,
>> 	.periods_max		= 128,
>>
>> ?
>>
>> It's not really clear to me how all the parameters interact; the buffer size
>> 128K, which, if PAGE_SIZE_MAX is 64K, would hold 1 period of the maximum size.
>> But periods_min is 2. So not sure that works? Or perhaps I'm trying to apply too
>> much meaning to the param names...
> 
> Right, when PAGE_SIZE_MAX is 64k, 128k won't be used because of the
> constrant of periods_min=2.
> 
> As Mark mentioned, here the actual size itself doesn't matter much.
> So I suppose it'd be even simpler to define just 4096 and 4096 * 2 for
> period_bytes_min and *_max instead of sticking with PAGE_SIZE.  Then
> it would become platform-agnostic, too.

OK great I'll set these to 4096 and 4096*2 for the next version.

Thanks for the feedback!

> 
> 
> thanks,
> 
> Takashi


