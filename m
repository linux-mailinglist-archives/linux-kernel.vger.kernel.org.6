Return-Path: <linux-kernel+bounces-240007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581359267DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141DF28A1E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FAA187567;
	Wed,  3 Jul 2024 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Vg38uojI"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D571862A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030310; cv=none; b=sdq/pZKJOFog1/dh2rbpXWnUskN5zErhI+t3sCrEB/c9bhBKixBPCxMiuNtrLdbPxuOTD7qmdwFeakiW8IR5ZBD5OR4kGVL40AX9bQ9JPDLwNWkdhVZAYYFar5Z3WqDaMN8hTxj3rKnGNrhXYHPkc39bEPpmBf7CE2UO/K2JsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030310; c=relaxed/simple;
	bh=jWXm5HXtzueAdOKs0xkvy0vrctXsPXlYa1NTbuL8g2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGVLdSa6uh9R01mTNgq8WzoNkNxA0jpiNbu2Qu1LHE0ghyQL44c/6kWa/XgC0aqvT79nGCaX+QGYB7k2FstiSi0k0OGUspV/9YqtxTn+eB7JXw8pvqV11xrfCxCpC3OpZOtkGTnyyjqf8JMcZl/xTUHhvb4g3cZCKbiUrhM7csg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Vg38uojI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4257a390a4eso31782425e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720030305; x=1720635105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kBFfRtBXCq9sa5mQ7/2X3hV4yzjNzYCR4JfLOEXbOQ=;
        b=Vg38uojIkMxSSdm9JsrvkHn6xfHJzBYRR/lXSJqlE5NFUUShcDzV7S4K2tHPTQaF/h
         Xav27pnZim9poviIcQECwbxrxcl0teOI/RpOuCib1r+Z6P8iSYkXojdUNenZ0YzaI9NE
         zzu7C16ZuIc80xxqck4TSCcJLZTb9ulXougxwxGxEbt92aTDhiqHQfio9ikCtZ+lkpiF
         s2b5bCOCeSYRnRRYUhlxVJoUWyLT1DJ5XbMMrIjWn2IxKV7JhgPodCG0B3yVEBL+XOsT
         thOSXeQb2YxMSBswrjCIHDlADMa223B6T4mn6FpIkqcynZhPO+rnF8njFLMj3YaZCi2Q
         fKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030305; x=1720635105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kBFfRtBXCq9sa5mQ7/2X3hV4yzjNzYCR4JfLOEXbOQ=;
        b=HrqEOb/p5hyMo3nb77wwR8fr6GmLSUDv3wnLx9COCiJSpq6ma4jdUJaCDMTdeDBQSJ
         XFnZVWOWZGhkClGZk3+tBJrJQ2RVYW1LoOIERcsOqmByiiRTHCv79R2RXEHB3ID59uoG
         l0s+BNJWJrfvhVAqpsnCHx7QVtk7gKZkraA2az3g6i8LaHdGd2lDbjajjH9l5SK0dmVw
         NFuX4MJbKrvsIRXqZ3DxtYV2NI2yEzm9W1B+dBaGjT8V+8A8CuBE7KaqE4PgJSXsxxRA
         pe49C7FBpbaYUWpVycyNEUkj5D/7GVdkdHBGhlS0BeAAhaAcMCqmioggeELRJEOVdPZT
         xYUg==
X-Forwarded-Encrypted: i=1; AJvYcCVwGAX4i16w0eEhGsdVFINq00uILx3KIEpspq3RbT4SYFi2cvoghRrfZIDFoiE7suF1ezuFDACeRWedwRSXuiFFM7ulP1tzxvWtsjxU
X-Gm-Message-State: AOJu0YylwctB3sIulfyxBOWjolZcyDhBlk8fxtHR26ciCm/xeAKy0Blw
	PF/vfrcKzCTukU44meIs65qffi+01us1FuaMwIXzf6K3CpJr3OcerSlDKbaENvs=
X-Google-Smtp-Source: AGHT+IHM+xqXXphyV0243nkSSyEh8redY5/z5ZwzWVJUApzS2y/iFov786LLxvohO46F5A7aYXHiYw==
X-Received: by 2002:a05:600c:22cb:b0:424:a48f:4fe0 with SMTP id 5b1f17b1804b1-4257a02122amr89775755e9.26.1720030305343;
        Wed, 03 Jul 2024 11:11:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm255295965e9.9.2024.07.03.11.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:11:44 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/4] net: phy: aquantia: enable support for aqr115c
Date: Wed,  3 Jul 2024 20:11:27 +0200
Message-ID: <20240703181132.28374-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This series addesses two issues with the aqr115c PHY on Qualcomm
sa8775p-ride-r3 board and adds support for this PHY to the aquantia driver.

While the manufacturer calls the 2.5G PHY mode OCSGMII, we reuse the existing
2500BASEX mode in the kernel to avoid extending the uAPI.

It took me a while to resend because I noticed an issue with the PHY coming
out of suspend with no possible interfaces listed and tracked it to the
GLOBAL_CFG registers for different modes returning 0. A workaround has been
added to the series. Unfortunately the HPG doesn't mention a proper way of
doing it or even mention any such issue at all.

Changes since v2:
- add a patch that addresses an issue with GLOBAL_CFG registers returning 0
- reuse aqr113c_config_init() for aqr115c
- improve commit messages, give more details on the 2500BASEX mode reuse
Link to v2: https://lore.kernel.org/lkml/Zn4Nq1QvhjAUaogb@makrotopia.org/T/

Changes since v1:
- split out the PHY patches into their own series
- don't introduce new mode (OCSGMII) but use existing 2500BASEX instead
- split the wait-for-FW patch into two: one renaming and exporting the
  relevant function and the second using it before checking the FW ID
Link to v1: https://lore.kernel.org/linux-arm-kernel/20240619184550.34524-1-brgl@bgdev.pl/T/

Bartosz Golaszewski (4):
  net: phy: aquantia: rename and export aqr107_wait_reset_complete()
  net: phy: aquantia: wait for FW reset before checking the vendor ID
  net: phy: aquantia: wait for the GLOBAL_CFG to start returning real
    values
  net: phy: aquantia: add support for aqr115c

 drivers/net/phy/aquantia/aquantia.h          |  1 +
 drivers/net/phy/aquantia/aquantia_firmware.c |  4 ++
 drivers/net/phy/aquantia/aquantia_main.c     | 40 ++++++++++++++++++--
 3 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.43.0


