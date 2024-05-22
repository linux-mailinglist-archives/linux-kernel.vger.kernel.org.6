Return-Path: <linux-kernel+bounces-186598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7428CC61D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918431F250C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81574145A1E;
	Wed, 22 May 2024 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVLKOzN6"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27333A929
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401303; cv=none; b=OKQYHX8i60728GDAuNFazilZfne97P1Rk/ZdXbQSxp8ViVVIWzSq+izRM/zrSgs/VholFxLzJydGxRktx4LZJjKH6/LQaZ68RWy0KKtB7Brf0nGqQB74bNfbojlzW+8n70yD0+LQrV9yjTPF3J8gvuykps/YbN2KOcRn2rfJZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401303; c=relaxed/simple;
	bh=de/va54cFXE6dZC3rsLgUlhOLoQzpNi7uxfl6NckXE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aY6eDvB8qekEr759kW6YqdHcBfRN7AC/iaUYFDYC8joEslwnL4LvHFqVcAg0707XYA68Mz4hhLbvUbzWAOsGnwyCRU8AC5UkBhPmxOuyWWEoeThLMzlF/Hrn94M/S7MmuuTKJfhZV//ar4wT6JZnxVxWD2j+8IS6ujvECBbdp4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jVLKOzN6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso93820311fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716401300; x=1717006100; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9J7VkvlyzdgokztcmiI2sbYnzlGN24WOER4kC71qKRU=;
        b=jVLKOzN667Eq12ZkyFd1/+gp1ZB7JUbglJ4co85ZzB3w6KqRgHep/V9Si98t/ZPLJ/
         6NH4ItZNbtIDhqOefKa7iMW22pTuWI2t9CYgIqKFJskDiXJ9dFv+n/BV8kz3Uk5TxB5/
         HVzGFpakOmejM7Z2a/hcAaAbTQI+I1IN3Q15GGqlo77J0yZqFU34H0OZAsfC7DZs2QUj
         FYuR7fdNiK6AA3aefnlGcKhOvgkbzDb9mu9mhdDOSmwPTuu2T6f1KqDNLNyj4oX4ZlZz
         d7xrkATWAHC97dD6NAaEFdSjg22GLOJJAdgRo8wlooXasyS21O289DNSoLYFElDveG6k
         Qq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716401300; x=1717006100;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9J7VkvlyzdgokztcmiI2sbYnzlGN24WOER4kC71qKRU=;
        b=jaesHs5JaJ0kV3xYzHRQWphIyucXXaSiFbzbgNcBfzNp34x+HGrYgUiBb5TTLj7Y7E
         zWi/SA/uWQPeBjKs/z4cLtsGrnbII6KSEWHKi4ZB093+NRaR6rN7VFIRsE5nreWZFz1h
         M6grDGySpQCsH32YIxlJDZQldxp9nZsXBomDnRRIV3N7juaPSAEg9NecI5GrUuxYJYkl
         8wKfRZrolZhPJdlyYG/4RigcGIu6t7G2pZ7oUlh/M/ZuT75FLac9E3BJIFt6Kpnz0+VH
         z4j9L20ND9YOfRp0BfPXNNHripzk53KfUK/WP2vjawCq1J160uoPfnxbwe/dkHtYcNWi
         vIYw==
X-Forwarded-Encrypted: i=1; AJvYcCW0iKgcrbV08COND6l55PWJbtYE8BcmIcFRDeheCR42CCOB4rZk3LM8adX4toB604Vu0VwpqJA6UQ6VcD02OFXAb4WWCEvkTIjtq8+U
X-Gm-Message-State: AOJu0YzMQWdirJJkwXkEXDEk3te1jGWLn4tLgQhkyw7YP3RU2aTqQCgL
	v4H1ltXGNzFq/fBwk9jRGpYi6gXYQHnnBscnyBP9fzgNOpq9HMIuguZ9jpqLMre/RzEnrkU7FT5
	KIYI=
X-Google-Smtp-Source: AGHT+IEeYd5+idxruIhxMc0np6hZeIJiKBt4Z1yIzKJzI/XBLd9hysaJbSL+PGkWRmsK2YVUj02EAA==
X-Received: by 2002:a2e:9846:0:b0:2e2:64d:6849 with SMTP id 38308e7fff4ca-2e949564009mr21402001fa.50.1716401300051;
        Wed, 22 May 2024 11:08:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:f41:c55:53ae:8e0f:24ed:3702:e958])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a8bc917e2sm1118929866b.155.2024.05.22.11.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 11:08:19 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 22 May 2024 20:08:17 +0200
Subject: [PATCH v2] spmi: pmic-arb: Pass the correct of_node to
 irq_domain_add_tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-topic-spmi_multi_master_irqfix-v2-1-7ec92a862b9f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJA0TmYC/42NQQ6CMBBFr0JmbU2pKODKexhCaJ3CJEBxWhsN4
 e5WTuDmJ+8v3lvBIxN6uGYrMEby5OYE6pCBGbq5R0GPxKCkKuRZKRHcQkb4ZaJ2eo0hbecDckv
 8tPQW9nJCbYtSS2UgSRbGdO+Be5N4IB8cf/ZezH/v3+qYi1zYUtaVrk1VyeI20tyxOzruodm27
 QtLMdhrzQAAAA==
To: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

Currently, irqchips for all of the subnodes (which represent a given
bus master) point to the parent wrapper node. This is no bueno, as
no interrupts arrive, ever (because nothing references that node).

Fix that by passing a reference to the respective master's of_node.

Worth noting, this is a NOP for devices with only a single master
described.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Un-delete the missing ampersand
- Link to v1: https://lore.kernel.org/r/20240522-topic-spmi_multi_master_irqfix-v1-1-f7098b9c8804@linaro.org
---
 drivers/spmi/spmi-pmic-arb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 791cdc160c51..e6a4bf3abb1f 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1737,8 +1737,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
 
 	dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
 
-	bus->domain = irq_domain_add_tree(dev->of_node,
-					  &pmic_arb_irq_domain_ops, bus);
+	bus->domain = irq_domain_add_tree(node, &pmic_arb_irq_domain_ops, bus);
 	if (!bus->domain) {
 		dev_err(&pdev->dev, "unable to create irq_domain\n");
 		return -ENOMEM;

---
base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
change-id: 20240522-topic-spmi_multi_master_irqfix-f63ebf47b02c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


