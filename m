Return-Path: <linux-kernel+bounces-267594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC8794132F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C9C281668
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D215519F478;
	Tue, 30 Jul 2024 13:33:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB119E7CF;
	Tue, 30 Jul 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346424; cv=none; b=W4vcGRoTz/ooRUB43Da/qiloxnfsRW4pJFE5AsdfVFYmhHBWOsbNDacTYv/ikSby38q78ci4kaDkw3gr8Rrq3VJJaopQ+yX0u8We23cAASXobiWX2Y0fF6RIGaPpOGeX6XDsWnNkMCSiRWVjHdPSkob+efG/jBNmmhTZYvNBZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346424; c=relaxed/simple;
	bh=EoEyzUBrGMKH93PwUl1DCgkvlIQeyS/DBPs124q9pi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQS2BuV92K1O0nokNCKZkjIG3o3lKp9Kv2m8T5+Yvd1Mb4BI11/OaOKmb9YSDqCj3LVlV1FdFOc97J0N2yICHDVqEpCAdAyuz/BLwiQmqBr3jEGjPslZ8k42Grw1WhIDcWubMUkzjCcF4V7BtcGjmhUNRSUEjS94C+35ceTiUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2269D1007;
	Tue, 30 Jul 2024 06:34:07 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5476B3F5A1;
	Tue, 30 Jul 2024 06:33:38 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	ptosi@google.com,
	dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 0/9] Make SCMI transport as standalone drivers
Date: Tue, 30 Jul 2024 14:33:09 +0100
Message-ID: <20240730133318.1573765-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Till now the SCMI transport layer was being built embedded into in the core
SCMI stack.

Some of these transports, despite being currently part of the main SCMI
module, are indeed also registered with different subsystems like optee or
virtio, and actively probed also by those: this led to a few awkward and
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

Patch [1/9] is a fix around the chan_free method for OPTEE transport; it is
really unrelated to this series, but included to avoid conflicts.

Patch [2/9] is a mostly unrelated (but much needed) clean-up from Peng,
which I included in this series to avoid conflicts at merge.

Patch [3/9] simply collects the existing datagram manipulation helpers in a
pair of function pointers structures, in preparation for later reworks.

Patch [4/9] adds the bulk of the new logic to the core SCMI stack and then
each existing transport is transitioned to be a standalone driver in
patches 5,6,7,8 while shuffling around the compatibles. (no DT change is
needed of curse for backward compatibility)
While doing this I kept the module authorship in line with the main
author(S) as spitted out by git-blame.

Finally patch [9/9] removes all the legacy dead code from the core SCMI
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

Based on v6.11-rc1

Any feedback, and especially testing (:D) is welcome.

Thanks,
Cristian

---
v2 --> v3
- rebased on v6.11-rc1
- fixed spacing in Kconfig
- fixed Copyrights all over
- fixed platform_driver_register callsite in OPTEE transport
- refactored DEFINE_SCMI_TRANSPORT_DRIVER() to:
  + use alloc + add_data + add platform drivers methods so as to implictly
    use a standard default device_release method.
  + drop .remove method in favour of devres_add_action_or_reset
  + use explicit parameter passing (no more concatenation)
- renamed scmi_transport_lookup() to scmi_transport_setup()
- use IOMEM_ERR_PTR to avoid sparse issues

v1 --> v2
- fixed setup_shmem_iomap to address also SMC needs (QC/nikunj)
  (silencing also warnings by kernel test robot <lkp@intel.com>)
- using __free OF cleanup.h magic in setup_shmme_iomap
- properly handle platform_driver_register() failures (Dan)
- fixed a few commit message style
- added a few missing static in scmi_desc
  (addresses warnings by kernel test robot <lkp@intel.com>)


Cristian Marussi (8):
  firmware: arm_scmi: Fix double free in OPTEE transport
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
 drivers/firmware/arm_scmi/common.h            | 184 +++++++++++++-----
 drivers/firmware/arm_scmi/driver.c            | 142 +++++---------
 drivers/firmware/arm_scmi/msg.c               |  32 ++-
 .../{mailbox.c => scmi_transport_mailbox.c}   |  72 +++----
 .../{optee.c => scmi_transport_optee.c}       | 130 ++++++-------
 .../arm_scmi/{smc.c => scmi_transport_smc.c}  |  57 +++---
 .../{virtio.c => scmi_transport_virtio.c}     | 102 +++++-----
 drivers/firmware/arm_scmi/shmem.c             |  85 ++++++--
 10 files changed, 477 insertions(+), 356 deletions(-)
 rename drivers/firmware/arm_scmi/{mailbox.c => scmi_transport_mailbox.c} (86%)
 rename drivers/firmware/arm_scmi/{optee.c => scmi_transport_optee.c} (89%)
 rename drivers/firmware/arm_scmi/{smc.c => scmi_transport_smc.c} (87%)
 rename drivers/firmware/arm_scmi/{virtio.c => scmi_transport_virtio.c} (94%)

-- 
2.45.2


