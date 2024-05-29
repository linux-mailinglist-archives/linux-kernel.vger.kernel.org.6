Return-Path: <linux-kernel+bounces-194066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3508D362A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B141F254D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60F71802DD;
	Wed, 29 May 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqrt1BjS"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7663954673;
	Wed, 29 May 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985049; cv=none; b=FCurE+S57jqoFkjFVED6RVkHDoAvoWg/Xc4DfMvEdpdRBRMIXemen6b0Qul2wMvVvXBQ9ngYhUuZBkaQ2OvPhUS8RElLl/BoRn49+2To0fORwzSZbH2s5pXn5WBn4CM07PblEiqvDTs6lPOSh8Tmk0gQEVLjamghOSFiHnOVB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985049; c=relaxed/simple;
	bh=sgKwjPODxzYN3p+okRqBGRJBeVvvLIorjrEYlALuRBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cC0GGryNXISKQpJVZkmNwdQU3zhOJxv0wNnfpZgeD7ThBgfSKLn6NwjUSKm17c80HQg/2G62gWJ23kvOJMzEEmoV5lTJgHUXzQpB4eGKOV1fTxDNmnvzEhP7I8n01dal/vnn1P2YfykLtz+TRmFkHJh0A8iANLNxxy0KVeNO7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqrt1BjS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f8e98760fcso1515000b3a.1;
        Wed, 29 May 2024 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716985048; x=1717589848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+MihMHKV9dZJCXs33ES9SxmacG/nuOnOhI3+T1gT0g=;
        b=Lqrt1BjSQklyo4+bRPo9Ca27im1VmdPHp8Ml0DeVNkCXUos36viZ9fjsoJYHAxT3M3
         9V5RiJFxdrgjLTUCH6rVXtJjEvXT3LwupxBApeEdaXYr96mCRO+cRVfHWQIHHZP/oJhp
         mQ/QFT+lKULdpa1cmAsvGAMBL3qMHdrRCOgMEkXJf2FtSKylkyWbKFT9cwgVDutvc1Rt
         LVyxXF11mE/3ssK3IvtkQ4KYc0lxehiGzTYse64lvciop0p7PLhVxYR2j1YQfRjgzqvf
         4Gmf1WdbQLvdp0RkRbG6XuMiMEgmYsCiAT0lXiAGEzd6yggsaKpHW+4HlNKAmyYOX9GG
         qlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985048; x=1717589848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+MihMHKV9dZJCXs33ES9SxmacG/nuOnOhI3+T1gT0g=;
        b=s4hjJ2baLaS+OnmFQKLa90oOIJ7MOge2z5Ms+1k1m0GIZyI0fhP2/hcy52ht1ENiFN
         F8PIgLTVINOf1f4SOVsqhWLfjI9baxP3thO+dMF+ZuyG6vzVPTW9rIl44MuP7dedwBiM
         BygMmNpBSjkbDOeNakyxzLqi9zzag4DBnYJLaA6wd7rCIskb1TorwnDtEwxoMTZbNZTK
         3IjN0zmslmIskI9N/qZJj468gBERW+43u5ZSN+0hwz7s+aHX/mhw6iwpwJc4s9lPZodr
         MeD0iOMJsCARjYQdIEBjPf5J3J5bGSclSxviXziWME0K6u92sVf0rJgNiiVAI8f+JykN
         jfIA==
X-Forwarded-Encrypted: i=1; AJvYcCVzS9gG7ASGjiZ8KWL6bfMKJ+VZCNFLeCgr9V6q1HMOknBkGII6lii+x8vj0aiMCObS7JtNsCr9N/CH51LG+fJeMN2vQm8QDoyL58dr6/oePiOzlYgn8+etJ6HLVO1aqcOk1b28hxLW
X-Gm-Message-State: AOJu0Yybm73SwXZvPXeoPY5BZDxQMOT2/4H9/QgKvaclNebql0/R8YCQ
	A824ss+LBlRYD9tqOPPDd04omwnydKeGv+d/cptSoCq77HOXK7Y8
X-Google-Smtp-Source: AGHT+IEv+/g1WObNhavH5ma7i4PTgVsskCJDAVpbKkIEhJENbKuSmCBCY+k1lfCvtbdjXyNaPoSUFA==
X-Received: by 2002:a05:6a21:32a8:b0:1af:fb2c:fac9 with SMTP id adf61e73a8af0-1b212d0002emr23292426637.20.1716985047627;
        Wed, 29 May 2024 05:17:27 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-701d70c8b35sm2424065b3a.65.2024.05.29.05.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 05:17:27 -0700 (PDT)
Message-ID: <d4e4064c-e731-4721-b815-a2e30d3af513@gmail.com>
Date: Wed, 29 May 2024 20:17:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt: Update overlay file extension
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Davis <afd@ti.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <977f66b9882b6150a8da5787bf94a418aa9affec.1716976241.git.geert+renesas@glider.be>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <977f66b9882b6150a8da5787bf94a418aa9affec.1716976241.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LGTM.

On 5/29/24 6:00 PM, Geert Uytterhoeven wrote:
> Building DTB overlays from .dts files is no longer supported.
> Update the documentation to reflect this.
> 
> Fixes: 81d362732bac05f6 ("kbuild: Disallow DTB overlays to built from .dts named source files")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
> v2:
>   - Add Acked-by, Reviewed-by.
> ---
>  Documentation/devicetree/overlay-notes.rst           | 12 ++++++------
>  .../translations/zh_CN/devicetree/overlay-notes.rst  | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
> index e139f22b363e9f36..35e79242af9a928d 100644
> --- a/Documentation/devicetree/overlay-notes.rst
> +++ b/Documentation/devicetree/overlay-notes.rst
> @@ -38,10 +38,10 @@ Lets take an example where we have a foo board with the following base tree::
>  	};
>      ---- foo.dts ---------------------------------------------------------------
>  
> -The overlay bar.dts,
> +The overlay bar.dtso,
>  ::
>  
> -    ---- bar.dts - overlay target location by label ----------------------------
> +    ---- bar.dtso - overlay target location by label ---------------------------
>  	/dts-v1/;
>  	/plugin/;
>  	&ocp {
> @@ -51,7 +51,7 @@ The overlay bar.dts,
>  			... /* various properties and child nodes */
>  		};
>  	};
> -    ---- bar.dts ---------------------------------------------------------------
> +    ---- bar.dtso --------------------------------------------------------------
>  
>  when loaded (and resolved as described in [1]) should result in foo+bar.dts::
>  
> @@ -88,9 +88,9 @@ in the base DT. In this case, the target path can be provided. The target
>  location by label syntax is preferred because the overlay can be applied to
>  any base DT containing the label, no matter where the label occurs in the DT.
>  
> -The above bar.dts example modified to use target path syntax is::
> +The above bar.dtso example modified to use target path syntax is::
>  
> -    ---- bar.dts - overlay target location by explicit path --------------------
> +    ---- bar.dtso - overlay target location by explicit path -------------------
>  	/dts-v1/;
>  	/plugin/;
>  	&{/ocp} {
> @@ -100,7 +100,7 @@ The above bar.dts example modified to use target path syntax is::
>  			... /* various properties and child nodes */
>  		}
>  	};
> -    ---- bar.dts ---------------------------------------------------------------
> +    ---- bar.dtso --------------------------------------------------------------
>  
>  
>  Overlay in-kernel API
> diff --git a/Documentation/translations/zh_CN/devicetree/overlay-notes.rst b/Documentation/translations/zh_CN/devicetree/overlay-notes.rst
> index 43e3c0bc5a9f8235..ba5edd05dc1e7fd2 100644
> --- a/Documentation/translations/zh_CN/devicetree/overlay-notes.rst
> +++ b/Documentation/translations/zh_CN/devicetree/overlay-notes.rst
> @@ -43,10 +43,10 @@ Documentation/devicetree/dynamic-resolution-notes.rst[1]的配套文档。
>  	};
>      ---- foo.dts ---------------------------------------------------------------
>  
> -覆盖bar.dts,
> +覆盖bar.dtso,
>  ::
>  
> -    ---- bar.dts - 按标签覆盖目标位置 ----------------------------
> +    ---- bar.dtso - 按标签覆盖目标位置 ---------------------------
>  	/dts-v1/;
>  	/插件/;
>  	&ocp {
> @@ -56,7 +56,7 @@ Documentation/devicetree/dynamic-resolution-notes.rst[1]的配套文档。
>  			... /* 各种属性和子节点 */
>  		};
>  	};
> -    ---- bar.dts ---------------------------------------------------------------
> +    ---- bar.dtso --------------------------------------------------------------
>  
>  当加载（并按照[1]中描述的方式解决）时，应该产生foo+bar.dts::
>  
> @@ -90,9 +90,9 @@ Documentation/devicetree/dynamic-resolution-notes.rst[1]的配套文档。
>  DT中的适当位置。在这种情况下，可以提供目标路径。通过标签的目标位置的语法是比
>  较好的，因为不管标签在DT中出现在哪里，覆盖都可以被应用到任何包含标签的基础DT上。
>  
> -上面的bar.dts例子被修改为使用目标路径语法，即为::
> +上面的bar.dtso例子被修改为使用目标路径语法，即为::
>  
> -    ---- bar.dts - 通过明确的路径覆盖目标位置 --------------------
> +    ---- bar.dtso - 通过明确的路径覆盖目标位置 -------------------
>  	/dts-v1/;
>  	/插件/;
>  	&{/ocp} {
> @@ -102,7 +102,7 @@ DT中的适当位置。在这种情况下，可以提供目标路径。通过标
>  			... /* 各种外围设备和子节点 */
>  		}
>  	};
> -    ---- bar.dts ---------------------------------------------------------------
> +    ---- bar.dtso --------------------------------------------------------------
>  
>  
>  内核中关于覆盖的API

