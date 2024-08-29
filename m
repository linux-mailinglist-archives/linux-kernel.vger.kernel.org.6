Return-Path: <linux-kernel+bounces-306439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 752EA963F11
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6FF1F251B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C598E18D640;
	Thu, 29 Aug 2024 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JRcojrtP"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE818C35D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921519; cv=none; b=a+0p8ekLjViu6F4irZY1uTja+jcepGnHDGvIpUeg+GOblArNMyljSGEUrLMO/w3XrlsnKWxazge19Sg3OkhBp0tRVpuWul6h6kwZa0iGIh3oH9Ch1ElIfLf1NpgEKKAhr7++UgKiLLsvwRDGS7nDG7QZQpPV0YuBOQ+Cef1+XsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921519; c=relaxed/simple;
	bh=Ke+pQZjKf0p+gJIaQwR13J4j2KBNs5YVJ0+ePSyhd9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvzwav92end2O3B3XxzrkhIdWTlNsMuy4QnhfC3hybeqjwZzn9FEBrxGWmx0UuE4iVCotCYKeit2fY3JiZesaDnopazqBSpSpc0bZ4j+HnySdqAttoavahMxCxVz9UXMPJpZ3+nJl4mh35uBoxdOZJCT/m+DYFxKFwrhEg4Tq5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JRcojrtP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-202146e93f6so4029875ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724921517; x=1725526317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eExJ/LSKKVvg9hYH9GnPj/p8H26y4FLjUbJxPPs080=;
        b=JRcojrtPgmK4Y7PKhFQ+hU/1OWh6CphqAukaG2bddWOO3/gE0QibBpb2csNep6OdkQ
         JkVYnIvPcYfOW9EILazAnz+XZrPKRNXJrfQXLTZELL+yu9K/w6YMT1TM4F2yDLPKf3Rm
         2+RcBf1MW2vZA/SngBLkN0BxlY5DTp3BF/3tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921517; x=1725526317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eExJ/LSKKVvg9hYH9GnPj/p8H26y4FLjUbJxPPs080=;
        b=iTYrEF5mJSwyYqDtPmvQGyB4L4xIYHsv83C/8eH9IB83nR66Ri57Dhui9BKGvxrjBw
         JTJaypA4VpHfrG1VRUPyb2mIzjuKtxjdhlOxhlpyE7XjrIvvZU/zra6LPIfadMw34ex3
         YmxtyMrWJHKtgpE2bydhBNygdq0cJX+bd9cHRxMcD2SxPLQJ1TOqmzHHDMJLZNJA0iBv
         qEtVPrp0t+cchoODHUhQLeLQ0lmCfNn9Vdd3wqOFzec07lqlxLH1i5IBewU9XClVNy6/
         M3CHilitA4c5fUorHk3vtW1jm2r0SdddAQBOmi/B6xDCP5fe7T9xi1x6VJ+JBuvVrQEd
         +Spw==
X-Forwarded-Encrypted: i=1; AJvYcCWDNYSAulQ+24ITPbNAox3bM2GhBPp8tnCJUDzKq2fLGmJ1fSRYiMhFGFa0o/wXCC6aPFJfBn7lYhhOkik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5w3vHfusm8WjgJOTkf2VQZdFkz3gQaipMmwPQacsv3IOjP/vE
	MtPT+XH8livhzO3LiCCU4sqNognM2lEpTRYPbifSiU9mPypz+FVaG+oUcMF1kw==
X-Google-Smtp-Source: AGHT+IHUH7tsXNguLatZjd+DWsassoMfMvLOPUoskM9fuBDw+9E/mq7qkdIorWuKes7byOLkDCI3Ag==
X-Received: by 2002:a17:902:ce83:b0:202:3ebf:679d with SMTP id d9443c01a7336-2050c3d2936mr21337985ad.37.1724921516915;
        Thu, 29 Aug 2024 01:51:56 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fbe5:6d6c:1cc7:23f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515543fbdsm6924165ad.218.2024.08.29.01.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:51:56 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 04/10] regulator: core: Add missing kerneldoc "Return" sections
Date: Thu, 29 Aug 2024 16:51:24 +0800
Message-ID: <20240829085131.1361701-5-wenst@chromium.org>
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

kernel-doc complains about missing "Return" section for many documented
functions in the regulator core. Some with free-form return value
descriptions have been fixed in the previous patch. The remaining are
completely missing any mention of return values.

Add "Return" sections to these kerneldoc blocks with basic descriptions.
In a few cases where the functions don't call even more functions and
the error numbers are known, those are documented in detail.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Capitalized first word of first sentence in "Return" section
- Added articles ("the", "a") to the description based on surrounding
  and function implementation context
---
 drivers/regulator/core.c | 65 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d7656b91f5bb..0b929ab71188 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -139,6 +139,8 @@ static bool regulator_ops_is_valid(struct regulator_dev *rdev, int ops)
  * once. If a task, which is calling this function is other
  * than the one, which initially locked the mutex, it will
  * wait on mutex.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 static inline int regulator_lock_nested(struct regulator_dev *rdev,
 					struct ww_acquire_ctx *ww_ctx)
@@ -1464,6 +1466,8 @@ static int handle_notify_limits(struct regulator_dev *rdev,
  * Constraints *must* be set by platform code in order for some
  * regulator operations to proceed i.e. set_voltage, set_current_limit,
  * set_mode.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 static int set_machine_constraints(struct regulator_dev *rdev)
 {
@@ -1702,6 +1706,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
  * Called by platform initialisation code to set the supply regulator for this
  * regulator. This ensures that a regulators supply will also be enabled by the
  * core if it's child is enabled.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 static int set_supply(struct regulator_dev *rdev,
 		      struct regulator_dev *supply_rdev)
@@ -1734,6 +1740,8 @@ static int set_supply(struct regulator_dev *rdev,
  * sources to symbolic names for supplies for use by devices.  Devices
  * should use these symbolic names to request regulators, avoiding the
  * need to provide board-specific regulator names as platform data.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 static int set_consumer_device_supply(struct regulator_dev *rdev,
 				      const char *consumer_dev_name,
@@ -2000,11 +2008,13 @@ static struct regulator_dev *regulator_lookup_by_name(const char *name)
  * @dev: device for regulator "consumer".
  * @supply: Supply name or regulator ID.
  *
+ * Return: pointer to &struct regulator_dev or ERR_PTR() encoded negative error number.
+ *
  * If successful, returns a struct regulator_dev that corresponds to the name
  * @supply and with the embedded struct device refcount incremented by one.
  * The refcount must be dropped by calling put_device().
- * On failure one of the following ERR-PTR-encoded values is returned:
- * -ENODEV if lookup fails permanently, -EPROBE_DEFER if lookup could succeed
+ * On failure one of the following ERR_PTR() encoded values is returned:
+ * -%ENODEV if lookup fails permanently, -%EPROBE_DEFER if lookup could succeed
  * in the future.
  */
 static struct regulator_dev *regulator_dev_lookup(struct device *dev,
@@ -2451,6 +2461,8 @@ EXPORT_SYMBOL_GPL(regulator_put);
  *
  * All lookups for id on dev will instead be conducted for alias_id on
  * alias_dev.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_register_supply_alias(struct device *dev, const char *id,
 				    struct device *alias_dev,
@@ -2640,6 +2652,8 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
  *
  * GPIO is enabled in case of initial use. (enable_count is 0)
  * GPIO is disabled when it is not shared any more. (enable_count <= 1)
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 {
@@ -2962,6 +2976,8 @@ static int _regulator_enable(struct regulator *regulator)
  *
  * NOTE: the output value can be set by other drivers, boot loader or may be
  * hardwired in the regulator.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_enable(struct regulator *regulator)
 {
@@ -3072,6 +3088,8 @@ static int _regulator_disable(struct regulator *regulator)
  * NOTE: this will only disable the regulator output if no other consumer
  * devices have it enabled, the regulator device supports disabling and
  * machine constraints permit this operation.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_disable(struct regulator *regulator)
 {
@@ -3121,6 +3139,8 @@ static int _regulator_force_disable(struct regulator_dev *rdev)
  * NOTE: this *will* disable the regulator output even if other consumer
  * devices have it enabled. This should be used for situations when device
  * damage will likely occur if the regulator is not disabled (e.g. over temp).
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_force_disable(struct regulator *regulator)
 {
@@ -3203,6 +3223,8 @@ static void regulator_disable_work(struct work_struct *work)
  * NOTE: this will only disable the regulator output if no other consumer
  * devices have it enabled, the regulator device supports disabling and
  * machine constraints permit this operation.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_disable_deferred(struct regulator *regulator, int ms)
 {
@@ -3362,6 +3384,9 @@ EXPORT_SYMBOL_GPL(regulator_get_regmap);
  * hardware or firmware that can make I2C requests behind the kernel's back,
  * for example.
  *
+ * Return: 0 on success, or -%EOPNOTSUPP if the regulator does not support
+ *         voltage selectors.
+ *
  * On success, the output parameters @vsel_reg and @vsel_mask are filled in
  * and 0 is returned, otherwise a negative errno is returned.
  */
@@ -4216,6 +4241,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
  * request voltage that meets the system constraints will be used.
  * Regulator system constraints must be set for this regulator before
  * calling this function otherwise this call will fail.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
@@ -4326,6 +4353,8 @@ EXPORT_SYMBOL_GPL(regulator_set_suspend_voltage);
  * Provided with the starting and ending voltage, this function attempts to
  * calculate the time in microseconds required to rise or fall to this new
  * voltage.
+ *
+ * Return: ramp time in microseconds, or a negative error number if calculation failed.
  */
 int regulator_set_voltage_time(struct regulator *regulator,
 			       int old_uV, int new_uV)
@@ -4383,6 +4412,8 @@ EXPORT_SYMBOL_GPL(regulator_set_voltage_time);
  *
  * Drivers providing ramp_delay in regulation_constraints can use this as their
  * set_voltage_time_sel() operation.
+ *
+ * Return: ramp time in microseconds, or a negative error number if calculation failed.
  */
 int regulator_set_voltage_time_sel(struct regulator_dev *rdev,
 				   unsigned int old_selector,
@@ -4435,6 +4466,8 @@ int regulator_sync_voltage_rdev(struct regulator_dev *rdev)
  * Re-apply the last configured voltage.  This is intended to be used
  * where some external control source the consumer is cooperating with
  * has caused the configured voltage to change.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_sync_voltage(struct regulator *regulator)
 {
@@ -4566,6 +4599,8 @@ EXPORT_SYMBOL_GPL(regulator_get_voltage);
  *
  * NOTE: Regulator system constraints must be set for this regulator before
  * calling this function otherwise this call will fail.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_set_current_limit(struct regulator *regulator,
 			       int min_uA, int max_uA)
@@ -4639,6 +4674,8 @@ EXPORT_SYMBOL_GPL(regulator_get_current_limit);
  *
  * NOTE: Regulator system constraints must be set for this regulator before
  * calling this function otherwise this call will fail.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_set_mode(struct regulator *regulator, unsigned int mode)
 {
@@ -4700,6 +4737,9 @@ static unsigned int _regulator_get_mode(struct regulator_dev *rdev)
  * @regulator: regulator source
  *
  * Get the current regulator operating mode.
+ *
+ * Return: Current operating mode as %REGULATOR_MODE_* values,
+ *	   or a negative error number on failure.
  */
 unsigned int regulator_get_mode(struct regulator *regulator)
 {
@@ -4746,6 +4786,8 @@ static int _regulator_get_error_flags(struct regulator_dev *rdev,
  * @flags: pointer to store error flags
  *
  * Get the current regulator error information.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_get_error_flags(struct regulator *regulator,
 				unsigned int *flags)
@@ -4818,6 +4860,9 @@ EXPORT_SYMBOL_GPL(regulator_set_load);
  * for the regulator also enable bypass mode and the machine
  * constraints allow this.  Bypass mode means that the regulator is
  * simply passing the input directly to the output with no regulation.
+ *
+ * Return: 0 on success or if changing bypass is not possible, or
+ *	   a negative error number on failure.
  */
 int regulator_allow_bypass(struct regulator *regulator, bool enable)
 {
@@ -4875,6 +4920,8 @@ EXPORT_SYMBOL_GPL(regulator_allow_bypass);
  * @nb: notifier block
  *
  * Register notifier block to receive regulator events.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_register_notifier(struct regulator *regulator,
 			      struct notifier_block *nb)
@@ -4890,6 +4937,8 @@ EXPORT_SYMBOL_GPL(regulator_register_notifier);
  * @nb: notifier block
  *
  * Unregister regulator event notifier block.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_unregister_notifier(struct regulator *regulator,
 				struct notifier_block *nb)
@@ -5180,6 +5229,8 @@ static void regulator_handle_critical(struct regulator_dev *rdev,
  *
  * Called by regulator drivers to notify clients a regulator event has
  * occurred.
+ *
+ * Return: %NOTIFY_DONE.
  */
 int regulator_notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data)
@@ -5198,6 +5249,8 @@ EXPORT_SYMBOL_GPL(regulator_notifier_call_chain);
  * @mode: Mode to convert
  *
  * Convert a regulator mode into a status.
+ *
+ * Return: %REGULATOR_STATUS_* value corresponding to given mode.
  */
 int regulator_mode_to_status(unsigned int mode)
 {
@@ -5888,6 +5941,8 @@ EXPORT_SYMBOL_GPL(regulator_unregister);
  * @dev: ``&struct device`` pointer that is passed to _regulator_suspend()
  *
  * Configure each regulator with it's suspend operating parameters for state.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 static int regulator_suspend(struct device *dev)
 {
@@ -5977,6 +6032,8 @@ EXPORT_SYMBOL_GPL(regulator_has_full_constraints);
  *
  * Get rdev regulator driver private data. This call can be used in the
  * regulator driver context.
+ *
+ * Return: Pointer to regulator driver private data.
  */
 void *rdev_get_drvdata(struct regulator_dev *rdev)
 {
@@ -5990,6 +6047,8 @@ EXPORT_SYMBOL_GPL(rdev_get_drvdata);
  *
  * Get regulator driver private data. This call can be used in the consumer
  * driver context when non API regulator specific functions need to be called.
+ *
+ * Return: Pointer to regulator driver private data.
  */
 void *regulator_get_drvdata(struct regulator *regulator)
 {
@@ -6011,6 +6070,8 @@ EXPORT_SYMBOL_GPL(regulator_set_drvdata);
 /**
  * rdev_get_id - get regulator ID
  * @rdev: regulator
+ *
+ * Return: Regulator ID for @rdev.
  */
 int rdev_get_id(struct regulator_dev *rdev)
 {
-- 
2.46.0.295.g3b9ea8a38a-goog


