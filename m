Return-Path: <linux-kernel+bounces-286771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27FF951EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B1C1F22591
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB031B5832;
	Wed, 14 Aug 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="00DVmx0F"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A71B4C42
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649999; cv=none; b=QHKVQzQtwVmqccbJ/FMmieLZ9PAQP8XOIY8u3HgIsUjHiks2YMjwVH1D+Y3r3ij9T4qssbtolQYbXWfjae1MwTKe4A6x3D2y+u2IyR1AgEJ3pHsgtwFIda86OVf9eweGPiar7QZl52PV8lyOe6Qz50umtn4LBPsRjeQHmW7+bfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649999; c=relaxed/simple;
	bh=Rn4U+pg7pbOOA+pqHntMv+60vDwg7ssIxo/38q0Vmvw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lOZwOWhPvxoj19vOVwfWTjSxfChWO6dt+PclC43fe8So9TlfsqlalMovXWkCgKDNER1elJ/EvtbtNc4e+Mw8nKfI8Dd5S7mJWtpmTYTjAuHDpxz+3Yg50mbrvxnUVGZdfmd0RbtuYYVTsBhneubj43okE2iCQWJe8kexrw3QhtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=00DVmx0F; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so41526a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723649994; x=1724254794; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1VWpoo0tu3M3A3LRAdNigKVKR+IaX/4ELlj6gztu9Y0=;
        b=00DVmx0FjpL8mWZdA/ibwy2xEfjOhwOP8EvAnQ2x/soHF6OFwc0na5RSGQSxb8FKaF
         ZmOrspoZrFATD0CRtlh88UVrHdy4CHvsemCNuuy1V1VVOFaTPZ0hba6bSMJxtaLyYv0H
         +UbyytWu9tNjC682730KBqQQSxh2xlLnNeS8OlnnTXz2K0FZzdY/JntVw2LD0F0CoHXy
         /DKGmPBcFdBG72LMwGc7Es106kh3TzKOvGhZ87X+Ksvm6eLznb7VQi+rCJakfrXxYlMQ
         vKzu9InXGWD4Qdc50TTw1bdEXNkCrDx2bhkTlFsOaF9zMv3DIlSVKGrksmiSbmaODb/W
         DHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649994; x=1724254794;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VWpoo0tu3M3A3LRAdNigKVKR+IaX/4ELlj6gztu9Y0=;
        b=soTaBbkoCp094v0hblMzuMYYlNzX+wAGB6UZCDara7xaAL1LTZ2KhSEoFUYzP6oZpi
         JaQbWJg2lkVAYK0UB/8XSHQAXX2SaTGgdPxsHBtdlo/RSUP2+UBJlwxcRx9yT9Sxz+w1
         YTkOmQaiYGdbbts9B/lsGUSYcRwMQ1IKZQmUcB/Eo5pbrNyPmjygGdrYN3/ldS9A8fVQ
         QXDN1tjq5a71lOKW8NB+AKwfK+YJLVSaRDt1M5SqQE2KxK4Pr/8LlPnkzUbavWRTWqqM
         jjf8FMOytaA6ggMvc5DaqCP7qs5VO76wg3Q9V0YRwo5O608Zn/zlUHurDEbkIHeT9Dxb
         YMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEnkuSydoq60jLxoNU7Dqqo6SCYz59nSVtIBwEEcqYD39hQAChdkX9cJd5rG8xtgbdGmNJhhciGaeJepXYia0Xnzclp6kjFro5Zapb
X-Gm-Message-State: AOJu0Yyo3O7rYC+BKP3TKz0GMOwy5bff41XGT9atQLZT3UXOvbQJlP+G
	83QXvahUCtZ0s9NktpETlj5z0UsXabvtrPpCYMQj5LLdmOJqKCWqpohVyVPtGG0=
X-Google-Smtp-Source: AGHT+IEEnU/WyMHMRghoSzI6w3fVMZnzOHXj3adE+OZc/DotYNVt6EBOYaKjZe/05ABNzDkgtavRjg==
X-Received: by 2002:a17:90b:2242:b0:2d1:ba43:1303 with SMTP id 98e67ed59e1d1-2d3aaabdd79mr3462889a91.21.1723649993717;
        Wed, 14 Aug 2024 08:39:53 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7e8af3sm1913629a91.18.2024.08.14.08.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:39:53 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v10 0/4] firmware: ti_sci: Introduce system suspend support
Date: Wed, 14 Aug 2024 08:39:27 -0700
Message-Id: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK/PvGYC/03MTQ6CMBBA4auQrh3TaVHElfcwLkoZZBLakinxJ
 4S7W125fG/xrSqTMGV1rlYl9ODMKZZAvauUH128E3BfhjLa1PqEFqY5gE8xL+I4LhkGlvB0QhD
 yDOh11+vWOLSNKsQsNPDr519vpQdJAZZRyP2hukV7sHWzN4jmaGvAr3Xp3HviTmjvU1Db9gFII
 cQMqwAAAA==
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8184; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=Rn4U+pg7pbOOA+pqHntMv+60vDwg7ssIxo/38q0Vmvw=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmvM/IYPJEpDZ0uZ/19McgHZGpq0+zKWECPBQws
 2LThisKttuJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZrzPyAAKCRBZNxia0/vG
 ZagjD/9s48m9yXyY6C4+wDhkD4SdFXWT4LRvN2W77C4XUvltWR4M8t2Af3pj87trJix44SwUG7k
 rPO86m8STarIjx1t1PBDw/hPZkA2OCq8X43ssc4gLQ+dJyUB/93TdUg8Hxi6IBOE3I3xRXBq3vf
 R4q7ZA+u1U6d+tJIE0gC96sk/aMDkFOC8LMZ8KZJJRC2gDT3a4PAiU9HXo9XKa+oHFEjzr5arNs
 /PRWRpmQWBxD5aXzxyW9LIDa8hd/UwSmlQ3Glnbqe1K8gxGdMvzEbqqukje4VmaLzBGopxgym99
 Fsm4pwSmf9dVmqTGQVokiBD6SwuVJkOqnrBrPyuVBzmcB2SRCOnQSRJsMXBnFCDolj/7kV+ejZr
 RMPqWuS+qrfXp1EdkA3DZ7ib09CRkKq2tFabtrIpYb80IN+9r2wRxGMLv3wGZHVvOvhHVkiutB/
 331NdtewaafbailVFp9JK2FxUFFoWs6/NOEgadR1YMA8XD6nsH8Nf6fYN97knYL3XAfRY0Ghx7o
 HHtmmWq6eR1r/lK8nzmp/n1+rgU+pVPEZn4GCzd1xPjXgHfrG0AoHwjUGZCk6kASsPnJonm8ohW
 k+aehbIQFukxJWjsr8Ww13w9Lldu6IMU/jCRbMrDBcnR6Ta4CLIXj6UFWqcWeom8j8tkwHIx0Fc
 jRgp2UMNcD5q1og==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

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

 drivers/firmware/ti_sci.c              | 452 ++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h              | 137 +++++++-
 include/linux/soc/ti/ti_sci_protocol.h |  46 +++
 3 files changed, 633 insertions(+), 2 deletions(-)

--
2.45.2

---
Dave Gerlach (1):
      firmware: ti_sci: Introduce Power Management Ops

Georgi Vlaev (1):
      firmware: ti_sci: Add support for querying the firmware caps

Kevin Hilman (1):
      firmware: ti_sci: add CPU latency constraint management

Vibhore Vardhan (1):
      firmware: ti_sci: Add system suspend and resume call

 drivers/firmware/ti_sci.c              | 468 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h              | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/soc/ti/ti_sci_protocol.h |  46 +++++++++++++++++
 3 files changed, 655 insertions(+), 2 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240813-lpm-constraints-firmware-msp-1c0bd092a137

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


