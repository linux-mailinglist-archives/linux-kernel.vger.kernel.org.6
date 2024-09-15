Return-Path: <linux-kernel+bounces-330014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A853979874
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C46B21B85
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254021C9EC8;
	Sun, 15 Sep 2024 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WDEigjxB"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4181B85D9
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726428886; cv=none; b=Kc1YS5bt48kET8bBBY/waoEjcFBJCttB+mrcIDN1cGX5ynuozKXgbu+xyRY7HwGHxlHpcg4jKUnCsq5y/JHpHxChsVXXT6LM/cGNMPAGMw6pi9HrJUiboKlWOQOsVdeTYVAoDHtcqqvYyzhdwH+ltjQUerzpktkIgoQ5w+si3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726428886; c=relaxed/simple;
	bh=/SVCM+wOJnBBA1H4/wm78Nu8sNDdpCzn02Rw3G34Qqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCmkT/KIZvAeP8Nh15CrIiJ84qR8kE1XRfgOCL6Ai4ZtQzPHOOyfQzmLw0KHtOEBthDGfMPb+n717Sss4Lf3x9tS+/EFQ+LYsMM9Ls7GF/BvYS/vl40Sx+laFF3DjK7+250TSqQVnozbIOpRacBHYe/BmF5M6dEPH3iW/NJZJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WDEigjxB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201d5af11a4so42310965ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 12:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726428884; x=1727033684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRpxdaFIHzOzVsYksVQ0yHwIyLAz6RoLwdsQAhW66Vo=;
        b=WDEigjxBCcUK8iSsACbkq5D2H44Gxv9bPDiv+K6ap+pxqOFM8UKoSFlRUD8zARxYRt
         LEmrjKRZH0JZu6GXubyUD9n2TxINLBLWXzX4gdgCWydCZvIu+BTrUDMVg6LFOzY6Yewu
         Z+pEFNslxHFoZXNOnlQDMffhGxAxieMkeGBfRzFD4+o2ju3SPSa1lNE0qZoTX6+OS9i/
         +XnofZ2zrO5mJO+b66YsoJD0U/oday/u1Sdb9GVJQNpd3ZsItwHMQuLkP2Jnt7UAu6lZ
         XvgwSjlokLnOD+p1rcx0UArYkOX9y6pXDgxBZB/iFcxMSWHeOfaEdSeU1seQlyB8SR44
         JL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726428884; x=1727033684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRpxdaFIHzOzVsYksVQ0yHwIyLAz6RoLwdsQAhW66Vo=;
        b=Ra+XWyPKbN8mS0/49AJETY0NF8aUz5SeLrMHw+kbyXHRU77qHPG3Besw63fIAcExWU
         bjbDt3H0SYWVj6yaTSL3K8XJJGXlei+W44Hcmqt08HoBex9gjfYT58bRYL48rLOYxJBq
         h8olNQxxIotjGkt+D83Nm2p1kmSMHwY4byhBo2rLLBI2OUCo0eFdORc3emEsZmR5iP1S
         x4HaE1qLFNVKYRxCnDg9k1VeolQPeVmWoZ0Hv31k9ljFcTc0E0goVlzALNZuuZxgTW5J
         pW95exTriOAl5mDr40HC/o7ejDaSw7oqjADQXRmkVvv/Kgl+blVD6gc0gzbkF0MnYg7q
         S4YA==
X-Forwarded-Encrypted: i=1; AJvYcCU7WdGg85MhMjrxdrOTI/TiyWBJQt9GrJSG1/QqpBRfO3aWc7C5lnqKaeR8Ulo279msH6dCmNcJNzSXH0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXU0ITodhxak1bkgsq0+dL/Z/YUqH2dO5mZvy94ZehWqJosmsR
	hvr1pDotETzkMtVi+3cwGj6/RTIzZsqn2gUVNsPRHmvZS2E4dGzH46cOHDlLZHki8LaPLAML5b/
	TmcKKaH2wisGarMmvT3ZGJVDgFhI=
X-Google-Smtp-Source: AGHT+IEwWAUsKsReKqUwRX6bFUHcxg5LdPrAbDWpBlNKgtnCiuqZNg9QIOcYa1yarrAewo3Icr/xRF2g9uLNksk5XsM=
X-Received: by 2002:a17:902:ecc4:b0:202:508c:b598 with SMTP id
 d9443c01a7336-2076e447f9cmr210991925ad.59.1726428884437; Sun, 15 Sep 2024
 12:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org> <20240908-regmap-config-const-v1-1-28f349004811@linaro.org>
In-Reply-To: <20240908-regmap-config-const-v1-1-28f349004811@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 15 Sep 2024 21:34:33 +0200
Message-ID: <CAFBinCB=4MtDSc94N-ijgjd0T6-O9pe26Wg+B44miX=iY1vmow@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/meson: drop unused staitc dw_hdmi_dwc_write_bits
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 4:21=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> static inline dw_hdmi_dwc_write_bits() function is not used at all:
>
>   drivers/gpu/drm/meson/meson_dw_hdmi.c:276:20: error: unused function 'd=
w_hdmi_dwc_write_bits' [-Werror,-Wunused-function]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

maybe s/staitc/static/ can be applied to $SUBJECT when applying this patch


Best regards,
Martin

