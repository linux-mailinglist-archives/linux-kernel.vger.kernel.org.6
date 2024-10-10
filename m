Return-Path: <linux-kernel+bounces-358828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE7C998452
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671F7B26602
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD2A1C1AD0;
	Thu, 10 Oct 2024 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUfx1gP6"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887929AF;
	Thu, 10 Oct 2024 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558094; cv=none; b=HEq8I1xWLCk5716RC+9Eqx1mOF5yp3qzT46oi7vMEOWYmJGaYPSc0e6EAEKyOYsTBe1bBigQU42ttv32m51mZ73hVYvCF7/kgQaaUQC0MhB7aPx+2b95456TpYVYUnIvaxoOkoNti4XPT27pSWjKYDYxIpC8Id5Ir+AP26gufLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558094; c=relaxed/simple;
	bh=RL3uSZeIrH6d5BzVGAUrprfkh0HmInzaNVRnh+tYYiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cdm5RIQFbjZvkzOh6HlVegu3ET8m7Gwgc4PR6L0HMbrMeCkYiMokK42Pb6TgEYBQ1OvsaVovID5ui4AN84OaEL1yg3qxf/ONl4M7uQ0fmVxeyQ8oZ3GRRcNFQ1aY8p0nWqAiIwP28549O8xZCj/juqlF4YWmJzTCksasLGu0O9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUfx1gP6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86e9db75b9so145202666b.1;
        Thu, 10 Oct 2024 04:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728558091; x=1729162891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6hOB3WYe5ptd0V4yAFNBvH3wokk8CpFdZ0OmgAEsCA=;
        b=DUfx1gP6DJezRsv501CZBuEGaONVmnEbFqiVizCSo9XL2Ki0xiM8Ie6jQ08M8E79iX
         GQSasliKzjceEfOMvk0fzO7SlW/uIBhtIYzpgKnQedKK3rn4Ek0ZBgkEqZWKn62xAyMk
         a7EjZlbUp7sDAOJbZUdCS6MkbR5UDQWp5iFTGZVm9EG9+/wSc9ra4DndryOTUZA6QE2Q
         8Jjdo6WlgYmRvHZkiLLSYr57YCPND/iDeO/gEgpXocieXm0ukFd3E/3zbl4je/fyvaIG
         nfFMKpSNrfboBgSjKMVi2Cm9PdyWKBMh1Q4avdXzRBAi8Lp100kF3guYwQcYvDf5kJZb
         uw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728558091; x=1729162891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6hOB3WYe5ptd0V4yAFNBvH3wokk8CpFdZ0OmgAEsCA=;
        b=kWdJrTp+qvAOy9L0oC1Wpdys0cd7/EN3Ty0v9a8itHLOWswlafG84retvHbBDH3wwL
         b06s6eXtakDJ1EAX57Vb+UONkTXgnNPk7YjFLHIlqpEhqggvuRCqHsxNBDGCVsXXnHEe
         PsW2Tttv3q1wsq+cE9DIQ+Kg7Qu5jY+tzcHmTIHRQF1eGZqQTvY6QbyxZVcbBwMgtJQt
         asYEx5w+5N4mv6eNELRWIJx5KKN3x7CdfLdTEvSFFxh9VRVzIRU7MleynBCC+ecN+wCG
         87NR+bCCgsSi04zVH9uEPPYgPGhl/j+DXUWLm8Im5MMZmGamSiTtSISMNv1nHsjX/9aw
         WU5A==
X-Forwarded-Encrypted: i=1; AJvYcCVcGbZ9n3kkTamM7GVcZ2+j71XzUYm/Z4dhlge+IQhsTGEBAvgIQ40UkZpQoWD9uP/I+GYQTsb/xsK5N3c=@vger.kernel.org, AJvYcCWqMqcQUEPVj6zu0+EfjJ61R1lHq+54L1yJyPLJUXoatXR0m/nBFfh2VXMq+xuIdAI89yW+WTzvCZrAZlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqOCfHptZKed1UbFUltaO/k2q1Kji2+Xo+I30OyIUo6Tz1H3B
	T5HvU5PjJQptQNlurxRNDMm7I0/otzOwRCLD9ygiABH4t9ODpnor
X-Google-Smtp-Source: AGHT+IHbNEed4HOcT5QFwuxaCRiY2AqUAYWXaD8LyYy0wMdUUxQ+IElSGs2olFBYFKuyibS7TkhutA==
X-Received: by 2002:a17:907:6e89:b0:a8d:250a:52a8 with SMTP id a640c23a62f3a-a998d11896cmr507786466b.3.1728558090475;
        Thu, 10 Oct 2024 04:01:30 -0700 (PDT)
Received: from [192.168.42.132] ([81.95.8.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f35c46sm72920366b.89.2024.10.10.04.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 04:01:29 -0700 (PDT)
Message-ID: <53db6c40-10ff-45e6-b2cf-6a6a1a4f31c9@gmail.com>
Date: Thu, 10 Oct 2024 13:01:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8188: Remove unnecessary variable
 assignments
To: =?UTF-8?B?5ZSQ5b2s?= <tangbin@cmss.chinamobile.com>,
 broonie <broonie@kernel.org>
Cc: lgirdwood <lgirdwood@gmail.com>, perex <perex@perex.cz>,
 tiwai <tiwai@suse.com>,
 "angelogioacchino.delregno" <angelogioacchino.delregno@collabora.com>,
 linux-sound <linux-sound@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20241010073547.3720-1-tangbin@cmss.chinamobile.com>
 <ZwejOZQlSsWbAWBg@finisterre.sirena.org.uk>
 <202410101755089538782@cmss.chinamobile.com>
Content-Language: en-US
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <202410101755089538782@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/10/24 11:55, 唐彬 wrote:
> I am sorry, it's my mistake. I know the rule, just mistake.
> 

Please don't top most email but write the answer below the line you want 
to respond to. This will help others to better understand the context.

Best regards,
Matthias

> 
> 
> 
> 
> 
> 
> From: Mark Brown
> 
> 
> 
> Date: 2024-10-10 17:49
> 
> 
> 
> To: Tang Bin
> 
> 
> 
> CC: lgirdwood; perex; tiwai; matthias.bgg; angelogioacchino.delregno; linux-sound; linux-kernel; linux-arm-kernel; linux-mediatek
> 
> 
> 
> Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8188: Remove unnecessary variable assignments
> 
> 
> 
> On Thu, Oct 10, 2024 at 03:35:47PM +0800, Tang Bin wrote:
> 
> 
> 
>> In the function mtk_dai_hdmitx_dptx_hw_params, the variable
> 
> 
> 
>> 'ret' is redundant, thus remove it.
> 
> 
> 
>   
> 
> 
> 
> Please don't send patch serieses without cover letters, having a cover
> 
> 
> 
> letter makes it easier to tell why the series is a series and makes it
> 
> 
> 
> easier for tooling to work with the series.
> 
> 
> 


