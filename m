Return-Path: <linux-kernel+bounces-533134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC899A45603
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D902B7A67C6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331125E46F;
	Wed, 26 Feb 2025 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMFfXkKy"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6C31C84BD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552700; cv=none; b=Cjei2rXFfz7PofyRitt938cgYgXwl7vsjpB77FFHBjMxa5h21P8uDgcpFZoxb0CRe7eYaz0w8WUcbuFgEmrFJ/mDR+173EZxEcKA+u/fto6Li1afaaK/vdoR/d/YMYvUBTrPzoib8FJAYKhCIwrJct7oDDK54/bUS0bewYOxiuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552700; c=relaxed/simple;
	bh=wRs0gmeqq768Y89ArLseMA/3ZQIpZm/Jsw0n2OyBaHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqH5ro+FPuVY0M1E4/P8AlslrO9n8dQCqdgQAPqcoAr0Beh7ON4t/gY5ODMDqYWCsAH5cn6wkin9kKuwv+vK53RhwHXiWmgoNxc/+4caVUbTGqw3gyqiXq5WbANmGDFRpR4q6yaJz3O3pZKAZ0mJGqQXd4/Tr/LHumgzGjF5JuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MMFfXkKy; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so72460701fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740552697; x=1741157497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z4ngxG7wZTi1m7uV7bTzUYJzMzdYxlg992vgIRw5xa4=;
        b=MMFfXkKyR8OLoz0o6KbTikBpqbc0MmY+Df8P982/cheXSS9OiIYe41ufMt7imcfPha
         6odX5fpM3v+NXDjAqIeDGsx6BHcN8HW2Mj4pCiV+ZAvswD+5lMHRYo0R4wEXqfdycTVF
         MVSSTliNKuu3iW/cLsRqjqTfAzOnl3nMq8xnjCI/YOa8OoWF1mPVC5rchZR7T9zgil4W
         upqq7x0up8zIyKkVuU28vOabt+VCL2Z41T+ZOcY6hLvXdsAhXraqVqJBiZxwiodbnx3t
         pHeH32fF8vWzAWt8elFSU1xHprcF6iOOOnYtE1E+DP55mYPRzUZX9o1FRVJkj8x1bZCt
         5e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552697; x=1741157497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4ngxG7wZTi1m7uV7bTzUYJzMzdYxlg992vgIRw5xa4=;
        b=IPIFQToXfvsd/3L5kQ3g6ulBtDhckeC/7i/K+tjPA99ABl2mnj86Ei6rjbdp1YzOVQ
         cVKLZ7U88saiFNwqnXTRsysYB1EAx/DmhWbCnlHzyS2QaSwxM7ACX2SBVGob2CaaHzB9
         eYV1A/hN7Y1uUSHz21hyhYuyZVxS3sAqquQrcaVBYVRjuszdTooKD+yuXKlVyFPhOzPg
         v16RmqXl/rW9wQv3JsLiata+6egUS8uZQ9pA/pcv/klSCYM7W6RJqw+xQ/I4NdPrSsFG
         vzR5SWotbAhkeK6RQix5IChFFtmD46ECVPX3a2rAmpV+TEZfTl9/K6gRT21JqjEpzS6l
         kNeA==
X-Forwarded-Encrypted: i=1; AJvYcCWQz6ge4DhDfeQ5q0aeW2bEV3f91NaoFgr6m6dyLb4ww3T3YQmYlzfT65U4dcbFZM7qtweidTmpq3KkIDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwngDHLkmIuUWDEp3ZUrr8KCAyrPFXvD842neW6OqmHQRblIT3W
	iKuhAAlJMB5cBO9vrjQex35DkUiEN1cfL84nqEq3QwPpJXGL6XXHDoeb91052P0=
X-Gm-Gg: ASbGncsC5YhQXqPzMeKc7er1KJQUjVb1ymJOvCq6qsKoa4s3nkPatCx6RiXwmecJp9S
	rC6kdO/hlc1ENuYG3VLzRkTqYn9UosXemWvMo6YIJ0GFEsYh9V2TyCtbtM35NpPlqeu5QGlR9aT
	QbB6UvQDrT9xgd0gdb2CTit6GclEtMwioIB4zY7WMP0qFL7DmO4KolRYmTLYOoc55sbC0nOXQsS
	aqRzOPHERFUl35cVCW99zQSztpg5GEYlLE0BEIVG3a3glTdQ5XkCQjULtAsOpoGg8f50o3Z2GcN
	fCWmDy64Lkps0dyTK61S18kxT96Msh5f15qVcCkptkOAIgmtafQdL4YSiN+z0SpVjiAmc+/EQDh
	gWhXDuQ==
X-Google-Smtp-Source: AGHT+IHhnecMpxf3ajGCWrSv09C+5qZ2BSxCoboF22wDMvMgPA47KnQQNxvM//BmYfumNsfXt/RUKg==
X-Received: by 2002:a2e:934e:0:b0:309:24c1:73e1 with SMTP id 38308e7fff4ca-30b7915f761mr22083431fa.12.1740552696677;
        Tue, 25 Feb 2025 22:51:36 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819e0bebsm4067451fa.18.2025.02.25.22.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:51:36 -0800 (PST)
Date: Wed, 26 Feb 2025 08:51:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 7/8] drm/hisilicon/hibmc: Enable this hot plug
 detect of irq feature
Message-ID: <vrsy4hao4qu3hlcbmjyfyibeearhhjgtik3e6o3v2eyzkatdve@kdb7cyvl45tu>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-8-shiyongbang@huawei.com>
 <reqpxlbvlz5qssgy6gbjuou33h4zevo4xeztqbsr4keehplyhx@utv22a5ihohx>
 <eef68fc7-30f4-4246-a82e-4f90cd6a665d@huawei.com>
 <6jx5ldpidy2ycrqognfiv5ttqr5ia4dtbryta3kc2mkndrvvgo@qzuakucz765k>
 <6634386b-afc1-4e31-a2f4-9c1afed2d1d8@huawei.com>
 <CAA8EJpqHmhUxLE57XNeh-nVtSP7WvtBE=FiFWk9kqM_P+AC=0A@mail.gmail.com>
 <5af62fa9-e71b-412f-8640-502f03fcaa52@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5af62fa9-e71b-412f-8640-502f03fcaa52@huawei.com>

On Tue, Feb 25, 2025 at 09:57:17PM +0800, Yongbang Shi wrote:
> > On Mon, 24 Feb 2025 at 16:03, Yongbang Shi <shiyongbang@huawei.com> wrote:
> > > > On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
> > > > > > > +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
> > > > > > > +{
> > > > > > > +  struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
> > > > > > > +  struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
> > > > > > > +  struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
> > > > > > > +  int ret;
> > > > > > > +
> > > > > > > +  if (dp->hpd_status) {
> > > > > > > +          hibmc_dp_hpd_cfg(&priv->dp);
> > > > > > > +          ret = hibmc_dp_prepare(dp, mode);
> > > > > > > +          if (ret)
> > > > > > > +                  return ret;
> > > > > > > +
> > > > > > > +          hibmc_dp_display_en(dp, true);
> > > > > > > +  } else {
> > > > > > > +          hibmc_dp_display_en(dp, false);
> > > > > > > +          hibmc_dp_reset_link(&priv->dp);
> > > > > > > +  }
> > > > > > If I understand this correctly, you are using a separate drm_client to
> > > > > > enable and disable the link & display. Why is it necessary? Existing
> > > > > > drm_clients and userspace compositors use drm framework, they should be
> > > > > > able to turn the display on and off as required.
> > > > > > 
> > > > > Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
> > > > > We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
> > > > > the different video modes into DP registers.
> > > > Why? The link training and mode programming should happen during
> > > > pre_enable / enable stage (legacy or atomic).
> > > Hi Dmitry,
> > > 
> > > Right, that's what I'm curious about. It won't call encoder enble/disable functions when I triggered HPD.
> > > And I'm sure the drm_connector_helper_hpd_irq_event() is called. So I add a drm_client for it.I
> > It should be userspace, who triggers the enable/disable (or it should
> > be the in-kernel fbdev / fbcon, which interface through the generic
> > drm_fbdev client).
> 
> Right, I knew it. When I insmode my driver firstly (or restart display service), it will call disable, modeset and enable,
> by user, but it won't call when HPD triggered .

- Is HPD even properly delivered to userspace? What kind of compsitor
  are you using? Is .detect working properly and reporting a correct
  plug-in state?

-- 
With best wishes
Dmitry

