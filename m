Return-Path: <linux-kernel+bounces-307630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8075C96509A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEC41C232A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA0B1BAECF;
	Thu, 29 Aug 2024 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bN8JQM3Q"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A928685
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962580; cv=none; b=hix7JITmi48GzOyI9T2P9rG4UlnENTgkiImNEO5jnZHIaNQvQshiuCq0U4gLnE1gd+OE+yvjpzlbztkLSL8UwE5jksnIBqE2gqMLsZVGJgJOHmQHBCqvOVUVpFbksnKuQ8LOgSDBF+WNIzQmKHBFdoYDuQZbXbWVxiicE8jrt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962580; c=relaxed/simple;
	bh=gZjjGJsguQluKqSCK214V0yTjge9AUQiSoaExZpqj6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2rJP8No1L7JkMkIYvJnbqhruUuiNYjsB421zmMxlVOIuGhyd8GG1cTNRGjiKuIEKOxSuiuCbZg37zl3cWRplQmcccyx9QhYxIKJohm/sxgLXxfXrPWQlEhTvUG4xdeB/lhzrttsqhJfT/upkUmJxW9Tkw7BVO/xdjckHhQzQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bN8JQM3Q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37496a92188so699450f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724962575; x=1725567375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7Ev17CQKlTA6DNpzpaUXflqEdapwQabQU/zEUmS19U=;
        b=bN8JQM3QztZIoi/RFl1GLpCrGIrRnJuze1c1lmr5KhGplztrEruXK5S9dR+cHBPXck
         Q54LcN+lQp+2RWQCXe6TSVuzQD/HqyO6NiDIzGvCtbSms7zsRRM2Fvrj3L1nrDhOy5FM
         SQj3LyMABY/hVgx7Oq+MAKk1PQvDtZKeGn2c9ow2kt90MUpq1UaTXhv8AJ9zRMXVN04c
         17Ka/ZzQA4VMRW6CP6UjItPrOTQE5f8GooThb/k+MaXapR4odzKtIeRdAOP6XhBA5wV6
         tzNWpU0cXSYRkE+BxcrkDL7dMRgcB86hJSp/H+CKPpVc7h1njdN1CXS4jUaHXIXUj3aV
         tHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962575; x=1725567375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7Ev17CQKlTA6DNpzpaUXflqEdapwQabQU/zEUmS19U=;
        b=XCLCDAlW+mqAqmv/ulk1r95q7Okj4xdcajdkNzPhGWn7SexP4aesj++3bLZADWFUSo
         szP3VmA5L674wpkPyKKPQCQ++GOoiSQfsoiNrTs5QnzXpmpk5H7zHK22rVC6lbHo8a1f
         2hDcbl+MQU6UMZQmzaw6dpOAi9IUOwiKVamnQzv/EmZ/CkBCJtqIhLurNJzyEphwgALz
         efyexR+hh5V+BVhKPRWOCzkt1baCYHCasB9iM8rOeqr69Yy3ZTEHVX8SBUZDuUsR2wFf
         Js3GqnNpu3jeUyqQn05QA2z1v9eiQg495/VkLWMZiR8onX8fgQmeCnqg312kXrIZGZJy
         5cMw==
X-Forwarded-Encrypted: i=1; AJvYcCVkmVo8z4aApfj1I1kVh6BbNXo93apFdXEVNVPK3FQlteOpPm/lZFDfntsikSlTazgUkQhKiopFiA2fxBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFPPjGtEGdaglfbCm1qMtoTD0WiNLx5PD23KjErBlGAQtCrij
	ajebJTiPPxOvEDYNv7Oqz2BPBw5ZmXEwhgKtcqABiA/OwrS2cKMQrBZshBznB7I=
X-Google-Smtp-Source: AGHT+IEVMTVA+XF/RZp36+jG20qz8VgE9YipbUhVHun0d8Xu3JujMxKVLfywE6agXsuJveHppV7FEA==
X-Received: by 2002:a5d:6606:0:b0:371:8ed7:49e9 with SMTP id ffacd0b85a97d-3749b548f9fmr2841156f8f.26.1724962574933;
        Thu, 29 Aug 2024 13:16:14 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:802f:3a47:b29:5530:28a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb303sm26681385e9.9.2024.08.29.13.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:16:14 -0700 (PDT)
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
Subject: [PATCH v11 0/4] firmware: ti_sci: Introduce system suspend support
Date: Thu, 29 Aug 2024 22:16:01 +0200
Message-ID: <20240829201606.1407773-1-msp@baylibre.com>
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
"6.2.4 Power Modes" of the AM62P Technical Reference Manual [0].

Summary
*******

This series is a restructuring and rebase of the patch series by
Dave Gerlach [1] and Dhruva Gole [2]. It applies on top of Linux
6.11-rc1.

The kernel triggers entry to Low Power Mode through the mem suspend
transition with the following:

* At the  bootloader stage, one is  expected to package the  TIFS stub
  which then gets  pulled into the Tightly coupled memory  of the Device
  Mgr  (DM) R5  when it  starts up.  If using  U-Boot, then  it requires
  tispl.bin to contain the TIFS stub. Refer to documentation in upstream
  u-boot[3] for further details. The  supported firmware version is from
  TI Processor SDK >= 10.00 ie. tag 10.00.04 from ti-linux-firmware [4].

* Use a TF-A binary that supports PSCI_SYSTEM_SUSPEND call. This causes
  system to use PSCI system suspend as last step of mem sleep.

* We add support for the TISCI_MSG_QUERY_FW_CAPS message, used to retrieve
  the firmware capabilities of the currently running system firmware [6].
  Sysfw version >= 10.00.04 support LPM_DM_MANAGED capability, where
  Device Mgr firmware now manages which low power mode is chosen. Going
  forward, this is the default configuration supported for TI AM62 family
  of devices. The state chosen by the DM can be influenced by sending
  constraints using the new LPM constraint APIs. (Patch 1)

* The firmware requires that the OS sends a TISCI_MSG_PREPARE_SLEEP
  message in order to provide details about suspend. The ti_sci driver
  must send this message to firmware with the above information
  included, which it does during the driver suspend handler when
  PM_MEM_SUSPEND is the determined state being entered. The mode being
  sent depends on whether firmware capabilities have support for
  LPM_DM_MANAGED feature. Legacy firmware or those supporting other
  modes can extend the mode selection logic as needed. (Patch 2)

* We also add the remaining TISCI Low Power Mode messages required for
  inquiring wake reason and managing LPM constraints as part of a new PM
  ops. These messages are part of the TISCI PM Low Power Mode API [5].
  (Patch 3)

* Finally if any CPUs have PM QoS resume latency constraints set, we
  aggregate these and set the TISCI system-wide latency constraint.
  (Patch 4)

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
v11:
- Add dev_err() in many error cases
- Fix a typo in the commit message of 'firmware: ti_sci: Add support for
  querying the firmware caps'
- Fix URL in commit message
- Unify error handling and printing over the added ti_sci_cmd_*
  functions
- Use dev_* instead of pr_*
- Add a debug message listing the capabilities the firmware returned
- Add a small comment describing why context address is 0x0
- Removed unnecessary debug prints
- Restructure the ifdefs for pm ops as suggested
- Only print the wake reason if there was no error. If there is an
  error, the ti_sci_cmd_lpm_wake_reason already printed an error. As a
  missing reason is not critical, the error is ignored and the system
  continues to resume
- Remove wakeup source macros from sci_protocol.h

v10:
- add "wake reason" handling which is also supported by 10.x
  firmware update, but was mistakenly left out of v9
- fix debug print of which CPU caused max CPU latency
- update TRM pointer[0] to point to AM62P TRM which has better
  description of low-power modes shared across AM62P family
- update u-boot documentaion pointer to point to upstream u-boot
  commit.

v9:
- Include Kevin's patch to add CPU latency constraint management into
  this series. Posted here in v3:
  https://lore.kernel.org/lkml/20240802214220.3472221-1-khilman@baylibre.com/
- reorder patches to avoid any build warnings
- ti_sci_cmd_prepare_sleep was moved into the patch that adds suspend
  and resume calls
- pmops wake_reason is now only set if the capabilities exist
- Use pmops pointer instead of full path

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
[3] https://source.denx.de/u-boot/u-boot/-/commit/962f60abca82bb11501bc0c627abacda15bed076
[4] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/commit/?h=10.00.06&id=193f7d7570583a41ddc50a221e37c32be6be583e
[5] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
[6] https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-msg-query-fw-caps

Dave Gerlach (1):
  firmware: ti_sci: Introduce Power Management Ops

Georgi Vlaev (1):
  firmware: ti_sci: Add support for querying the firmware caps

Kevin Hilman (1):
  firmware: ti_sci: add CPU latency constraint management

Vibhore Vardhan (1):
  firmware: ti_sci: Add system suspend and resume call

 drivers/firmware/ti_sci.c              | 490 ++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h              | 143 +++++++-
 include/linux/soc/ti/ti_sci_protocol.h |  30 ++
 3 files changed, 661 insertions(+), 2 deletions(-)

-- 
2.45.2


