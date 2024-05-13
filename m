Return-Path: <linux-kernel+bounces-178041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 589768C47CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A6B1C22E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F8678283;
	Mon, 13 May 2024 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCyR3p0I"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8376C61
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629580; cv=none; b=mmUF/O1Gk0T5aia6mlkxe30U+5DjqR8gWFk7BdN6ezZdHC9ucy6lPYH0i95KuBpzTNJPgdrpPdgKgsPlio4d3lcCLPzD/IHkqyM+7KQmi5paKlOXDr8hBvd3zYg2nhwu5HG7iyt30RHbLxHrtVFFk28r4tHl6AWnywKnC+r16nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629580; c=relaxed/simple;
	bh=jfq0L0WzYlZWNJDoXdThH1orDAOUPsq8XTVqFT2qHhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIawCo86hbkes5nvatPW0q33WMw8++wDV1MNfAbOa/HT6egRunZdIS2nZbBLf7RM9AlylOKET5zlNCt65KkRqjUhJYBDN5BjfmsrARa8pkG5E/8ghHRQUAPPOGsrJUChvBdR28JEaPWmb6LyBxxxNLCuTP4eJwbj7wJApdHkqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dCyR3p0I; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-622e32414ffso16707347b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715629578; x=1716234378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJEfzwkd2qxnsKE/Vy91fWDkVPR6tUmf6vlcyzKqO+0=;
        b=dCyR3p0IEhRpcDrUZl4uBQqomyNBOG4nTixjndpT/dY0vw3RMRwjxTJPmht5IMnmzU
         pj4LKsbtOfWMHV02d9lgVTkjVC8tM4OPqwlF6dlvChpeJsJ0VgID+Te3029AOv74255O
         8ob/RznsbIjDLH942XrQE5PpCqHAfGLZ8gr60LKoljJp8DgGuath0xcrdx5o6MWLb21g
         eJKoUyBYdiz36XWuhYkUFLAlnhmK0VlTatz+AWH8Gu4GPuZxxdZFWACqp9fH0abEbEgu
         MX9R1MKaP5VU8P5NremOu3AyxCae96COgcNrxoKQLI30mxZg84+CvHVhx7+Iu0JC+yHb
         kEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629578; x=1716234378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJEfzwkd2qxnsKE/Vy91fWDkVPR6tUmf6vlcyzKqO+0=;
        b=J12nHcrWz8WDOdTilIwunLMDDFhHiTIPskFmtq3XcXFy/YaaX/nWexlIcGuOnpNMXt
         oJXavghzTl9axQ9br2ydUq6WmPE0dNYMuIslQNGFBvkskt4HO8bLFg60ixfDi2hA5TUc
         awa6PLW+zAPlcjVtdHIk6HXZR/Yz5y7m7pyndvHmIi+ANQ9OtpbfTtqw6lePqtpFGJFd
         YJmHGg0u8+iwZg4ESnJtjnloDG0uAinWlWaOoiTL1bS/jgc3kIB9G7VlfRN1fmMeOiJL
         N9PrCOUW4zfz3VAJyWhM4CQ4oCcfooUtauX8cQTh6UD3yR7AJ+WrIlwppVS+K5k7w8hO
         PYDg==
X-Forwarded-Encrypted: i=1; AJvYcCUxv9h2y9SLiPngvV156DZcLph6OdY3Sgb1eBclnzu7LRCqTRtY+qlXxiNfGeJFwLTbaQLT93R5g97sANn9znyLlS7RBoAP/BoHHV7D
X-Gm-Message-State: AOJu0YwdjM6tMV5hYHTIa2CknT27FfVOuQ1QvbbeVmLmFWj7vacElP4u
	gpuN4FAWxYilwZ8Jj3StE0IhB/92k9ZeIL5KczMYf10pLRIeXy1D4Xdw8Y0COeJSoXIkTFtF9Z0
	Sk0GC3zr01XSseMg6Y+FvPPI0ACs7IEQBnaMfRy2EZkn6VFU/zkQ=
X-Google-Smtp-Source: AGHT+IGPz3LnxD+FGgFaCeFXh78jEmepPyxiwe+4wcuPzQbaTP/typ2A4tlWBQFabmLYpFP+8e9pZBIybxpkvek/nwE=
X-Received: by 2002:a05:690c:3805:b0:61e:a66:bccd with SMTP id
 00721157ae682-622afff95e1mr158687087b3.38.1715629577353; Mon, 13 May 2024
 12:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508205222.2251854-1-dianders@chromium.org> <20240508135148.v4.6.I3c08a7d02c467d2bc88da14e513ea4c8649fce45@changeid>
In-Reply-To: <20240508135148.v4.6.I3c08a7d02c467d2bc88da14e513ea4c8649fce45@changeid>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 21:46:06 +0200
Message-ID: <CACRpkdZjaqAr6s-VUTw52qNmkP1aFxXdjdKd+JC_ukC5fKL0kw@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] drm/panel: novatek-nt36672e: Switch to mipi_dsi_dcs_write_seq_multi()
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, 
	lvzhaoxiong@huaqin.corp-partner.google.com, 
	Jani Nikula <jani.nikula@linux.intel.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Joel Selvaraj <jo@jsfamily.in>, 
	Brian Norris <briannorris@chromium.org>, Ritesh Kumar <quic_riteshk@quicinc.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 10:53=E2=80=AFPM Douglas Anderson <dianders@chromium=
org> wrote:

> This is a mechanical conversion of the novatek-nt36672e driver to use
> the new mipi_dsi_dcs_write_seq_multi(). The new function is easier for
> clients to understand and using it also causes smaller code to be
> generated. Specifically:
>
> $ scripts/bloat-o-meter \
>   ...after/panel-novatek-nt36672e.ko \
>   ...ctx/panel-novatek-nt36672e.ko
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-988 (-988)
> Function                                     old     new   delta
> nt36672e_1080x2408_60hz_init                6236    5248    -988
> Total: Before=3D10651, After=3D9663, chg -9.28%
>
> Cc: Ritesh Kumar <quic_riteshk@quicinc.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

