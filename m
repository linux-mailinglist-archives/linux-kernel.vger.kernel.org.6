Return-Path: <linux-kernel+bounces-438009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A14AF9E9B92
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C871667C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2050146A63;
	Mon,  9 Dec 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFqSzKDA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BE142900;
	Mon,  9 Dec 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761556; cv=none; b=sMXVPU6yKe3D9BcCuP1Cr8UxHm80yV3HOwPS1gRoedKYyXm36eQI1ycdfu7ToKHaGn6tejGf/V2An9zn5mPrTltVhq26rljGxmLl/IfbvCd/kqzfkOraQHPYXw+2ZMXQEZU8GA+imV6/SGDElqMRPRKTY2DKWnk+DB37I8O2So4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761556; c=relaxed/simple;
	bh=D2x5fHTQCDa81i7TcZDxFnrvfS3HasdzbgffyKZH0p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUa4wUPsSv+35Da5Sv31tN+xA5gTSf+VEA4mTnEF3b81UE2cOAB/ncZD3674XWma3T8vjoOuvgbyaMXrHpbyp6K3W8814lpf/rYuTHCtDAVXgh1wuS7UCECedM3z+3zdHHySKya4tEABf10pnTuMKejbk98FPVBfNnHjMvyML78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFqSzKDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0E2C4CED1;
	Mon,  9 Dec 2024 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733761555;
	bh=D2x5fHTQCDa81i7TcZDxFnrvfS3HasdzbgffyKZH0p0=;
	h=From:To:Cc:Subject:Date:From;
	b=iFqSzKDA2XWCSVu2JbKqlgqbcWVU4HbdPd6O3vVVDtjylqbfFg+Jfr9trhpTlJJIy
	 8HnznYbDt9cAIFoFs+IIbhbmpilpB5s2O9+ii6jp7hqDNDnAw17FZdaP+fwbYMWbd5
	 JR/vZJQLzRnU9C28mORXkY1mouv4gAAjsRF6R4rrcnDDQpa1rgnO9fTTccrC+/rONM
	 C1Gb7qYWR1XLHvqcI7LIkCbjh6hflfVhxnj/564iWjRZGUU7mrSURwXAQB6Cr6Tc1f
	 yPU4/4GUNkZckHneGHvBMaqfU7dRvmQ1NJDjieusb76/w2aY+bmmyEaVxC9IfBmeJ9
	 Ou/abrBTbXwVQ==
From: Mario Limonciello <superm1@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org (open list:THUNDERBOLT DRIVER),
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Richard Hughes <hughsient@gmail.com>
Subject: [PATCH v2] thunderbolt: Don't display nvm_version unless upgrade supported
Date: Mon,  9 Dec 2024 10:25:51 -0600
Message-ID: <20241209162551.888749-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The read will never succeed if nvm wasn't initialized due to an
unknown format.

Add a new callback for visibility to only show when supported.

Fixes: aef9c693e7e5 ("thunderbolt: Move vendor specific NVM handling into nvm.c")
Reported-by: Richard Hughes <hughsient@gmail.com>
Closes: https://github.com/fwupd/fwupd/issues/8200
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Use no_nvm_upgrade instead of changing logic
 * Adjust commit message
---
 drivers/thunderbolt/retimer.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 89d2919d0193e..eeb64433ebbca 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -103,6 +103,7 @@ static int tb_retimer_nvm_add(struct tb_retimer *rt)
 
 err_nvm:
 	dev_dbg(&rt->dev, "NVM upgrade disabled\n");
+	rt->no_nvm_upgrade = true;
 	if (!IS_ERR(nvm))
 		tb_nvm_free(nvm);
 
@@ -182,8 +183,6 @@ static ssize_t nvm_authenticate_show(struct device *dev,
 
 	if (!rt->nvm)
 		ret = -EAGAIN;
-	else if (rt->no_nvm_upgrade)
-		ret = -EOPNOTSUPP;
 	else
 		ret = sysfs_emit(buf, "%#x\n", rt->auth_status);
 
@@ -323,8 +322,6 @@ static ssize_t nvm_version_show(struct device *dev,
 
 	if (!rt->nvm)
 		ret = -EAGAIN;
-	else if (rt->no_nvm_upgrade)
-		ret = -EOPNOTSUPP;
 	else
 		ret = sysfs_emit(buf, "%x.%x\n", rt->nvm->major, rt->nvm->minor);
 
@@ -342,6 +339,19 @@ static ssize_t vendor_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(vendor);
 
+static umode_t retimer_is_visible(struct kobject *kobj, struct attribute *attr,
+				  int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tb_retimer *rt = tb_to_retimer(dev);
+
+	if (attr == &dev_attr_nvm_authenticate.attr ||
+	    attr == &dev_attr_nvm_version.attr)
+		return rt->no_nvm_upgrade ? 0 : attr->mode;
+
+	return attr->mode;
+}
+
 static struct attribute *retimer_attrs[] = {
 	&dev_attr_device.attr,
 	&dev_attr_nvm_authenticate.attr,
@@ -351,6 +361,7 @@ static struct attribute *retimer_attrs[] = {
 };
 
 static const struct attribute_group retimer_group = {
+	.is_visible = retimer_is_visible,
 	.attrs = retimer_attrs,
 };
 
-- 
2.43.0


