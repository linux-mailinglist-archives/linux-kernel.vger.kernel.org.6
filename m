Return-Path: <linux-kernel+bounces-192338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B788D1BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BBC1C21D12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD70D16DECC;
	Tue, 28 May 2024 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJ9tn6zT"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F45616D9AE
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900880; cv=none; b=rfezg2OG8lPhfNblxo/XsKFSpJ+SjADUcg3AKno8NDB3zUMtEvpMSH+AVFYDduLk9nwL7WanU+JHr33DMJKJUXa6N1AMcYRtErqy3wNH+8nA9+DmiKiYvEyfMi/l1A+V2pr3TXFPLu86Ta17AXxMijhB1ea1g7MUwM3HfgfYNPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900880; c=relaxed/simple;
	bh=WHYs4O7Fu2CjoBdYG4P4R2/1sEZnwQQz0IAl+4b3tVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gn1DI30RAx+zsgyFa8N1Kw/drDp7ZEhvye6dHFr7l1GmgJIk1KZdI5hlaMamvcEyS4lk3t6IpYfK2IMo6UzX1ZGJmVR3xvfUzs/Qnns/cuIrzMhRo295HHvcCcbjNnDXrjDNfbx4o9JTZUjedt/seGX1IdeW6P1kxiLd702rLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UJ9tn6zT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-529614b8c29so1318095e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716900877; x=1717505677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSTrlh2SCKUUASbHMjU/dT8MYXK+NpaxB9pLENdcjzo=;
        b=UJ9tn6zTZtjtDDJVKJOZNoN5vJLiF6HgDNi2dXGKtoh3QBCjF+mASVELB1MTDaM9Fy
         kGgoeNJL95gXpwYTUTJvwCwTY1bebAYN+7IZHiVa5wltBwQJh6wpl2uoSVCppVpZizOk
         cmW/1GS7YJD1eQJ8C16uehKC/akUI3L+R0tMniPIIG/UhDpmP44Um1GJZosCU7CqmD/v
         +/YxlEZJRnIStyjyqACRCxuX3BjQEIMHZIfjO7NA+4YKKBaO2ssIth3nbau3Zd1pL7GW
         bFZxBoUIRuFXkYvJOSh0XWCuwQAOG16/HSVVK3EEkL1L8c5j/NcLNcsnaR8SNsLDKyZ6
         QcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716900877; x=1717505677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSTrlh2SCKUUASbHMjU/dT8MYXK+NpaxB9pLENdcjzo=;
        b=waQYqOpUZOhyuXLRB3JBwmj0WFMu2fzxBvPyzEAfnJnqvL96NTWIp8jDZMGKebnNNE
         LOif1KcWfKbSLc9pFeVx/4ksE2NTWQUERAEtE6l/ArtjEskPn7w45YlS+qqmJRAInLJL
         iVrSJ4c1hxR9MXy6GzQndVFXVmYIL6tt2hvcrdo4gCM363eXrkwf+1Xer855UQO3KaLm
         fgSuVYsyNj3MYVKTNQApEeoZHtMD/V2h/imXVaAWOFoHbZsrNysim6I/IwiNT0rQclQU
         EVygIhNc9vMjt/44BRJUr0NefQfEc95UcT8LWiivXdl05UDdGvXfILeX/kaj/4EaNgmc
         iieA==
X-Forwarded-Encrypted: i=1; AJvYcCWTYy+9SrkbBwpEY/HRZ6sVHVm5OZNNXcSWN5eSkxLz3iJUBNUSufBQZGsAodbkOFnstT/WnO3Wd0893asapwwMewQ+yGheUt1Ejq0U
X-Gm-Message-State: AOJu0YwGDclGTTV/zfQtIzjxrCrmFN4JHL6yG2yqC7piBp8GAFIDncdv
	1L8ml1sQC16vWZDO7IG4GiHB+Us54JdNm71RmOWuDGp8rLzOHpFbRMEKFIJXxew=
X-Google-Smtp-Source: AGHT+IGKzu2XIOmakywBVvQVCXPjCqQFFHQbzz7rGWhc+7VQYk4Q9VgfwbtHKoxlTZxsKpchLq1WnA==
X-Received: by 2002:a19:ad07:0:b0:524:3ce:d4ca with SMTP id 2adb3069b0e04-52966005aadmr9313303e87.37.1716900876850;
        Tue, 28 May 2024 05:54:36 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c97:23a9:35bc:df2e:d894:2c76? ([2a00:f41:c97:23a9:35bc:df2e:d894:2c76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296e8877a3sm952106e87.36.2024.05.28.05.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 05:54:35 -0700 (PDT)
Message-ID: <68593878-fd39-4961-b7c2-cc33553d6fca@linaro.org>
Date: Tue, 28 May 2024 14:54:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] arm64: dts: qcom: sc8180x-primus: Enable the two MP
 USB ports
To: Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-usb@vger.kernel.org,
 Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20240525-sc8180x-usb-mp-v1-0-60a904392438@quicinc.com>
 <20240525-sc8180x-usb-mp-v1-9-60a904392438@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240525-sc8180x-usb-mp-v1-9-60a904392438@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/25/24 20:04, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> The SC8180X Primus comes with an AUX card with two USB ports, fed by the
> two multiport ports.
> 
> Enable the involved nodes and define two always-on regulators to enable
> VBUS for these ports.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

[...]

> +		gpio = <&pmc8180_1_gpios 9 0>;

GPIO_ACTIVE_HIGH?

> +		enable-active-high;
> +
> +		regulator-always-on;
> +	};
> +
> +	vreg_usb3_host_en: regulator-usb3-host-en {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb3_host_en";
> +
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +
> +		gpio = <&pmc8180_2_gpios 9 0>;

GPIO_ACTIVE_HIGH

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

