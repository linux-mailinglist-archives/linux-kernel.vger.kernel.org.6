Return-Path: <linux-kernel+bounces-371213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9009A3805
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFDC283BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53318E03F;
	Fri, 18 Oct 2024 08:07:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8922518CC0D;
	Fri, 18 Oct 2024 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238823; cv=none; b=tdQiGVYYO5vU2DLloJ+YZLMKsEXP1A4KUQoP+9w5V1AYyzkBPKGGb3dBnnxTvfGHh2kTATX+gDzgtMZzUPcQkw6/6lJYRlKm6bqepBR+r4E/9xGgG6Esxwixrkf4GFwxkdTweeEb7ZOiU2MjAQLdqy+/XNz3veyNd8RnRu3PwM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238823; c=relaxed/simple;
	bh=VruJkAKLDJgWtoA6aIG9VBfLRbNgGhfPbGgS15jgb0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMbM/Je7pNn8dr2qx/C4teGca/nHOF8DhIvqMxFm5P2mavTlyWLs/XIfs7TNK3RIJkwyxDmVWDPr12JwKL36aSUYaZRXmBVeqVO0StSQjlN3TUKqu6q9gVyGCmr71B85Ni1u5Er9/5QWEDRlkkB+ZnSBvq+hAerL/tf2zUL81mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3180D15BF;
	Fri, 18 Oct 2024 01:07:25 -0700 (PDT)
Received: from pluto.. (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9157E3F528;
	Fri, 18 Oct 2024 01:06:53 -0700 (PDT)
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
	dan.carpenter@linaro.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 2/5] firmware: arm_scmi: Calculate virtio PDU max size dynamically
Date: Fri, 18 Oct 2024 09:05:59 +0100
Message-ID: <20241018080602.3952869-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241018080602.3952869-1-cristian.marussi@arm.com>
References: <20241018080602.3952869-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCMI virtio transport maximum PDU size is currently hardcoded at build
time; this will not play well with the possibile retrieval of a different
size at run-time.

Make the virtio transport derive the maximum PDU size from the max_msg_size
provided by the SCMI core.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/transports/virtio.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/transports/virtio.c b/drivers/firmware/arm_scmi/transports/virtio.c
index d349766bc0b2..41aea33776a9 100644
--- a/drivers/firmware/arm_scmi/transports/virtio.c
+++ b/drivers/firmware/arm_scmi/transports/virtio.c
@@ -32,8 +32,8 @@
 
 #define VIRTIO_MAX_RX_TIMEOUT_MS	60000
 #define VIRTIO_SCMI_MAX_MSG_SIZE 128 /* Value may be increased. */
-#define VIRTIO_SCMI_MAX_PDU_SIZE \
-	(VIRTIO_SCMI_MAX_MSG_SIZE + SCMI_MSG_MAX_PROT_OVERHEAD)
+#define VIRTIO_SCMI_MAX_PDU_SIZE(ci) \
+	((ci)->max_msg_size + SCMI_MSG_MAX_PROT_OVERHEAD)
 #define DESCRIPTORS_PER_TX_MSG 2
 
 /**
@@ -90,6 +90,7 @@ enum poll_states {
  * @input: SDU used for (delayed) responses and notifications
  * @list: List which scmi_vio_msg may be part of
  * @rx_len: Input SDU size in bytes, once input has been received
+ * @max_len: Maximumm allowed SDU size in bytes
  * @poll_idx: Last used index registered for polling purposes if this message
  *	      transaction reply was configured for polling.
  * @poll_status: Polling state for this message.
@@ -102,6 +103,7 @@ struct scmi_vio_msg {
 	struct scmi_msg_payld *input;
 	struct list_head list;
 	unsigned int rx_len;
+	unsigned int max_len;
 	unsigned int poll_idx;
 	enum poll_states poll_status;
 	/* Lock to protect access to poll_status */
@@ -234,7 +236,7 @@ static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
 	unsigned long flags;
 	struct device *dev = &vioch->vqueue->vdev->dev;
 
-	sg_init_one(&sg_in, msg->input, VIRTIO_SCMI_MAX_PDU_SIZE);
+	sg_init_one(&sg_in, msg->input, msg->max_len);
 
 	spin_lock_irqsave(&vioch->lock, flags);
 
@@ -439,9 +441,9 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		if (!msg)
 			return -ENOMEM;
 
+		msg->max_len = VIRTIO_SCMI_MAX_PDU_SIZE(cinfo);
 		if (tx) {
-			msg->request = devm_kzalloc(dev,
-						    VIRTIO_SCMI_MAX_PDU_SIZE,
+			msg->request = devm_kzalloc(dev, msg->max_len,
 						    GFP_KERNEL);
 			if (!msg->request)
 				return -ENOMEM;
@@ -449,8 +451,7 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 			refcount_set(&msg->users, 1);
 		}
 
-		msg->input = devm_kzalloc(dev, VIRTIO_SCMI_MAX_PDU_SIZE,
-					  GFP_KERNEL);
+		msg->input = devm_kzalloc(dev, msg->max_len, GFP_KERNEL);
 		if (!msg->input)
 			return -ENOMEM;
 
-- 
2.46.1


