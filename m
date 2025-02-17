Return-Path: <linux-kernel+bounces-517934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1610A387C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65079173888
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854CD224B11;
	Mon, 17 Feb 2025 15:39:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31E148FE6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806772; cv=none; b=tZK+dbkRbrrJgIVn6TS4QRMI3CJYVvFBFcBSbMjXCfRLs6ZY1BT5EWuSIMCd0/q6d15AofriyzxxDqA7anCZ9UIUMoPT6ZwKDOZVw3DiFt3gd6oTF9A8wNAhJ6n1tbVcDygkyv3Lw4LOzgqSSLhiZKvC2Lc8q5klRWD9GNothm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806772; c=relaxed/simple;
	bh=RhTnNYTfj2ffvvqL8JaHV8Axj4MhUpAhKy1ZgSM7abE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=pH7iQf10rBznBKXUJ9/Q5R7GSQJL6oPLOaLOvG3j5gu00R74jLj+Lh8MVyPHBizni6A0E47hhxYHIM0QNxE4SsvkBWyjjQSXAPueJlQpE1Qpz5o942E68lQU7BJqjN0SdK3xCrknMujZvYsSYHCLJuf9JCWlBqfzNZx87o4dbn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04CAB152B;
	Mon, 17 Feb 2025 07:39:48 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E9393F6A8;
	Mon, 17 Feb 2025 07:39:27 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v3 00/19] firmware: arm_ffa: Framework notification support
 + other updates and fixes
Date: Mon, 17 Feb 2025 15:38:41 +0000
Message-Id: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAZYs2cC/23MSwrCMBSF4a2UjI3k5ia+Ru5DRNLmxmbQpiQ1K
 KV7Ny2ICA7Pge+fWKLoKbFTNbFI2Scf+jJwU7GmNf2duLdlMymkAikVd87cHoM1IyUOYucsWnd
 Eq1kRQyTnn2vtci279WkM8bXGMyzv/04GLrgAiWhqgwR0NrHbNqFjSyXLj9QCEH6lLFIrVRtFq
 PGw/8p5nt9c5vTu3gAAAA==
X-Change-ID: 20241224-ffa_updates-106fd3df93d5
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3957; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=RhTnNYTfj2ffvvqL8JaHV8Axj4MhUpAhKy1ZgSM7abE=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1gtlQjXSIZZ1QilM4KEtRmZZGA/mabcIzQyM
 HMQGh7ifgWJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLQAKCRAAQbq8MX7i
 mMaTEADXtL3GaYTyX9jBF0qryyucuCDMc0PT3DNxvYndxYVB4X0pWfMLajZqMB4sjbJe0NXpy2e
 M1OKrlAp/6C6X7aLkGEvzELgzlHPdk4VLjw+vG3hBKsTc7Ej4iqORfSASIwUwV/xYN/CWri4xD4
 z3KH3Soj20Fb4858gGph5P+++ZJR+66onbTrI/b0GXesqd+s0pwoZ2eO5ggnZkNlIEo0lM+kxPI
 vPX698S4vQbZJvT85v+Pv80er/XZZswj3Yj4g+8XZrdESjEY6tEOc5LbOl20nuX/ZL/TERV9opt
 JCqX6vWN8IMFcAbUPACK6//3HR+Fwm/CYrBN2RMHeN6NkQ1z3m+fB5qV17IIloqp3RJ0rzxudam
 ZcqyVlwOct5e3HMTiiLQ4aGZJqQrxvMpLefMXKexOcg/lqChxNRKD/V7fHnAGW34QTt1IhW5wd/
 88IbTg4+sm4KCThcBYus4OnnqkxXTDW7jV47np0p0GT2jv/GrpqKyv+nqmyElLyiHXH6IqGXja2
 Atp7moVDW9TKpS4i/L77rlbTDh/EcmGUNZMLxH8WkZVNAUJ3A1YLFbN6gnRN+vrur6FsWzBxyD6
 xS0ZtVvKbf0u7OfLYTO2a6GjO5p68CuF72QMzEMbipl02u50YhBUP+fUVjOcm+tEOCd0DT1+x03
 hB98ma3NAwS0IuQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

This bundle of changes mainly have FF-A framework notification support
along with other minor updates and fixes.

It adds support to allow multiple UUIDs per partition to register
individual SRI callback, to handle Rx buffer full framework notification
in particular and general framework/interface to extend in the future.

It also adds support for passing UUID in FFA_MSG_SEND2 which improves
the multiple UUID/services per partition support in the driver and
an helper to check if a partition can receive REQUEST2 messages or not.

It also improves cleaning up the partitions by adding unregistration of
the devices as well as handles the presence of host partition in the
partition info.

It also contain fixes big-endian support in couple of functions:
__ffa_partition_info_regs_get() and __ffa_partition_info_get().
Big-endian support is still not complete. Only these changes can be
verified at the moment without any additional application or testing
support changes.

Regarding the FF-A versions, it upgrades the driver version to v1.2
and rejects any higher major version than the driver version as
incompatible.

It also fixes the mis-alignment with sync_send_receive{,2} function
prototypes.

It replaces UUID buffer to standard UUID format in the ffa_partition_info
structure and fixes a typo in some FF-A bus macros.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
Changes in v3:
- Dropped spurious extra blank line in ffa_setup_partitions()
- Fixed issue with Xarray erase in ffa_partitions_cleanup()
- Used kmemdup() instead of kmalloc() + memcpy()
- Extend support to read non-secure notification bitmaps
- Added Viresh's Tested-by tag
- Link to v2: https://lore.kernel.org/r/20250131-ffa_updates-v2-0-544ba4e35387@arm.com

Changes in v2:
- No changes in the patches sent as v1 itself.
- Addition of framework notification support and other updates as listed
  above
- Link to v1: https://lore.kernel.org/r/20241224-ffa_updates-v1-0-01233aba3e1e@arm.com

---
Sudeep Holla (18):
      firmware: arm_ffa: Replace SCMI by FF-A in the macro
      firmware: arm_ffa: Replace UUID buffer to standard UUID format
      firmware: arm_ffa: Align sync_send_receive{,2} function prototypes
      firmware: arm_ffa: Fix big-endian support in __ffa_partition_info_get()
      firmware: arm_ffa: Fix big-endian support in __ffa_partition_info_regs_get()
      firmware: arm_ffa: Handle the presence of host partition in the partition info
      firmware: arm_ffa: Unregister the FF-A devices when cleaning up the partitions
      firmware: arm_ffa: Helper to check if a partition can receive REQUEST2 messages
      firmware: arm_ffa: Add support for passing UUID in FFA_MSG_SEND2
      firmware: arm_ffa: Upgrade FF-A version to v1.2 in the driver
      firmware: arm_ffa: Reject higher major version as incompatible
      firmware: arm_ffa: Remove unnecessary declaration of ffa_partitions_cleanup()
      firmware: arm_ffa: Refactoring to prepare for framework notification support
      firmware: arm_ffa: Stash ffa_device instead of notify_type in notifier_cb_info
      firmware: arm_ffa: Add support for {un,}registration of framework notifications
      firmware: arm_ffa: Add support for handling framework notifications
      firmware: arm_ffa: Allow multiple UUIDs per partition to register SRI callback
      firmware: arm_ffa: Handle ffa_notification_get correctly at virtual FF-A instance

Viresh Kumar (1):
      firmware: arm_ffa: Refactor addition of partition information into XArray

 drivers/firmware/arm_ffa/bus.c    |  13 +-
 drivers/firmware/arm_ffa/driver.c | 526 ++++++++++++++++++++++++++++----------
 include/linux/arm_ffa.h           |  22 +-
 3 files changed, 418 insertions(+), 143 deletions(-)
---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20241224-ffa_updates-106fd3df93d5

Best regards,
-- 
Regards,
Sudeep


