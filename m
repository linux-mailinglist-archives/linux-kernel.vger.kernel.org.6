Return-Path: <linux-kernel+bounces-384970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA019B30D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5B32828F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65F71D63EF;
	Mon, 28 Oct 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pnm9cACf"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DAF1D9586
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119588; cv=none; b=OdPQUVHKaaZbL9GXmOoXXJiQpZNl8yYEgC25rifeNT6XjXBSNexel9LACcURvVXizH/B49O/rTzmX6a9H54W4FHIGx7yG8CCdDxUDC6y7VNkTxrOduGDgzv4g81Rx+3r8OrGeBMru3wAWoW8TVOHXunJJR5TLEczCNOJeo7FneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119588; c=relaxed/simple;
	bh=+AitCXjKq04W7cgcQoh9oz7Gk+0bO2Nu1FQBG5LO1zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHJ/ZVekExms4pTi0JVYS67J0iQ4zoxTs6KFN5wR86umohvWUYtGtOLjWYH484dip33uZBb9ZdNdJwwhFQcHqNgHDN6pN/LKGZaAVu2F96eITah6aq21mx97sCnyIDLEqBQ2oKNiPODUfe8ApPZcGpI/A1lP8WXHzNeZB1wK2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pnm9cACf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f6e1f756so4476751e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730119584; x=1730724384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aSTTKcsEues9Slud5u2I4oUCfkMRIvmSj7eb96RQ74=;
        b=Pnm9cACf0iOoVU40zZmmphsUqrD5CybLxo0O3rfC/DyG0LoGwbLFSyaNR6XlT+/dBL
         XOQajbOLN42d5A4hd5aJQUv2gLGf+YzQ9eHYRzt1KTSoNwCp8O5dwjbQLHTSg3qEkvKu
         5WYABkz35HIOBttURkEfxl4bIpy+6Ur9CSty3NuS8Zwpx5e7q+rKwt4Cr792whTc9fgc
         eyqW4Il7WhrQKG+vB5W79v09QVW/SSPjAB987UCcRZCMhJjdFa3z9IEcreDQ4o9h9Elj
         juUr5YFjJ8rJuJrV6cFiU/Qi3UJHO01JFRUxbB8p79u+WbCsxvQDt0upFFhbjMrqunKF
         Hynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119584; x=1730724384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aSTTKcsEues9Slud5u2I4oUCfkMRIvmSj7eb96RQ74=;
        b=WnMYsM8IWDNi7mxRwoOnPCZsrVT37Utl8/ZhUuzglYPtrUma8QEjnQAhp69a7DVW9m
         wl53dnjD59ZhtH1GAxFOR4Q9W5FlX5BLXkxoVxYegCH+xLzpfpuGaJmFkjNrlC7T6ml8
         k+wWCCRLblqtv8BDTJ5gKFxlTptJDRAhAHDC7AOBRYNE6VUK4IUKNc9VQpSpl3Q/RvYy
         V59MfkiClfbzIcvp2G8ORmJqDz7EXdtOhhq16PtjJ4d6zoQ0qT7LWy4hoNvr03xKXUgm
         fs3BAz9LrgCW4GRsC9pfvlewxOfXrlAEctchOq7/80PBWCIquGPHNA/QLzvzHE0XyyCh
         BeSA==
X-Forwarded-Encrypted: i=1; AJvYcCUB3ZJ9PhZCRJCtEw+3Ogs5ozX3s5WfQIkLSpt7dBfWjAgnYNm9VHf3gOMEQLZDZ4EsIpAsWyEjnKQcDYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBIGmTo38Hr6+a3JAldg1d6lNvjUHAVjphOSbLiSJ6KV45Jt8
	UX7zhyIYOzy0H3cYX/FXq6YcFND2u7gzyBqntnvnKMXHgzClXkHfF1KJFpKCnSxDw1pj0KvsoyL
	1jLK4LO/Bmg5/qpmSp8VMZoNvaC/hslATCAyfiw==
X-Google-Smtp-Source: AGHT+IHKBOt7btwvvrMi093N8L0HSsxQd++C6ep3baxxUYVZr5QdfiIpCSS/MoaRNRGceN2TTToscxI5mPA8SlKe6OY=
X-Received: by 2002:a05:6512:318d:b0:539:f65b:401 with SMTP id
 2adb3069b0e04-53b34c463d9mr2861815e87.57.1730119583728; Mon, 28 Oct 2024
 05:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730070570.git.jahau@rocketmail.com> <d92ef0036b66520bb6d1ec908165e776cf30c303.1730070570.git.jahau@rocketmail.com>
In-Reply-To: <d92ef0036b66520bb6d1ec908165e776cf30c303.1730070570.git.jahau@rocketmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 13:46:11 +0100
Message-ID: <CACRpkdZSxvLri-9CQQMuFP-Q4UswoJq4YDySWR0GXz0=+xcLiw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] drm/panel: samsung-s6e88a0-ams427ap24: Add initial driver
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

> This initial part of the panel driver was mostly generated by the
> "linux-mdss-dsi-panel-driver-generator" tool [1], reading downstream
> Android kernel file "dsi_panel_S6E88A0_AMS427AP24_qhd_octa_video.dtsi" [2=
].
>
> On top of the generic output of the tool, there were a couple of changes
> applied:
> - Added mipi_dsi_dcs_set_display_on() to function s6e88a0_ams427ap24_on()=
,
>   otherwise the display does not show up.
> - In functions s6e88a0_ams427ap24_on() and s6e88a0_ams427ap24_off()
>   changed DSI commands to multi context and used "accum_err" returns.
> - In functions s6e88a0_ams427ap24_on() and s6e88a0_ams427ap24_off() repla=
ced
>   msleep() by mipi_dsi_msleep().
> - The function s6e88a0_ams427ap24_get_modes() was changed to make use of
>   drm_connector_helper_get_modes_fixed(). This also required to include
>   drm/drm_probe_helper.h.
> - In function s6e88a0_ams427ap24_probe() registring the regulators was ch=
anged
>   to devm_regulator_bulk_get_const(). This required to change supplies in=
 struct
>   s6e88a0_ams427ap24 to a pointer.
> - Removed bool "prepared" from struct s6e88a0_ams427ap24 and according pa=
rts in
>   functions s6e88a0_ams427ap24_prepare() and s6e88a0_ams427ap24_unprepare=
().
> - Removed include <linux/of.h>, it's not needed.
> - Added comments to the mipi_dsi_dcs_write_seq_multi() lines in function
>   s6e88a0_ams427ap24_on().
>
> [1] https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-gener=
ator
> [2] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/video/msm/mdss/samsung/S6E88A0_AMS427AP24/dsi_panel_S6E88A0_AMS427AP=
24_qhd_octa_video.dtsi
>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Comments instead of #defines?

OK then, it's readable too.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

