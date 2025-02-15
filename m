Return-Path: <linux-kernel+bounces-516280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0414A36F1E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702541894ABC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36B71DF73D;
	Sat, 15 Feb 2025 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VltFOaff"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15511DDC2C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739633283; cv=none; b=YV9faDJAgh4aGuT+b37RVWYEkPiVk9ASb7K4JVGaT/6jYdDGgGwDY+IOQWTn6mRYw8VuE+26biBSRz6PKOs+K82BMOMAadUsKdq6XPCtpGbhgHckTuDC5keuTz6nk26wUoolpxXILlHF8JZ+tDO59fXLGIlRTLNsvMrIHDm7aEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739633283; c=relaxed/simple;
	bh=8VTYB10hPqOrf/u1pOI7j4P8G7PEOPP5ICNgU/q4IVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJOTre4c4bEXVLMkG0b1aPzpgYDGvahfF0d4VbljcLtucZYMeC2XadxoKD1YUgg+fGVpRLMiZKLT5AQdI8SXdaFOplm59AR8DfVNiDTdm4GDzgDKgWJ5MjoJHnl/rgUBg8A1L9POr/Wvln+3JXWPsuRYwjQsPiHHn2Vw5gqVXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VltFOaff; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54504bf07cdso3051967e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 07:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739633279; x=1740238079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AGf5rmg49p6MaNgIwMB/5odZQ50Ill9b6G6pRafnfic=;
        b=VltFOaffPDmZg/3+DKf838X7LTcmAYhHUDmL/QYgJQZaP94OAxCi+S90iVYwSoQ0r1
         Jfctnwoy/dhzYl5FkZzOcd7wcTml6ZqIJgBNp5UMSlOLn1tKE0rj1rNz+mLnaic8+bD9
         ZHd6+H8+4ODmi+KkZcFGH/PSjKkcccM4tpUCqWr3V0cx3JOnKEzvF+7hoNIUny90pWjN
         sx1Gqa/Wvf4Q3Jk/zoxVoWMpbgmHzn8AWABStZ4U6Xky2zKu1pRZ+nZQEc3H+z0PM67o
         j7tJFkXUo4wE5f2V1rZuPICR1cTAtGZOtnYxR9zngEDGpjcIHB8ew5TYI2GCHYOWuDBQ
         B+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739633279; x=1740238079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGf5rmg49p6MaNgIwMB/5odZQ50Ill9b6G6pRafnfic=;
        b=fbhH+F7pHWHMetDNTuU7zBdoK9HQHhAivzVfnFKHTeZNePPXGlES8EbH7FuiNrnmmm
         8/5BWRQJ859lE1o8fSKk+G8hX1jrb5JA9Ttbtmpk8bDbNLvxpN145ZCBz4Hp+7nfp5E3
         zEe2qe0GsQOmOufvw20zgfrW25R63TawBqmkzY/Ss1BwDVi4Ep8CNwZMjLUGAcIHFDmA
         c4EtyPEvjmynQqktbEqQfbXDpTXs+OXm1GUhkrDzAG9xeKZgKe89YXUw249hgzgr4fDL
         rW9S1//JeFszi1VdH92Am0kMico2ToGuuZrR6OHZM6QV5bIFAjGQS0psdeRe2tdFYevj
         w5Og==
X-Forwarded-Encrypted: i=1; AJvYcCWgrO5GN2Z8caY5VD4dt0iAbfyagoS4i7K3KY0r98X9rpYI96HGBOwO1Sa7MGNi7ljoGJyrJagfP2ZUW7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZHeTX+enZtD+RQNtmUYaiFUx6ItPWjTWjLwhRnC4JP1DTaxW
	fAPnWrW+mp/nHPaBX+MyDM7mDH7R2F1DHQahg8zFuYxSZ0KkmtTnFegbEQfUYFI=
X-Gm-Gg: ASbGncseB2cjQpVqW+XM4vGXpTUp6emYt0l2ZWC86OUmr2/XVXQgmHUGYNYVXcBCh7V
	/r4iG4Mrk5cfUmvEHXumI5Y78YTORALYEpD4k8zzBJVzpOUtHtdFiTyolgfAmw6EaPcipl8vRUc
	beOpD6bFXmiOGaNy7j5N5p2DVFtybkB3cq6327seymPYNQ5wC2P0IGcXoA2Si7c5mcen4s9+zme
	iVJs4BEU8J6sPoOVqdjGkE1DnGeSMtnVjdqj18fq2yb5jEoAwNLf4uVY3IZco/BgRA5quhY5sbW
	cSUQ4ncraGnqItHnqYdqPCLsZ3YW26i4gOzT3UwF2d7BEq+s5S6zLdjH2kuAg1qfsrorA7U=
X-Google-Smtp-Source: AGHT+IGM2zzla/sAtpjhHsDca+TA2fL77Ecg4EGheoA5N95v+ACAAM7LoIlZRAUhg5mZDNj9h6xYJw==
X-Received: by 2002:a05:6512:401b:b0:545:fc8:e155 with SMTP id 2adb3069b0e04-5452fe4dc30mr1064901e87.20.1739633278874;
        Sat, 15 Feb 2025 07:27:58 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5453197f3f9sm162596e87.53.2025.02.15.07.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:27:57 -0800 (PST)
Date: Sat, 15 Feb 2025 17:27:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v6 07/14] drm/msm/dpu: Reserve resources for CWB
Message-ID: <55njf2p4cg24bihrp7n4laaize7onslfgke6bwqw4jfofsaxq2@epwug3zfs2ow>
References: <20250214-concurrent-wb-v6-0-a44c293cf422@quicinc.com>
 <20250214-concurrent-wb-v6-7-a44c293cf422@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-concurrent-wb-v6-7-a44c293cf422@quicinc.com>

On Fri, Feb 14, 2025 at 04:14:30PM -0800, Jessica Zhang wrote:
> Add support for RM to reserve dedicated CWB PINGPONGs and CWB muxes
> 
> For concurrent writeback, even-indexed CWB muxes must be assigned to
> even-indexed LMs and odd-indexed CWB muxes for odd-indexed LMs. The same
> even/odd rule applies for dedicated CWB PINGPONGs.
> 
> Track the CWB muxes in the global state and add a CWB-specific helper to
> reserve the correct CWB muxes and dedicated PINGPONGs following the
> even/odd rule.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

