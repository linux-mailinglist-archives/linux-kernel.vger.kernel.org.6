Return-Path: <linux-kernel+bounces-427923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB69E0809
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900051749A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C3A13B2A8;
	Mon,  2 Dec 2024 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6vuUL/d"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3701E42AAD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154499; cv=none; b=sqkab/S3gtf+yMjefbuZETjxerTwxymh1ndLaIbOsooDA1z3PBG4S6vndnWBWEbA8yJi4CjmhyIQ0eQkhfiPaiRoWNlfsX4jaPyX394hpmPkmtQ/Q3++OSNasuT7MqHL1o/aOjcwzidcZQWGORN7Vg/rc3KscN7BwSrrRrqJkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154499; c=relaxed/simple;
	bh=uHjedfVRrZ+e3sFGTNQ46N0aIuL9DX4TX/57voliHDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFQYWBxOYskzcL0uDU1e90g+4mo28CV+DFjd5DPGVXUAymrr21suhDVJJqNZeFxaDWI898LLBxUgVm/rOR0hkYGOc+EtMuM21RLErWsFANLoWor//ypxDT/eTid3t9Ry37h83ZAWa+aiGReyhYxQVVmtpie8eqP4M6lC1PicxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F6vuUL/d; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53df67d6659so6621877e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733154496; x=1733759296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfHRG0ckbabpB5WkAOGLFC/tsNXMkX3A9rmcYDbuN4Y=;
        b=F6vuUL/dRzR82uF/XRVcmZTG8/Y4/wgxNwdZHxTWoxaPrEB/JZ5NMlnZqUdAjguM5F
         ohGJYa+nj0V6bBpWDRK8oCNmQvNxbMO0E83UPzy8W3jIm07MSd2Y2GHjjyGcrRSwmVLz
         d/GiO/N99sVuezwZ1NUljKwtaBCu+dB/SRoQyULOSEtSS4nh8JTtA6HLkZ4b6fjj3yJi
         P5qPiFNiHi22Jijmjhh7FKABnHUdk9AxF0+pSAJAbYJFv4HO3Q5/jcpssYErye59ipuK
         j5GWsnEJa9aqAy/r+N1BQ3y3Zakk2JqzN5NPScJyF/LPrwvoP1sFLYq16g9f1jIGMDFL
         xKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154496; x=1733759296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfHRG0ckbabpB5WkAOGLFC/tsNXMkX3A9rmcYDbuN4Y=;
        b=fxn9Cs8Fm0kjX8sMBVG4OpDMsvexq7W6eByAyhByI7O7hLzGEOzHPPKaWJpclA70Cb
         HeI0Da0kYgoooZsZYp263G14Rf1covMah4iEShXhBmZQxpbtKGHlFkzzwqGKah9czF3J
         xWB8qybjyxweZFour+Kjij791YqgqB9k8vT1hs46njlEsN6xLOkTRTl2Yq/ruMxQu94o
         P9HClA3kLUm6Pc2bvENdUvVbi7q8dfznyufXGfMNOhO7gc95JZHRqH4lfo8TpXwdRfUJ
         M6OvkLd9UYkr9pAAapMk//MprNCDXu2jnD+daNKN0amQ62WQO+Lu1ejuO+dTXKGONLF+
         woaw==
X-Forwarded-Encrypted: i=1; AJvYcCXwvXt5y2iUOaut/xnkWAW6QAT4CC+7Oe/APTHMG7c37MTdQUY61pgClUdi6d1u9laNXK8f99pmPT41Bb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylP9mYllNOaGgpPQI3y0/NZgZDHgJgoW1gvvXO/eZe6ouU8KEu
	u4vvub73312Km3DSaAq9bqfuXQN8InuFxw8JDR2zFeHbro8UEZSJZgmQrL1CEGU=
X-Gm-Gg: ASbGncsbmrQ+iMH4b2H8kaC7Ml4lPPv+RkmAjcjGnqmiANJhs/ZSPnbN1xg/i7hfDOC
	JLQZQq0pJhlGVZI5a59YsQ1+zkxS1xneudboHzLEGq3ph1vLSDGAwSuVxVFIvrOl2FqnK2oTczv
	WlDENGDNgicu+58UWNQaCiZEwYzfewyNoA8dAeV4YjbwlWjsSch3YppsCkuQiUzBJIttHc3mDpy
	cukJtCT26V1sArxs6xwNUw+wrBUAqPGKU52LnW6IsZEGNLt9WMkdpIZpUeZrzhFdqA4HmZslyPm
	eX3mTnGoyDMRyPwqN9osx2JS1zdtfg==
X-Google-Smtp-Source: AGHT+IG0Q5k/W3ed0OQwMlkM6qlSogEM4cPmSjYiJhbwpudSDr/7EC5mlTOxyGWNLuXKmiBWsxS+wQ==
X-Received: by 2002:a05:6512:3b0d:b0:53d:ed95:9bfa with SMTP id 2adb3069b0e04-53df00a96d2mr17148818e87.7.1733154496365;
        Mon, 02 Dec 2024 07:48:16 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649f638sm1511742e87.239.2024.12.02.07.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:48:15 -0800 (PST)
Date: Mon, 2 Dec 2024 17:48:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xiangxu Yin <quic_xiangxuy@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_lliu6@quicinc.com, quic_fangez@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/8] phy: qcom: qmp-usbc: Add DP phy mode support on
 QCS615
Message-ID: <gnrdym5o345fsbtxmfis6ykep7mzvhkxxnizlj5xplrsaaijjq@5465y2oamqoh>
References: <20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com>
 <20241129-add-displayport-support-for-qcs615-platform-v1-3-09a4338d93ef@quicinc.com>
 <b310587f-c6c3-41dd-83bf-6affbcc65730@kernel.org>
 <22600892-3b0d-4b0f-9c46-e74241960dda@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22600892-3b0d-4b0f-9c46-e74241960dda@quicinc.com>

On Mon, Dec 02, 2024 at 06:31:44PM +0800, Xiangxu Yin wrote:
> 
> 
> On 11/29/2024 4:18 PM, Krzysztof Kozlowski wrote:
> > On 29/11/2024 08:57, Xiangxu Yin wrote:
> >> +static int qmp_usbc_com_init(struct phy *phy)
> >>  {
> >>  	struct qmp_usbc *qmp = phy_get_drvdata(phy);
> >> -	const struct qmp_phy_cfg *cfg = qmp->cfg;
> >> -	void __iomem *pcs = qmp->pcs;
> >> +	int num_vregs;
> >>  	u32 val = 0;
> >>  	int ret;
> >> +	unsigned int reg_pwr_dn;
> >>  
> >> -	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
> >> +	if (qmp->type == QMP_PHY_USBC_USB) {
> > 
> > 
> > Sorry, all this code is unreviewable. Organize your changes in logical,
> > reviewable chunks.
> > 
> Will create new patch list and seperate patchsets.

Please respond to the comment regarding the single PHY vs multiple PHYs
first.

> >> +		struct qmp_phy_usb_cfg *cfg = to_usb_cfg(qmp);
> >> +
> >> +		num_vregs = cfg->num_vregs;
> >> +		reg_pwr_dn = cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL];
> >> +	} else {
> > 

-- 
With best wishes
Dmitry

