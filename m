Return-Path: <linux-kernel+bounces-576817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FBEA714C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3003BB9BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AB81C861B;
	Wed, 26 Mar 2025 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="K+MJBcRF"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218631C84D3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984599; cv=none; b=B9C7MVBBhmR7ZiAU1YIBAbsPqn6bX0cFMJqR5q4IOfSsQi0ut+cKAlkm57wuxxSXPwFPxbiQFoHsXl2T73zoWMGAYdFgseRHvjTNl+SvG/u+ThfvPu3O3DSh4cfqtH5EQPX+9agAi0M3d9FqBo1xmhvTOn3SCkH9HzfFI0M7TmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984599; c=relaxed/simple;
	bh=VRbt9M7GxKWMUSjZmb14cR0Em9o5VMrCRIUA6byEed4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hdQuk+lAWqYsprboMRjvk00po4aNgBiDlPWsoWWfoD84HVQNH069fKDr0LgxyRFCAjCkYxPcEv3gEiXLqAsp3hNvweVuKspTvSuEvAKUzvb839JDoSHOD4MoZMbOeDlTr7VWckWMCzLHY2o9icJDtQ6AIZQj5/ijV4qQ4Zzmi/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=K+MJBcRF; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742984586; bh=CXOxzSBc81SY9jtwgQfdy/KYkhvUkVXESNbfLq9w2L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K+MJBcRF6OszIxfoDFvYh2uItEZUj8EPw8IwOlsHEyqCvZBuxEbqDlSFHn7TQ4h6T
	 XexjBbvEdPw8RwTWsIwvHYY/XEshW2TE39GhzzjurBdHlaXpy0QFytmSbWYdrKvBO0
	 u1QHD/HBuKsoLgxfy5u5j9ZyujeT9l8zf8fA98kg=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 42821883; Wed, 26 Mar 2025 18:16:40 +0800
X-QQ-mid: xmsmtpt1742984200t5ml4h1h7
Message-ID: <tencent_10273AE37EBF4B64C7988400467673566C09@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9UdRif9mToAQRMObCgm5SPPK0FZCAWaSNErEipKDq/qJrxMW39K
	 Hf48/mxKaoCJI+ntbYnarguqxERydJLbYfn2iYg37vur+LlanSprL/7FNiwLrukYRtcgxIc/Rhhw
	 uGk7jIoUNgb7OL1kqNUG2h9IbubhvEpgykqAi3JViilsu5GqNUeRDZHV4hkUxUcNKsp+l8CVAn1Z
	 ddv6jIAauhLylInwIoWrpLjwVPgj5hixc+QCCsjpV/xO2uAjCouGzFoSXZfrYwvwWYNX5OJUk0rp
	 KHvrrOlOy1iWHNJeSi7vCe8hLibTKjwE8V2dokN20iONZ82aoSJf0VmyYcay2QSd/YLDgHoJHi7+
	 Jrkg6VD2Lxl/raKGTFtxD0LA21cyJaV6nEh7dfZFHGFQrnauQqKdJ/srNaYep/DiL/8iGePdg/jF
	 Bnp+x9f7gc3oGDtJ40CqJ1IX71tCLayXj4wWJ3U8NDuBEMB9W6L7qvOMWuWWCwzdc4T/iKjT1xlW
	 iTp2eEAeVYXhHSLUrnCDRoKmGOObEcVd4Z/oMTZghEWj7bYqRbRDP0X+OED+ldUcOcgMQV0sqDa8
	 Z25CYLprgI64CuZj2AvjGgNfXaI5UpBwuGzfVz06cGZ+vqf89VaK66xqeTalVjdh42o0q+oJkEHu
	 3VRWqi7ZDoO6mmO4d0U75IJYQgds1zhkE9wL5vIaeRBe0WrtGYvSxj850t9KW1qz8hvnGwf0+nml
	 W4i2Z6G1q3nIV1xLU5ZfzU116R2uocPAY9F+3eEeLlJyGLE+xB0foMKW6IBuKbRiq3S+5aLi0pgq
	 dl6MT2f96apYG1CL/MSUoXU2mtEkrFcXBPaN5Azqrvzl73eFwbSe+13rJ4kieHocEca5CZw7BL9G
	 lZxBH05X862IGewuvAQcii6GSzHSDjy3o/Uy0Jl9nbDVQGLi678bOQrndA1p/pGo3cfmN2X+feir
	 RN8KDwxt0JrYlP/XPpCAMdwjGFFG6HE/Pj+vlGyZ0=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 2/3] nvme: add sysfs interface for APST table updates
Date: Wed, 26 Mar 2025 18:16:38 +0800
X-OQ-MSGID: <20250326101638.1353393-1-iambestgod@qq.com>
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

Currently, the APST (Autonomous Power State Transition) table can only be
updated during module initialization via module parameters or indirectly
by setting QoS latency requirements. This patch adds a direct sysfs
interface to allow dynamic updates to the APST table at runtime.

The new sysfs entry is created at:
/sys/class/nvme/<controller>/apst_update

This provides more flexibility in power management tuning without
requiring module reload or QoS latency changes.

Example usage:
update nvme module parameters.
echo 1  > /sys/class/nvme/nvme0/apst_update

Signed-off-by: Yaxiong Tian  <tianyaxiong@kylinos.cn>
---
 drivers/nvme/host/core.c  |  4 +++-
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fb0404fee551..cfce433c5553 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2654,7 +2654,7 @@ static bool nvme_apst_get_transition_time(u64 total_latency,
  *
  * Users can set ps_max_latency_us to zero to turn off APST.
  */
-static int nvme_configure_apst(struct nvme_ctrl *ctrl)
+int nvme_configure_apst(struct nvme_ctrl *ctrl)
 {
 	struct nvme_feat_auto_pst *table;
 	unsigned apste = 0;
@@ -4852,6 +4852,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	ctrl->ka_last_check_time = jiffies;
 
+	mutex_init(&ctrl->apst_lock);
+
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
 	ctrl->discard_page = alloc_page(GFP_KERNEL);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 51e078642127..7f8e10f5bf7a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -385,6 +385,7 @@ struct nvme_ctrl {
 	key_serial_t tls_pskid;
 
 	/* Power saving configuration */
+	struct mutex apst_lock;
 	u64 ps_max_latency_us;
 	bool apst_enabled;
 
@@ -828,6 +829,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
+int nvme_configure_apst(struct nvme_ctrl *ctrl);
 
 static inline enum req_op nvme_req_op(struct nvme_command *cmd)
 {
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 6d31226f7a4f..5003cb294d65 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -684,6 +684,28 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
+static ssize_t apst_update_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t size)
+{
+	int err;
+	bool bool_data = false;
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	err = kstrtobool(buf, &bool_data);
+
+	if (err)
+		return err;
+
+	if (bool_data && nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE) {
+		mutex_lock(&ctrl->apst_lock);
+		nvme_configure_apst(ctrl);
+		mutex_unlock(&ctrl->apst_lock);
+	}
+
+	return size;
+}
+static DEVICE_ATTR_WO(apst_update);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -712,6 +734,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+	&dev_attr_apst_update.attr,
 	NULL
 };
 
-- 
2.25.1


