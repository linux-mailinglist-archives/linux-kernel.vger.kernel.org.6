Return-Path: <linux-kernel+bounces-329006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 848B5978BF7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA0BDB22950
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA00E17CA1F;
	Fri, 13 Sep 2024 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fbdhfrwC"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9772D26289
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726271347; cv=none; b=eSttoqG4vKf53zkrE0m5N8XQQN8N/WvZbcjUII8f0tApiBU1QPId3c7aKW6dvZP47s+9/8+qKwMIIXDdj/B4nvJHo6PPKWj4LLMLxKYwgkkOFHF4GRRUFG1nUFe4KXQIqoP2lpMmalyqsmDJIlqWsD9j3QVkxVtToJzob7km3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726271347; c=relaxed/simple;
	bh=iShfGa2K9v84syG+aLK78YPAr6h3bqgDt5AT1QZtHo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKZjN/vCBimwJYXCcMlc77m3vgR3OgoaiauulXoMBjA3vicmUv8SBR/sYzJOvoJYTM4aYnFoOirKF1medv+IaE/GaAg4mwtYGZ3TqZOFvRXg5SQGEBxGIbm/Ru4vyjwjBFgTn0oMXCs3qaHyuhX+tcPtiUFXnElTaBrJK0mXeh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fbdhfrwC; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9b3cd75e5so253313585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726271344; x=1726876144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TI7TITmGzIQHc7WsNOaVJ244cb5V1Nwa651mKiB3q/E=;
        b=fbdhfrwC8a2HquWcpdgPRxJnLn7IjMwyFhUKdUcwf7NGOJFJCfjnASA1n4qwH4bMaW
         8SxwdeongRj687R83RNHEjtkgSIk/pZal+9Yp3z8N2I3bKOzVY7wxf4DrxLi0y6wPqU7
         r5Q4mg7CfwvO619BPlKvBQpHqKfTLZ4AmRUFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726271344; x=1726876144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI7TITmGzIQHc7WsNOaVJ244cb5V1Nwa651mKiB3q/E=;
        b=EwD/3XrMy8BJ117Hko+i+AyGcPmxB8/NvzilTmsGv8Xo5vg1Kwuquj4gZHWL0JLGYI
         rS3fmvB1KW9S4Ov9lgZTiIe7p1hFsMF8OF3TFsZmtsLxjiYvZqYSVfSi4gmqS22OtOoP
         yb171aJ4sLGq02rYyMOEvXO2I4zWbKbLYZS8BNi1mozqysIwqhmHrUBgShle0kNAWT+t
         E74eBdBu3Q0nzry1vLoNh6fRez+WM/NFuaG7eZbdEefaD7F34M0eqQbJhTXxuG5UN36K
         RLBXNQbJVbePq9pDTw7kxPlNshIlZnVzRD6SEHfplJvX4MuODEpBYrS5SDgNSWwd4aqD
         h7WA==
X-Forwarded-Encrypted: i=1; AJvYcCVP4FknnmXF45+gYMmwvhlec242FH691GFoRwubnev1QdhV+2MylH8NzsidKx2sWRIjxia84aQs3DoHglE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIkuls4F2xB2zZDim3549de/xxwnoWqvhe9QS1Y7VQF+QEglX
	xZmYmh5FYA1d4g/2iptIfsTuvAjNhaZbU4IvzS39YBPRSey0idTSzMsjRTjUKWaQowdTYN8HBr4
	=
X-Google-Smtp-Source: AGHT+IHK3neiCV8JupUqnmYST21XxuA9BREQXZTmTcor5PSse8fYckUwKfKnRjL5ECbaufggE65+XA==
X-Received: by 2002:a05:620a:4508:b0:7a9:b114:471d with SMTP id af79cd13be357-7a9e5f18a6fmr1538319985a.33.1726271343744;
        Fri, 13 Sep 2024 16:49:03 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e97c123sm14324485a.29.2024.09.13.16.49.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 16:49:03 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45821ebb4e6so21571881cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:49:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXf/uq37fbjKqd9GPQjM0+/PPzaDK/EmMuygvmRRlXIM7B/lYn9v/PFmP6xOvf3VCLC33ogMZ+4keVdzg=@vger.kernel.org
X-Received: by 2002:a05:6214:448c:b0:6c3:5599:93a0 with SMTP id
 6a1803df08f44-6c57347d602mr144060086d6.0.1726271006617; Fri, 13 Sep 2024
 16:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911072751.365361-1-wenst@chromium.org> <20240911072751.365361-9-wenst@chromium.org>
In-Reply-To: <20240911072751.365361-9-wenst@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Sep 2024 16:43:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XvPA0UC87fQ+RvFzPv9qRSEP6eQhT79JOx9Arj87i9Mg@mail.gmail.com>
Message-ID: <CAD=FV=XvPA0UC87fQ+RvFzPv9qRSEP6eQhT79JOx9Arj87i9Mg@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] i2c: of-prober: Add GPIO support to simple helpers
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

On Wed, Sep 11, 2024 at 12:29=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> +static int i2c_of_probe_simple_set_gpio(struct device *dev, struct i2c_o=
f_probe_simple_ctx *ctx)
> +{
> +       int ret;
> +
> +       if (!ctx->gpiod)
> +               return 0;
> +
> +       dev_dbg(dev, "Setting GPIO\n");
> +
> +       ret =3D gpiod_direction_output_raw(ctx->gpiod, ctx->opts->gpio_hi=
gh_to_enable ? 1 : 0);
> +       if (ret)
> +               return ret;
> +
> +       msleep(ctx->opts->post_reset_deassert_delay_ms);

Like in the previous patch, you need an "if
(ctx->opts->post_reset_deassert_delay_ms)" before the msleep().


> +static void i2c_of_probe_simple_disable_gpio(struct device *dev, struct =
i2c_of_probe_simple_ctx *ctx)
> +{
> +       if (!ctx->gpiod)
> +               return;
> +
> +       dev_dbg(dev, "Setting GPIO to input\n");
> +
> +       gpiod_direction_input(ctx->gpiod);

This is weird. Why set it to input?


> @@ -347,6 +438,7 @@ int i2c_of_probe_simple_cleanup(struct device *dev, v=
oid *data)
>  {
>         struct i2c_of_probe_simple_ctx *ctx =3D data;
>
> +       i2c_of_probe_simple_disable_gpio(dev, ctx);

Maybe add a comment before the GPIO call that it's a noop if we found
something and i2c_of_probe_simple_free_res_early() was already called?
Otherwise you need to read into the function to understand why this
doesn't crash if the early call was made. To me, that makes the
abstraction add confusion instead of simplifying things.


> @@ -92,24 +93,33 @@ int i2c_of_probe_component(struct device *dev, const =
struct i2c_of_probe_cfg *cf
>   * struct i2c_of_probe_simple_opts - Options for simple I2C component pr=
ober callbacks
>   * @res_node_compatible: Compatible string of device node to retrieve re=
sources from.
>   * @supply_name: Name of regulator supply.
> + * @gpio_name: Name of GPIO.

Talk about the fact that gpio_name can be NULL or an empty string and
that they mean different things.


>   * @post_power_on_delay_ms: Delay in ms after regulators are powered on.=
 Passed to msleep().
> + * @post_reset_deassert_delay_ms: Delay in ms after GPIOs are set. Passe=
d to msleep().
> + * @gpio_high_to_enable: %true if GPIO should be set to electrical high =
to enable component.

Now that you've added the GPIOs and more delays, the description of
this structure needs to list exactly what the power sequence your
simple functions assume.

I would also say: given that you're providing a parameter anyway and
you're giving the GPIO name, can you please move away from the "raw"
values and move to "logical" values?

