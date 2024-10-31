Return-Path: <linux-kernel+bounces-389893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807FE9B7299
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41918285D25
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8750912FF9C;
	Thu, 31 Oct 2024 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="l65h0Xuk"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9512C473
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342668; cv=none; b=pfz3gNQYvRjYoAVjz0mzdesE9EhCAqRrp0wNq6llEtzb+ZKgOs8nswfTBPCRcdG5KckLfiQJnMwB8MW/xyHpd0RgMBNf3D4by3Njqg9htl9gudtvO5/omGhBMX5H3S71euFUgKOwBa3+Srl13GNIlpVAdHk5RDfHHfC0RI6agSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342668; c=relaxed/simple;
	bh=iCkq/n0ScNs19XGEBHP6SQ4H+TMRU4fkw8iLrhzrW/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bVlMx2SVjY/r2kEnqNBseEM1yWUDjHq79NZD3/o2/UEDBGdKGPuEWi0lpVCUzuFbMNxqXfmeAy5fsT5NzDjLd/G8+BC/DujhFfMOCFrFkrIDnSM8ZBcT+fzL9QHyWWDaEUhQdp632w056+0/Z4jukHCDHBVDZ/aGjs9fpAIrsU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=l65h0Xuk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730342662;
	bh=iCkq/n0ScNs19XGEBHP6SQ4H+TMRU4fkw8iLrhzrW/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l65h0XukiXN4BdEFyncTp/UBZ/U+9z2UHbM7gGX5BRcepfcPGG3g1bjTahnAUznic
	 8mEylLJBmZq0meuuE8fnMZ1FFJ6KKZwSoRC8RI1AwG2RqARi+lAt9htYpxhcRUrYgJ
	 rtrgLQ+9pyfwJASs6Z7VnrabXJn9ic23Mzlwgeyg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 31 Oct 2024 02:43:50 +0000
Subject: [PATCH RFC 01/10] sysfs: explicitly pass size to
 sysfs_add_bin_file_mode_ns()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-sysfs-const-bin_attr-v1-1-2281afa7f055@weissschuh.net>
References: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
In-Reply-To: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730342657; l=3118;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iCkq/n0ScNs19XGEBHP6SQ4H+TMRU4fkw8iLrhzrW/Q=;
 b=8H9UXNcwMtfvH+tc1LRO3oWJXPSganB+Ds3czbDy342RiLa9+en5+xsI7j/4TFrUP1CsXi9/A
 PqXxTTG2hkSAEv9yr5X59lCoVpcfZm5RM1rFjc0VgO4YYnApqsTSARS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Upcoming changes to the sysfs core require the size of the created file
to be overridable by the caller.
Add a parameter to enable this.
For now keep using attr->size in all cases.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/sysfs/file.c  | 8 ++++----
 fs/sysfs/group.c | 3 ++-
 fs/sysfs/sysfs.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d1995e2d6c943a644ff9f34cf2488864d57daf81..6d39696b43069010b0ad0bdaadcf9002cb70c92c 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -315,7 +315,7 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 }
 
 int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
-		const struct bin_attribute *battr, umode_t mode,
+		const struct bin_attribute *battr, umode_t mode, size_t size,
 		kuid_t uid, kgid_t gid, const void *ns)
 {
 	const struct attribute *attr = &battr->attr;
@@ -340,7 +340,7 @@ int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
 #endif
 
 	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
-				  battr->size, ops, (void *)attr, ns, key);
+				  size, ops, (void *)attr, ns, key);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, attr->name);
@@ -580,8 +580,8 @@ int sysfs_create_bin_file(struct kobject *kobj,
 		return -EINVAL;
 
 	kobject_get_ownership(kobj, &uid, &gid);
-	return sysfs_add_bin_file_mode_ns(kobj->sd, attr, attr->attr.mode, uid,
-					   gid, NULL);
+	return sysfs_add_bin_file_mode_ns(kobj->sd, attr, attr->attr.mode,
+					  attr->size, uid, gid, NULL);
 }
 EXPORT_SYMBOL_GPL(sysfs_create_bin_file);
 
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index d22ad67a0f3291f4702f494939528d5d13c31fae..45b2e92941da1f49dcc71af3781317c61480c956 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -87,6 +87,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 	if (grp->bin_attrs) {
 		for (i = 0, bin_attr = grp->bin_attrs; *bin_attr; i++, bin_attr++) {
 			umode_t mode = (*bin_attr)->attr.mode;
+			size_t size = (*bin_attr)->size;
 
 			if (update)
 				kernfs_remove_by_name(parent,
@@ -104,7 +105,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 
 			mode &= SYSFS_PREALLOC | 0664;
 			error = sysfs_add_bin_file_mode_ns(parent, *bin_attr,
-							   mode, uid, gid,
+							   mode, size, uid, gid,
 							   NULL);
 			if (error)
 				break;
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index 3f28c9af57562f61a00a47935579f0939cbfd4dc..8e012f25e1c06e802c3138cc2715b46c1f67fa48 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -31,7 +31,7 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 		const struct attribute *attr, umode_t amode, kuid_t uid,
 		kgid_t gid, const void *ns);
 int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
-		const struct bin_attribute *battr, umode_t mode,
+		const struct bin_attribute *battr, umode_t mode, size_t size,
 		kuid_t uid, kgid_t gid, const void *ns);
 
 /*

-- 
2.47.0


