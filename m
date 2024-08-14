Return-Path: <linux-kernel+bounces-285899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB933951404
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9820A1F255A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1918855887;
	Wed, 14 Aug 2024 05:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TS0uLLUB"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64712D20D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723614290; cv=none; b=jaBotGy0vaLc/VzV8tFr0Hs4NxK2DsRUcRVZl07Do2iFOfDJWhhz+849U8pNmQZWJWKw/VI9c2UfkSpvpPSsZVg0FfkjHAM4faDzUwHUOKpa63tOMlT9UO24xibCxn1YAqzP9MKdEN6GBFlK967NW/vLiIgnHhO+Vt8zZ1mD+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723614290; c=relaxed/simple;
	bh=DY/EnKxUgw/t3JJe/H9FARv02RC+Lgp7w5T672pTog4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPX3CueERzCWhMUvBkubv1iL9hamdWsx4ClSakdRPfhPRBmmCosLwMaYJX7POVtF++9mFJerj9ysu3viQ/+y/I5aTxIEIpEh6b160uNes6vc9nqBv9P+F0nmvnMxJ1J5cdZLs6nIejRwNyWGls1YVCFSZSzanD5tNf6c5Ndnh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TS0uLLUB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7b80afeb099so3956736a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723614288; x=1724219088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALi80qQywvgRdU6+eXIGrdG4mei/lQM5/cjgvbw3p6w=;
        b=TS0uLLUBchswfVArE1Cn9jArUAk9pBbEq8cMliqrhu9mZK81JzTXzKB6bHYP1fOxlB
         KGfa5QJM3ewaRN4gueUI4DqZiYU6pBx+Yuz9sPssWU/+Mush5cE0FJULmNHhnIf7nWxm
         WE2kSQZ5OXCI6TMURkTdjHBwBeXFXS2Dqb8san3nt1MJZhk277nZhYO7XEc4ZCeu0KgH
         fkFMkFMcM+QKc0o06OER6jJNPA+F20AwFuIohTXFkMJelVpDB9/RortsTBDcNRU2tiKT
         U87ElhMKxpDy2hREuUouzapqLgFW9tWJvn1yrFrqmGeUW7aTUcWGM8OtcRnnn7m1Tom6
         MDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723614288; x=1724219088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALi80qQywvgRdU6+eXIGrdG4mei/lQM5/cjgvbw3p6w=;
        b=wbaVHEv34Gp7rvcU6V9aKtpX8IYS3tUslVHYqiKVOHAdRarwXfMNyuT3E5NjKKlHl4
         BBBmEz0vYialrXq57Eu9hyLAfU1D3TGM1vLvd+/RzUWzDgrJur4roKSlzTVcM9Bbx9JI
         3JXYgf4POzvuUL//Ip9tKhJJcAIzF8Jz2Y4Q4PcdcnbOq16Z/iUrCjPxDPWmjQySwrNh
         8gqlKLwo9TkqIFwrGcRUbX2y9vd48pTUzy9hBTzCJ3Vs9TD15zgxampJvr87ZuwrmO6s
         AMY4FdG5MUVY9BtWxQQ/gBCnqedy5Pk7BJ96g9XlwOopAwSfxrrbfy/cWi5CT0Sr5hh3
         Xjcg==
X-Forwarded-Encrypted: i=1; AJvYcCUqgYhTuPzTdgd46KWxuEUgAP+TkRIZG9GUndQtYrQx2/0vdDsvLeK8icysAeuKZJgxFOcMKLMHPJTrrUixmc5ZHz9Aaq7UoWy/pBBk
X-Gm-Message-State: AOJu0YzJt5xsOa9rpbZpETFM6WgCaBhAx+rIa/aMIlGRq62NU49jWKIR
	9sSRzC2QKiY8fsAVYhEFCQImguUc2VBWoxqPIBuWyFLbJGHHQ1GImoqWeO5V7ow=
X-Google-Smtp-Source: AGHT+IGdGbklP55z7Stx4FlDdzAVCAAfA6mUFaLw7+5KDYOKNc1xThXBt1NMzPRtP1UnIPwA1wPDcg==
X-Received: by 2002:a05:6a21:398:b0:1c2:94ad:1c67 with SMTP id adf61e73a8af0-1c8eaed5ed2mr2299929637.30.1723614288396;
        Tue, 13 Aug 2024 22:44:48 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1ab486sm22062085ad.150.2024.08.13.22.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 22:44:48 -0700 (PDT)
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
Cc: Nick Hu <nick.hu@sifive.com>
Subject: [PATCH v2 2/2] cpuidle: riscv-sbi: Add cpuidle_disabled() check
Date: Wed, 14 Aug 2024 13:44:34 +0800
Message-Id: <20240814054434.3563453-3-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814054434.3563453-1-nick.hu@sifive.com>
References: <20240814054434.3563453-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The consumer devices that inside the cpu/cluster power domain may register
the genpd notifier where their power domains point to the pd nodes under
'/cpus/power-domains'. If the cpuidle.off==1, the genpd notifier will fail
due to sbi_cpuidle_pd_allow_domain_state is not set. We also need the
sbi_cpuidle_cpuhp_up/down to invoke the callbacks. Therefore adding a
cpuidle_disabled() check before cpuidle_register() to address the issue.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 98e7751dbfe8..3c8a509288f3 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -25,6 +25,7 @@
 #include <asm/smp.h>
 #include <asm/suspend.h>
 
+#include "cpuidle.h"
 #include "dt_idle_states.h"
 #include "dt_idle_genpd.h"
 
@@ -336,6 +337,9 @@ static int sbi_cpuidle_init_cpu(struct device *dev, int cpu)
 		return ret;
 	}
 
+	if (cpuidle_disabled())
+		return 0;
+
 	ret = cpuidle_register(drv, NULL);
 	if (ret)
 		goto deinit;
@@ -548,7 +552,10 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
 	/* Setup CPU hotplut notifiers */
 	sbi_idle_init_cpuhp();
 
-	pr_info("idle driver registered for all CPUs\n");
+	if (cpuidle_disabled())
+		pr_info("cpuidle is disabled\n");
+	else
+		pr_info("idle driver registered for all CPUs\n");
 
 	return 0;
 
-- 
2.34.1


