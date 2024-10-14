Return-Path: <linux-kernel+bounces-363996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB58599C995
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EA61C2230E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95BE19E990;
	Mon, 14 Oct 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ihc7mwws"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823321684B4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907088; cv=none; b=Vp6X5r3MO2GAiFiQz6gvQGCqUD3zYXigrEXFGJxV5N6b8zvhgxGC06QmoQc+LtUSAmCGaN95NRI6T8dYYINlcL4ydbat4MnZTg1xGhcpOOHI7Gd42Ifw/JgEI/U2yHgkPc2uQuzSE8Z/X5Zk1V8+g7wYKdPoupG+eUhUzKbFpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907088; c=relaxed/simple;
	bh=nbNQQnh9Pf1Sp+nS4FFxFlGjxC/b7WX4Eecmzqer/7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8r4R6XuKsZSY+ohM1lKfZtGgZTC0g4hGQ4VVF48Qr69DOIejf4Gx8YCx7h1b4D+UOj8M6FJ307emswhgxyqAeJUC1PAENErbtV9lqWlzE9L3j8chZ5SvPthy8J/HktUsXlJBg5/uckCMggtsnnNvbqC9Wp2hesYiucoARS2mec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ihc7mwws; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1780393e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728907085; x=1729511885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDXxdgxZ7Ma3MW/R3VAkR8+WvVIPMHEYqKawEAYgO5M=;
        b=Ihc7mwwsNzztz+k+qMcbWQLMIk4R79BZWxZA2hjmX/dQEjhCgJvvnbXbHflqrowsMp
         V8jyJQrXrma1Rr8qp//FQ6ms/43GOV6bvea6/KUYdObhiEISXOXw+/RnUEXCXctPNe3i
         /SMP28VpL3MrKBoSNYdiJfcCkGCXvA1c8o1/WG5nP20QSNXXes9Dn50I7DRU+BZkjNJD
         WR7if4FQrdY22KoRTKHVxncffcXuwHaFjBsaZFv5wmZwxswlBDa+5LTaDCOYGj7mqSPc
         5ffh1CnXmoQeojrOkBsHad3hH0IX17oIq10UFAOSz7+lOcgyBPvOjE3BJAaLbkOrj4fT
         G1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728907085; x=1729511885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDXxdgxZ7Ma3MW/R3VAkR8+WvVIPMHEYqKawEAYgO5M=;
        b=SFsLyyELINIh3HIfVY4a99dpcm3c5IMjXHp3ri0nt27Qn0uEvJpbS4Hu8N2kC771jF
         qDbqnb5IysrJ+L2XwVd2kuybD8T70HQIe+BPJ/wFbjI0YL+Gd4qU9tv8Di11GQCzgz2M
         8ekO6wza3jEUErxgnoHxv2MTNQnVcjuf5SZONmpGBygqVn3Hi8vczLrb439X30LO5vGr
         d2hnpTqDcHokvc6puB2pd+gjPr/h3MJCXaDLC/vcljlyEwqtGIwWEo5UeibTq8ju2dOJ
         thYK46DWdPqKcAG0qKeLGQJMs0C/qG6E5pdcNL7UwbCdYwTfB1AuocpI6PrZ9FDQdt5a
         nnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVASfYDqJ2HU5bOWm8+Ip49RRoI85D3Aq+XsWsbwAi/IL9fA7HfLdMUuZ1toBiKYqAucosV1+2nqL+E6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKrxkf+UIT9uwYqs8TvLs5iADlFlDCKaEzeUCqPzyAO+pIoj8
	jdZVUg8i/1Y0UhZphcXeDmMNZRKlTbwJUVn2+F6Pzg91oftW57lYjO2VqWygQmU=
X-Google-Smtp-Source: AGHT+IGpKf2Jj53ywJPZ7vdG/vfbYbMz3qeVmODq89yS2wggv0OB2B9rq7/JAAy4YSsa7bjVk2K5ew==
X-Received: by 2002:a05:6512:b21:b0:539:9524:92bc with SMTP id 2adb3069b0e04-539da57b1ebmr5294838e87.55.1728907084604;
        Mon, 14 Oct 2024 04:58:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fbfe4324sm108550e87.113.2024.10.14.04.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:58:03 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:58:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 10/10] drm/bridge: it6505: add I2C functionality on AUX
Message-ID: <3s2bl6zruppjldqrjyfcn2pkrwptbwxo2rkrludczvtbnivdiw@6cy7523bmaww>
References: <20241001064550.32375-1-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001064550.32375-1-Hermes.Wu@ite.com.tw>

On Tue, Oct 01, 2024 at 02:45:50PM +0800, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> DisplayPort AUX protocol supports I2C transport which is capable of reading EDID or supports MCCS.
> 
> In drm_dp_helper, drm_dp_i2c_xfer() packs I2C requests into a sequence of AUX requests.
> it6505_aux_i2c_operation() is implemented to match drm_dp_i2c_xfer() behavior.
> it6505_aux_i2c_transfer() adds I2C functionality for  it6505_aux_transfer().
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 177 +++++++++++++++++++++++++++-
>  1 file changed, 175 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

