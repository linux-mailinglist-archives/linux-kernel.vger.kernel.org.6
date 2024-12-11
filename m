Return-Path: <linux-kernel+bounces-440910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B28909EC654
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBBE1644AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE01F1C5F21;
	Wed, 11 Dec 2024 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="okXBaSB5"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A81D4610
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904100; cv=none; b=LOHmUZQRiJwkk0MiTcNbPOGzqH5I++DDQKLXmzjKOAc56dVJK4n19jEVd/9ycUrXj2AFZuUQOsvsQGkcBto5eY1Xx64UK2SfZtpWiwtMpwb+dfIyBMLjt9ILLAeZbmiJqwncXm/ixe3709rsUH0hDlEvWfKyjS/ibSMrSMIRM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904100; c=relaxed/simple;
	bh=ipm6qELbYTfXg2hQT0IFc0rvkpX/x/nt8LPfq0mYElQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KmFv3I4s/7T0b0nZf9mZ91M+mBa6OrYXHpGpo7L9WhzK70seyrxF8HPpJ3cLC+nz4RJwRQQW83PQyQNzdknPhjsBzVMa1Ak3iG2bjuaVKYjq/UyNgAwI+CTeTD7wS7kKdt8yZsRIvmvUh0bn+dvX4FZqfAyJOF45Cyh4OVckY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=okXBaSB5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fbd9be84bdso5872833a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904098; x=1734508898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q76q7eUTECAS81ZcaHstGwKhBK0vE68IjtIJyIAI+k=;
        b=okXBaSB5VRecPpORrr27JIy1sTCPUUNRV0odBObWz3Ht+9bFLY0YnmeDsV714Ckbz7
         MwyIt5DZcD9ddsMexFwlu8czwz9oj/gA/F67OkHkP+5vFtJAJnTCXA2uXqmDcCwKK5f3
         iZPsg6/rhyj36hHZiAzMaVQrup5CS9S5M5T/IzznGbrwDlYzmhyRcnH3a1bGKB5VZKRf
         Y9UvNyynuAbfv9AUWpHI/LgTnIMYWzhB+ttKGHhqX2YEd9HMbA/ZdVQI0wKNmrTHTw+v
         jv5YP/tRNiUJos05+QetafOXatKXGQLH1BCLEtA8wA65h/yxf4BOJeOhVJLObDf3HXek
         xUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904098; x=1734508898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q76q7eUTECAS81ZcaHstGwKhBK0vE68IjtIJyIAI+k=;
        b=RmMWJ+bSZV2TijNpbCFHD8jMESZUBxSyx3tCql8X5OKfVrlAoXqtTU6EKP69kQ7lOp
         xdU1nyOF5NikJOJT+NaYSKCkaWwKdEF5lYBTnpPyqY8Od0DjJxp+5vVchdCj8IvdeAVB
         UEHhw+A+F826+1C1bdYgT6upEtyXqXZqjJ+iUyO15hN1zR2JHnDFszEU9GIo6HEYdrtI
         MbUWmLjmFYExVThAQaojck01Vptd2uaWjHWiHEAr/8+2y5el7CfnOaIGRecxoshpSLoy
         5YlvG0WaAnOtxeMnUeSeK75S/VHkA6R7+xvAwLkawnyURueGz+JXJWdUTbASkW86iMS2
         SbKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaeI5gwFyE9WGOGw8aopcY1TG08JP4MDElN+sN/c+YzNcia/3LFnzW/3+I95T0u82Brmptb3mTrnzlcPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtUa1Up+2dBLpLm6wSUtI0ijxNn9DQ6CgFoBs0Duwzx1gYQjv
	88YbkRM+nYNH0OwflAh8BoIUaEQeHCY1Rs0birL10fulcX2ydQzQh7pIN1f18g==
X-Gm-Gg: ASbGnctKc3EYEWPZV23ARqX2vYcJt1N9GSMdi0dU1Y2fVzEnPSA7DzoBiTrefNWzJcF
	H3EOtMMoN43aMyz61a5uAwdqtuojUS8+5dwRBuXpibuFjktq6GwgWxKmgl7cojtLaHoXlxUAVrg
	b/6P2KmG7v9OzlBTcv/GW4CRrQ4aI2SgcckjKcSFbOGjqNe3JmE8xqjCH5X3igVq+T3wYD536fn
	NZ30hMhSPRYKtou/Ps0RV43FftRRwpayq7Hoc/VdXQXKU+0VHLXT0vlbU52q7ZSqmb7yjd0mDAg
	zXje
X-Google-Smtp-Source: AGHT+IG99qcIr9GvfITm98ryc2AXYkrV8pH6ZRMpAt1heLeVZuLUM1sds1scrjNv6/IS5BWcXLa9WQ==
X-Received: by 2002:a17:90b:224b:b0:2ee:8430:b847 with SMTP id 98e67ed59e1d1-2f127f50a32mr3250201a91.6.1733904097941;
        Wed, 11 Dec 2024 00:01:37 -0800 (PST)
Received: from localhost.localdomain ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b93dsm12929775a91.51.2024.12.11.00.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:01:37 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kw@linux.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	lpieralisi@kernel.org,
	shuah@kernel.org
Cc: kishon@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable+noautosel@kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 1/4] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED
Date: Wed, 11 Dec 2024 13:31:02 +0530
Message-Id: <20241211080105.11104-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
References: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On all Qcom endpoint SoCs, BAR0/BAR2 are 64bit BARs by default and software
cannot change the type. So mark the those BARs as 64bit BARs and also mark
the successive BAR1/BAR3 as RESERVED BARs so that the EPF drivers cannot
use them.

Cc: stable+noautosel@kernel.org # depends on patch introducing only_64bit flag
Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index e588fcc54589..f925c4ad4294 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -823,6 +823,10 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
 	.msi_capable = true,
 	.msix_capable = false,
 	.align = SZ_4K,
+	.bar[BAR_0] = { .only_64bit = true, },
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_2] = { .only_64bit = true, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
 };
 
 static const struct pci_epc_features *
-- 
2.25.1


