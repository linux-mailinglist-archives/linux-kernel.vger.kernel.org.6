Return-Path: <linux-kernel+bounces-552166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA0A5766C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B8B1898C21
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F88928F3;
	Sat,  8 Mar 2025 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkmBY1yi"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E59190470
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392032; cv=none; b=gxViN/yiavD4ryr4QOWbkYch6k1U+Wrgh3IJbIcXJ9KDc6g+IPQGO4hT/gKZkeiX7X11Z4E31Hcpk6xslLa4VndsS1RsNO8HcgyZymcQYWTub1w0/EVXYN4DBxCRJ7M9SqdMGifZE/m2UYIKAceK0c0peiYgWc19vDRyokX1vfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392032; c=relaxed/simple;
	bh=G24jByTcLB3gZ7lneK9yPWDVXemn8A7VmPesVcSmOBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPkKVegeS6opT89oQieeC9pAIHNds0dWG3838WxbQyAClmQFO7B9Dzd2HizVZIehpPRqEK0RTLyH1PrA4rKd4lxmVzD3vtdewXV27InIMdhfI8NIwkDIKQ36oORvK/Drr3OYsHhODCyBF0g00ZIdamOLF43TbZNekOQE8ywaOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkmBY1yi; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso11508041fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 16:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741392029; x=1741996829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEwMiLzCyICEunJ5u9SkRaghHLUa2TZbSRFS1CMQbNs=;
        b=NkmBY1yiPzJxrCbEyvTRt6E0VuRa19ATlJfgiNbWVhmE9Jo3UIr/KtQClPwI5vO4rG
         YPfZqsUq8kUPWqpBOzzIArxV9BToZ7nAvmvHu1im5SHmh9nWBIGDXQcslyjg6kI0MCDi
         yLvSYMrDwht2DfoxRsjGGDemYP6bn+zbG/L7gaI4fsaNKC/b0yQX4t55IKzaPUcLikJN
         BYZajfnba527eF/twvxEzD01z2oKFa5fpUtttxnBwnqtxAtgdpMRhLdFx4jfFwgVcAER
         31BD2AXqr5AGjnTorSBL0/NYo0M3P4qWtoHLSgjc6nSxQvvYiC3uQUYC9MTleU9ZxfhR
         YD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392029; x=1741996829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEwMiLzCyICEunJ5u9SkRaghHLUa2TZbSRFS1CMQbNs=;
        b=Gf8vTkkXrGhStmO99o4XgWTLQLFAk6fyHSnkz2YCJyzAUwHhO7Ha2vrEmrgnnKJFqX
         FwtJKwY+9IPvVstKuI+6ARatz2tUppmekCFC7YbIjwLn9UIX3ZP5gY2aiKgOTcSU/yka
         KxGNGbJApZ3EKo9qxUYvOMeZdF8pJeEuVrPHm5s25T2yLKVGSriNlQhuIfTHbdq5sNzW
         8hROmKzQd6/fAGIxRfZzzZKqcP2XO7zugZI8uC+67DPvIpTet0naepbprtiTFc0mi15G
         fDyTZ2q9M878xD4KMR0nACn0KBGjqiFIPC16UQkM1tJOOJLzanIZKY2o/1ku+U8mugM0
         ONiA==
X-Forwarded-Encrypted: i=1; AJvYcCVrUbdUTRJ/Ett1aW8Rotg7K7TW/klzxm6UCKdyflqcbK06eiqJiaH/qjFJda24FSs/whaOColVskB3MHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqnNS3qg7ZIgEoUuTg4cWQqLUMKKudfxIevkIq3sfDB7lqcYr
	OheOmxHcVQ8PCIdrLFJyS5N3U1lv/tRvqFvk/hjkqYT5JEGUkbewtcMmYBpcJwc=
X-Gm-Gg: ASbGncubukRPPEQVFPAEirqYG8Gph/49b4CVmxrnjvUYBc46sU9HEzcEbuDUcN2O1ya
	EoWAd87oQ8OTa5XMLbjPYEI6bA0Pr4QlTKDtoNimqL3lcMvpyemc9yRpAW1Y3Qw4wNrHpqzpUjy
	HK38Y2sH6UyjwpYjhDDKY5vpGltGxGyxfo0Rib48jhhBdvr3m+sjV+HsJEcouIKMHv+AN/gznb7
	WG34piupyf6nPl3gE2gDe8vAxPMJjyiL98cC+FWDeWMEtuqjvNrrZY45cLQxlHYsSPaLrNj5muI
	UiAAhIBbdeUh9DlYe4yJPVDW00sKL59SnX/+dcY0T3yhH06ZhqQHIvgwenBgZ/TsdCbF/PXbLN2
	FzRz8DtRUYtPzVL9tJ5Rr39MG
X-Google-Smtp-Source: AGHT+IHp+tbCuGTMiQOtkAJeNqJU+GLHRyHQrcNbiQ0L6CepcDGTgtUgqeherQpSU3yjAqkm/DxJgw==
X-Received: by 2002:a2e:a78a:0:b0:30b:c3ce:ea38 with SMTP id 38308e7fff4ca-30bf43b45bcmr21229201fa.0.1741392028923;
        Fri, 07 Mar 2025 16:00:28 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be99c815fsm7131741fa.69.2025.03.07.16.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 16:00:27 -0800 (PST)
Date: Sat, 8 Mar 2025 02:00:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Lyude Paul <lyude@redhat.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
	Xinwei Kong <kong.kongxinwei@hisilicon.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH RFC v3 4/7] drm/display: dp-aux-dev: use new DCPD access
 helpers
Message-ID: <ytsczbxfokt4yz26w5zl2rxtuagrirdpi6uyxnt4itcllrowuk@wqqcgkr7b52k>
References: <20250307-drm-rework-dpcd-access-v3-0-9044a3a868ee@linaro.org>
 <20250307-drm-rework-dpcd-access-v3-4-9044a3a868ee@linaro.org>
 <3284acdfa43fa62e7230355b4ed2e09ab75f326a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3284acdfa43fa62e7230355b4ed2e09ab75f326a.camel@redhat.com>

On Fri, Mar 07, 2025 at 05:53:38PM -0500, Lyude Paul wrote:
> I thought we had agreed that drm_dp_aux_dev.c was one of the few places where
> we wanted to keep using the old functions here?

Hmm, I thought I dropped it.

> 
> On Fri, 2025-03-07 at 06:34 +0200, Dmitry Baryshkov wrote:
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > Switch drm_dp_aux_dev.c to use new set of DPCD read / write helpers.
> > 
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/display/drm_dp_aux_dev.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 

-- 
With best wishes
Dmitry

