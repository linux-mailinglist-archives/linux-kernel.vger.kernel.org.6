Return-Path: <linux-kernel+bounces-570427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEA5A6B03C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7191C7B346A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD76228C9C;
	Thu, 20 Mar 2025 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnuqufDd"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945D224220
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508104; cv=none; b=gUOwlodGCJUC8F1g27Nyp2KjDoqD/qfb7GPTCDyakHQTd1UOk5MgJDwQKhxZRhCYYEIUABXC4pR+SXM6WE+2+hNc2FeK1PdkyQ5u34L2VgAMexinunOeniZYRKWHhfWxphMl4/3ciQY6PxAwXGfEGV4LMUh6iYUBFPsOjCH93iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508104; c=relaxed/simple;
	bh=UBLaD4Nq5xNwf400rlM/sUNn9F560QUZ1XyT2uZZub8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tN++enEhzB3Y8pauIKM4eD3IJ3Pnxn3U8j7dJkIS17iywlRKpgiO1D+jMd3Y54ihJknoUfyqoGgCeeopw+6dVXgiyYXBVmLBIvTs2FrrHJPgLcTmZ9C0tOWEtrKEsYhw/g06eXT4mKSY8CLPw/dwJUTYl2I7CToXBimmcuJ9xdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LnuqufDd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso8848825e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742508100; x=1743112900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w8yT7bxx+POTQPmMty55njjk/M6SEwDhRgh0uxWleRk=;
        b=LnuqufDdNc0xgPOLrTPivBZCBviALYxIZERpaM9Wc3DDGtpUVHQDAh4XsT+IbtW3/e
         fHzLQJ3CXVL5RAg9OTwLtY0oAh5yCT80jgy4PUlJYlp0mZ4lKqCm2zuVIq7CcCkno3/r
         rbAO+yVYYQsRFRTumBiOiw/AYR8UVgj6Oz7F53O5I4SvD/EjB9iag3Xvvt3WAF/3wubF
         BDfA/BjEcAr1fsrknqDXoOoI3cKuMhnu3ipzglTJuxET2WWCgeQk6n6VMLjRG6TB/bYV
         8Uu+Z1tPleNrFM8Ev/Yrj3Usnr0vKb9qR0OKtx0mXIsht0DpmkRC2LvFchuetfihg8Vq
         OqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742508100; x=1743112900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8yT7bxx+POTQPmMty55njjk/M6SEwDhRgh0uxWleRk=;
        b=SbIJwUYYcLWLgEYQRe0qUbnDWBe5ciawLMdi/C5SzHj3pJCFCGmoLDrB5l1Ufw+v9M
         9fth4pRLoSIyGWIdWBb7+B42EY+GiAd0zZQDHDMxHMqk/5hgnhqSwbiP15jX6WePeL1z
         pTuYHE4HxNZZB7A0kAIf9Of8seymy8SmN3kMEg8y4g5STcZFSH5kDsoAlNpkpBvgLAjF
         HdGsK9W5AZ1zIGm+jIdXkaRcTXANAEmmNlcT+mQr4r0tUvUCs1AboaCBLq707FLk/ZHm
         mbtl0L8Gq0zgqu3L8xMUk+kZSJW4IK11gMFvSJAQQ2Vebpjq+afXuDJTuAM5Bp2PeiFK
         td2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAXT5Xy+mi4fi511tI0T6wZhYzuRWIjOclYk6TIN2dlwfrtEBTo0zPADWpZadYFwTp0zAEGy9g3epBOfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZoiMnS0uWsygIhq4Wmhu+//WcE8UkZvlqe7kk64I1sjAjkreo
	S7Rqi93BlPOtKp3BoKIeap8VoqFXLQaDg37AxtSh2X3QzSl7UwrMea+FNjOm/Cs=
X-Gm-Gg: ASbGnctnWCIXRf3uy75t2w9jLdMoJqTgGfEbQRkLdox0ZLcychG0ouwxdo/ORuymU4h
	PkhZYCBkwC/vQ2g9HA2mIGDsh0AcY1RNpXX1kD3QuxoWdy+Az6ttHiwt6GDf/1aXRuu1h7UWsaI
	tiuWWfWQiOUT/0BIXKA1i/IwLBTfKYssVKC3DOCx84mMW4vY9rgEtDwxMgWTAbYaoVdEbaWA340
	4Qq7ra5USH5Qx/uox0m/rGKlerGuKXUS7dKo+hLbLqQSHdoak8R64aOnHhVLg+4cmhCSCNnXykj
	8bqZwKQwXv5VQgoYKICDlw1oWyxRUPk6A8c9PwVNJvwKnWvwrY2FnZnJNUcAhyKfEIK+k/vS8de
	HnP1reevm1g==
X-Google-Smtp-Source: AGHT+IGz8sDCfiUcMrh3ZaHqynp/YtvdJQNLTBk+X4KzsimZeV2pCXU70QJKuqlDD/aS804bEebyZA==
X-Received: by 2002:a05:600c:1e8f:b0:43b:c7f0:6173 with SMTP id 5b1f17b1804b1-43d502e4332mr11888305e9.4.1742508099644;
        Thu, 20 Mar 2025 15:01:39 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd1c7sm8939025e9.40.2025.03.20.15.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 15:01:39 -0700 (PDT)
Message-ID: <fff943a6-4322-43d0-9821-08375bc5376c@linaro.org>
Date: Thu, 20 Mar 2025 22:01:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm64: defconfig: enable PCI Power Control for
 PCIe3
To: Wenbin Yao <quic_wenbyao@quicinc.com>, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, quic_qianyu@quicinc.com,
 sfr@canb.auug.org.au, linux-arm-kernel@lists.infradead.org
References: <20250320055502.274849-1-quic_wenbyao@quicinc.com>
 <zqBb_94gbwLzHgbAiLqgbuGg9wmeV1jUxHOsMXDdZToeTtRrtUimm8ra7GB48DXWU-ZOvC5mO8EY0uvxz46ISg==@protonmail.internalid>
 <20250320055502.274849-2-quic_wenbyao@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250320055502.274849-2-quic_wenbyao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 05:55, Wenbin Yao wrote:
> From: Qiang Yu <quic_qianyu@quicinc.com>
> 
> Enable the pwrctrl driver, which is utilized to manage the power supplies
> of the devices connected to the PCI slots. This ensures that the voltage
> rails of the x8 PCI slots on the X1E80100 - QCP can be correctly turned
> on/off if they are described under PCIe port device tree node.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 85ec2fba1..de86d1121 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -245,6 +245,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
>   CONFIG_PCI_ENDPOINT=y
>   CONFIG_PCI_ENDPOINT_CONFIGFS=y
>   CONFIG_PCI_EPF_TEST=m
> +CONFIG_PCI_PWRCTL_SLOT=y
>   CONFIG_DEVTMPFS=y
>   CONFIG_DEVTMPFS_MOUNT=y
>   CONFIG_FW_LOADER_USER_HELPER=y
> --
> 2.34.1
> 
> 

PCI_PWRCTL_SLOT is a tristate symbol why be a "y" instead of an "m" i.e. 
compile this into the kernel instead of having it be a module ?

---
bod

