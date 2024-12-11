Return-Path: <linux-kernel+bounces-441596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975669ED086
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D3B28D9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B371DA633;
	Wed, 11 Dec 2024 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="heDTfIA/"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C381D934C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932508; cv=none; b=SDSpKIIJYBiufXH3m0VXr50N1RtQsQa7rx+5kCbq4L49KZjt5oVGN808kIxsT5nghcevJoC9I/RD0f9n3CQGHTR0CuEMUxsf4hqhsWzMF33YBC7u4QD+gqcLAg+hHal9ltGB6OTBp03DAx9kTIOb3NGm1KDDsbVFMlPdBoM0OI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932508; c=relaxed/simple;
	bh=5yTQkTiLNlgzxMTI/87+m6H6CgU6XoaZc9oMqNk1wn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCDG+AGRjj60e19OObmp0IHpIHlrun4c/ZGqA+wROCM5XyGe0TbcU0mfDwtz9pgzbUFg+HuEX1gn/ZJ15H+eOFeJSwJWQ9pP4JBX+1+hM6TThlSYee2c5yf8xv+Z9s17OMfvV0HeyR3vwx76L7ZJCk2SuEQVK49QfQJvnBbohV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=heDTfIA/; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71e1728c307so603363a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733932506; x=1734537306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM4xWNbBQiQSKcdY0A3fSeeNjHX/5IOfsxpBhHQV0Y0=;
        b=heDTfIA/JlWQESXRhU7fC/dWe9DVllk8GCnefxLngY3wJ0KzthA+tb50EzP0MqhabO
         AvN5WdRDoN60df8YDV/jwntZWrtHKoZUSsxQl/fl/3pmBzRmLfDZ3kB8K0LMjWnfymmb
         c5yxeDRayPv7OfJyA6yOecmyOWPb5MlWyiItY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932506; x=1734537306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cM4xWNbBQiQSKcdY0A3fSeeNjHX/5IOfsxpBhHQV0Y0=;
        b=Xu1MjdHeeYAAC60jxco/V4Ohs/5KVRIwZnev6YrvCCuRc274xe3USq8BkMzWhV+6a/
         4IBZ8BdpDnTK6cIvnxtsZOogfx62EsVxokqeV7dTOXrkQL6A7lmDTeqHrp350+NLcxNR
         cAcc8DSZ1MIjjtLM0OLBMVUvs4FfP4k+RLNMCbiFdb5cMWxvpXqFeHhD82k/jDzbcR7s
         a5M5ctcJ2mLduxi6N1T4ONMzeRCmTziDDI1RisHUUL3lOXPMeUhaJjT7lXhpE4TPehOT
         ArAnlmKJD6OpVzodubVzyewsceEdSJKIYEwTc0ysNlms7bC/JQbSaAqT0QPxjDqZfHOS
         nmSg==
X-Forwarded-Encrypted: i=1; AJvYcCV/Rhg2H1/91+iGUDvLV2H628ePZUfKuZ8pILocsOhYpRqdsv/X5CVO1BUT7PKLvW7O8PQqSQDbRzHAO60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+pm12Sw8KvSG4N9ZNs+apVL0x3iknrwywZHPviE9LE8mImiA
	yYSj1C4M2sadksCZGsTIpEDuAlr9l/N3vN5zhH9Q+oHBqk68kxmcmnhfFv9Q4NZyvu1a8UrS+d9
	MWCzU/8pm3oDkBcaePexdV1x7Ttze0lI7vvv1
X-Gm-Gg: ASbGncuSYSGlnrE1BsEteWpFRDGdNU2uGj5yQal+GAxOxWYyq3wFHJ3Ub4yVx8b/Iwj
	GedsDb/a7CrAwYCTt+QyFv2GLWORTiy7CuxLGncYrk5RTqZBma197IuJMGRAt6tsg7w==
X-Google-Smtp-Source: AGHT+IEx/8qyRNCpAGNyBiIPDTaO6ywfXdqcQHAcz/L6po3vkqyog9ldUzPG1MyazfliKkJNK0LiFAhyClCexcxNoJQ=
X-Received: by 2002:a05:6830:6f0b:b0:71d:641b:8295 with SMTP id
 46e09a7af769-71e19b469b3mr2387272a34.28.1733932506288; Wed, 11 Dec 2024
 07:55:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209064632.1705578-1-xji@analogixsemi.com> <fy6zvkdidz2srerfq5bshgcshps2wfa4syxwndwesgxcej66ws@nf5svlpkeodh>
In-Reply-To: <fy6zvkdidz2srerfq5bshgcshps2wfa4syxwndwesgxcej66ws@nf5svlpkeodh>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 11 Dec 2024 23:54:54 +0800
Message-ID: <CAEXTbpeC9DpLxHm2fw7hWKGfpxhUy5ZgHXtGJ0=WSxRrVa845w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge:anx7625: Update HDCP status at atomic_disable()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Xin Ji <xji@analogixsemi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	bliang@analogixsemi.com, qwen@analogixsemi.com, treapking@google.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dimitry,

Thanks for the review.

On Wed, Dec 11, 2024 at 5:44=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Dec 09, 2024 at 02:46:32PM +0800, Xin Ji wrote:
> > When user enabled HDCP feature, upper layer will set HDCP content
> > to DRM_MODE_CONTENT_PROTECTION_DESIRED. Next, anx7625 will update
> > HDCP content to DRM_MODE_CONTENT_PROTECTION_ENABLED if down stream
> > support HDCP feature.
> >
> > However once HDCP content turn to  DRM_MODE_CONTENT_PROTECTION_ENABLED
> > upper layer will not update the HDCP content to
> > DRM_MODE_CONTENT_PROTECTION_UNDESIRED until monitor disconnect.
>
> What is "upper layer"? Is it a kernel or a userspace?

I think Xin meant userspace, but sounds like there are some
misunderstanding around the HDCP status.
>
> >From drm_hdcp_update_content_protection() documentation:
>
> No uevent for DESIRED->UNDESIRED or ENABLED->UNDESIRED,
> as userspace is triggering such state change and kernel performs it witho=
ut
> fail.This function update the new state of the property into the connecto=
r's
> state and generate an uevent to notify the userspace.
>
>
> >
> > So when user dynamic change the display resolution, anx7625 driver must
> > call drm_hdcp_update_content_protection() to update HDCP content to
> > DRM_MODE_CONTENT_PROTECTION_UNDESIRED in bridge interface
> > .atomic_disable().
>
> Why?
>
> >
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 25 ++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/dr=
m/bridge/analogix/anx7625.c
> > index a2675b121fe4..a75f519ddcb8 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -861,6 +861,22 @@ static int anx7625_hdcp_disable(struct anx7625_dat=
a *ctx)
> >                                TX_HDCP_CTRL0, ~HARD_AUTH_EN & 0xFF);
> >  }
> >
> > +static void anx7625_hdcp_disable_and_update_cp(struct anx7625_data *ct=
x)
> > +{
> > +     struct device *dev =3D ctx->dev;
> > +
> > +     if (!ctx->connector)
> > +             return;
> > +
> > +     anx7625_hdcp_disable(ctx);
> > +
> > +     ctx->hdcp_cp =3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> > +     drm_hdcp_update_content_protection(ctx->connector,
> > +                                        ctx->hdcp_cp);
> > +
> > +     dev_dbg(dev, "update CP to UNDESIRE\n");
> > +}
> > +
> >  static int anx7625_hdcp_enable(struct anx7625_data *ctx)
> >  {
> >       u8 bcap;
> > @@ -2165,11 +2181,8 @@ static int anx7625_connector_atomic_check(struct=
 anx7625_data *ctx,
> >                       dev_err(dev, "current CP is not ENABLED\n");
> >                       return -EINVAL;
> >               }
> > -             anx7625_hdcp_disable(ctx);
> > -             ctx->hdcp_cp =3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> > -             drm_hdcp_update_content_protection(ctx->connector,
> > -                                                ctx->hdcp_cp);
> > -             dev_dbg(dev, "update CP to UNDESIRE\n");
> > +
> > +             anx7625_hdcp_disable_and_update_cp(ctx);
>
> No. atomic_check() MAY NOT perform any changes to the hardware. It might
> be just a probe from userspace to check if the mode or a particular
> option can be set in a particular way. There is no guarantee that
> userspace will even try to commit it.

So, we should move the hdcp status update from .atomic_check() to
.atomic_enable() and .atomic_disable(), right? That is, enable HDCP
for the chip at .atomic_enable() if it is DESIRED and disable it at
.atomic_disable() if we enabled it previously.

Maybe we can keep some of the checks in .atomic_check(), but I doubt
if those logics actually make sense.
>
> >       }
> >
> >       if (cp =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > @@ -2449,6 +2462,8 @@ static void anx7625_bridge_atomic_disable(struct =
drm_bridge *bridge,
> >
> >       dev_dbg(dev, "drm atomic disable\n");
> >
> > +     anx7625_hdcp_disable_and_update_cp(ctx);
> > +
> >       ctx->connector =3D NULL;
> >       anx7625_dp_stop(ctx);
> >
> > --
> > 2.25.1
> >
>
> --
> With best wishes
> Dmitry

Regards,
Pin-yen

