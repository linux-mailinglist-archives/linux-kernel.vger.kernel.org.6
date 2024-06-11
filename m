Return-Path: <linux-kernel+bounces-209889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78D903C90
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F701F2312F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7E17BB2B;
	Tue, 11 Jun 2024 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yeOTu4Nw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB938DD1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110873; cv=none; b=NRMir1sImrFykafzmT8vzVi7Sv534P/G4YHfpGP52kxAquFbyaH6ZWbcGnVl96FGLLSikUkxk/EN0CQN5u4KXmm4RiRr27CDLTTLp13e/DDKpGr2bb7AOFELaiSH/intgeN00Ye5y28HmmHCYu7BNGbNNTcc1zBHk2n92i+Z/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110873; c=relaxed/simple;
	bh=sB0+sZLP/Y2Sqmo8oadg2kS/jbqmOBdH66Ld8QA5FGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNXk+eUptMk0Y6xLAwsQRGjsOmpOcPvd5BHjXAPQNwroyStHJrTNTKBKXXVJQfaf4U95YMWHPDS0PWIhJ1/Rm9tQTomJ6jEGiKJpTR5pDYYYaFD+lweLyFm9S7VGZgmdRGA5yJec3aybZB5ckQAlH/YQgqoxqDFiiwWSgVKbH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yeOTu4Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE75C2BD10;
	Tue, 11 Jun 2024 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718110872;
	bh=sB0+sZLP/Y2Sqmo8oadg2kS/jbqmOBdH66Ld8QA5FGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yeOTu4Nw5B/k9fiQpxL5S+CIpUCqo+iaPeqQO2fD0qZ+io7d92FuN7Z2IhPKrTH6K
	 +pHmQbFPf4wjeBaekkTHVdlyTRpClIok/A9JLY1TUmU4aIMzRYjKV9ouk/FihB/fld
	 coJT7ncjVwfxoWcyL2VUXPh9+2YMe8cOfTGkbX1s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/6] driver core: platform: fix ups for constant struct device_driver
Date: Tue, 11 Jun 2024 15:01:05 +0200
Message-ID: <20240611130103.3262749-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
References: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2060; i=gregkh@linuxfoundation.org; h=from:subject; bh=sB0+sZLP/Y2Sqmo8oadg2kS/jbqmOBdH66Ld8QA5FGA=; b=owGbwMvMwCRo6H6F97bub03G02pJDGkZXhO1G6bd2xfCfka0/omXHMeB0MCDEufsxEvbLDPMJ p2afaa7I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbiocKw4HrT3Y5lr2uP1a15 77pope6hi3vv32WY71lUuMprj+q5I0ZbOPscg0QU8ouKAQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Fix up a few places in the platform core code that can easily handle
struct device_driver being constant.  This is part of the work to make
all struct device_driver pointers be constant.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/platform.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index c8aa1be70526..a6884479f4ac 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1122,7 +1122,7 @@ static int platform_legacy_resume(struct device *dev)
 
 int platform_pm_suspend(struct device *dev)
 {
-	struct device_driver *drv = dev->driver;
+	const struct device_driver *drv = dev->driver;
 	int ret = 0;
 
 	if (!drv)
@@ -1140,7 +1140,7 @@ int platform_pm_suspend(struct device *dev)
 
 int platform_pm_resume(struct device *dev)
 {
-	struct device_driver *drv = dev->driver;
+	const struct device_driver *drv = dev->driver;
 	int ret = 0;
 
 	if (!drv)
@@ -1162,7 +1162,7 @@ int platform_pm_resume(struct device *dev)
 
 int platform_pm_freeze(struct device *dev)
 {
-	struct device_driver *drv = dev->driver;
+	const struct device_driver *drv = dev->driver;
 	int ret = 0;
 
 	if (!drv)
@@ -1180,7 +1180,7 @@ int platform_pm_freeze(struct device *dev)
 
 int platform_pm_thaw(struct device *dev)
 {
-	struct device_driver *drv = dev->driver;
+	const struct device_driver *drv = dev->driver;
 	int ret = 0;
 
 	if (!drv)
@@ -1198,7 +1198,7 @@ int platform_pm_thaw(struct device *dev)
 
 int platform_pm_poweroff(struct device *dev)
 {
-	struct device_driver *drv = dev->driver;
+	const struct device_driver *drv = dev->driver;
 	int ret = 0;
 
 	if (!drv)
@@ -1216,7 +1216,7 @@ int platform_pm_poweroff(struct device *dev)
 
 int platform_pm_restore(struct device *dev)
 {
-	struct device_driver *drv = dev->driver;
+	const struct device_driver *drv = dev->driver;
 	int ret = 0;
 
 	if (!drv)
-- 
2.45.2


