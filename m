Return-Path: <linux-kernel+bounces-384971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D799B30DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804051F20C37
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE431DB34E;
	Mon, 28 Oct 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5IkQnBJ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB21CCECE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119644; cv=none; b=WRF5Kd88O83b3sTDjiSYY20eVZN+o8/ePqB5wGtjzp6HxnLbZg7t5ganVEWkxY34rpIFheMG1IRNvxGaPe9jtVkN65wtxV7InkgBJ0KlWjgMfHA8sMlktmDwqh1VoGzxn/XL70nQgAG3C6BIeenpo/ULlhtZtfSRdr3J8dIku8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119644; c=relaxed/simple;
	bh=DeYQ+dNxtG99x0aQLlVj5mjHlCA8mn9SpdtFx66tefw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUuAiGJATF/lUDMck3TtMKYPWT41AJjA/C7V8xArFFuRAxMn+ZDYcmmkGpgmixjKFdYgfcuv4EtPiNqq2oewsXo/XwhDq32OT5qdTQxxT08dp9LaXVGwHMazNZEHOoooG+h/13xdN3RoHraKF1UtxWw9EwDgK32hOi6kjC0lnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J5IkQnBJ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so36271761fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730119640; x=1730724440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeYQ+dNxtG99x0aQLlVj5mjHlCA8mn9SpdtFx66tefw=;
        b=J5IkQnBJDPZvBpq3sDebMM2lVFr3xaNVqqDGAwdh+8gCWO7KBb9BLiA7iMiUbjYj6U
         HC7+yoe6OcTDwDrv0kTiUlg+mKshF7n96lksvF6AkFpgyL6OhjvOTuEVf+/t2BrmqiTQ
         +Utxvs8xa4rR4Iymg/+hfw5EcX7mr8Bat/p8PBaYaZGibJ+kXP7S2tF3ZlGj+I1EqXzw
         mxPi0ALq7dJuw/t+gvJ1M8WusGgNFbXnAElE9XALtNDJ7st1qOiaj9bKxOj45tVgF6f2
         tHSSFiN3KAhI/HYNngucM8l9782e1299uTmFfA+yeXwY8iqATz/6Z8EMtONergQwvcCQ
         fhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119640; x=1730724440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeYQ+dNxtG99x0aQLlVj5mjHlCA8mn9SpdtFx66tefw=;
        b=cXTp9tQZD5yI4QSYllvyEC+nUUClY2TgFkmVLyujq0NY0NbzfZ+i9PU7BD9npA+YxL
         MbZSO2r5fOtqkU2Pv+/jVJRL5DBG6wVlO37CT1GRMQc1c9ySqhQZ8hS7mcGKBmJputd8
         SvflvdbNEogChj7gnR51G5LC5cBYR/19fuTyyTK2h8mSUhJfbHvVm9gPUWOIx1IbYcbq
         mbOlNDITtJaBjxT+5uVsHf+r6E2zPBeHwItkhrCBpo30FpMipJs/YlniSaAuBeaN+7kQ
         W7YMra60Cofa6QCam16XcC6uS++QLHlhfimy2k1TUTtkrn6uPUjeZm32F9dO3uEoKccX
         nwmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaKKWFufYTdTB6MhQOpCu0kyPunMLMjvECD5EPglpHy38J68RXSdHmxxNlrftYUaTsHfNmsuPBsW7sXqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+ehfFtwyg0b26ngdl+IpxU0egbNAYm4d8OIttkWgonCqbfdi
	GtkKUBn/sDcLJcNcTveQiG7F416B5vKqCJptY+NCkj5TKGx4drEQJfB81cqnt70ba4BuWzq/qlD
	31k9/qhZi+BqWg0Pe4fpmlla91NX34alEfbyDBw==
X-Google-Smtp-Source: AGHT+IHOLCFQLPNhZz+uFzdwwXch/oc0CkWdrvmLFctGLdK8llDYUMinPepdGvS7x3K/TdVsln9gijrEdwd/6GxRpNo=
X-Received: by 2002:a2e:1319:0:b0:2fb:60a0:f4e1 with SMTP id
 38308e7fff4ca-2fcbdfe8db2mr27240591fa.24.1730119640455; Mon, 28 Oct 2024
 05:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730070570.git.jahau@rocketmail.com> <30c154954a4e0f75d90f6ef6f393a5ba8b3ffea9.1730070570.git.jahau@rocketmail.com>
In-Reply-To: <30c154954a4e0f75d90f6ef6f393a5ba8b3ffea9.1730070570.git.jahau@rocketmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 13:47:09 +0100
Message-ID: <CACRpkdZfJqhUFrpv7BmMiuQYJJ8dveJyaKVh9dpVYbz-QDnKGg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] drm/panel: samsung-s6e88a0-ams427ap24: Add
 brightness control
To: Jakob Hauser <jahau@rocketmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 12:42=E2=80=AFAM Jakob Hauser <jahau@rocketmail.com=
> wrote:

> The tables for brightness to candela, aid and elvss were taken from downs=
tream
> kernel file "dsi_panel_S6E88A0_AMS427AP24_qhd_octa_video.dtsi" [1][2][3].
>
> The gamma table gets generated in "ss_dsi_smart_dimming_S6E88A0_AMS427AP2=
4.c" [4]
> with hard-coded starting values. The function smart_dimming_init() [5] go=
es
> through the v{*}_adjustments, generate_gray_scale and gamma_init procedur=
e.
> Instead of calculating it manually, it's easier to compile a custom downs=
tream
> kernel with SMART_DIMMING_DEBUG enabled and read out dmesg early at boot.
>
> Selection of the values for aid and elvss are again according to downstre=
am
> file "dsi_panel_S6E88A0_AMS427AP24_qhd_octa_video.dtsi" [6][7].
>
> The set of write commands is guided by downstream file "ss_dsi_panel_comm=
on.c" [8]
> followed by "ss_dsi_panel_S6E88A0_AMS427AP24.c" [9].
>
> The dsi mode flag MIPI_DSI_MODE_VIDEO_NO_HFP prevents screen flickering w=
hile
> changing the brightness.
>
> [1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/video/msm/mdss/samsung/S6E88A0_AMS427AP24/dsi_panel_S6E88A0_AMS427AP=
24_qhd_octa_video.dtsi#L341-L397
> [2] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/video/msm/mdss/samsung/S6E88A0_AMS427AP24/dsi_panel_S6E88A0_AMS427AP=
24_qhd_octa_video.dtsi#L214-L254
> [3] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/video/msm/mdss/samsung/S6E88A0_AMS427AP24/dsi_panel_S6E88A0_AMS427AP=
24_qhd_octa_video.dtsi#L301-L320
> [4] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/video/msm/mdss/samsung/S6E88A0_AMS427AP24/ss_dsi_smart_dimming_S6E88=
A0_AMS427AP24.c
> [5] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/video/msm/mdss/samsung/S6E88A0_AMS427AP24/ss_dsi_smart_dimming_S6E88=
A0_AMS427AP24.c#L1816-L1900
> [6] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/video/msm/mdss/samsung/S6E88A0_AMS427AP24/dsi_panel_S6E88A0_AMS427AP=
24_qhd_octa_video.dtsi#L256-L268
> [7] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/video/msm/mdss/samsung/S6E88A0_AMS427AP24/dsi_panel_S6E88A0_AMS427AP=
24_qhd_octa_video.dtsi#L322-L334
> [8] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/video/msm/mdss/samsung/ss_dsi_panel_common.c#L1389-L1517
> [9] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/video/msm/mdss/samsung/S6E88A0_AMS427AP24/ss_dsi_panel_S6E88A0_AMS42=
7AP24.c#L666-L678
>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

