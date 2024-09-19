Return-Path: <linux-kernel+bounces-333369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840EF97C780
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3115C1F29E58
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E319DF9C;
	Thu, 19 Sep 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="co309K1B"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425619DFBB;
	Thu, 19 Sep 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739121; cv=none; b=Ltp+90of1yyDsgMux+44DtPrzvtGWUAj4useCvBUEXusw2y9KKE5XbhVjeWQt2If3QpoTP0UiGezJANfgFgBiJSlTOaMzEFvVrfYLlBe7Og0Bytbh7S/5K9m+Oz9VQGxZJgWy/EiKt+IxkyQ/zzwRDmVcrG7faitI5EI1yzQ/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739121; c=relaxed/simple;
	bh=k5xmfyVdyCvrB2WJTpIJB9/AIvpppvVVztmANlpPdJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzTO79mAzjms6oUdRCF7AnkkNpw8aAKzKx8lk8yV8y0IYxo02r5IAZLmXZYolr98mqUTuEAqZFB6GFXLr0BNJGVZ4ISZh0SuI7hwArZnRY6B7ZHa6VFASf/PaAf5hKa7bmm4oMhLmx0Pq9EZq52LtFBi/N1cS5AlcqKSf37y0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=co309K1B; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.96] (pd9e59da1.dip0.t-ipconnect.de [217.229.157.161])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 1A8972FC005B;
	Thu, 19 Sep 2024 11:45:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1726739115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLzXgz6POjQZOmuww2M/f0naB3HRg4Ck33Y/3loj2wc=;
	b=co309K1BJB3wHgyqw+qF5NSFtlvoxwq10nHPmLP59q7XpFGSEz3tNBruYdgk08oS/W9sZ5
	JG6xvqP5pAfDSMMCjfRF3HDhoFtvzBxcWK3kNd+cJ4EdH55t7nLPb4p09ovw3HefZ6MUYt
	ir2/Tlr9DmqyK3pTI4BlbuTG1r9eWF0=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <0593dc74-0a8c-4147-822d-0785c9d5aec3@tuxedocomputers.com>
Date: Thu, 19 Sep 2024 11:45:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
To: Takashi Iwai <tiwai@suse.de>, Christoffer Sandberg <cs@tuxedo.de>
Cc: Jerry Luo <jerryluo225@gmail.com>, Christian Heusel
 <christian@heusel.eu>, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>
References: <c930b6a6-64e5-498f-b65a-1cd5e0a1d733@heusel.eu>
 <87jzfbh5tu.wl-tiwai@suse.de>
 <66dfd536-ae17-4d75-b514-7931a3734e54@gmail.com>
 <20f70c0a92a27db29f188e05c33ba82c@tuxedo.de>
 <1fbba03e-56b8-4e74-adf6-998e3a2d9dac@gmail.com>
 <87setxe68m.wl-tiwai@suse.de> <87r09he63e.wl-tiwai@suse.de>
 <dfb141e8-6afa-4d21-8cd4-f9a53e8a192e@tuxedocomputers.com>
 <87r09hcbr0.wl-tiwai@suse.de> <cedb8758bb506bf9454b90eebcaaea24@tuxedo.de>
 <874j6cc96f.wl-tiwai@suse.de>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <874j6cc96f.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi,

Am 19.09.24 um 10:57 schrieb Takashi Iwai:
> On Wed, 18 Sep 2024 16:10:00 +0200,
> Christoffer Sandberg wrote:
>>
>>
>> On 18.9.2024 15:49, Takashi Iwai wrote:
>>> On Wed, 18 Sep 2024 15:39:28 +0200,
>>> Werner Sembach wrote:
>>>> Hi
>>>>
>>>> Am 18.09.24 um 10:09 schrieb Takashi Iwai:
>>>>> On Wed, 18 Sep 2024 10:06:01 +0200,
>>>>> Takashi Iwai wrote:
>>>>>> [...]
>>>>>> I don't see any relevant about the incorrect volumes by the suggested
>>>>>> commit, but at least we should avoid applying the quirk for a
>>>>>> non-existing speaker pin.
>>>>>>
>>>>>> Jerry, yours is with CX11970 (codec id 0x14f120d0), right?
>>>> Yes, at least for the preproduction sample of the Sirius Gen1 I have
>>>> at hand atm.
>>>>
>>>> pciid is 2782:12c3
>>>>
>>>> @Christoffer: I guess 2782:12c5 is for the Gen2?
>> Yes the other is for Sirius Gen2
>>
>>> Hm, and one of those PCI SSID conflicts with System76 Pangolin
>>> (pang14)?  All seem to have the very same codec CX11970.
>> I don't think I saw the pci id explicitly listed, but that was the
>> assumption.
>>
>>> If they really conflict in both PCI and HD-audio codec IDs, the only
>>> way would be to check DMI string, I'm afraid.
>>>
>> I asked about the volumes since it could be a hint that a second
>> speaker is activated but stuck on a fixed volume. This would make a
>> low general volume setting sound louder but still somewhat adjustable.
>>
>> However, if we can not verify second speaker pair, then I agree, DMI
>> limit would be the safe choice.
> So, just to make clear: the device reported for a regression and the
> device you tried to tweak are different models?  The former is
> Pangolin and the latter Sirius Gen 2.  I'm confused by models.

Yes, the regression report is for the Pangolin, which seems to be affected by a 
patch that should only affect the Sirius 16 Gen1 & Gen2.

>
> With the quirk, you'll get an individual mixer element controlling the
> top speaker volume?
Yes (for the Sirius devices at least, we ofc don't have a Pangolin laying around 
we could test), unless you use this 
https://github.com/alsa-project/alsa-ucm-conf/pull/410 alsa patch Christoffer 
wrote for TUXEDO_OS and sent to upstream which merges them down into one 
controlling both speaker pairs.
>
>
> Takashi

Kind regards,

Werner


