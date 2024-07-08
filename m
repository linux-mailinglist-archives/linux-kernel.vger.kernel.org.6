Return-Path: <linux-kernel+bounces-244027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB68929E25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22851F22124
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F3654278;
	Mon,  8 Jul 2024 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L/+akWgm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F851016
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426562; cv=none; b=ra84N5c7y+ImrhehR9LgW3Ez6dOrQ2UatVpw0/F28O1Yeg9FeOu9/R3yqAcVuRBmeyJaAsl9K+3iT6vUHSX1hxjO+eiap8mFeHYKwMJjE5oIJ8Iy56tDGaDG2rsJCeT59Pmle4tqZjAW5ITr16vCBoPjTNFWQt8MM3hjva8vi3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426562; c=relaxed/simple;
	bh=gY0fWvFWUXqLtyA1HjVChnA0YLYvq3PtPPHe0WsJdv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4XaQ6tQ4BhA5vUaMalgsWFPstMv0m1YiKyMQKcHFunI8czxbzCEEEwTVWepFZdk2BRquYaD4UbL5DcphdEk+GNPMA+fwfVloJ3G/APo8jkJg8QP9ET3HyCrPMjV6Qu4V7Ch8dbnbAmVKo9jR8+VPGUZDYAeEoyIruPJoj/xIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L/+akWgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03E4C116B1;
	Mon,  8 Jul 2024 08:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720426562;
	bh=gY0fWvFWUXqLtyA1HjVChnA0YLYvq3PtPPHe0WsJdv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/+akWgmhObg/uEvzvkbVCxVgk0NLqqEgjj8Njkr6d44oey0K0QQK6LzQS5OKoatS
	 ggbngCm3kJNHWwtDhrUo23tBddGgmmZ/bQjKvIisbp/PC9ap67sNG144I3XVP1XN50
	 r+CXo8ObE3GOffp+4+F16q1+U7vCNqxAZx4ZT+CE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 3/3] driver core: module: make module_[add|remove]_driver take a const *
Date: Mon,  8 Jul 2024 10:15:47 +0200
Message-ID: <2024070850-entering-grandson-205e@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024070844-volley-hatchling-c812@gregkh>
References: <2024070844-volley-hatchling-c812@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 59
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=gY0fWvFWUXqLtyA1HjVChnA0YLYvq3PtPPHe0WsJdv4=; b=owGbwMvMwCRo6H6F97bub03G02pJDGndC8xkrVJNnrq/vaQZ+/3IDss4V6HOrvDP1/PmL5YMy DikfWByRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzEeSrD/LI9inxZ9vmLShgi 1lg98Dz5sX/mcob5WdP3it9yFb8exZwiePyIc+ykO/mSAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The functions module_add_driver() and module_remove_driver() do not
modify the struct device_driver structure directly, so they are safe to
be marked as a constant pointer type.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h   | 4 ++--
 drivers/base/module.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0886f555d782..0b53593372d7 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -192,8 +192,8 @@ extern struct kset *devices_kset;
 void devices_kset_move_last(struct device *dev);
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
-int module_add_driver(struct module *mod, struct device_driver *drv);
-void module_remove_driver(struct device_driver *drv);
+int module_add_driver(struct module *mod, const struct device_driver *drv);
+void module_remove_driver(const struct device_driver *drv);
 #else
 static inline int module_add_driver(struct module *mod,
 				    struct device_driver *drv)
diff --git a/drivers/base/module.c b/drivers/base/module.c
index a1b55da07127..7af224e6914a 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -9,7 +9,7 @@
 #include <linux/string.h>
 #include "base.h"
 
-static char *make_driver_name(struct device_driver *drv)
+static char *make_driver_name(const struct device_driver *drv)
 {
 	char *driver_name;
 
@@ -30,7 +30,7 @@ static void module_create_drivers_dir(struct module_kobject *mk)
 	mutex_unlock(&drivers_dir_mutex);
 }
 
-int module_add_driver(struct module *mod, struct device_driver *drv)
+int module_add_driver(struct module *mod, const struct device_driver *drv)
 {
 	char *driver_name;
 	struct module_kobject *mk = NULL;
@@ -89,7 +89,7 @@ int module_add_driver(struct module *mod, struct device_driver *drv)
 	return ret;
 }
 
-void module_remove_driver(struct device_driver *drv)
+void module_remove_driver(const struct device_driver *drv)
 {
 	struct module_kobject *mk = NULL;
 	char *driver_name;
-- 
2.45.2


