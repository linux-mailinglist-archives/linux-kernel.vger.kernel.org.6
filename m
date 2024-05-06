Return-Path: <linux-kernel+bounces-169378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6135D8BC7D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4EB28166A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BE34EB3A;
	Mon,  6 May 2024 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2WWWVpx"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6845948
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978203; cv=none; b=XiAy6acVdy01bR4pXiHgCQv5rAotWhDgew9oH/nyMwl1vVsn/0N4BBAWzgPjNbeC7sf2SaiLm0AqTUALVcu8Qic5VZEBsM2Y/TShM1vGnXd+8Faob6aLWZKzd143LB60+/YEbo6YVDsKZ/T4k9IW1aBbx26TpmP8xcjOCb953AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978203; c=relaxed/simple;
	bh=bD8zr9K3TvpMI07CepCgahiM+TM9JI1lwjNTMLU3tPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRBWW9zKuzNdREQcR8hhbZx0scqLuoSLYR9l+JA7ZkJ7Jca2Wa3nD7GWhT7OzP7HqVZgZF1JNTzT/acqKItVRA/ryq2y3EvFiR4frapRp6MLrLIyPNQzOqNDZY79Te7dN9YXRM5uJhA1aGFd6USdnHxzWg+jMWa2Azn1fIzhh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E2WWWVpx; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de610800da0so1456503276.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714978201; x=1715583001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD8zr9K3TvpMI07CepCgahiM+TM9JI1lwjNTMLU3tPI=;
        b=E2WWWVpx2XjL10XHxbEvptyEpSpDXMMIij/U8utL1OQul/AEU3iV8XDXUJ7Oqkdfr0
         BdXK4TV0qlAmDqjHAzxk0pblekLA/eyqskmV9X2W89cx8lNCc05wb42LV9rOMvuZAQX7
         7BRhRpzfsPgZS87C/Sumwo9NZ8Nd2pDyYomF+5S2H0qGvHfUVghI2WYfrn7tSlraurfM
         Ti+wVY8Vtk/TvrnXQ2YtO2xsMr6AXYawHndTnN4LXb18LaooQDc7Ja8YpizYqUVV/T/x
         BeKJLrDwT8rql4bTzN2RbcEfKF+0JCY62iKBfaKRW9W1qa5t84ThU4MEIVmUTmJBcwix
         9xkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714978201; x=1715583001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bD8zr9K3TvpMI07CepCgahiM+TM9JI1lwjNTMLU3tPI=;
        b=HIsTYdJE5ULYHinuYu7AYlW6GltAd9S7y8earAOmZh/2Qa4ox9DWsNxOiipTWp1Y0z
         ydHeMKiekavPD5ZzFSml4s7JbL0RkPLIZvpk3YlThMjgnNyD1cUfNyXm+UDgRRzEkG22
         UVPJOb6DuQjkmsdT0npUgPPGrbQAXmIHt6Z0Bpsc5FTKFnCn0fE+jSM6SFz9Kf6P+hOz
         6hzGNqQmnEUERc3yZgMlGNnaAAa2WuHDmL9K9lDOnYYMDkdqsf989XCjuVByyG/+X+xx
         yeHcPN3X6bB/aDf31foRzJ1OHxcKs4xr5LJlRmaI6yRw6aUspq2g6WcvWcUbHg8Pi0fj
         dsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq+Qa6WMzw/H/rKjpQW0KAZ3eGIhxbr48kgsuDETVmRcUdooyFyFNpatQDAS99FlBi9HuEdPunQ5j+/ltUA4x9xE7pd4NRgUqwYMAg
X-Gm-Message-State: AOJu0YyVYknrIJBghsFBnYrSrfSDVhCVM33mYhuXUNEmPeiI8swWwhEh
	KyAUZUL1/0MUIlbvQbIdsj816EkxIUcpmRVUiwfZFMau4gp/U4TzQpxL87pSbYPkfshvS0Uv9xT
	tq7UuEs4CksIWoP1w28TKE6IY2EugI7dnhwvenQ==
X-Google-Smtp-Source: AGHT+IHaOyjFlq8XYx41Cxil96IUw2lta8RtC1Merd60dXgYHJ/wvReVZXQGPD4L8MA4Mt3mUEcy6sSY/kYNmU9PLRc=
X-Received: by 2002:a25:804b:0:b0:de4:64eb:8607 with SMTP id
 a11-20020a25804b000000b00de464eb8607mr9454277ybn.32.1714978201293; Sun, 05
 May 2024 23:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503213441.177109-1-dianders@chromium.org> <20240503143327.RFT.v2.47.I2513fd6824929a17c1ccd18a797b98a1a1063559@changeid>
In-Reply-To: <20240503143327.RFT.v2.47.I2513fd6824929a17c1ccd18a797b98a1a1063559@changeid>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 May 2024 08:49:50 +0200
Message-ID: <CACRpkdajJ0dkSm7uE=YN5B90tdE_GzczMRxO7eaNWuZLVzP_eg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 47/48] drm/panel: sony-acx565akm: Don't call
 disable at remove
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:38=E2=80=AFPM Douglas Anderson <dianders@chromium=
org> wrote:

> It's the responsibility of a correctly written DRM modeset driver to
> call drm_atomic_helper_shutdown() at shutdown time and that should be
> disabling / unpreparing the panel if needed. Panel drivers shouldn't
> be calling these functions themselves.
>
> A recent effort was made to fix as many DRM modeset drivers as
> possible [1] [2] [3] and most drivers are fixed now.
>
> A grep through mainline for compatible strings used by this driver
> indicates that it is used by TI OMAP boards. The TI OMAP driver
> appears to be correctly calling drm_atomic_helper_shutdown() so we can
> remove the calls.
>
> [1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.o=
rg
> [2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.o=
rg
> [3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.=
org
>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

