Return-Path: <linux-kernel+bounces-266478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5720940075
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E1C2836A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E54618E746;
	Mon, 29 Jul 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUaDFskl"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A1187555
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288630; cv=none; b=Msax7Sm4+1bnbiVtZmOJATP0+85hFcqq6ytrWQbTAxU+9jh6lBCpADhK53ZqYoaJdLNe+yjCKUvhsoLEddoujT0+K+3aTNg9gPHf/korLg43zEYzNrcug/W02/aXU2Ipa2jhdMDd6+4hxHI3VdOjxO29DjLJcCc2/3TB3TICsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288630; c=relaxed/simple;
	bh=nkh3RY87LSj7T5WSe1L7vT9axB9xoj0Dh0BC+iFxZ1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHaLopzRLbLf3RrsFYA/P7Kid/t+ZNEXehBvsSqE8dBeNVqS8QGBLBXi6QCYKoGp5D9Nb0vaGKFPLSCX0CxEsH4kwd6rO6vi+LYZfUl2N2JwcOLM0wkEfMiDVtCUgLoDmZleahkXLxZXEyPEVEwCOIW37jH1Fcbx0bQBWOH9gw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iUaDFskl; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef2c109eabso51009541fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722288626; x=1722893426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w+XeGVGpXC/9raSm+hbwTOeiVV3/eRdhAJVqlpmquSE=;
        b=iUaDFsklFwK2/PiEXk2a4wFP+8Z0VcQ1C66GPfpSKxykbpuyIzvqCFTSdvICEbuRBj
         hacpHDLqplm2s3g3MJb3yW/ZpbeJ25cYwcEhGT2oOUG2jEm2NMGm7FrlMNmlSXpeKXjy
         3uk41R9/kcSreBW865yhiaMf9lXiZL7x42GTnGuM1w5S3wYj0yaQAy4I6GZICdt94p6e
         JjMp8020WC+8854OMo05xgm5uzg54VmOmD6RFH5ms0rt7UcmIdMLAz6bu/xv/lowfBuw
         81x3t0HIUdlD7crcLlwU7Dv8pL3dPBPqVmQcFoWlaZ/OnADnIEkFOm4sZYreoJXx25t/
         pr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722288626; x=1722893426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+XeGVGpXC/9raSm+hbwTOeiVV3/eRdhAJVqlpmquSE=;
        b=xB1byAM2LS1N+JOUNAyooWvl9W8u+AWoUIi93fiIILLxWE/5INkWe4hDecg+1DtTCK
         OqOwul64y09ANtrEpHvtutul6QPcyODCsYX2c89JEs8/z+HdOcZK+3H5Km9+rIiyRacM
         HIk0EMOG80UEUp6mantU740x8Q2XCweyNpmflYsg2wd7+EQTJKDP+kaVbfWQ2vB5QSIV
         J50eeD0u0+Z1tvAQMkvbVdIOjH2w/PWpIrC9VV7yDlXxMuSmtnMmhAVW547haihr6mUV
         NUYZVgfQPIrx9t0pAaRe+PjsiR/WLYMEHc3RvZndys+SetMj0aNhqjJoCB5lxt/etLRR
         ttkA==
X-Forwarded-Encrypted: i=1; AJvYcCUUHuou8Aun8g+NbhMr2nvYFY58CGFOpli3Z5fXhve0LlOn29uMG0Glm5YeVZTd2VODmv0JEBUYW1vksYboTZKFpiS/dxyT35Lfostu
X-Gm-Message-State: AOJu0YyvaTj1+ZCyeszTrVZCrZ4qqqL9rs786NLEZ3LeoOhCCKjhfh/e
	nL4AKEMLtKOpctwrl/cCQIizKutwwNKP82n0OiYqxRZ4t5bT4OYOcGAZxZ7LUy0=
X-Google-Smtp-Source: AGHT+IHkuA/ybS+vTEmAhWPiJMmSXwxniP06izUiJNBrRHRDIu1+0MlWYxSP7AAgk4esgMEHJO2Ehw==
X-Received: by 2002:a2e:7c01:0:b0:2ef:2c86:4d47 with SMTP id 38308e7fff4ca-2f12ecd2cb8mr59018661fa.15.1722288626513;
        Mon, 29 Jul 2024 14:30:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d09574dsm14265531fa.140.2024.07.29.14.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:30:26 -0700 (PDT)
Date: Tue, 30 Jul 2024 00:30:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	kees@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com, sudeep.holla@arm.com, 
	quic_rjendra@quicinc.com, andre.przywara@arm.com, ulf.hansson@linaro.org, 
	davidwronek@gmail.com, neil.armstrong@linaro.org, heiko.stuebner@cherry.de, 
	rafal@milecki.pl, macromorgan@hotmail.com, linus.walleij@linaro.org, 
	johan+linaro@kernel.org, javier.carrasco.cruz@gmail.com, quic_kriskura@quicinc.com, 
	lpieralisi@kernel.org, fekz115@gmail.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org, linux@mainlining.org
Subject: Re: [PATCH 08/11] arm64: dts: qcom: Add SM7325 device tree
Message-ID: <g6w2z2apwu5ng2jolpnddduqqpxp27by7e2xshqpxrzkutyuhc@gyprjccngtya>
References: <20240729201843.142918-1-danila@jiaxyga.com>
 <20240729201843.142918-9-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729201843.142918-9-danila@jiaxyga.com>

On Mon, Jul 29, 2024 at 11:18:15PM GMT, Danila Tikhonov wrote:
> From: Eugene Lepshy <fekz115@gmail.com>
> 
> The Snapdragon 778G (SM7325) / 778G+ (SM7325-AE) / 782G (SM7325-AF)
> is software-wise very similar to the Snapdragon 7c+ Gen 3 (SC7280).
> 
> It uses the Kryo670.
> 
> Signed-off-by: Eugene Lepshy <fekz115@gmail.com>
> Co-developed-by: Danila Tikhonov <danila@jiaxyga.com>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  arch/arm64/boot/dts/qcom/sm7325.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7325.dtsi
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

