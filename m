Return-Path: <linux-kernel+bounces-420690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F54B9D822A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B49281AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A49B19068E;
	Mon, 25 Nov 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVAwVPMn"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790FA18FDDB;
	Mon, 25 Nov 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526669; cv=none; b=DsGtXA0Rl0Toh/LJ4aHXyTx6R7UwRbEiDpU8gwxchBrrIxyqwVVu/Psekp/XK8L9Jb7c2E1YtTmqwHG9lM5hYNhYIepHvr/C8VPcSypN5ewSG4+qL8hTZ1uzmf0NlTv5rpDv3QYtCDomqfGhcro2K2/8o1yk3r4qdqmVrzb91Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526669; c=relaxed/simple;
	bh=dFAwG0pk25WHHBGzk3B7O450dnKjPQyykPlvZ7p/+cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u46HOUPtTcmz5NO9hW21A6aqYhC7/2fj3pQjlTyP66d/KhkWkv4sNuN//oDvNOAJFprf4zBZp8rqHoHJclqAjNXxs4YiER/lEn4mjAL/WqgcYt4TYJITsWVdrObx3LpPorOZNWH66h0PiVAgsgAU/5mIUsF6Q7B0wvoi8Jvhzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVAwVPMn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724e1742d0dso2193327b3a.0;
        Mon, 25 Nov 2024 01:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732526668; x=1733131468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GH47thgLGLAwhEyFYzkW0bapLRnqQvS6F+hSbhzlTX4=;
        b=fVAwVPMnc1VUm52eZNYvnJOeOa5E+RHYLPj+e+J2cbbH2chrIHfAHxrXMVqHpPpvUT
         /fAqDEdhlX1EuN1quTvsox4LpagqzenJ8C5nFvHCjTL2WnGPyd4Ip0R5tiXBiByCPYgm
         3vWs0FVZgNhhSDXm+w9W4ip1bOzR8vDGFuy6dcYUg7kptDIPaHqK9odF6nwK+vbwPhRB
         79kowHN62D6acHYWo2ikvLgp9m6nKTKqXDbjVJdivDdUR5W1I3pp8fD3+2H+a1JvQhAC
         edwB+aeCebH0Kvsm+6SuaW8gJr00RTs4OnDyWr8f49Q/SLBEPwm1V1Aqvm6ogfPJrJmt
         n63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526668; x=1733131468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GH47thgLGLAwhEyFYzkW0bapLRnqQvS6F+hSbhzlTX4=;
        b=OtFm59Ta+nXeepX7phxcIqAWXP3E/hPJkBQqyhrVmR8BAU53CFwB8Uj7eQje0wIpgA
         5uPY4gWxKU8mWUNGYRE4zyp17i46wUFWasTTKggtXXPPfBmRtrTJiBpnvHHtR+9qHKYL
         wgToMH3AFKCCx4LWsVLqoUKxzNS4RxDK8XMOh/I9rQ0tFqvIpXcRIs+oLzt5JOfR2D+h
         iIyQVcYXcoR44lC5cyuvCM+ZIK6UL2oTJzZd5HrDivLWfnrQ8d9fwr91I9HxaL2IHACJ
         cI1STmalm4FwHo2Kf06XjQ6iuposZu6Hr1FNaCy1HkvJfVPKay04YHDwnPxYR/W/CDo0
         IhQw==
X-Forwarded-Encrypted: i=1; AJvYcCVthfNqplpovyCoWSV+BXxtQCYbilXK75XJxBhEuokopovUF97qbelHomaed2eG6598zwwAzwbV6RVD1F+1@vger.kernel.org, AJvYcCWVq4xUivMXtoI0E3ccdZuw74Mz0Q6iuOfxORW+Q2dxQMSoe+R9wFxE+ZE+kUnw4Mxhjqps+qlHUtG8@vger.kernel.org
X-Gm-Message-State: AOJu0YxA47RiZEZRht77uwQGJQ8DekYLuQWZcCX1Nxg8/If7EyPJHgnq
	nNjK7IfHIA2ET/1PvWm9466jMASf1L9lMsH3W1bebQUuBYtRumVf
X-Gm-Gg: ASbGncsgmYS64gobbv/k2BU53WPBXiUTvBnqr70NCrRbWfpX+gyu1tX8FyDdh2VbJf+
	BFNSkseVsk+h2kYswkRjcZYK1IbSW3MVzLg6tv+LdsBNHki0V/p7yvRK2bjRi0Dh2S4Twag940f
	VHYHJVJ1TU/b2NKYx4t21Qa8ySIUrC/MnRkZOkkwPu/Zl6rU95kbjc75xdjShmk5qeIh10YCIM0
	F7mz35RzlEtcd8dS4aYP6WPZ3vOHRRlj2CidJ4NLonvq3vF88vO6QoGoFYZSMQ2VS07
X-Google-Smtp-Source: AGHT+IGH/2hu7Jr9H6sYJsbkLS36GY64EFbufco7FimN9lRF0ny00OASpXVX5qeXHk77eHloKg29MQ==
X-Received: by 2002:a05:6a00:a8f:b0:71e:410:4764 with SMTP id d2e1a72fcca58-724df5d453fmr19361348b3a.8.1732526667715;
        Mon, 25 Nov 2024 01:24:27 -0800 (PST)
Received: from [192.168.0.115] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de5762b4sm5950940b3a.179.2024.11.25.01.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 01:24:27 -0800 (PST)
Message-ID: <54759f1f-2575-4e84-b351-119cefed2b17@gmail.com>
Date: Mon, 25 Nov 2024 17:24:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] MAINTAINERS: Add entries for touchbar display driver
To: fnkl.kernel@gmail.com, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-5-3191d8e6e49a@gmail.com>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20241124-adpdrm-v1-5-3191d8e6e49a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Sasha Finkelstein via B4 Relay 於 2024/11/25 早上6:29 寫道:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> 
> Add the MAINTAINERS entries for the driver
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7f0170977013889ca7c39b17727ba36d32e92dc..1964bb705cae0b0f12e2174fc96c5cd123d31520 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2164,6 +2164,7 @@ F:	Documentation/devicetree/bindings/arm/apple.yaml
>  F:	Documentation/devicetree/bindings/arm/apple/*
>  F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
>  F:	Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> +F:	Documentation/devicetree/bindings/display/apple,display-pipe.yaml

Missing F:
Documentation/devicetree/bindings/display/panel/apple,summit.yaml
>  F:	Documentation/devicetree/bindings/dma/apple,admac.yaml
>  F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
> @@ -2183,6 +2184,7 @@ F:	drivers/bluetooth/hci_bcm4377.c
>  F:	drivers/clk/clk-apple-nco.c
>  F:	drivers/cpufreq/apple-soc-cpufreq.c
>  F:	drivers/dma/apple-admac.c
> +F:	drivers/gpu/drm/adp/
>  F:	drivers/pmdomain/apple/
>  F:	drivers/i2c/busses/i2c-pasemi-core.c
>  F:	drivers/i2c/busses/i2c-pasemi-platform.c
> 

Nick Chan

