Return-Path: <linux-kernel+bounces-427599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED999E0338
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4698287195
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816FC1FF7C2;
	Mon,  2 Dec 2024 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="oSPJ1Urp"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33503200108;
	Mon,  2 Dec 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145595; cv=none; b=T1p606yJ0nCv5HsUstU0fwmIkSTO29OKhJ5Tdix8V8NikBJ2wnjjTzLBGtOFNBLeNLRV2ZnvZwSCeDJaMGMBFBWbN6xKDwkIczyKiH4ywh1uHHVzlU2SDwMk2O9tXdbpk58u/DnW380Em9sMBh2Z5QbYs6FLlf3kwiC1xadjccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145595; c=relaxed/simple;
	bh=yaUqx6K9fkaOFNDKEIBtmlrrCsL+aOkTGK7JAx/vMb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qdd8/3qjbLMcMh92sK0tdPlubtZlxVYffX0mMJVweOsbw9iIG5TlU+OlABLLuQtFNU/dTNE/pTAl731BIfiaghnZ1CvMS+BEKf1RDrIZLbUfsmk0ZarG3cLp/jjyXioy24Uxt1/x7nTofbEFeRSf8ITpc9MrzV/GvK68kokLkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=oSPJ1Urp; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5A3A6A0365;
	Mon,  2 Dec 2024 14:19:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=svV0/3uF6IUmbGm1JvpE
	CltQfqjOP2APO0thyVFbZY0=; b=oSPJ1UrpsayIy6NSbibVCUlxIIjVPArEJBZD
	z6GW2GAfv2RQo9g5ES9C/qn/fPNwK3k9Eo2s1rHC/OJQk+UQVfcdl6d8WXQQYIor
	hw3WL15PHFSpUcE7/K1XeqPfRGsxNVZt21QV+1FE2lepxsDnt3Q0dHceytEZT1pP
	cnsGFl9Oc8jhP6Px5PN5eGfl/hjFwj5ZJsCr3Nfc3OePpNGGkxXS7NtrzrRpCO1M
	X3+AeHtABs7FVqbxeG51TKo3BR/i9SYP8KpB7EOL2LNkc4ACV81O7d/dOOforyDP
	TCnlG3JVwCCMdhcfBUNouuYlFu6mrCOQVr1MCKQuO6Qqwcxo3S+jNuErVWLrHSBz
	JKwQz+iUcWIFGZRYaZf2qhUoxrQX5hDE56TWHfFi6wm0y8SRUnOaiVWOTtyB6bf9
	FfLK5R3jYyZR6nV+U/GP5jzVQlYSa5kwKtRSHLU2KMNm3lU9QVYR85uak8DsA3j4
	WTRMuZ6wOOpyYIGzTYgu0LM59zT4nzapHNBhkV8u+idzs13NHgBvaU+xaSKs8s1P
	NJ7QVuBDdm+HhGF1COCwjvQLJoj7P5e98MbG6Z/usiWP4RltdBo54Zh7inY4oqWA
	vTrDeSB5iH7JKit/HHWSUcGpSOMryzv4og8l3TnHVUJZQa2AJvjnppNELIDJ5e9p
	kPbxNaA=
Message-ID: <47344634-9681-43a0-995a-f7dc025d1d09@prolan.hu>
Date: Mon, 2 Dec 2024 14:19:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] ASoC: sun4i-codec: Add DMA Max Burst field
To: Mark Brown <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Mesih Kilinc
	<mesihkilinc@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>
References: <20241102125712.2647325-1-csokas.bence@prolan.hu>
 <20241102125712.2647325-2-csokas.bence@prolan.hu>
 <fe02df7f-16ae-4128-9af8-7de7f76734bc@sirena.org.uk>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <fe02df7f-16ae-4128-9af8-7de7f76734bc@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637261

Hi,

On 2024. 12. 02. 14:14, Mark Brown wrote:
> On Sat, Nov 02, 2024 at 01:57:10PM +0100, Csókás, Bence wrote:
>> From: Mesih Kilinc <mesihkilinc@gmail.com>
>>
>> Allwinner suniv F1C100s has similar DMA engine to sun4i but it has
>> smaller max burst size compared to sun4i. Add a quirk field to
>> differantitate between them.
> 
> This doesn't apply against current code, please check and resend.

Try v6: 
https://lore.kernel.org/linux-kernel/20241123123900.2656837-1-csokas.bence@prolan.hu/

If that doesn't apply either, then I'll look into it, but it seems we 
already missed the MW for 6.13... :(

Bence


