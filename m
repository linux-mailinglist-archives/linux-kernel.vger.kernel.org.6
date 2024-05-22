Return-Path: <linux-kernel+bounces-186154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065708CC069
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0501F2371C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E10A83A09;
	Wed, 22 May 2024 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a12Rds1z"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5571839FE
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377914; cv=none; b=TUb18Y3R3el0AXIcJtaYtylCIRMCbRAE8dAPdpKaQuucuy3+oJSFFYkso3rA9z0Q4OHhNERnVkM1/q98mMtWJQi4KU4B/oZpZLGcXiAQnmF7qRTIEnlgc4f8vGiYzAGHR8KAONYRRx3oMStdQPQsjjaawhfeWtgYOne8JXm4oo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377914; c=relaxed/simple;
	bh=yHzX9y/qCvid1mg33b2D6r7EkS+pv/D5AgQLr82rKKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BKiTfbT4/IxFiuTrf8SSrh6jeb9cm5/hN/I8b/L2t7/iUlHqpiFMzY0nBZojU0XiRikS7RWGhLFqeNIJAkUVkLXMrU5CV10bz5/ZmxQwSuG7FuWb5qHmn0IxWb7Y0tMWywCoPpK02LjN6QbEIY014SAnpc/2O6Y+dCQPcU+436g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a12Rds1z; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59cdd185b9so164660266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716377910; x=1716982710; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ozR5UPKF3Qyww8Ahh5rDcDSPLy5kexc1/BjXgWcYQNE=;
        b=a12Rds1zlFWzejq9nAepL1H36AhkrzVm2m8FpMgJIcYY9TyNVtNWMGGAiaICZ/YvVM
         xwwnZYgy9vqYA+DI07LieSHscsG1eYb/1kvOLyNoUAi7AQC6hBJ2z8YX4yy40t3GfzZu
         DToH6I5/gBMZC3/8P8uN9n1eS/UHDYH8/8/nDmWtRGorFAI6qssvJse9vKDvcOt3N1dI
         aFiXjFoVB1mZw0pet2+RxmgqerfUWFkLLWoaH9xUtgWD1UC5dgo2l/rm5igwS1u1JGCz
         vLg+TGrdAJQFX/712XFmyMHfNhquOwlfusm4GsGg4nR2PEqIQ0ImpUcDRrav5aCw9M5q
         pHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716377910; x=1716982710;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozR5UPKF3Qyww8Ahh5rDcDSPLy5kexc1/BjXgWcYQNE=;
        b=YQ2LAqZWc5eg73iNmk6dgJ++/XNuzU4BSMZFmyrLjQIw67YKwUbXp/uHWHQN4MITLh
         YTWx77JJfUMR1nupAZtBTfJYgW/Jk4gM9CrS2QUTMaKWfLtzjNoUqnY7vLhpVf09tkZk
         w7KwTF8wou3Gqo//7wfAa+LP9ZfL6TWBfQ2ZvmLJZoSdB4DnERTGGc7mP+DqyBF4gXOD
         M9lQa+nwNRm2yvR+cxpHstae5kg16yZTdZbhxta7DmWT+/vKTFu95X8SXEosOdsfNZsP
         o0vGXEIJU6my+tp7Y/Zk7OqFQjRoUxEAL2ZgPcYdcJ52aE/8yl3i5NNIWTGvltDkCGsK
         0CmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2dNnnmm5Md0RGKb82KC2VDl4QbK8GVX8lgjs5tIK9Y1rxaHivdOyTRCqzDgfn4PtjQAHCImy/HnSonJIZOxu1SqRDVf/KbiQLC6Xd
X-Gm-Message-State: AOJu0YzzYTbugvSLbtJmlmM9LKN4rI9uGwi9qP+ns50hSILW0WVh0rUU
	N00hXvoYyCKDa0S+VbN5X201lBhJ7ByCRTIWs1ytfKPfchNf+14eezXyh8hPgBk=
X-Google-Smtp-Source: AGHT+IF2n5QgSMpXzZR/9l3VXBhEj/hSn6E2bgcVvtu1U1aPAb/72QqLG7ZIFzJaV1HjnqeL/y8Huw==
X-Received: by 2002:a17:906:4c53:b0:a59:ad76:b371 with SMTP id a640c23a62f3a-a62232b3846mr157482666b.26.1716377909924;
        Wed, 22 May 2024 04:38:29 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:f41:c55:53ae:3b6a:7bb9:3183:8e19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b179casm1758569066b.203.2024.05.22.04.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:38:29 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 22 May 2024 13:38:23 +0200
Subject: [PATCH] spmi: pmic-arb: Pass the correct of_node to
 irq_domain_add_tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-topic-spmi_multi_master_irqfix-v1-1-f7098b9c8804@linaro.org>
X-B4-Tracking: v=1; b=H4sIAC/ZTWYC/x2NQQqDQAxFryJZd2CMVqFXKUV0mtFA1WkySkG8u
 6GbB+8t/j9ASZgUHsUBQjsrr4tJeSsgTP0ykuO3OaDH2t8RXV4TB6dp5m7ePtnYaybpWL6Rfy4
 2FQ2xbgePAWwkCVn+Hzxf53kBypFbU3AAAAA=
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
 drivers/spmi/spmi-pmic-arb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 791cdc160c51..46ea93f78dcd 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1737,8 +1737,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
 
 	dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
 
-	bus->domain = irq_domain_add_tree(dev->of_node,
-					  &pmic_arb_irq_domain_ops, bus);
+	bus->domain = irq_domain_add_tree(node, pmic_arb_irq_domain_ops, bus);
 	if (!bus->domain) {
 		dev_err(&pdev->dev, "unable to create irq_domain\n");
 		return -ENOMEM;

---
base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
change-id: 20240522-topic-spmi_multi_master_irqfix-f63ebf47b02c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


