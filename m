Return-Path: <linux-kernel+bounces-552751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51064A57D9F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3613C7A311E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60628205E15;
	Sat,  8 Mar 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs0Pprfw"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698F1DB122;
	Sat,  8 Mar 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741460647; cv=none; b=qNMDG8bR4YUul+Pbc+cwNnC/AtZv4s7cyJfZp0XtztbatRgokaSsisImoeXCOqe+CMZlXfMCbJH3YpgREvGE5gxsqBcwVYEeE8Xybo6BrfSNd0XB3JVFYFxfaUSxpuzBzcUFxk8hjAh/ogHio3RxNz66DS50JneiReqX9QH0qlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741460647; c=relaxed/simple;
	bh=hLQRFBlo3PiBpW/PV5t75PCUgkfxdVXkjt3uDuaXM2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zv7sBcLHTf4pkoI3V7XfsVhyVopHq6esdvIfBzD0fxqv2tRQsCDDyKW9PMNrms/EqujwhEQ5cf3aYUd9i2jrLmWwhrzw1wuSzeJ5DSmIOp0XSOb+NZk9s/8LMsp0wkgkOqiSOlyiZfK+YpVuCUKiK+INFXCLJl/VJ+YtFhUYVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs0Pprfw; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso14698331fa.3;
        Sat, 08 Mar 2025 11:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741460644; x=1742065444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTVbXxjWlsf93+TNBRlPrQnC9sQtCvCemMI+xBM+RLA=;
        b=gs0PprfwHwLOYeBY5LdOMnj0FBBxwVKznWpgHfqpcKqy/woloSSMnvpHGxjSYNtNEx
         XOSev05zu71UJTM88m8YzEywjtx+e+ilKVQ3OmzXR5Vr9EIWF2T9pnkRvk8c5H5+OOM5
         mawJIJS1pFGenRzs5PnLGtPf2M2fnurEdZm7DYXmz7VFRDzZEghyDk3hEUTT6jw9ho8+
         zv/WM07ZYCVJLWzEz8v5Ecbsvy70IOPAXyTnCEdvjkB2xrC5BluR4Av+6heYkDvc08FU
         Rj/ZAnQTH5X+527+GvuaOGdX3baOESjfEPAvl876NnEWiwNT05AASV/bjBs0Hzv2FMEo
         UqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741460644; x=1742065444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTVbXxjWlsf93+TNBRlPrQnC9sQtCvCemMI+xBM+RLA=;
        b=p7jSso7baoAcujIoPrrcWCiDaIl0FIw/HGWhWwmKCkZ8wIzHGEXFc9enuB1qH4LvH2
         7l4wuyB0M0Y2kuM12KVlV+VjZXUEEF30TTCDnuH+TiMCz9sF00jNlRkZUdDad8fWMw6Q
         TtbDaJQ4WH/aAQlNsOjWeUW1cUJ3HWYRdjPhjOwnErItYcUqbl+PgwZ2nZ+FmHNf6VaR
         IKhrXiWfiiY+XjuJA2vvUg/QI6vYL88dPGjKXfokgbUa70ail55LxHI5Hli6NR4XtwkY
         2fAJcSzr9wh5ITSysD9W3HjDvHraTkx0OC0Fg2gyg9XtUjsfCtKawONbbvI8GH8791dM
         MA1A==
X-Forwarded-Encrypted: i=1; AJvYcCVvYzOPQaCifv9DrBGP+kdFnY32vCoEwWZzwYOCnnJrW8F9q6bMpp1R7eVxfLdLBS7MVaV/mK9RFAI2Y3qs@vger.kernel.org, AJvYcCXJ4Ej7GSg53hh7ggFbVTONtvI5NJcBwTMAgGLY9Ki7I6StPosiVdv9UKafRlLDiOvKYQ07B/khkPfM@vger.kernel.org
X-Gm-Message-State: AOJu0YxJl8kuARMxxtdQnyt/ktLGBLmN1KjVUTpNypK62dFBBhFEWP7R
	PQzfrzPchte9qHXZSuVqXa7Pmyn8NZD0SDsP1m2w7y9V2/062r03
X-Gm-Gg: ASbGncuhEJptwob/qBfsNGd9OmkGhxaWmfPzIzrIwhG3bbVGIfhJHDsU9/AER4gmY9C
	MMCYM3s5gj5pDi+cX8lQ+5NQhhpyOZ37VHf3PAXla6IDo/1BUzKZDerEohY14flc5JDOyGjSDkS
	ASdfZPqKHUEWms9Ik9glt+7Gf4dVE1C7rIV9Od93N11QKGiMdo6OTVpBRyoata6/15XSk7l+VKG
	mIck4Lk9IPA8FM1fsWMm9duZyLxuZhgB22VWJ7p7i9GcDHvzFF3qDT+kjTvS8mnULwueimp/mWx
	TnkBpKGCyj/swLIu8dY9p9ta/icJv4i8zHJIEHYMXmlR1Zj/nC9anz6w1lw=
X-Google-Smtp-Source: AGHT+IHONdtOGFlS7xPC7CsMoQUtrhTnztXQBlowSZtaB1Dgbc0GCjes4fUV0lQgJ2cvnPRqYxqQbg==
X-Received: by 2002:a05:6512:a93:b0:545:2fa9:8cf5 with SMTP id 2adb3069b0e04-549910b7c6fmr3484311e87.49.1741460643774;
        Sat, 08 Mar 2025 11:04:03 -0800 (PST)
Received: from [192.168.3.116] ([78.56.129.233])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c3adcsm883370e87.249.2025.03.08.11.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 11:04:02 -0800 (PST)
Message-ID: <5bb045fe-89c3-46dd-bd9a-dee8800a6d58@gmail.com>
Date: Sat, 8 Mar 2025 21:03:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Xunlong Orange Pi 3B
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240626230319.1425316-1-jonas@kwiboo.se>
 <20240626230319.1425316-3-jonas@kwiboo.se>
 <d1c600f1-a874-4bb8-8b9f-22a3414edfcc@gmail.com>
 <29739e60-15f5-4361-a57a-2e6b93fba09c@kwiboo.se>
Content-Language: en-US
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
In-Reply-To: <29739e60-15f5-4361-a57a-2e6b93fba09c@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/8/25 6:34 PM, Jonas Karlman wrote:
> This is because of a reset issue with Ethernet PHYs in Linux, see [1].
>
> Two workarounds:
> 1. Let boot firmware reset the PHY before Linux, i.e. use U-Boot
>     v2024.10 or newer.
> 2. Use a ethernet-phy-id compatible with correct phy-id to force Linux
>     to attach the PHY.
>
> I suggest you try to wipe U-Boot from SPI flash on your board and update
> to use U-Boot v2025.01 and try again.
Wiping board SPI flash which contained old U-boot and using 2025.01 from 
SD card fixed issue hence DTS is OK.
Though I do not remember that I ever wrote anything into SPI flash in 
first place (I touched board almost year ago so potentially forgot about 
it) maybe it was shipped like that with the board...

Arturas Moskvinas

