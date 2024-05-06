Return-Path: <linux-kernel+bounces-169373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317FC8BC7C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6338E1C21212
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5029C4DA06;
	Mon,  6 May 2024 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUoaN3o+"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D445948
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714977928; cv=none; b=u2wniyGT1pUl+RyoKDrrmD7dLdB2HEFFQ3kzdl84ZHPH4Nivzj+4V0KhiwbQ4caD+NLBb+MQWEgKljm913U5G84VfkS3TUQAarrvhQHUESD8vVt07e8xZ1AHAnNiRYvsxBV4TAp340wlKUlJVyEVhWSfg5cy+FUoLWVat48m2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714977928; c=relaxed/simple;
	bh=b9OuIqJw9DrBFaPlZL+ogcu1hmTZDxgmDFbwewE5zgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMLPLV7MqD7s/2kPml18vdZAqJQtNvZiRSuOngHFAIZ1InQUAEPqNgMSoiEfeLGtcXHAWMAl3etGvDS1SSFltS5kXn+iL5lj6jSYbUSPaMRwSA/DRh6UvhxFcFt+490Klg4D7R6dijqWTE/gjUiIgi+LRS6+mbGgXwpksVt+unc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fUoaN3o+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6181d032bf9so13629337b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 23:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714977926; x=1715582726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mfxz2O8XS3FqjCrjmLET9AWxg3oFsKvwghyYD05k6U=;
        b=fUoaN3o+9uyTHWN02dm7MvdCb4Y0fF+2W45Z+sGlEuqOAXSTcDgYHQXOeUcemJX98I
         B3UKO1IV3zD1K1q8q0bbI7d/EbTeqttJ6bCydfmBmKc6fGesL6GImVCT8Q5Kr0ax0b03
         DywM86URqexoF9v0jv6LYfvp6LAB/BZvh/o+Z04w+lEC7ht7AP6ukRsOTDGDpTtTOh1U
         3L7YCyk6I6/yZkLhA6xfWCUqzvU8/5W+/ksDRUfDag+eeUH26ei0jj61j00UNAmFaONC
         xUdxJKA8Tw5BX4LJLezCww1HWJZkxPI9EFqeSoYjqc6On13jzpN2Xh+3vF54jpyG8WEh
         8mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714977926; x=1715582726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mfxz2O8XS3FqjCrjmLET9AWxg3oFsKvwghyYD05k6U=;
        b=aGq8ki+8JeGvLFLeLZdTsIkAX36Pg/lY1YOyueP8Vu7MrFfh9/OXXbv2h24GmyyPbU
         KigWqNjPqpZFqgdZ0Sn8jgqDfK/lvHM7dhynMqtIFMCcGqh47WQtqyQTwfrFkEE1vaav
         I3HJD9BDdIEgTBIMKCJhUEeBmuhbBYTOHeL3IIHKWqrBnn9r/Bb092RZW4z3/fgEJTRn
         yT71AaMhom9/l5ku+Xl4lQbYpvWo9fyjWZbIG3FjbsZk8YiEr4icu9yzKXJijQE1hzbQ
         nt8yOpDgiF7uzNEcKec/jdWY2SrKvZXfbj0aOkLSMGLW3nkibop6xGkwHjLxE62GRTCz
         o+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVowOqtk8ZspztH+LioBE5/mkpsQscS8r6cht74ubk2h06IE5Tmfc5G246gxopf13oIAIHVTOqggMPDdb/shrHqr6ym6WrYSTLFkJge
X-Gm-Message-State: AOJu0Yx5MlalKgaMRlFoj+xirF94EYMLh+WTu8NTq+bl1bBCCkPpYTWi
	1z3oFfXibX9iYZLwzHh3PF+KbOtbyzfx/Pn38FmOu7Mp+QMPcGijPjojT3spgy+twbt5CdL+4lA
	ntEmtrkmrg2RYeX4djWxQHP7aX7hFTNJ/ksQb2w==
X-Google-Smtp-Source: AGHT+IEFH0U8CO1IDjCLvIZv1boxJZTKo1UkGaFseTk0bJY4Cy4LrIDB4kffcrBBs7di25uwzfJQ4u2WysBYxgh/aSs=
X-Received: by 2002:a81:a14a:0:b0:61e:a3a:2538 with SMTP id
 y71-20020a81a14a000000b0061e0a3a2538mr9695835ywg.18.1714977926097; Sun, 05
 May 2024 23:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501154251.3302887-1-dianders@chromium.org> <20240501084109.v3.9.I947e28c81f9ef7dcd3add6e193be72d6f8ea086f@changeid>
In-Reply-To: <20240501084109.v3.9.I947e28c81f9ef7dcd3add6e193be72d6f8ea086f@changeid>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 May 2024 08:45:15 +0200
Message-ID: <CACRpkdZek9Q1ovQY_f7SzT3bvcK4dsn_t0ZGB94On7MG=CzTEw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] drm/panel: innolux-p079zca: Don't use a table for
 initting panels
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Brian Norris <briannorris@chromium.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Joel Selvaraj <jo@jsfamily.in>, lvzhaoxiong@huaqin.corp-partner.google.com, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 5:43=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:

> Consensus on the mailing lists is that panels shouldn't use a table of
> init commands but should instead use init functions. We'll use the
> same concepts as the recently introduced
> mipi_dsi_generic_write_seq_multi() to make this clean/easy and also
> not bloat the driver too much. Measuring before/after this change:
>
> $ scripts/bloat-o-meter \
>   .../before/panel-innolux-p079zca.ko \
>   .../after/panel-innolux-p079zca.ko
> add/remove: 3/2 grow/shrink: 0/1 up/down: 2356/-1944 (412)
> Function                                     old     new   delta
> innolux_p097pfg_init                           -    1772   +1772
> innolux_p097pfg_init.d                         -     480    +480
> innolux_panel_write_multi                      -     104    +104
> innolux_panel_prepare                        412     308    -104
> .compoundliteral                             480       -    -480
> innolux_p097pfg_init_cmds                   1360       -   -1360
> Total: Before=3D5802, After=3D6214, chg +7.10%
>
> Note that, unlike some other drivers, we actually make this panel
> driver _bigger_ by using the new functions. This is because the
> innolux-p079zca panel driver didn't have as complex of a table and
> thus the old table was more efficient than the code. The bloat is
> still not giant (only 412 bytes).
>
> Also note that we can't direclty use
> mipi_dsi_generic_write_seq_multi() here because we need to deal with
> the crazy "nop" that this driver sends after all commands. This means
> that we have to write code that is "inspired" by the new macros.
>
> Since we're touching all the tables, let's also convert hex numbers to
> lower case as per kernel conventions.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

With the mentioned bugfix:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

