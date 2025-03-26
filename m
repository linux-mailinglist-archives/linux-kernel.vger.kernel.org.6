Return-Path: <linux-kernel+bounces-577294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762F1A71AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9272D16B8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861BB1F3B98;
	Wed, 26 Mar 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrqs1UYy"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB914E2E2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003987; cv=none; b=lEjSSSxAL8MqZeoe5ZKU7Ugfk0CSnChcFRZI7/G+xe/eIQOvb72sSVw5FJ5DDu9Wm8CRkw8ntIh68W9yeaaI7h09gsDVZ+mBte6FXyTcMrkTNVdoUkcp9dnha05/Rk26gobZ+Ah2tvoWHVJVyqIQxqzKt7gt+QjJVQBDxHWXX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003987; c=relaxed/simple;
	bh=hNNCePkymmg+NYs3DkRrPQnRgBmPbY4NL9bVwrX85lM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BOSB1XoEVHaN6fWM8spluEmJl3iKvkuXhyL2c2olT8Zieu+9RWUq+UcEHzf0RUk8033brF4dA8a8PhF1tyoLgGrst3wE4HMo0GL3/HKqmANm9xdOWLK/7t+t4NX4n1yidRDZ9L12HuGpP1QBD/qqh0RyNkgNfPs9kRLikF+ozCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lrqs1UYy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso73335805e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743003984; x=1743608784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8xs/xWdaiX3M9cJQlymIzyu+i97cUXJM+NWk64iFLA=;
        b=lrqs1UYyc5dGAdsvbJwkzKm2R9dM3z8Moufz9fqUxXRHqkqK4jIu8p4ZAEg1fqHGgG
         am67RyxMfldhOBRwmqX8NlH2LPqbCrqsNgaxDb2G32PieLsC5RUlT3TiGDk1SOntM6tu
         bFLJWvfQcKfKeo56qd0LyPsoJSm1KGN36kEpUTNQQ5VL7jyO8bj+lwU26wkBQ+NuFDWk
         9qd7kPRyr5Kd48CIXlOOwfOSSHxqA95hutQ5vm08MMd8dMSFA+3r38oF5DE3qWqm2bG8
         qiNrJubdXQQ6HmQgsK8gsg86HIitbCbYM1N/vp3bMqe+XETT2dHVW8WbEbn6nXLnyl01
         3ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743003984; x=1743608784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8xs/xWdaiX3M9cJQlymIzyu+i97cUXJM+NWk64iFLA=;
        b=u4EsnXAnnNGvn0T4WwkTHSvmPEhROhJlQx0VCYbmneoXbS6T49yNss3cpy9zzpqqlh
         Xm6Nzex5FFqO3tLD1MwHIRRQAUzm+fNLKhkM3XgtH52Ldlw6EjgQcvEnTkcJ8o7JZvWQ
         O3dBBjIGAkh1U08JDeAaxA8ZzscI6K1/bokyk5SETtfM9qyjsf5uLMQkNo+TAtmjOWp/
         WE2SGrk/z7B7b5ckgsIXHqB17GFi2yxNU+8VGiNdLKyp5/eh6A3tDi0ZIUHeA3jGB3Gw
         XSrk7MUrYfLEKqtr4rrFemLyIt64LLRjArycK+V0NBjKm7+ztArJJzkMPn+4QNyawCY6
         fJ0A==
X-Gm-Message-State: AOJu0Yza98xYK4vfGTVWdOPsZr0jJdfKWWQ0+8qpinJET5zyw/++wZgh
	QwvXOTuyEU4Iir0SXSc2w2L635mW9sYIE6zEgZZzQjjVsu4L4CaEp2br6WsZzEc=
X-Gm-Gg: ASbGncvvGrlqNJj7XX+UK69jdLFVeY/7J//KDntqm/pDruWfSZhGoK6Db3SNFL+SAuT
	2bqNrMKKYelnkaRiCNksgK134uAXtTzx4VhX8PxBLz1GV2YPdD9/ip1y0uqGd7dIwkX5k7wMLNN
	Ll42uaVvWRWiURIIldxO0q5lAfTiazaPZlS6GKqRy0k56gXaHLXT9jusLS4tMfrTBnOj/yVhfo1
	HDgPGZ1Uu60CCvSuS0T7C1seS1fFgzavdFiS95JXtvW3YumkL6vC9L8C6h5itfKz15y5Loxz7v9
	F1XdcyRQK+6LQSEtP6KL45NscApF+3BfVMHDPIZYbo2RUD0/wd6F3W0kLAuDDgQehtziCH5qaCi
	dSrtR
X-Google-Smtp-Source: AGHT+IGZx5FXYfFFphOwe7pPS7aVSIkPdhhttp6oit9Add11hmPULRvMmrMLB1lr72VRTy5CY3m0Mg==
X-Received: by 2002:a05:600c:1c96:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-43d50a35fa5mr202172855e9.30.1743003983510;
        Wed, 26 Mar 2025 08:46:23 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82f7c82esm5728495e9.37.2025.03.26.08.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:46:22 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: peda@axentia.se
Cc: linux-kernel@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH] mux: core: add exclusive mux controls support
Date: Wed, 26 Mar 2025 15:46:13 +0000
Message-Id: <20250326154613.3735-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Mux control core by design supports mux controls that are shared with
multiple consumers. However in some usecases where the mux is exclusively
owned by one consumer do not need some of the locking and deselect apis.

exclusive apis makes the consumer side of code much simipler.

ex:
From
	if (is_mux_selected)
		mux_control_deselect()

	if (mux_control_select())
		is_mux_selected = false;
	else
		is_mux_selected = true;

to
	if (mux_control_select())
		dev_err("mux select failed..");

This patch adds a new *_get_exclusive() api to request an exclusive mux
control and rest of the apis usage remains same, except that exclusive
mux do not need deselect api calling, drivers can simply select the
desired state and its consumers responsiblity to make sure that correct
state is selected.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mux/core.c           | 123 ++++++++++++++++++++++++++++-------
 include/linux/mux/consumer.h |   3 +
 include/linux/mux/driver.h   |   9 +++
 3 files changed, 113 insertions(+), 22 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 02be4ba37257..e0b8a723948b 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -356,6 +356,10 @@ static void mux_control_delay(struct mux_control *mux, unsigned int delay_us)
  * until mux_control_deselect() or mux_state_deselect() is called (by someone
  * else).
  *
+ * Exception to this is for exclusive mux control, which do not need
+ * mux_state_deselect() as the owner of mux has exclusive access to this mux
+ * and is responsible to set the correct state.
+ *
  * Therefore, make sure to call mux_control_deselect() when the operation is
  * complete and the mux-control is free for others to use, but do not call
  * mux_control_deselect() if mux_control_select() fails.
@@ -368,15 +372,17 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
 {
 	int ret;
 
-	ret = down_killable(&mux->lock);
-	if (ret < 0)
-		return ret;
+	if (!mux->exclusive) {
+		ret = down_killable(&mux->lock);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = __mux_control_select(mux, state);
 	if (ret >= 0)
 		mux_control_delay(mux, delay_us);
 
-	if (ret < 0)
+	if (!mux->exclusive && ret < 0)
 		up(&mux->lock);
 
 	return ret;
@@ -428,14 +434,16 @@ int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
 {
 	int ret;
 
-	if (down_trylock(&mux->lock))
-		return -EBUSY;
+	if (!mux->exclusive) {
+		if (down_trylock(&mux->lock))
+			return -EBUSY;
+	}
 
 	ret = __mux_control_select(mux, state);
 	if (ret >= 0)
 		mux_control_delay(mux, delay_us);
 
-	if (ret < 0)
+	if (!mux->exclusive && ret < 0)
 		up(&mux->lock);
 
 	return ret;
@@ -479,6 +487,10 @@ int mux_control_deselect(struct mux_control *mux)
 {
 	int ret = 0;
 
+	/* exclusive mux control do not deselection */
+	if (mux->exclusive)
+		return -EINVAL;
+
 	if (mux->idle_state != MUX_IDLE_AS_IS &&
 	    mux->idle_state != mux->cached_state)
 		ret = mux_control_set(mux, mux->idle_state);
@@ -523,13 +535,15 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
  * @mux_name: The name identifying the mux-control.
  * @state: Pointer to where the requested state is returned, or NULL when
  *         the required multiplexer states are handled by other means.
+ * @get_type: Type of mux get, shared or exclusive
  *
  * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
  */
 static struct mux_control *mux_get(struct device *dev, const char *mux_name,
-				   unsigned int *state)
+				   unsigned int *state, enum mux_control_get_type get_type)
 {
 	struct device_node *np = dev->of_node;
+	struct mux_control *mux_ctrl;
 	struct of_phandle_args args;
 	struct mux_chip *mux_chip;
 	unsigned int controller;
@@ -606,7 +620,25 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 		return ERR_PTR(-EINVAL);
 	}
 
-	return &mux_chip->mux[controller];
+	mux_ctrl = &mux_chip->mux[controller];
+
+	if (mux_ctrl->exclusive) {
+		mux_ctrl = ERR_PTR(-EPERM);
+		put_device(&mux_chip->dev);
+		return mux_ctrl;
+	}
+
+	if (get_type == EXCLUSIVE_GET && mux_ctrl->open_count) {
+		mux_ctrl = ERR_PTR(-EBUSY);
+		put_device(&mux_chip->dev);
+		return mux_ctrl;
+	}
+
+	mux_ctrl->open_count++;
+	if (get_type == EXCLUSIVE_GET)
+		mux_ctrl->exclusive = true;
+
+	return mux_ctrl;
 }
 
 /**
@@ -618,10 +650,33 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
  */
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 {
-	return mux_get(dev, mux_name, NULL);
+	return mux_get(dev, mux_name, NULL, NORMAL_GET);
 }
 EXPORT_SYMBOL_GPL(mux_control_get);
 
+/**
+ * mux_control_get_exclusive() - Get the mux-control exclusive access for a device.
+ * @dev: The device that needs a exclusive mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Other consumers will be unable to obtain this mux-control while this
+ * reference is held and the use count for the mux-control will be
+ * initialised to reflect the current state of the mux-control.
+ *
+ * This is intended for use by consumers which do not need mux shared
+ * mux-control, and need exclusive control of mux.
+ * exclusive mux controls do not need mux_control_deselect() before
+ * selecting a mux state. Any mux state can be selected directly
+ * by calling mux_control_select() as long as state is supported.
+ *
+ * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+struct mux_control *mux_control_get_exclusive(struct device *dev, const char *mux_name)
+{
+	return mux_get(dev, mux_name, NULL, EXCLUSIVE_GET);
+}
+EXPORT_SYMBOL_GPL(mux_control_get_exclusive);
+
 /**
  * mux_control_put() - Put away the mux-control for good.
  * @mux: The mux-control to put away.
@@ -630,6 +685,8 @@ EXPORT_SYMBOL_GPL(mux_control_get);
  */
 void mux_control_put(struct mux_control *mux)
 {
+	mux->open_count--;
+	mux->exclusive = false;
 	put_device(&mux->chip->dev);
 }
 EXPORT_SYMBOL_GPL(mux_control_put);
@@ -641,16 +698,8 @@ static void devm_mux_control_release(struct device *dev, void *res)
 	mux_control_put(mux);
 }
 
-/**
- * devm_mux_control_get() - Get the mux-control for a device, with resource
- *			    management.
- * @dev: The device that needs a mux-control.
- * @mux_name: The name identifying the mux-control.
- *
- * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.
- */
-struct mux_control *devm_mux_control_get(struct device *dev,
-					 const char *mux_name)
+static struct mux_control *__devm_mux_control_get(struct device *dev, const char *mux_name,
+						  enum mux_control_get_type type)
 {
 	struct mux_control **ptr, *mux;
 
@@ -658,7 +707,10 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	mux = mux_control_get(dev, mux_name);
+	if (type == EXCLUSIVE_GET)
+		mux = mux_control_get_exclusive(dev, mux_name);
+	else
+		mux = mux_control_get(dev, mux_name);
 	if (IS_ERR(mux)) {
 		devres_free(ptr);
 		return mux;
@@ -669,8 +721,35 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 
 	return mux;
 }
+
+/**
+ * devm_mux_control_get() - Get the mux-control for a device, with resource
+ *			    management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_control_get(dev, mux_name, NORMAL_GET);
+}
 EXPORT_SYMBOL_GPL(devm_mux_control_get);
 
+/**
+ * devm_mux_control_get_exclusive() - Get the mux-control exclusive for a device,
+ * 				 with resource management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+struct mux_control *devm_mux_control_get_exclusive(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_control_get(dev, mux_name, EXCLUSIVE_GET);
+}
+EXPORT_SYMBOL_GPL(devm_mux_control_get_exclusive);
+
 /*
  * mux_state_get() - Get the mux-state for a device.
  * @dev: The device that needs a mux-state.
@@ -686,7 +765,7 @@ static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
 	if (!mstate)
 		return ERR_PTR(-ENOMEM);
 
-	mstate->mux = mux_get(dev, mux_name, &mstate->state);
+	mstate->mux = mux_get(dev, mux_name, &mstate->state, NORMAL_GET);
 	if (IS_ERR(mstate->mux)) {
 		int err = PTR_ERR(mstate->mux);
 
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 2e25c838f831..649b86c74bf3 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -54,8 +54,11 @@ int mux_control_deselect(struct mux_control *mux);
 int mux_state_deselect(struct mux_state *mstate);
 
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
+struct mux_control *mux_control_get_exclusive(struct device *dev, const char *mux_name);
 void mux_control_put(struct mux_control *mux);
 
+struct mux_control *devm_mux_control_get_exclusive(struct device *dev,
+					 const char *mux_name);
 struct mux_control *devm_mux_control_get(struct device *dev,
 					 const char *mux_name);
 struct mux_state *devm_mux_state_get(struct device *dev,
diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index 18824064f8c0..cda75b9b4775 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -26,6 +26,12 @@ struct mux_control_ops {
 	int (*set)(struct mux_control *mux, int state);
 };
 
+enum mux_control_get_type {
+	NORMAL_GET, /*  Shared */
+	EXCLUSIVE_GET,
+	MAX_GET_TYPE
+};
+
 /**
  * struct mux_control -	Represents a mux controller.
  * @lock:		Protects the mux controller state.
@@ -34,6 +40,7 @@ struct mux_control_ops {
  * @states:		The number of mux controller states.
  * @idle_state:		The mux controller state to use when inactive, or one
  *			of MUX_IDLE_AS_IS and MUX_IDLE_DISCONNECT.
+ * @type:		Indicate type of mux control, Shared or Exclusive
  * @last_change:	Timestamp of last change
  *
  * Mux drivers may only change @states and @idle_state, and may only do so
@@ -50,6 +57,8 @@ struct mux_control {
 	unsigned int states;
 	int idle_state;
 
+	int open_count;
+	bool exclusive;
 	ktime_t last_change;
 };
 
-- 
2.39.5


