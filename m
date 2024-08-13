Return-Path: <linux-kernel+bounces-284291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3057C94FF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624301C22448
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4080D13A409;
	Tue, 13 Aug 2024 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TFRY1IKm"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6EC137930
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536812; cv=none; b=c7IeiOyD/d2ciMXFD8/f9hqs7clXZJPDQeYkGmfL39U/QoGM0H8iL5S1zJtbqJAc/jC5o/gU21WD9ps2B+/stUGBQa0DjuOmwNHUc+THWrSQwfO2o8tKY87CchJnDQGygsTsfKFqmF6M/6l3ND0lBEsTQw1G8Hxpvhu8TxKdjHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536812; c=relaxed/simple;
	bh=KI/vFrEyEg5EFIYU/iBV01qglnGbaphkmdipf2rX5jo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gbHBNuMEHSvd+ReOzrpZwAd24jdN4/pm8C5OhzRFWX6jWqin1zJTLcj0KLiQho4Uez5TKIvH7dCWBmysE578+Uzkh08Knew18ppb/Jijdp2rKb+yiXFDiSU8FDNWek4YFWLbP91ldY6DW9nm2UL+UtaXDgQUSJtgMMmI4CdDNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TFRY1IKm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc60c3ead4so34457285ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723536810; x=1724141610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MPwCQlZV6XnO0rlNbX/WsNAZ1kHHhsOKatz4Qfacl5c=;
        b=TFRY1IKmKrfmoV4Uj0/os8oGPK3sHfDnk8E8Fd03OrC1ijShxK8oKI62ZpDeYcyrm0
         mXLM4JTJWJMgd0zDrhx/PlXg9TVKCvAvLVmmTCaFJa8KRX/Y9b9cv/bdWMhZ0PLoLpAe
         qsxh9XUcBC+wZJrSS0uqtKk5uOeUjkeYKqAZ7v/dpNyvtEHYI5RDg4N7A7csKBY/CukU
         YVahVS/n2+IR99uN/rRy0MgHBhjivRKgdhcLhyMZyQi8F7D/mvSuDI2pEUXUBqQaExPB
         3duQaqJLCsfgPf9qrUeSco61AsWS9a/TRFlAV+EfEYBmZHldbzNkyYyE2hneg2K4wSkm
         sbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723536810; x=1724141610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPwCQlZV6XnO0rlNbX/WsNAZ1kHHhsOKatz4Qfacl5c=;
        b=j3QKpa9Lsoxgw2Z/2Ia8oHtBXiniVLYuBd0Zfd0uEWM6Ld8Rwu1sAucaD7F3sq0MKs
         J+aZqs1P+ZxNXJ5zdQJsMaRwWo+UOiuFZMUDAxUz8X2CWF6NZ25ZVjYKytuXswMbNKIW
         PtfFt6dMBUzV5tweFES3uEBtHtFH7PJ49L4zKz/kzhi/APzaddx5pizeSYi7RLRH1W4/
         qTGVn6994SvWPZJEhJl5QPtxVXAzz7zc5QHPyLA6xykp/+5DNjX7JL0pNM4VMU3d7hEK
         44FOhM66dJcxy+yUgZh7K/qXa/ujj+nLVviiPcoveyVgTMUY99s0NMXY9pRDxV5vocT+
         Tn8w==
X-Forwarded-Encrypted: i=1; AJvYcCXpxQAoUPbe6lU15KXpW3sSnDJ3o0hnfLoLTD3p2E114LMSRq8xouMbi47BItBQNw9I1L+tYCDdyNz0F8XRCXxCkLGHEZRDiOf5bCoX
X-Gm-Message-State: AOJu0YzHmyMxypxSvXnHG4Iw5gwJmW2ru4wFm5zolZSQs7OjbXbcKfTZ
	qgBA8xEsQj4vMJ56b3JnX8jjM0cwKu6qL35SXgOr/NCY1ZQSJ3u0PeC25cmxI6Q=
X-Google-Smtp-Source: AGHT+IFGyOzsELsbEN5dq5CT9Zf/5PMWDUy7RodzkZu3Mk7cSMnkmo/3cHgdPDhbNHigLjznXjqnXw==
X-Received: by 2002:a17:902:d487:b0:1ff:39d7:a1b0 with SMTP id d9443c01a7336-201ca1ca41bmr30756345ad.50.1723536809857;
        Tue, 13 Aug 2024 01:13:29 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1e29afsm8289885ad.309.2024.08.13.01.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 01:13:29 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: anup@brainfault.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	greentime.hu@sifive.com,
	zong.li@sifive.com
Cc: Nick Hu <nick.hu@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] cpuidle: riscv-sbi: Allow cpuidle pd used by other devices
Date: Tue, 13 Aug 2024 16:13:24 +0800
Message-Id: <20240813081324.3205944-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent the probe of consumer devices being deferred, create the
platform devices for each pd node under '/cpus/power-domains' and move the
driver initailization to the arch_initcall.
The consumer devices that inside the cpu/cluster power domain may register
the genpd notifier where their power domains are point to the pd nodes
under '/cpus/power-domains'. If the cpuidle.off==1, the genpd notifier
will fail due to sbi_cpuidle_pd_allow_domain_state is not set. We also
need the sbi_cpuidle_cpuhp_up/down to invoke the callbacks. Therefore,
add a cpuidle_disabled() check before registering the cpuidle driver to
address the issue.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Link: https://lore.kernel.org/lkml/20240226065113.1690534-1-nick.hu@sifive.com/
Suggested-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index a6e123dfe394..d6b01fc64f94 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -25,6 +26,7 @@
 #include <asm/smp.h>
 #include <asm/suspend.h>
 
+#include "cpuidle.h"
 #include "dt_idle_states.h"
 #include "dt_idle_genpd.h"
 
@@ -336,6 +338,9 @@ static int sbi_cpuidle_init_cpu(struct device *dev, int cpu)
 		return ret;
 	}
 
+	if (cpuidle_disabled())
+		return 0;
+
 	ret = cpuidle_register(drv, NULL);
 	if (ret)
 		goto deinit;
@@ -380,20 +385,26 @@ static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
 struct sbi_pd_provider {
 	struct list_head link;
 	struct device_node *node;
+	struct platform_device *pdev;
 };
 
 static LIST_HEAD(sbi_pd_providers);
 
 static int sbi_pd_init(struct device_node *np)
 {
+	struct platform_device *pdev;
 	struct generic_pm_domain *pd;
 	struct sbi_pd_provider *pd_provider;
 	struct dev_power_governor *pd_gov;
 	int ret = -ENOMEM;
 
+	pdev = of_platform_device_create(np, np->name, NULL);
+	if (!pdev)
+		goto out;
+
 	pd = dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
 	if (!pd)
-		goto out;
+		goto free_pdev;
 
 	pd_provider = kzalloc(sizeof(*pd_provider), GFP_KERNEL);
 	if (!pd_provider)
@@ -419,6 +430,7 @@ static int sbi_pd_init(struct device_node *np)
 		goto remove_pd;
 
 	pd_provider->node = of_node_get(np);
+	pd_provider->pdev = pdev;
 	list_add(&pd_provider->link, &sbi_pd_providers);
 
 	pr_debug("init PM domain %s\n", pd->name);
@@ -430,6 +442,8 @@ static int sbi_pd_init(struct device_node *np)
 	kfree(pd_provider);
 free_pd:
 	dt_idle_pd_free(pd);
+free_pdev:
+	of_platform_device_destroy(&pdev->dev, NULL);
 out:
 	pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
 	return ret;
@@ -447,6 +461,7 @@ static void sbi_pd_remove(void)
 		if (!IS_ERR(genpd))
 			kfree(genpd);
 
+		of_platform_device_destroy(&pd_provider->pdev->dev, NULL);
 		of_node_put(pd_provider->node);
 		list_del(&pd_provider->link);
 		kfree(pd_provider);
@@ -548,7 +563,10 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
 	/* Setup CPU hotplut notifiers */
 	sbi_idle_init_cpuhp();
 
-	pr_info("idle driver registered for all CPUs\n");
+	if (cpuidle_disabled())
+		pr_info("cpuidle is disabled\n");
+	else
+		pr_info("idle driver registered for all CPUs\n");
 
 	return 0;
 
@@ -592,4 +610,4 @@ static int __init sbi_cpuidle_init(void)
 
 	return 0;
 }
-device_initcall(sbi_cpuidle_init);
+arch_initcall(sbi_cpuidle_init);
-- 
2.34.1


