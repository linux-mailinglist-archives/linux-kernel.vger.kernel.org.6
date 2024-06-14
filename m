Return-Path: <linux-kernel+bounces-214755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9B4908996
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7A8B28B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F506194A52;
	Fri, 14 Jun 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psGXSiCq"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D141946CF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360310; cv=none; b=Z39DirDX467dw+/pvc0fULgny1NFcRKISOWDa0z9aqqAHjdma+gPqeqDutraRlK4Z/rK2WlA21k97LL7cx4+4hiP3FKzzUYRbg2fYCsRzoRgNhg83+1qn2wXx/f578vWXsozuO0jTVqtfq4ki10Et8CQFYeJoC352gDY9qRncfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360310; c=relaxed/simple;
	bh=T3DjvXEe+sumQ+ecA/DCNSeChO1xZMZY4sezj86K88Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLq2rsprKV5E5t4sYtR8tkjqM2bfVpq8GF7jXlpT7aDk0gu+QHFp81w3/AeEgDC0Yj2+L7srQ0n2LsGVsS4otGFioGyZhjncOPYfVOtpvf/0vtQP25yYsZsQDU2rW1acR7s2ieE442ypc6xb4HGWT2maFa9Ozv81XYa8elVaBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=psGXSiCq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso8866991fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718360307; x=1718965107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cu/gvkK5JV8o/AwZTjhXVurT12iJLCtsIO6X1RdbaeU=;
        b=psGXSiCqlJdAJXx3Si0bBVMweYMoH7xUZoMURwoR42iiGPNalCq6ysGkIj7ToxKnKJ
         YG3gM37RKjoyLZqDYexh2ueCCF63N6eozCNQSGlvqEGFRpWm+33K9XDqcwEYevg0O5Cs
         qjV7fF/PUYA5lSUTN49yrgsYORwViHzvQfXC7dWX5eBqBJ/ihH9sqD2YmNZZgS9TR8hk
         7+vo1ih3IWq0dFUT0pMijSMcLjJc7MP/KC3s2yDHJwtavOVGfmT0eBBcxMubLLWfQCiT
         WTNzDbz6MGsEtt4vtZvpLfVEaFWBaYNhsBiIjRpfxjLPGShNNicZVTQlvE9y2/3vr009
         himA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718360307; x=1718965107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu/gvkK5JV8o/AwZTjhXVurT12iJLCtsIO6X1RdbaeU=;
        b=jNSAE8Ss9ndviMPQ+6PmsSy3Vvoy+t5WeKa9Z4THheJZESn6LDOM2DEbfiK6G7O66I
         y4WYAnwsG7iT1KY+tiA/MQtxh5HZbPp65OOvcAHeqniwzccsI8CzLSJrDtD9gcYSrqxG
         uWlyWcz/A1WDUjrNZca+fXISuuPnkY7uqF2G10aOBJlsbFTnZIjgiwOVMtj6lASS4f+A
         ga6ik8Ezo4xct1mOHJRnDMYkwbrahAful0uuYV8bFiCvsD3M0U/sGb6wcR9tcbk0szAz
         O7ljm/1p4sBVkaVHQZuuZaq2b8+qk8tMgPkdxEvwRXT5VJMFlgPP++6c4yPD9lNoNUV5
         PDzA==
X-Forwarded-Encrypted: i=1; AJvYcCWtppCawTieP/wf9wCf0osAUjhKwLBlhY+bKhugrU+/MZkGuREA3kbZxxZ2WZcPQd/0EL7Vidou2YPxsa1Meg/Kwm889JiEf7tx38i7
X-Gm-Message-State: AOJu0YyTYSkb+Vnxp7eidWrg8xBZAvX2sSFbwlL59a990DrkGiI18bpj
	NFP7HGRXwRIF/aTYGU1+SWLwjxZ2+A3gm9vks3JBY02RhPdZ5DV0kN9T2rSccFw=
X-Google-Smtp-Source: AGHT+IE9Igf80a9v9jW4+hHgFtvj4dzuHZGTY6Ba0xBnG4L+4RhK36KB+2EyI+LPKREkLy/AmHU+Cg==
X-Received: by 2002:a2e:7c0e:0:b0:2ec:1334:7ee0 with SMTP id 38308e7fff4ca-2ec1334832bmr9702561fa.38.1718360307264;
        Fri, 14 Jun 2024 03:18:27 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05bf44c4sm5000241fa.9.2024.06.14.03.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:18:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 14 Jun 2024 13:18:24 +0300
Subject: [PATCH v3 1/5] phy: qcom: qmp-pcie: restore compatibility with
 existing DTs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-fix-pcie-phy-compat-v3-1-730d1811acf4@linaro.org>
References: <20240614-fix-pcie-phy-compat-v3-0-730d1811acf4@linaro.org>
In-Reply-To: <20240614-fix-pcie-phy-compat-v3-0-730d1811acf4@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=T3DjvXEe+sumQ+ecA/DCNSeChO1xZMZY4sezj86K88Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmbBjwWST2vn0/HBi504jSxpaS/FcGYEQXws/0Z
 Li9eCQgMTCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmwY8AAKCRCLPIo+Aiko
 1SIhB/4inbA4gW2P2tS7P/P1h40jhnWYgOhODA3nURHZNRa2WbLmoL/QVHztCJmCBE/k+9E5BDX
 cmjO6e9MO2whENnZ/hCIXYdsnH26ykaSADDVq4w+ZdY4M6n61Ey8F0FWppsIjGEq7vFdD+ND1tr
 rvF9yZd1I3yXCuyCEzB/g8Y7WQkjW8qosq2/n1m973uV74+XHx9pXdP60YlaiDwkjdvS0Pb6wIv
 RQHgjSzBkZ2lH+YDnW0dnz6eCpdDsjTMgopujrOiScm3dzlFKcWJOmk+wskNoQQVO17/FVBvIaM
 FUhA9QYgbBiJ80/+mMos1OhMQby4ExOQnUYN5yth2ihXACUz
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Existing device trees specify only a single clock-output-name for the
PCIe PHYs. The function phy_aux_clk_register() expects a second entry in
that property. When it doesn't find it, it returns an error, thus
failing the probe of the PHY and thus breaking support for the
corresponding PCIe host.

Follow the approach of the combo USB+DT PHY and generate the name for
the AUX clocks instead of requiring it in DT.

Fixes: 583ca9ccfa80 ("phy: qcom: qmp-pcie: register second optional PHY AUX clock")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 8cb91b9114d6..5b36cc7ac78b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -4033,14 +4033,11 @@ static int phy_aux_clk_register(struct qmp_pcie *qmp, struct device_node *np)
 {
 	struct clk_fixed_rate *fixed = &qmp->aux_clk_fixed;
 	struct clk_init_data init = { };
-	int ret;
+	char name[64];
 
-	ret = of_property_read_string_index(np, "clock-output-names", 1, &init.name);
-	if (ret) {
-		dev_err(qmp->dev, "%pOFn: No clock-output-names index 1\n", np);
-		return ret;
-	}
+	snprintf(name, sizeof(name), "%s::phy_aux_clk", dev_name(qmp->dev));
 
+	init.name = name;
 	init.ops = &clk_fixed_rate_ops;
 
 	fixed->fixed_rate = qmp->cfg->aux_clock_rate;

-- 
2.39.2


