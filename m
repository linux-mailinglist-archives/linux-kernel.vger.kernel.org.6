Return-Path: <linux-kernel+bounces-414891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164999D2EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA628282C89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5261D1F72;
	Tue, 19 Nov 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGIMntYq"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD831D1305
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045042; cv=none; b=vFS/pNaSzO6lzLSSTAp+iKkepkPF50IvSLSyd3KKGwtMVRtOk+OUdMPDclFp3D2+6RaFwnpufHgKo5whTgBIRpy0BU6MCH4hkaO++1sHKNitzaqIipuxUhhFu3BYUam4pWH7KjL+EA7X40AR1gBaPvxAonRt53G5dDf03muz3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045042; c=relaxed/simple;
	bh=4WUsRG+jUTGOH6GZS0Jn15Kxz1vwJeJmhrF/5snu5EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Er3iCYl6teMyDGzSdhuM8GKuX/Z8ACHwmG8H53yDY9miS8VeXiO1NLIa0P8xGapvLVAj5jOLfrwcDs8akChR3PtXKp+INoJQL8DD1fjB/GlYBnpDalXbaqcdH9l6leLv6xH7c/JwiHBAvZTucCJchUixu/RT2jkBrC2c4/hlT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DGIMntYq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315dfa3e0bso4182615e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732045038; x=1732649838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hxlFvij/ZEjGN1MCcEsA2qGkS/XD29eeUgFlVEB7nLM=;
        b=DGIMntYq6RrTIEvdCBM//AsEzrtcJFmMjxUWIseLYhcaI2YGTxNCK72CzQ22B4eLV1
         4IkFEOSshlAK6B00ezn3iTAit+OMcZn9GD1w0qw5QXgObBeQGo1MUwRnQU485I3OyiIL
         NrF9npLg3xreBhq9AfdkMl45xPajbI3Kdasc8c/CjXymircQs5qX5o5usHPK1gAXY9Y2
         +0FXo6oVoLmZ9rB5Yu9T02W1ptMrhwiNiLSQglrfU/vaVLPxaiUElxQJJAgGzEz+3yGv
         HLN3XGBQrsIKR+H4T4Qj69sBzUCFWosNcXLl8/LtlgowW6q8fbaN7LV9UUKSx2DrEJMr
         5OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732045038; x=1732649838;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxlFvij/ZEjGN1MCcEsA2qGkS/XD29eeUgFlVEB7nLM=;
        b=WvzIYOY1rGH89WDTxKVxqaETX2dXfQaj9cRa3M8QKzFYuZ2woZC8eu19yNk97ewQiC
         GrTlo+PlhRVSzRPUpeOk+Mn+tCpsV7+BFX8jpjEegDd58bojb92iigD3ra0Cwttnrqk/
         L9RLqB1qpiboLuB/ZfdhXTXY9YIkh+A2VbpYIs6o22B0jz1QYRKW0pHGcVKNd8wvCNrW
         XxSi1eEdtbfuhFCajmWzq2uVSCS1EEgXWQKRJhIJsBcW4/VFfI+h1pDUo2lQIoqKm+0b
         5X8Nd8qXvx/aOJvjzMqFJaEcNDA6g5/OKJps3l3DJpYJVXDiJQycgBS9p+b7B5XMfjvm
         PXWA==
X-Forwarded-Encrypted: i=1; AJvYcCXmYjAa2zAqY237pQAlNHf2ouQnX6+4PrjTe6DhNzQHqzLnrqQaki2Xo5UwM/m1OYRapNSSqAN11sjSKtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp13XWP073u05qmhYQCQH1Fm5v17D6FAMS351KrBQg+1z8ae4/
	WQq1hXq+Ov9RZmFeG7Q/6f2dXqC+Nyd6LKb6Ey7pUkttlfwdyEJZBV7excby/r0=
X-Gm-Gg: ASbGnct52p5lelqIU5c69fU93j1/toFx6BVvh8t4PXr+kclQZwTMpDp30ofvNYerHIL
	fVEDz5t9ymefz8pd2ZvChwqcCDDFS3G2+C0b4OxwNBZcqMv8bDR1jDIYBInzwHKsz/kGVC68Kmn
	Co86eG6g7KiFZ9I/1OURc43Md3ystACpCSFjlbNgTofudkaAbThhz6QQ7L1EPipDmQQtMizTTP8
	iuuR/kSJzKVWMb0ppWnIsgAxlMEGDKs8pGhKzVYxAieoZsURvkEMh6xWiGrVDu45UVciw==
X-Google-Smtp-Source: AGHT+IEfxHZ/bh3pnAXH7HujNQIk/LVuiWotqDESjFDdoRKIBz9grgL85uRIkssQGDgyNuM3ikqQ1A==
X-Received: by 2002:a5d:598e:0:b0:382:4378:464b with SMTP id ffacd0b85a97d-38254b24edamr4715f8f.10.1732045038436;
        Tue, 19 Nov 2024 11:37:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254905294sm129183f8f.11.2024.11.19.11.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 11:37:17 -0800 (PST)
Message-ID: <3bfd6343-de4a-4cf5-a4b8-55a3531eb41e@linaro.org>
Date: Tue, 19 Nov 2024 20:37:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 4/6] firmware: qcom: scm: Cleanup global '__scm'
 on probe failures
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Mukesh Ojha
 <quic_mojha@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Kuldeep Singh <quic_kuldsing@quicinc.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Andrew Halaney <ahalaney@redhat.com>,
 Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>,
 Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
 <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-4-7056127007a7@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-4-7056127007a7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/11/2024 19:33, Krzysztof Kozlowski wrote:
>  	/*
>  	 * Initialize the QSEECOM interface.
> @@ -2094,6 +2104,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>  
>  	return 0;
> +
> +err:
> +	/* Paired with smp_load_acquire() in qcom_scm_is_available(). */
> +	smp_store_release(&__scm, 0);
Heh, I should store there NULL, obviously.

Best regards,
Krzysztof

