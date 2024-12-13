Return-Path: <linux-kernel+bounces-444634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4449F0A00
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF108188A414
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C671B6CF6;
	Fri, 13 Dec 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpAmN5Yd"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71C1B4F21
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086810; cv=none; b=C0IOKvf2iLrhdeQt3aabwjMWAItFs3tyklI8UX4syhn20Tt/vafa9uS5/7k3MBrhXBF/c13oPNjod3NXi1lBk3Z+6WNMUs4HSi7frce6FyzMdD/qokxdkYaB0Gi/cIPmt+48bbh2GFaUoUlKuaBVVqDoqQuhDLq+4guJwOmyX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086810; c=relaxed/simple;
	bh=u2Xn+KNbVqlfmrJ9RWE96EfrPr7hc1AnPuSXpEX4IVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBTdv2giB5tPqEQ46XvX1+tK+THL+IBaYiXabbbk5QB1tap58SaN6+MqG+xY7Xkci8f4xoZyLePEl4zfhCpOy595GX29WrxSMpISREBYybpDYesq+nVD3+n/0Q5/abI4iXFUq42CgLyfRfOmj/JSqeoCJ/+cXJl93/FdKNfFMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpAmN5Yd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5401be44b58so1673206e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734086806; x=1734691606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+riqgFIVH/DYP7alTtDkk3IJ4T8e5i4UAZc0dBAEl5E=;
        b=tpAmN5Yd4V5mOGAPnOp9YvxERb5taUpiVKfBHiJvrz71yG877diOPYkvF+IPEdb/m9
         3csxdp1Kq4P/E/IDARtGlplXI66eoVjQ4fRs7YZ+ck7x4H90RlF46gmAIZdtCFyK/ZmZ
         jom+liDICBQjoTNUzQkGvIwA6OjSJOEcwOrI3LaRPK1gecgPiJleCG6eKwjWCu9/EcPf
         +p+cPZwHHhl5FO5HmmWLHcmbdQAGwreNm+idSEeKbfbXDliDEVJHmStVmndHLn+6fXuL
         zaDMxVBk+oXblREQOfZZxbJwZvieuSREHSi1iMCoiQf8qjfaWQ33G2cgoa6t0OoRcuIe
         muVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086806; x=1734691606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+riqgFIVH/DYP7alTtDkk3IJ4T8e5i4UAZc0dBAEl5E=;
        b=HirJ3kScsZPQmr4RSTb66cVL4FvBVN/zGjQMZaIQwG5vIFH5eR4ZUPf4Qesn3vmVm9
         IPgJ08L6mb2kv71VtwSR4Zuk7+H8FMEqO3AeXmUFbNmehAowErLDhQGYcuyc2qjueMCi
         0g7poG+HVgaqC8i5yThUOEKpXbWBUmi+uyLcUI9MlYwM0jb+oKFHnjhLFPkm58kaexwc
         dM0NGSTLJzGdmeP8M4jvPVGg73SsY6h0SmCbARaIEI+SH4P2/rbZj2tqSXmT/dGsHnoZ
         MBBGFJ4jnVCZHsXGZTiUrHzscslQuj7Zh34HMW1i2LHP9WcA7c8+e32XYIc4NBIpE9El
         iGIA==
X-Forwarded-Encrypted: i=1; AJvYcCX38pg3EYt7Hv7W4MYRA47JL1+UwMhDjFAWbtNiEhTPVO2J5vU6zv13HaSWeHsqQR0HHldC5WbV17dGdAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3B4R15Qf6jTpnFkTcbrjXKUDTV43uIp8vK+RMnFatfeZCkOl
	c2mMqt2y8PF1jOXzzsJvcoYF+wMkmTiyxhwwsudrzItsEhTRA7Ac7MtR4LqX7Y8=
X-Gm-Gg: ASbGncvg2UA/TkeZ1MmOujbxr9TgrCp/HQz+1Y0qGqwWPANPhxuyZd8RBuMNxFZwEH5
	MpUdlH/ZaLAjBP9rhw0B7q+A811vcDfFjnRu5E3HgWKDUS112G+iS22Np4oMkcGjoX17IaDJs8u
	MZtJ9TkhIo4wfyjHAwAxUx5EESvgWvxeI9ESlKKRhj9gkQ7/m3Ru5aJIinrFuHVVZScZ8AKu+mV
	2Tnt6yHCP6MxXl4hXDFWgAvffuVkcmxAQ9PONEEZinVfw8xNQ0lRRLVA1k1jSUeze8c6BD7pseh
	3zbqMLUNKMu/UTIFZq2aFq3crct1XLS7+WYu
X-Google-Smtp-Source: AGHT+IEm2vjvZgyAC46ioS4Iv92mUkMOa1/KLmQj2/Q0eiaT5naaA+czP9WRIBuvwOukMwZlXd0o4w==
X-Received: by 2002:a05:6512:3189:b0:540:2fe6:6a3a with SMTP id 2adb3069b0e04-54099b72e3emr649543e87.57.1734086806386;
        Fri, 13 Dec 2024 02:46:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e369298bbsm2226481e87.13.2024.12.13.02.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:46:45 -0800 (PST)
Date: Fri, 13 Dec 2024 12:46:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xin Ji <xji@analogixsemi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bernie Liang <bliang@analogixsemi.com>, Qilin Wen <qwen@analogixsemi.com>, 
	"treapking@google.com" <treapking@google.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at
 atomic_enable()
Message-ID: <4q2jncpnmeu7ytuyuv5pjzurh3ai5663jmu2we6cebuad2r3r5@tfb6hf6unioc>
References: <20241212055110.1862487-1-xji@analogixsemi.com>
 <vkrl7om7hepboovp2uivcnernia3ygqwrj3y3kkjydeclwvrk5@7tkdc4etkcjs>
 <BY5PR04MB673977C1DB1E774CB261C119C7382@BY5PR04MB6739.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR04MB673977C1DB1E774CB261C119C7382@BY5PR04MB6739.namprd04.prod.outlook.com>

On Fri, Dec 13, 2024 at 10:06:36AM +0000, Xin Ji wrote:
> Hi Dmitry, thanks for the review, I made some changes which change ENABLE to DESIRE
> in .atomic_disable(), I'll upstream it after testing. Thanks!

- Please don't top-post.

- You still didn't explain, why do you want to do this change of HDCP
  status. Could you please provide an explanation before sending the
  next iteration?

> 
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Sent: Thursday, December 12, 2024 5:18 PM
> > To: Xin Ji <xji@analogixsemi.com>
> > Cc: Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong
> > <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org>; Laurent Pinchart
> > <Laurent.pinchart@ideasonboard.com>; Jonas Karlman <jonas@kwiboo.se>;
> > Jernej Skrabec <jernej.skrabec@gmail.com>; Maarten Lankhorst
> > <maarten.lankhorst@linux.intel.com>; Maxime Ripard <mripard@kernel.org>;
> > Thomas Zimmermann <tzimmermann@suse.de>; David Airlie
> > <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Bernie Liang
> > <bliang@analogixsemi.com>; Qilin Wen <qwen@analogixsemi.com>;
> > treapking@google.com; dri-devel@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at
> > atomic_enable()
> > 
> > CAUTION: This email originated from outside of the organization. Please do not
> > click links or open attachments unless you recognize the sender, and know the
> > content is safe.
> > 
> > 
> > On Thu, Dec 12, 2024 at 01:51:10PM +0800, Xin Ji wrote:
> > > When user enabled HDCP feature, userspace will set HDCP content to
> > > DRM_MODE_CONTENT_PROTECTION_DESIRED. Next, anx7625 will update
> > HDCP
> > > content to DRM_MODE_CONTENT_PROTECTION_ENABLED if down stream
> > support
> > > HDCP feature.
> > >
> > > However once HDCP content turn to
> > DRM_MODE_CONTENT_PROTECTION_ENABLED
> > > userspace will not update the HDCP content to
> > > DRM_MODE_CONTENT_PROTECTION_UNDESIRED until monitor disconnect.
> > 
> > It seems you've ingored a part of the previous review comment. It's the
> > userspace who triggers the ENABLED -> UNDESIRED transition, not the kernel
> > side. The change to move HDCP handling to atomic_enable() looks fine, the
> > change to disable HDCP is not (unless I misunderstand something).
> > 
> > >
> > > So, anx7625 driver move hdcp content value checking from bridge
> > > interface .atomic_check() to .atomic_enable(), then update hdcp
> > > content according from currently HDCP status. And also disabled HDCP
> > > in bridge interface .atomic_disable().
> > >
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > ---
> > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 74
> > > ++++++++++++++---------
> > >  1 file changed, 46 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > index a2675b121fe4..f96ce5665e8d 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > @@ -861,6 +861,22 @@ static int anx7625_hdcp_disable(struct anx7625_data
> > *ctx)
> > >                                TX_HDCP_CTRL0, ~HARD_AUTH_EN & 0xFF);
> > > }
> > >
> > > +static void anx7625_hdcp_disable_and_update_cp(struct anx7625_data
> > > +*ctx) {
> > > +     struct device *dev = ctx->dev;
> > > +
> > > +     if (!ctx->connector)
> > > +             return;
> > > +
> > > +     anx7625_hdcp_disable(ctx);
> > > +
> > > +     ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> > > +     drm_hdcp_update_content_protection(ctx->connector,
> > > +                                        ctx->hdcp_cp);
> > > +
> > > +     dev_dbg(dev, "update CP to UNDESIRE\n"); }
> > > +
> > >  static int anx7625_hdcp_enable(struct anx7625_data *ctx)  {
> > >       u8 bcap;
> > > @@ -2149,34 +2165,6 @@ static int anx7625_connector_atomic_check(struct
> > anx7625_data *ctx,
> > >       if (cp == ctx->hdcp_cp)
> > >               return 0;
> > >
> > > -     if (cp == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> > > -             if (ctx->dp_en) {
> > > -                     dev_dbg(dev, "enable HDCP\n");
> > > -                     anx7625_hdcp_enable(ctx);
> > > -
> > > -                     queue_delayed_work(ctx->hdcp_workqueue,
> > > -                                        &ctx->hdcp_work,
> > > -                                        msecs_to_jiffies(2000));
> > > -             }
> > > -     }
> > > -
> > > -     if (cp == DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> > > -             if (ctx->hdcp_cp != DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > -                     dev_err(dev, "current CP is not ENABLED\n");
> > > -                     return -EINVAL;
> > > -             }
> > > -             anx7625_hdcp_disable(ctx);
> > > -             ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> > > -             drm_hdcp_update_content_protection(ctx->connector,
> > > -                                                ctx->hdcp_cp);
> > > -             dev_dbg(dev, "update CP to UNDESIRE\n");
> > > -     }
> > > -
> > > -     if (cp == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > -             dev_err(dev, "Userspace illegal set to PROTECTION ENABLE\n");
> > > -             return -EINVAL;
> > > -     }
> > > -
> > >       return 0;
> > >  }
> > >
> > > @@ -2425,6 +2413,8 @@ static void anx7625_bridge_atomic_enable(struct
> > drm_bridge *bridge,
> > >       struct anx7625_data *ctx = bridge_to_anx7625(bridge);
> > >       struct device *dev = ctx->dev;
> > >       struct drm_connector *connector;
> > > +     struct drm_connector_state *conn_state;
> > > +     int cp;
> > >
> > >       dev_dbg(dev, "drm atomic enable\n");
> > >
> > > @@ -2439,6 +2429,32 @@ static void anx7625_bridge_atomic_enable(struct
> > drm_bridge *bridge,
> > >       _anx7625_hpd_polling(ctx, 5000 * 100);
> > >
> > >       anx7625_dp_start(ctx);
> > > +
> > > +     conn_state =
> > > + drm_atomic_get_new_connector_state(state->base.state, connector);
> > > +
> > > +     if (WARN_ON(!conn_state))
> > > +             return;
> > > +
> > > +     cp = conn_state->content_protection;
> > > +     if (cp == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> > > +             if (ctx->dp_en) {
> > > +                     dev_dbg(dev, "enable HDCP\n");
> > > +                     anx7625_hdcp_enable(ctx);
> > > +
> > > +                     queue_delayed_work(ctx->hdcp_workqueue,
> > > +                                        &ctx->hdcp_work,
> > > +                                        msecs_to_jiffies(2000));
> > > +             }
> > > +     }
> > > +
> > > +     if (cp == DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> > > +             if (ctx->hdcp_cp != DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > +                     dev_err(dev, "current CP is not ENABLED\n");
> > > +                     return;
> > > +             }
> > > +
> > > +             anx7625_hdcp_disable_and_update_cp(ctx);
> > > +     }
> > >  }
> > >
> > >  static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
> > > @@ -2449,6 +2465,8 @@ static void anx7625_bridge_atomic_disable(struct
> > > drm_bridge *bridge,
> > >
> > >       dev_dbg(dev, "drm atomic disable\n");
> > >
> > > +     anx7625_hdcp_disable_and_update_cp(ctx);
> > > +
> > >       ctx->connector = NULL;
> > >       anx7625_dp_stop(ctx);
> > >
> > > --
> > > 2.25.1
> > >
> > 
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

