Return-Path: <linux-kernel+bounces-436529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41279E8729
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D9E281A9D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87A818BC3F;
	Sun,  8 Dec 2024 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YwE5ETXL"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6A176240
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733680218; cv=none; b=k33hy7qSzsOzxR46o1NS52aDmMsHUGYES6xQEzZZQHlHu1EgTvXLlWfsc0u1PTTsx15Dq5QmIlr5WT4gDlJYG+4BCfuCaApvZJU0NWdW8DPb5pDu5nWLmEXl4by6ppDk9H5Ng7J07Bf0/eH0Et9ZGdxDDOevkbPqOLBkXIYCd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733680218; c=relaxed/simple;
	bh=NMYKVwOZ9ghfzC4m+4A/KuTL24A3wsDJ9KyStazQPDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPwGSW0ShnSW2j/KxDWyUSyldzHXUzk//bNJJd5XQVWmdjNSG0AFSV+sW9vkqPR6bkcQJABBMHQGQdFL+cQcuSRcH80LltY/JUvDwv3+jP91BncK4N3oceWTdOiThqHFyx6im7FyZmZqhvt2oSlAUOj/ZjBJ2P89vApkWhL/Lno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YwE5ETXL; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53f22fd6887so921053e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733680215; x=1734285015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5u+YWQpYadE0OMjiReHLCH4W+mWwJz1CAGoagd9qERs=;
        b=YwE5ETXL45dR3NiDyBkaiLAjde/o6JdC74ASIRrZBPm1RgSPgIyfbdLhnybLP5P0ze
         6GhaIVanz6olFKz0KjT9lJb/zH1IFNy/zgtF8Q82XvlltCB/IYqfwwwbyBMg/5QQZ+Rr
         V/X2nyLkybPWPD4wJdCaL2k6axem1qYEzMU9wBb3/a9NpDgfkPPUrVjp+Zsoe+CPIoQG
         8RL3EgJPbualIL+ZocEqCpOfTsOSV8YLGnKtybFQTrLCrTPhg4h073nKPFk3NyIq9lTn
         fcTdK4ZZRX1UC+PlO5xTb1rvLd8X+K6cye4mO8zu6qjJzOy7aPtPUB/h96p40g7tRp6+
         f71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733680215; x=1734285015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u+YWQpYadE0OMjiReHLCH4W+mWwJz1CAGoagd9qERs=;
        b=pBDD5TnGVco6ehCJYSldfEOkKIQ03lT0rNBfBbEfx92wZTC74T9ioHq2PnnQWOC3t0
         N9/AJhY4dFvtntn0/0xdH8nsEwYEpktrsf0xYhAv9rSGJId+r2y7zsmycTe9pqjYqih0
         KnAJnAkZHGSIR7MZ0wP4J/iMgELa/w1Ckg68v3D/L3dSnLOuixip0NXc03EToPKG26BY
         H/izZYqOeDgb3wzsJX8ZwMa588TEEItf6qN9AuEMVTG30DhEyCnIVzeaM2NoCq8zf50Q
         oxVkPfwwb/Ls3oqyptKzPtNAHZO/MCyVXJqJ3NKZvqidIo1Gnbn0O6o7+rNbP8uohPuy
         vmzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVlgL95laVSm3JauzaFsMND+5PYeJL4xyjYIE9W+IcgESura6xb84HazyLteBodFtOhJIzspHFSoQWeCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwvk/IJXwDZigJ/VLb9Iy0zcZh7mmmgGNoJQBLHX1FQKQXtfBA
	GBorcvcOdauMCEcGqer7onrCMvv6JtOGLnpQyw/Zof+1P0E5jTIKu5RAtM93YLk=
X-Gm-Gg: ASbGncvp3/e4mzAyZ/TmtQ/37294n1G50TjwMazukGF9v7bN5eec1kHWHChNUekSPk9
	oGbz9dAL+pP8p8JxkQ/SgrxDpUeLZaVEIyds9sSzSf/Yj73PW+QroaCXH/sSRGCaq8UKXFFHLPr
	d9tkO34EuKWZv1btGXYDtAKf8r427ackbhj7mFPeuQk/jp+fQxGf03dRYvFyi6d1oGXzcaBfmqo
	FxRPlbH78fpIcUR5+OYHeL45eWBSmM3jcJ2xDzQNCEPNxNTAZK3C9Gzt7n2OVHzg8vDkJKPV1L3
	6xjglgYfEXrspZIEcW/2l6qvzjaFRg==
X-Google-Smtp-Source: AGHT+IEVJLXOPnyFmKaPz9KPMKbv70YRlg73dziKIo45JVQh26G1HQVfDj7ebpdmC8hy5ZJT275q6A==
X-Received: by 2002:a05:6512:33d0:b0:53d:cfdb:c65c with SMTP id 2adb3069b0e04-53e2c504c25mr3188513e87.52.1733680214661;
        Sun, 08 Dec 2024 09:50:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3968850dsm659447e87.31.2024.12.08.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 09:50:13 -0800 (PST)
Date: Sun, 8 Dec 2024 19:50:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 01/45] drm/msm/dp: dont call
 dp_catalog_ctrl_mainlink_ctrl in dp_ctrl_configure_source_params()
Message-ID: <vemardbn3siohtg74hgjsnugkm4adqw6ekc4xhvjq3fty2rfov@5yhhsvjsnp6z>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-1-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-1-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:32PM -0800, Abhinav Kumar wrote:
> Once the link has already been setup there is no need to call
> dp_catalog_ctrl_mainlink_ctrl() as this does a reset on the mainlink
> thereby tearing down the link briefly.
> 
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

