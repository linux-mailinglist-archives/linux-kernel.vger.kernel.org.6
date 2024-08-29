Return-Path: <linux-kernel+bounces-306055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A4396388E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB4F1C21CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469863BBCC;
	Thu, 29 Aug 2024 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="k0TfSTEp"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364014A00
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724900727; cv=none; b=eTFDS1qAb47IR5WT3TGn7xf/irVBjt0bA5nsrDr8Pi0c1+lXsVYvGbdN/IZgLaczoE1LZvYiqbNIy1wNcKIg+pKnDw6Kxav7kVB/ZiMko63KYtkr/X1sYI+yzIoMfXwC1+CBatq5KdGUwaaqSsV3hPnagZB203EDK/Z5Jigi4sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724900727; c=relaxed/simple;
	bh=NONFwEK/OkuxNCZ5XhngoOZ4k0fqWPYsb40vUq9Mk0E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=urEdhiJlhCWn7+JUA5mTzSE8Bo8ZScOH+mmle2W1XO6zH7xvs9vmVjrYV1IYdRTHb2PeguWJx/hxxjI2D2L3mkzayCR2BySjL5NV4puoc9RyPwGx+B5SbVCXs0YdzJyw67i31y7qHseG76yXNIYu4vqa3uOOYMqTLjVd7d6ikEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=k0TfSTEp; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 879393F5E4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724900293;
	bh=+h//h1u4VNN8yQMA42JFOOJYxZB7jSPI+KUI4YrKMnk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=k0TfSTEpDHA25lJfz6WwurOoElL6rwszdZqQtbwgI7nHeOX4BrrIWPYjcpI1oHiNl
	 w0cbs8gxgsW6cJysfeB187kHseIITXf1AliTcs8RguhRvj42Cv0m0iCtdQMAzRvFfT
	 EeMSPO1JCVVShJWEQqVvYoc7XNXVTiQC8NgK8+d6dyThzc4odzf0T9cN6T5IO4WHcQ
	 dcSp+kekwjPMaWVpWVZ0HYkBAiC/L2ODuocDVnZ9Gwd7ea6h/W9inNHrR/NU+VbPAO
	 QBN/DtoeURimInbJH6QxJDlLZdcDlwyuFw/M4vU/8upvhg6t7ZL0KLHyAkLu1M3UmL
	 oVeGx2zG/e6NQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-201ee593114so10949565ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724900292; x=1725505092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+h//h1u4VNN8yQMA42JFOOJYxZB7jSPI+KUI4YrKMnk=;
        b=AGj5MND6Xk0kWHvODwlnQNy+A9gkG2Rqj4i7DWSN3umIdug/Rv5RBnrVUpx6m0RhOg
         V7+5UpkecIIt7VNoa2qNTeQWIOQ+f5CUcygHIWuuig9/4awkgeUDg5hZQ4u+Z7zmWbOO
         x/X130sCOyy027HGGq8tvtGWXOedeVsPEvHgoNYIcNjfxWMcZ4QsK9IwQoaRQei5FsjC
         kXJCd1FM5pk/zDWxMtPp4L4lCPSEnRz0O1WaOLFdnaPfWokMInOVwmxwRobxVKBNnFH8
         2kw//zzKgYr47ODstzSM+4vS54pec2lhnFwvT+Ubk1rQjXQzYUrLPpigAUwCXIh/h94T
         RmbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVczllaSsXdu2TBELrbAT/KeA05x0idbMBkL3ZFRB3aE2OZ5T/PWIZGND03vXY+J7wirZA5LPXaSjNk8go=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMJEo8RrW8YLqFfatAomU8DBXFCWic5bwmFsPJOv3mWmfpcLx
	wyJ5sj1XY4KxB7ytnQCEmoaShgtZxSv0aB/pX33GSaT+xYKMlVDMaJ/PQFfGQLbSfzhJjPYTWmm
	BTqSh88Z0tuZcwY48qkzOk0eaQsDSZbg47w4R9S+k8s6sgE6Ho0QEAa2eudimzNEWBLQlhkko9R
	5Z6w==
X-Received: by 2002:a17:902:7087:b0:201:e2db:7be7 with SMTP id d9443c01a7336-20516743038mr2750565ad.13.1724900291982;
        Wed, 28 Aug 2024 19:58:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmbNWB34P18PQrxN3YT3XzJ2HAHmZtxZEyX9snuPC9wbBVBdVqO8dkGpqgtAZz0xb2gwNf0w==
X-Received: by 2002:a17:902:7087:b0:201:e2db:7be7 with SMTP id d9443c01a7336-20516743038mr2750335ad.13.1724900291565;
        Wed, 28 Aug 2024 19:58:11 -0700 (PDT)
Received: from solution.. (125-228-254-191.hinet-ip.hinet.net. [125.228.254.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155528d9sm1666315ad.264.2024.08.28.19.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 19:58:11 -0700 (PDT)
From: Jian Hui Lee <jianhui.lee@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Axel Lin <axel.lin@ingics.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] regulator: mt6359: Fix UBSAN shift-out-of-bounds
Date: Thu, 29 Aug 2024 10:58:07 +0800
Message-ID: <20240829025807.2455823-1-jianhui.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A shift-out-of-bounds will occur as caught by LTP fs:read_all_sys, if
modeset_mask has not been set for MT6359_LDO_LINEAR regulators.

Example command on MediaTek Genio 1200-EVK:
 # cat /sys/devices/platform/soc/10024000.pwrap/10024000.pwrap\:pmic/regulator/regulator.28/opmode

This patch initializes the member modeset_reg to zero, and checks it
before any further actions.

The related log:
UBSAN: shift-out-of-bounds in ../drivers/regulator/mt6359-regulator.c:281:9
shift exponent -1 is negative
CPU: 1 UID: 0 PID: 4473 Comm: cat Not tainted 6.11.0-rc2-custom #1
Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2022.10 10/01/2022
Call trace:
 dump_backtrace+0xa0/0x148
 show_stack+0x20/0x48
 dump_stack_lvl+0x80/0x130
 dump_stack+0x18/0x30
 __ubsan_handle_shift_out_of_bounds+0x144/0x250
 mt6359_regulator_get_mode+0x154/0x160 [mt6359_regulator]
 opmode_show+0x84/0x150
 dev_attr_show+0x28/0xa8
 sysfs_kf_seq_show+0x90/0x180
 kernfs_seq_show+0x34/0x60
 seq_read_iter+0x1f0/0x518
 kernfs_fop_read_iter+0x170/0x220
 vfs_read+0x288/0x338
 ksys_read+0x70/0x120
 __arm64_sys_read+0x24/0x48
 invoke_syscall+0x70/0x120
 el0_svc_common.constprop.0+0x48/0x138
 do_el0_svc+0x28/0x58
 el0_svc+0x40/0x1a8
 el0t_64_sync_handler+0x15c/0x178
 el0t_64_sync+0x1a8/0x1b0
---[ end trace ]---

Fixes: d6208ba87066 ("regulator: mt6359: Remove shift fields from struct mt6359_regulator_info")
Suggested-by: Yu-wen Fang <yu-wen.fang@mediatek.com>
Signed-off-by: Jian Hui Lee <jianhui.lee@canonical.com>
---
 drivers/regulator/mt6359-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/mt6359-regulator.c b/drivers/regulator/mt6359-regulator.c
index c8a788858824..24b1dcc5eee8 100644
--- a/drivers/regulator/mt6359-regulator.c
+++ b/drivers/regulator/mt6359-regulator.c
@@ -88,6 +88,7 @@ struct mt6359_regulator_info {
 		.enable_reg = _enable_reg,			\
 		.enable_mask = BIT(0),				\
 	},							\
+	.modeset_reg = 0,					\
 	.status_reg = _status_reg,				\
 	.qi = BIT(0),						\
 }
@@ -270,6 +271,9 @@ static unsigned int mt6359_regulator_get_mode(struct regulator_dev *rdev)
 	struct mt6359_regulator_info *info = rdev_get_drvdata(rdev);
 	int ret, regval;
 
+	if (!info->modeset_reg)
+		return REGULATOR_MODE_NORMAL;
+
 	ret = regmap_read(rdev->regmap, info->modeset_reg, &regval);
 	if (ret != 0) {
 		dev_err(&rdev->dev,
@@ -303,6 +307,9 @@ static int mt6359_regulator_set_mode(struct regulator_dev *rdev,
 	int ret = 0, val;
 	int curr_mode;
 
+	if (!info->modeset_reg)
+		return -EINVAL;
+
 	curr_mode = mt6359_regulator_get_mode(rdev);
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
-- 
2.43.0


