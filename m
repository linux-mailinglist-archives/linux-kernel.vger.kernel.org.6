Return-Path: <linux-kernel+bounces-306445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1AF963F18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDB01C243E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A016C18E355;
	Thu, 29 Aug 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HNLduTVS"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E481218E364
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921532; cv=none; b=J26qQnJ+9yvVtcLlkuGxeOULEqz2LG+2vijy66I5LGKYnLWHNwYVlE8a3zWU1YPLRvXQiDBCeYn/kFHFPFf9pV5WSgff2zuPEQIxfrI4w7nXK1GPmQb9dDkH0jNMRFxguq8JZ7H1fEgDRkMVLOiZKTvhUiklsIJ68bClL2sO3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921532; c=relaxed/simple;
	bh=kNIE9BNf8Zv75I/FZ7NOqQGoA6g4YLu7tMFeythIcfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBNHPT97MfSYD3xZB/bOrYZpvhL8Htu7sYnfG43Y7EreyF+ZsFLHRfgLDnEEb5nDqBzxo7GvyiD6IcSdSs16VVJttN+zRABq6dIQu9XBFzee2p9jleQRbFbB8gBw1E4ERNszu/6gpzfUFMI4EgeEONvQr9CLJXeZPVgBbFiAQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HNLduTVS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2021c03c13aso3323085ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724921530; x=1725526330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWRchbsiI/jit0CfCKj74uSu6ttu4ROq7KriKtjM8cE=;
        b=HNLduTVS+NiusJfaTa1ZilLuHUGB4fa5G+TghDaL+Dnlt4i3FdhmkFdf4znX7IFH3B
         u0tTxjWHtsCJCN1mRz08Ki4BDgTH8IGpHWBj7FgFoE1wsvMFuKqb3244VirxtU0hZfnN
         rZxk5acMvM1kbklMARJLDoEa2959nUsuPP8S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921530; x=1725526330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWRchbsiI/jit0CfCKj74uSu6ttu4ROq7KriKtjM8cE=;
        b=RGyrarZmrWDIdPACT089kBSJnnqoQcGVq+iFpoHWTah6rB8zjz1wiX+Prvdr42L3bi
         Z8G0N+kRFzKtyaZxfJsrq+Fgx625uIfJ6RmdQBPe+1Z8E/EYFUZob47s6RZEK6JijnhS
         4u4g//ZhacSfgMlb139gA0SavIEOKDeLgMcKg9u0dD1436IzScUPP6Xb55ZHXe+YqLrs
         MHjV9bgoJRw0jsQDnPnFHBocmC/na9JtDfOTWfsOsA1As7zpIMAkSKPypM4CD74P2oJd
         x4Wdf3fffnjSZ7t8IPnfRAUL4L6JhyE2DkYsuO3orVr0umixV+LVxdyKZbEJAEbBtX1O
         Uq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX50qE1OvPaIcd2rpLhr0OTE20PTK7dmvR/scuz23SiU67kQtMwNET8QYtlB8Bfk77s9+L/y6kosheQwIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw85vf9Lpva83RbuMwXSMxzhQafnqcGK5Od6Qs24G+4A3gvZ3x
	1ok/0llYVOyDlrRuRwF02LtKm2B4kNX0dWyfc9tElIGR5c2akIjyDYE4sP10jw==
X-Google-Smtp-Source: AGHT+IGOtUweXCQpV0LrosRSEGtTwTNe13Qf96/F2cMlyFpBImeyvt9uH0ZmoT0phJz7470I5C5maQ==
X-Received: by 2002:a17:902:da84:b0:202:60e:76f6 with SMTP id d9443c01a7336-2050ea4ce5emr31435735ad.29.1724921529985;
        Thu, 29 Aug 2024 01:52:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fbe5:6d6c:1cc7:23f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515543fbdsm6924165ad.218.2024.08.29.01.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:52:09 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 10/10] regulator: Unify "negative error number" terminology in comments
Date: Thu, 29 Aug 2024 16:51:30 +0800
Message-ID: <20240829085131.1361701-11-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240829085131.1361701-1-wenst@chromium.org>
References: <20240829085131.1361701-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commits cleaning up kerneldoc used the term "negative error
number" to refer to error condition return values. Update remaining
instances of other terminology such as "error code" or "errno" as
well so the whole regulator subsystem is unified.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- New patch
---
 drivers/regulator/core.c                |  2 +-
 drivers/regulator/devres.c              | 18 +++++++++---------
 drivers/regulator/fixed.c               |  2 +-
 drivers/regulator/irq_helpers.c         |  2 +-
 drivers/regulator/max77802-regulator.c  |  4 ++--
 drivers/regulator/qcom-rpmh-regulator.c |  6 +++---
 drivers/regulator/qcom_smd-regulator.c  |  2 +-
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 0b929ab71188..c1d11924d892 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3388,7 +3388,7 @@ EXPORT_SYMBOL_GPL(regulator_get_regmap);
  *         voltage selectors.
  *
  * On success, the output parameters @vsel_reg and @vsel_mask are filled in
- * and 0 is returned, otherwise a negative errno is returned.
+ * and 0 is returned, otherwise a negative error number is returned.
  */
 int regulator_get_hardware_vsel_register(struct regulator *regulator,
 					 unsigned *vsel_reg,
diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 7111c46e9de1..1b893cdd1aad 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -163,7 +163,7 @@ EXPORT_SYMBOL_GPL(devm_regulator_get_optional);
  * In cases where the supply is not strictly required, callers can check for
  * -ENODEV error and handle it accordingly.
  *
- * Returns: voltage in microvolts on success, or an error code on failure.
+ * Returns: voltage in microvolts on success, or an negative error number on failure.
  */
 int devm_regulator_get_enable_read_voltage(struct device *dev, const char *id)
 {
@@ -174,8 +174,8 @@ int devm_regulator_get_enable_read_voltage(struct device *dev, const char *id)
 	 * Since we need a real voltage, we use devm_regulator_get_optional()
 	 * rather than getting a dummy regulator with devm_regulator_get() and
 	 * then letting regulator_get_voltage() fail with -EINVAL. This way, the
-	 * caller can handle the -ENODEV error code if needed instead of the
-	 * ambiguous -EINVAL.
+	 * caller can handle the -ENODEV negative error number if needed instead
+	 * of the ambiguous -EINVAL.
 	 */
 	r = devm_regulator_get_optional(dev, id);
 	if (IS_ERR(r))
@@ -276,7 +276,7 @@ static int _devm_regulator_bulk_get(struct device *dev, int num_consumers,
  * @num_consumers: number of consumers to register
  * @consumers:     configuration of consumers; clients are stored here.
  *
- * @return 0 on success, an errno on failure.
+ * @return 0 on success, a negative error number on failure.
  *
  * This helper function allows drivers to get several regulator
  * consumers in one operation with management, the regulators will
@@ -299,7 +299,7 @@ EXPORT_SYMBOL_GPL(devm_regulator_bulk_get);
  * @num_consumers: number of consumers to register
  * @consumers:     configuration of consumers; clients are stored here.
  *
- * @return 0 on success, an errno on failure.
+ * @return 0 on success, a negative error number on failure.
  *
  * This helper function allows drivers to exclusively get several
  * regulator consumers in one operation with management, the regulators
@@ -326,7 +326,7 @@ EXPORT_SYMBOL_GPL(devm_regulator_bulk_get_exclusive);
  * This is a convenience function to allow bulk regulator configuration
  * to be stored "static const" in files.
  *
- * Return: 0 on success, an errno on failure.
+ * Return: 0 on success, a negative error number on failure.
  */
 int devm_regulator_bulk_get_const(struct device *dev, int num_consumers,
 				  const struct regulator_bulk_data *in_consumers,
@@ -393,7 +393,7 @@ static void devm_regulator_bulk_disable(void *res)
  * @num_consumers: number of consumers to register
  * @id:            list of supply names or regulator IDs
  *
- * @return 0 on success, an errno on failure.
+ * @return 0 on success, a negative error number on failure.
  *
  * This helper function allows drivers to get several regulator
  * consumers in one operation with management, the regulators will
@@ -574,7 +574,7 @@ static void devm_regulator_unregister_supply_alias(struct device *dev,
  *             lookup the supply
  * @num_id:    number of aliases to register
  *
- * @return 0 on success, an errno on failure.
+ * @return 0 on success, a negative error number on failure.
  *
  * This helper function allows drivers to register several supply
  * aliases in one operation, the aliases will be automatically
@@ -726,7 +726,7 @@ static void regulator_irq_helper_drop(void *res)
  *			IRQ.
  * @rdev_amount:	Amount of regulators associated with this IRQ.
  *
- * Return: handle to irq_helper or an ERR_PTR() encoded error code.
+ * Return: handle to irq_helper or an ERR_PTR() encoded negative error number.
  */
 void *devm_regulator_irq_helper(struct device *dev,
 				const struct regulator_irq_desc *d, int irq,
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index c3de9c783d26..1cb647ed70c6 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -129,7 +129,7 @@ static irqreturn_t reg_fixed_under_voltage_irq_handler(int irq, void *data)
  * If it's an optional IRQ and not found, it returns 0.
  * Otherwise, it attempts to request the threaded IRQ.
  *
- * Return: 0 on success, or error code on failure.
+ * Return: 0 on success, or a negative error number on failure.
  */
 static int reg_fixed_get_irqs(struct device *dev,
 			      struct fixed_voltage_data *priv)
diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index 2de7b907c81d..0aa188b2bbb2 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -333,7 +333,7 @@ static void init_rdev_errors(struct regulator_irq *h)
  *			IRQ.
  * @rdev_amount:	Amount of regulators associated with this IRQ.
  *
- * Return: handle to irq_helper or an ERR_PTR() encoded error code.
+ * Return: handle to irq_helper or an ERR_PTR() encoded negative error number.
  */
 void *regulator_irq_helper(struct device *dev,
 			   const struct regulator_irq_desc *d, int irq,
diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index 69eb6abd2551..b2e87642bec4 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -160,8 +160,8 @@ static unsigned max77802_get_mode(struct regulator_dev *rdev)
  * Enable Control Logic3 by PWRREQ (LDO 3)
  *
  * If setting the regulator mode fails, the function only warns but does
- * not return an error code to avoid the regulator core to stop setting
- * the operating mode for the remaining regulators.
+ * not return a negative error number to avoid the regulator core to stop
+ * setting the operating mode for the remaining regulators.
  */
 static int max77802_set_suspend_mode(struct regulator_dev *rdev,
 				     unsigned int mode)
diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 6b4cb7ba49c7..6c343b4b9d15 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -158,7 +158,7 @@ struct rpmh_vreg_init_data {
  * @wait_for_ack:	Boolean indicating if execution must wait until the
  *			request has been acknowledged as complete
  *
- * Return: 0 on success, errno on failure
+ * Return: 0 on success, or a negative error number on failure
  */
 static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
 			struct tcs_cmd *cmd, bool wait_for_ack)
@@ -317,7 +317,7 @@ static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
  * This function is used in the regulator_ops for VRM type RPMh regulator
  * devices.
  *
- * Return: 0 on success, errno on failure
+ * Return: 0 on success, or a negative error number on failure
  */
 static unsigned int rpmh_regulator_vrm_get_optimum_mode(
 	struct regulator_dev *rdev, int input_uV, int output_uV, int load_uA)
@@ -409,7 +409,7 @@ static const struct regulator_ops rpmh_regulator_xob_ops = {
  * @pmic_rpmh_data:	Pointer to a null-terminated array of rpmh-regulator
  *			resources defined for the top level PMIC device
  *
- * Return: 0 on success, errno on failure
+ * Return: 0 on success, or a negative error number on failure
  */
 static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
 			struct device_node *node, const char *pmic_id,
diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 6761ada0cf7d..28e7ce60cb61 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -1386,7 +1386,7 @@ MODULE_DEVICE_TABLE(of, rpm_of_match);
  * @pmic_rpm_data:	Pointer to a null-terminated array of qcom_smd-regulator
  *			resources defined for the top level PMIC device
  *
- * Return: 0 on success, errno on failure
+ * Return: 0 on success, or a negative error number on failure
  */
 static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev,
 				   struct device_node *node,
-- 
2.46.0.295.g3b9ea8a38a-goog


