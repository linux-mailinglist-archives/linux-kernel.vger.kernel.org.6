Return-Path: <linux-kernel+bounces-329003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A3978BF0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D25E284F02
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3B192B8C;
	Fri, 13 Sep 2024 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eom+H5DD"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E261922D7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726271016; cv=none; b=iWeNOYDNBmGUuawM5PaArDxazio0x/NDiw7jsGkVDVqpo9UgaRB7Bv2Z2gYxpPrAEHt5mFtkVirtBNLJehMN4iqOyvEtab84z2nj832uZYcl4x9GmAXqqq7m25V6wyvUwSTJAEfvsyIFevGxryxczXlS8JnRnu+MIfUmykCUN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726271016; c=relaxed/simple;
	bh=0ahzFG2oNxj4NQXzKVIJir1WD7KoViMiBM80pX771gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKznMeL1qDQDN6hydMFa9qhTSebUKbtuG0mBOAhWiWXDiWs+V3QYJIETizIh5FT9/7e3UPKIp16U2KhjwFoN3ejBlvtrfW8cwNkiUyl/Ba9xGdY7sHaorDPKdzJyhpPs4YV8n+PH9BR1wWIcjSY9UXhaeiAAYFyiCXfATvUX20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eom+H5DD; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c524b4a3aeso19239926d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726271009; x=1726875809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGpao8Kwq4txpjKiG0IecbBKjp+Vjjk+9Rmjd0MdGw0=;
        b=Eom+H5DDedNLLsBi2ToGc1HAYZM74KPsCaMu01N8H7W8m3ccSZMIunW0MHGUxo7Bqk
         kHOCTAqhRdD8V/2dZDawIMMywnpsdUVVRwnrLGpT3w74yD22eFVaD+P/QreE6gTw04Op
         9wDeQhVcOTIiHTtOaotQU2MTmXJOojaxzzuVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726271009; x=1726875809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGpao8Kwq4txpjKiG0IecbBKjp+Vjjk+9Rmjd0MdGw0=;
        b=JYuLwR0iE0oMpCUQNf2JtCN1oEm2kQwaN5oW8Yq7AwmW65IRHvU7/1+2iMQly+5RPH
         8/LnskqpDNPD68qWhM6ZogLr7ff05zG0i3pryS5/edITNEUN1bs9bgUI5/cTjboYM7wS
         qijhwQNwacBqDP8t1Nyb72M0gmZ2Wivbe+kFKVGU+znrLio47GvsJCBS9/NPsddoX3T2
         TY0HDTPXSRQPEWALk4sjtRvT2kMd3/FqX+AgMhWkfS9Xene6/bGmUGRWapVmS/s2ECSl
         MhyEzlltEVDRpw2hqj3WwILpW3vLIGpQ5IMCtT2fLDZil8R2G9jDD1cw+QC29QpmgLtD
         hevg==
X-Forwarded-Encrypted: i=1; AJvYcCXwdPSj5Azf9VX5G8L7cBp91hNEW/DzZ/U94hCoaWvF0KQ/g8K2uz3vc1LdBDvikTI877qtP0H+TNIEAFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzysvsnXvvAnU8o7vFcrdWqv09TajJFHPne2wE0j/JHERzYb3NI
	AA4lyIon1AnScqhp9wewH8pJeG1lBf0GcqVBjrfHrygiSFGXBqZE6mfmXsvqoysF4dLDm1sIoXY
	=
X-Google-Smtp-Source: AGHT+IE9dDP8QCrmXu5jdhYTNR4e3Rt5nSK/00x9upsmRRAu6CtWZUFFUKXdnVsTp8dUZ5Zhkfw62g==
X-Received: by 2002:a05:6214:498a:b0:6b5:58e8:8f0c with SMTP id 6a1803df08f44-6c57350a9c5mr134491806d6.7.1726271009372;
        Fri, 13 Sep 2024 16:43:29 -0700 (PDT)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c7d628esm1298396d6.137.2024.09.13.16.43.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 16:43:24 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c354091616so20695576d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:43:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVc4rc9svlFRUUOLb0+lvixZ55FZOV71EPiLd4YpJTQ1O2s6JfMbfjGYCLZR++z0QGUCdDSQkZ/QYEqH/Q=@vger.kernel.org
X-Received: by 2002:a05:6214:390a:b0:6bf:7d3c:a64d with SMTP id
 6a1803df08f44-6c573570b31mr113649466d6.32.1726271002581; Fri, 13 Sep 2024
 16:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911072751.365361-1-wenst@chromium.org> <20240911072751.365361-8-wenst@chromium.org>
In-Reply-To: <20240911072751.365361-8-wenst@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Sep 2024 16:43:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VL3nA8hwC8Ejy9T0ZWdYKxMjts8fgF7Y3CO507njOKkg@mail.gmail.com>
Message-ID: <CAD=FV=VL3nA8hwC8Ejy9T0ZWdYKxMjts8fgF7Y3CO507njOKkg@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] i2c: of-prober: Add simple helpers for regulator support
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

On Wed, Sep 11, 2024 at 12:28=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> +static int i2c_of_probe_simple_enable_regulator(struct device *dev, stru=
ct i2c_of_probe_simple_ctx *ctx)
> +{
> +       int ret;
> +
> +       if (!ctx->supply)
> +               return 0;
> +
> +       dev_dbg(dev, "Enabling regulator supply \"%s\"\n", ctx->opts->sup=
ply_name);
> +
> +       ret =3D regulator_enable(ctx->supply);
> +       if (ret)
> +               return ret;
> +
> +       msleep(ctx->opts->post_power_on_delay_ms);

Presumably you want an "if (ctx->opts->post_power_on_delay_ms)" before
the call to msleep() since it doesn't check that for you.


> +/**
> + * i2c_of_probe_simple_enable - Enable resources for I2C OF prober simpl=
e helpers
> + * @dev: Pointer to the &struct device of the caller, only used for dev_=
printk() messages
> + * @data: Pointer to &struct i2c_of_probe_simple_ctx helper context.
> + *
> + * If a regulator supply was found, enable that regulator.
> + *
> + * Return: %0 on success or no-op, or a negative error number on failure=
.
> + */
> +int i2c_of_probe_simple_enable(struct device *dev, void *data)
> +{
> +       struct i2c_of_probe_simple_ctx *ctx =3D data;
> +       int ret;
> +
> +       ret =3D i2c_of_probe_simple_enable_regulator(dev, ctx);
> +       if (ret)
> +               return ret;
> +
> +       return 0;

Instead of the above, just:

return i2c_of_probe_simple_enable_regulator(dev, ctx);

I guess maybe you'd have to undo it in the next patch, but it does
make this patch stand by itself better..

Although I'd also say that if it were me I might just get rid of the
helpers and inline the stuff. The helpers don't _really_ add too much.
3 of the 4 callers are just simple wrappers of the helper and I don't
think it would be terrible to inline the last one. I guess with the
next patch when you add GPIOs it maybe makes more sense, but even then
it feels like a stretch to me. Anyway, feel free to ignore if you
want.

> +/**
> + * DOC: I2C OF component prober simple helpers
> + *
> + * Components such as trackpads are commonly connected to a devices base=
board
> + * with a 6-pin ribbon cable. That gives at most one voltage supply and =
one
> + * GPIO besides the I2C bus, interrupt pin, and common ground. Touchscre=
ens,

Maybe speculate here that the GPIO is often an enable or reset line?
Otherwise you leave the reader wondering what this mysterious GPIO is
for.

