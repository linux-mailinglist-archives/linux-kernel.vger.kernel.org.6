Return-Path: <linux-kernel+bounces-209891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866CB903C96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D171C2392C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3527017D343;
	Tue, 11 Jun 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QzPahklF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23917CA1C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110880; cv=none; b=rleYi5PSXSkTWl52TSW55Me/H4yifvZs4iZIemAGUwwnPbT9nzB7yH+AscqM8zodlCkDDt2j8wp6coyJUOtZyZfrkm4doztxE9Q94ztA7QQypAsJViIgWLIEWYtoxuX7G8LvcpanwUvX/wpTCiO8IrICyKyFEntYBWEUZKMwVxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110880; c=relaxed/simple;
	bh=FU/6iPiDrX2Ki4l7e9j9OyGkg+UQtIgHZ5MD4/NbJKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBLDq+YV2r/NT4ry5KyBGX9NbxosP9vAF/gyRVWPCXwRX3TI4EaeXN/36YLOJ3AwgmPVODIJxWPBae7Uhj0UtEmXWmNz6w8C9hjwewD85YStEFzEzM03uFPyRd5C0rDAOGOIEvTvTiclgP2ZKivntdBheHpezeso32/R2/3Hrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QzPahklF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA6BC3277B;
	Tue, 11 Jun 2024 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718110880;
	bh=FU/6iPiDrX2Ki4l7e9j9OyGkg+UQtIgHZ5MD4/NbJKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzPahklFBMInwUg8SOxZYVzG3DM53urnMtWv6DkOPGTie+xne1Q1/gpeBh+ZtshsF
	 s00MYP7KNP+crR9RvD9nM4TROgVlZutGt9K3gmNbL0V3naLfs5UAECTiBN1EU8VurN
	 nO/Xh0HKdM/lKkupXbJ3utgSvwH6hOHPinTRWBAM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 3/6] driver core: driver: mark driver_add/remove_groups constant
Date: Tue, 11 Jun 2024 15:01:06 +0200
Message-ID: <20240611130103.3262749-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
References: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=gregkh@linuxfoundation.org; h=from:subject; bh=FU/6iPiDrX2Ki4l7e9j9OyGkg+UQtIgHZ5MD4/NbJKU=; b=kA0DAAIRMUfUDdst+ykByyZiAGZoSpKhOael1iKxPJ05oFvNqdwkNPEh56kminJbjUeYkpziX IhdBAARAgAdFiEE9LYMxb94wiFKMT3LMUfUDdst+ykFAmZoSpIACgkQMUfUDdst+ykfzACfQwaC DsDxH3dHcU1SkMS8Gj/zyTsAn3FoIF3Hayqk6RDXxFMpgFJxrAfG
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

driver_add_groups() and driver_remove_groups should take a constant
pointer as the structure is not modified, so make the change.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h   | 4 ++--
 drivers/base/driver.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index db4f910e8e36..cba8307908c7 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -175,8 +175,8 @@ static inline void dev_sync_state(struct device *dev)
 		dev->driver->sync_state(dev);
 }
 
-int driver_add_groups(struct device_driver *drv, const struct attribute_group **groups);
-void driver_remove_groups(struct device_driver *drv, const struct attribute_group **groups);
+int driver_add_groups(const struct device_driver *drv, const struct attribute_group **groups);
+void driver_remove_groups(const struct device_driver *drv, const struct attribute_group **groups);
 void device_driver_detach(struct device *dev);
 
 int devres_release_all(struct device *dev);
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index c8436c26ed6a..85b4c00df078 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -199,13 +199,13 @@ void driver_remove_file(struct device_driver *drv,
 }
 EXPORT_SYMBOL_GPL(driver_remove_file);
 
-int driver_add_groups(struct device_driver *drv,
+int driver_add_groups(const struct device_driver *drv,
 		      const struct attribute_group **groups)
 {
 	return sysfs_create_groups(&drv->p->kobj, groups);
 }
 
-void driver_remove_groups(struct device_driver *drv,
+void driver_remove_groups(const struct device_driver *drv,
 			  const struct attribute_group **groups)
 {
 	sysfs_remove_groups(&drv->p->kobj, groups);
-- 
2.45.2


