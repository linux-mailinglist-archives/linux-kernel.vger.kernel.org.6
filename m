Return-Path: <linux-kernel+bounces-330596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E65D97A086
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511891F2449D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04214F11E;
	Mon, 16 Sep 2024 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uR6FIMBS"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF377117
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487415; cv=none; b=iWGDhMNAQII6xNWPJdyau8ZNfxlOP4a/dl8ZeAVcmhixII1qIFhXwLxYAIlmKfOckj+fdhZYxc5wV5xr9Kg9cgyx+JlwRRCMYuZK8jDMFT2QRuMDN2LPsoAp1sGNa4JflD2NdO/MKxSaLoVCqUUlN1YndtdS9Cvp1sLxbZPwx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487415; c=relaxed/simple;
	bh=BOXW3JslIblNYf9Aocmxo/2HsjFNvrnIngZouGmAp4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcbDgFhjsHi9ikQ08cXMHYyhDQuX16tvaevMyyYTUj8cjLuVkM3DfK+SuEXQG6I6vYgIsYpnQDYHgDx/onf6KBWI1IcCdqqqKffOrrfOz/m1sPXiu3mpJJjG4YNuIkU1kFyT8K2gGy7/fkWshOHkrIQ/W1r48fjbKncna4bckBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uR6FIMBS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c61ea33bso354235f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726487412; x=1727092212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6jqQbTIbzoQD4ktr4EUrmcjMIkyaxZR7eTQ2XC9c49E=;
        b=uR6FIMBSMUM8zOizAtD1ouirzzWZEZsyI5GaVoKWxP2mTtr8Nv6gVN+pHU2+wPBuRE
         ZyVSHpEx2oag+aD8QSnln2SxAGiOejo6imF82oMvGQVt9TITWM4okVBMN9XZm8oPvFPg
         p2/QgmSdYl2oM5c3U2d6ono7VL/7uT0oDIFdtTd5QKCHDk4qDuzYzFkiAYSiDL64hmLQ
         tby2g+Y8hI0Hl+85VHqgCK3K+7klPgYhk72t2gMd+81nAKGN0HwyS+UhC1T7W+PKZBSg
         KkjynXbm47OVwXlQg5U70xv8kvkT6e/b3yyAwuSd5CRN9xZe6eW5uhADKhbk6tEDjfdb
         zMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726487412; x=1727092212;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jqQbTIbzoQD4ktr4EUrmcjMIkyaxZR7eTQ2XC9c49E=;
        b=SQFBqKZ8CDIlKgNiqNgTceWNczu2NHTni29pDT8OdWFtDOfOpxlgSzqo46RYPgRsae
         o2ZndtYKI0u6Q7RL3lyD3lQ61TNf4rfI4L2raJ6ayKbXhO9YIkUug6pbsGaEXtwpwxPd
         rFULoU1P0XvuLQBNt5LVDN8CNiHvCNkB51DTDkNc9GFu9urBn5xP3fqBdm/6E195mtOo
         +9PJlGIwr0O6wOadfafcOGP2Z9tvzT8GhBhKuuq8eD/QqHPwG3ETXfVUIzJw1/l9MFVS
         hlkoBRSV+K27QXTg9pPvKtlggPtI1K350pobazGUDRn+Htw/ecWVQoUKc3jzboWw1dXL
         s/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAGeJfHeXeIXmBuoC4yr0Ikdjz1xfDW5r8ht3jfsdeXUFbmFLSkFGaaC9IrZqQnuzIi1fxx7W5Nfx9AjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uJmQUay8LlccEHjMe+/F76i1NrM78IguPI2X8Eq4yIqh7lT0
	vQS7q0VN6YXq4pOzGR3V4CUtdnKqFqGIUBIEQL0PPam4SILXwFW3Z6jRtUhIBEE=
X-Google-Smtp-Source: AGHT+IEkQU0sI/IN0zj809r4RVcOdkGvNQ/1VtMJ4DEyMBP7GoRN1NJ15+KyI16cA6yMrQLEQ3d6ow==
X-Received: by 2002:a5d:64c1:0:b0:374:c7a3:2d33 with SMTP id ffacd0b85a97d-378c2d5f549mr4424315f8f.9.1726487411380;
        Mon, 16 Sep 2024 04:50:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7805179sm7004652f8f.100.2024.09.16.04.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 04:50:10 -0700 (PDT)
Message-ID: <a3fd2c41-fd2d-40fc-8a1d-0f8e83467279@linaro.org>
Date: Mon, 16 Sep 2024 13:50:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable Ftrace and STM configs
To: Mao Jinlong <quic_jinlmao@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?B?J07DrWNvbGFzIEYgLiBSIC4gQSAuIFByYWRvJw==?=
 <nfraprado@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240910092121.20433-1-quic_jinlmao@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240910092121.20433-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/09/2024 11:21, Mao Jinlong wrote:
> Ftrace logs can be captured by STM over TMC sink path. We can enable
> ftrace logs along with HW trace of coresight component. The timestamp
> of ftrace logs and hw traces will be in sync which helps to debug.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 362df9390263..979f6eeecf2b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1588,6 +1588,12 @@ CONFIG_NVMEM_SNVS_LPGPR=y
>  CONFIG_NVMEM_SPMI_SDAM=m
>  CONFIG_NVMEM_SUNXI_SID=y
>  CONFIG_NVMEM_UNIPHIER_EFUSE=y
> +CONFIG_STM_PROTO_BASIC=m
> +CONFIG_STM_PROTO_SYS_T=m
> +CONFIG_STM_DUMMY=m
> +CONFIG_STM_SOURCE_CONSOLE=m
> +CONFIG_STM_SOURCE_HEARTBEAT=m
> +CONFIG_STM_SOURCE_FTRACE=m
>  CONFIG_FPGA=y
>  CONFIG_FPGA_MGR_ALTERA_CVP=m
>  CONFIG_FPGA_MGR_STRATIX10_SOC=m
> @@ -1703,7 +1709,6 @@ CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_FS=y
>  # CONFIG_SCHED_DEBUG is not set
>  # CONFIG_DEBUG_PREEMPT is not set
> -# CONFIG_FTRACE is not set

That's a user-visible symbol. You must select it explicitly.

Best regards,
Krzysztof


