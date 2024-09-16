Return-Path: <linux-kernel+bounces-330768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F6B97A3F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24FCB2B040
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905CE157A67;
	Mon, 16 Sep 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SRY9ci2W"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A180155316
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726496161; cv=none; b=uBodxZsbjy3+BUHG2LUaOhJApop/ulk8rhmqORbiHm4dUZDP9Ef/wRjq8aOpHKpYhD/gXR4Fxbx07Qi1Twv4P6wtvf6DLd9UNTeMZVDIhTe8OJL6ZiYAjWcMa5yYAUnC8W7Ko4pi8ZPSkcgWIYLN8wQkVJuiy2siT6aJauuy8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726496161; c=relaxed/simple;
	bh=4vNgVS9GZ2j9kKRodh0jVIgu5z1qSsuIchwcUpNkRWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAw/M3i0hX0ovTFSF/NhX/jbfN/n3sM9gi6ffk1ABHEKhJYKxJszv1jZ+qWXboeaJaUxp7RIejM4Y8agd5VZDdFzlqf5/wQ011HYA0UYs3selHEb39itMIm5iwDCsH1mUD/p+n+TN1LX1LaC3b3VGoWDF3C4giGi+lP+/u3jHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SRY9ci2W; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a9acc6f22dso450879785a.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726496158; x=1727100958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE+jV0zHlg6zy6Ts72y2t3G+5soo/pTPKebVXXxYvbc=;
        b=SRY9ci2Wgyy+0wwLSwMKM4aKoPwwPzHc5xXaOODcJtC4PP0CNZoJcg37EWKLENyjaP
         TKnzZge6g41H66lOS9X4wyFNuAORZ2JdAaH9Ftb2vE4xjwewCyQYBu9vNAoe4r1Zm2DC
         v+yAIONdt+Of29Wegjc/i8VcT8OrkjN5Jw1Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726496158; x=1727100958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZE+jV0zHlg6zy6Ts72y2t3G+5soo/pTPKebVXXxYvbc=;
        b=Tk4j7LoLDw4Sgt0Zq4oji4qgB+mHpTVF7rakZG16lk4HRznPVv1rahUJDMlqNYZbR/
         U/hhKydBh60Kd6XpYAttPazKNHAfpvqNPZMf/OkO5u1H1+ltKj6P1PrPV3yUARNr7NCB
         G7XKyjI9zuGCK0Cq1Op3L3jYXOQ/JljBM5v3RlIBEjW30UD++a5HgOYr2JlsjjBrBkCI
         YDMhvJP5McnQsWLReMruxPcGw5CfKNCWTbEr7xuWZsvIJeELLcc0EUFixYD5BGcv13aB
         M+ts3s4VeYEY/cKEEHP/F1jK3ev5JrCwLLVS/O5Vi7gV6EWXceWCLfgQGH4LGQZCTckb
         Pctw==
X-Forwarded-Encrypted: i=1; AJvYcCVuZNDvIfkQwYMea2l8Z1ZbnC5W+61OLe8D96wkE9Xv+dqCCZ6PII8voSMg5ZIVnNv3EXbID097ugItIIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxavMnei+yp9XUhzyMThbXHkDiN/JE+teghyDPoVghFM1slCTe0
	EJudeUKwdGaPUkZtrQ7UvOBWjsIzCvVNV5GMcLKBf5ObedLyL9kcbl4fpyVSEHnyGHZa3BJGmge
	Eog==
X-Google-Smtp-Source: AGHT+IEWSGuu5p/8IXjvWR89vIGwmTf6MHiZ5Km9yDB+qw+mHWucgbRMy9eKJszCjVmnB91PVQLZOA==
X-Received: by 2002:a05:6214:5345:b0:6c3:6d28:c2ed with SMTP id 6a1803df08f44-6c573590297mr296653556d6.28.1726496158376;
        Mon, 16 Sep 2024 07:15:58 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c6294b0sm24776816d6.16.2024.09.16.07.15.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 07:15:57 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c3f12d3930so40344246d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:15:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWksV3Z2msiSgzvyyLAjw6QvZ1zuFykTPUZlkK3QIgYQT+GBM+tPqXDL2dX//qSaDmkdf7qEjeEje5ctHI=@vger.kernel.org
X-Received: by 2002:a05:6214:5245:b0:6c3:6e5e:64d4 with SMTP id
 6a1803df08f44-6c5736c8fdbmr253820506d6.32.1726496156795; Mon, 16 Sep 2024
 07:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911072751.365361-1-wenst@chromium.org> <20240911072751.365361-7-wenst@chromium.org>
 <CAD=FV=Udc9aP7bSzTWP82zsaztRD2YnVNpSDA54FC0dKQ-Nz2A@mail.gmail.com> <CAGXv+5FRoiv+TPyeFTcuRanRuSh2-xUo6ttVPkW6o3tktUmcFA@mail.gmail.com>
In-Reply-To: <CAGXv+5FRoiv+TPyeFTcuRanRuSh2-xUo6ttVPkW6o3tktUmcFA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 16 Sep 2024 07:15:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UDoaBN4OLZhEB4uvs6vDRVS0ZAsce2=3rJOn5sKEu-hw@mail.gmail.com>
Message-ID: <CAD=FV=UDoaBN4OLZhEB4uvs6vDRVS0ZAsce2=3rJOn5sKEu-hw@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] i2c: Introduce OF component probe function
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 15, 2024 at 4:32=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> > > + * Assumes that across the entire device tree the only instances of =
nodes
> > > + * prefixed with "type" are the ones that need handling for second s=
ource
> > > + * components. In other words, if "type" is "touchscreen", then all =
device
> > > + * nodes named "touchscreen*" are the ones that need probing. There =
cannot
> >
> > "touchscreen*" implies that it can have an arbitrary suffix. Can it?
>
> That is the idea. The use case is for components that have conflicting
> addresses and need special probing. Such device nodes obviously can't
> have the same node name. This is planned but not implemented in this
> series.

Maybe "touchscreen@*" instead of "touchscreen*" if I'm understanding correc=
tly.


> > > + * be another "touchscreen" node that is already enabled.
> > > + *
> > > + * Assumes that for each "type" of component, only one actually exis=
ts. In
> > > + * other words, only one matching and existing device will be enable=
d.
> > > + *
> > > + * Context: Process context only. Does non-atomic I2C transfers.
> > > + *          Should only be used from a driver probe function, as the=
 function
> > > + *          can return -EPROBE_DEFER if the I2C adapter or other res=
ources
> > > + *          are unavailable.
> > > + * Return: 0 on success or no-op, error code otherwise.
> > > + *         A no-op can happen when it seems like the device tree alr=
eady
> > > + *         has components of the type to be probed already enabled. =
This
> > > + *         can happen when the device tree had not been updated to m=
ark
> > > + *         the status of the to-be-probed components as "fail". Or t=
his
> > > + *         function was already run with the same parameters and suc=
ceeded
> > > + *         in enabling a component. The latter could happen if the u=
ser
> >
> > s/latter/later
>
> Are you sure?

No. latter looked weird to me and I searched quickly and thought I was
right. With a more full search looks like you're right.


> > > +int i2c_of_probe_component(struct device *dev, const struct i2c_of_p=
robe_cfg *cfg, void *ctx)
> > > +{
> > > +       const struct i2c_of_probe_ops *ops;
> > > +       const char *type;
> > > +       struct device_node *i2c_node;
> > > +       struct i2c_adapter *i2c;
> > > +       int ret;
> > > +
> > > +       if (!cfg)
> > > +               return -EINVAL;
> >
> > Drop extra check of "!cfg". In general kernel conventions don't check
> > for NULL pointers passed by caller unless it's an expected case. You
> > don't check for a NULL "dev" and you shouldn't need to check for a
> > NULL "cfg". They are both simply required parameters.
>
> "dev" is only passed to dev_printk(), and that can handle "dev" being
> NULL. Same can't be said for "cfg".
>
> I don't know what the preference is though. Crashing is probably not the
> nicest thing, even if it only happens to developers.

Honestly as a developer I'd prefer the crash. It points out the exact
line where I had an invalid NULL. Returning an error code means I've
got to compile/boot several more times to track down where the error
code is coming from.

I'm fairly certain that the kernel convention is to only check things
for NULL if it's part of the API to accept NULL or if the value can be
NULL due to untrusted data. If the only way it can be NULL is due to
buggy code elsewhere in the kernel then you should omit the error
checks.

> > > +               if (!of_device_is_available(node))
> > > +                       continue;
> > > +
> > > +               /*
> > > +                * Device tree has component already enabled. Either =
the
> > > +                * device tree isn't supported or we already probed o=
nce.
> > > +                */
> > > +               ret =3D 0;
> > > +               goto out_put_i2c_node;
> > > +       }
> > > +
> > > +       i2c =3D of_get_i2c_adapter_by_node(i2c_node);
> > > +       if (!i2c) {
> > > +               ret =3D dev_err_probe(dev, -EPROBE_DEFER, "Couldn't g=
et I2C adapter\n");
> > > +               goto out_put_i2c_node;
> > > +       }
> > > +
> > > +       /* Grab resources */
> > > +       ret =3D 0;
> > > +       if (ops->get_resources)
> > > +               ret =3D ops->get_resources(dev, i2c_node, ctx);
> > > +       if (ret)
> > > +               goto out_put_i2c_adapter;
> > > +
> > > +       /* Enable resources */
> > > +       if (ops->enable)
> > > +               ret =3D ops->enable(dev, ctx);
> > > +       if (ret)
> > > +               goto out_release_resources;
> >
> > I won't insist, but a part of me wonders whether we should just
> > combine "get_resources" and "enable" and then combine "cleanup" and
> > "free_resources_late". They are always paired one after another and
> > I'm having a hard time seeing why they need to be separate. It's not
> > like you'll ever get the resources and then enable/disable multiple
> > times.
>
> Maybe. The structure was carried over from the original non-callback
> version. I think it's easier to reason about if they are kept separate,
> especially since the outgoing path is slightly different when no working
> component is found and one of the callbacks ends up not getting called.

Actually, both of the outgoing callbacks are always called. It's only
the 3rd callback (the "early" one) that's called sometimes.

I won't insist on combining them, but I still feel like combining them
would be better. I'd be interested in other opinions, though.


-Doug

