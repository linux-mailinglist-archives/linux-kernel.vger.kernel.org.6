Return-Path: <linux-kernel+bounces-337795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB89984F11
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE9BB214DC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6F918950C;
	Tue, 24 Sep 2024 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbHLOuqM"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354B188CD5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727221416; cv=none; b=Au8/ZsoXOywNSn0FzMBbIILfHlavFCYElcFMG2Lxs2W/T2nuYWL4dtoxA4GnDNXG5tf+oNCrEDHBgQxSU6tXt1crB/E0uHi/BsxPGD7llmpY7vXZA1lwXX6xry5pBIFhSSNqSSUc94pJxjYdc6aOXIOJqTVpnsYf3b3txqVyGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727221416; c=relaxed/simple;
	bh=wCY4lL+HUJZAjX1alFGOPiuA6ZGTGOj7gpmXEpAgBKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABWirdXTXFabte7MWB+Zu7V7bYb4jw5oI1F0me4CvPGLmr9BBaEDogScGqITWZ4/tKC4ffSRE4b3VQz69YR6kRsJsTHllSs+r0FGwhvEYUsqRhGb6LYcK8ec2gyzbX/cEAoQ0MNMP0Jgz13cFskuwL1QrkjHLuDRtJxvL0zAWvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nbHLOuqM; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f75de9a503so57197641fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727221412; x=1727826212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aaB904nJswzSJ9sroCAmof81VYvbvVS4ZH/0WuYrOVM=;
        b=nbHLOuqM2uwVhiTPz+sPnLDcbZMvYuH2GfnvgkmyM1isDNCaZArr8pZEt43EUV54F4
         Kz/+EK5QLCxkqDw3jisj/Ji2ohgy6sSMwvyNYTppDesyTD2BexGsvuE4tafpiBgl9AXu
         Tahk0iYJ7rDVqBN3AJCP2uxQfVEFfB28dsoqsPUgN628UdUK+TpkoaqXbuFk04/pOTSK
         ffjNLysFi14NhBDrSFlOpcvPJtqFXUvz28IbzDFm6AFb1ErXT2k8lKttlxQmqudN3+3U
         YxG3cEzl3fVpe3owgZMIhnojTCx0NVIF4bxFGQDlVEKGfRn9c3pEnR1IvadO10RHW4Sc
         3T3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727221412; x=1727826212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaB904nJswzSJ9sroCAmof81VYvbvVS4ZH/0WuYrOVM=;
        b=agsaenrR8KLMDOJms+KSa4vqSx47ytGcap4sHuotmZ2ME3M06IPSOK4Rk8ft+lrcNM
         WsOWvpgIn22HbPCWJK7M8Jmw3tL75f+JLAEiJhVuGdypLC3tAvEa4SA3WphNGfomvmQK
         XallO+FUGsd0hF6dM6CfU8JTOyhp18PG+r8kbvgitlqFCpxremdSMGtCplwDaMGgFgfl
         wMPV1ckIF6RIJRaIMq/MbSEG9yyLkxOeZJQyG3PFFo0M6C4CSie2u88v+CuYU75mpXQT
         foRiQolUPyXaDuALFlzjXkJVbOTFRxLvnvl10bpOCqngRwSYgUHavHaZzCib/xL/BWpy
         15Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWBTRwxM/Sst6N2d4EU5M7fZ6NX9ZwXWr6Ef9gfRasM4227VKCf8KpjJnTLlHjR+GRQ9tEJbnBawCHCsck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKgp/ykGo7vpEpeblZRQ8wrsnYCM6SB/HZcWayQvoO7EtNIpq
	iI8h43fY69XepgDcy6wK5VtwqeUk0g0wpSmyAHMWKGjwh4b2JNtz24Fp83maq4w=
X-Google-Smtp-Source: AGHT+IHJcmuOaUBwvlkEtZIKbGrA0Cs0d2P3fusjeaeBp5b7mIzG6VP9t/3bUVtxs0ZpUjKmoSc57g==
X-Received: by 2002:a2e:743:0:b0:2ef:2d3a:e70a with SMTP id 38308e7fff4ca-2f915ff4b51mr3422621fa.18.1727221411893;
        Tue, 24 Sep 2024 16:43:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d288e03fsm3521031fa.91.2024.09.24.16.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:43:30 -0700 (PDT)
Date: Wed, 25 Sep 2024 02:43:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 20/22] drm/msm/dpu: Skip trigger flush and start for
 CWB
Message-ID: <tl4flcgmup2cdbbi4uiihkij4sqr7uscdfal6sw6443uixhhz5@z6jyokawiwh2>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-20-7849f900e863@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924-concurrent-wb-v2-20-7849f900e863@quicinc.com>

On Tue, Sep 24, 2024 at 03:59:36PM GMT, Jessica Zhang wrote:
> For concurrent writeback, the real time encoder is responsible for
> trigger flush and trigger start. Return early for trigger start and
> trigger flush for the concurrent writeback encoders.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

