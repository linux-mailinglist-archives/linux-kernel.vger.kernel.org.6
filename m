Return-Path: <linux-kernel+bounces-539577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E04A4A5FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8DD7A8187
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDE81DE3AC;
	Fri, 28 Feb 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bSazCb08"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F77C23F39A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782136; cv=none; b=U/6HEO8JloEQaAFVHC8WkV/P72nZHkBP91T1qBKqtpDQ6ZsD8+OH4ib5Jm2HzhQ1FqQleAzbBV3YNRq0k04vXsD8xr/JliUukXkyVpUyq782W3szmTL13j4Tg8FbiPaG1o0ZwKkjYqxRy4LWbMgSYLs1me/JkHctx8RlhSX/e+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782136; c=relaxed/simple;
	bh=/GN3Gq02lKGxFjLKREUiZZBaqMHMWg8SCb7Y4qcnaOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laB3ZZqnBczDDfOljxwDtETAwMmaro2KDV56GHIORCO2ACcs5uRaBuB22nYrmXM+TaBbWht2uP9o7k4PTdSEWHC1Sh7YGkM5VN3ztslDalTnicISbWbs3ZemuWaF+l+hmMwpIuwW7EzfqRNPZ9WojnduP9OD7GTABxquq4Bzfp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bSazCb08; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso4337589a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740782132; x=1741386932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRYH/DqwOrqprt4Hy5jDneelAnanR7z2qpvPIfRcpyU=;
        b=bSazCb08sZmSmWzCZw94+3/DiJLgRT7xF3xAIMyxbTlk6H+moxsJE6ra1DkSiBYeMi
         znDrQ7yqF2nOCM/JrMVCtjgeWRlDRAShQtql79gqN//cRWy3ukGZYpZm3sbn9zXpYGna
         PpR/i8c3EjT4UMKDfoG2Y+3BufmXi8H3XcPAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782132; x=1741386932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRYH/DqwOrqprt4Hy5jDneelAnanR7z2qpvPIfRcpyU=;
        b=jY5DDrB/Wxu3pz6sPe5oMJblHi/zh3a+0NBn+9HSNXhwcYtI9HKQlOYmBuLLA4/bHq
         PUNhpYFLM7+xNnYrGlT0juewEiTRXYNOrCmH7kwTPPqhtTfPdWDKn/Lwg4ZxNIiBOIiX
         khZUHKPbYAuhBAsIYWHwzjj1mArQDBdR33RVN3jOiodvhS8BRYGteMJysWO7CLYJtv3K
         uEa1BPbmVlvqGOfQq5WciISBXQXcKGH58m11mtOcjzwWwBbOjtUMy9IjlFLu/MAFQFwI
         sDp2sQzXLCvAehGnyx8qktOVZ54Zxr9902ZmXHBRjcl7/Ops8xAIICW94T410cyT+WQz
         Fdog==
X-Forwarded-Encrypted: i=1; AJvYcCXOsEvYJvtEi/ub7MNd2JLoqkHzlkSQeVuzdGWLYnagRMaK5ao2Fnt8AAtVm2aM/tDEM9hRqu1IhQCWUt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfk31IWx9Fb4AZctRIUbRoC9d5EbMd98fGNfRO2akNhzyWzYWR
	FMWMudgUulhxvPX5EtL5pFzE/bBBb9upHgYN1hbdDEkv4hOcVRl2cL7Ol6g3OKRHdbNN6QTGGQj
	Mdg==
X-Gm-Gg: ASbGncsTDk61tzQOebQH8tlUNZPu6476YLld29+z7xxbOZERkkh+Sy6UeV5yFNruniN
	+qGc3ZnVyAEF0s1s7953nzfk1mIVILhjNuX/vwUeQ2czGbUmXsEsiTjKjf/yd2lOqE5sHvzUGb1
	uq6i+G5StPIAJ0PRAYYhHU4XEDaCuwM+xF67YMFCdLqUEPLgA1IWrDP5tqcAaHicdnLDKddbJsZ
	PzrfwiDtOaGeRlpvYAsl9Q75KLNilPG4HwSEYLVxdaN05OM6KG+WmoCmjTioTEwuj4vsnLJb2dl
	++KQiNmYcPrzLoLyVGQUKUKLoCWWA84XDEjXazl6CA+GyGN8Ox5WcaNJ74wxdlVmif8YAbdpM/o
	df5FchpgW
X-Google-Smtp-Source: AGHT+IFq5j7EfQucapaGcttSTVgtgcPQLmiNRfF6yDU2zK4Q9ZpCYaScBPGVqo6MjfFSvUVFSfAQ6Q==
X-Received: by 2002:a05:6402:274b:b0:5e4:cf2e:891c with SMTP id 4fb4d7f45d1cf-5e4d6ad8737mr5251804a12.12.1740782131819;
        Fri, 28 Feb 2025 14:35:31 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6dac5sm3131884a12.19.2025.02.28.14.35.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 14:35:30 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaec111762bso466051666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:35:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/eVBG/ZBXqICkcAQQbJ6rDPxMwCaM8Ka/M4GOgU1hDUgy3zNLQ+m2FZvkVjd9FL59XSmQBhEvtBAXfXc=@vger.kernel.org
X-Received: by 2002:a2e:be03:0:b0:309:1d7b:f027 with SMTP id
 38308e7fff4ca-30b9320f37bmr19835331fa.9.1740781801791; Fri, 28 Feb 2025
 14:30:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org> <20250225-bridge-connector-v4-15-7ecb07b09cad@kernel.org>
In-Reply-To: <20250225-bridge-connector-v4-15-7ecb07b09cad@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 28 Feb 2025 14:29:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XSoANcWJEB13xmP0HjMS9dSF-LFsXG-1DS-UPbbeOxig@mail.gmail.com>
X-Gm-Features: AQ5f1Jqp-7Ry1Gg8ZKOqY3HRbtGi61kp0H-KrgGIBh7MRLyPJ5mDvINcqx1JO8Q
Message-ID: <CAD=FV=XSoANcWJEB13xmP0HjMS9dSF-LFsXG-1DS-UPbbeOxig@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] drm/bridge: ti-sn65dsi86: Use bridge_state crtc pointer
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 25, 2025 at 8:44=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The TI sn65dsi86 driver follows the drm_encoder->crtc pointer that is
> deprecated and shouldn't be used by atomic drivers.
>
> This was due to the fact that we did't have any other alternative to
> retrieve the CRTC pointer. Fortunately, the crtc pointer is now provided
> in the bridge state, so we can move to atomic callbacks and drop that
> deprecated pointer usage.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 58 +++++++++++++++++++++++------=
------
>  1 file changed, 39 insertions(+), 19 deletions(-)

Booted this up on my coachz with ti-sn65dsi86 and the display came up:

Tested-by: Douglas Anderson <dianders@chromium.org>

I haven't followed all of the refactorings, but assuming all the
previous patches are good w/ folks then this one seems fine to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

