Return-Path: <linux-kernel+bounces-449757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29FE9F55BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034F11657D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38421F8918;
	Tue, 17 Dec 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rW5mzLpR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D2C1F869D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459118; cv=none; b=WNknncI2eJaX2DXLlNG32jkyeAkpm+knrVHNQDTkDRaFE16E3OzxZAcdvi+fwqDXU4w01CM61V0XqRdOXdPWPPk6s0tg32Ex550LRHn0ekcm5bigFSizqyOR4JjlHfdiSLBYptnP6gtv14NSxqDjRo3JOIrGNrd6bdywIa1I0Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459118; c=relaxed/simple;
	bh=CEymn1dapn9L+g1VujOTt+GizasEFssPjK9PHGiZzV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eftY2IWwqkKInrKBWzGowlX6lHBcxoQB3qfpare0hBNjCMBU1puKMFr9vKONCZwIruWKYgvxmNw3uNfwMASCzTPfci/Lnzs5CgKrMnrvgED0JjqFZ9bWHBRPMB4JtU4bRY9ayVmwlgwJs68wRWwz7mvW93vXuQPc3S5TBxypoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rW5mzLpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88018C4CED3;
	Tue, 17 Dec 2024 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459117;
	bh=CEymn1dapn9L+g1VujOTt+GizasEFssPjK9PHGiZzV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rW5mzLpRUZmMPMfwrPOLSvNWDY0Y8MLCq63tgBR5e1U5vZ+ooFeHLat8qsB87q37v
	 +vWDOTSiBkV1hvsM+Nq+Q768NomnFyiVhKpsruu0syZ2QdbqYeq7YhZq/10Mg6RPrJ
	 0N/YRxCrVtbGtSFOL1/bwVJAy5u/Mv5i05KViZCEeZC3UP9DJWFFhwdarFs7XLZoM1
	 kS6GDIyjknB1EEZMOW2pGQLGqCJ3EPIZ+bI+8o9pe7M+S80cfSbeHarlAERpWVgDvG
	 A2m5s0LB9VjgUtBnn4jZzCM8pWD8dKJD2xTKXy1d05YA9wb2ly9PhEH2QU7r/AkmF5
	 K84vafo7doEBg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 17 Dec 2024 12:11:40 -0600
Subject: [PATCH v2 1/3] mfd: syscon: Fix race in device_node_get_regmap()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-syscon-fixes-v2-1-4f56d750541d@kernel.org>
References: <20241217-syscon-fixes-v2-0-4f56d750541d@kernel.org>
In-Reply-To: <20241217-syscon-fixes-v2-0-4f56d750541d@kernel.org>
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Pankaj Dubey <pankaj.dubey@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 John Madieu <john.madieu.xa@bp.renesas.com>, 
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
mutex as many of the functions called in of_syscon_register() such as
kzalloc() and of_clk_get() may sleep.

Fixes: bdb0066df96e ("mfd: syscon: Decouple syscon interface from platform devices")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/mfd/syscon.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 3e1d699ba9340f8135dfdeae6feca474980cc48d..72f20de9652da2d7bad12e4bc2c43ac0c9a97f76 100644
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


