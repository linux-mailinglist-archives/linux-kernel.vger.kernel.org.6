Return-Path: <linux-kernel+bounces-442092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4759ED7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374E7168C26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E39235C40;
	Wed, 11 Dec 2024 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhjcpX90"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA56235C32
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950650; cv=none; b=TzckOKnbHuFT4h9ZEOTp/8Cue7X2c23dn8u7FDRmXaJ9edXNB5hiayLT+DObi77oQMfVj4MfeGce9O1h1HNZQGuiYrtUxL+bDahHYGC8MLAqfKOYBKxYV+pPygOiHmZkyRuDBx3PpW17sK9QkJG+57i8ye+z0fImxAhsNJCuFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950650; c=relaxed/simple;
	bh=XvZ70etxbl7a+HEq8W/PmORE99I680EgH7X9zOxKkeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uvnw9vZnIBN5Zi8jQiUgMmoHt4JFQGMXuxX+5zaIW43/hu93nszoQ3NQ5s2zb2Tit6qkl/K9poyqT0i0sojZd+kEwAg3YaTmlLcT6Iipgdwzpss2j+/jeHF9eyCWkh4WPY1ihOUVMgJmOKNtEIH9Jk5URKPSFCMHJBuXk9xJnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhjcpX90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C643CC4CEDD;
	Wed, 11 Dec 2024 20:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733950650;
	bh=XvZ70etxbl7a+HEq8W/PmORE99I680EgH7X9zOxKkeU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FhjcpX904qnBERVAcvLCNepto31hdwld4EYeU1UemcH4x0AkLC9lvG+vQO3caXnc5
	 e8QlKXo25UKC+eYBrRzv/M5XJ47aws1MUKuu/30z+RTh1n9g19S6C/ZmCSJl/csmAu
	 yKnsVsCOYVpFZItt///kQdR/aNJIeUClZX9WVVsjMvbRn2n44OH2fNZfcCTNnCDMkq
	 gNcZOOLNB5FcPebsjx2tuQqU0AWcn9nQlzxFL+LiItqfDnwR5hxLsaUDQU1rtnrXVe
	 NdzNwgTcGEZn5BqsvTMJKHbWhnRu0+NA7UZEhX/wwh5o60dr/OHf24MsN0AOjt4XCP
	 dq9WQtAydnghg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 11 Dec 2024 14:57:12 -0600
Subject: [PATCH 1/3] mfd: syscon: Fix race in device_node_get_regmap()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-syscon-fixes-v1-1-b5ac8c219e96@kernel.org>
References: <20241211-syscon-fixes-v1-0-b5ac8c219e96@kernel.org>
In-Reply-To: <20241211-syscon-fixes-v1-0-b5ac8c219e96@kernel.org>
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Pankaj Dubey <pankaj.dubey@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev

It is possible for multiple, simultaneous callers calling
device_node_get_regmap() with the same node to fail to find an entry in
the syscon_list. There is a period of time while the first caller is
calling of_syscon_register() that subsequent callers also fail to find
an entry in the syscon_list and then call of_syscon_register() a second
time.

Fix this by keeping the lock held until after of_syscon_register()
completes and adds the node to syscon_list. Convert the spinlock to a
mutex as many of the functions called in of_syscon_register() may sleep.

Fixes: bdb0066df96e ("mfd: syscon: Decouple syscon interface from platform devices")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/mfd/syscon.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 3e1d699ba934..72f20de9652d 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -27,7 +28,7 @@
 
 static struct platform_driver syscon_driver;
 
-static DEFINE_SPINLOCK(syscon_list_slock);
+static DEFINE_MUTEX(syscon_list_lock);
 static LIST_HEAD(syscon_list);
 
 struct syscon {
@@ -54,6 +55,8 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	struct resource res;
 	struct reset_control *reset;
 
+	WARN_ON(!mutex_is_locked(&syscon_list_lock));
+
 	struct syscon *syscon __free(kfree) = kzalloc(sizeof(*syscon), GFP_KERNEL);
 	if (!syscon)
 		return ERR_PTR(-ENOMEM);
@@ -146,9 +149,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	syscon->regmap = regmap;
 	syscon->np = np;
 
-	spin_lock(&syscon_list_slock);
 	list_add_tail(&syscon->list, &syscon_list);
-	spin_unlock(&syscon_list_slock);
 
 	return_ptr(syscon);
 
@@ -169,7 +170,7 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 {
 	struct syscon *entry, *syscon = NULL;
 
-	spin_lock(&syscon_list_slock);
+	mutex_lock(&syscon_list_lock);
 
 	list_for_each_entry(entry, &syscon_list, list)
 		if (entry->np == np) {
@@ -177,11 +178,11 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 			break;
 		}
 
-	spin_unlock(&syscon_list_slock);
-
 	if (!syscon)
 		syscon = of_syscon_register(np, check_res);
 
+	mutex_unlock(&syscon_list_lock);
+
 	if (IS_ERR(syscon))
 		return ERR_CAST(syscon);
 
@@ -212,7 +213,7 @@ int of_syscon_register_regmap(struct device_node *np, struct regmap *regmap)
 		return -ENOMEM;
 
 	/* check if syscon entry already exists */
-	spin_lock(&syscon_list_slock);
+	mutex_lock(&syscon_list_lock);
 
 	list_for_each_entry(entry, &syscon_list, list)
 		if (entry->np == np) {
@@ -225,12 +226,12 @@ int of_syscon_register_regmap(struct device_node *np, struct regmap *regmap)
 
 	/* register the regmap in syscon list */
 	list_add_tail(&syscon->list, &syscon_list);
-	spin_unlock(&syscon_list_slock);
+	mutex_unlock(&syscon_list_lock);
 
 	return 0;
 
 err_unlock:
-	spin_unlock(&syscon_list_slock);
+	mutex_unlock(&syscon_list_lock);
 	kfree(syscon);
 	return ret;
 }

-- 
2.45.2


