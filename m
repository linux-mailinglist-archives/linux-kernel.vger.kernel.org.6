Return-Path: <linux-kernel+bounces-298348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0CD95C613
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B2A1F23B05
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BE113A88A;
	Fri, 23 Aug 2024 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oqqril0p"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ACA137932
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396737; cv=none; b=jxufcbR0OHriPTb8i5zesNwi335MsUs6flOfQM5HaNuitO81prqYuAjm45Rb6xAz1rBTMsog9NJK1B/K4/CVbwj3mrNYXAWNObqUAXirQvFyMVA0LqLaVjDT+9TJz/GjkYHzK2Vw+x48b25tZOdSocXtAbKs2L2L1FKBX2MQJ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396737; c=relaxed/simple;
	bh=0DkaIH/nX+twHmI7wfMWeM8/bOcrhMdeBUghxa7zFeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BP6qQWfEg0khadz+T9F9vBjeXhujX3wEYb1gdJlRk8LSAYvFr7mAt8j4hQpPPEtP4M+Xr2LgUH5XMKibnv9h6V85VhTuOXjHtsS5vYqaOYwRwYDEMATeIochpa3wJWVezR9a7p9VanXQPGX96mjCss7g4Yk7LRmAWYY+gLzOazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Oqqril0p; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso14942161fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724396733; x=1725001533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSqREulePxg8CKTf5awNX/HJBRiZ4QLVJ8cgBAYKHIo=;
        b=Oqqril0pwWbrDLYHVb19g0n4ysk6Ew+49EnB5G90SoC/8wogTZNwTF2acdsS6cd+72
         h4e76rsqt6uoQ9Y05QIioPqogkxw26xtDbUHiQdxUVMlDXlbG39jlqOetBJdOR1UsVY2
         2rO0tNpIfOIagEdlSm38P3QYkXyKU/vUVVLe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724396733; x=1725001533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSqREulePxg8CKTf5awNX/HJBRiZ4QLVJ8cgBAYKHIo=;
        b=KBF3ArMRs3XpJiRk44YliR/kmkhIT65HhzfypJv5BFYBFs6Qg5JF6mg1kpgwOl9iy4
         VqEYipC4ZOtgsIOSIn8p/5AMkrazBVv5ITClQDunxzlt2OMPxFBeiGj0g2btXbjErI/v
         su301lU3ARl3CxD0v5nEx5Dj/1neoZaMTSBpCncBYRa1haYnMTcgBli6mgAcP06NXITl
         XudqDexquZw0IDKAjG33tVVBdtINz7aHEQFBpMKVZMls0caH9wu5PJrc/o9mHSU3hqBF
         CPG7FxqDiYuCYasIQjVj9oTu18dVAboD3olJ5TjQm3DDLCfs125xurZ+QXOYWuhJFcwN
         uflg==
X-Forwarded-Encrypted: i=1; AJvYcCVj7perr6PLGM07vRCbaH6nMcYUv7qsA6m7YF704OTVNZNu/6oH2UwIST9ljTJJ59Kok4A5E/oJrjVZg04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvaL3todUzdqiv45+eGNIlABeOsOc1Yj6lTKAvxFM0h/eSNnsY
	Ethqm14FuYtqj4qIj75fmrx0mrPrPM+aM3HSD4am9bgspC2JlKtvp3iI/P2hn3fJKa8W0BdKZG/
	21eW7+d6yt51Zw1xLuXs9Bet8finykN7Em3QjQBH6uAETVes=
X-Google-Smtp-Source: AGHT+IGNtTDEfjRQCAU7zqH2LB9KdSvjRzwWhHcPb4xis4wVU2lVsZpgq0JMxBRDIb+KkRoJXAdbfiGPaOxPwtfJ6oc=
X-Received: by 2002:a05:6512:695:b0:530:b871:eb9a with SMTP id
 2adb3069b0e04-534387baca6mr662910e87.47.1724396733400; Fri, 23 Aug 2024
 00:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822092006.3134096-1-wenst@chromium.org> <20240822092006.3134096-5-wenst@chromium.org>
 <ZsdC8wkgsdsMJuAL@smile.fi.intel.com>
In-Reply-To: <ZsdC8wkgsdsMJuAL@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 23 Aug 2024 15:05:22 +0800
Message-ID: <CAGXv+5H3RvWFTg6dnMR6QBG-gLnv29fEC_5icdHE7Tjfy7fvxA@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] regulator: Do pure DT regulator lookup in of_regulator_bulk_get_all()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 9:54=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 22, 2024 at 05:19:57PM +0800, Chen-Yu Tsai wrote:
> > The to-be-introduced I2C component prober needs to enable regulator
> > supplies (and toggle GPIO pins) for the various components it intends
> > to probe. To support this, a new "pure DT lookup" method for getting
> > regulator supplies is needed, since the device normally requesting
> > the supply won't get created until after the component is probed to
> > be available.
> >
> > Convert the existing of_regulator_bulk_get_all() for this purpose.
> > This function has no in-tree users, as the original patch [1] that
> > used it was never landed. This patch changes the function ABI, but
> > it is straightforward to convert users.
> >
> > The underlying code that supports the existing regulator_get*()
> > functions has been reworked in previous patches to support this
> > specific case. An internal OF-specific version of regulator_get(),
> > of_regulator_get_optional(), is added for this.
>
> > [1] https://lore.kernel.org/all/20231220203537.83479-2-jernej.skrabec@g=
mail.com/
>
> Make it Link tag
>
> Link: https://lore.kernel.org/all/20231220203537.83479-2-jernej.skrabec@g=
mail.com/ [1]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> ...
>
> >       /* first do a dt based lookup */
> >       if (dev && dev->of_node) {
>
>         if (dev_of_node())
>

Not part of the original change, but I don't see why not.

> > -             r =3D of_regulator_dev_lookup(dev, supply);
> > +             r =3D of_regulator_dev_lookup(dev, dev->of_node, supply);
>
>         dev_of_node()

Ack.

> >               if (!IS_ERR(r))
> >                       return r;
> >               if (PTR_ERR(r) =3D=3D -EPROBE_DEFER)
>
> ...
>
> >  /**
> >   * of_get_regulator - get a regulator device node based on supply name
> > - * @dev: Device pointer for the consumer (of regulator) device
> > + * @dev: Device pointer for dev_printk messages
>
> dev_printk()

Ack.

> > + * @node: Device node pointer for supply property lookup
> >   * @supply: regulator supply name
> >   *
> >   * Extract the regulator device node corresponding to the supply name.
> >   * returns the device node corresponding to the regulator if found, el=
se
> >   * returns NULL.
> >   */
>
> ...
>
> >  /** of_regulator_dev_lookup - lookup a regulator device with device tr=
ee only
> > - * @dev: Device pointer for regulator supply lookup.
> > + * @dev: Device pointer for dev_printk messages.
>
> Ditto.

Ack.

> > + * @node: Device node pointer for regulator supply lookup.
> >   * @supply: Supply name or regulator ID.
> >   *
> >   * If successful, returns a struct regulator_dev that corresponds to t=
he name
> > @@ -636,13 +639,13 @@ static struct regulator_dev *of_find_regulator_by=
_node(struct device_node *np)
> >   * -ENODEV if lookup fails permanently, -EPROBE_DEFER if lookup could =
succeed
> >   * in the future.
> >   */
>
> ...
>
> > +/**
> > + * of_regulator_get_optional - get optional regulator via device tree =
lookup
> > + * @dev: device used for dev_printk messages
>
> Ditto.

Ack.

> > + * @node: device node for regulator "consumer"
> > + * @id: Supply name
> > + *
> > + * Returns a struct regulator corresponding to the regulator producer,
> > + * or IS_ERR() condition containing errno.
> > + *
> > + * This is intended for use by consumers that want to get a regulator
> > + * supply directly from a device node, and can and want to deal with
> > + * absence of such supplies. This will _not_ consider supply aliases.
> > + * See regulator_dev_lookup().
>
> Fix kernel-doc warning.

Ack.


Thanks
ChenYu

> > + */
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

