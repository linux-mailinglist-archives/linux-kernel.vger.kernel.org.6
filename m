Return-Path: <linux-kernel+bounces-303031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15994960660
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBC21C22434
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0192419EEA2;
	Tue, 27 Aug 2024 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HG7NQBls"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D119E7F9
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752567; cv=none; b=JKGlIaqgkCAhe0oR3aSA/QcqOm0bec6rUYPLKvBe8MyA8n1mfV6hPh09FLPPIQjKZBs77cjZd5U3KsOL4Mu7wD0lFNHzuHACLpnhsJg9j/JMboSw7op9P9rpv+pSCPb2zehmbfs/3kGFotZghbTUIv6I9I3w9ykmgTfw8/OILds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752567; c=relaxed/simple;
	bh=LBvhRma7fI8JVth7/NQQV6dLoRL7Em1JoE7ZYHHju0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X05rREZE6O1zaFOpCI+UAqFdd0TmahSmCHGC12+7FTgssGFloOh60cq1qqdG/RUVS0ts9nSnTbcJxfXRKDiljXE8gCLen8ugXr9lkk1myfqxeTu57uZQslMON9wt1mpd8ddVHYxhuD9v9HtxWCFQoteWOcuvct5ThnszJedGXMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HG7NQBls; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3153561a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724752565; x=1725357365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sghYcwjnzdejWIjBpN1UzeYRtefjC2IMHo4HFLUj5uA=;
        b=HG7NQBls/dVCUu5i137mGlKyXL+jriiR1O9eymxZsVpxRpn0Lpq1v5V9h5AZaFlQd4
         QBot8I/H5vzMsIZDeYQByANozpNq4OXmONNFRqAsji70X6Zs7TDXUwn+Oo1KJ/55aAH+
         uMqn7mQpnAMugvwFUlJD4Reng2QquFwGp55dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752565; x=1725357365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sghYcwjnzdejWIjBpN1UzeYRtefjC2IMHo4HFLUj5uA=;
        b=KSQiZXkddEaUw/po0BMpwOI/FwWkSUC4z1Gah9DwBj9CGq4gvQOKoMduTFLqVWtqY/
         rJ50DOq9B+Coerdenz8AKbb9GKCbELP9kHZvxTG+eQHAbe78tS2i7dP0hXoJDc/dM02F
         JkC3en/SBVApEQ9b8pqg4XyLINKD0rMev7OTOcen6irgY4+mNk3wPH/T82VXuiVmZlpY
         wR6ssyHxKBxmufULGjmNW264xCe7k6vMS4257paGR0MuSKev8X83Cba1RsqYaf27oWl7
         QICYRrx39SzkMfuRM4bUcMxYEcn9D2rEdORsvG2Kjy/X6tljZK36DF5lW14/SnlDbt6H
         qJBg==
X-Forwarded-Encrypted: i=1; AJvYcCUbhqPH/O7kHUdmyrVYGjNumjF2tf43xYaLXDTGoiI4tJRU2Zy0orTw2F6FdL4tfjIRme3YpqrJTqV/Y3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2GWGFBKvepQzYzlikTo5YZC4sC4hCf+rQFoPzJ0b2bm1l/gju
	izr7SzUSdE4xlAeUcyW3Zy4s7JBPrdmydKFW9QDmKy7YEFjwCDeGIuWsXL7wyQ==
X-Google-Smtp-Source: AGHT+IFjt2qwKKVbLe4sOBHHmEf4C7vlTf8mEf3uCumq5WKVMPiLmtrco3HnyLt+ixtp3ic1ZXph6A==
X-Received: by 2002:a05:6a21:1192:b0:1c2:8efc:88e9 with SMTP id adf61e73a8af0-1cc8b58f912mr11509172637.40.1724752565164;
        Tue, 27 Aug 2024 02:56:05 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:3102:657e:87f4:c646])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560c2basm80006775ad.222.2024.08.27.02.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:56:04 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4/8] regulator: core: Add missing kerneldoc Return sections
Date: Tue, 27 Aug 2024 17:55:44 +0800
Message-ID: <20240827095550.675018-5-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240827095550.675018-1-wenst@chromium.org>
References: <20240827095550.675018-1-wenst@chromium.org>
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
 drivers/regulator/core.c | 65 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b1950cbc046a..1f2303a2ba7b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -139,6 +139,8 @@ static bool regulator_ops_is_valid(struct regulator_dev *rdev, int ops)
  * once. If a task, which is calling this function is other
  * than the one, which initially locked the mutex, it will
  * wait on mutex.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 static inline int regulator_lock_nested(struct regulator_dev *rdev,
 					struct ww_acquire_ctx *ww_ctx)
@@ -1464,6 +1466,8 @@ static int handle_notify_limits(struct regulator_dev *rdev,
  * Constraints *must* be set by platform code in order for some
  * regulator operations to proceed i.e. set_voltage, set_current_limit,
  * set_mode.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 static int set_machine_constraints(struct regulator_dev *rdev)
 {
@@ -1702,6 +1706,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
  * Called by platform initialisation code to set the supply regulator for this
  * regulator. This ensures that a regulators supply will also be enabled by the
  * core if it's child is enabled.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 static int set_supply(struct regulator_dev *rdev,
 		      struct regulator_dev *supply_rdev)
@@ -1734,6 +1740,8 @@ static int set_supply(struct regulator_dev *rdev,
  * sources to symbolic names for supplies for use by devices.  Devices
  * should use these symbolic names to request regulators, avoiding the
  * need to provide board-specific regulator names as platform data.
+ *
+ * Return: 0 on success or negative error number on failure.
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
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_register_supply_alias(struct device *dev, const char *id,
 				    struct device *alias_dev,
@@ -2640,6 +2652,8 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
  *
  * GPIO is enabled in case of initial use. (enable_count is 0)
  * GPIO is disabled when it is not shared any more. (enable_count <= 1)
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 {
@@ -2962,6 +2976,8 @@ static int _regulator_enable(struct regulator *regulator)
  *
  * NOTE: the output value can be set by other drivers, boot loader or may be
  * hardwired in the regulator.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_enable(struct regulator *regulator)
 {
@@ -3072,6 +3088,8 @@ static int _regulator_disable(struct regulator *regulator)
  * NOTE: this will only disable the regulator output if no other consumer
  * devices have it enabled, the regulator device supports disabling and
  * machine constraints permit this operation.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_disable(struct regulator *regulator)
 {
@@ -3121,6 +3139,8 @@ static int _regulator_force_disable(struct regulator_dev *rdev)
  * NOTE: this *will* disable the regulator output even if other consumer
  * devices have it enabled. This should be used for situations when device
  * damage will likely occur if the regulator is not disabled (e.g. over temp).
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_force_disable(struct regulator *regulator)
 {
@@ -3203,6 +3223,8 @@ static void regulator_disable_work(struct work_struct *work)
  * NOTE: this will only disable the regulator output if no other consumer
  * devices have it enabled, the regulator device supports disabling and
  * machine constraints permit this operation.
+ *
+ * Return: 0 on success or negative error number on failure.
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
@@ -4215,6 +4240,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
  * request voltage that meets the system constraints will be used.
  * Regulator system constraints must be set for this regulator before
  * calling this function otherwise this call will fail.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
@@ -4325,6 +4352,8 @@ EXPORT_SYMBOL_GPL(regulator_set_suspend_voltage);
  * Provided with the starting and ending voltage, this function attempts to
  * calculate the time in microseconds required to rise or fall to this new
  * voltage.
+ *
+ * Return: ramp time in microseconds, or negative error number if calculation failed.
  */
 int regulator_set_voltage_time(struct regulator *regulator,
 			       int old_uV, int new_uV)
@@ -4382,6 +4411,8 @@ EXPORT_SYMBOL_GPL(regulator_set_voltage_time);
  *
  * Drivers providing ramp_delay in regulation_constraints can use this as their
  * set_voltage_time_sel() operation.
+ *
+ * Return: ramp time in microseconds, or negative error number if calculation failed.
  */
 int regulator_set_voltage_time_sel(struct regulator_dev *rdev,
 				   unsigned int old_selector,
@@ -4434,6 +4465,8 @@ int regulator_sync_voltage_rdev(struct regulator_dev *rdev)
  * Re-apply the last configured voltage.  This is intended to be used
  * where some external control source the consumer is cooperating with
  * has caused the configured voltage to change.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_sync_voltage(struct regulator *regulator)
 {
@@ -4565,6 +4598,8 @@ EXPORT_SYMBOL_GPL(regulator_get_voltage);
  *
  * NOTE: Regulator system constraints must be set for this regulator before
  * calling this function otherwise this call will fail.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_set_current_limit(struct regulator *regulator,
 			       int min_uA, int max_uA)
@@ -4638,6 +4673,8 @@ EXPORT_SYMBOL_GPL(regulator_get_current_limit);
  *
  * NOTE: Regulator system constraints must be set for this regulator before
  * calling this function otherwise this call will fail.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_set_mode(struct regulator *regulator, unsigned int mode)
 {
@@ -4699,6 +4736,9 @@ static unsigned int _regulator_get_mode(struct regulator_dev *rdev)
  * @regulator: regulator source
  *
  * Get the current regulator operating mode.
+ *
+ * Return: Current operating mode as %REGULATOR_MODE_* values,
+ *	   or negative error number on failure.
  */
 unsigned int regulator_get_mode(struct regulator *regulator)
 {
@@ -4745,6 +4785,8 @@ static int _regulator_get_error_flags(struct regulator_dev *rdev,
  * @flags: pointer to store error flags
  *
  * Get the current regulator error information.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_get_error_flags(struct regulator *regulator,
 				unsigned int *flags)
@@ -4817,6 +4859,9 @@ EXPORT_SYMBOL_GPL(regulator_set_load);
  * for the regulator also enable bypass mode and the machine
  * constraints allow this.  Bypass mode means that the regulator is
  * simply passing the input directly to the output with no regulation.
+ *
+ * Return: 0 on success or if changing bypass is not possible;
+ *	   negative error number on failure.
  */
 int regulator_allow_bypass(struct regulator *regulator, bool enable)
 {
@@ -4874,6 +4919,8 @@ EXPORT_SYMBOL_GPL(regulator_allow_bypass);
  * @nb: notifier block
  *
  * Register notifier block to receive regulator events.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_register_notifier(struct regulator *regulator,
 			      struct notifier_block *nb)
@@ -4889,6 +4936,8 @@ EXPORT_SYMBOL_GPL(regulator_register_notifier);
  * @nb: notifier block
  *
  * Unregister regulator event notifier block.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_unregister_notifier(struct regulator *regulator,
 				struct notifier_block *nb)
@@ -5179,6 +5228,8 @@ static void regulator_handle_critical(struct regulator_dev *rdev,
  *
  * Called by regulator drivers to notify clients a regulator event has
  * occurred.
+ *
+ * Return: %NOTIFY_DONE.
  */
 int regulator_notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data)
@@ -5197,6 +5248,8 @@ EXPORT_SYMBOL_GPL(regulator_notifier_call_chain);
  * @mode: Mode to convert
  *
  * Convert a regulator mode into a status.
+ *
+ * Return: %REGULATOR_STATUS_* value corresponding to given mode.
  */
 int regulator_mode_to_status(unsigned int mode)
 {
@@ -5887,6 +5940,8 @@ EXPORT_SYMBOL_GPL(regulator_unregister);
  * @dev: ``&struct device`` pointer that is passed to _regulator_suspend()
  *
  * Configure each regulator with it's suspend operating parameters for state.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 static int regulator_suspend(struct device *dev)
 {
@@ -5976,6 +6031,8 @@ EXPORT_SYMBOL_GPL(regulator_has_full_constraints);
  *
  * Get rdev regulator driver private data. This call can be used in the
  * regulator driver context.
+ *
+ * Return: pointer to regulator driver private data.
  */
 void *rdev_get_drvdata(struct regulator_dev *rdev)
 {
@@ -5989,6 +6046,8 @@ EXPORT_SYMBOL_GPL(rdev_get_drvdata);
  *
  * Get regulator driver private data. This call can be used in the consumer
  * driver context when non API regulator specific functions need to be called.
+ *
+ * Return: pointer to regulator driver private data.
  */
 void *regulator_get_drvdata(struct regulator *regulator)
 {
@@ -6010,6 +6069,8 @@ EXPORT_SYMBOL_GPL(regulator_set_drvdata);
 /**
  * rdev_get_id - get regulator ID
  * @rdev: regulator
+ *
+ * Return: regulator ID for @rdev.
  */
 int rdev_get_id(struct regulator_dev *rdev)
 {
-- 
2.46.0.295.g3b9ea8a38a-goog


