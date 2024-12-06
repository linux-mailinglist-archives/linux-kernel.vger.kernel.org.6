Return-Path: <linux-kernel+bounces-435465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED69E7821
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E913F282C51
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D995E1D54E9;
	Fri,  6 Dec 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjXcnDMq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39324198837;
	Fri,  6 Dec 2024 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510010; cv=none; b=kzIw0ekQz2qQQD8DjLpEvmazk4b9mbYbOvt747c/nVG5ryS8kGKQF2QpuyHqCxf0fKctwmHkKGFL+FjjfCCmF8AtSvlQnp81NLJYJyDx9u+qTLVaQuzraqF8Gtf49ZJ8ClOrnVFycOritt6u4zT/xvWvPdtyRfXIYPLMubholQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510010; c=relaxed/simple;
	bh=Q86J75Wlse8wJ2ag9BsAM2NfLtB+qhOPLFY/afXDp1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYSOfUW/GPLy9/xOX4e/n8/0efm20m1oKMNdqNrjPdrlCSjM6VUS0nFNGWXWhROUA9b+ukciEXEOOrFbFHAkVhkylVzIhWxRNh4zh8DHDml1/g5Nnh3TNB86MqlHjhj06d4efrJ2WUMSCOVrWJ8/DcDNt9mBYzFaCTShNn68q4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjXcnDMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EB5C4CED1;
	Fri,  6 Dec 2024 18:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733510009;
	bh=Q86J75Wlse8wJ2ag9BsAM2NfLtB+qhOPLFY/afXDp1g=;
	h=From:To:Cc:Subject:Date:From;
	b=DjXcnDMqvMdaL7Xb8arLi3mOmq/w2e60TiTSQ7qYsBmps7Iv/GKe5BREyNPFOnFES
	 RBSfgjEHSPKqzVaBhvH/WLnHNouPXNBH7Ya8sKhMzK7IBzm6qkNXXRcprUebZ9n5Cj
	 XyKbzOfyehZ/QAD1B+xkF3LWx2097Pne3jA4vz66SzGd8nutUsjfIkj7ivxQu8hm6q
	 CuTbR660fGvOIU1VmiOR+yqEH/4jxmspBVfEp0q+wU8I07VdlndtZ2stsb8c7VkNNR
	 bz6JgS71ABpfa4LkP22eHKTmehgO1h9Glovirbj2E6zwMt3EyB8HKmWQ7aDxl/o1r0
	 tVabPjpxAl2uQ==
From: Mario Limonciello <superm1@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org (open list:THUNDERBOLT DRIVER),
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Richard Hughes <hughsient@gmail.com>
Subject: [PATCH] thunderbolt: Don't display retimers unless nvm was initialized
Date: Fri,  6 Dec 2024 12:33:18 -0600
Message-ID: <20241206183318.1701180-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The read will never succeed if nvm wasn't initialized.

Reported-by: Richard Hughes <hughsient@gmail.com>
Closes: https://github.com/fwupd/fwupd/issues/8200
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/retimer.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 89d2919d0193e..7be435aee7217 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -321,9 +321,7 @@ static ssize_t nvm_version_show(struct device *dev,
 	if (!mutex_trylock(&rt->tb->lock))
 		return restart_syscall();
 
-	if (!rt->nvm)
-		ret = -EAGAIN;
-	else if (rt->no_nvm_upgrade)
+	if (rt->no_nvm_upgrade)
 		ret = -EOPNOTSUPP;
 	else
 		ret = sysfs_emit(buf, "%x.%x\n", rt->nvm->major, rt->nvm->minor);
@@ -342,6 +340,18 @@ static ssize_t vendor_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(vendor);
 
+static umode_t retimer_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tb_retimer *rt = tb_to_retimer(dev);
+
+	if (!rt->nvm)
+		return 0;
+	return attr->mode;
+
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


