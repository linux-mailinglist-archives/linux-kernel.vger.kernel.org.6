Return-Path: <linux-kernel+bounces-207117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 501CB901295
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02ED01F21A30
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03417D37F;
	Sat,  8 Jun 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNBGcX2T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FCF17B4EC;
	Sat,  8 Jun 2024 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717862241; cv=none; b=Z6tUhhIpJ7X1fOsu3tmsWG8Oc7nYMJu6NjzW5D3ZfkmVAFa73fLuX8RdsJS37EWvJpY4KFUpKE+bQ6UjJoUW8mkOOkqJ54bZqAFfQJUIMTQQ2fMO/r8ZeenmOjbS2Sk+QgDezU1Od3C6Cnzz06kiugES7jD43GjIuLJfRf7sFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717862241; c=relaxed/simple;
	bh=lga3d+eXyDGzWJge8vvnwfcv1gyBqqWJmkYtkVpaX6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pd5lToeKxwJI5oJmwJ8QmqVuogL7V5D33PXeZEqssVW4kJFm4z0IT5hjlWn2noCRa1NjPqhH/Q+6BCTd0pnurNA3FPbO5iuLhOtDRlpujQmWXDmfodnurHqJBzA86lugHBzZY2ZtwACPZGMrJEgvqKIgBH9iuYtuTnIugGXaos0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNBGcX2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B97C4AF0A;
	Sat,  8 Jun 2024 15:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717862240;
	bh=lga3d+eXyDGzWJge8vvnwfcv1gyBqqWJmkYtkVpaX6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNBGcX2TjpqViRONTdOjfZ+TDAqfR/AyiALbCvbv7g4dgLWJqMDQG/7h3vWMTLV75
	 RoHTz3DbMmLJ5YIPs84wVA6K5OTXBXoUVi3g0itoxg+pkaXtBRmi9WqGQqzHKtgONG
	 PAdib/OIpmwAxzlFiRe4SQ9K6QFimDger8z/9xyKL/7DXFVnD03ZhHzjqVSWVopPZY
	 nDPlVdDlvpZoxImhDDB+kmvwThZ5JZX19+V1CmKe6otXnxaK8WqlE9JnAduWaxPI0x
	 7EUc1YqQmfa5uwQeKqOY8K2YwaERQW8soipbvYdH9won9vwaB/SqxZolMq1EI9O6Oe
	 ZofGNdv6FfKwg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sFyRT-000000003Q3-49fK;
	Sat, 08 Jun 2024 17:57:20 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 06/12] mfd: pm8008: Rename irq chip
Date: Sat,  8 Jun 2024 17:55:20 +0200
Message-ID: <20240608155526.12996-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240608155526.12996-1-johan+linaro@kernel.org>
References: <20240608155526.12996-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the redundant "irq" suffix from the irq chip name.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/mfd/qcom-pm8008.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 18173c7a7e7b..bab17417aeec 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -130,7 +130,7 @@ static int pm8008_set_type_config(unsigned int **buf, unsigned int type,
 }
 
 static const struct regmap_irq_chip pm8008_irq_chip = {
-	.name			= "pm8008_irq",
+	.name			= "pm8008",
 	.main_status		= I2C_INTR_STATUS_BASE,
 	.num_main_regs		= 1,
 	.irqs			= pm8008_irqs,
-- 
2.44.1


