Return-Path: <linux-kernel+bounces-243428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E7A929611
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 02:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28221F21918
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA7317F7;
	Sun,  7 Jul 2024 00:21:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE144C7B;
	Sun,  7 Jul 2024 00:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720311696; cv=none; b=moAC9VyvKSTQ22AdpQduGQ4Ek85jzLspWsCW3bmT54Qf1ou+YXm1F0ldRZzqIoHvm9fXEdrOBYX+W9thUxZG0j+16P/Rz+2X0ky0tNCLsQ6EQujV4YhneyWkr9Kgrc8TJIgvmTlerk15HoU7KdihpuYXLb3LK6V5I/CNvqrybkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720311696; c=relaxed/simple;
	bh=oHOXUljsjplj2hMFLMYDgcenBpbY6CUbLzvvMfLxXug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzT/1f+u4L5I81DleTYWjYSaNGkszSw0t8zlA6zJivxivMs1xWwkuTKXjsFmD8ZV2KAiwggmiKj5QKABjEfPo0qnoQuas2iQHEHL8m2EuA6omecXZ3t9+nYDNTZmJmmUwRBL1eF0Bh4zqoiXViKkbtfQqmFPkfAUvGaLhvAxyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CAB0DA7;
	Sat,  6 Jul 2024 17:21:58 -0700 (PDT)
Received: from pluto.. (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B756A3F73B;
	Sat,  6 Jul 2024 17:21:29 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@foss.st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	ptosi@google.com,
	dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/8] Make SCMI transport as standalone drivers
Date: Sun,  7 Jul 2024 01:20:47 +0100
Message-ID: <20240707002055.1835121-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

SCMI transport layer was till now being embedded built into in the core
SCMI stack.

Some of these transports, despite being currently part of the main SCMI
module, are indeed also registered with different subsystems like optee or
virtio, and actvely probed also by those: this led to a few awkward and
convoluted tricks to properly handle such interactions at boot time in the
SCMI stack.

Moreover some partner expressed the desire to be able to fully modularize
the transports components.

This series aim to make all such transports as standalone drivers that can
be optionally loaded as modules.

In order to do this, at first some new mechanism is introduced to support
this new capability while maintaining, in parallel, the old legacy embedded
transports; then each transport, one by one, is transitioned to be a
standalone driver and finally the old legacy support for embedded transport
is removed.

Patch [1/8] is a mostly unrelated (but much needed) clean-up from Peng,
which I included in this series to avoid conflicts at merge.

Patch [2/8] simply collects the existing datagram manipulation helpers in a
pair of function pointers structures, in preparation for later reworks.

Patch [3/8] adds the bulk of the new logic to the core SCMI stack and then
each existing transport is transitioned to be a standalone driver in
patches 4,5,6,7 while shuffling around the compatibles. (no DT change is
needed of curse for backward compatibility)
While doing this I kept the module authorship in line with the main
author(S) as spitted out by git-blame.

Finally patch [8/8] removes all the legacy dead code from the core SCMI
stack.

No new symbol EXPORT has been added.

The new transport drivers have been tested, as built-in and LKM, as
follows:

- mailbox on JUNO
- virtio on emulation
- optee on QEMU/optee using Linaro setup

Exercised using the regular SCMI drivers stack and the SCMI ACS suite,
testing commands, replies, delayed responses and notification.

Multiple virtual SCMI instances support has been tested too.

SMC has NOT been tested/exercised at run-time, only compile-tested.
(due to lack of hardware)

Note that in this new setup, all the probe deferral and retries between the
SCMI core stack and the transports has been removed, since no more needed.

Moreover the new drivers have been tested also with a fully modularized
SCMI stack, i.e.:

  scmi-core.ko + scmi-module.ko + scmi_transport_*.ko [ + vendor modules ]

One thing that I have NOT done still, but that it's an easy pick, would
be to completely remove any dependency between the SCMI core stack and the
transports, leaving these latter only dependent on the mere presence of
the related subsystems like optee/virtio/mailbox/smc: this would allow to
compile the transports and the related subsys as built-in while keeping the
core SCMI stack as a module....not sure if it makes sense... but it can be
already easily done by simply patching further the Kconfig.

Based on sudeep/for-next/scmi/updates.

Any feedback, and especially testing (:D) is welcome.

Thanks,
Cristian

Cristian Marussi (7):
  firmware: arm_scmi: Introduce packet handling helpers
  firmware: arm_scmi: Add support for standalone transport drivers
  firmware: arm_scmi: Make MBOX transport a standalone driver
  firmware: arm_scmi: Make SMC transport a standalone driver
  firmware: arm_scmi: Make OPTEE transport a standalone driver
  firmware: arm_scmi: Make VirtIO transport a standalone driver
  firmware: arm_scmi: Remove legacy transport-layer code

Peng Fan (1):
  firmware: arm_scmi: Introduce setup_shmem_iomap

 drivers/firmware/arm_scmi/Kconfig             |  20 +-
 drivers/firmware/arm_scmi/Makefile            |   9 +-
 drivers/firmware/arm_scmi/common.h            | 183 +++++++++++++-----
 drivers/firmware/arm_scmi/driver.c            | 140 +++++---------
 drivers/firmware/arm_scmi/msg.c               |  34 +++-
 .../{mailbox.c => scmi_transport_mailbox.c}   |  69 ++++---
 .../{optee.c => scmi_transport_optee.c}       | 120 +++++-------
 .../arm_scmi/{smc.c => scmi_transport_smc.c}  |  52 ++---
 .../{virtio.c => scmi_transport_virtio.c}     |  95 +++++----
 drivers/firmware/arm_scmi/shmem.c             |  80 ++++++--
 10 files changed, 445 insertions(+), 357 deletions(-)
 rename drivers/firmware/arm_scmi/{mailbox.c => scmi_transport_mailbox.c} (87%)
 rename drivers/firmware/arm_scmi/{optee.c => scmi_transport_optee.c} (89%)
 rename drivers/firmware/arm_scmi/{smc.c => scmi_transport_smc.c} (88%)
 rename drivers/firmware/arm_scmi/{virtio.c => scmi_transport_virtio.c} (95%)

-- 
2.45.2


