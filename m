Return-Path: <linux-kernel+bounces-388705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9B69B635B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA861C20D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BA71E9079;
	Wed, 30 Oct 2024 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQ2F/0B6"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727D1E9078
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292595; cv=none; b=Zqxcfdx3k81ydgB7lTO8SLY2bYfpOA2WbHjXym4mSJAGm2HANvIcD03jPh/0OYqJzCCeeEkZZ2CigICN02lRxxveud0Il8zMjoYBEl1yjFxHqDDw7zs2luQQLbAs1JPn0BEPXCdwzFRoX7bWiYGaGS+Um3ouPW7feBkdw9LFSjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292595; c=relaxed/simple;
	bh=Xskowo2JrKgiuEf/ASq0/MvwNY+jLhWDLYQZVeMyCY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFSigcsv0FRgOZTB/ZagbcewTmDk907T40R0cBwmve9i/3hqjCDXtkwnEwv2T5uFmPeoldQ8xjE54R4x9aifVxoLi3YGVui0iHQVDAPNQMGBYGSFM+RTtnDUpbB+u7pWJlTRepqpKbOr8yoI+oUde4xx6hBjhd/WT4cf74ckVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nQ2F/0B6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d462c91a9so4667053f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730292591; x=1730897391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UyVmo4JQBKeEzxnePKos+ThEBHZ99otuDsHDx5ry1v4=;
        b=nQ2F/0B6ISiM5oai4+JYTHAInrdqo42RiIk0hEGiooKvHpX2d5wJZBrTypzwsCqAr9
         CyIBGEmKs/7MpCNwgYjq5YXE+WzyXD4aEUQm48Dn2mopjqrWEHEgVMu7kM0KGZnHXxcQ
         q6guiK4gz6mfINoNvDh9I/0CbQiGIuB9FWPgWrCoXhjMh8iKtJvPJ1KwCCSmJ4YB0T/4
         K36T2jhfjY7qKV8pMTvTQ/KGG3HVIX3Evza5PQVkU2DwysajfPObUkB0YUJMOo8XfdW0
         hH4uI5QocdkPB282q77cw7LJspsvxtO0BvpJj2TATet64wqROGZd/lKvragoS5lljgFG
         a8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730292591; x=1730897391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyVmo4JQBKeEzxnePKos+ThEBHZ99otuDsHDx5ry1v4=;
        b=Z/HNXFYnvPnEf/plL4tiAiRRrZBd+29+KQeqYEY1cnkyB4o/6mLoe299oI8ZNzWJ1g
         TgEw0N+RpnBbe42oqCJi5ugjioUsgnpitTDxvCl+d7ZzUq0PXERy1gK+pax0CTHqJebT
         zAqkTALH1/gPT/eFL1ShN1x/w2bkMDWL4HVCmvTR8mx8HC5G1hcBgYn/BzZn+bmt6wo1
         S/jO///orvmJZQaHk2IzLjwWctKCSpXk0fLF09Gzt2gBZcXRj0ZC2WECrmCnRYDR5JzA
         HuAwEoT9hu4H8WTRnAxZlutzzriWlbSTiQ6ryJ9Mx/nR98J9zPV7014h7+T/IZ+XjTTq
         q8DA==
X-Forwarded-Encrypted: i=1; AJvYcCUD9JpB3ja9B3urlCLumzx98mA3DnJLuBRKaWzywMTFQz7le0unYQEX1D8uJ3nuB9znsTdmum5SE2RjoUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCPlwaBwa7rYZuFCzr3P0dAimU3Pekj41VJuRdPn+3zvOYO/Te
	EkCYOqDkgq+W5mQC1wBbf9pWFK/S2jrUptCPrUzEYnh6lFJHBk4cZhJ761lZCaE=
X-Google-Smtp-Source: AGHT+IENv7pio/IJPFsHAGkR/WlrAiR0sRTKsv+efTJpMs8r1AenabTe5ZXSkASO6Q+2w1i9twimHg==
X-Received: by 2002:adf:a45d:0:b0:37e:d2ba:6f11 with SMTP id ffacd0b85a97d-381b70effc4mr2397016f8f.47.1730292591257;
        Wed, 30 Oct 2024 05:49:51 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm15427544f8f.70.2024.10.30.05.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 05:49:50 -0700 (PDT)
Message-ID: <2634dc58-84fc-429e-9e78-1b8a6a757483@linaro.org>
Date: Wed, 30 Oct 2024 12:49:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: atmel-quadspi: Create `atmel_qspi_ops` to support
 newer SoC families
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Varshini Rajendran <varshini.rajendran@microchip.com>,
 Mark Brown <broonie@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20241030084445.2438750-1-csokas.bence@prolan.hu>
 <7cc95e52-7509-44eb-8e30-d518283e7d87@linaro.org>
 <2b310b54-c215-40fa-b6d4-81faf75a8c9e@prolan.hu>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <2b310b54-c215-40fa-b6d4-81faf75a8c9e@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/30/24 12:37 PM, Csókás Bence wrote:
> Hi,

Hi!

> 
> On 2024. 10. 30. 12:09, Tudor Ambarus wrote:
>> I think it's fine to split sama7g5 addition in smaller steps. But please
>> add the sama7g5 support in the same patch set, otherwise this patch
>> doesn't make sense on its own.
> 
> Well, actually, we're using SAMA5D2. My goal was just to somewhat
> harmonize upstream with the vendor kernel so that we may contribute
> other patches that we have made on top of the latter, or in the future,
> take patches from upstream and apply it to our vendor kernel-based tree.
> This patch was only meant to lay the groundworks for future SAMA7G5
> support. I can of course send the "other half" of the original patch if
> needed, but I wouldn't want it to hold up this refactor.

Do you have a sama7g5 at hand? If not and unable to test it, it's
probably better to not touch that code, unless you get support from
someone to do the testing for you.

I still think that this patch on its own doesn't make sense without the
sama7g5 addition because nothing guarantees that sama7g5 will be added
on top of this. But I won't stand against your patch. Maybe others from
Cc find it fine.

> 
>> Also, if you think you significantly changed the code of authors, I
>> think it's fine to overwrite the authorship. Otherwise, try to keep the
>> authorship and specify your contributions above your S-o-b tag.
> 
> I don't know if it counts as "significantly changed", I split out parts
> of a patch that were relevant for our device, and made small adjustments
> to make it correctly apply to master. I didn't find a descriptive enough
> tag for this, so I just went with Cc:, but if so desired, I could change
> it to a S-o-b, Co-authored-by, Suggested-by etc.
> 
I think it's fine if you keep your authorship for this refactoring
patch, I was thinking more of the bulk of the sama7g5 changes.

Cheers and good luck!
ta

