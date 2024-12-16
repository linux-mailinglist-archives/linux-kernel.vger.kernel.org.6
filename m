Return-Path: <linux-kernel+bounces-447286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5649F300D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C22618859F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C60204680;
	Mon, 16 Dec 2024 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UpjD4vf2"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B920012C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350716; cv=none; b=HsDdeqt88dpZo3hC22hXduxJ7RCRXPvmzjqGeezdAfpHoU4bGNmlMjyL5AGa1p94NB5ZI4k9X5CzgDgaJeeprGcgS6Vr1FsBh0C0uCcGiif11WAKoWsCHKpn91dVCqzPRoOTVIF9u7txoYd+IaQX53lHY3sdll3+94V0zPLI4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350716; c=relaxed/simple;
	bh=tF0kz8y9ZP58p3ib5Tvrn4JZfYBYFp9/3DPdeTn2XGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E18qHGpCfjxM2BgCsfk+MIyvKGpSCF0vFOotl7ouIzGIkzv+mGkYuIv31du4Epz+audH9w2T6OtV9QywDsbsPHXmNJiq6hPBv90rZN2q6A1HwlNa1B3laYgMd7+HRggVMWm7W9xkhbWkMzBRr/ZVL+f2xYSYjmGdpE5UwuNfR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UpjD4vf2; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ea55a2a38bso2177663b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734350712; x=1734955512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8K1cOj7kv2D78Ieg03Jcwx7V33fuxfxbjFiWT6wznKI=;
        b=UpjD4vf2rGaet8ULVZF6xFqnA7jkpgB6sJTtpWTeGMrAYIULTlam5O5cwjMuvwCtj3
         X2V4fU0ROgaUnikUoEqqP3BzhqCCpqpg0FICBHIdFeqIXdt7dxBueOB6XWpHErJ77uKv
         e40leC+5u2k6IS0F5fV9/4BapLgOn7+k/jGsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734350712; x=1734955512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8K1cOj7kv2D78Ieg03Jcwx7V33fuxfxbjFiWT6wznKI=;
        b=MIZNGeW27Oz/n5UJONOtlEe9AQIxzQkUNnC3LFHA9Bhk4klutkb3cqJxMGQADZLlyu
         473bjvutJgj+etKPV2yj4VizPeUlMjz6KNU28CGzrlEwXrCtg5rwBafQsAi1l3DcDUFl
         lz8OoERn9iFGR7DLgG6YXnx+9LUTocOnS6+sSKQbqK1nXT/+CGxedAfC2PUq5HHuSZ/V
         uLL2XKSwhH5vOB/Y6MHWU72C/0eMWt80s6lY43fbPVo9ku7i9Ha4TVRDi3WylEDzXjLN
         7KEKtLOtJeVCJzoX+Tfr0QnMDn1wODWEGkpOXLOMFmkJNegip73q0gLBH4KvtcxP/1BX
         Lhnw==
X-Forwarded-Encrypted: i=1; AJvYcCU1ckYIgpT+CxjXH5LKYbekR+U+1pGdWNlbZtQEvQ5R040DXSCzBVPf14+0UrKNjhXReTpXUfEXGycKwKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+UZKx2g3DHx6LkeVZ0uLLUQcpeK4zAYxIUamSbXY8qMfH7Txq
	rFrpGGGKntmXLP5BuFTqYY7NuN25U8j9eUb8HVW7pG6EYqq7c6c+cFQfFc1PcX0dI4V+m6eoj1C
	CBpydYdBW12lu5N/F6EEZKiWkPa4y1L9e8hY8
X-Gm-Gg: ASbGncvsldSpgjzTGsO73EYDfP1bM8fbZUOnQImqTmUvGPuJXs4QIiishxp3Yqzcj1m
	QyOarR/OMVqaUwwc4v7X/gByfyamae6TyAANZF7WfvXwRM8qHIJ6gTrFmCES0aglCgg==
X-Google-Smtp-Source: AGHT+IFavBk8Ryu/l2uAQIDip7R+XM8dm18vcpg1mDMUpMh3XpLIH+220bTofmhEwfydO6ojOcNXAm0rpubsiv89piQ=
X-Received: by 2002:a05:6808:f01:b0:3eb:3b6e:a74b with SMTP id
 5614622812f47-3eba686b29dmr6832115b6e.17.1734350712192; Mon, 16 Dec 2024
 04:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212055110.1862487-1-xji@analogixsemi.com>
 <vkrl7om7hepboovp2uivcnernia3ygqwrj3y3kkjydeclwvrk5@7tkdc4etkcjs>
 <BY5PR04MB673977C1DB1E774CB261C119C7382@BY5PR04MB6739.namprd04.prod.outlook.com>
 <4q2jncpnmeu7ytuyuv5pjzurh3ai5663jmu2we6cebuad2r3r5@tfb6hf6unioc>
 <BY5PR04MB673902E047FF8ADAFD8B94B3C7382@BY5PR04MB6739.namprd04.prod.outlook.com>
 <CAA8EJprGjuGFjZnXUxiMZMV=FO9O9CYt06H_nSL82fEOvPytyA@mail.gmail.com>
 <BY5PR04MB6739C5804F0E9764EFD3A3EBC73B2@BY5PR04MB6739.namprd04.prod.outlook.com>
 <fyltwqxyrmy3rz75nosc4wn6z5zglwv7pelzdf5g6ztloq4ncj@yigwmszuhigb>
In-Reply-To: <fyltwqxyrmy3rz75nosc4wn6z5zglwv7pelzdf5g6ztloq4ncj@yigwmszuhigb>
From: Pin-yen Lin <treapking@chromium.org>
Date: Mon, 16 Dec 2024 20:05:00 +0800
Message-ID: <CAEXTbpf3Bipid7bgnYzGJ6C6d+pgPcA2mjwFijSBwz_6Ub4aaw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at atomic_enable()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Xin Ji <xji@analogixsemi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bernie Liang <bliang@analogixsemi.com>, Qilin Wen <qwen@analogixsemi.com>, 
	"treapking@google.com" <treapking@google.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Mon, Dec 16, 2024 at 7:59=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Dec 16, 2024 at 08:33:23AM +0000, Xin Ji wrote:
> > > -----Original Message-----
> > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Sent: Friday, December 13, 2024 9:17 PM
> > > To: Xin Ji <xji@analogixsemi.com>
> > > Cc: Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong
> > > <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org>; Laurent =
Pinchart
> > > <Laurent.pinchart@ideasonboard.com>; Jonas Karlman <jonas@kwiboo.se>;
> > > Jernej Skrabec <jernej.skrabec@gmail.com>; Maarten Lankhorst
> > > <maarten.lankhorst@linux.intel.com>; Maxime Ripard <mripard@kernel.or=
g>;
> > > Thomas Zimmermann <tzimmermann@suse.de>; David Airlie
> > > <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Bernie Liang
> > > <bliang@analogixsemi.com>; Qilin Wen <qwen@analogixsemi.com>;
> > > treapking@google.com; dri-devel@lists.freedesktop.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at
> > > atomic_enable()
> > >
> > > CAUTION: This email originated from outside of the organization. Plea=
se do not
> > > click links or open attachments unless you recognize the sender, and =
know the
> > > content is safe.
> > >
> > >
> > > On Fri, 13 Dec 2024 at 13:00, Xin Ji <xji@analogixsemi.com> wrote:
> > > >
> > > > Hi Dmitry, sorry, I didn't clear describe the reason.
> > >
> > > Please. Do not top-post. Please paste your answer under the question,=
 not
> > > somewhere at the top of the email. This allows us to have a more cons=
tructive
> > > dialog. Additional bonus if you can fix your email client to insert s=
ensible quoting
> > > information instead of dumping the headers of the original email.
> > Hi Dmitry, OK, sorry about it. Currently, we have problem to fetch emai=
l from
> > Microsoft on Ubuntu. I'll try to fix it later.
> > >
> > > >
> > > > Anx7625 implement DSI to DP convert behind USB Type-C port, when us=
er
> > > > plug into USB Type-C Dongle with DP monitor, the user space will
> > > > enable HDCP feature, then kernel do HDCP and output display and set
> > > > HDCP content to ENABLE, but the issue happened if user manually cha=
nge the
> > > monitor's resolution later.
> > > >
> > > > Each time user change the resolution, kernel will call bridge
> > > > interface .atomic_disable() and .atomic_enable(), the old driver wi=
ll
> > > > keep HDCP state to ENABLE, this is a BUG, when user change the
> > > > resolution, kernel must change HDCP content too (mustn't keep to
> > > > ENABLE),
> > >
> > > Why? Could you please point me to the corresponding documentation or =
a code
> > > path in the other driver? Preferably i915, AMD or Nouveau.
> > As https://elixir.bootlin.com/linux/v6.12.5/source/drivers/gpu/drm/drm_=
connector.c#L1423:
> >         - ENABLED -> DESIRED (termination of authentication)
> > As there is no other interface to tell anx7625 bridge driver, so the I =
think best place to handle
> > ENABLE -> DESIRED in .atomic_disable().
>
> I was looking for something like cdns_mhdp_connector_atomic_check(),
> which switches to UNDESIRED if there is no new CRTC. Likewise i915
> driver performs this in intel_hdcp_atomic_check() if there is a need for
> modeset.

I believe you mean "DESIRED" here.
>
> For the "termination of authentication" case see
> cdns_mhdp_hdcp_check_link(), which detects if the HDCP got disabled by
> HW and then updates the status accordingly.
>
> >
> > >
> > > > as DRM doc said, kernel cannot change from ENABLE to UNDESIRE, so n=
ext
> > > > patch, I'll change it to DESIRE in .atomic_disable().
>
> This e.g. will result in HDCP being restarted for all modesets. Is this
> an expected behaviour?

The bridge could be powered off between .atomic_disable() and
.atomic_enable(), though I'm not sure if this would be a concern for
anx7625. I'll let Xin to comment on this.
>
> > > >
> > > > Thanks!
> > > > Xin
> > > >
> > > > > -----Original Message-----
> > > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > Sent: Friday, December 13, 2024 6:47 PM
> > > > > To: Xin Ji <xji@analogixsemi.com>
> > > > > Cc: Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong
> > > > > <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org>; Laur=
ent
> > > > > Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas Karlman
> > > > > <jonas@kwiboo.se>; Jernej Skrabec <jernej.skrabec@gmail.com>;
> > > > > Maarten Lankhorst <maarten.lankhorst@linux.intel.com>; Maxime Rip=
ard
> > > > > <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>;
> > > David
> > > > > Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Bern=
ie
> > > > > Liang <bliang@analogixsemi.com>; Qilin Wen <qwen@analogixsemi.com=
>;
> > > > > treapking@google.com; dri-devel@lists.freedesktop.org; linux-
> > > > > kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at
> > > > > atomic_enable()
> > > > >
> > > > > CAUTION: This email originated from outside of the organization.
> > > > > Please do not click links or open attachments unless you recogniz=
e
> > > > > the sender, and know the content is safe.
> > > > >
> > > > >
> > > > > On Fri, Dec 13, 2024 at 10:06:36AM +0000, Xin Ji wrote:
> > > > > > Hi Dmitry, thanks for the review, I made some changes which cha=
nge
> > > > > > ENABLE to DESIRE in .atomic_disable(), I'll upstream it after t=
esting. Thanks!
> > > > >
> > > > > - Please don't top-post.
> > > > >
> > > > > - You still didn't explain, why do you want to do this change of =
HDCP
> > > > >   status. Could you please provide an explanation before sending =
the
> > > > >   next iteration?
> > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > > Sent: Thursday, December 12, 2024 5:18 PM
> > > > > > > To: Xin Ji <xji@analogixsemi.com>
> > > > > > > Cc: Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong
> > > > > > > <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org>;
> > > > > > > Laurent Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas
> > > > > > > Karlman <jonas@kwiboo.se>; Jernej Skrabec
> > > > > > > <jernej.skrabec@gmail.com>; Maarten Lankhorst
> > > > > > > <maarten.lankhorst@linux.intel.com>; Maxime Ripard
> > > > > > > <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>=
;
> > > > > David
> > > > > > > Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>;
> > > > > > > Bernie Liang <bliang@analogixsemi.com>; Qilin Wen
> > > > > > > <qwen@analogixsemi.com>; treapking@google.com;
> > > > > > > dri-devel@lists.freedesktop.org; linux- kernel@vger.kernel.or=
g
> > > > > > > Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP statu=
s
> > > > > > > at
> > > > > > > atomic_enable()
> > > > > > >
> > > > > > > CAUTION: This email originated from outside of the organizati=
on.
> > > > > > > Please do not click links or open attachments unless you
> > > > > > > recognize the sender, and know the content is safe.
> > > > > > >
> > > > > > >
> > > > > > > On Thu, Dec 12, 2024 at 01:51:10PM +0800, Xin Ji wrote:
> > > > > > > > When user enabled HDCP feature, userspace will set HDCP
> > > > > > > > content to DRM_MODE_CONTENT_PROTECTION_DESIRED. Next,
> > > anx7625
> > > > > > > > will
> > > > > update
> > > > > > > HDCP
> > > > > > > > content to DRM_MODE_CONTENT_PROTECTION_ENABLED if down
> > > > > stream
> > > > > > > support
> > > > > > > > HDCP feature.
> > > > > > > >
> > > > > > > > However once HDCP content turn to
> > > > > > > DRM_MODE_CONTENT_PROTECTION_ENABLED
> > > > > > > > userspace will not update the HDCP content to
> > > > > > > > DRM_MODE_CONTENT_PROTECTION_UNDESIRED until monitor
> > > > > disconnect.
> > > > > > >
> > > > > > > It seems you've ingored a part of the previous review comment=
.
> > > > > > > It's the userspace who triggers the ENABLED -> UNDESIRED
> > > > > > > transition, not the kernel side. The change to move HDCP
> > > > > > > handling to atomic_enable() looks fine, the change to disable
> > > > > > > HDCP is not (unless I misunderstand
> > > > > something).
> > > > > > >
> > > > > > > >
> > > > > > > > So, anx7625 driver move hdcp content value checking from
> > > > > > > > bridge interface .atomic_check() to .atomic_enable(), then
> > > > > > > > update hdcp content according from currently HDCP status. A=
nd
> > > > > > > > also disabled HDCP in bridge interface .atomic_disable().
> > > > > > > >
> > > > > > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 74
> > > > > > > > ++++++++++++++---------
> > > > > > > >  1 file changed, 46 insertions(+), 28 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > index a2675b121fe4..f96ce5665e8d 100644
> > > > > > > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > @@ -861,6 +861,22 @@ static int anx7625_hdcp_disable(struct
> > > > > > > > anx7625_data
> > > > > > > *ctx)
> > > > > > > >                                TX_HDCP_CTRL0, ~HARD_AUTH_EN=
 &
> > > > > > > > 0xFF); }
> > > > > > > >
> > > > > > > > +static void anx7625_hdcp_disable_and_update_cp(struct
> > > > > > > > +anx7625_data
> > > > > > > > +*ctx) {
> > > > > > > > +     struct device *dev =3D ctx->dev;
> > > > > > > > +
> > > > > > > > +     if (!ctx->connector)
> > > > > > > > +             return;
> > > > > > > > +
> > > > > > > > +     anx7625_hdcp_disable(ctx);
> > > > > > > > +
> > > > > > > > +     ctx->hdcp_cp =3D DRM_MODE_CONTENT_PROTECTION_UNDESIRE=
D;
> > > > > > > > +     drm_hdcp_update_content_protection(ctx->connector,
> > > > > > > > +                                        ctx->hdcp_cp);
> > > > > > > > +
> > > > > > > > +     dev_dbg(dev, "update CP to UNDESIRE\n"); }
> > > > > > > > +
> > > > > > > >  static int anx7625_hdcp_enable(struct anx7625_data *ctx)  =
{
> > > > > > > >       u8 bcap;
> > > > > > > > @@ -2149,34 +2165,6 @@ static int
> > > > > > > > anx7625_connector_atomic_check(struct
> > > > > > > anx7625_data *ctx,
> > > > > > > >       if (cp =3D=3D ctx->hdcp_cp)
> > > > > > > >               return 0;
> > > > > > > >
> > > > > > > > -     if (cp =3D=3D DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> > > > > > > > -             if (ctx->dp_en) {
> > > > > > > > -                     dev_dbg(dev, "enable HDCP\n");
> > > > > > > > -                     anx7625_hdcp_enable(ctx);
> > > > > > > > -
> > > > > > > > -                     queue_delayed_work(ctx->hdcp_workqueu=
e,
> > > > > > > > -                                        &ctx->hdcp_work,
> > > > > > > > -                                        msecs_to_jiffies(2=
000));
> > > > > > > > -             }
> > > > > > > > -     }
> > > > > > > > -
> > > > > > > > -     if (cp =3D=3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED) =
{
> > > > > > > > -             if (ctx->hdcp_cp !=3D
> > > > > DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > > > > > > -                     dev_err(dev, "current CP is not ENABL=
ED\n");
> > > > > > > > -                     return -EINVAL;
> > > > > > > > -             }
> > > > > > > > -             anx7625_hdcp_disable(ctx);
> > > > > > > > -             ctx->hdcp_cp =3D
> > > DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> > > > > > > > -             drm_hdcp_update_content_protection(ctx->conne=
ctor,
> > > > > > > > -                                                ctx->hdcp_=
cp);
> > > > > > > > -             dev_dbg(dev, "update CP to UNDESIRE\n");
> > > > > > > > -     }
> > > > > > > > -
> > > > > > > > -     if (cp =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > > > > > > -             dev_err(dev, "Userspace illegal set to PROTEC=
TION ENABLE\n");
> > > > > > > > -             return -EINVAL;
> > > > > > > > -     }
> > > > > > > > -
> > > > > > > >       return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > @@ -2425,6 +2413,8 @@ static void
> > > > > > > > anx7625_bridge_atomic_enable(struct
> > > > > > > drm_bridge *bridge,
> > > > > > > >       struct anx7625_data *ctx =3D bridge_to_anx7625(bridge=
);
> > > > > > > >       struct device *dev =3D ctx->dev;
> > > > > > > >       struct drm_connector *connector;
> > > > > > > > +     struct drm_connector_state *conn_state;
> > > > > > > > +     int cp;
> > > > > > > >
> > > > > > > >       dev_dbg(dev, "drm atomic enable\n");
> > > > > > > >
> > > > > > > > @@ -2439,6 +2429,32 @@ static void
> > > > > > > > anx7625_bridge_atomic_enable(struct
> > > > > > > drm_bridge *bridge,
> > > > > > > >       _anx7625_hpd_polling(ctx, 5000 * 100);
> > > > > > > >
> > > > > > > >       anx7625_dp_start(ctx);
> > > > > > > > +
> > > > > > > > +     conn_state =3D
> > > > > > > > + drm_atomic_get_new_connector_state(state->base.state,
> > > > > > > > + connector);
> > > > > > > > +
> > > > > > > > +     if (WARN_ON(!conn_state))
> > > > > > > > +             return;
> > > > > > > > +
> > > > > > > > +     cp =3D conn_state->content_protection;
> > > > > > > > +     if (cp =3D=3D DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> > > > > > > > +             if (ctx->dp_en) {
> > > > > > > > +                     dev_dbg(dev, "enable HDCP\n");
> > > > > > > > +                     anx7625_hdcp_enable(ctx);
> > > > > > > > +
> > > > > > > > +                     queue_delayed_work(ctx->hdcp_workqueu=
e,
> > > > > > > > +                                        &ctx->hdcp_work,
> > > > > > > > +                                        msecs_to_jiffies(2=
000));
> > > > > > > > +             }
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     if (cp =3D=3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED) =
{
> > > > > > > > +             if (ctx->hdcp_cp !=3D
> > > > > DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > > > > > > +                     dev_err(dev, "current CP is not ENABL=
ED\n");
> > > > > > > > +                     return;
> > > > > > > > +             }
> > > > > > > > +
> > > > > > > > +             anx7625_hdcp_disable_and_update_cp(ctx);
> > > > > > > > +     }
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static void anx7625_bridge_atomic_disable(struct drm_bridg=
e
> > > > > > > > *bridge, @@ -2449,6 +2465,8 @@ static void
> > > > > > > > anx7625_bridge_atomic_disable(struct
> > > > > > > > drm_bridge *bridge,
> > > > > > > >
> > > > > > > >       dev_dbg(dev, "drm atomic disable\n");
> > > > > > > >
> > > > > > > > +     anx7625_hdcp_disable_and_update_cp(ctx);
> > > > > > > > +
> > > > > > > >       ctx->connector =3D NULL;
> > > > > > > >       anx7625_dp_stop(ctx);
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > With best wishes
> > > > > > > Dmitry
> > > > >
> > > > > --
> > > > > With best wishes
> > > > > Dmitry
> > >
> > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry

Regards,
Pin-yen

