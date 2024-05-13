Return-Path: <linux-kernel+bounces-177790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 316D68C44A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9661C2189D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908AE155320;
	Mon, 13 May 2024 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VRSgIo5F"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF41552E8
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615763; cv=none; b=FOFMQb21UETo65PE0vfifOJfkk76CRXO+BaGL/+ilfWgOaVhr83UwGY0ABFCsojppSFBLSFjYhVUKrVxlZJ6LBN6MZx+GyWN9cc7ag5lA4WoTpSCHbNfET76ed53j0/kJIUy3qhnRWN8SHPbGNNkbKoe01F2ijzRdZor7xBD83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615763; c=relaxed/simple;
	bh=kYk3ZCIb/BCDa967nLDsyGkJ+rMF5AqvD2finirkTKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjEFwT38T3kdmV7ERsWnZFZVNvYh8lhAUtZbLF/8YJ8crR3u40m+Nf0zuQ5r4kG7qUIRawI0QI399HwVKWefOgIaNTBzOQdSGCe9LMaAcgzAmD+Jjrfny6W/XRtYRwBKI23Boo/4rxhAa5k3aQKbpjSJZNZab4J65oPpJVgrH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VRSgIo5F; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7deb424da41so223999139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715615760; x=1716220560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3IRhSxtiuRG6Rrg6F2hEDkcNkh2AC1QxGibS7snE1k=;
        b=VRSgIo5FVf/ESE9ieUn1cIFZBNWsAkVJRnq3bO6uYqVUbjgGSpjN7qVVVCzP0yMjoa
         2di2vM5T5cKQ8CO+sfROEQuP+GgFjLxKhwGUIn0swZ6H20IZF/8Ibc9Z8b33k17mjJ7i
         JcLz70ylPTA+PGtysSo/blrVBdzr5LIgYN9+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715615760; x=1716220560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3IRhSxtiuRG6Rrg6F2hEDkcNkh2AC1QxGibS7snE1k=;
        b=pI6U4vT6WBH2o+iJUodZ1tpSqiVYBBkOzjfJhVFw2/FeUjJg1JOZoz9ni/btMDI1IR
         UwHletrQy1XmVgBrMq2dpom8to+koUx6e8TFAW5+/A3gtegOuHdMWMVhn/X6ifTw5TQI
         zvo7/pUCkN73UQlxCvCfUvgj+ZBv0FUUoJz0dmwpb2VYFAoeQSYADrmo3jMcOCUubW+M
         5uvShDWgSA0p5ZWXlKB5HMpNyEwWILXW4ISiqMiiOqO4yLyrEa0xoqvaWBcXOybqzXXi
         KIlknk/vVa/OxzyJg3TR0ivZ/8/qDIXeYjhf+HgyaQzWpI+wpepJYy8UhWB4AcAf1sji
         GvPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbVw0QPz+S6nofpVukY/I3gfJSnCXRU2CDC0S9y97yHoW6IRCGrGKGyE7hNbp8QN+fatdv3cJOJ7lfo569Lhynx7IHUV0OD5jk2xyu
X-Gm-Message-State: AOJu0YwPjp1cKlXnWaYsDZ6LzTn228wACfTcj56Vqfo4rz8jgsYlQLl8
	OhP9kiEf+a9Gk4EDrPGzlGG0FIehi1NcyX0Yuqv6kZ+YujdFvLBu7zGZPwbsoh8UgTrKGTZuaw4
	=
X-Google-Smtp-Source: AGHT+IGIJ/qTtw5Enrt+BZljttOO1QAmSq0W9bePtTHnWlGT11L2GWordb/7Y+YH4VQ+/Wxc5ewMXg==
X-Received: by 2002:a05:6602:18a:b0:7e1:9f1f:12cd with SMTP id ca18e2360f4ac-7e1b51a9827mr1130092639f.1.1715615760290;
        Mon, 13 May 2024 08:56:00 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1d7d39e6csm100408039f.19.2024.05.13.08.55.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:56:00 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36c6dd950d8so358445ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:55:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCu/DKTZsxuxDcd0TX0j+k0b2jl10bNbyOIGoHy+QMno+P2myxoxhzfDL3Y019DzqWc7tHWKF6eNDJvXMUNfYWBv4o0pfTzqhMs/SG
X-Received: by 2002:a05:622a:2293:b0:43d:f77b:7aa2 with SMTP id
 d75a77b69052e-43e094b1f0bmr4810231cf.6.1715615314713; Mon, 13 May 2024
 08:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508205222.2251854-1-dianders@chromium.org>
 <20240508135148.v4.4.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid> <20240513-solemn-yak-of-refinement-cb778a@penduick>
In-Reply-To: <20240513-solemn-yak-of-refinement-cb778a@penduick>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 13 May 2024 08:48:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UWV7O-FkO56af5-ae5qdb40p_x_yUQ3NDuJKRKzF5BWA@mail.gmail.com>
Message-ID: <CAD=FV=UWV7O-FkO56af5-ae5qdb40p_x_yUQ3NDuJKRKzF5BWA@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
To: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, 
	lvzhaoxiong@huaqin.corp-partner.google.com, 
	Jani Nikula <jani.nikula@linux.intel.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Joel Selvaraj <jo@jsfamily.in>, 
	Brian Norris <briannorris@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 13, 2024 at 2:30=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Hi,
>
> On Wed, May 08, 2024 at 01:51:46PM -0700, Douglas Anderson wrote:
> > Through a cooperative effort between Hsin-Yi Wang and Dmitry
> > Baryshkov, we have realized the dev_err() in the
> > mipi_dsi_*_write_seq() macros was causing quite a bit of bloat to the
> > kernel. Let's hoist this call into drm_mipi_dsi.c by adding a "chatty"
> > version of the functions that includes the print. While doing this,
> > add a bit more comments to these macros making it clear that they
> > print errors and also that they return out of _the caller's_ function.
> >
> > Without any changes to clients this gives a nice savings. Specifically
> > the macro was inlined and thus the error report call was inlined into
> > every call to mipi_dsi_dcs_write_seq() and
> > mipi_dsi_generic_write_seq(). By using a call to a "chatty" function,
> > the usage is reduced to one call in the chatty function and a function
> > call at the invoking site.
> >
> > Building with my build system shows one example:
> >
> > $ scripts/bloat-o-meter \
> >   .../before/panel-novatek-nt36672e.ko \
> >   .../after/panel-novatek-nt36672e.ko
> > add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-4404 (-4404)
> > Function                                     old     new   delta
> > nt36672e_1080x2408_60hz_init               10640    6236   -4404
> > Total: Before=3D15055, After=3D10651, chg -29.25%
> >
> > Note that given the change in location of the print it's harder to
> > include the "cmd" in the printout for mipi_dsi_dcs_write_seq() since,
> > theoretically, someone could call the new chatty function with a
> > zero-size array and it would be illegal to dereference data[0].
> > There's a printk format to print the whole buffer and this is probably
> > more useful for debugging anyway. Given that we're doing this for
> > mipi_dsi_dcs_write_seq(), let's also print the buffer for
> > mipi_dsi_generic_write_seq() in the error case.
> >
> > It should be noted that the current consensus of DRM folks is that the
> > mipi_dsi_*_write_seq() should be deprecated due to the non-intuitive
> > return behavior. A future patch will formally mark them as deprecated
> > and provide an alternative.
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Update wording as per Linus W.
> >
> > Changes in v3:
> > - Rebased upon patch to remove ratelimit of prints.
> >
> > Changes in v2:
> > - Add some comments to the macros about printing and returning.
> > - Change the way err value is handled in prep for next patch.
> > - Modify commit message now that this is part of a series.
> > - Rebased upon patches to avoid theoretical int overflow.
> >
> >  drivers/gpu/drm/drm_mipi_dsi.c | 56 ++++++++++++++++++++++++++++++++++
> >  include/drm/drm_mipi_dsi.h     | 47 +++++++++++++++-------------
> >  2 files changed, 82 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_=
dsi.c
> > index 795001bb7ff1..8593d9ed5891 100644
> > --- a/drivers/gpu/drm/drm_mipi_dsi.c
> > +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> > @@ -764,6 +764,34 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_dev=
ice *dsi, const void *payload,
> >  }
> >  EXPORT_SYMBOL(mipi_dsi_generic_write);
> >
> > +/**
> > + * mipi_dsi_generic_write_chatty() - mipi_dsi_generic_write() w/ an er=
ror log
> > + * @dsi: DSI peripheral device
> > + * @payload: buffer containing the payload
> > + * @size: size of payload buffer
> > + *
> > + * Like mipi_dsi_generic_write() but includes a dev_err_ratelimited()
>
> You mention in both functions that it's calling dev_err_ratelimited() ...
>
> > + * call for you and returns 0 upon success, not the number of bytes se=
nt.
> > + *
> > + * Return: 0 on success or a negative error code on failure.
> > + */
> > +int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
> > +                               const void *payload, size_t size)
> > +{
> > +     struct device *dev =3D &dsi->dev;
> > +     ssize_t ret;
> > +
> > +     ret =3D mipi_dsi_generic_write(dsi, payload, size);
> > +     if (ret < 0) {
> > +             dev_err(dev, "sending generic data %*ph failed: %zd\n",
> > +                     (int)size, payload, ret);
>
> ... but it doesn't.

Whoops, thanks for catching this! I'll plan to send a v5 tomorrow to
fix this and then I'll still plan to land the series on Thursday
unless anything major comes up.

-Doug

