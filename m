Return-Path: <linux-kernel+bounces-240017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506939267EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC02B25745
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185EE1862BA;
	Wed,  3 Jul 2024 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R5qskGcP"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067A186E33
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030509; cv=none; b=GTpRHilgPrsS/YJk/ZSbLQceXlzkjEEwywqP9LPRG0CVgskQsQG0DA6mUGIZxJh1Dh8WiQ3isGjx2HLPt1uYzhSiG7bmYsszT/GvpEJvC+pRvlkBGHG+CZa2Z0nPQAF0JK01rmehdWr7aJpCDq4qevwIgSGDr8Q2+Il5r9N2bjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030509; c=relaxed/simple;
	bh=5w0rmOxDyTDGXnUFXKzhdRIw+XWWxtkh3O1pqRnHB/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MsQt+AGfMlYJ8V4BUvmCue/CnFmPKVy/qfRlqKLdeXQgRup+JiytVs0gmFjihBhbbisT5B0ZfKCI1JTdcgdx2kO7yG8SoT3DLOX9dZHgzO9uZjp0riR2RynD70N4iIu16Z92Z8gQ3bVfPwYL5jhObY1vwVoCWwB9opTLtgV0Ga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R5qskGcP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-424ad991c1cso50716555e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720030506; x=1720635306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZbbSn7dO/LHkMEuGVIUAESb1k8ru9Rr/nw1cfojTtc=;
        b=R5qskGcPeg3Z3N+2YA71vYISetWyMJIQQUSUfjNBvb1hytC1irK3edjnDW39qXCVdG
         2xdGmQh0rNsyS9/QAR3/ozNWDd8Nx/9tWuVdHc+bn8a5huZptHXgsl3cjMHXy9+i/E21
         SId1UuF+jW8iiGnB3W2O9iW4iSCpnc+feGdXjteNk0PwLDK8TIN88TN00hXMhf0MbSRY
         WvwvxF7PXDOxRtFjQtc9zwHFnQiYH/9msQCio4VfvWRB5+HiW3XjT7PkHIvIhCV4u7Nw
         x8NyKP/CfPckZrg2vSy6MEGQ2WGh5CB2dFvmZaJCVNvAgDA4wqr286jxWanxpomtRTKm
         u3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030506; x=1720635306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZbbSn7dO/LHkMEuGVIUAESb1k8ru9Rr/nw1cfojTtc=;
        b=NVXQL2hqTUyZ2kxIxMIZOOJxVg18+9aHYM5jaEOkIA5P13ukaQWZ5anRq5oiQisJzr
         AdH04Gcbg8C9Zsb6stWEQ9quaQMKv8J05b7Ai6QWAcI0myoF+um6zIV7Wvpd/qfxOoih
         7GgNcTj79bJaNvC9tpJNWVvIFHbrhvaOa9WqpozW8HNgdBnasloyZVcL73R6sm6jNUXu
         N6iAWNRUwEQF4HR45hrXb0aJNs1g0470BSw0HxYMhaGdJHG1luwM4R2wqhqwTgw/Pddt
         WiKKs28mxmJy+zyzfKomeD/mabj7OFyoLP6KVsYcboSFxqv1FGYDb04djHlxM2QVA8yc
         U88A==
X-Forwarded-Encrypted: i=1; AJvYcCWd7sw0nSrBiF0W8GJiFe+PenMkuMyTwHSaYvATdjx6siiVpRu9HI5/sKBCcyVwavwdD4FfPpauinVDQM6ORCKy+s7W4Z1KQpKP6eLO
X-Gm-Message-State: AOJu0YzSLS2/W/OHhpy3PJK5w2h3WfogAKZnAnKOVFdGZxUbJTGGvM89
	LZvR2gHcUiPXHd65zqo0f4q6nwuCvgHCeVi8zBOQFAmh2NXeL3Us+RTqCmDAQV4=
X-Google-Smtp-Source: AGHT+IHA959VcQ8zkd43QwM/hU+7N7JRWUGVEs+OSBw7vjjt+p+1E1CwFCIhhJ7Up42Xt55D1kCxtw==
X-Received: by 2002:a05:600c:3286:b0:425:6927:5f4e with SMTP id 5b1f17b1804b1-4257a0270d5mr108482685e9.37.1720030506233;
        Wed, 03 Jul 2024 11:15:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f26sm245178845e9.39.2024.07.03.11.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:15:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v3 0/2] net: stmmac: qcom-ethqos: enable 2.5G ethernet on sa8775p-ride
Date: Wed,  3 Jul 2024 20:14:57 +0200
Message-ID: <20240703181500.28491-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are the changes required to enable 2.5G ethernet on sa8775p-ride.
As advised by Andrew Lunn and Russell King, I am reusing the existing
stmmac infrastructure to enable the SGMII loopback and so I dropped the
patches adding new callbacks to the driver core. I also added more
details to the commit message and made sure the workaround is only
enabled on Rev 3 of the board (with AQR115C PHY). Also: dropped any
mentions of the OCSGMII mode.

Changes since v2:
- only apply the SGMII loopback quirk on Rev 3 of the sa8775p-ride board
- extend the commit message in patch 2 to explain the situation in detail
Link to v2: https://lore.kernel.org/netdev/20240627113948.25358-1-brgl@bgdev.pl/

Changes since v1:
- split out the stmmac patches into their own series
- don't add new callbacks to the stmmac core, reuse existing
  infrastructure instead
- don't try to add a new PHY mode (OCSGMII) but reuse 2500BASEX instead
Link to v1: https://lore.kernel.org/linux-arm-kernel/20240619184550.34524-1-brgl@bgdev.pl/T/

Bartosz Golaszewski (2):
  net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode
  net: stmmac: qcom-ethqos: enable SGMII loopback during DMA reset on
    sa8775p-ride-r3

 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.43.0


