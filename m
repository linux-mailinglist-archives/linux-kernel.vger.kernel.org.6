Return-Path: <linux-kernel+bounces-381747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F79B03BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239181C2234C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A21FB8AE;
	Fri, 25 Oct 2024 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFrwdN2I"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988F20F3DF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862106; cv=none; b=GJOJ4tNZteluCz889BdQEMH/1A5pC0iLQ3z5XhFR6+TZX2Q4fqU77Ro/7gIHc5OVCGMXws9AjCsaA8gqnesIAp2TnL3KRS6fiB1g6xH85CF+wVN/8+JLNN1otAR8UrUMns9bR1/PoYovaA3ZwxCxUEMRfQZt3DpXTBRhxltImLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862106; c=relaxed/simple;
	bh=F2qnRTR340hKwHQSf4//6eO6VZH4516ssxBM5pftm4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPN25INOyx+2ou1ewmVfzHhFoPN3UZZfKDOQWFhOkpCZQsZb+hbNVaCUVbFNuRhWLe9xTYlRWoQCaidj62wjSddfzA35mP29CespmuxeIpNcbY1tkhGvrUYDJpneqqhhVaZoV5wNiKXGBK5/MAgBWO+kmkfB0qliJw1Ku2WuYf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sFrwdN2I; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431695fa98bso19836865e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729862103; x=1730466903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ivh7+EYUuihJcPnZHjnVXOeazDxQAc1FZwbuTGARMJo=;
        b=sFrwdN2IyP3rYPRzWUw82FX+bSNpKhA4mzd+g3WF8t+qBMwV1Hh61iuP6RnZ1nv0C3
         HSkSFAFYcEv9/7/oKX7hF3Dg/wLKLmWi9YKvCDKohXrfn25AnKlFiltr654bpFiIEleJ
         abJpGn5sfu667qaAoUV7mQuDLQ6xEMSR/HQ2TOrxoB28eVewJpXU2AqgC99qoo1b7rjW
         2YlfGuPe1mlcWFvj1ASTPbqwqqk7+MBkjCTMk4uRsyYdhyin7ePCOd/3hYX0ewGnCTnC
         y52ObddhyJWCwgZL+u81OoXiCD2u0N6QTMMfWAGoHdMo8OeDsqjTmJzu4Mw5Cf0Axqpg
         Q1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862103; x=1730466903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ivh7+EYUuihJcPnZHjnVXOeazDxQAc1FZwbuTGARMJo=;
        b=fu012VkHSCPoUxGV26bYb03TwMzonQ2CeIXXyUwWyOQiJpzy+TN40/OiVBBkyoPThW
         y5F1HGbg7vhyWV3fJmJdUAgVtVgY5UO7JVooHl/Sf5f9E1HTo+BQK5lMWV7WdhVjMpTc
         uUyILsWuwXGjxJkSCCjXEXAaR8KCI5KDrauFdpaiCOCw+VbAq8HVNyg0uj56eGmY19Ce
         nrsS7zjoAM05tyu9pwI1o9bkpmlb/6ySiugVNxCIQco9y3FTHxpyxd3zzwZ30KtM7QTa
         tYErYZNTDvSgLmd7R/ff3nju+DDHOLT5g1VDaTH3oOUNus11tsxOD0ETlifbFgSkH5S4
         zKHA==
X-Forwarded-Encrypted: i=1; AJvYcCW3GO2jjlpERXPbeXEBxDcptgtTfb3zbhFbXEZUA5db1N5+OFm0B+DIaGTijsrSnb20Bzjsb7fqv6rM5Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvtYkPQc/On5zaG9Zfbh8+ZKxm3Yx4T8MW/kiylBBqFfPQbhQe
	8thCixQwWOGwD6t1OpXOXGCJfs8E1vgUf6U9uV8YVO1EvyfRy6UltrEg/LYItCE=
X-Google-Smtp-Source: AGHT+IFHaCs0Brlywx2EDejiKT/SRxUFjAkp/495iouOQYJDyac2EtGgBL2CMBR/7/lJY4x2bivyMQ==
X-Received: by 2002:a05:600c:4f88:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-4318c6ea2f0mr54335655e9.10.1729862102813;
        Fri, 25 Oct 2024 06:15:02 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.67.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b58b6bdsm47616685e9.45.2024.10.25.06.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 06:15:02 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	krzk@kernel.org
Cc: tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ebiggers@kernel.org,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 10/11] scsi: ufs: exynos: fix hibern8 notify callbacks
Date: Fri, 25 Oct 2024 14:14:41 +0100
Message-ID: <20241025131442.112862-11-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241025131442.112862-1-peter.griffin@linaro.org>
References: <20241025131442.112862-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 of the patch which introduced the ufshcd_vops_hibern8_notify() callback
used a bool instead of an enum. In v2 this was updated to an enum based on
the review feedback in [1].

ufs-exynos hibernate calls have always been broken upstream as it follows
the v1 bool implementation.

[1] https://patchwork.kernel.org/project/linux-scsi/patch/001f01d23994$719997c0$54ccc740$@samsung.com/

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
---
 drivers/ufs/host/ufs-exynos.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index fa4e61f152c4..3bbb71f7bae7 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1529,12 +1529,12 @@ static void exynos_ufs_dev_hw_reset(struct ufs_hba *hba)
 	hci_writel(ufs, 1 << 0, HCI_GPIO_OUT);
 }
 
-static void exynos_ufs_pre_hibern8(struct ufs_hba *hba, u8 enter)
+static void exynos_ufs_pre_hibern8(struct ufs_hba *hba, enum uic_cmd_dme cmd)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 	struct exynos_ufs_uic_attr *attr = ufs->drv_data->uic_attr;
 
-	if (!enter) {
+	if (cmd == UIC_CMD_DME_HIBER_EXIT) {
 		if (ufs->opts & EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL)
 			exynos_ufs_disable_auto_ctrl_hcc(ufs);
 		exynos_ufs_ungate_clks(ufs);
@@ -1562,11 +1562,11 @@ static void exynos_ufs_pre_hibern8(struct ufs_hba *hba, u8 enter)
 	}
 }
 
-static void exynos_ufs_post_hibern8(struct ufs_hba *hba, u8 enter)
+static void exynos_ufs_post_hibern8(struct ufs_hba *hba, enum uic_cmd_dme cmd)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 
-	if (!enter) {
+	if (cmd == UIC_CMD_DME_HIBER_EXIT) {
 		u32 cur_mode = 0;
 		u32 pwrmode;
 
@@ -1585,7 +1585,7 @@ static void exynos_ufs_post_hibern8(struct ufs_hba *hba, u8 enter)
 
 		if (!(ufs->opts & EXYNOS_UFS_OPT_SKIP_CONNECTION_ESTAB))
 			exynos_ufs_establish_connt(ufs);
-	} else {
+	} else if (cmd == UIC_CMD_DME_HIBER_ENTER) {
 		ufs->entry_hibern8_t = ktime_get();
 		exynos_ufs_gate_clks(ufs);
 		if (ufs->opts & EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL)
@@ -1672,15 +1672,15 @@ static int exynos_ufs_pwr_change_notify(struct ufs_hba *hba,
 }
 
 static void exynos_ufs_hibern8_notify(struct ufs_hba *hba,
-				     enum uic_cmd_dme enter,
+				     enum uic_cmd_dme cmd,
 				     enum ufs_notify_change_status notify)
 {
 	switch ((u8)notify) {
 	case PRE_CHANGE:
-		exynos_ufs_pre_hibern8(hba, enter);
+		exynos_ufs_pre_hibern8(hba, cmd);
 		break;
 	case POST_CHANGE:
-		exynos_ufs_post_hibern8(hba, enter);
+		exynos_ufs_post_hibern8(hba, cmd);
 		break;
 	}
 }
-- 
2.47.0.163.g1226f6d8fa-goog


