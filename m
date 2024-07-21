Return-Path: <linux-kernel+bounces-258152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D156593846F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02ADA1C2097B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73421433B0;
	Sun, 21 Jul 2024 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNwHKGIX"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762E2F870
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721560604; cv=none; b=OPi5KhMuqQiNs6gbAwmUZxSWTzEcXWxurYMeMCeUFx59SD9PjNtGM1tWZZ8mi/hflM3Igy9uMdmzBmxov2ruC18Pzr12iu8IAoS5UEfz0q9D5JCQMCHb4HM5kpBBNKpXWHMPU9FbEFbGJTX80mC1w6LGcNa4kQwu2CzvdxmV4YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721560604; c=relaxed/simple;
	bh=gSDr2qXiWunqD83kcCcfkWzmofL1UeyjfIsv5gb6YVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Et1jh9/l3YYSTmLGt6/T6mbaHAZk2xAX5lNIWIwAwxSKq9EQ1t46DWqo04lOKFSIZJULanQbJivbNVjBNKX6zAPTLFkogDWey791iXnGJzAIKkcFn61gGf1BT/xt8Xzh2X+OzBY9OmTrikrMLXxVQLNV2cHJqpEsTfSq+bmBB2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tNwHKGIX; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efef496ccso539089e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 04:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721560601; x=1722165401; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAUIBKUFiqHBE7OX0O7eWG2UC2nEpnjuYCzeR97fn5c=;
        b=tNwHKGIXQ6LBjtsoY4e4qSwmftmwP6EEArWld1e78O83YQB5Qxf9GQJXKc9zRurh9B
         CFET0OJVkf0t8P0FyoVCA4wj9dJNWciA/6hKKhLIbSnWdQvWxV8nRM+yO3z7m0+a0RIF
         sgLPFmg7CxIj1SBEwjrUL4sOwSwI4IMcIzLejxy9/qNzrEWTAxHnmvIiG9bMuvIqnegl
         rfwARI6GuK43XY27Sw8fSzM3hwiWiZxS2hN1m20sOXCz92sYKLzBJt8Hm4Ke3lv6/rxw
         hG18rIvUGJZhpAAlqZT4UU/Dj9voV9UOnmCS6WgNq4I67ZIaAJZvisNv7kAPgGgnvU2V
         4JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721560601; x=1722165401;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAUIBKUFiqHBE7OX0O7eWG2UC2nEpnjuYCzeR97fn5c=;
        b=a1QkY8PVlezO9mth3xpsKGxVTRBqWsrHbPaNzzcdA49J8FcBZ3sjOCaLe3jqoscatu
         kRWY7j/Q3ZmnafuuqdIo5m5D5WaWC6SNWrzUtqq7cPTb13CNmudRscl8PeLm944DiABC
         iyuwAblf2JgFq2MyLR7rpQULyXrWtO7BncbkMTqAuCdJfeVwnQGohzi8pu+nMeNicQn/
         7IG2sWwunTU6wq4gLTetNSp1/liAfnafAq+EH6vZXDmWbK4LvWbyzZELxe0joLd2obyG
         W8n7K8h9rOyQZQueitas23npdb51R1H7d6TSyte/1fNPdKKuagAWMq7eBuYwlGSYDYhD
         Lf/A==
X-Forwarded-Encrypted: i=1; AJvYcCUCtIc6t7j2zfi4CQU0bxV6IUHG/VtLTT/6YCRUC8tKVtzSpHl+Ik/biqsvt7BLQRyEc2LbZkSwbeTqfWkFuTbIx5yl6E8932po3Xmq
X-Gm-Message-State: AOJu0Yx0a1Qdk5J216JwDpb90AVelpKK4qN0oX057DObvasu20RBGHwN
	dpQMvUydKnJVt5JK3WLaHPean8ssp2ny5oktP3KOB3ZDDNT3cIXNDq2G5Jq3Mwku8px8IS3R9K5
	O
X-Google-Smtp-Source: AGHT+IEY2idVUSGtat10CMxDBXzEMzhFrrDcQu9qRLhhVyj0rYaxZmSkj5WTR7wjcMw1NB1n7aTjHQ==
X-Received: by 2002:a05:6512:695:b0:52c:8b11:80cf with SMTP id 2adb3069b0e04-52ef0702ae6mr2563685e87.8.1721560600793;
        Sun, 21 Jul 2024 04:16:40 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef5578506sm822451e87.295.2024.07.21.04.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 04:16:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 21 Jul 2024 14:16:39 +0300
Subject: [PATCH] thermal/drivers/qcom/lmh: remove false lockdep backtrace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240721-lmh-lockdep-v1-1-c1bf919b442f@linaro.org>
X-B4-Tracking: v=1; b=H4sIABbunGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyND3ZzcDN2c/OTslNQCXQuLlFQDy1RzcwMLSyWgjoKi1LTMCrBp0bG
 1tQCu+DtRXQAAAA==
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2582;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=gSDr2qXiWunqD83kcCcfkWzmofL1UeyjfIsv5gb6YVw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmnO4Xrovb9aqAuAdMv9r/yiaa+XQt85hSxSvkN
 S02LdJPRPWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZpzuFwAKCRCLPIo+Aiko
 1YMfB/96eLGyMclo0vwO45CrMn9SgiqDGn+AOGcUjdu+za39MOncl4XANqiLM2cTVTris9Gl34l
 7za8lffSnrIkvl6bRqidLnmEyxiYVRIlSpQ8y6noxVxc1qNvIlWHNsMgqhwcZAPhHX7mlE2RHek
 0qDm2RBTUVLKVwB6Gd2v/+e0L/vdaXJtvhgK79pTsox7pADYLJ12PRgKRnyV3PS9Wj8PzSrYc1I
 zDxLvuUfacsDKnP/mPihVrSZn234rj9tHVAFXf+i8IENO421BtfhRz/2meEsQ72X3ggVUAA9PE/
 vFHWKoeBgIq9O27I9iWpRqLZ3AWQw/1eoHIRVIvpxaIKAaYK
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Annotate LMH IRQs with lockdep classes so that the lockdep doesn't
report possible recursive locking issue between LMH and GIC interrupts.

For the reference:

       CPU0
       ----
  lock(&irq_desc_lock_class);
  lock(&irq_desc_lock_class);

 *** DEADLOCK ***

Call trace:
 dump_backtrace+0x98/0xf0
 show_stack+0x18/0x24
 dump_stack_lvl+0x90/0xd0
 dump_stack+0x18/0x24
 print_deadlock_bug+0x258/0x348
 __lock_acquire+0x1078/0x1f44
 lock_acquire+0x1fc/0x32c
 _raw_spin_lock_irqsave+0x60/0x88
 __irq_get_desc_lock+0x58/0x98
 enable_irq+0x38/0xa0
 lmh_enable_interrupt+0x2c/0x38
 irq_enable+0x40/0x8c
 __irq_startup+0x78/0xa4
 irq_startup+0x78/0x168
 __enable_irq+0x70/0x7c
 enable_irq+0x4c/0xa0
 qcom_cpufreq_ready+0x20/0x2c
 cpufreq_online+0x2a8/0x988
 cpufreq_add_dev+0x80/0x98
 subsys_interface_register+0x104/0x134
 cpufreq_register_driver+0x150/0x234
 qcom_cpufreq_hw_driver_probe+0x2a8/0x388
 platform_probe+0x68/0xc0
 really_probe+0xbc/0x298
 __driver_probe_device+0x78/0x12c
 driver_probe_device+0x3c/0x160
 __device_attach_driver+0xb8/0x138
 bus_for_each_drv+0x84/0xe0
 __device_attach+0x9c/0x188
 device_initial_probe+0x14/0x20
 bus_probe_device+0xac/0xb0
 deferred_probe_work_func+0x8c/0xc8
 process_one_work+0x20c/0x62c
 worker_thread+0x1bc/0x36c
 kthread+0x120/0x124
 ret_from_fork+0x10/0x20

Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/lmh.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 5225b3621a56..d2d49264cf83 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -73,7 +73,14 @@ static struct irq_chip lmh_irq_chip = {
 static int lmh_irq_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	struct lmh_hw_data *lmh_data = d->host_data;
+	static struct lock_class_key lmh_lock_key;
+	static struct lock_class_key lmh_request_key;
 
+	/*
+	 * This lock class tells lockdep that GPIO irqs are in a different
+	 * category than their parents, so it won't report false recursion.
+	 */
+	irq_set_lockdep_class(irq, &lmh_lock_key, &lmh_request_key);
 	irq_set_chip_and_handler(irq, &lmh_irq_chip, handle_simple_irq);
 	irq_set_chip_data(irq, lmh_data);
 

---
base-commit: 797012914d2d031430268fe512af0ccd7d8e46ef
change-id: 20240721-lmh-lockdep-88de09e77089

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


