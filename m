Return-Path: <linux-kernel+bounces-289920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A2D954D56
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A449A2864EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B611BD519;
	Fri, 16 Aug 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYx180bK"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED61BCA1C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820980; cv=none; b=WaQ7L9WCKnj/ovmI4VGHbI/0tNYCkYey2a+R+Cqmq7NIbVFl1r2z0TMFGq42JLpPUeFeb9ZvNroIXS4dbUSn5a556gE7V4U3aK33r8tiyxVt2X+pMk26OFFknMcwYgtQvq88O4olORHqUrKQRDOX3mmm81Wg3YQRN33CW0i0IZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820980; c=relaxed/simple;
	bh=DutqlqHE6bdTfzEusV88EvHx97cLnaHqQXNHMGXgdd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRKwIE9XwVY69bn3XBdNExwMibCg+2HZ49uUZ5REuJAB0xtFlie3k7Z6XKhneLFlyqxFJXdL5xqJlbF6jvUBsxeT8UQiS97JmQkYZP+uugIqi7PaO4yk9N1fnSQkaapw3+O+r1ZFP0dvi5Q53WncM5hQKg97WVmpD112tJcs5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eYx180bK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3719753d365so400805f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723820977; x=1724425777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycsrSNVghYJYo7Kq/sAqp6MnjeFyaL9nJFuFS/dh9Nk=;
        b=eYx180bKiY4F/wON9/KOJ6RD1w+RQZ8Dg2nM/UDNm9Cc39OkfH4ljUt1xp51laaVdv
         Vu92t6YaDvD6KhjHAJk8STCRVHqltjMrPBivk+v4QTFeG3VUlyfMFslJ81UzRzxVVf2D
         jMluB0LRmJUzmsPSFNTLhkgH3ujFaBlyiUcmY/ZeF4t6qM3YSs2zFh8V5V9tnr3rPr4d
         U1Spoy6jTO0nfVkPKxq7RhQuoLOcATOgwku7wufxby+dnDLl6CFQYgIQPMklc2KjIWdn
         Qf1yowwyM/DjKsV+yS375LfzUxy6GINpXaVV+Wyj+zzAymAP8j4eee5fQm7uXng4mBVW
         wK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723820977; x=1724425777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycsrSNVghYJYo7Kq/sAqp6MnjeFyaL9nJFuFS/dh9Nk=;
        b=arO7DSjYdcVtEgLyKqujenqM4zc8L/6hE5ne79xy5JnNyVVF1GCDCrDd+FLkvFyhLW
         mN3DFnRqcMh4aQfNfCdqrNizqZFjdXKJ/qO+UAu2r61yIJPJWT1Xv3NU2ZoUsTYIBMEl
         AYHLEvbaI8FNt5rAjirZo8uF7PxGtuL5TkbyGn6hNrvagqcX20tHr1JVgzbTQk58gotY
         DK5gWRLtC6i7+Ib01GEG+x3NyZjfaiL0Fh46gv4IqiyveyQaND54W16kdDy3LxcL2mNl
         ZSwFx5e8epzkm62NW4pYjN+sQWFwiIm9Qnlfb3ldL0rskNZDGhnz+XD8RpgLzEEJ01mZ
         WiVw==
X-Forwarded-Encrypted: i=1; AJvYcCWOHdwHsblPN9wNEptP1JMidX83LJiohygCz1tmiIbfIQonp7piWo01VtEdAER4ctGZjl+UBS7sRSwuUKfJGM4KMNc7O5PAMz5ei7uY
X-Gm-Message-State: AOJu0Yx4eNzSosMdi+lZHTmHYCNObHqp8IIiPHKVqRo34qhaYlkvQexg
	7tH2HKlbo2937lwE2I/AFzKWcUixjm+AxzAhQfyMDMk9KkCeak6V5nFSCJEcNND06CPAQgU7U8j
	A
X-Google-Smtp-Source: AGHT+IFDGX+GfHixPCgcFALGkNattnCz9fLq1GjkO92ZX/36nvryecE+9MvCeLg53L+RFEWex0FMuw==
X-Received: by 2002:a5d:5442:0:b0:371:8c79:73c1 with SMTP id ffacd0b85a97d-37194317aa2mr2276336f8f.2.1723820976767;
        Fri, 16 Aug 2024 08:09:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984993fsm3808758f8f.31.2024.08.16.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:09:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] cpuidle: riscv-sbi: Use scoped device node handling to simplify error paths
Date: Fri, 16 Aug 2024 17:09:29 +0200
Message-ID: <20240816150931.142208-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
References: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index a6e123dfe394..5bb3401220d2 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "cpuidle-riscv-sbi: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/cpuhotplug.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
@@ -236,19 +237,16 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 {
 	struct sbi_cpuidle_data *data = per_cpu_ptr(&sbi_cpuidle_data, cpu);
 	struct device_node *state_node;
-	struct device_node *cpu_node;
 	u32 *states;
 	int i, ret;
 
-	cpu_node = of_cpu_device_node_get(cpu);
+	struct device_node *cpu_node __free(device_node) = of_cpu_device_node_get(cpu);
 	if (!cpu_node)
 		return -ENODEV;
 
 	states = devm_kcalloc(dev, state_count, sizeof(*states), GFP_KERNEL);
-	if (!states) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!states)
+		return -ENOMEM;
 
 	/* Parse SBI specific details from state DT nodes */
 	for (i = 1; i < state_count; i++) {
@@ -264,10 +262,8 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 
 		pr_debug("sbi-state %#x index %d\n", states[i], i);
 	}
-	if (i != state_count) {
-		ret = -ENODEV;
-		goto fail;
-	}
+	if (i != state_count)
+		return -ENODEV;
 
 	/* Initialize optional data, used for the hierarchical topology. */
 	ret = sbi_dt_cpu_init_topology(drv, data, state_count, cpu);
@@ -277,10 +273,7 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 	/* Store states in the per-cpu struct. */
 	data->states = states;
 
-fail:
-	of_node_put(cpu_node);
-
-	return ret;
+	return 0;
 }
 
 static void sbi_cpuidle_deinit_cpu(int cpu)
-- 
2.43.0


