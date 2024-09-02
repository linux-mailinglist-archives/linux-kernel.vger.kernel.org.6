Return-Path: <linux-kernel+bounces-311626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F71968B54
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BC21C22068
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1E81A265C;
	Mon,  2 Sep 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A71V68La"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE481CB533;
	Mon,  2 Sep 2024 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725292461; cv=none; b=At9bQ1bN5hudFDYck87bk2d9SBz60fnF0Q327l+xs1+y7fQw7mxwbqqhUaBaCb4RVfcQcygQi+A3iA80f+31VqJFqeTKigjtYB+CENySjjBGaDOxqG6wVg+L2PFkgaF/qFm30zU68AUnQayYITMakcVzi0vmS2E9jPsh4nhG+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725292461; c=relaxed/simple;
	bh=EyzxpZaiqoJjpt6G2AcyN0MauggcldSzdz0TEoW9yvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcdH68ehGII5I7giVOqmeDxsdgWxZQhSbtiaJjK7x05EYP2e21ov24/BM8C90nBffravudACqPCbuDz9KffUNJomxvspfntAMALs9RN48k4ErdKcSvNhPh8g1yJDd8tenWzizQ7GRIjx95GmYk1X3UIOLKT0R/EZB8mz72huA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A71V68La; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a869332c2c2so856829666b.0;
        Mon, 02 Sep 2024 08:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725292458; x=1725897258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4cP2dHj6d2ZZxQr7eLgquWgY/MJjFzFp7m1ULBgCRrE=;
        b=A71V68LaM/8aaJiqB2ri5izQGurgDTKr0iNP8dnA5cVuMYjSOLx/P3A4ufBwvqMN7x
         jIvZoGk9Hiduv+l+IZ7xBlccv3J3Dww3loPvLEUa+yui4kyI5wMmCGFncPl9UFSkTbJA
         Pa3kZxQG/UpqUgI3OsYRrV8qGAIsNY67dARoYAZBp5/6WT7qrqn8xXPCtdXjUaZGqS2N
         rmA3F28RmOsOSThfD5MiU7llS8gFbYmVCXa1u60VigKZTffgUKuSybne/MmAOG8m0YjL
         pQGxd8FzUfQuAqGoSKxN0+MkK04ecngsy/3OY0L0uIlfHvMCSTt20qIQERiGYMdb0ITx
         CNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725292458; x=1725897258;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cP2dHj6d2ZZxQr7eLgquWgY/MJjFzFp7m1ULBgCRrE=;
        b=fqHMhWiXpMzF0zXN3sR2AlAgIMIBsKJCP1MCJ4wKE/ku6UjCwWTLX0QlBlllAAqOvx
         Gu3mO2lrq0eCVkjMiFZdiihfqzhe6I7xtFegUHaUoBD0JTNz1baubcSC/P1owFQGHpKp
         TrGTZSyVopgPyZQFnuDcZj5addDwFnzSIQ7TD9xyqJ92i+B3Z6rNKp+SsidPju0odV0C
         HXaNVTqXpSHhVJEDN5nXW20ZuJvKl4pbSiCLDhwHMtf17giYL3ZZfg/Tur5okhD9IL+I
         zJ1ysG+0Hs1TmgMHCf6J2GHRJLNIN21dgjdkgPIYInIiPZee1XtBExvKlBnnpWvTfhFp
         jcuA==
X-Forwarded-Encrypted: i=1; AJvYcCUTgExcUCSa43rvQ3cgd9Bo13MngKFWwkzBkb1clZK+80dH2SPeXyr2N0DheJXayxGxha5lctIxyvtf@vger.kernel.org, AJvYcCUaWA6s1VrQB76ZWwRWgapWZE0q0MWa5o+sq0nZFgKYhsTDU2D/mj6rxvrrCURApJhPn4pxz3E/njw38agE@vger.kernel.org
X-Gm-Message-State: AOJu0YxWuS+WU6DWnTeZQ7rH/EmJ8mlQX++pSJOHkI8yedos/RP9KST3
	fAh2v8a31duiD0QfB3XlH6K8L5VBhrbRNf+r38iBR+TD6A0naFC3
X-Google-Smtp-Source: AGHT+IFjeDTiTBRfvpDJVE9X0cTiZpwVlLd9lMbUR3Mi8Y4e8APmznCpbyZDjhrj6mS8oiSJ7snFvQ==
X-Received: by 2002:a17:907:805:b0:a77:d9b5:ad4b with SMTP id a640c23a62f3a-a89823c9ecbmr1476806166b.9.1725292457920;
        Mon, 02 Sep 2024 08:54:17 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6d88sm576946266b.151.2024.09.02.08.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 08:54:16 -0700 (PDT)
Message-ID: <9649e485-1f46-4dff-9dac-9bd13740e558@gmail.com>
Date: Mon, 2 Sep 2024 17:54:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] arm64: dts: mediatek: mt8186: Add power domain for
 DPI
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
 <20240830084544.2898512-3-rohiagar@chromium.org>
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
In-Reply-To: <20240830084544.2898512-3-rohiagar@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/08/2024 10:45, Rohit Agarwal wrote:
> Add power domain phandle to the DPI controller in mediatek
> mt8186 SoC.
> 
> Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index caec83f5eece..85b77ec033c1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -1843,6 +1843,7 @@ dpi: dpi@1400a000 {
>   			assigned-clocks = <&topckgen CLK_TOP_DPI>;
>   			assigned-clock-parents = <&topckgen CLK_TOP_TVDPLL_D2>;
>   			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_LOW 0>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
>   			status = "disabled";
>   
>   			port {

