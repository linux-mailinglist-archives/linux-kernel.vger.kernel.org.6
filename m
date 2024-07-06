Return-Path: <linux-kernel+bounces-243149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF08929282
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0941C20E34
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A6061FCE;
	Sat,  6 Jul 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0SVvUcQ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FBF4778B;
	Sat,  6 Jul 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720261455; cv=none; b=gy+MJROPIDYmFjhhrUrpn5gs0B1+QufiaRTHh4wqhCirKE4GI2ujcCW+iTltVNv621xMsNKKev6O+jhQdaqAjVvyxIBlzPhbh47oaxCpWQOj5/fn4+NXe8ITTJiwVyEN79i4xNHYyvj+wEpn8Cw5hMxcfHP3UwFxEhQy3QMV1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720261455; c=relaxed/simple;
	bh=v7fyDVZ4Zen5Kc42NhGyOL1GP4zenYzvdS/sloF7BMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUo6myP0B28IEEKe210Ex37gWm++ezQXoFfe0kxr6DrowTYQgVRAIG/+rUYPbiQ/YMnzhOkjcsiJz/U/M7JYffSC8d6PhzQiI53XJTNCRWhec4RdqV2SFUGjNiB8sbH++Eyd4qQSJBgpprB6ZcgyRFKvzef8EJieCsM6zTzejzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0SVvUcQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f4c7b022f8so16653915ad.1;
        Sat, 06 Jul 2024 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720261453; x=1720866253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wukxN0PIXiJkpvJy8jm2igAsjxWST6oYyCh6lRk67BQ=;
        b=R0SVvUcQkzURDNzAi4GqwLQ471aHL2JCrxUq+53W+ANTgTXwc4HkpiD15iL/d6tbrV
         2b1g7u7gA5sPcVItI9WBFN50Pb+mluIMuWFF1tV2EkAhC/9txo7OB9OtPY66KAhF2NoN
         0zEhQheIon6VwrjK38KcCFDi2qIn8E7nUn/PqBw25hu8M0NhLs3AW4nKGy+Gh0WUKzqO
         auI/9lHGH4Avj29mL6TzP5eHdOPCsfSJjkY3rinyC696emGEi38OZVIDfYso6C2p78Ej
         m32TJmXGzrXXVSshHzbYdGEC3vfZIvTuc6h8mvaSchGpdDEHgh/9e6wQE97Ia5lSF5uX
         Ig/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720261453; x=1720866253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wukxN0PIXiJkpvJy8jm2igAsjxWST6oYyCh6lRk67BQ=;
        b=ix7b3A41B/PjyHkXubWy7aOATth67Rv2B7aYadXNg6pl61Xn0sQiZ6ljvmM01W7lTg
         VizzLU8C3ItOhHtKU0SE1HijK3ZktTg8mKO8ZsvkOCeBd2hp3LsiDl74d9CQuUiv24vl
         ev4CR0HC2ZDpU2C5zp3qsX04K/4sOygU0V4dC5Veg7jMkQBDlpvLydyTKl5RHYvrWS6U
         GAkz/+OfFRG+WP5IhdRHh9NwlnH47Y57mANLWI/BwWO1PcQnFFtNQzkvg0E3HlJrrwnh
         n29Ck/mX4nvBPlStIUJQjqoHpAzIurp61/3pPQ3BI0xUhRR5X2w1Hxn0kbjzlnUn4NK5
         5t/w==
X-Forwarded-Encrypted: i=1; AJvYcCVBfIW2YEqWVDdQn1JZAvkfz1GtRmnsMNa8s4/IIZT/Y8bLbzNEwYR2jYb+Zp01r2oh1Z7hgHyygtcRUUrB/JMM7GAkpIJTbxR5Yw==
X-Gm-Message-State: AOJu0YwHG4kRbY9+WlIHAEg9312spU/A/B7jXYMQYKeTBATfodpA8Wd6
	LeatLe3RysH/lkdok1MAEoBRc22wU1MJl37RZr+6N4d9UGJ4ScZ+aOPJ93wthnk=
X-Google-Smtp-Source: AGHT+IGRVGt0AwBNkvSk99WrI8NjrmtZs3O2g4U++wOVairspqjrDCMDgAyi3brqtmPuxNpVtbT3UQ==
X-Received: by 2002:a17:902:ecc6:b0:1fb:5808:73af with SMTP id d9443c01a7336-1fb5808756fmr27183725ad.61.1720261453365;
        Sat, 06 Jul 2024 03:24:13 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb67e04f64sm9126625ad.214.2024.07.06.03.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 03:24:12 -0700 (PDT)
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
Subject: [PATCH v3 0/5] drm/panel: st7701: Add Anbernic RG28XX panel support
Date: Sat,  6 Jul 2024 19:23:31 +0900
Message-ID: <20240706102338.99231-1-kikuchan98@gmail.com>
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


