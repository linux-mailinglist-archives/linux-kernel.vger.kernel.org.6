Return-Path: <linux-kernel+bounces-311628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE39968B59
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27417283C52
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782C51A3023;
	Mon,  2 Sep 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO99RXgm"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE801CB533;
	Mon,  2 Sep 2024 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725292566; cv=none; b=XT/8Ps37kQw9A0EPazF2dsNBYIjPBkdJdNkm+CIhHPvEGuFlsEOuZ/pWHQHfnC1KuDj4sCLE501rGbzqCuaeI/Coc51byIyR+Pa8Hi0P8+yX/HHS4EoN8kSb2rKLTLZb02lfCBG3XZes5HA2k8rZeF87oUGbqGa3PZ9fXnNVXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725292566; c=relaxed/simple;
	bh=axhsVtSKS2mGMFqWbdshH9lnYkJ4yN60V14MfT55jTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2C1Jb3a4by1M41YsWU+O9hXbvNr0nnX7mgxRRy0iWtHh9e0q9GNMYNG30dCR6/YtORnDT4lqi1814iBZE0Ye7CkyUG8Z7XtEaARTqyEzTN4kvlVG7dVABxWSleB02T76o7gXKFBh6LmtJRDVyKFXV8kzN4ReUi0PYnfw0QA/Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO99RXgm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso1293109a12.3;
        Mon, 02 Sep 2024 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725292563; x=1725897363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uqrIFFIBuT9fXuo9sjt1fU701rtujCx6+oPYTycRxhw=;
        b=jO99RXgmTu6nXE97iVpkrwci4llHb3h+7D9PF2RJXvu+yn0a4U2p3hc493IEOiBMjq
         10GeAlJZuDhIVlCJhUIjUtp4IyIXaICibhvKrdaed/Y8xp1DsaSNYBH/BzaHZqxrcPra
         UZD8+xSTohjLTPVm1T1wvY6UyEOvA/uNWCSHcIEbAWpzQBMzPoXRE+M6A5gP0akhanW6
         AF5uNLw59eDIkWdfeoesHt961XVl+wFtc/QHFJH4HWWFmlqfrH/vV0t0zfe94ehjWwU6
         HWzvzhP2IhPq7NwdxU7z8THwrup6gOgK8FktTisGfpF71lmw5TscvTJmLxdfuGfHD8L+
         W4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725292563; x=1725897363;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqrIFFIBuT9fXuo9sjt1fU701rtujCx6+oPYTycRxhw=;
        b=Hw25x916j6sLqSsqZPfVpx+s4AvTT6itac/Hin19yIiWnhRwEQtrpUjADlRD4MzDL/
         ZAzXQoW46ZFQQVc41VGBbug+4nInEaaY7q8Ry8NokCnpfazU2ZtYajCbRMgbdLhmIO1h
         h4VltIzakia5YORV4qmv+PMApetFZFGx3Yx2ZXiObiqjwOBdQGKstQ59VF2o3WbzTC2q
         bO1YfsL8pZEAN/YPRRV1WKjMi0VzZzdBhhg8sc/kY/yFQTdW/riwCgR2DBRIGCJ3c0ax
         tbg3qY/Uc1BtKieH8pbok+T+DzYBoOO1fjOr2v6nQA7KzeFtGRRESOv0Xf5duOC056At
         SuYw==
X-Forwarded-Encrypted: i=1; AJvYcCVghshUdGWz68MaNBsUKSKedLmJ6LnvNKp/ZV71izxfX0TGULV4WsH+164KbjxTH8sPWB48eTnf9559rCQi@vger.kernel.org, AJvYcCVuInM0SYdCQadfqkshTYJ7K2gHaVx1+skAAQCtEQnbkW4JIUnY6nDFN5ILNHG30SGorRmgMiJsnpyz@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzkMpMJt/10pBOdiVLi5eAJ30StdHLVwBmfJxeZGW5fdEzhlW
	CHqsQA9bmxT16HlcOFMmRDWZfCSSRIrtlj3wHSB+8lW1R0pZpTUI
X-Google-Smtp-Source: AGHT+IGJpF9fNgWm0ITi3ee/hUoYJvUXoCSyQ2oj82pSrGszpg1RCTmEuV72xcab9PyRcmGIhRFZ5Q==
X-Received: by 2002:a05:6402:354a:b0:5c2:6314:11c4 with SMTP id 4fb4d7f45d1cf-5c263141257mr1776017a12.2.1725292562888;
        Mon, 02 Sep 2024 08:56:02 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7c3a8sm5403524a12.49.2024.09.02.08.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 08:56:01 -0700 (PDT)
Message-ID: <200d30d0-783f-4ca9-8bad-60499b65a33d@gmail.com>
Date: Mon, 2 Sep 2024 17:56:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: mediatek: mt8186: Add svs node
To: Rohit Agarwal <rohiagar@chromium.org>, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
 jitao.shi@mediatek.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240830084544.2898512-1-rohiagar@chromium.org>
 <20240830084544.2898512-4-rohiagar@chromium.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSlNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPsLBkgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyyc7BTQRd1TlIARAAm78mTny44Hwd
 IYNK4ZQH6U5pxcJtU45LLBmSr4DK/7er9chpvJ5pgzCGuI25ceNTEg5FChYcgfNMKqwCAekk
 V9Iegzi6UK448W1eOp8QeQDS6sHpLSOe8np6/zvmUvhiLokk7tZBhGz+Xs5qQmJPXcag7AMi
 fuEcf88ZSpChmUB3WflJV2DpxF3sSon5Ew2i53umXLqdRIJEw1Zs2puDJaMqwP3wIyMdrfdI
 H1ZBBJDIWV/53P52mKtYQ0Khje+/AolpKl96opi6o9VLGeqkpeqrKM2cb1bjo5Zmn4lXl6Nv
 JRH/ZT68zBtOKUtwhSlOB2bE8IDonQZCOYo2w0opiAgyfpbij8uiI7siBE6bWx2fQpsmi4Jr
 ZBmhDT6n/uYleGW0DRcZmE2UjeekPWUumN13jaVZuhThV65SnhU05chZT8vU1nATAwirMVeX
 geZGLwxhscduk3nNb5VSsV95EM/KOtilrH69ZL6Xrnw88f6xaaGPdVyUigBTWc/fcWuw1+nk
 GJDNqjfSvB7ie114R08Q28aYt8LCJRXYM1WuYloTcIhRSXUohGgHmh7usl469/Ra5CFaMhT3
 yCVciuHdZh3u+x+O1sRcOhaFW3BkxKEy+ntxw8J7ZzhgFOgi2HGkOGgM9R03A6ywc0sPwbgk
 gF7HCLirshP2U/qxWy3C8DkAEQEAAcLBdgQYAQgAIBYhBOa5khjA8sMlHCw6F9kUC7JWEwLx
 BQJd1TlIAhsMAAoJENkUC7JWEwLxtdcP/jHJ9vI8adFi1HQoWUKCQbZdZ5ZJHayFKIzU9kZE
 /FHzzzMDZYFgcCTs2kmUVyGloStXpZ0WtdCMMB31jBoQe5x9LtICHEip0irNXm80WsyPCEHU
 3wx91QkOmDJftm6T8+F3lqhlc3CwJGpoPY7AVlevzXNJfATZR0+Yh9NhON5Ww4AjsZntqQKx
 E8rrieLRd+he57ZdRKtRRNGKZOS4wetNhodjfnjhr4Z25BAssD5q+x4uaO8ofGxTjOdrSnRh
 vhzPCgmP7BKRUZA0wNvFxjboIw8rbTiOFGb1Ebrzuqrrr3WFuK4C1YAF4CyXUBL6Z1Lto//i
 44ziQUK9diAgfE/8GhXP0JlMwRUBlXNtErJgItR/XAuFwfO6BOI43P19YwEsuyQq+rubW2Wv
 rWY2Bj2dXDAKUxS4TuLUf2v/b9Rct36ljzbNxeEWt+Yq4IOY6QHnE+w4xVAkfwjT+Vup8sCp
 +zFJv9fVUpo/bjePOL4PMP1y+PYrp4PmPmRwoklBpy1ep8m8XURv46fGUHUEIsTwPWs2Q87k
 7vjYyrcyAOarX2X5pvMQvpAMADGf2Z3wrCsDdG25w2HztweUNd9QEprtJG8GNNzMOD4cQ82T
 a7eGvPWPeXauWJDLVR9jHtWT9Ot3BQgmApLxACvwvD1a69jaFKov28SPHxUCQ9Y1Y/Ct
In-Reply-To: <20240830084544.2898512-4-rohiagar@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/08/2024 10:45, Rohit Agarwal wrote:
> Add clock/irq/efuse setting in svs nodes for mt8186 SoC.
> 
> Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 85b77ec033c1..3bd023cdcac0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -1372,6 +1372,18 @@ lvts: thermal-sensor@1100b000 {
>   			#thermal-sensor-cells = <1>;
>   		};
>   
> +		svs: svs@1100bc00 {
> +			compatible = "mediatek,mt8186-svs";
> +			reg = <0 0x1100bc00 0 0x400>;
> +			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
> +			clock-names = "main";
> +			nvmem-cells = <&svs_calibration>, <&lvts_efuse_data1>;
> +			nvmem-cell-names = "svs-calibration-data", "t-calibration-data";
> +			resets = <&infracfg_ao MT8186_INFRA_PTP_CTRL_RST>;
> +			reset-names = "svs_rst";
> +		};
> +
>   		pwm0: pwm@1100e000 {
>   			compatible = "mediatek,mt8186-disp-pwm", "mediatek,mt8183-disp-pwm";
>   			reg = <0 0x1100e000 0 0x1000>;
> @@ -1695,6 +1707,10 @@ lvts_efuse_data2: lvts2-calib@2f8 {
>   				reg = <0x2f8 0x14>;
>   			};
>   
> +			svs_calibration: calib@550 {
> +				reg = <0x550 0x50>;
> +			};
> +
>   			gpu_speedbin: gpu-speedbin@59c {
>   				reg = <0x59c 0x4>;
>   				bits = <0 3>;

