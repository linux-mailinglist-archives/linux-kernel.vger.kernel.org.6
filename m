Return-Path: <linux-kernel+bounces-306438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87149963F10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BB41C242FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3694C18D620;
	Thu, 29 Aug 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O2OljoS9"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A5218CC12
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921517; cv=none; b=BL5QaJ3/gcJTzK2kIucZi6UVKxaXO3WNXQ3wbjGhyxs1qJYQBYtVrv9IWzVt18ZCkYvpzqb6LUZxodSMt1baaJdY0tp7mpuLll0jUup84Ii+L0r6S6ja25T5v67pDplrAykNhEafsWDu25RxqVVvRxeXzEVCv+7r1kkQXq3glHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921517; c=relaxed/simple;
	bh=CITJ/pXW+PNEYY3huU/lIyFmUCDxWKW9ESaqs7VfFa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IshJYECRmanffJw9e0SZtG6ghoz6B6/5LZBmaZDo4dQU1P3R9aN4jTC9hODGGsnOaw3zMxnSwGjJKb7zcjpRzLadtGBywdkAVl+inqTXLmb+S6svbTk9f5tPk7iNj4Y6zgb/HKzfHf6M5OGno6AT67gfSx/5ShLjR/XJUJmVlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O2OljoS9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-204f52fe74dso3560465ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724921515; x=1725526315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Peh3KRS2otd9KMsQofYzoADoRSJG/N+Ns2pNhtBQcKs=;
        b=O2OljoS9x9fVCvJ60pIxUL1m5HBIrgWNj9Q2k9eXlJDust0J+E1Sj5JIvOmlrSOXFl
         k7Q5LtdyfFEESAETSj2bl6fgJaJoXAGQ/84aHsY8HFFKap7q1wuBnzgmTYkPg6ssCgh8
         LNX5nwPse86LBpXDZw/yfFokZJhBPTFR2Nwf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921515; x=1725526315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Peh3KRS2otd9KMsQofYzoADoRSJG/N+Ns2pNhtBQcKs=;
        b=WjbX81ORqAiGdV7NcHUsmY2FuqKLorHr9VVcxcO+hfSwnUotQZd6+HHNINgPfJPsUP
         9Ig5HWx8NPrwwM53GaSeyMCSuPheDagC4NMCn5hg7mAsnCYazGCb7l3iTJOld4k7DuJB
         Kz58fHPTqzIogChZlF8T90E1cnh3HkRm9SVW2ntWzKYuCQE1bnTCziRLkegsiRTa8xSM
         6DvfnKN4nXsqDukCqgmCHSSPHoPQ+fpmBUF/vnt9xu1j8HDNQfAA2nJlOIekIHAJbhe7
         iR585iZf0S719L4G1IaJLrgsWUg7xwjonK+kCi90+x+fOee4MoQaquvic+DAOoro/cnG
         pGCA==
X-Forwarded-Encrypted: i=1; AJvYcCVkdVF/9lyg+nIoNeM2SWGdX4V9fkjapXKJStX8WY4mn+I7PvW+nj3WToZPazthSOGEQgyCkkoyb73g20Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYK9RyiaGt+/g8BkvGWoUQkxAya6C4yBViYgI6YhH1a4Jhh5wh
	OXcJ/1n1YSvZvLKsKtJbX4qJ0ta6cHVD0VoGA7d1tdKupqTqmSdBBpUC6i2zDA==
X-Google-Smtp-Source: AGHT+IGo3tvc2nBfopqiex+TZW5v8gp7UnG5vd9DIk3b/JKNnSyE+2RajYwWR7PuW+PQtgmHbWWHHQ==
X-Received: by 2002:a17:902:ec84:b0:203:a0c7:3156 with SMTP id d9443c01a7336-2050c23699amr22263655ad.5.1724921515115;
        Thu, 29 Aug 2024 01:51:55 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fbe5:6d6c:1cc7:23f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515543fbdsm6924165ad.218.2024.08.29.01.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:51:54 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 03/10] regulator: core: Fix incorrectly formatted kerneldoc "Return" sections
Date: Thu, 29 Aug 2024 16:51:23 +0800
Message-ID: <20240829085131.1361701-4-wenst@chromium.org>
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
functions in the regulator core. Many of them actually have descriptions
about the return values, just not in the format kernel-doc wants.

Convert these to use the proper "Return:" section header. The existing
descriptions have been reworded and moved around to fit the grammar and
formatting.

In a few cases where the functions don't call even more functions
and the error numbers are known, those are documented in detail.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Capitalized first word of first sentence in "Return" section
- Added articles ("the", "a") to the description based on surrounding
  and function implementation context
- Indented "Return" section for regulator_is_enabled()
---
 drivers/regulator/core.c | 101 ++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 45 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 0ce3fe1774fe..d7656b91f5bb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -427,8 +427,9 @@ static void regulator_lock_dependent(struct regulator_dev *rdev,
  *
  * Traverse all child nodes.
  * Extract the child regulator device node corresponding to the supply name.
- * returns the device node corresponding to the regulator if found, else
- * returns NULL.
+ *
+ * Return: Pointer to the &struct device_node corresponding to the regulator
+ *	   if found, or %NULL if not found.
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
+ * Return: Pointer to the &struct device_node corresponding to the regulator
+ *	   if found, or %NULL if not found.
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
+ * Return: Pointer to a &struct regulator corresponding to the regulator
+ *	   producer, or an ERR_PTR() encoded negative error number.
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
+ * Return: Pointer to a &struct regulator corresponding to the regulator
+ *	   producer, or an ERR_PTR() encoded negative error number.
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
+ * Return: Pointer to a &struct regulator corresponding to the regulator
+ *	   producer, or an ERR_PTR() encoded negative error number.
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
+ * Return: 0 on success or a negative error number on failure.
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
+ * Return: 0 on success or a negative error number on failure.
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
+ * Return: Positive if the regulator driver backing the source/client
+ *	   has requested that the device be enabled, zero if it hasn't,
+ *	   else a negative error number.
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
+ * Return: Number of selectors for @regulator, or negative error number.
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
+ * Return: Voltage for @selector that can be passed to regulator_set_voltage(),
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
+ * Return: Pointer to the &struct regmap for @regulator, or ERR_PTR()
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
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_hardware_enable(struct regulator *regulator, bool enable)
 {
@@ -3438,8 +3444,8 @@ EXPORT_SYMBOL_GPL(regulator_hardware_enable);
  * regulator_get_linear_step - return the voltage step size between VSEL values
  * @regulator: regulator source
  *
- * Returns the voltage step size between VSEL values for linear
- * regulators, or return 0 if the regulator isn't a linear regulator.
+ * Return: The voltage step size between VSEL values for linear regulators,
+ *	   or 0 if the regulator isn't a linear regulator.
  */
 unsigned int regulator_get_linear_step(struct regulator *regulator)
 {
@@ -4527,7 +4533,7 @@ EXPORT_SYMBOL_GPL(regulator_get_voltage_rdev);
  * regulator_get_voltage - get regulator output voltage
  * @regulator: regulator source
  *
- * This returns the current regulator voltage in uV.
+ * Return: Current regulator voltage in uV, or a negative error number on failure.
  *
  * NOTE: If the regulator is disabled it will return the voltage value. This
  * function should not be used to determine regulator state.
@@ -4611,7 +4617,8 @@ static int _regulator_get_current_limit(struct regulator_dev *rdev)
  * regulator_get_current_limit - get regulator output current
  * @regulator: regulator source
  *
- * This returns the current supplied by the specified current sink in uA.
+ * Return: Current supplied by the specified current sink in uA,
+ *	   or a negative error number on failure.
  *
  * NOTE: If the regulator is disabled it will return the current value. This
  * function should not be used to determine regulator state.
@@ -4779,7 +4786,7 @@ EXPORT_SYMBOL_GPL(regulator_get_error_flags);
  * If a regulator is an always-on regulator then an individual consumer's
  * load will still be removed if that consumer is fully disabled.
  *
- * On error a negative errno is returned.
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_set_load(struct regulator *regulator, int uA_load)
 {
@@ -4964,12 +4971,12 @@ int _regulator_bulk_get(struct device *dev, int num_consumers,
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
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_bulk_get(struct device *dev, int num_consumers,
 		       struct regulator_bulk_data *consumers)
@@ -4990,12 +4997,13 @@ static void regulator_bulk_enable_async(void *data, async_cookie_t cookie)
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
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_bulk_enable(int num_consumers,
 			  struct regulator_bulk_data *consumers)
@@ -5039,12 +5047,13 @@ EXPORT_SYMBOL_GPL(regulator_bulk_enable);
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
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_bulk_disable(int num_consumers,
 			   struct regulator_bulk_data *consumers)
@@ -5078,7 +5087,6 @@ EXPORT_SYMBOL_GPL(regulator_bulk_disable);
  *
  * @num_consumers: Number of consumers
  * @consumers:     Consumer data; clients are stored here.
- * @return         0 on success, an errno on failure
  *
  * This convenience API allows consumers to forcibly disable multiple regulator
  * clients in a single API call.
@@ -5086,6 +5094,8 @@ EXPORT_SYMBOL_GPL(regulator_bulk_disable);
  * likely occur if the regulators are not disabled (e.g. over temp).
  * Although regulator_force_disable function call for some consumers can
  * return error numbers, the function is called for all consumers.
+ *
+ * Return: 0 on success or a negative error number on failure.
  */
 int regulator_bulk_force_disable(int num_consumers,
 			   struct regulator_bulk_data *consumers)
@@ -5582,8 +5592,9 @@ static struct regulator_coupler generic_regulator_coupler = {
  * @cfg: runtime configuration for regulator
  *
  * Called by regulator drivers to register a regulator.
- * Returns a valid pointer to struct regulator_dev on success
- * or an ERR_PTR() on error.
+ *
+ * Return: Pointer to a valid &struct regulator_dev on success or
+ *	   an ERR_PTR() encoded negative error number on failure.
  */
 struct regulator_dev *
 regulator_register(struct device *dev,
-- 
2.46.0.295.g3b9ea8a38a-goog


