Return-Path: <linux-kernel+bounces-363015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC13499BCC3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 01:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DE12816C1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 23:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5279214AD38;
	Sun, 13 Oct 2024 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLuYY3sT"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E571304AB
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728862587; cv=none; b=XNTfEaEEF7MJC56xbJKKrGSsczrM2KvTRhLJl3FETW4lO3tXlku7dodthDRTuoo+oxb9vnZ+uxd15T+2e45mYsyH9Dqt34Ntwu0C9OlrC/C8e4F1xC+vBBTnIcJhmdo2OVjbzwIsCm9M+orHUVQNuKVV4kpyZVHsdU/8VNBB0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728862587; c=relaxed/simple;
	bh=U6mUU9ML+IfU7BfS7G5ec2FacFT+nLptq76PCY/rxWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVVZ6vWiQLAAJPXgAaoUg2W0Q36avIwfQlTFuBx0q29S5bF/jVr/QRHwmqXSrNIWdfmQj5K3XUuZLJ2AzlFYQdw2VbZr2Q1fOaYkC/MKdR8j70oX0Q5IZAgV0+m0rjT4u5BTkaoVpQTTh3tgmaUF4Bfhuy7k9Zx3T/K8NEyZp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NLuYY3sT; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so630191e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 16:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728862584; x=1729467384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtsIDsXd14fK/gP7UyoWpxQjzyKDGOWRk0Y+VS/K1j8=;
        b=NLuYY3sTGgdMxwW6j4IF3Uo2o6C/TCSvt958H4ktt0g4u6qI+Xh3pRS6pwCCu88ySP
         VSwBYJid+I/dvxzDS+jVnzZ33syjRpgs35qfvWQU8kTJ/xBZ0UNgsHS2LcQPgzkd4nyf
         jlHfYMyR8NYO80BZ3w6w2vfNy8gQ8tLveb80I/1sg9NoWmHpjOLJ6kxDd5OfV+j83LXy
         FIZgZ58ldHsEx8RB6v2oLaVwn3xR2WhT0kEwaRSSt76YMrO9JcHBfJCfjaFuc9Ge/QlM
         T4huc6s/yLdBCbOREOmbpjkKuDZhbaAYk4NJGijqKLiPHJ33IPutSKYesssKZHqxHzoa
         d73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728862584; x=1729467384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtsIDsXd14fK/gP7UyoWpxQjzyKDGOWRk0Y+VS/K1j8=;
        b=FXZc/YvB0aT+ukN77PQ2Y1ap1IUi2Br2Rxddjxl8SNIj+5oDdfER49oNBcG+k57zEt
         kBk1WY1BwGNws+tYZ8c6N0OyDjyFF774btuoBKT8JkXz4CFlZG1gGQ3OSrFX8dGb3StC
         0DjeT1TUoASwizB7qBLNXfQ72ozEXVRgRxuthefOXndC6EguZ26noed2nhYRk1bvfLf0
         oD8bDvVcSjzDIpHrOysTQxeI8Lb1wx1Rxn9ufHrVTgagN+PlQpo2uOjgsGFNMCsQxuHy
         2a7Mi/VaDSl3f4AtdjVpRPEL76sUSKz9ZqzuOGbEMoBpmZ2fngwHNfebQ3oUdO2JYkNF
         pk+g==
X-Forwarded-Encrypted: i=1; AJvYcCVSDzbC718w4h4pL902FSabPK6Ldk6nyjWhw80yflzHTY0zwrnuukZFikrVcJCGIpy/o5ZSiajAhuyfS7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/iCqSyfi21i9tDoEzMcZHvhn5YXb8fD1KW58Otlc0DV23VHq
	rka3n5R68GLveCwNPrKUAQ4zFhcVMiHDii74WxSjab1XRB/+sEckqMR/fSYh1z8=
X-Google-Smtp-Source: AGHT+IHFwXgR5icPxsw2kqPcp+dhlQDcfwPu1bgHs8JR0lE4su8aTVs0S0kQ1stHQt0GuBsK4gz6+Q==
X-Received: by 2002:a05:6512:3b9c:b0:530:aa3f:7889 with SMTP id 2adb3069b0e04-539da57f62fmr3626492e87.56.1728862584125;
        Sun, 13 Oct 2024 16:36:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539f1bb45ccsm363614e87.273.2024.10.13.16.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 16:36:22 -0700 (PDT)
Date: Mon, 14 Oct 2024 02:36:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@mainlining.org
Subject: Re: [PATCH 2/2] drm/panel: Add Samsung AMS581VF01 panel driver
Message-ID: <gdan5zalxmcvtobhizxefemfevn3qkqiflwcmfdhw3v5fwdlex@ozfpn3ejaeub>
References: <20241013212402.15624-1-danila@jiaxyga.com>
 <20241013212402.15624-3-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013212402.15624-3-danila@jiaxyga.com>

On Mon, Oct 14, 2024 at 12:24:02AM +0300, Danila Tikhonov wrote:
> Add the driver for Samsung AMS581VF01 SOFEF01-based 5.81" FHD Plus CMD
> mode OLED panel support found in Google Pixel 4a (sm7150-google-sunfish)
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-samsung-ams581vf01.c  | 283 ++++++++++++++++++
>  3 files changed, 293 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-samsung-ams581vf01.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

