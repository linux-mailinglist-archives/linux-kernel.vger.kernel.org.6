Return-Path: <linux-kernel+bounces-374379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDD19A694F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8331F2541B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6311F7062;
	Mon, 21 Oct 2024 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+wpsMut"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C251E7C05
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515546; cv=none; b=oAQ2gv6LhwqV0DHDUSGcDZb0bNEdv1nd0MA87JjDuL2dUOvAT2tPVbAWSrzuwwsaPGw7vbL/wT2Bdg75Czs2agKRv228YAT+9fnqxTgEpdL1LSQYGwUo0PTHB1RRRaLBGm7gWur3/gasyzTkP1G/Kodz3STVNOLsih8AUjSASeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515546; c=relaxed/simple;
	bh=t7oceQtuD7b5kafw/zgnqa4STZhy9h9v38YbyMLJMqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q0MlYuaTPVoWFUbPt1AmVOHZUQ7zs6Z8MWld/+YOZMDNTXL93m1thw6PKfWGZ4Xh9/Hte60b/f+6DPd7DNI+327FtOHBvQ5BinKYuaMQbxuTj6Dwm6PUgMCLK7AbGwmGRJV2ZZsWuzUCHSO7ZVM5bMsCe1U4V8XOk7jMIXCY0EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+wpsMut; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43169902057so20005185e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729515542; x=1730120342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W4u+QtS4UNkEr65DGOIEiZitFsgZAiIfJ/DctJiwRs=;
        b=G+wpsMutjAf4z2K5CvVJXJBviVY9A239s24lkJ38Y37lTpu2yD1+5xFp1kiHmfJjvp
         E48ylVF+1I/j+y9ZmpMb7i6Re4APLTGL6qmiWbCSTJMt/Kfll1Pn25ibaPHpYnXhJadG
         75qVVX0pHMK80MFpTJ4Voz2WXigrrRLP/JEKPETKNrzQe0YX79RAkA99tylvpuoN2CdC
         9ZpyUBl9L3DOSp/ERvuFj7+K9NYJXnCeC489TygNXdRPSrQt4AU+2//dF7SR4FygfibJ
         jqIpUpRUAYoURZDyMgq7XwIj4iIgwmeGERoYWcfRXbzrx+QTiwIW+K+qexM8qVNWYBZU
         DMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515542; x=1730120342;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0W4u+QtS4UNkEr65DGOIEiZitFsgZAiIfJ/DctJiwRs=;
        b=kwjodbWRi4sepf4czMmVAcpOFuhatiuAhnn0ac/CY9fjUrnyQlG1OLULPbbb94u5sf
         inxqsHCwHtiOPdyUoIsB1+FtVc+Hfm1PlZzauFnVVaFQHmHj1EBCF4F7AQr3tDzzJlRf
         fx/o3tDvQJgVb/ahnn/bPRD7J3WGtV9hsPIY5tbUQ4+t06lGm6APA6/A99qPxc2W8zOW
         FHtQwMXg8C1ExtZigi4d+8zAE/LNApPdDlDEB7uedzb1+nBnBCA1Fn/Cpr/5KCLdXqBP
         eikcbFcU2Mr8EIuSGvmdZGnCwcPK0/K7apKUGbeUEGos2eOEW1LPFz+9mzAfS0FH8nd7
         Ximg==
X-Forwarded-Encrypted: i=1; AJvYcCVFyR+rV5FhWRy7DP0Fok0m3bSaMvXrGDY38Wtt1OMZfbN68sNhmQflM+SbU2xKxtaQLpnpFy0IgJbW0QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynMN+cR0+aTEpRB6llftqRMrB972By5y39/Grq1fZ5kBRwGAd8
	Sb3t0HOp/u90O08qKEMs9LPBX8w7soeUH1Hkv1G03sdawb10LpfWvpI8051rMuFAeoFru0Pj6C9
	7Bk4=
X-Google-Smtp-Source: AGHT+IH04j80oL9ouXTZKR+04j2kFDZL0aYwGPdMMYjCKFcqtXA5i8kcVtQSqWhMcA827fSFGcOcew==
X-Received: by 2002:a05:600c:3151:b0:431:6060:8b22 with SMTP id 5b1f17b1804b1-43161641a62mr89150865e9.10.1729515542557;
        Mon, 21 Oct 2024 05:59:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc4dfsm57452995e9.45.2024.10.21.05.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:59:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
References: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
Subject: Re: (subset) [PATCH 0/5] drm: misc: few simple cleanups
Message-Id: <172951554139.1240386.5313614669791374928.b4-ty@linaro.org>
Date: Mon, 21 Oct 2024 14:59:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Sun, 08 Sep 2024 16:21:30 +0200, Krzysztof Kozlowski wrote:
> No dependencies, trivial patches.
> 
> Best regards,
> Krzysztof
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/5] drm/meson: drop unused staitc dw_hdmi_dwc_write_bits
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d9c12481f980bdad9cf6fdb742e49c5b50622795
[2/5] drm/meson: constify regmap_config
      (no commit info)
[5/5] drm/bridge: ti-dlpc3433: constify regmap_config
      (no commit info)

-- 
Neil


