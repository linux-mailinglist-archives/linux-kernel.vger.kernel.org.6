Return-Path: <linux-kernel+bounces-289919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7655A954D55
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91061C21D57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564301BD4F7;
	Fri, 16 Aug 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7EqRt58"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1731BC9EA
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820979; cv=none; b=b+xdCyoLnwFTWWSxwYHDMlENVG/nCdSLPsZGJmRIavOYb3bgcGWfAHgsIsqzmj6b9efCWLspYGlWlr/cYyDQMHkRQl2E3UWIoLwtTWh7eKWrTYsZnJKzVOEIq5ENtpgbPvA6ji8wbO9iAvL+PKhjnapm2NIpft5CURTECsSEfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820979; c=relaxed/simple;
	bh=XzdvY7dTSy94mw2/rQM0iFi1pa3M0LsbqBKyIiUy9+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROppLdwxKSDGXJzlAfNWpgWs3FHaIppq3regnf+Yz8MQ/6S4LbiaZ2ksnOBYYHWOSoNiYs5QXvoep0SRKPXNUQcMoBlBNP2o0fxsxIHzRGs3gfxENi+aoulsDktqpVU8HeJ528XQB5FFVUpdzgSMnW40G1DUNFzcobBNEuqBYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A7EqRt58; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso15486125e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723820975; x=1724425775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0sK0ufc7qEbd/mn2fdq4hcobz3MRQ2PN+HK1BuFHRw=;
        b=A7EqRt58KZpuu8L6OoagPNaPAUwSjSK232MEGaoWfylAW460Vb00U5ZlN17Upgg8VW
         G33U4BBxwNrucuhDozqGE/8FQzNi5NFPnld1Z31K6AFMbJAOayEhK6nI0MvIMjHsyu37
         D+LFh/Jl2QvqImFpUYU5TvkQHE9nFy+gVkuZ1BhR/PL3tY3iRE+Uz7T3++Qi+pZ8fdlK
         ywd6SHF++ACZERowTLSQgiWbquKqWgvf04KA9CkSAh37V+BmIM7/gs00KhKcCJk6+gS5
         9HAF5BZ483yrDepzc/+ejCdWTvtyVf9Ku86V1yV0edj4hefGl+NOgQ9LKYQoN7no6yGX
         QB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723820975; x=1724425775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0sK0ufc7qEbd/mn2fdq4hcobz3MRQ2PN+HK1BuFHRw=;
        b=QNwDVanE/J+pYc9JBTr8cUnFg74xPJd//PJqhdXa5ivxJVCit0dp8GEUTLE76BwNfA
         3ZQHHv0NzWNQUs41xRqy+Iel3tlIYa2M1015VvE7ACD3yyAviiCS9Qo5Rf4aMODvEQbL
         7PZuXCj57OaVcw53ZTdRs7THzz3vJUPswiihSsyABFSykOptd7+uV9SmBSGwLVU59fS4
         NnDHN57ztW1vlNQw7PruDF8kNhB4/uuApPtYHhr3SaC0yD9wE/lkyK4AeRgShsD7R/21
         tuncPvXOGAYtaJFib/QQHG1uTb4GAvfTeG+eh97k+XX9dCxvpFSs3BLjyccmIqwG1DUA
         65pg==
X-Forwarded-Encrypted: i=1; AJvYcCUe/M+KIHrnX4ANTIaS1TxRAfLHqMrbo/NW7OsTbcnQSm+OiSIGYI3olgvyECAPwbRxG9nmnsrfYgRWKPllX9ic6BtRVmNuuQo1YnTb
X-Gm-Message-State: AOJu0Yyv79TzHARVgIOELdr+rJJfVP1BfvR9QXy0ic3Sy5k/EEroNF6k
	4It0BLqT9oNjpQFwmodFoifKl9p+waGkEplP+ojd1nnUYji6GM3vLkxc9HlAeLE=
X-Google-Smtp-Source: AGHT+IFhP/NIsW9PWfnEcWLqi7chpg87KWhwfD8tKVYrnOj6sJddsAiBh6dq11WCBuqo717hp+HeUw==
X-Received: by 2002:a05:600c:444b:b0:426:6320:7ddf with SMTP id 5b1f17b1804b1-429ed7f944bmr19485875e9.35.1723820975298;
        Fri, 16 Aug 2024 08:09:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984993fsm3808758f8f.31.2024.08.16.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:09:34 -0700 (PDT)
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
Subject: [PATCH 1/4] cpuidle: psci: Simplify with scoped for each OF child loop
Date: Fri, 16 Aug 2024 17:09:28 +0200
Message-ID: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index ea28b73ef3fb..146f97068022 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -142,7 +142,6 @@ static const struct of_device_id psci_of_match[] = {
 static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *node;
 	bool use_osi = psci_has_osi_support();
 	int ret = 0, pd_count = 0;
 
@@ -153,15 +152,13 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 	 * Parse child nodes for the "#power-domain-cells" property and
 	 * initialize a genpd/genpd-of-provider pair when it's found.
 	 */
-	for_each_child_of_node(np, node) {
+	for_each_child_of_node_scoped(np, node) {
 		if (!of_property_present(node, "#power-domain-cells"))
 			continue;
 
 		ret = psci_pd_init(node, use_osi);
-		if (ret) {
-			of_node_put(node);
+		if (ret)
 			goto exit;
-		}
 
 		pd_count++;
 	}
-- 
2.43.0


