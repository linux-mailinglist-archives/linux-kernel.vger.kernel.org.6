Return-Path: <linux-kernel+bounces-299225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFB395D1BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E329B1F26F22
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71B18A6A7;
	Fri, 23 Aug 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H653+rAO"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE44189B87
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427537; cv=none; b=FtBZsDp9ckOV1ot60j61u2dc0Vqj81uziljeKJIjF3C+rqvPbDao/ESQ8414QX1fLqmt1p5/H+q9xMdEbSIH+JBvRgevPKAG/PEuZ7JEhXn7a7uSfQ9iS6UODAIOHZsEr5XnEdbBIe7q2HZFTo5V5OPftnXAfz696S1xtvQisdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427537; c=relaxed/simple;
	bh=JR9cw74DQSM2eU2zWwaNZZ0xGyZqYuXXOD6ozbehUUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OyrvN418QeTLKoNgzbWWXx2oAMbnHBa8p1rhGq+Vv9bHxjVmg2D40b5xRRD/nwWdcM+WR1j74pwjeu3H43i+T9dAmDGVq+DAvNkL4/p8Ks8cSg3o/Hvz0AU8rc3iz+HdKkIYjJ5xJURps3X7pcf2JUJ4Fakvvx6gD66Q9B1QsDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H653+rAO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86753ac89bso12936766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724427533; x=1725032333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJs8d7RVfQGekQmLWkZ3l/lci/ql4y2sx5IVAqszbbQ=;
        b=H653+rAONM9NH05H08lSI7RPuqapvCjRvNLdz3hqHWK64TTTqjYNj7ym2BzCIeEJgz
         53ol87XiD4PXelWmqmeDJPvrarqPe80U8qxul+j52nXQdeLlwv6paIi27yp3tqw1FyC7
         7lSd0Zr7inDAFZAk15MAsvPNdXhBIe6oQaafYs+ztTaOwQ3DvGGBO9kochf+NGSmGcv6
         VKnpBVKvduUPsr93zGzLjOQRtzkqXHE4E4hsWnhHTeyvdT9oYgYLB18MARrfQmUuey6h
         K9EeALecGbVcPzcPIL908ZcHDRXN9IZeW8G903bPUtZOLYBJY9hCZ+a0PMV2ZU4Nn04E
         ohsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427533; x=1725032333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJs8d7RVfQGekQmLWkZ3l/lci/ql4y2sx5IVAqszbbQ=;
        b=Tgc29Si1IiIfBofIyJjES9uaJiDotXxNrWpTXptfzgJbsh1ER7ivVuKdZ3vQavlVIe
         op3meD1/VI0+KNr/V0HXyLVdcp65322J/uinK+XeZd0hkMDPDNDYz6ZJMXjDZMiQF7+r
         6km0wYCi0PHBVXal5UXxC2mJW9ZEfbO2BDY1xn9fv6wbYWv3eoaC2NwZIwk6Xf5+l/oO
         nCxGV9BhF70vz5BZNisrV/jW9BRiJ7jODu8O+XfXzC78igX+CHGni4WMLyCzgwUTc6Ed
         Pbd2Azb7p6H1ThqEWhjikyRBdQXzjcv2x0O7LT/Bul+NUrdMTiReXSQ9k8X9ZmmdWq6k
         Xw6w==
X-Forwarded-Encrypted: i=1; AJvYcCVUkV/QQncwzdJIFhJipQx/1IlvVrwL0HCW/ER6HPZCSW/LyhAo26PlGnDF1mNMPguNtJAoNTFGRxMQXT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV7XnKxt8wpbUskQLGNdwwcJzUz038Ahum5pf6RsIHKdy7amL1
	8lOViA7UaY9eZmibqByNMugVGKhJkK0G3zN/Lz9h5bleyhM8KTXroHz5y2TBqhk=
X-Google-Smtp-Source: AGHT+IHjrGLfTu2FQGAUVxvGqawL/r9shFFDgxA1PeiSj8myBbgeuoJr5guuoDNtki43GxYl4WmVig==
X-Received: by 2002:a17:907:868e:b0:a7a:8378:6253 with SMTP id a640c23a62f3a-a86a5489a52mr122703866b.6.1724427533388;
        Fri, 23 Aug 2024 08:38:53 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2e6722sm273279866b.91.2024.08.23.08.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:38:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 23 Aug 2024 17:38:43 +0200
Subject: [PATCH 1/3] clk: qcom: rpm: simplify locking with guard()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-cleanup-h-guard-clk-qcom-v1-1-68bb9601c9dd@linaro.org>
References: <20240823-cleanup-h-guard-clk-qcom-v1-0-68bb9601c9dd@linaro.org>
In-Reply-To: <20240823-cleanup-h-guard-clk-qcom-v1-0-68bb9601c9dd@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=JR9cw74DQSM2eU2zWwaNZZ0xGyZqYuXXOD6ozbehUUQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyK0IQtEkv5hsTH16vg7GMkM80IXzMNmQHSClE
 WDLx9TYIlyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZsitCAAKCRDBN2bmhouD
 17SRD/9O9R3z7jT0K4xXGRf4Jsz0hfvMvbt5+GVp3EGiPy5d6axfBuNX1/OWAgdCHeEvhJKR6MJ
 ZDoSdUNxevZLbafQmwlTGFTwe0kuT2B+dUM6xB22VUNHTRnWM0iCF6fucU5dDAQjC1yAB/K3oRE
 lNc/C2u6tFZuMvBv1Fu06h7EtvPDjEfIVbZkkjzPk2HuLlTlXm6z5Cvl/YqYVwR3Ve6GsepflLA
 LXR5DWR1HOdlhLrXNFB8ErJHxoXhutLCzKoBIu2U+ANBpHyrQ3gvw5D4x9OsxbcFPyydOpKxAuh
 QnR545gj9b2smdNQM8opOyTZAoQEm57Y82dzLjz0ryYFp2R2xWBlnC7OhzxKaRojS/X0NPvHkNe
 FeNYdG8I1e+Ejd0ZCP+KSwKSQrlrTYVJ5WB/aWdVz1xP5rt9z65U7MZGc3qMQ5mCRLdcfpFyQoY
 23HVbRa+vKX6Hv2oV4d2Gpc5ghplUAKXk1ljmld6u0bplTxVHDbRdDy8NkOXhEtWOqUFQpaFd2G
 N91KuywF7T3KUJ+VIbKydsoBePBxZmU4RowAN/hyGvBxcVTriseJhul1tJW8X+Z81vhZD+ZaPde
 9a/r8CyviB3d+yGZWmhpD7ffzepSuXk0n5Yl+pKTJeeYvPGgVyi6ULTpD9gFZUVApj2FZcGL+pm
 nryYWEy/6Wqtz1A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify error handling (less gotos) over locks with guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/clk-rpm.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
index 9da034f8f2ff..ccc112c21667 100644
--- a/drivers/clk/qcom/clk-rpm.c
+++ b/drivers/clk/qcom/clk-rpm.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -224,10 +225,10 @@ static void clk_rpm_unprepare(struct clk_hw *hw)
 	unsigned long active_rate, sleep_rate;
 	int ret;
 
-	mutex_lock(&rpm_clk_lock);
+	guard(mutex)(&rpm_clk_lock);
 
 	if (!r->rate)
-		goto out;
+		return;
 
 	/* Take peer clock's rate into account only if it's enabled. */
 	if (peer->enabled)
@@ -237,17 +238,14 @@ static void clk_rpm_unprepare(struct clk_hw *hw)
 	active_rate = r->branch ? !!peer_rate : peer_rate;
 	ret = clk_rpm_set_rate_active(r, active_rate);
 	if (ret)
-		goto out;
+		return;
 
 	sleep_rate = r->branch ? !!peer_sleep_rate : peer_sleep_rate;
 	ret = clk_rpm_set_rate_sleep(r, sleep_rate);
 	if (ret)
-		goto out;
+		return;
 
 	r->enabled = false;
-
-out:
-	mutex_unlock(&rpm_clk_lock);
 }
 
 static int clk_rpm_xo_prepare(struct clk_hw *hw)
@@ -324,12 +322,12 @@ static int clk_rpm_set_rate(struct clk_hw *hw,
 	unsigned long active_rate, sleep_rate;
 	unsigned long this_rate = 0, this_sleep_rate = 0;
 	unsigned long peer_rate = 0, peer_sleep_rate = 0;
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&rpm_clk_lock);
+	guard(mutex)(&rpm_clk_lock);
 
 	if (!r->enabled)
-		goto out;
+		return 0;
 
 	to_active_sleep(r, rate, &this_rate, &this_sleep_rate);
 
@@ -341,19 +339,16 @@ static int clk_rpm_set_rate(struct clk_hw *hw,
 	active_rate = max(this_rate, peer_rate);
 	ret = clk_rpm_set_rate_active(r, active_rate);
 	if (ret)
-		goto out;
+		return ret;
 
 	sleep_rate = max(this_sleep_rate, peer_sleep_rate);
 	ret = clk_rpm_set_rate_sleep(r, sleep_rate);
 	if (ret)
-		goto out;
+		return ret;
 
 	r->rate = rate;
 
-out:
-	mutex_unlock(&rpm_clk_lock);
-
-	return ret;
+	return 0;
 }
 
 static long clk_rpm_round_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.43.0


