Return-Path: <linux-kernel+bounces-280987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34D94D1A5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A631F24D46
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB486195B18;
	Fri,  9 Aug 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FusUgP/m"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5C194A48
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211640; cv=none; b=fdwxcPE38DZvCay1+xgfpeHamsNK9QLm2lSzy0ZtRpB0XoPMSuujBrsdZxNs1w2qJLIH8YzCDo2jGFpYzy1izZsAgna31jlsG1FM+qrM9COr6s/+pjhs/LPPiihWx/pLBJV1hR6Zrqc3T63vai8QFQ43gOWxAZ0qsZyXlvs0cmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211640; c=relaxed/simple;
	bh=JzBA0asp/uIUg6uVMQEE1AxAgrkqlIdSYclUedAQ4Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7GngzxiJ6lXFBjkw/Qf1h36M4QNe6QXI08ftIy4reBmNl/wnSVb8pT+GURDpqDn50ZpM6SREJIWertDFJLWyWojTaYAuVgjbI80exMiWdpg2vLEThN+HMruNZIVnfmWa8bzhNUkqkY4I5+4VgRphvvm6osmSFblwffIDT1PMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FusUgP/m; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5e97b8adbso1069166eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723211637; x=1723816437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbnjOXDTOYI2JZNwrEJdQ9m6GBxCSfhfEeSdGgG1XLQ=;
        b=FusUgP/mNlM4v3Nov63GpHwz986vI0QdT17XvoWEmJwdgHDnjnn7OnX92Ml645BgdA
         EqSoMQvzqUMwkLDFNcTTT1GsAbR2JqtESkkU8XRTmhswGFMuXkoGU7EcodShskK0MaIx
         KZK8kwIztu0IiTZOp7DDKbR2ZmV0jkYfXK3dVVxkUhsnUVPi4GJigpv3uMfSCZCr7gyy
         4jXtt0x39A+ndQP+L4G12wgDb/aRBUmVIKwIJTR0TO2IA03bx5NJfZLTPpIlxRKm9eKa
         ntYU2F0zgNdPxFszeTNIs7aoomh8xjYx8/SEswJB5xI7XGp7c0lvVqVa232N8+PEzNBw
         2vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211637; x=1723816437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbnjOXDTOYI2JZNwrEJdQ9m6GBxCSfhfEeSdGgG1XLQ=;
        b=dIltyePXBUy2FYZpzBER2YW2/QU5ZNqGMw3CjVl0OcsnPL0WErTL63JH/OVrSRXK8X
         80cnF7dDXV1fZVNrLAfvJHVlgxWG2UVTuZ8DRRli8Q551XjZpLKyxizrlt0ABHBWt8Ta
         jcwaP3EC+rD0dRap7PCBNtBhG34THFJNu6XpWQLfekTNn+9PCvmTnYcKtpkO1dcMxILN
         RBqCEOj0W0M549CFXSDNvwdppC6wyL8dtOSgl8rUPHzd+eWILYOI3zWR0PfydlAbRdxH
         zXd2Gl+9Mi4JysrPLa0ssmQb2Ku5FRg0j37Q40USbZiZVdEZHIpW/AYyx6v0yQ7OgvzM
         JYYw==
X-Forwarded-Encrypted: i=1; AJvYcCX35Bq3Nl/6LQ7SYUFk9BtBKwOe4T59lBdNQf5FUzZChG67REWy2BeiZuZu7x5MBUMiNtCz8jkoIVTrlYyLU+qYZmPp76Llu2FzAZL1
X-Gm-Message-State: AOJu0YzqWI7NdMdikFFQg3j1VutPpH38YB4rqQs0M1USib74n7FLapck
	tkucL4KbvzTFGvvEHl14KYDHz0EDFqXu+1KqctV8vAQUkbmLsTSvmwNbPkUQNKk=
X-Google-Smtp-Source: AGHT+IFieOG7LkS2XXQlOLREKnjhwhEXzvSufxijvvixByPqEO4PNirq85dpiYCzPDWgmDLXY1Fw4g==
X-Received: by 2002:a05:6358:27a3:b0:1ab:e07d:c945 with SMTP id e5c5f4694b2df-1b176eed1fcmr183303655d.1.1723211636947;
        Fri, 09 Aug 2024 06:53:56 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a2728bsm4158640173.103.2024.08.09.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:53:56 -0700 (PDT)
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
Subject: [PATCH v9 0/4] firmware: ti_sci: Introduce system suspend support
Date: Fri,  9 Aug 2024 15:53:43 +0200
Message-ID: <20240809135347.2112634-1-msp@baylibre.com>
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
[3] https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2023.04&id=91886b68025c7ad121e62d1fc1fa4601eeb736cd
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

 drivers/firmware/ti_sci.c              | 452 ++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h              | 137 +++++++-
 include/linux/soc/ti/ti_sci_protocol.h |  46 +++
 3 files changed, 633 insertions(+), 2 deletions(-)

-- 
2.45.2


