Return-Path: <linux-kernel+bounces-303030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7708496065F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD4D28500C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E07119DF65;
	Tue, 27 Aug 2024 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ppqaf3kA"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F919DF74
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752566; cv=none; b=HOiFHgdvpJUSmJNXm3RstzEAAKjGf4vwHxPxIs82hEWFGcof9pXFjyWDUXOk8nsSxQtcLjBAUT6oH9SKNO8wcOmehzypve3BRYq3DVJ6eaf2bpxubyZD9WS8QKrBx0oCWmPbTMbPyA9wpbCDGCku8WLh7wloQU80JIZlQNuYgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752566; c=relaxed/simple;
	bh=hWiPvOMyFndhmj2nO6WnPJBI755Oilx522etrqUOGrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7xmQviLzNntbkF5vJuFHdPTPFPlzs7cxp22ZYeM1Bm/8onDXJxOl4Icls6zPGXT+k8JNZT71FX31uaBTi2pcrkXUUiPPTUOVzhI85TkBdb+wv3ixHVzS53e6nuoqhPVoSbLMRUpvoMmfUm6vYKIsoCrKkwcMZ34C2+zJXH+Goo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ppqaf3kA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20223b5c1c0so47220105ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724752563; x=1725357363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LLSsNj3le8TWETIDzCV0x45IW45F1GT/zaPgv3xeew=;
        b=Ppqaf3kAV5bvC8SwLovbZrg5Klq8wMQ91dmB5zjdYE3jp/HLFVkMwCJ+3+EaZz5eqa
         2WaIEJiuZQlDfIo/oERZFKUgdiCeuz3xPHfn7U9UUcq4lIWwyhazHP+mRGLAAZ7bon2O
         0YxdHCEweTNJz/7cWWa2k9QkYucSUZ/YczA9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752563; x=1725357363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LLSsNj3le8TWETIDzCV0x45IW45F1GT/zaPgv3xeew=;
        b=gJDQ6XPtAixYSQJkvtcz26lXr1AF+a2BJ/6x4trswGA6RtVpmRiiNL9y8qWhpFVXvo
         8kk79jMgjeUyzE/C3ROrGU+PrA6jkS83OHRJsXDjOH/pDwk5osg7FI/otgBtEVwwjtI0
         Q8qNdbp/cgD9hlqK/9ZPWGB369K6o+xNHD8s/JojRUxbvJb4st/53uzDtIz8etSs1HFq
         FIwjiLLoNTNRXI8NCHljNabxztxsglYGLvoFq74F4Kihsfml4Cvjdd15sHZxLYs/mjui
         3EAkDhHdjmQK1/YcYQkFdNZKGE/VhVBAWc77wjV9m+/Yd9DGNu282cjT7Mo7vzMf3aiM
         g0zw==
X-Forwarded-Encrypted: i=1; AJvYcCUjBVGf1PQtDv7m8XsgUNVUL0cP3aDud0xF+Sv4wpsVEbqRd0r0rwYiabrkylXIi/4u1J0zZsy2mYQZmYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrekNK+OupKRT7ZArpDtHX+SjWKb8WAyo8hbr5oQ6OcWcqJVjx
	B8N5R4iqk+19KUGdh1nuReWAsnbmuxpCnteZaQ+lgZ4u6D8V8lDOELFhRd1zYA==
X-Google-Smtp-Source: AGHT+IHnP0UxGHShDudSxRf4EKVdCozcxdusgqEAENCL/YU2wzK66FdkoWkYdwQomaRjL9BY0Eb7tw==
X-Received: by 2002:a17:902:c411:b0:203:a046:c676 with SMTP id d9443c01a7336-204ddfe8059mr21403475ad.0.1724752563346;
        Tue, 27 Aug 2024 02:56:03 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:3102:657e:87f4:c646])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560c2basm80006775ad.222.2024.08.27.02.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:56:03 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/8] regulator: core: Fix incorrectly formatted kerneldoc "Return" sections
Date: Tue, 27 Aug 2024 17:55:43 +0800
Message-ID: <20240827095550.675018-4-wenst@chromium.org>
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
functions in the regulator core. Many of them actually have descriptions
about the return values, just not in the format kernel-doc wants.

Convert these to use the proper "Return:" section header. The existing
descriptions have been reworded and moved around to fit the grammar and
formatting.

In a few cases where the functions don't call even more functions
and the error numbers are known, those are documented in detail.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/core.c | 101 ++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 45 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3a1b6fd9780d..b1950cbc046a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -427,8 +427,9 @@ static void regulator_lock_dependent(struct regulator_dev *rdev,
  *
  * Traverse all child nodes.
  * Extract the child regulator device node corresponding to the supply name.
- * returns the device node corresponding to the regulator if found, else
- * returns NULL.
+ *
+ * Return: pointer the &struct device_node corresponding to the regulator if found,
+ *	   or %NULL if not found.
  */
 static struct device_node *of_get_child_regulator(struct device_node *parent,
 						  const char *prop_name)
@@ -460,8 +461,9 @@ static struct device_node *of_get_child_regulator(struct device_node *parent,
  * @supply: regulator supply name
  *
  * Extract the regulator device node corresponding to the supply name.
- * returns the device node corresponding to the regulator if found, else
- * returns NULL.
+ *
+ * Return: pointer the &struct device_node corresponding to the regulator if found,
+ *	   or %NULL if not found.
  */
 static struct device_node *of_get_regulator(struct device *dev, const char *supply)
 {
@@ -2308,13 +2310,13 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
  * @dev: device for regulator "consumer"
  * @id: Supply name or regulator ID.
  *
- * Returns a struct regulator corresponding to the regulator producer,
- * or IS_ERR() condition containing errno.
- *
  * Use of supply names configured via set_consumer_device_supply() is
  * strongly encouraged.  It is recommended that the supply name used
  * should match the name used for the supply and/or the relevant
  * device pins in the datasheet.
+ *
+ * Return: pointer to a &struct regulator corresponding to the regulator
+ *	   producer, or ERR_PTR() encoded negative error number.
  */
 struct regulator *regulator_get(struct device *dev, const char *id)
 {
@@ -2327,11 +2329,9 @@ EXPORT_SYMBOL_GPL(regulator_get);
  * @dev: device for regulator "consumer"
  * @id: Supply name or regulator ID.
  *
- * Returns a struct regulator corresponding to the regulator producer,
- * or IS_ERR() condition containing errno.  Other consumers will be
- * unable to obtain this regulator while this reference is held and the
- * use count for the regulator will be initialised to reflect the current
- * state of the regulator.
+ * Other consumers will be unable to obtain this regulator while this
+ * reference is held and the use count for the regulator will be
+ * initialised to reflect the current state of the regulator.
  *
  * This is intended for use by consumers which cannot tolerate shared
  * use of the regulator such as those which need to force the
@@ -2342,6 +2342,9 @@ EXPORT_SYMBOL_GPL(regulator_get);
  * strongly encouraged.  It is recommended that the supply name used
  * should match the name used for the supply and/or the relevant
  * device pins in the datasheet.
+ *
+ * Return: pointer to a &struct regulator corresponding to the regulator
+ *	   producer, or ERR_PTR() encoded negative error number.
  */
 struct regulator *regulator_get_exclusive(struct device *dev, const char *id)
 {
@@ -2354,9 +2357,6 @@ EXPORT_SYMBOL_GPL(regulator_get_exclusive);
  * @dev: device for regulator "consumer"
  * @id: Supply name or regulator ID.
  *
- * Returns a struct regulator corresponding to the regulator producer,
- * or IS_ERR() condition containing errno.
- *
  * This is intended for use by consumers for devices which can have
  * some supplies unconnected in normal use, such as some MMC devices.
  * It can allow the regulator core to provide stub supplies for other
@@ -2368,6 +2368,9 @@ EXPORT_SYMBOL_GPL(regulator_get_exclusive);
  * strongly encouraged.  It is recommended that the supply name used
  * should match the name used for the supply and/or the relevant
  * device pins in the datasheet.
+ *
+ * Return: pointer to a &struct regulator corresponding to the regulator
+ *	   producer, or ERR_PTR() encoded negative error number.
  */
 struct regulator *regulator_get_optional(struct device *dev, const char *id)
 {
@@ -2507,12 +2510,12 @@ EXPORT_SYMBOL_GPL(regulator_unregister_supply_alias);
  * lookup the supply
  * @num_id: Number of aliases to register
  *
- * @return 0 on success, an errno on failure.
- *
  * This helper function allows drivers to register several supply
  * aliases in one operation.  If any of the aliases cannot be
  * registered any aliases that were registered will be removed
  * before returning to the caller.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_bulk_register_supply_alias(struct device *dev,
 					 const char *const *id,
@@ -2837,7 +2840,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
  * responsible for keeping track of the refcount for a given regulator consumer
  * and applying / unapplying these things.
  *
- * Returns 0 upon no error; -error upon error.
+ * Return: 0 on success or negative error number on failure.
  */
 static int _regulator_handle_consumer_enable(struct regulator *regulator)
 {
@@ -2863,7 +2866,7 @@ static int _regulator_handle_consumer_enable(struct regulator *regulator)
  *
  * The opposite of _regulator_handle_consumer_enable().
  *
- * Returns 0 upon no error; -error upon error.
+ * Return: 0 on success or negative error number on failure.
  */
 static int _regulator_handle_consumer_disable(struct regulator *regulator)
 {
@@ -3271,13 +3274,13 @@ static int _regulator_list_voltage(struct regulator_dev *rdev,
  * regulator_is_enabled - is the regulator output enabled
  * @regulator: regulator source
  *
- * Returns positive if the regulator driver backing the source/client
- * has requested that the device be enabled, zero if it hasn't, else a
- * negative errno code.
- *
  * Note that the device backing this regulator handle can have multiple
  * users, so it might be enabled even if regulator_enable() was never
  * called for this particular source.
+ *
+ * Return: positive if the regulator driver backing the source/client
+ * has requested that the device be enabled, zero if it hasn't, else a
+ * negative error number.
  */
 int regulator_is_enabled(struct regulator *regulator)
 {
@@ -3298,9 +3301,10 @@ EXPORT_SYMBOL_GPL(regulator_is_enabled);
  * regulator_count_voltages - count regulator_list_voltage() selectors
  * @regulator: regulator source
  *
- * Returns number of selectors, or negative errno.  Selectors are
- * numbered starting at zero, and typically correspond to bitfields
- * in hardware registers.
+ * Return: number of selectors for @regulator, or negative error number.
+ *
+ * Selectors are numbered starting at zero, and typically correspond to
+ * bitfields in hardware registers.
  */
 int regulator_count_voltages(struct regulator *regulator)
 {
@@ -3322,9 +3326,9 @@ EXPORT_SYMBOL_GPL(regulator_count_voltages);
  * @selector: identify voltage to list
  * Context: can sleep
  *
- * Returns a voltage that can be passed to @regulator_set_voltage(),
- * zero if this selector code can't be used on this system, or a
- * negative errno.
+ * Return: voltage for @selector that can be passed to regulator_set_voltage(),
+ *	   0 if @selector can't be used on this system, or a negative error
+ *	   number on failure.
  */
 int regulator_list_voltage(struct regulator *regulator, unsigned selector)
 {
@@ -3336,8 +3340,8 @@ EXPORT_SYMBOL_GPL(regulator_list_voltage);
  * regulator_get_regmap - get the regulator's register map
  * @regulator: regulator source
  *
- * Returns the register map for the given regulator, or an ERR_PTR value
- * if the regulator doesn't use regmap.
+ * Return: pointer to &struct regmap for @regulator, or ERR_PTR()
+ *	   encoded -%EOPNOTSUPP if @regulator doesn't use regmap.
  */
 struct regmap *regulator_get_regmap(struct regulator *regulator)
 {
@@ -3387,7 +3391,9 @@ EXPORT_SYMBOL_GPL(regulator_get_hardware_vsel_register);
  * directly written to the regulator registers. The address of the voltage
  * register can be determined by calling @regulator_get_hardware_vsel_register.
  *
- * On error a negative errno is returned.
+ * Return: 0 on success, -%EINVAL if the selector is outside the supported
+ *	   range, or -%EOPNOTSUPP if the regulator does not support voltage
+ *	   selectors.
  */
 int regulator_list_hardware_vsel(struct regulator *regulator,
 				 unsigned selector)
@@ -3414,7 +3420,7 @@ EXPORT_SYMBOL_GPL(regulator_list_hardware_vsel);
  * Request that the regulator be enabled/disabled with the regulator output at
  * the predefined voltage or current value.
  *
- * On success 0 is returned, otherwise a negative errno is returned.
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_hardware_enable(struct regulator *regulator, bool enable)
 {
@@ -3438,8 +3444,8 @@ EXPORT_SYMBOL_GPL(regulator_hardware_enable);
  * regulator_get_linear_step - return the voltage step size between VSEL values
  * @regulator: regulator source
  *
- * Returns the voltage step size between VSEL values for linear
- * regulators, or return 0 if the regulator isn't a linear regulator.
+ * Return: the voltage step size between VSEL values for linear regulators,
+ *	   or 0 if the regulator isn't a linear regulator.
  */
 unsigned int regulator_get_linear_step(struct regulator *regulator)
 {
@@ -4526,7 +4532,7 @@ EXPORT_SYMBOL_GPL(regulator_get_voltage_rdev);
  * regulator_get_voltage - get regulator output voltage
  * @regulator: regulator source
  *
- * This returns the current regulator voltage in uV.
+ * Return: current regulator voltage in uV, or negative error number on failure.
  *
  * NOTE: If the regulator is disabled it will return the voltage value. This
  * function should not be used to determine regulator state.
@@ -4610,7 +4616,8 @@ static int _regulator_get_current_limit(struct regulator_dev *rdev)
  * regulator_get_current_limit - get regulator output current
  * @regulator: regulator source
  *
- * This returns the current supplied by the specified current sink in uA.
+ * Return: current supplied by the specified current sink in uA,
+ *	   or negative error number on failure.
  *
  * NOTE: If the regulator is disabled it will return the current value. This
  * function should not be used to determine regulator state.
@@ -4778,7 +4785,7 @@ EXPORT_SYMBOL_GPL(regulator_get_error_flags);
  * If a regulator is an always-on regulator then an individual consumer's
  * load will still be removed if that consumer is fully disabled.
  *
- * On error a negative errno is returned.
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_set_load(struct regulator *regulator, int uA_load)
 {
@@ -4963,12 +4970,12 @@ int _regulator_bulk_get(struct device *dev, int num_consumers,
  * @num_consumers: Number of consumers to register
  * @consumers:     Configuration of consumers; clients are stored here.
  *
- * @return 0 on success, an errno on failure.
- *
  * This helper function allows drivers to get several regulator
  * consumers in one operation.  If any of the regulators cannot be
  * acquired then any regulators that were allocated will be freed
  * before returning to the caller.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_bulk_get(struct device *dev, int num_consumers,
 		       struct regulator_bulk_data *consumers)
@@ -4989,12 +4996,13 @@ static void regulator_bulk_enable_async(void *data, async_cookie_t cookie)
  *
  * @num_consumers: Number of consumers
  * @consumers:     Consumer data; clients are stored here.
- * @return         0 on success, an errno on failure
  *
  * This convenience API allows consumers to enable multiple regulator
  * clients in a single API call.  If any consumers cannot be enabled
  * then any others that were enabled will be disabled again prior to
  * return.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_bulk_enable(int num_consumers,
 			  struct regulator_bulk_data *consumers)
@@ -5038,12 +5046,13 @@ EXPORT_SYMBOL_GPL(regulator_bulk_enable);
  *
  * @num_consumers: Number of consumers
  * @consumers:     Consumer data; clients are stored here.
- * @return         0 on success, an errno on failure
  *
  * This convenience API allows consumers to disable multiple regulator
  * clients in a single API call.  If any consumers cannot be disabled
  * then any others that were disabled will be enabled again prior to
  * return.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_bulk_disable(int num_consumers,
 			   struct regulator_bulk_data *consumers)
@@ -5077,7 +5086,6 @@ EXPORT_SYMBOL_GPL(regulator_bulk_disable);
  *
  * @num_consumers: Number of consumers
  * @consumers:     Consumer data; clients are stored here.
- * @return         0 on success, an errno on failure
  *
  * This convenience API allows consumers to forcibly disable multiple regulator
  * clients in a single API call.
@@ -5085,6 +5093,8 @@ EXPORT_SYMBOL_GPL(regulator_bulk_disable);
  * likely occur if the regulators are not disabled (e.g. over temp).
  * Although regulator_force_disable function call for some consumers can
  * return error numbers, the function is called for all consumers.
+ *
+ * Return: 0 on success or negative error number on failure.
  */
 int regulator_bulk_force_disable(int num_consumers,
 			   struct regulator_bulk_data *consumers)
@@ -5581,8 +5591,9 @@ static struct regulator_coupler generic_regulator_coupler = {
  * @cfg: runtime configuration for regulator
  *
  * Called by regulator drivers to register a regulator.
- * Returns a valid pointer to struct regulator_dev on success
- * or an ERR_PTR() on error.
+ *
+ * Return: pointer to valid &struct regulator_dev on success
+ *	   or ERR_PTR() encoded negative error number on failure.
  */
 struct regulator_dev *
 regulator_register(struct device *dev,
-- 
2.46.0.295.g3b9ea8a38a-goog


