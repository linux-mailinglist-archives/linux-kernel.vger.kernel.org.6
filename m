Return-Path: <linux-kernel+bounces-513988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465AA35110
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A884316DC79
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B857E269896;
	Thu, 13 Feb 2025 22:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PFogO3uN"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85EB266B74
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484893; cv=none; b=HOke4K4GIud1MptwTRcPuMLpv2jeqWdKV5NNlBFJyhkyAwSCNeVcZlW61XTt9CMI5rrIRSPdS3GcNh9jnVlZHu9qufGNbNPMkIKb6348ZaqvzdMRXnhCPSHQsMDejRMFDT1m1r5nbp2S3yRQjcvS4xX5ThE3VE2NC7L20NzKENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484893; c=relaxed/simple;
	bh=wSReGM6hECD9e8HYpkKhPacbvACSWzTpzeys+4D+bRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FCkKw0CJro1F398pH52dqhUf0GDe7xDSEVgTQMVCf5R3Odx6qOP60v++7m+kZN+0bX8wSNq/KmRWvSWj/o6dseCAgEHP1NMPbfgVUA0Tf6TT/n4/lnBVvWD7d1yD8k6Rw058JQ5XgV1mjpToCcj0kXqthy814ZrlwckIQjE2BRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PFogO3uN; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739484887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pguDVgZxVJ4xAengdkHS4cwG5zmoEvQiCfVy56YmJT8=;
	b=PFogO3uNE1Q0aPxFw5OGQR6EwwC8rOWmKGBOA91BSqZqo3VS3EM796VNSoTG2eOL/tVvMS
	2KYDovBHJKaEH4cEaGQQ7sb0dU1sqYHzgXgA6r2ysX9KkD4WJLEfayrW02JzSF5bnlkCx2
	nL9Gzn2vf/epZANsDtt7UTJsVVrl0UU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RESEND PATCH v2] params: Annotate struct module_param_attrs with __counted_by()
Date: Thu, 13 Feb 2025 23:13:52 +0100
Message-ID: <20250213221352.2625-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by compiler attribute to the flexible array member
attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Increment num before adding a new param_attribute to the attrs array and
adjust the array index accordingly. Increment num immediately after the
first reallocation such that the reallocation for the NULL terminator
only needs to add 1 (instead of 2) to mk->mp->num.

Use struct_size() instead of manually calculating the size for the
reallocation.

Use krealloc_array() for the additional NULL terminator.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use krealloc_array() as suggested by Andy Shevchenko
- Link to v1: https://lore.kernel.org/r/20240823123300.37574-1-thorsten.blum@toblux.com/

Resending again after Luis mentioned that co-maintainers are rotated
every 6 months. Latest thread for reference: https://lore.kernel.org/r/20250114214956.915982-2-thorsten.blum@linux.dev/
---
 kernel/params.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 0074d29c9b80..2509f216c9f3 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -551,7 +551,7 @@ struct module_param_attrs
 {
 	unsigned int num;
 	struct attribute_group grp;
-	struct param_attribute attrs[];
+	struct param_attribute attrs[] __counted_by(num);
 };
 
 #ifdef CONFIG_SYSFS
@@ -651,35 +651,32 @@ static __modinit int add_sysfs_param(struct module_kobject *mk,
 	}
 
 	/* Enlarge allocations. */
-	new_mp = krealloc(mk->mp,
-			  sizeof(*mk->mp) +
-			  sizeof(mk->mp->attrs[0]) * (mk->mp->num + 1),
+	new_mp = krealloc(mk->mp, struct_size(mk->mp, attrs, mk->mp->num + 1),
 			  GFP_KERNEL);
 	if (!new_mp)
 		return -ENOMEM;
 	mk->mp = new_mp;
+	mk->mp->num++;
 
 	/* Extra pointer for NULL terminator */
-	new_attrs = krealloc(mk->mp->grp.attrs,
-			     sizeof(mk->mp->grp.attrs[0]) * (mk->mp->num + 2),
-			     GFP_KERNEL);
+	new_attrs = krealloc_array(mk->mp->grp.attrs, mk->mp->num + 1,
+				   sizeof(mk->mp->grp.attrs[0]), GFP_KERNEL);
 	if (!new_attrs)
 		return -ENOMEM;
 	mk->mp->grp.attrs = new_attrs;
 
 	/* Tack new one on the end. */
-	memset(&mk->mp->attrs[mk->mp->num], 0, sizeof(mk->mp->attrs[0]));
-	sysfs_attr_init(&mk->mp->attrs[mk->mp->num].mattr.attr);
-	mk->mp->attrs[mk->mp->num].param = kp;
-	mk->mp->attrs[mk->mp->num].mattr.show = param_attr_show;
+	memset(&mk->mp->attrs[mk->mp->num - 1], 0, sizeof(mk->mp->attrs[0]));
+	sysfs_attr_init(&mk->mp->attrs[mk->mp->num - 1].mattr.attr);
+	mk->mp->attrs[mk->mp->num - 1].param = kp;
+	mk->mp->attrs[mk->mp->num - 1].mattr.show = param_attr_show;
 	/* Do not allow runtime DAC changes to make param writable. */
 	if ((kp->perm & (S_IWUSR | S_IWGRP | S_IWOTH)) != 0)
-		mk->mp->attrs[mk->mp->num].mattr.store = param_attr_store;
+		mk->mp->attrs[mk->mp->num - 1].mattr.store = param_attr_store;
 	else
-		mk->mp->attrs[mk->mp->num].mattr.store = NULL;
-	mk->mp->attrs[mk->mp->num].mattr.attr.name = (char *)name;
-	mk->mp->attrs[mk->mp->num].mattr.attr.mode = kp->perm;
-	mk->mp->num++;
+		mk->mp->attrs[mk->mp->num - 1].mattr.store = NULL;
+	mk->mp->attrs[mk->mp->num - 1].mattr.attr.name = (char *)name;
+	mk->mp->attrs[mk->mp->num - 1].mattr.attr.mode = kp->perm;
 
 	/* Fix up all the pointers, since krealloc can move us */
 	for (i = 0; i < mk->mp->num; i++)
-- 
2.48.1


