Return-Path: <linux-kernel+bounces-225626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DA791330B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1012828BF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 10:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B173714D432;
	Sat, 22 Jun 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIBJixxF"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6B818
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719053234; cv=none; b=OG2YYtn1PiedyCqCNCGhaO4DbaihWiKDS7Ihk9FFqF3dHozCyllkVQ0ucyDEi8Ilz0UGD6Ztm2t+3IZul8fmy9Wf1IWkhJzsH2peBsJTlyShIKBGYXcK3ekoj9y1mtq1dzckq6Q2ajtTSDiuitPp7daDMvdGvSCi+ozyshtj02A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719053234; c=relaxed/simple;
	bh=/csiwm84ObWwf+jKb/NjNWgFEOnJJFiWOMgSdEFLohg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCE1OGrzNFbSQMNMNJIbb6Ed/ebC1TnE630x+lbW0GsVa29KnxPluhOhZLlaQISkHvjPDR9RvMW5S8edQhI0ZZhchbZHTb/dPK5KBzykXp7DOF0e5JQlrnMDH0BU76LNgYoDJ9kq0v68tJydWvMUpNO0FnB9VO0DWDg8BuL202U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bIBJixxF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-421d32fda86so31949655e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719053230; x=1719658030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yIkgsmSuwLuYmoWZWqX/68bZk5aVVz1tB5jeLe6Fcns=;
        b=bIBJixxFC9YWRaqJPdtqICx73A5zM4L5fzg1j9nURFzRyRKYTCRV/7q/F+CVwDQsTh
         5tJKnh9L2eKmoj/WkYOSvy+DAAPZZRyPqktrJysuxdPvUoalmpUO8obG7+Xzd7RaIilu
         n11AIYNNU0kCYZ4yUUuUXBRdiPG74NYL5fRY9WXFGgj2SS1fJmT91IeVvNGrvz9B0B45
         jB/uKtpzjpZRf8IZlFjrvyHd34tQM9VUpoV2zUR0oMzHcYeqJx/lpEmCitCBLm3DO8Lm
         PQTYETbNLUrxeqEvSgtLABQXXQCsyeYrZIr3zJ6vjBVJaVN2b5KApVX9jiXwfMZbeNHd
         0edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719053230; x=1719658030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIkgsmSuwLuYmoWZWqX/68bZk5aVVz1tB5jeLe6Fcns=;
        b=F0OlLGpWoT8fMkoIT6E6RALji/mgZ3G6rb/RKDlBI8t1bu/zjYUNenUYho8t3N2QYC
         NyTKfDPYKVREhaWRcZ1OiVOwMb94vPuEAArjZTBuEONNtIbxr8vxivvtzQSo/iTgBfNr
         tAaL6ct/zXEEgKncEmeVw1OHWHhWpfgiF9Ytvu0tSR6ujzIpjXQoeqk4T4Fob0x1qJ5P
         GY8fqQ/Hp8UU8gwnYInRWp/aNwOBzhJeQLFvi7n8YunTiNNMD899P2geQLlL1mws8vwc
         ZXEC+H91jLQTFv9ZVWYH/YXCo0g2iTLneEw2KFv09oGxhp8OJ7tkUz4Gh5chQo6iFhNl
         QbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgTdvEeHPu8hJrE4x64kKPva1huzSShOk0ziJdAMmbP655IbF0JbUaQYiTRtbdIj/y/AuBWA/+Wkug3HQHXDS2aRXasCKmgm6GY7gS
X-Gm-Message-State: AOJu0YzjQGKp8B2E7xwI6m/KPXXWrC00ACXxzNgXQcz4+Pqeik1/hzLi
	Vf8w8FlEFd5/Haxpg9Bwb8Jdwb3AnKHOzUAOp0eQ429dLt8M1FPl1AUI2HBaQck=
X-Google-Smtp-Source: AGHT+IHn1InNC33kwCui1Dlcfdf6RZqGMfE03lhPXvz5XVM3Qwts2wYYQ19CitvzIAzjozJVJenXMg==
X-Received: by 2002:a05:600c:3592:b0:422:7ad4:be7c with SMTP id 5b1f17b1804b1-4247529bd90mr97119795e9.34.1719053230383;
        Sat, 22 Jun 2024 03:47:10 -0700 (PDT)
Received: from [172.20.10.4] (82-132-215-235.dab.02.net. [82.132.215.235])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-424817a9667sm59158655e9.15.2024.06.22.03.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 03:47:09 -0700 (PDT)
Message-ID: <7b97ef5b-a3e1-4c02-a013-2bd1c97a0e65@linaro.org>
Date: Sat, 22 Jun 2024 11:47:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmem: kconfig: set i.MX OCOTP default y
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20240603070007.2413599-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240603070007.2413599-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2024 08:00, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> If ARCH_MXC is selected, set NVMEM_IMX_OCOTP[*] default y which will make
> nfs rootfs work since i.MX network driver needs read mac address from
> fuse.
> 
Given that ARCH_MXC is y is defconfig and making these drivers as 
default y will increase the arm64 defconfig kernel size.

--srini

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/nvmem/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 283134498fbc..7e92e855eb50 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -76,6 +76,7 @@ config NVMEM_IMX_OCOTP
>   	tristate "i.MX 6/7/8 On-Chip OTP Controller support"
>   	depends on ARCH_MXC || COMPILE_TEST
>   	depends on HAS_IOMEM
> +	default y if ARCH_MXC
>   	help
>   	  This is a driver for the On-Chip OTP Controller (OCOTP) available on
>   	  i.MX6 SoCs, providing access to 4 Kbits of one-time programmable
> @@ -89,6 +90,7 @@ config NVMEM_IMX_OCOTP_ELE
>   	depends on ARCH_MXC || COMPILE_TEST
>   	depends on HAS_IOMEM
>   	depends on OF
> +	default y if ARCH_MXC
>   	help
>   	  This is a driver for the On-Chip OTP Controller (OCOTP)
>   	  available on i.MX SoCs which has ELE.
> @@ -97,6 +99,7 @@ config NVMEM_IMX_OCOTP_SCU
>   	tristate "i.MX8 SCU On-Chip OTP Controller support"
>   	depends on IMX_SCU
>   	depends on HAVE_ARM_SMCCC
> +	default y if ARCH_MXC
>   	help
>   	  This is a driver for the SCU On-Chip OTP Controller (OCOTP)
>   	  available on i.MX8 SoCs.

