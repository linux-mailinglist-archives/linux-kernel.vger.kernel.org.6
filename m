Return-Path: <linux-kernel+bounces-271816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0DA94538F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7DC1F2407E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE17314A627;
	Thu,  1 Aug 2024 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i7W93GH4"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F613C832
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542082; cv=none; b=l7Jkgv0qsRZV8PGBjmeCADzWfCr/G0NmNxoAW2cWCgXAYVAJ7BcNDfosr5xj2HcuYcRXff8PuXEYAKy5FMQOEy5cjZsFMiRE7Q3wTWSBFX5vQ0euncKlBcDi2MYB64pjkamDlc0LoC6yA4JrkffylCBmTt6g6kVd2oKe02uoudQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542082; c=relaxed/simple;
	bh=mSSGw7ztU00kMeYnSQs/MwnrLbJC4sI9NqZPJ6lOZ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8/oU1TFcs8qpd2QaWF1rmAZZcIf09LvldDK4IOxpYVTwXPUgEAqPejEp+7bOFZ176zXhfGIG39S/CLsgawkULg5ozEgyZ4Wd4tsFhGw5DTF455F43IKY/TClIPOZxWQDgIuUJTZRaE7ZEC948QRN88bZaF1GlWNdvLWOtp+u/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i7W93GH4; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-81f83b14d65so320191039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 12:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722542079; x=1723146879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jyW55qSj/iPHMS0nqqgGxT6hlNq7rzg4SSxLEN7hDfg=;
        b=i7W93GH44AXrjOFyOhDq3Yp1CMFz+tn5r7JI0acxCfgRCyUfmhWtPdxal07khlCGQe
         NeDncftYsF1bEI7dunsVOiCvSnSsqz0JqyZJNdt5nS7CQNiDYA9ebKdXNG3RI8nlzoA5
         ZV/OFT7IDlJREKRahiD8tBrQTxhaeIYRmqOjuQvyY+H4kVi0vEqjoqRkzbdxD1MHdVNA
         8G1r+N49CzpcmDpGH2cV22/GZcKQCUAh+po08Hz5wikfH/kwfsk98bM3WL0FgtAyQv3x
         6UudbwgM4icBdXDwhohxoxwEuH93Fwn7B9Nc/JEy5dxBg43N5/BH5VhhRLpA6nLADxOq
         YFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542079; x=1723146879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyW55qSj/iPHMS0nqqgGxT6hlNq7rzg4SSxLEN7hDfg=;
        b=KZxoJ//Hgwu8ZaarKUE04g5pa9LYTnPaL+7pjXR6DjmYr/NrphbxMCWT/CkS//FRXJ
         0tPS+9+3vhoCbaXA3M5By3xoJpEdTen9fBBVojlTxyLs33iJ23SRKEJvHYgH6F9alh8k
         DrEdykSEw+AK7pUlhwO+JX4PAYAQ2Fxw3fMAcLZd9wRoRTQ0cn54mHyD+vYDttkkBuqR
         Jlp/DhWuH+qlJ23rQvIoINN5EGQeCFTTBhfnFn8RM1xe1bL2kUTS7hKsFnREojEhUJEX
         zeXonCCkSM9BQl3yPBwa1tosthQ2YL87/BVb8Uvl4DJ2kseqLLW/mbezOzbPjYpCf1GW
         5CLg==
X-Forwarded-Encrypted: i=1; AJvYcCU0qvMlcBANJPncuvQQqAcz5JwDZKLa+8XMC4r+R0lXXexTCn9w345Gts70T0vBhce4Cp3ZJr460zBUOsJ3Y5jU1JTNHf5e3r9Wkh9v
X-Gm-Message-State: AOJu0Yz+wEQa+/BcCrJlJz0nT7uldO2Im3xTmXgPwNGzWv2XSaIPwawO
	5pQ0oaoxwTO8TMuGozdJhNxgQkrXccRz1i067SPCgzXEGmqVoh4CLsDARiGeGD8oVBK96akDtAv
	K
X-Google-Smtp-Source: AGHT+IEKV797TyolnkJWg6HMjhoCX7q5kaFe9HOie0hsAeiTC0W9aVdTPL1KTjz4JYdm8mGMQgqIOg==
X-Received: by 2002:a05:6602:27cc:b0:803:83c0:6422 with SMTP id ca18e2360f4ac-81fd435a75bmr175501739f.9.1722542078795;
        Thu, 01 Aug 2024 12:54:38 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d1b7ddsm14395039f.3.2024.08.01.12.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:54:38 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v8 0/3] firmware: ti_sci: Introduce system suspend support
Date: Thu,  1 Aug 2024 21:54:19 +0200
Message-ID: <20240801195422.2296347-1-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Abstract
********

This series introduces necessary ti_sci driver functionality to support
various Suspend-to-RAM modes on TI AM62 family of devices. These Low
Power Modes include Deep Sleep and MCU Only as described in section
"6.2.4 Power Modes" of the AM62x Technical Reference Manual [0].

Summary
*******

This series is a restructuring and rebase of the patch series by
Dave Gerlach [1] and Dhruva Gole [2]. It applies on top of Linux
6.11-rc1.

The kernel triggers entry to Low Power Mode through the mem suspend
transition with the following:

* At the bootloader stage, one is expected to package the TIFS stub
  which then gets pulled into the Tightly coupled memory of the Device Mgr
  (DM) R5 when it starts up. If using U-Boot, then it requires tispl.bin
  to contain the TIFS stub. Refer to ti-u-boot patch [3] for further
  details. The supported firmware version is from TI Processor SDK
  >= 10.00 ie. tag 10.00.04 from ti-linux-firmware [4].

* Use a TF-A binary that supports PSCI_SYSTEM_SUSPEND call. This causes
  system to use PSCI system suspend as last step of mem sleep.

* The firmware requires that the OS sends a TISCI_MSG_PREPARE_SLEEP
  message in order to provide details about suspend, so we must add the
  ability to send this message. We also add the remaining TISCI Low Power
  Mode messages required for inquiring wake reason, enabling I/O
  isolation, and managing LPM constraints as part of a new PM ops. These
  messages are part of the TISCI PM Low Power Mode API [5]. (Patch 1)

* We add support for the TISCI_MSG_QUERY_FW_CAPS message, used to retrieve
  the firmware capabilities of the currently running system firmware [6].
  Sysfw version >= 10.00.04 support LPM_DM_MANAGED capability, where
  Device Mgr firmware now manages which low power mode is chosen. Going
  forward, this is the default configuration supported for TI AM62 family
  of devices. The state chosen by the DM can be influenced by sending
  constraints using the new LPM constraint APIs. (Patch 2)

* Finally, the ti_sci driver must actually send TISCI_MSG_PREPARE_SLEEP
  message to firmware with the above information included, which it
  does during the driver suspend handler when PM_MEM_SUSPEND is the
  determined state being entered. The mode being sent depends on whether
  firmware capabilities have support for LPM_DM_MANAGED feature. Legacy
  firmware or those supporting other modes can extend the mode selection
  logic as needed. (Patch 3)

Testing
*******

This series can for example be tested with a am62a-lp-sk board.

For am62a-lp-sk all usb nodes have to be disabled at the moment (usbss0,
usb0, usbss1 and usb1). There is currently an issue with USB Link Power
Management and turning off the USB device which is being worked on.

Once booted suspend/resume can be tested with rtcwake:
  $ rtcwake -m mem -s 10 -d /dev/rtc0

Make sure /dev/rtc0 corresponds to rtc-ti-k3:
  $ dmesg | grep rtc-ti-k3
  rtc-ti-k3 2b1f0000.rtc: registered as rtc0

Base commit:
************

v6.11-rc1

Changelog:
**********

v8:
- Restructuring of code to include all TISCI PM LPM ops
- Removing malloc related to TIFS Stub as it is managed by DM
- Dropping has_lpm check as suggested by Nishanth
- Using LPM_DM_MANAGED capability for mode selection
- Updating the suspend and resume callback handlers

v7:
- Address Andrew's concerns on SYSFW fw_caps API
- Remove all the unused functions and variables including
  set_io_isolation and wake_reason calls
- use dma_free_attrs
- remove IO isolation related code from linux side,

v6:
- link to v6 [5]
- Loading of FS Stub from linux no longer needed, hence drop that patch,
- Drop 1/6 and 5/6 from the previous series [4].
- Add system suspend resume callbacks which were removed in
commit 9225bcdedf16297a346082e7d23b0e8434aa98ed ("firmware: ti_sci: Use
system_state to determine polling")
- Use IO isolation while putting the system in suspend to RAM

v5:
- Add support (patch 3) for detecting the low power modes (LPM) of the
  FW/SoC with a recently introduced core TISCI_MSG_QUERY_FW_CAPS message.
- Use TISCI_MSG_QUERY_FW_CAPS instead of misusing the
  TISCI_MSG_PREPARE_SLEEP to detect the FW/SoC low power caps (patch 4).
- Take into account the supported LPMs in ti_sci_prepare_system_suspend()
  and handle the case when CONFIG_SUSPEND is not enabled (patch 6) that
  was reported by Roger Quadros and LKP.
- Pick up Rob Herring's "Reviewed-by" tag for the binding patch.

v4:
- Fix checkpacth warnings in patches 2 and 3.
- Drop the links with anchors in patch 2.

v3:
- Fix the compile warnings on 32-bit platforms reported by the kernel
  test robot in patches (3,5).
- Pick up Roger's "Tested-by" tags.

v2:
- Addressed comments received for v1 series [1].
- Updated v1 patch 5 to use pm notifier to avoid firmware loading
  issues.
- Dropped the reserved region requirement and allocate DMA memory
  instead. The reserved region binding patch is also removed.
- Introduce two more TISCI LPM messages that are supported in SysFW.
- Fixes in error handling.

References:
***********

[0] https://www.ti.com/lit/pdf/spruiv7
[1] https://lore.kernel.org/lkml/20220421203659.27853-1-d-gerlach@ti.com
[2] https://lore.kernel.org/lkml/20230804115037.754994-1-d-gole@ti.com
[3] https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2023.04&id=91886b68025c7ad121e62d1fc1fa4601eeb736cd
[4] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/commit/?h=10.00.06&id=193f7d7570583a41ddc50a221e37c32be6be583e
[5] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
[6] https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-msg-query-fw-caps

Dave Gerlach (1):
  firmware: ti_sci: Introduce Power Management Ops

Georgi Vlaev (1):
  firmware: ti_sci: Add support for querying the firmware caps

Vibhore Vardhan (1):
  firmware: ti_sci: Add system suspend and resume call

 drivers/firmware/ti_sci.c              | 438 ++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h              | 137 +++++++-
 include/linux/soc/ti/ti_sci_protocol.h |  46 +++
 3 files changed, 619 insertions(+), 2 deletions(-)

-- 
2.45.2


