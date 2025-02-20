Return-Path: <linux-kernel+bounces-523346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED1A3D55A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857651883327
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E79D1F0E4C;
	Thu, 20 Feb 2025 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAKcZ7wg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5FA1F0E3D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044913; cv=none; b=tMFmZe3BezLitYJ0c/XTHijB62MUzSKo9l4XK2sf5HLYHKEda0xz1LEe9+Nibc7ZnADOyN+muAqdpoAOVx/DZBTil+B7T+djFTNpYAb7kwjL5oUIt7TzMup3pidkRx60zvzlW+pizXWMzHR7sYldsAGa+ZYtYF0BojlU0463j8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044913; c=relaxed/simple;
	bh=TjkBgIVDkPykxXfTNJkQ2/RRYs8MAYcHrObSe1QzYi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAhgxAXpJb7r9PLLXaEE4A3IaKlA3BR/f2rjzgi9WNK8HDNVm+/5MZGRw/V4hwlfPZAbd8dTXtELNA3Sg7lGCJ8l4e2T/p/aDRJmIyeO/n5Zik4Fviy1Mvzj33nJNnWSo0VYadwpFyKCdPjWX83y1PMhH5UbgCe4STXTBL22eq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAKcZ7wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2DEC4CED1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740044913;
	bh=TjkBgIVDkPykxXfTNJkQ2/RRYs8MAYcHrObSe1QzYi8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qAKcZ7wgZuAYLUnbQT2K5Y+OaKIl2b0NIVilbOArOJb/bQ0wZdsBMW9onVK21z2Jj
	 5VFP7KcCkAq9zVNWPUJyiz84NFNgk5rhD+0A3gnPGBfSyi5DseWdIqABWomU1C6WcF
	 54jKiXmybEOmhD6L5sqrc+wDAefM4ycWC5+ptPODhyy63a31cLb06Z6WS2aDS4WR5e
	 ivH+xzA/Lf3RuZw1TZwXB+KSmTmEY0eHAZ90samLCXG0zmbSP+Oh5qLy9BWfTMRpVf
	 Dl/pY55A3BnmCqNkGO2eyF45f6sUmLhq5yqA4zZ8CEAQou9s4Yas3XgyXx+/j4Y1Wi
	 ReKVWCmS7jVvA==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6f7031ea11cso6084737b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:48:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPcIhM+8mbxEmbXlfRBS9weYHiScwKvYhQGYWuhmDOSKFF4qYeoyZzHmFICCTiW/8NAmaKUytb0c6sdaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNOfC2wY4OqTo6olp9nWgyU2NVrGmJH55KqI1GkpMXL9q8AI53
	VPgxwcT8JHEZkjzDGtIX1wSjF1cGOHvbOMiaeSf7M2YhlDJ8X/QktPbH+vn+hTE2SKxj2tgSIbR
	v/3sxRLrJ+nrWZryFZ12hqqzJ4v9938nzdox/hg==
X-Google-Smtp-Source: AGHT+IHVyfnxjQQ5aEaDqqPnDXAHxGc+7AeDEznGEtYCeqwlDBOrCPISJFLJj/LtX4uF5vP7GOn1wFrzCA3FuOZVTpY=
X-Received: by 2002:a05:6902:2384:b0:e5d:e52a:5383 with SMTP id
 3f1490d57ef6-e5e0a0c72ccmr4853420276.25.1740044912333; Thu, 20 Feb 2025
 01:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220094456.32818-1-clamor95@gmail.com> <20250220094456.32818-2-clamor95@gmail.com>
In-Reply-To: <20250220094456.32818-2-clamor95@gmail.com>
From: Robert Foss <rfoss@kernel.org>
Date: Thu, 20 Feb 2025 10:48:21 +0100
X-Gmail-Original-Message-ID: <CAN6tsi7gxP9TiZYMGUgpHKbMU03tpJAYkpt0QQxM9QGS-p9f8A@mail.gmail.com>
X-Gm-Features: AWEUYZl04SviqWXBbPQ4Tq2Q2RXXyF_nx7L186IU5dhzMZQzi8Vi4vOrBvQbNso
Message-ID: <CAN6tsi7gxP9TiZYMGUgpHKbMU03tpJAYkpt0QQxM9QGS-p9f8A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindigs: display: extend the LVDS codec with
 Triple 10-BIT LVDS Transmitter
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxim Schwalm <maxim.schwalm@gmail.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 10:45=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.c=
om> wrote:
>
> From: David Heidelberg <david@ixit.cz>
>
> LVDS transmitter used in the Microsoft Surface RT.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.=
yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> index 6ceeed76e88e..24e89c1d0c76 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> @@ -33,6 +33,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - idt,v103      # For the Triple 10-BIT LVDS Transmitter
>                - ti,ds90c185   # For the TI DS90C185 FPD-Link Serializer
>                - ti,ds90c187   # For the TI DS90C187 FPD-Link Serializer
>                - ti,sn75lvds83 # For the TI SN75LVDS83 FlatLink transmitt=
er
> --
> 2.43.0
>

Reviewed-by: Robert Foss <rfoss@kernel.org>

