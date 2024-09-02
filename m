Return-Path: <linux-kernel+bounces-311753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1734968D0B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A80A1F22FE0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7311C62AE;
	Mon,  2 Sep 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="W0E1ioUE"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87C19F12F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300031; cv=none; b=sozADlbEX4wsmcYV91/y0R8btLl0WUdj93bC8dsdNNcgs+Tyq7ZtDHZATfOl5f7CR7mOakM66sEwPSxfC0voNS+MqG8wWhFNX6rw8o6SqzUsj9M9qAXnsjolGKjnOerw9mcM4B2f7GicBQ7/q9XZOlDCUM+DCAd7YTs+yrBKUfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300031; c=relaxed/simple;
	bh=eIdZarM1ZLkVjotRPPZmnvVFmvtd6W2DF0WIqNGWdp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z23c3AJDR4OPNJFVKboiCRsQIm2m3ZqIbh/jw7fL2yMnXYXscn26JWU9oc/wykGBo86DchKn+Gr0XtT0JMF6QtdCJj2FnP8ElEEeNy2oIDI+WDra0QPcgwaER+NDH5TYgO1FHKVKZNMNIBTA69qVvkxBy86ANv6jIJl9OxvuVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=W0E1ioUE; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e13d5cbc067so4759739276.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1725300028; x=1725904828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TDNeSmr+pEwKiBUwbmQzYPYqs+N6cVSAJynan+v3I9Q=;
        b=W0E1ioUEEe626nTl+afl8lO4DVm2lEoZZ6RWB2n7LmwxDYJjXMj60+ApB83mftARpu
         v+EXTrCvmAdt8W8+5XLR3JxMwk606dKA0DlfGLy0pjjvzAIGDH1o35F6OgTgJoWLBO1J
         qUQ9G1cwGm3O+5T/sL+698kNbq/BRSAmipYkZp8VhmEP1S4zb2LhUrmLosZYScEKshD5
         upxs0rCAyv/K0qM4h2V6GW58iG+UDtN2ZbXJOSYGVgbH+C3EgG9qWNnfzDvClN7NQWKp
         eEchcQTd40LTRv/Hfl+RyuhQ2U8B/dGRXxGPd2oiDvluD8K/zM6Nuw+ha+/c66qi6o+5
         JQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725300028; x=1725904828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDNeSmr+pEwKiBUwbmQzYPYqs+N6cVSAJynan+v3I9Q=;
        b=qVT+qKBgzpzpa+SIEA1KJk6dOKmeyOLZWE8LFn7nTEuzUZc/yRuWuq2A3b0jbcJEUM
         PCNpgPJNe6/6MUgwN4NAaWX/w6wYTOWM0JfYwBKl94/vQeG6Si5JEIXAPvaE0cIBDa7V
         lNAdEmNmf2waDomC2hfcTqv5pnyRMuVsBfNRCWujM6ju9zfVqwMtySds2D190M0K3qOZ
         8wH4MgEqkxMzcx7i1X81REWG+SuYgzRCez2DTk9V0qiveop4g9Pvq8efp/LpHmVsYopj
         b3nhFZaaKnVQgHn8w3XqfctTxyRK9Tz3BYXZL9pwoJUMhr3PdTOdLchi5GErRwKW6CBF
         SbNA==
X-Forwarded-Encrypted: i=1; AJvYcCX7dZwD+TPIm7Ev7xkN5/ZBUfqHg5/0I0f5sR705b1aFi0qbNKxkXEyATb46CeLv08U3/oSf6xvL1KSvq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLbnOmGrgzlgA85mBdsRDWm8KonULkKRw70NByCOvYfkuKKYmp
	+UpXr2cetkGuUGqjB2jtbaktJ4f1Upfa9lVgiXxfSNULwpp5wOxYwWBdHXxGfD04JV1Q60j7yNs
	eWfD8986f4Fsh2IsrMHHRtr7s5YuHrt1zJ185eA==
X-Google-Smtp-Source: AGHT+IFn4wQQczLIIxtXiQbYwUwHLtres2LmVlKhTtBWt0g9+wQzEl6+uilrT4mQe/H3yg5cNi2SGciwpTKS3FNIHAo=
X-Received: by 2002:a25:ce50:0:b0:e1a:8026:e71b with SMTP id
 3f1490d57ef6-e1a8026e893mr9541600276.54.1725300028277; Mon, 02 Sep 2024
 11:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902-imx290-avail-v3-0-b32a12799fed@skidata.com> <20240902-imx290-avail-v3-2-b32a12799fed@skidata.com>
In-Reply-To: <20240902-imx290-avail-v3-2-b32a12799fed@skidata.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 2 Sep 2024 19:00:12 +0100
Message-ID: <CAPY8ntCj=u4ZQJwjhvZF30x08Cf0h7R5yQTim7QCKd8bi_M08w@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] media: i2c: imx290: Define absolute control ranges
To: bbara93@gmail.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Benjamin Bara <benjamin.bara@skidata.com>
Content-Type: text/plain; charset="UTF-8"

Hi Benjamin

On Mon, 2 Sept 2024 at 16:58, <bbara93@gmail.com> wrote:
>
> From: Benjamin Bara <benjamin.bara@skidata.com>
>
> For now, the driver activates the first mode (1080p) as current active
> mode in probe(). This e.g. means that one cannot set VBLANK below 45
> (vmax_min - height), although theoretically the minimum is 30 (720p
> mode). Define the absolute possible/supported ranges to have them
> available later.

Currently the driver will set the ranges for VBLANK and HBLANK
whenever the mode changes.

How is it helpful to fake these numbers? Seeing as they aren't
reflecting anything useful, they may as well all be 0.

> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
> Changes since v2:
> - new
> ---
>  drivers/media/i2c/imx290.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> index 1c97f9650eb4..466492bab600 100644
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -499,6 +499,10 @@ static const struct imx290_clk_cfg imx290_720p_clock_config[] = {
>  };
>
>  /* Mode configs */
> +#define WIDTH_720P     1280
> +#define HEIGHT_720P    720
> +#define MINIMUM_WIDTH  WIDTH_720P
> +#define MINIMUM_HEIGHT HEIGHT_720P
>  static const struct imx290_mode imx290_modes_2lanes[] = {
>         {
>                 .width = 1920,
> @@ -512,8 +516,8 @@ static const struct imx290_mode imx290_modes_2lanes[] = {
>                 .clk_cfg = imx290_1080p_clock_config,
>         },
>         {
> -               .width = 1280,
> -               .height = 720,
> +               .width = WIDTH_720P,
> +               .height = HEIGHT_720P,
>                 .hmax_min = 3300,
>                 .vmax_min = 750,
>                 .link_freq_index = FREQ_INDEX_720P,
> @@ -537,8 +541,8 @@ static const struct imx290_mode imx290_modes_4lanes[] = {
>                 .clk_cfg = imx290_1080p_clock_config,
>         },
>         {
> -               .width = 1280,
> -               .height = 720,
> +               .width = WIDTH_720P,
> +               .height = HEIGHT_720P,
>                 .hmax_min = 3300,
>                 .vmax_min = 750,
>                 .link_freq_index = FREQ_INDEX_720P,
> @@ -846,6 +850,30 @@ static const char * const imx290_test_pattern_menu[] = {
>         "000/555h Toggle Pattern",
>  };
>
> +/* absolute supported control ranges */
> +#define HBLANK_MAX     (IMX290_HMAX_MAX - MINIMUM_WIDTH)
> +#define VBLANK_MAX     (IMX290_VMAX_MAX - MINIMUM_HEIGHT)
> +static unsigned int imx290_get_blank_min(const struct imx290 *imx290, bool v)
> +{

This function is never used in this patch. I'm surprised the compiler
doesn't throw an error on a static function not being used.
You first use it in patch 4 "Introduce initial "off" mode & link freq"

> +       const struct imx290_mode *modes = imx290_modes_ptr(imx290);
> +       unsigned int min = UINT_MAX;
> +       int i;
> +
> +       for (i = 0; i < imx290_modes_num(imx290); i++) {
> +               unsigned int tmp;
> +
> +               if (v)
> +                       tmp = modes[i].hmax_min - modes[i].width;

if (v)
   return h

With the complete series my sensor comes up with controls defined as
vertical_blanking 0x009e0901 (int)    : min=280 max=261423 step=1
default=280 value=280
horizontal_blanking 0x009e0902 (int)    : min=30 max=64255 step=1
default=30 value=30

Set the mode to 1080p and I get
vertical_blanking 0x009e0901 (int)    : min=45 max=261063 step=1
default=45 value=1169
horizontal_blanking 0x009e0902 (int)    : min=280 max=63615 step=1
default=280 value=280

  Dave

> +               else
> +                       tmp = modes[i].vmax_min - modes[i].height;
> +
> +               if (tmp < min)
> +                       min = tmp;
> +       }
> +
> +       return min;
> +}
> +
>  static void imx290_ctrl_update(struct imx290 *imx290,
>                                const struct imx290_mode *mode)
>  {
>
> --
> 2.46.0
>
>

