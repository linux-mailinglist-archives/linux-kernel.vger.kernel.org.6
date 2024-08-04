Return-Path: <linux-kernel+bounces-273697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335BC946C9A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 08:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EF01C20AB4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 06:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C607D531;
	Sun,  4 Aug 2024 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va2233RB"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021FE3C30;
	Sun,  4 Aug 2024 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722752165; cv=none; b=J8VAsZAVNG34ojFOXf1dUbhGAAbF73o0vgmnpwYaF1iAvZjJFLPGFISNLkZQV56enbxOmzWRNJVcOYP7ieCWsvc7lfmT4vVYJ6catXZ4MVEH/S2VZBQvYW9aFi31EZg45VH/a6Psz34YgLHCN0g7PB10uSc3sB4c2UJJ4q8C4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722752165; c=relaxed/simple;
	bh=jxErJTRtsHFJthGZTc+iqfiRYB5vkGU09kQ+bN0waCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmYlQqVDBMQ/rgZuN9Ts2brimtj1P5PW31yzorZR500dj8QYaHUuoZ5BHRnwPE23niijvzCWgavxLfUm8Cz8A7PC4P1d8bSTRj1dTaFJ+JMN4iek1ucBHE5XMHqkvIhICq3QUj/r/pbq1Xkfpno5OmxAOMwx647RynuJgoSIigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va2233RB; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db130a872fso6605396b6e.2;
        Sat, 03 Aug 2024 23:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722752160; x=1723356960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+PeTNFmfRiiVfdD4fTEqR8T2Gwq0tebxgkS79dVtbw=;
        b=Va2233RB/H6P2SLh6FfJF0iib+AAk/XJVC78NVT6PukqfLkhN+ztcFW4n//46HkeQ1
         frq1zbBUmw3q7JPJfwj5cTcuopGSKwBs0Gi7I45goH7F/35Y0eqDViJqdJ4hs2Tk2tGZ
         SJhuaa9wfTtDCQpRWAnAvYOMsBq3UR05DP52nrh43yU1ecn++lD6Gc0F17kGBuKKLPJp
         cj2yKxzv7Q+Yw6m/xIeNGBVZTVuMcMpAy6LuCEU71UGGFATzIWr3xchR+fL4cnIyt6jN
         p4XI0K4PFYmv2vl03LHu7nYRSeHLGFOf8S2F1lzM300gTVrelFFLA2Z3bIqGCWE+60HB
         TXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722752160; x=1723356960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+PeTNFmfRiiVfdD4fTEqR8T2Gwq0tebxgkS79dVtbw=;
        b=qxAmZXYqyzr0ICRkhMcg+hUBeV/SYF5xaIq89xK4397b/YoOAXQufDZwF5MN11Jnul
         DgsQ1s9MoFEtT/bwe39bQSNnay3akNtWM+GIO8SGWNoF49JcTZd0ieidBBPmRSL3ptPY
         zJ8ozgQrNNXgOmkEy3AF3ch2dRUn+AUXmm/QH1pkrQ8Jx+F8P84wCznR1BBq9ExfOaDK
         DAsqxiJjVaJo9ZJnXtBkleQIOi4361Nr8ZMHI9a41mECwkqTrsjFfyUaNfEdUFylunz+
         SH1b7FqU13E8oqOnY1Ma/aUVpM2nWjNXVlcbDy+bKxtpzqcnuuQp3U9de3wLvZM3aAJC
         F9ow==
X-Forwarded-Encrypted: i=1; AJvYcCXmGPLZ4LIZuGzQKR5sZFtgeTSUx82oIf/FmMYtTqQHr9sDyKWzKymOQblEQPFLM0Flw09TgLm07TepCsW2es3fQOqZy3Lu6FjmqQ==
X-Gm-Message-State: AOJu0YxmIBf1uWXde8DUiDgaCTsv99Bm0AOdVTCDF5ZG6Y3zatmUxwdn
	vWFIlDIDwuFwkTYz+4zgccgtrO3YVjikTTLOa6XCqfPTAbwk7CX9ED8+myHL
X-Google-Smtp-Source: AGHT+IEMOeP1zK3q0PzdphJcoR2q9nwUOvs8Wff6/AmNerTKEGhqJokdQYaqcv/6lU4GTPuPMIwNPg==
X-Received: by 2002:a05:6808:159d:b0:3da:ac85:3bd5 with SMTP id 5614622812f47-3db557ef9bemr11211096b6e.8.1722752160006;
        Sat, 03 Aug 2024 23:16:00 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29ef4sm44194195ad.14.2024.08.03.23.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 23:15:59 -0700 (PDT)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 0/5] drm/panel: st7701: Add Anbernic RG28XX panel support
Date: Sun,  4 Aug 2024 15:14:44 +0900
Message-ID: <20240804061503.881283-1-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the display panel of the Anbernic RG28XX, a handheld
gaming device from Anbernic. "RG28XX" is the actual name of the device.

This panel is driven by a variant of the ST7701 driver IC internally,
and is connected via an RGB parallel interface for image transmission and
an SPI interface for configuration.

Since the current code of the panel driver for ST7701 variants only
supports MIPI DSI as the configuration interface, add support for SPI
as well.

v4:
  - Update a commit message for dt-bindings

v3:
  - Split commits
  - Remove unnecessary changes
  - Change Kconfig dependency and adjust for it
  - Fix incorrect device variable in st7701_get_modes()

v2:
  - Update dt-bindings
  - Rename DSI_CMD* macros to ST7701_CMD*
  - Rename ST7701_DSI macro to ST7701_WRITE
  - Fix incorrect dev_err_probe() usage
  - Remove GPIOD_FLAGS_BIT_NONEXCLUSIVE flag
  - Remove st7701_remove() and st7701_spi_remove()
  - Call drm_panel_disable() and drm_panel_unprepare() on cleanup

Hironori KIKUCHI (5):
  drm/panel: st7701: Rename macros
  drm/panel: st7701: Decouple DSI and DRM parts
  dt-bindings: display: st7701: Add Anbernic RG28XX panel
  drm/panel: st7701: Add support for SPI for configuration
  drm/panel: st7701: Add Anbernic RG28XX panel support

 .../display/panel/sitronix,st7701.yaml        |   69 +-
 drivers/gpu/drm/panel/Kconfig                 |    3 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 1074 ++++++++++-------
 3 files changed, 734 insertions(+), 412 deletions(-)

-- 
2.45.2


