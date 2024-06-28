Return-Path: <linux-kernel+bounces-233351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B591B5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BCD1C226FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6A72BCF5;
	Fri, 28 Jun 2024 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR/dammC"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E178182;
	Fri, 28 Jun 2024 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719551460; cv=none; b=frCP6Y81L0psiSHV3VoxCLAjmi8IAA7genTJ3kyEkWUQV+RXUtseFcrTA4b2KpQpx8RO5eRP6fFC8LobXwH1Xm2U7AnLQLa8poIz69IMWdXO4D+vzAYOxMIS9fZzvEAAJJ1rAuJ9n8O2D43gtlXoQs8erjDrBB1+MZI+2p5B99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719551460; c=relaxed/simple;
	bh=b81UiFGaLy/MZV2n16kv7Qt/YzZaFowtduRwojJ9x8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAzSxQyx4oTS/HcxZ2bngvV++RuiILnBstk1bCuWvVSuHzzxpi4qWb2dvleNQsU5XEx/uuZoPrewRrp/r/0l9GVivoYPKFx+pol/Q9MvyeZv8lRn4az8x2bf7xNhDovcnwwZy0/SsrJ0WK9Jjp4tCMjOspZ1fBkhnukGI1jbK7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR/dammC; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-701ef9594a2so139489a34.3;
        Thu, 27 Jun 2024 22:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719551458; x=1720156258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZOviDQs/MBQD8ld1vhQDebgxIDzTBqHnA9k/ikra64=;
        b=hR/dammCGwsSClp+jbWgmZtC2L31J1WcC9yNxwDi0kIk7IvqUEWQIy/pAXa9oM3g/I
         RAI0iwToywATnjjmQBO5dAy33tyx5o/GObLqUT4UTkJCFe/oF1aavRKV+HhvXq5A/LdM
         W6dJLkzPdjEChz0FJgzXdPnXMaSDWHTbOJW0MHnZEcYgXN0TGD5YNePvZS+kLZhOIWC/
         gWs/NPpiG2T6axgNs3eZGIFxhMBI+zs8ppu/zxSBUBh4XCpJHy22w6StvBj4YSfzZxPJ
         V9ECMfD2WKPBSd2/gHK5YvY0dAVRmAmd5P2KzqVl+zXykhQrWwJNptRHaK8/3jnmeMz3
         E+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719551458; x=1720156258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZOviDQs/MBQD8ld1vhQDebgxIDzTBqHnA9k/ikra64=;
        b=P0e4Ln/NhAMppmd1OuqYnVRjTrxH6zBvpQ+zJ/aY5zpVAmXBGMPny9X0q5o5dxdqLS
         RQd8s4J4A2ZXl6vb482LBloJwe2fMYekSbQ6Nla1sXbcquRP7kydYiyAb7CwMJFnC7dA
         Pw9MFjst1p19iWWu03fPjLv8z9WykKTyYdGBcSQ8kRgYKMZlaIM3FhWHv/h9luquDX4R
         oOzfPX0RCIWQxzLg6CEipnp4BhWzk/r1rrVsr7umvUVTA5MP8U79kk/XEtWDEmpKtYJ/
         RJedFMPJDVr8Ldxuej+GB2Ux+mDbOhJjosbpr7bYpzO9smhAsUXdLecU5Z0GVso8HpLl
         puzA==
X-Forwarded-Encrypted: i=1; AJvYcCXpoY8qU2+OLqsiQ5oUzHYYz0MJlvBh7kmEsTZb4/gvYlP1VGESrSRWdFNivPKsMzfHCW+3JDlNKEBCZRIdX8JtpW/DsvI5oy+7JQ==
X-Gm-Message-State: AOJu0Yz3nJpIQO67+Hns8yWOhyRK2YLh8YEMmdBt+I8NExHn6N3wznmW
	qzVEhKs4yIrDi5hrzrz+xBkUR8gf3XK0MgeG4NFU/GtuYmqQk89fQ8vMnYWy/xM=
X-Google-Smtp-Source: AGHT+IEM3bDBrt30alpajKkos/IxGqPZ7xRkmoOjUEHyZ4phZitXVg3133+I0ub4CXr8Kt4EtjoiEQ==
X-Received: by 2002:a05:6871:588f:b0:254:b0b0:9335 with SMTP id 586e51a60fabf-25d016e7c2cmr15937221fac.33.1719551458463;
        Thu, 27 Jun 2024 22:10:58 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804893e4bsm624716b3a.184.2024.06.27.22.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 22:10:57 -0700 (PDT)
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
Subject: [PATCH v2 0/3] drm/panel: st7701: Add Anbernic RG28XX panel support
Date: Fri, 28 Jun 2024 14:10:14 +0900
Message-ID: <20240628051019.975172-1-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the display panel of the Anbernic RG28XX, a handheld
gaming device from Anbernic.

This panel is driven by a variant of the ST7701 driver IC internally,
and is connected via an RGB parallel interface for image transmission and
an SPI interface for configuration.

Since the current panel driver for the ST7701 variants only supports MIPI
DSI as the configuration interface, add support for SPI as well.

v2:
  - Update dt-bindings
  - Rename DSI_CMD* macros to ST7701_CMD*
  - Rename ST7701_DSI macro to ST7701_WRITE
  - Fix incorrect dev_err_probe() usage
  - Remove GPIOD_FLAGS_BIT_NONEXCLUSIVE flag
  - Remove st7701_remove() and st7701_spi_remove()
  - Call drm_panel_disable() and drm_panel_unprepare() on cleanup

Hironori KIKUCHI (3):
  dt-bindings: display: st7701: Add Anbernic RG28XX panel
  drm/panel: st7701: Add support for SPI for configuration
  drm/panel: st7701: Add Anbernic RG28XX panel support

 .../display/panel/sitronix,st7701.yaml        |   69 +-
 drivers/gpu/drm/panel/Kconfig                 |    2 +
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 1074 ++++++++++-------
 3 files changed, 732 insertions(+), 413 deletions(-)

-- 
2.45.2


