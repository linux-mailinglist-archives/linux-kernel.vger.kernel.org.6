Return-Path: <linux-kernel+bounces-289529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F0954737
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED9C2871C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5CE1BB6B3;
	Fri, 16 Aug 2024 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p70LHCNB"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8FA1B86E3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805703; cv=none; b=kJfppMuV+JFrlQIk+RG0QFEODxWZ4Gf6kqf5sBoM4idxH3wowa84OAS02c7sndmO5i6G4aZ4jko1+lwqRK+OFDBIMZUvmF7gwBkDY28+ZQwgn+pYDgPkSB1Dq/IuFiEmf6R9T8lkXRrRgLu+atQpDNuKOtEtqD6HK52VAabQ/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805703; c=relaxed/simple;
	bh=H9pgFKFZj0vfgCksat3pZIHsHYX7b2XRIDWJ9Ds+vFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qHZ9/n4uNl+Mraxfq1J/ivvqFzHSje9Lg7q/bBZPoHW9Yks9irhmDTJe5wNgZUBtAD4EmQ42ekQFKxqbxVckRRBCpq9g2+tPje5zh3frYq2rUXrhzXJMc9whRyssbapVofgpPph/v5ZCcf6slAKQzfHyJlZHqIerCYYbJZmPzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p70LHCNB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428119da952so13406815e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723805699; x=1724410499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ofyujhdwo9HhuT+uKq2h0ijjUNuG8zhSZ3XGJMLvxUE=;
        b=p70LHCNBA7HK2pC01cOrZ7JUFB5pf3XL9i/5PSNnMT8YmmmfkCUtVhmGPExfoRszkG
         ouNFK5cCsJhfR+xQi6IuePbOPf68o0mf15OR2UjyeJjCe1a1x7Me2chQbq+PKBUB3ZKT
         1DUrb45ZNN3bndXVa4bIfrudQMoNN87D6mvUzetP1Kv31EuB5iCYayjwNjrBD99LCq42
         1hEFq6XMUWyMeIbf9hKYRTRCBAhYaVh5dJmyN2xVhJ+m2xwbefDf8ZqPPC1JDWqr1zSH
         oOJ8EH72ei2AZwqPc8UwD77WfNxRaNc5iTBb52KhKRB6e3oaC+s3mqLo2bfETMG8shfF
         QSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805699; x=1724410499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ofyujhdwo9HhuT+uKq2h0ijjUNuG8zhSZ3XGJMLvxUE=;
        b=u+pVG88n29C/5oM/Gv8DX1V/1TFlfhfG1RQIgtPxkqq+xHbXg7asv3vPvPe+XxwwR4
         7i6CVgDQr+6iy0dXbiyUIJHMaDS8SUrFh8Cc5wjGUoaNqxUO8t0IgbCwmwXwi3wEHEwN
         I4rFZPRi49yyjdhiA5RKc3MRRjzzQ11vnz2OcdF/+SwYXIxF4psx4OG6qEcTyLt8p4HF
         tqtD0Vp9c8AkdD58MPHg1a7nFLUIv4LyZacvT7Va6zz4aA+R30t6WD03Fw1mzDeW7U3T
         TK6k1LqeFBqWPdwINJ/E5RPTyEDyguOXKz4sMAh1fJbeL3m3tp/G8iHkFaW45YZG1TQI
         HtcA==
X-Gm-Message-State: AOJu0YyADoyAIIE7WTwpLL2GWiSLvjXTscUZ4cHqEQpvoBkX0obQ7Akz
	jY1Af1onO45eI4Mjjg4dsAlM2gbdvz3Wt8Yn+5xC9aXZ9ALIeG6+auWdoHI3CHA=
X-Google-Smtp-Source: AGHT+IF1Ki7kkJVeoFcsxkp8A7OnvN2/y+Y07xGgbyNW/uCef1ZfE+zmmjjSZ7/A05BtryN3zai2Tw==
X-Received: by 2002:a05:600c:4f4f:b0:426:64a2:5375 with SMTP id 5b1f17b1804b1-429ed77da5fmr16657705e9.1.1723805699218;
        Fri, 16 Aug 2024 03:54:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945cesm19461935e9.40.2024.08.16.03.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:54:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 12:54:33 +0200
Subject: [PATCH v2 09/13] memory: tegra20-emc: simplify with scoped for
 each OF child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-memory-v2-9-9eed0ee16b78@linaro.org>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=H9pgFKFZj0vfgCksat3pZIHsHYX7b2XRIDWJ9Ds+vFo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvy/ue0ZjWg9eHgEHo9vzwpfBVB0sZcVnAPvqh
 ztGhVs5Qm+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8v7gAKCRDBN2bmhouD
 10PCD/9BhzHHyMZ1ybl9Uqzx4g21Dxc1765kJu8rXa42a0jWJfLt6GovUNJY2+gsqS7uFhqlwYm
 sYqfjAEwQuwL81Qj0fovqGeHxM9A5m/XxYSRm5LDhA0CURo+9gC4XukSN1NGwW+WGaJ/ocVQumY
 cL8XFrAXoTmNk16mAmgIkfQz8rSugfhTJcLO289UGnghyKjjzWiYKseuVRfo5tglKkluXJiy8a0
 9ctneDbYsGEm1FtFUlKGX4he7OZ+5MHRK4NJmHVib1BK1rJke4axNolcwehhHsygI/DrNhBCCqx
 PRJkXyoUexFGGT9tGBQ+/BvjB0JsHagEm0S8p3PXvn5XvQwVmYU0xRNHayJgS7hUnLIGkzhgKxa
 lMNwPR+tO2Scr4P1Zat9I1s+5DBqnOcqA3TN6XzF4Pc+UlEEJKcygMrmseG1FFzBbLETGURcMyY
 CiA+MI2bKJF5a7RQWESVKSIqSgnUF7cZbuKY8P9aabxn4/Xl3vF3BucyIwjZhGprxPDCNp4M9zA
 bwVblrv0vWmbHK9RqtmIO67gBgGhoevTs+XfcQWZ5dJE5IjE2UdcDaDCGQsrUIfebaUcuR8sIHZ
 kG5UZSt30jVw8ULHXWOtX1HO5TOYjXYWQbPMRzgCrpqKy8yMjLLSrspykBPUcqomNMYKiFC9x78
 9IbhnSsdWiJ96Lw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra20-emc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 97cf59523b0b..7193f848d17e 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -410,7 +410,6 @@ static int cmp_timings(const void *_a, const void *_b)
 static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
 					  struct device_node *node)
 {
-	struct device_node *child;
 	struct emc_timing *timing;
 	int child_count;
 	int err;
@@ -428,15 +427,13 @@ static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
 
 	timing = emc->timings;
 
-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		if (of_node_name_eq(child, "lpddr2"))
 			continue;
 
 		err = load_one_timing_from_dt(emc, timing++, child);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 
 		emc->num_timings++;
 	}

-- 
2.43.0


