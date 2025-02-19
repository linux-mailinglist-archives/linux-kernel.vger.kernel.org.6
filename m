Return-Path: <linux-kernel+bounces-522026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002CFA3C507
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA59189A76E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67921F417A;
	Wed, 19 Feb 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEfAWXqE"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0E1FE45E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982498; cv=none; b=ipTHIfcYpagJHTSpXh5N9cMSypNWDCjlrsazyx8Wl57k1DfVJ1P37kusypZQvDgncyKoSafKrAoAVodOVxhpnqBI836nQWWqiCOLMSF6Lxp3NpBRrYcpl5F6KmNx3ZvoMaP0T7v8TNJ76V+RCotTePMJty0+VHQ75XMdkA2tnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982498; c=relaxed/simple;
	bh=gIEAaQuMpvcrLQDh3vZAHZqWFqhXyhJidbzOzOnz2ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgZ5P14f3NG2orkU25h2lIj8Y2Np4Tdux6z61OpyaPvJHNVE4TGqGGaimIbCnvqRBZcQ0oEJHrXBgWZeOuFVghKaudprTzuRZUBFrPo18ZYTCou6l4DHhnGLa9mTGntcM76UJwYumILZOlI8x9tI+iSw8VeMb4HymnQy8ACn7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEfAWXqE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f3ac22948so2181656f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739982494; x=1740587294; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MRwCTxrrfvwtx9nFWmK+OK00bxF7qgqDJMInBEnLV1g=;
        b=mEfAWXqEV3E+1cLWPKyAUOvWBVSOB2FLarif4Js/WWZdVmjgkjT0Ug9JEUQEJx1o37
         mrwvMfZd9M0aR8qhgmDQK/BRN5hpgaEO3NNadpuLCpWhfXVw6mgNspdKJACjpVkByu3h
         76/ZifkX/qMa8RWErEyjBMaLlMvUqHDxix5ChdsHcwciqZKaGez5QIQG9vqPcmB06z4O
         dsm7sLFZD0XuPCd9LjvhxPr39oYiUf2vj/ULif+B01RWgLt1dzj02x4OOq8U0IbF6Mib
         N6pw+22tEfSSFKISprcvfiYpKIGwso4GXN02Uett2yUdX39j4EINhRTwGjtVDueYqTJt
         3O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982494; x=1740587294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRwCTxrrfvwtx9nFWmK+OK00bxF7qgqDJMInBEnLV1g=;
        b=d15WvE+SfERHEPs3hTiV1TjP+e87Go+YMFTLMy8DtBOQmePGy8USWo8uOG3VExs7Y1
         uyxA9cHQ8BeMCF2dM3brI+w7bAzYgYUmoORhOpcQjbUd+jmImTGmG7tIgZ5OhClvGAzD
         eusCtIAFa/Y5x9VRetDs+pPJLst/Qbp1KPZTmoI8zasB3/Ld6IVK9AP75kXMyv17zh4X
         bBj47aSIeby18VRHppCaSuIzc5Wz0i707/Xs5SBbdqt4oyFnY4EhoCydyi89v5hz/Sk3
         ebfA1Go6Ogm+RAGJ7ZrD8hD9b/B1g3Wnz+/BKPG2Aii9Ee4yBmZGaVJzWOKzBcw98Ji5
         hYow==
X-Forwarded-Encrypted: i=1; AJvYcCUixKmnFPPIxwcWWV2MRTTooohPS8p75s5H5O6aC+a1bWOUHCRNU9YUbYSq61dD3zeaCmuKSYCF/En7orM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHSF8llbp77pzY9BZc1NNk7UGlOUNH+ZiaoK18Um/Er3FCMRa
	EPZfIeZrrtsJhSf1bg0fvMVEodBO12cWAU1zf4fP7meWLvE+zrvO44SowV9+uh0=
X-Gm-Gg: ASbGnctIabZB/nMXjHq/QelcGpIU36cusmtyXxxQaNXk5sVLCiZvxUfj5b5Mnc4fd2B
	/djyf8+45tGwuIXbcDl9huytVKxmV0RcWVL0YWi0XndM1vvyPYfk8VTxLs6V/XXA3UGNaja7iwW
	0Kz+9yo51Iyv2a/+a9m/F90fd855XP1dMHxWojQmUTmVNk07weArSp9HCoD41xVnsCngBGi75lh
	CfR1XLiQX8H+MhnsCvhjG0S0yZKq4FkKPOQ6XJ/T24O0BRrLDzq5ljn8X8ULqDEGnTRDvj1WXVh
	iog1LziLsHTTQGd2qqSZ/St1FFM=
X-Google-Smtp-Source: AGHT+IH8qkvsyXpimgmtGKizvI1hdDhttqIBX8KjR41D6xYWe3cw/2Xh8D6uRRAu4ip26Fbz7QtqJw==
X-Received: by 2002:adf:f60f:0:b0:38d:dc4d:3476 with SMTP id ffacd0b85a97d-38f33f58da4mr15133466f8f.52.1739982494207;
        Wed, 19 Feb 2025 08:28:14 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:c59a:9aec:ce42:c01f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b824dsm215833715e9.34.2025.02.19.08.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:28:13 -0800 (PST)
Date: Wed, 19 Feb 2025 17:28:12 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/4] arm64: dts: qcom: x1e80100: Apply consistent
 critical thermal shutdown
Message-ID: <Z7YGnN9XwDqOpwc4@linaro.org>
References: <20250219-x1e80100-thermal-fixes-v1-0-d110e44ac3f9@linaro.org>
 <20250219-x1e80100-thermal-fixes-v1-2-d110e44ac3f9@linaro.org>
 <Z7X6jZev8fpoq0Ih@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7X6jZev8fpoq0Ih@hovoldconsulting.com>

On Wed, Feb 19, 2025 at 04:36:45PM +0100, Johan Hovold wrote:
> On Wed, Feb 19, 2025 at 12:36:19PM +0100, Stephan Gerhold wrote:
> > The firmware configures the TSENS controller with a maximum temperature of
> > 120°C. When reaching that temperature, the hardware automatically triggers
> > a reset of the entire platform. Some of the thermal zones in x1e80100.dtsi
> > use a critical trip point of 125°C. It's impossible to reach those.
> > 
> > It's preferable to shut down the system cleanly before reaching the
> > hardware trip point. Make the critical temperature trip points consistent
> > by setting all of them to 115°C and apply a consistent hysteresis.
> > The ACPI tables also specify 115°C as critical shutdown temperature.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 4e915987ff5b ("arm64: dts: qcom: x1e80100: Enable tsens and thermal zone nodes")
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> 
> > @@ -8483,7 +8483,7 @@ trip-point1 {
> >  				};
> >  
> >  				cpu-critical {
> > -					temperature = <110000>;
> > +					temperature = <115000>;
> 
> Have you asked the authors where this lower limit came from (or
> determined it was just copy pasta some other way)?
> 

I haven't asked before sending the patch, but it looks like copy-paste
from sm8550.dtsi. That one also has these weird double passive trip
points for the CPU, which are dropped for x1e80100.dtsi in the last
patch of this series. Rajendra and Abel are in the Cc though in case
they would like to comment. :-)

> >  					hysteresis = <1000>;
> >  					type = "critical";
> >  				};
> 
> > @@ -8737,7 +8737,7 @@ trip-point0 {
> >  				};
> >  
> >  				video-critical {
> > -					temperature = <125000>;
> > +					temperature = <115000>;
> >  					hysteresis = <1000>;
> >  					type = "critical";
> >  				};
> 
> Ok, make sense to backport the first patch as well then.
> 

Exactly. :D

> Looks good to me:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Thanks!
Stephan

