Return-Path: <linux-kernel+bounces-576827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCC6A714D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22219189FD70
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157411C84BD;
	Wed, 26 Mar 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qzi9hM7q"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70C1B393A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984891; cv=none; b=lO+RTOxoHp8wEpVZn0415C4WN+jy+8uDkqDeby7wqfTn7wdIjVeF71mzPJz5niGCTV7t4rWPPhjXnhnFiBFmLfIA5BtQcyqAMOU1/4lvV4mNPY6EAR1ewCbYkcfiP/wMvjX3dujkJfFbP9xsd3ZSHWisCeMrZ8wQla/iO+pZ/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984891; c=relaxed/simple;
	bh=A7g5erTEnWIkdsckGVi5/bPrn40Wn5Avc/udvTqcAlU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=n/nvv4FyAKe9mRKGijlrcfD7HWT9NH4kwgBQSNdT6zjB5a6DEnk7zNAgkfchry+SmuRfZ34RnCBvuQIIUxl2aNa5Gt41tbIR+K/qotFN0enXYrK5ASOyJGn3iPmTggTscedbeq30h8f3RN374KvnBegVX7Z6s+WLnM4sfsPXr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qzi9hM7q; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742984582; bh=nIaOFhNr84R9BlJ0iJwxhdXvtzXEDs/CGd+I1BsLjh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qzi9hM7q5fW8H7Vf9Juf3Klw6OcWMHhF591iQupFGjYf7KkUohxbPh3bG6H2Le5OH
	 jqSGKTT3enKWJ7GtsvJbtpf2wp2LhvfIa8Feyy0JBhtPYzPXk33bf1Cgs6lFOx609t
	 Ud38oRujYXH2MOmYZ2POrBKUFPLRQjC0f+CmB2vU=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 43082E52; Wed, 26 Mar 2025 18:16:48 +0800
X-QQ-mid: xmsmtpt1742984208tkq0zmhro
Message-ID: <tencent_805B80CE895FEC9294314C21C511E09C3007@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx696PoZE8VmuxEuxwmZMVJQIksu4ZfLmGJoCOTEgcoPo1ff7ggK/H
	 Kod8y2SAecEIqw1/OwCgUmU4jTQq6brgETveUD72MbRi/Juz0waQQEpmOWnclXYtQ+N9c0RByNUp
	 PImdAy9GM9nodXP7FH0B+gM18NNKPJmM0UYGzVNK2XHE0eBJ/0S33pu0rdUPsERP/2UJFQjx4Zsj
	 gJEBvoJcMeaxjJ9puxyPjdoQnAcpAqHKm2fsuXHPprpQS08dZjZf4wEaXVM3tLPD7D842ZRTB49K
	 mLZlo/u7eeAzT830/OsthGur6+eg8P1EHKuXa9m5/PbfNFIcqbz/wT4+ZO33yq2DYPcRx6atiJHB
	 ttstHL8YUQ2qG1rKwKkF1RlKc0m8/zt6r1UaUyk3hu9XwZ85kg+Nt+IlN3DDVGZlQoyxEgPkZ0MT
	 busOxDFBx8iP6fOSgU/RI2HB3JF43d52gU3UqocmMpDJwIQv1v7sQxCUZ80RLyGzxLxt2JPXXIDq
	 /LWS9QpmcZaEk4v07jxN/sFkCUvfUiL9U0AT+xM7/j6I7hK9hfotleEVimUydlUpCLarRC8XLx6F
	 Bm3n+hFjhn4XrLZd0PYHCyPhAI8vfc37e6iEEJMNecDbGEzwXwzcrxOEvijeAugUMpS0YsiWbCb4
	 +NvlyxkT7Id7bA6G9gQot54teUOGBMxMpQ0KUyHcKRDOVhBoRSE5vqIYGPKTS1L3+kXeIYV02NEr
	 /XisoCNbu2Oo4frtE89gwGwIE0fYcvMCN3SBqlATpMYHdTjX2M/APkYkQBs7kxIEn5eDmnzM0JEY
	 QtOShWsyxMLtX3k3cvP6aBMDcikFZOcuC1nb48l3s7UpLJWofSzlYqv4inFNh+Fzh1WKh0598zDn
	 +kW6IGSv6hoX9/NJNYRJtqIr2WHvczkkBggt/YANdQqq+56/0P5wcAgK1NpAHwznw6At4AoUdQBY
	 L1I7+TNHjaWoCoOwmtOA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 3/3] nvme: add per-controller sysfs interface for APST configuration
Date: Wed, 26 Mar 2025 18:16:47 +0800
X-OQ-MSGID: <20250326101647.1353882-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_FD614E97ED4F67FE2F74C9C158AB50E7C806@qq.com>
References: <tencent_FD614E97ED4F67FE2F74C9C158AB50E7C806@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

Currently, APST (Autonomous Power State Transition) parameters are
configured as module parameters affecting all controllers uniformly,
 This lacks flexibility for heterogeneous systems.

This patch introduces per-controller sysfs attributes under each NVMe
controller's sysfs directory:
- apst_primary_timeout_ms
- apst_secondary_timeout_ms
- apst_primary_latency_tol_us
- apst_secondary_latency_tol_us

The attributes allow runtime configuration of:
1. Timeout values for primary/secondary states
2. Latency tolerance requirements

The existing module parameters are retained for backward compatibility
but now only serve as default values for new controllers.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/nvme/host/core.c  | 16 ++++++++++------
 drivers/nvme/host/nvme.h  |  4 ++++
 drivers/nvme/host/sysfs.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cfce433c5553..812e0a1f3b53 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2608,22 +2608,22 @@ static int nvme_configure_host_options(struct nvme_ctrl *ctrl)
  * timeout value is returned and the matching tolerance index (1 or 2) is
  * reported.
  */
-static bool nvme_apst_get_transition_time(u64 total_latency,
+static bool nvme_apst_get_transition_time(struct nvme_ctrl *ctrl, u64 total_latency,
 		u64 *transition_time, unsigned *last_index)
 {
-	if (total_latency <= apst_primary_latency_tol_us) {
+	if (total_latency <= ctrl->apst_primary_latency_tol_us) {
 		if (*last_index == 1)
 			return false;
 		*last_index = 1;
-		*transition_time = apst_primary_timeout_ms;
+		*transition_time = ctrl->apst_primary_timeout_ms;
 		return true;
 	}
 	if (apst_secondary_timeout_ms &&
-		total_latency <= apst_secondary_latency_tol_us) {
+		total_latency <= ctrl->apst_secondary_latency_tol_us) {
 		if (*last_index <= 2)
 			return false;
 		*last_index = 2;
-		*transition_time = apst_secondary_timeout_ms;
+		*transition_time = ctrl->apst_secondary_timeout_ms;
 		return true;
 	}
 	return false;
@@ -2728,7 +2728,7 @@ int nvme_configure_apst(struct nvme_ctrl *ctrl)
 		 * for higher power states.
 		 */
 		if (apst_primary_timeout_ms && apst_primary_latency_tol_us) {
-			if (!nvme_apst_get_transition_time(total_latency_us,
+			if (!nvme_apst_get_transition_time(ctrl, total_latency_us,
 					&transition_ms, &last_lt_index))
 				continue;
 		} else {
@@ -4853,6 +4853,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->ka_last_check_time = jiffies;
 
 	mutex_init(&ctrl->apst_lock);
+	ctrl->apst_primary_timeout_ms = apst_primary_timeout_ms;
+	ctrl->apst_secondary_timeout_ms = apst_secondary_timeout_ms;
+	ctrl->apst_primary_latency_tol_us = apst_primary_latency_tol_us;
+	ctrl->apst_secondary_latency_tol_us = apst_secondary_latency_tol_us;
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7f8e10f5bf7a..ed9afc3c6781 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -387,6 +387,10 @@ struct nvme_ctrl {
 	/* Power saving configuration */
 	struct mutex apst_lock;
 	u64 ps_max_latency_us;
+	u64 apst_primary_timeout_ms;
+	u64 apst_secondary_timeout_ms;
+	u64 apst_primary_latency_tol_us;
+	u64 apst_secondary_latency_tol_us;
 	bool apst_enabled;
 
 	/* PCIe only: */
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 5003cb294d65..afa61e9c1366 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -684,6 +684,37 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
+#define nvme_apst_show_and_store_function(field)				\
+static ssize_t field##_show(struct device *dev,		\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
+	return sysfs_emit(buf, "%llu\n", ctrl->field);	\
+}									\
+									\
+static ssize_t field##_store(struct device *dev,		\
+			     struct device_attribute *attr,		\
+			     const char *buf, size_t size)		\
+{									\
+	int err;						\
+	u64 data = 0;					\
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
+	err = kstrtou64(buf, 0, &data);		\
+	if (err < 0)						\
+		return err;						\
+							\
+	mutex_lock(&ctrl->apst_lock);		\
+	ctrl->field = data; 	\
+	mutex_unlock(&ctrl->apst_lock);		\
+	return size;			\
+}									\
+static DEVICE_ATTR_RW(field);
+
+nvme_apst_show_and_store_function(apst_primary_timeout_ms);
+nvme_apst_show_and_store_function(apst_secondary_timeout_ms);
+nvme_apst_show_and_store_function(apst_primary_latency_tol_us);
+nvme_apst_show_and_store_function(apst_secondary_latency_tol_us);
+
 static ssize_t apst_update_store(struct device *dev,
 					      struct device_attribute *attr,
 					      const char *buf, size_t size)
@@ -734,6 +765,11 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+
+	&dev_attr_apst_primary_timeout_ms.attr,
+	&dev_attr_apst_secondary_timeout_ms.attr,
+	&dev_attr_apst_primary_latency_tol_us.attr,
+	&dev_attr_apst_secondary_latency_tol_us.attr,
 	&dev_attr_apst_update.attr,
 	NULL
 };
-- 
2.25.1



