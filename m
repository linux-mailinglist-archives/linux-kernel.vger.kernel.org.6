Return-Path: <linux-kernel+bounces-169350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341128BC772
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAFA1F216E1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03984CB58;
	Mon,  6 May 2024 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIc3aAKz"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF93D967
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714976369; cv=none; b=eAQfYVKoUPiyOk9DqAA9MD7Yo2pFOv9z4fvjcMSmEsDAcSS5oeaOgwctRXId/cJYvCyU52NKb7yEcYRIeGBpSbXWi74+Y+ndmTsWoR2OkjX4UMptNE2ty4ah2W73+0r3XQcowk/S+yv6H4/pzZgCDVz2Uw9t3l6aQWRy6ke8Bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714976369; c=relaxed/simple;
	bh=hm9WP4hdWnhP4OGT6tKYYiu05S+Pl1cEl7fH15NGw9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQwIyR+RLSK4Ci1Ke8RILrIx3Z1dXl+yOxn7KIKnb3Rvwi5XJlGm0gAxhkvTsZb8xe4pgJl3hYeQbrPauQ7JrB7ZcUm6msWu63FmZu00hLiWl7kaDlcFSsa82shREbe+RiETLyCmFXgedA8ZUZoTOypUwdAKEBR/JNMjfNCkrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIc3aAKz; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61e0c2b5cd2so25803887b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 23:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714976367; x=1715581167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFdACjcDM2Uo7LPWPgteG5eQO148kN9bkoBsOWzObaM=;
        b=LIc3aAKzSAVdjAr1+lFQWMiOsWLY5nl4HBtm61xTVJCAVA08rOa+oYtFHpJbxPa+/i
         nx1yY0oIcZprugjl1qfGOdEvqMrlv7u1kQstxORBxMjmFTvo811sMmBRt39oCiSLWStA
         IXjkWsbtnsK7/cd3pg2Bp5Y1dQmvl7wOlQkqM0U8C1WpO9HqtVcRY44XGdWcGtUPv4aM
         ITAp1GNerYaoD8sMsertaQZv4W22fd9G6kXB0pxRMlf8N85R1YnxQQuEn6WHExKg13AJ
         GHPtWCg+JJzcScrMjD314nzdqYUzcgUNdq+4/36e5YNyLSGuugMcU2R3QyNY2xP77XNa
         XlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714976367; x=1715581167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFdACjcDM2Uo7LPWPgteG5eQO148kN9bkoBsOWzObaM=;
        b=ZJ1DKY3kZP+TynZ1uC2Y/J+Y+y+YZjxk7CaR88SdCjUyaeTD1Grr46vEdF28+P1Iif
         7doc5igDXfVNmacQrK+SJdqgBUhUtlz8Vh12rpK8JcDGp9CEM+h1Rn7YaZkqFNlMSzIs
         4YSbWmsMvIWs6SORdQIyiU2obKpWZjDvsgGmHcJ6TTMA/dNxE0QHIf3URT1TCA2hEq9f
         M38HiC1ewNrinDLv2/7IdJG42yTpaE3vyoujM6Ci/i0KzqRMydEcdHn9SuLDwELIKCKS
         ccrpVAM4Otg5/0lQfUniqZO1eiG9mDMEcAaeL0jY5a2PE6awHG9WK7KF8/qXi/MauNOo
         YfCg==
X-Forwarded-Encrypted: i=1; AJvYcCWNOq8QPUU91ktd84Iz6MXS6fMyMhNERX/hnG2o58dLUEB45IIZUH6Pv7+yNaL6H+Jx1T0pg87FxQNvTo9UO7vN1JaKO85RDcyuzwPU
X-Gm-Message-State: AOJu0YzUyeA9wzonfFuhmZmCZQIN5ICkpU/jXWmbtZQlBpoQ4qwmNlAd
	ogQypTVy9pEk/sHRxIYCHu26EIG32bCv76AXxykIsiuK5wX2Epe2d7DxQSVJRPVnxSUndoP/2pF
	MRNv+KYPRQHgLqBFwBrVrwvxFqVbWqLq5R4fl6A==
X-Google-Smtp-Source: AGHT+IEOfDlvTMI/NrunpGMGEX1H7cUaYUMUIp5ePuXRYMERxQPnW5eCWrbE7ubT2MVuE+JU6uHO09TVxn9P+Oaprq0=
X-Received: by 2002:a05:690c:398:b0:61b:e1e8:9a2c with SMTP id
 bh24-20020a05690c039800b0061be1e89a2cmr10154543ywb.1.1714976366663; Sun, 05
 May 2024 23:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501154251.3302887-1-dianders@chromium.org> <20240501084109.v3.8.I407b977f9508573103491df549dfaffc3688db13@changeid>
In-Reply-To: <20240501084109.v3.8.I407b977f9508573103491df549dfaffc3688db13@changeid>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 May 2024 08:19:15 +0200
Message-ID: <CACRpkdZm2diaTMQdpdCRdzjkmzP6dEYtWpCF+NyUzoYbqnFbuw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] drm/panel: ili9882t: Don't use a table for
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
> init commands but should instead use init functions. With the recently
> introduced mipi_dsi_dcs_write_seq_multi() this is not only clean/easy
> but also saves space. Measuring before/after this change:
>
> $ scripts/bloat-o-meter \
>   .../before/panel-ilitek-ili9882t.ko \
>   .../after/panel-ilitek-ili9882t.ko
> add/remove: 3/2 grow/shrink: 0/2 up/down: 6834/-8177 (-1343)
> Function                                     old     new   delta
> starry_ili9882t_init                           -    6152   +6152
> starry_ili9882t_init.d                         -     678    +678
> ili9882t_disable.d                             -       4      +4
> ili9882t_disable                             260     228     -32
> ili9882t_prepare                             540     396    -144
> .compoundliteral                             681       -    -681
> starry_ili9882t_init_cmd                    7320       -   -7320
> Total: Before=3D11928, After=3D10585, chg -11.26%
>
> Let's do the conversion.
>
> Since we're touching all the tables, let's also convert hex numbers to
> lower case as per kernel conventions.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for doing this Doug, everything is starting to look much
better after this series, and I hope we can keep Chromium display
drivers looking this good going forward.

Yours,
Linus Walleij

