Return-Path: <linux-kernel+bounces-267721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D048C9414BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879961F248C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A961A2C2A;
	Tue, 30 Jul 2024 14:47:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70B1A257D;
	Tue, 30 Jul 2024 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350879; cv=none; b=jrxuRI0VbnGhufEunvd1V4HTIh7L/lmmNi+jVPcFMSH7Jodtebh3wr3wTmEZCPsIrXYwjBCIhlcQpv06vfDTi+AXy97Nzb0VW4hBHpiaiVaKeQkO5EFqFE18g8Wj1vY17eU/sSnCbOOMOcunDlEKaVfTsKRyH+YZX0i1Bv9a0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350879; c=relaxed/simple;
	bh=VVfpgG5OslNS/wfuLNNhtQVPjBKlX7P4FEAUhpitjB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYbArraYYWUT9HSD79iOMt21D4ZB97dyMHZVGTbBWiRl53ns8oZLKAwiUVC9aBvh8pGIKBHOYsgAgkZg597qrWmZIVnpgScYKxQALHTfmFwa0uoBpTeFnx5Fj5AKmGO2haQBHhkbYOc12Fmy82KPP+OS+YnzCJdH0hTO0r4eD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D826106F;
	Tue, 30 Jul 2024 07:48:22 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2663B3F766;
	Tue, 30 Jul 2024 07:47:53 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v1 1/6] firmware: arm_scmi: Remove const from transport descriptors
Date: Tue, 30 Jul 2024 15:47:02 +0100
Message-ID: <20240730144707.1647025-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730144707.1647025-1-cristian.marussi@arm.com>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The descriptor structure scmi_desc contains a variety of fields related to
the transport functionalities and it is defined by the transport drivers
themselves; such elements, though, serve varied purposes and have different
lifetime.

In particular, while there are some of those elements that provide a
description of transport features that are supposed to be immutable, on
the other side there are present also some other characteristics that are
instead supposed to be configurable on a per-platform base since they
represent configuration features tied to the specific hardware/firmware
system.

The immutable fields are already qualified as const on the their own; get
rid of the structure-level const qualifier which is not needed, so as to
enable possible runtime customization of the mutable configuration
features.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h                 | 2 +-
 drivers/firmware/arm_scmi/scmi_transport_mailbox.c | 2 +-
 drivers/firmware/arm_scmi/scmi_transport_optee.c   | 2 +-
 drivers/firmware/arm_scmi/scmi_transport_smc.c     | 2 +-
 drivers/firmware/arm_scmi/scmi_transport_virtio.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 77721cb4ac34..5261dc9b5f96 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -381,7 +381,7 @@ struct scmi_transport_core_operations {
  */
 struct scmi_transport {
 	struct device *supplier;
-	const struct scmi_desc *desc;
+	struct scmi_desc *desc;
 	struct scmi_transport_core_operations **core_ops;
 };
 
diff --git a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
index 75483b6778ee..dc5ca894d5eb 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
@@ -355,7 +355,7 @@ static const struct scmi_transport_ops scmi_mailbox_ops = {
 	.poll_done = mailbox_poll_done,
 };
 
-static const struct scmi_desc scmi_mailbox_desc = {
+static struct scmi_desc scmi_mailbox_desc = {
 	.ops = &scmi_mailbox_ops,
 	.max_rx_timeout_ms = 30, /* We may increase this if required */
 	.max_msg = 20, /* Limited by MBOX_TX_QUEUE_LEN */
diff --git a/drivers/firmware/arm_scmi/scmi_transport_optee.c b/drivers/firmware/arm_scmi/scmi_transport_optee.c
index 974128d73f2d..08911f40d1ff 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_optee.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
@@ -510,7 +510,7 @@ static int scmi_optee_ctx_match(struct tee_ioctl_version_data *ver, const void *
 	return ver->impl_id == TEE_IMPL_ID_OPTEE;
 }
 
-static const struct scmi_desc scmi_optee_desc = {
+static struct scmi_desc scmi_optee_desc = {
 	.ops = &scmi_optee_ops,
 	.max_rx_timeout_ms = 30,
 	.max_msg = 20,
diff --git a/drivers/firmware/arm_scmi/scmi_transport_smc.c b/drivers/firmware/arm_scmi/scmi_transport_smc.c
index 1c203a68acd4..c6c69a17a9cc 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_smc.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
@@ -273,7 +273,7 @@ static const struct scmi_transport_ops scmi_smc_ops = {
 	.fetch_response = smc_fetch_response,
 };
 
-static const struct scmi_desc scmi_smc_desc = {
+static struct scmi_desc scmi_smc_desc = {
 	.ops = &scmi_smc_ops,
 	.max_rx_timeout_ms = 30,
 	.max_msg = 20,
diff --git a/drivers/firmware/arm_scmi/scmi_transport_virtio.c b/drivers/firmware/arm_scmi/scmi_transport_virtio.c
index 55d7245fa7ee..d711ba6e07f6 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_virtio.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_virtio.c
@@ -790,7 +790,7 @@ static const struct scmi_transport_ops scmi_virtio_ops = {
 	.poll_done = virtio_poll_done,
 };
 
-static const struct scmi_desc scmi_virtio_desc = {
+static struct scmi_desc scmi_virtio_desc = {
 	.ops = &scmi_virtio_ops,
 	/* for non-realtime virtio devices */
 	.max_rx_timeout_ms = VIRTIO_MAX_RX_TIMEOUT_MS,
-- 
2.45.2


