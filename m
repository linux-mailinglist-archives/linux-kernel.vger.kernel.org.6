Return-Path: <linux-kernel+bounces-364879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0394E99DA78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FF8282A74
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4630339A0;
	Tue, 15 Oct 2024 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hBwcS6+d"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBC13BC39
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950554; cv=none; b=rnrAT0jBglq55RIXJiggHmRVPWcVbooeBUQUCliondoU7wHdmct7R3H0LRYqYEXWyaaBVYPD3Vgolls/7nqADMtOD6mJuwbVyPEWM1lk8bk1Cvps+o9ovmrmErhCzdqKO/Vqzlc0TNR5lwr370x78cS/HYtAAZT0A/Aqzx3PyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950554; c=relaxed/simple;
	bh=MnPjnnIFLtrWvrXJlr8BDK31g0Cml9V40MaD2B9h5oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRIlWHqLtRWcqbgvw4/bNe/WAE5aN1h7FuieSZXnsq35b4Yo/Qi0nQ1vlm7hs4+O+5jyoRYShHnvAAX1ljEJW2gK/6iA+RoCRzs/z43OLY0KdnQxdbnA6Q9Xi/CYXIcUnXi3uUmh1ef4/G9YVxc9zqQ++M0MlivKkrkXhkyZMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hBwcS6+d; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3a309154aso16850165ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728950552; x=1729555352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7KnsMsLgHHAlAF8AZkFXLQreSsmSx1DXjOzlwCHV+Ds=;
        b=hBwcS6+dSTPPMRL7SYc24DJMLaku90+N1TYhLLusntchqA1CNIYJ7ED4ctttVlQtel
         CoLPvMvWq1bYqTnw3lREhLJB0WszORNNdpUzp2tRApivxYGNltsr/KBlQE6iy+TRS/AW
         iX3zaM/L5s5K/0WC54AXqwt8I2fN74fP0Encg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728950552; x=1729555352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KnsMsLgHHAlAF8AZkFXLQreSsmSx1DXjOzlwCHV+Ds=;
        b=JM9jKq5arRGau0BKm+zkg0wy/jjVE5Dd7vem/KKeYoUjPkmBk0aNnAWyhGygSOD0nW
         UlhFlbnnIx/pLBLdugdWZuyGESW5joKZNZchh0lR9O4XWQ2qYTMSgyFJOhqXLofvjiqA
         cskhJSxfTTCt9B/7+gBEWz0CIZy90cphajxBJp0gsdIeR8v90yrDARLEhAyYaJAxhWW3
         tVmVI3a7R2s5fRcYHpr1De5vfPW0TL5pjhJzbJvRuAjPrGndyxM4Po3C6i3TZnLHHGLG
         TCcMssi4YAuN+HJpzRbNEQT8NUcIZW9JgDPJX4nPzFNJ/wNujyrc0jKycTGVprA+LN9T
         T5PA==
X-Forwarded-Encrypted: i=1; AJvYcCXZXUT/Zvbrql3ruvF03uRF9ZkK6eKvSigX4rL7oZ+QhiT04rueKfZ2IGhDpLJYuUet82xoST9inOXWVvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQ9ymiuX1wmTp4OhKuqgvhaEkreEmvPvlksFF5RamjuwkD87a
	JjuzcyNSksx/C6pxqtHutSbysYRDK0Wa6w4h+DBhkm4MzmZ//RZyjyL1rrBmp7evYOEhhDEQ1WH
	L
X-Google-Smtp-Source: AGHT+IFDz5XO1kDv22Q96suK07QtAVK5mHYQiCCVxZPtzYKrKOc+rQeqSTXgN0R+eZonE2/80iWrCA==
X-Received: by 2002:a05:6e02:1705:b0:3a3:b256:f31f with SMTP id e9e14a558f8ab-3a3b5fb60cemr115496895ab.19.1728950551708;
        Mon, 14 Oct 2024 17:02:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d715e3d3sm415115ab.79.2024.10.14.17.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 17:02:31 -0700 (PDT)
Message-ID: <31a73bb7-47ec-496c-8a65-02e331051e0e@linuxfoundation.org>
Date: Mon, 14 Oct 2024 18:02:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] Bluetooth: btintel_pcie: Remove structually
 deadcode
To: "Everest K.C." <everestkc@everestkc.com.np>, marcel@holtmann.org,
 luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014163001.4537-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241014163001.4537-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 10:30, Everest K.C. wrote:
> The switch case statement has a default branch. Thus, the return
> statement at the end of the function can never be reached.
> Fixing it by removing the return statement at the end of the

Change "Fixing" to "Fix it"

> function.
> 
> This issue was reported by Coverity Scan.
> https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600709

Please include the output from the scan. People can't see this report
without logging in.

> 
> Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
>   drivers/bluetooth/btintel_pcie.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index e4ae8c898dfd..660496e55276 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
>   	default:
>   		return "unknown";
>   	}
> -	return "null";

What happens when you build your patch with -Werror?
Do you see any build errors?

>   }
>   
>   /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in

thanks,
-- Shuah

