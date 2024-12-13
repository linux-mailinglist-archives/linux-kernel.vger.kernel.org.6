Return-Path: <linux-kernel+bounces-444831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7C89F0D25
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDB0283BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD411DFE2C;
	Fri, 13 Dec 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOp4OVdw"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE091DFE2F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095820; cv=none; b=Yq2iF+FhmqUz36A0EKnIcgXFktR+FJU6oJbDm8FnaEYaD4jKa10JUDorMmiCfGJtbcTkCTOoqwuDH5k3QluvzK7FKwo7yIqvjWeK11dJdJ6BuN4DtWlqrzIzkVN1qu+9qFMbSND5p+3KgUMTiLdGIYvOQeLdSdOigUBb1WbaLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095820; c=relaxed/simple;
	bh=P8pW92DnyfoaK8XMmD9iA2KO4W0XcTkGVV6WwyDzmfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vp2Hwyeut8DaS784y3d5KAswEsW+j+h5mi4K4Q7hNXg9Mg7jyffi7kWkdZw01DnUWfDt2WPOGL80mli6e78LnmicU1Ona+PbuI1voSkD0EwQFVX3frphvJGL+4Iz3d9iZMpHwgDOhkvMKPjCvRczDofh4Dp68/LDTHIEI+bVXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UOp4OVdw; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso1261429276.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734095817; x=1734700617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RVcPpLOsWmE+ba7pF6UhID0o+wua7JbONLDV04eLt58=;
        b=UOp4OVdwIJGyf+NP9PMqF64NciEKNqpjsi7cGPnslhdv6NX6SF5zhBEnaMNG6Yujoe
         ujkRV+2r8i0w3UEuEQwQqy3E9H6ldRjCd23MTK6iFy93u9lr+TFCB441fDHiGoyK1UYz
         6dcstwRNts5p4SoBMp44am2+CDUaLZm6/2BD1jaGO5b2RPz8axZXBQAlL1y8Kj7hb9rX
         FmnhAKGCEpgHwtuXVWPh7iOzN3idmfhrPhxeDwb8EpgzuEVtyyU9KvAWswRKh2kGMT1b
         rDYBAy111oC+DoFoxCgej+oyKc99jqQD18SCT6Of6Dd4/JncvoMyA/rY+uCzBHekLDmh
         Idqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095817; x=1734700617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVcPpLOsWmE+ba7pF6UhID0o+wua7JbONLDV04eLt58=;
        b=vTfP8ySntSIfw44ABlJc4vSAyos48y03nHkQ8gyH169MGXAtngXFRzTXzjQM4CNBQP
         qAYeuE5A94FrZfW212V6VgSbyw+e5ZAUOH6ZGUjI51j1pTo+IKIaj/l65ghSYY/GJ4T6
         26RdhN8uo0XJ5AUP00F09Lm9zoc34d+3tOOR3KI//fKpfhYsjx70ivmrq5V91wV3jEYK
         mg2WXOPcTDGLDxP0TtdqcxwWr2vaAzB6/IsC8D0pHc0jg6rHq9URuvdDn0CtcYVOFIhz
         p08O60SfB10RL3xf+15ry2qIwikBrEWS3cJnRSHq/uStvAdkPpwYzxIYbE4hWAOFL5di
         qaqg==
X-Forwarded-Encrypted: i=1; AJvYcCUqAatIyJqYarSoKYq2rrXnrjVzTFQgEUNrVLqdLQFde8ByZ5RyS4dbHgypH2Ol063a+n/oyR+Um8DELw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywLKFxTLDb85B8xcq/gRib/mgOvEMGcI+98JGoHpQ11sz6mU0U
	Vnhgu/KGaFtzH2JkmoFI4HQh7divR3ty15+DiECKZ4lRLRid6ViL/X/33Zm6JwJN1MJfycBc4bv
	3Xjjb1EZhpS7/fCMxWgKP4u087/fjJbl2N4bAt8ftqTGrJqkt9qLmMQ==
X-Gm-Gg: ASbGncsQwjEl0Tuxmo3Kyq01cYAu/mmXNDz5BKA0p5u8ktAEKI2MICfzXD6MBq1JMwy
	FwHcTCa25XvHV49JLW8N981BkIskeBXMjSq3T
X-Google-Smtp-Source: AGHT+IGAl2LYP8iV2Q3Sc2IL4UxpP1EGC86H9SzT6Tzp3ChldYwdh60ZW5iAxqwg8uWrnFB2To757YfeZZkWJFcOoO8=
X-Received: by 2002:a05:6902:2213:b0:e3d:22a7:b969 with SMTP id
 3f1490d57ef6-e434d199da4mr2201350276.5.1734095815817; Fri, 13 Dec 2024
 05:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212055110.1862487-1-xji@analogixsemi.com>
 <vkrl7om7hepboovp2uivcnernia3ygqwrj3y3kkjydeclwvrk5@7tkdc4etkcjs>
 <BY5PR04MB673977C1DB1E774CB261C119C7382@BY5PR04MB6739.namprd04.prod.outlook.com>
 <4q2jncpnmeu7ytuyuv5pjzurh3ai5663jmu2we6cebuad2r3r5@tfb6hf6unioc> <BY5PR04MB673902E047FF8ADAFD8B94B3C7382@BY5PR04MB6739.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB673902E047FF8ADAFD8B94B3C7382@BY5PR04MB6739.namprd04.prod.outlook.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 13 Dec 2024 15:16:44 +0200
Message-ID: <CAA8EJprGjuGFjZnXUxiMZMV=FO9O9CYt06H_nSL82fEOvPytyA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at atomic_enable()
To: Xin Ji <xji@analogixsemi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bernie Liang <bliang@analogixsemi.com>, Qilin Wen <qwen@analogixsemi.com>, 
	"treapking@google.com" <treapking@google.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Dec 2024 at 13:00, Xin Ji <xji@analogixsemi.com> wrote:
>
> Hi Dmitry, sorry, I didn't clear describe the reason.

Please. Do not top-post. Please paste your answer under the question,
not somewhere at the top of the email. This allows us to have a more
constructive dialog. Additional bonus if you can fix your email client
to insert sensible quoting information instead of dumping the headers
of the original email.

>
> Anx7625 implement DSI to DP convert behind USB Type-C port, when user plug into USB Type-C
> Dongle with DP monitor, the user space will enable HDCP feature, then kernel do HDCP and
> output display and set HDCP content to ENABLE, but the issue happened if user manually
> change the monitor's resolution later.
>
> Each time user change the resolution, kernel will call bridge interface .atomic_disable() and
> .atomic_enable(), the old driver will keep HDCP state to ENABLE, this is a BUG, when user
> change the resolution, kernel must change HDCP content too (mustn't keep to ENABLE),

Why? Could you please point me to the corresponding documentation or a
code path in the other driver? Preferably i915, AMD or Nouveau.

> as DRM doc said, kernel cannot change from ENABLE to UNDESIRE, so next patch,
> I'll change it to DESIRE in .atomic_disable().
>
> Thanks!
> Xin
>
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Sent: Friday, December 13, 2024 6:47 PM
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
> > On Fri, Dec 13, 2024 at 10:06:36AM +0000, Xin Ji wrote:
> > > Hi Dmitry, thanks for the review, I made some changes which change
> > > ENABLE to DESIRE in .atomic_disable(), I'll upstream it after testing. Thanks!
> >
> > - Please don't top-post.
> >
> > - You still didn't explain, why do you want to do this change of HDCP
> >   status. Could you please provide an explanation before sending the
> >   next iteration?
> >
> > >
> > > > -----Original Message-----
> > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Sent: Thursday, December 12, 2024 5:18 PM
> > > > To: Xin Ji <xji@analogixsemi.com>
> > > > Cc: Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong
> > > > <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org>; Laurent
> > > > Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas Karlman
> > > > <jonas@kwiboo.se>; Jernej Skrabec <jernej.skrabec@gmail.com>;
> > > > Maarten Lankhorst <maarten.lankhorst@linux.intel.com>; Maxime Ripard
> > > > <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>;
> > David
> > > > Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Bernie
> > > > Liang <bliang@analogixsemi.com>; Qilin Wen <qwen@analogixsemi.com>;
> > > > treapking@google.com; dri-devel@lists.freedesktop.org; linux-
> > > > kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at
> > > > atomic_enable()
> > > >
> > > > CAUTION: This email originated from outside of the organization.
> > > > Please do not click links or open attachments unless you recognize
> > > > the sender, and know the content is safe.
> > > >
> > > >
> > > > On Thu, Dec 12, 2024 at 01:51:10PM +0800, Xin Ji wrote:
> > > > > When user enabled HDCP feature, userspace will set HDCP content to
> > > > > DRM_MODE_CONTENT_PROTECTION_DESIRED. Next, anx7625 will
> > update
> > > > HDCP
> > > > > content to DRM_MODE_CONTENT_PROTECTION_ENABLED if down
> > stream
> > > > support
> > > > > HDCP feature.
> > > > >
> > > > > However once HDCP content turn to
> > > > DRM_MODE_CONTENT_PROTECTION_ENABLED
> > > > > userspace will not update the HDCP content to
> > > > > DRM_MODE_CONTENT_PROTECTION_UNDESIRED until monitor
> > disconnect.
> > > >
> > > > It seems you've ingored a part of the previous review comment. It's
> > > > the userspace who triggers the ENABLED -> UNDESIRED transition, not
> > > > the kernel side. The change to move HDCP handling to atomic_enable()
> > > > looks fine, the change to disable HDCP is not (unless I misunderstand
> > something).
> > > >
> > > > >
> > > > > So, anx7625 driver move hdcp content value checking from bridge
> > > > > interface .atomic_check() to .atomic_enable(), then update hdcp
> > > > > content according from currently HDCP status. And also disabled
> > > > > HDCP in bridge interface .atomic_disable().
> > > > >
> > > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > > ---
> > > > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 74
> > > > > ++++++++++++++---------
> > > > >  1 file changed, 46 insertions(+), 28 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > index a2675b121fe4..f96ce5665e8d 100644
> > > > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > @@ -861,6 +861,22 @@ static int anx7625_hdcp_disable(struct
> > > > > anx7625_data
> > > > *ctx)
> > > > >                                TX_HDCP_CTRL0, ~HARD_AUTH_EN &
> > > > > 0xFF); }
> > > > >
> > > > > +static void anx7625_hdcp_disable_and_update_cp(struct
> > > > > +anx7625_data
> > > > > +*ctx) {
> > > > > +     struct device *dev = ctx->dev;
> > > > > +
> > > > > +     if (!ctx->connector)
> > > > > +             return;
> > > > > +
> > > > > +     anx7625_hdcp_disable(ctx);
> > > > > +
> > > > > +     ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> > > > > +     drm_hdcp_update_content_protection(ctx->connector,
> > > > > +                                        ctx->hdcp_cp);
> > > > > +
> > > > > +     dev_dbg(dev, "update CP to UNDESIRE\n"); }
> > > > > +
> > > > >  static int anx7625_hdcp_enable(struct anx7625_data *ctx)  {
> > > > >       u8 bcap;
> > > > > @@ -2149,34 +2165,6 @@ static int
> > > > > anx7625_connector_atomic_check(struct
> > > > anx7625_data *ctx,
> > > > >       if (cp == ctx->hdcp_cp)
> > > > >               return 0;
> > > > >
> > > > > -     if (cp == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> > > > > -             if (ctx->dp_en) {
> > > > > -                     dev_dbg(dev, "enable HDCP\n");
> > > > > -                     anx7625_hdcp_enable(ctx);
> > > > > -
> > > > > -                     queue_delayed_work(ctx->hdcp_workqueue,
> > > > > -                                        &ctx->hdcp_work,
> > > > > -                                        msecs_to_jiffies(2000));
> > > > > -             }
> > > > > -     }
> > > > > -
> > > > > -     if (cp == DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> > > > > -             if (ctx->hdcp_cp !=
> > DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > > > -                     dev_err(dev, "current CP is not ENABLED\n");
> > > > > -                     return -EINVAL;
> > > > > -             }
> > > > > -             anx7625_hdcp_disable(ctx);
> > > > > -             ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> > > > > -             drm_hdcp_update_content_protection(ctx->connector,
> > > > > -                                                ctx->hdcp_cp);
> > > > > -             dev_dbg(dev, "update CP to UNDESIRE\n");
> > > > > -     }
> > > > > -
> > > > > -     if (cp == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > > > -             dev_err(dev, "Userspace illegal set to PROTECTION ENABLE\n");
> > > > > -             return -EINVAL;
> > > > > -     }
> > > > > -
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > @@ -2425,6 +2413,8 @@ static void
> > > > > anx7625_bridge_atomic_enable(struct
> > > > drm_bridge *bridge,
> > > > >       struct anx7625_data *ctx = bridge_to_anx7625(bridge);
> > > > >       struct device *dev = ctx->dev;
> > > > >       struct drm_connector *connector;
> > > > > +     struct drm_connector_state *conn_state;
> > > > > +     int cp;
> > > > >
> > > > >       dev_dbg(dev, "drm atomic enable\n");
> > > > >
> > > > > @@ -2439,6 +2429,32 @@ static void
> > > > > anx7625_bridge_atomic_enable(struct
> > > > drm_bridge *bridge,
> > > > >       _anx7625_hpd_polling(ctx, 5000 * 100);
> > > > >
> > > > >       anx7625_dp_start(ctx);
> > > > > +
> > > > > +     conn_state =
> > > > > + drm_atomic_get_new_connector_state(state->base.state,
> > > > > + connector);
> > > > > +
> > > > > +     if (WARN_ON(!conn_state))
> > > > > +             return;
> > > > > +
> > > > > +     cp = conn_state->content_protection;
> > > > > +     if (cp == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> > > > > +             if (ctx->dp_en) {
> > > > > +                     dev_dbg(dev, "enable HDCP\n");
> > > > > +                     anx7625_hdcp_enable(ctx);
> > > > > +
> > > > > +                     queue_delayed_work(ctx->hdcp_workqueue,
> > > > > +                                        &ctx->hdcp_work,
> > > > > +                                        msecs_to_jiffies(2000));
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     if (cp == DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> > > > > +             if (ctx->hdcp_cp !=
> > DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > > > +                     dev_err(dev, "current CP is not ENABLED\n");
> > > > > +                     return;
> > > > > +             }
> > > > > +
> > > > > +             anx7625_hdcp_disable_and_update_cp(ctx);
> > > > > +     }
> > > > >  }
> > > > >
> > > > >  static void anx7625_bridge_atomic_disable(struct drm_bridge
> > > > > *bridge, @@ -2449,6 +2465,8 @@ static void
> > > > > anx7625_bridge_atomic_disable(struct
> > > > > drm_bridge *bridge,
> > > > >
> > > > >       dev_dbg(dev, "drm atomic disable\n");
> > > > >
> > > > > +     anx7625_hdcp_disable_and_update_cp(ctx);
> > > > > +
> > > > >       ctx->connector = NULL;
> > > > >       anx7625_dp_stop(ctx);
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > > --
> > > > With best wishes
> > > > Dmitry
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

