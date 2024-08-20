Return-Path: <linux-kernel+bounces-294395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE88958D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5377C285BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49B81C463A;
	Tue, 20 Aug 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LzvhdOeg"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75E1C3F3C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174590; cv=none; b=Be5NwJtQuFC4G49dmTmwLN8mMzgQvSNFWcMu2D8f5f495P6XFdojln2Jhhg5EgVKsKOy+Qxo+/yskP6y70fMxhIXMaGO+C5AUbgBS19a7EKYzZCspFAGobRiJQR+hD1Bt6K+5D9Me1fZz2Zpnk5pu1ujbWwIUqk/25YiwhOy1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174590; c=relaxed/simple;
	bh=J/J+/+oGhoE+/tah11bxsaeUZE1I08hXwOLSwZwosUI=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Re/3mv4b7MZgs1BRRnmicknw8oNZ74fGS1exVDqov7dwm9wdx6PCdl4GnLRWclrVDRFoajsvYLTpKjrT/A3cM+Q0RLV8xChndOAOv/BPVki3JH4Tqraotu755A+kqa2q9XW+A7C1V+X8luVCwoZ9vYqFOV2K1e1I4P6FUZbUnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LzvhdOeg; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84310fb76f1so951518241.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724174587; x=1724779387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjiHfu5pkFzqUOsx+SOY2D+4odBwVmyecYJTsluInAs=;
        b=LzvhdOeg4SfcgEc2zOatYBXkMsajX2m3lS+Hu1dONIi9/CmN17VU404HV2w9nNq+NX
         1uSMv+2MSv2C4A8BPdxipvoP7s2qTcX7AQI9kDdt/pmhb72tawComUKZy1MN633uLNT8
         mD9tB3LAWsX2hw/tInNhKzkiXatDRTQd4CnA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724174587; x=1724779387;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjiHfu5pkFzqUOsx+SOY2D+4odBwVmyecYJTsluInAs=;
        b=uaGLzoEtQLxeh/F6UL9LAzZHvbn4hDsDmHKvFLccLON+l4g8x45o4FmWbXFJzZ9UE9
         EMTslZRRoJlPAMpQoB5afvqTUmbUG0CQUjEPFmSMVXn4dKrkKMOOHqKm4qt2Ljqdps08
         qYonc1FwECDoY/O8ZsOR9Tjo2wskeX+qLKGRmHJTmzCpXVoyejGmoKoL2NAdWrKX94Zs
         E5qjBbv0Y241iFNRDOF4cHwetHHWI1etDaZqI1Ouyd2ocp8bPVaM2ld6rfXG6dGCfmI4
         QQnWr9HiSynk6FA/tTdetZzQY1+/i6jtf32lUBTheKA/mGtrDJVHKMOU5mhpNtn50w4r
         YJng==
X-Forwarded-Encrypted: i=1; AJvYcCWH2d1huoK1SSRWILD4WwTnbgrLjNHPmjZI2NJ5xLwqyW0O1ds11BGafnPE33QW0LeIVR6via4kTmnVZpYXWnifhxABImG6Cr6O6dr1
X-Gm-Message-State: AOJu0YytyN06eKwJmOzOX1SwIyTk0HmzwE/IRJwxMwliBhhP3IOnA4qi
	GIrJBj7kYgOz+oroDhAxIuTX6dOjL1q2fzlQs5jrwOvE4OXlrOFqbEJxuJTDCOMftP8vEEtrxRZ
	PtBT4xWPsak2QrlCsGTwBmKhrE6+IhfpuDaIg
X-Google-Smtp-Source: AGHT+IGfqseqp4mRIKADD9bykOeA01y+4F/62kKEBLZLbbbLI1oVDw9K0JgFNuY/9j8342Q36vrpqnXZCv1APwGTLdw=
X-Received: by 2002:a05:6102:f13:b0:493:d1c3:1aef with SMTP id
 ada2fe7eead31-4977990c46fmr12594753137.14.1724174586925; Tue, 20 Aug 2024
 10:23:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Aug 2024 10:23:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE-0n52FSUFictNQ9kotgFAZPYnJpy+3Ad__QeUN+EiJuBWGwQ@mail.gmail.com>
References: <20240819223834.2049862-1-swboyd@chromium.org> <20240819223834.2049862-6-swboyd@chromium.org>
 <ZsRs6d6uOMb4DqQQ@smile.fi.intel.com> <CAE-0n52O01UgrDT2=-JJpZj39BOJNyyQC4w_pgDUmKDmcN=8Yw@mail.gmail.com>
 <ZsTPeEsS1m4Y8imq@smile.fi.intel.com> <CAE-0n52FSUFictNQ9kotgFAZPYnJpy+3Ad__QeUN+EiJuBWGwQ@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 20 Aug 2024 10:23:06 -0700
Message-ID: <CAE-0n50uOcCHHaw=opEY089ymPBER2H7QLtORFzD6ypwHEKUJw@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] usb: typec: Add device managed typec_switch_register()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, 
	Guenter Roeck <groeck@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Daniel Scally <djrscally@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Stephen Boyd (2024-08-20 10:19:48)
> Quoting Andy Shevchenko (2024-08-20 10:16:40)
> > On Tue, Aug 20, 2024 at 10:01:07AM -0700, Stephen Boyd wrote:
> > > Quoting Andy Shevchenko (2024-08-20 03:16:09)
> > > > On Mon, Aug 19, 2024 at 03:38:19PM -0700, Stephen Boyd wrote:
> > > > > +     ptr = devres_alloc(devm_typec_switch_unregister, sizeof(*ptr), GFP_KERNEL);
> > > > > +     if (!ptr)
> > > > > +             return ERR_PTR(-ENOMEM);
> > > > > +
> > > > > +     switch_dev = typec_switch_register(parent ,desc);
> >
> > (Side note: wrong location of the white space)
>
> Thanks.
>
> >
> > > > > +     if (!IS_ERR(switch_dev)) {
> >
> > (Side note: positive conditional is okay)
> >
> > > > > +             *ptr = switch_dev;
> > > > > +             devres_add(parent, ptr);
> > > > > +     } else {
> > > > > +             devres_free(ptr);
> > > > > +     }
> > > >
> > > > devm_add_action_or_reset() ?
> > >
> > > No. We don't want to call the 'action' devm_typec_switch_unregister()
> > > when it fails because that would unregister a switch that has never been
> > > registered.
> >
> > Hmm... With devm_add_action_or_reset() we first do things and then try to add
> > them to the managed resources. In that case it won't be like you described.
> >
> > What do I miss?
> >
>
> I believe you've missed that this is a wrapper around struct device and
> the error path is different (put_device() vs. device_unregister()).

Or you're suggesting devm_add_action_or_reset() after registering the
switch? Sorry it wasn't clear to me.

