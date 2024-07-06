Return-Path: <linux-kernel+bounces-243357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0957929522
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 21:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B961C20D8A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 19:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323ED13790B;
	Sat,  6 Jul 2024 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xHRX5ROp"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548AD7172F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720294742; cv=none; b=NCqibDVsMuEzsLafnWd7sLT2W7RF+3nQx5vYo+sZLPsjX7dEXtlkCVREeOx3YtdgkK/vYSr1sjsrD6AmzaA6+QolEXZLb8jZfzz8sWP0EEO29HMIaMoQ/V92c71lZl9Hw+YlJUxYuMlXCaf0ldzthkjBKdfVzOtUSBQAkBWS6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720294742; c=relaxed/simple;
	bh=OPOWJ/PnTpzgX3IqYod6tuxMqbj4Er6k4H6BmWmpzjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUaKM/lRzcdsSJiB6Vzv7miqAp+sWFEn/G8iKesZRmC8WOJR+Y5P/mZTLMeBfRtAEkbzEatuzBS9+PDstrBHRsNH76xKDgqc+oggk0fk3uIk7wz5DxnWnYiEQRYTGW/uvjYrOgmF+z5hNCmz7+3d8eBcgSgYOJx6Otaei1ubGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xHRX5ROp; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e9a550e9fso3242870e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720294737; x=1720899537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WatubwyZ/r4ukIgXZJDaq3woxYHO5AHxba4LxGQrhKM=;
        b=xHRX5ROp9GHxugUzeMmr9LoViKBs5YbVMeA3prfFFxML94dONZWrlxv9gcJksjuwdY
         eyPttGcMr7rCZX0fX7NZHs/Zsfn3YF6krGFd9b9U4CUEeTmi3/RC7HxWnBuWNQbGpqpT
         e/ugSYag+c9TWsRQ3lM6ZoDVPrYXpcN0iCXHMVEvqOiXN9FwsUXrISF1pDyft21STiTP
         ompH4vweYfsChCCS7orDeQxCiGABRX5QkuqCi7ST0FSKctHUpwTp/cN1W153CBgpfLWY
         0Os2uIBwyHQ4i4LecVvq1FoGHrWOlbb9KFHNWfMYzrcx7Z9+5d2egNJZPLglubJvtfy6
         4R7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720294737; x=1720899537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WatubwyZ/r4ukIgXZJDaq3woxYHO5AHxba4LxGQrhKM=;
        b=AjUidMDsXxAowGIRyhO8GhA2WEL886rdp2jJTDZE7b0/LWgXHFh16PdskR9WhVNWje
         lTABdX7mzcWiw3HPhNzcEz8hyXN29hoT6kCtmj3QlETRAxKV6o847XqvXpv1A13JJY2O
         CPkH9Vc2t44cZnaEu8SxOxuNJexncZXBzranknr1mlvq2tHPwV6p6TnMQRJNw6tDB9ng
         v3x2vBbySeVhbbrqMCtPewhIroRwBVGj5ITV3lVce3SVnpqzV1RT1EOFUI88/hFVI2UQ
         RwQo/ZK4cxf31VexV8WoPhlirggEtu8LSPUQOkRE5GNG0F2zuGv/bJO7INRa44XqY74o
         oDXA==
X-Forwarded-Encrypted: i=1; AJvYcCUPbSKDVway3y8Gvk67RFnJpqzlFElmTSEwiYvN48FF1HOpEnN4cFdSTHEBD4xFdIH+4N//4MgizVx7G4rZ1YSYLS/Pmh15gaQ9OZnM
X-Gm-Message-State: AOJu0Yzgm+7bgrEz2QkbAulPA5vf/OG9nofNDxAgo1JCoS8qnROwsRBZ
	htOMmJAPoe8f+Y8wXPqbYPEPm3fTecPSdMOrI+6vex2sG2tMKZqdoYzGf+IXpJU=
X-Google-Smtp-Source: AGHT+IEI75PJF0Zh9sV24P1N6y9M64LfJqDS6iL0646IwVtjJwYBfK5K3X//XTp3KQetTOwRwLOdGg==
X-Received: by 2002:a05:6512:2082:b0:52c:72b4:1b24 with SMTP id 2adb3069b0e04-52ea0de3c2emr2074775e87.12.1720294737361;
        Sat, 06 Jul 2024 12:38:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea0aaeb16sm803258e87.309.2024.07.06.12.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 12:38:56 -0700 (PDT)
Date: Sat, 6 Jul 2024 22:38:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: apq8960: correct memory base
Message-ID: <mbiqysel6o4sedqdugo3rqjcys2bjwgspsixf2g237fkw55kge@lcebbrtnrwc5>
References: <20240706193415.218940-1-david@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706193415.218940-1-david@ixit.cz>

On Sat, Jul 06, 2024 at 12:34:07PM GMT, David Heidelberg wrote:
> Bootloader will provide the information anyway to the kernel.
> 
> Ref: https://github.com/msm8916-mainline/lk2nd/blob/main/target/msm8960/rules.mk
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

