Return-Path: <linux-kernel+bounces-328087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1781977EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8C91C217A5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580C51D86F1;
	Fri, 13 Sep 2024 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7oqb9B1"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4B1BE872
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227847; cv=none; b=CGiGowv9pwhvHMF736FV3fb9kKh5eLxrlvfgeqRxcMj/x3WW2tT/+V5gOIuA20RTbzBVdZOuiXCFaam7ceUyXIRldM7q4Q1z7xMW6XmkviICLAv0nq0aAcMzD9UyRGzsJ/ImxE6GX3XO35VDdAVcSjfNdr6RQtzDik9q3WWvpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227847; c=relaxed/simple;
	bh=Jut2JJvS8BiaXRNKbc2eNw8lvcDiJ+FvNNwMY8axnGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rHjuwmhq6wWiy9RjrzQeWtHMVwjrnCLqt7POtD0xY5PEbia281F7u87WeuHS59pPn+oWREau1BA75/NPOE6jwcBFUyQBZdXxSkGd2bJRO6tam3tdCGrLKKAJR2b0jyxutPp8/WNIjfMAJ0ZfUsAF0kFEcWc6KWuNMPL2b8KeuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I7oqb9B1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c3ed267a7bso2288967a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726227844; x=1726832644; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qlYXu9wdGGHl/oITpGKAFgbisLnw4KYV2wASACpU2Lc=;
        b=I7oqb9B1VADqDrQwglTnodY7wgRLuyFhi3wC0vvSJNoHtrvCiZie+iF2o+HBwKwooA
         Gj38bcK9mQHAaHveTW5swYjeufEpJbgkKtJHJtFIe3KsLr15/2Il6DAGSmZnLAB76zpm
         +NMhwZrts8dXCkPQyD0PNsbsbCMH0JQHMUuDmvo6FjHCybsITm9qKA/Qn3da4qMTI4TQ
         9/BA1JYQDLL++P48UURp8YMpVq44LNfoA666vM6lgb0FLse0RXjf2/2+t3L8bfbar+Xa
         7AWcjdyDM1u1i+cnD84XR0qLRW53I26kdp4sU0Cin+GZ4Trrt70qQ0A+ghPC/b65YP96
         24xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726227844; x=1726832644;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlYXu9wdGGHl/oITpGKAFgbisLnw4KYV2wASACpU2Lc=;
        b=XdoFM1MMpwfU6417j5yEL2CMEe2iew1zPlUJyXc+OqRhxRqekyLv8905vVzePJYnCD
         CxtS37gc98JrMhvN3TmbTOsHu/RyPDUUmqOnFnGaCWnEDS0Xd4nQwTBewWAK+u3Iot/g
         kV0G0nYROeegzZPX/EFS1eE7zqbxA3rK9jRtidARrGHdgag5onSjyrm5W9mM/K1hBFq4
         hhplKdDm3rVGp3nNlAqqBFJzCT//B5lcavPTgF1aBUxFt7KX4MgFIKDf3zCn6ZczwQYj
         GG5+InSFA5eDrBfkYNedIpoBiIUBMDkrZ+cf4mDPPLStwWPUDNiWDiAdUHFSVXEUBOGw
         TJsA==
X-Gm-Message-State: AOJu0YzFFNxOIeVkQgk9VSRFAut46TzGHT51+lTNmH7IBNDEmpgDl5fh
	ncSIvzbJxwwvA+QqgYwV+oSGWz8/jmDSUGbL9D5wi5wdN1mbl74CTOEmM6KDi2Q=
X-Google-Smtp-Source: AGHT+IFgdBHhnRR181adepCCcniOpts8e4r4NbrXOVCetFZwhxCcF3N/3TnCcklxP7H8J5/0vsGvgw==
X-Received: by 2002:a05:6402:295:b0:5c2:7727:6109 with SMTP id 4fb4d7f45d1cf-5c413e53f72mr3628609a12.30.1726227843865;
        Fri, 13 Sep 2024 04:44:03 -0700 (PDT)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8ad51sm7570249a12.79.2024.09.13.04.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 04:44:03 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 13 Sep 2024 12:43:58 +0100
Subject: [PATCH] regulator: update some comments ([gs]et_voltage_vsel vs
 [gs]et_voltage_sel)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240913-regulator-typos-v1-1-92781c93f638@linaro.org>
X-B4-Tracking: v=1; b=H4sIAH4l5GYC/x3MQQqAIBBA0avErBO0ErSrRAupyQZCY6wowrsnL
 d/i/xcSMmGCvnqB8aJEMRSouoJpdcGjoLkYGtl00qpWMPpzc0dkcTx7TEJPVhlrNFqFUKqdcaH
 7Pw5jzh/BUQUkYQAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Some comments here are referring to a non-existent
regulator_ops::get_voltage_vsel() where ::get_voltage_sel() is meant,
and similar for ::set_voltage_vsel() / ::set_voltage_sel().

Update the comments.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/regulator/helpers.c          | 8 ++++----
 drivers/regulator/mt6357-regulator.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 6e1ace660b8c..0def82eb8b46 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -125,7 +125,7 @@ static int regulator_range_selector_to_index(struct regulator_dev *rdev,
  *
  * Regulators that use regmap for their register I/O and use pickable
  * ranges can set the vsel_reg, vsel_mask, vsel_range_reg and vsel_range_mask
- * fields in their descriptor and then use this as their get_voltage_vsel
+ * fields in their descriptor and then use this as their get_voltage_sel
  * operation, saving some code.
  */
 int regulator_get_voltage_sel_pickable_regmap(struct regulator_dev *rdev)
@@ -195,7 +195,7 @@ static int write_separate_vsel_and_range(struct regulator_dev *rdev,
  *
  * Regulators that use regmap for their register I/O and use pickable
  * ranges can set the vsel_reg, vsel_mask, vsel_range_reg and vsel_range_mask
- * fields in their descriptor and then use this as their set_voltage_vsel
+ * fields in their descriptor and then use this as their set_voltage_sel
  * operation, saving some code.
  */
 int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
@@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(regulator_set_voltage_sel_pickable_regmap);
  *
  * Regulators that use regmap for their register I/O can set the
  * vsel_reg and vsel_mask fields in their descriptor and then use this
- * as their get_voltage_vsel operation, saving some code.
+ * as their get_voltage_sel operation, saving some code.
  */
 int regulator_get_voltage_sel_regmap(struct regulator_dev *rdev)
 {
@@ -276,7 +276,7 @@ EXPORT_SYMBOL_GPL(regulator_get_voltage_sel_regmap);
  *
  * Regulators that use regmap for their register I/O can set the
  * vsel_reg and vsel_mask fields in their descriptor and then use this
- * as their set_voltage_vsel operation, saving some code.
+ * as their set_voltage_sel operation, saving some code.
  */
 int regulator_set_voltage_sel_regmap(struct regulator_dev *rdev, unsigned sel)
 {
diff --git a/drivers/regulator/mt6357-regulator.c b/drivers/regulator/mt6357-regulator.c
index c0439a4e0b50..1eb69c7a6acb 100644
--- a/drivers/regulator/mt6357-regulator.c
+++ b/drivers/regulator/mt6357-regulator.c
@@ -123,7 +123,7 @@ struct mt6357_regulator_info {
  *
  * Regulators that use regmap for their register I/O can set the
  * da_vsel_reg and da_vsel_mask fields in the info structure and
- * then use this as their get_voltage_vsel operation.
+ * then use this as their get_voltage_sel operation.
  */
 static int mt6357_get_buck_voltage_sel(struct regulator_dev *rdev)
 {

---
base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
change-id: 20240913-regulator-typos-5c918985e91e

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


