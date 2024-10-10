Return-Path: <linux-kernel+bounces-360062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB14E999406
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1B81F2431B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F9B1E8832;
	Thu, 10 Oct 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Rxj/mubG"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9631E7C0A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593822; cv=none; b=FGfXOJmJA3xijOq2Cmheq4GlQeZKK25RX3V8nFVIvY4IOfxYfYdWsYztIyLmj6FMr53pp2YwQkiglvnlok4KJzym0+asv9Oa32SXjuc5gTQXKcrZ4hAAKThmSAvJi9FOppf/+Yv/mTo/433hMSvwW8CMzUPqqVCgNwyDBWLXH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593822; c=relaxed/simple;
	bh=sQ+SZVnBBRE3ImhqQsED15ZOeFkIa1z8kPdmYjw6BHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqo/Li6ar9k1iRAWCO8190i47aEJMZ4EzGkxx/s9/G5aQEOE2rDKED47rsAG2Iwl0i2fdgphHhbUZ0+2/GODTeqtMvH4qEx1U/J16IYtr+bK9wlZATLLFOqjKMczA2gDlTDucYxaUNBr5JOvgxWKtam5EEiwYrMEb2ut9nM7QSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Rxj/mubG; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=kM4m4C4qs2d8nTPdl5q9qTv/dlpUEKSAzIY4qhD1x9A=; b=Rxj/mubGuAWAygNk
	ojgBG/OjiCjjymkp9gOLWoQzNqriXW2tFVjOwjaur2ecztZ2b+P1WCRMVyLCWM5lW4D90tfewGMK5
	cucqIfZUXW5R11kkFIxi+GQZbm7eg9ACrhVtqHr/Tq7XT0GLFLb39FbkhwPsTxTyiShRN8kq0AGca
	9ogNrkDZpZuFgwXcA/2cXN4WZuTH0+fIeeehbu1SSa7KnBSPF7NrlRH6Jy4+fCtLfoo3JjsOdTPbu
	vfcG7BrhDTGwnIG4jfh/tALXo2JYqHqdKluN1q8JykNbQGiu+KOgmL0D3d6OE0WWJYfY7M8I7kAnC
	4e54KXw5i0P8lRGFXQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sz0DQ-00AMrs-1M;
	Thu, 10 Oct 2024 20:56:56 +0000
From: linux@treblig.org
To: jlbec@evilplan.org,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] configfs: Remove unused configfs_hash_and_remove
Date: Thu, 10 Oct 2024 21:56:55 +0100
Message-ID: <20241010205655.278385-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

configfs_hash_and_remove() has been unused since it was added in 2005
by commit
7063fbf22611 ("[PATCH] configfs: User-driven configuration filesystem")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/configfs/configfs_internal.h |  2 --
 fs/configfs/inode.c             | 25 -------------------------
 2 files changed, 27 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index e710a1782382..5c20e83315bc 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -73,8 +73,6 @@ extern int configfs_make_dirent(struct configfs_dirent *, struct dentry *,
 				void *, umode_t, int, struct configfs_fragment *);
 extern int configfs_dirent_is_ready(struct configfs_dirent *);
 
-extern void configfs_hash_and_remove(struct dentry * dir, const char * name);
-
 extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
 extern void configfs_drop_dentry(struct configfs_dirent *sd, struct dentry *parent);
 extern int configfs_setattr(struct mnt_idmap *idmap,
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index dcc22f593e43..1d2e3a5738d1 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -216,28 +216,3 @@ void configfs_drop_dentry(struct configfs_dirent * sd, struct dentry * parent)
 			spin_unlock(&dentry->d_lock);
 	}
 }
-
-void configfs_hash_and_remove(struct dentry * dir, const char * name)
-{
-	struct configfs_dirent * sd;
-	struct configfs_dirent * parent_sd = dir->d_fsdata;
-
-	if (d_really_is_negative(dir))
-		/* no inode means this hasn't been made visible yet */
-		return;
-
-	inode_lock(d_inode(dir));
-	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
-		if (!sd->s_element)
-			continue;
-		if (!strcmp(configfs_get_name(sd), name)) {
-			spin_lock(&configfs_dirent_lock);
-			list_del_init(&sd->s_sibling);
-			spin_unlock(&configfs_dirent_lock);
-			configfs_drop_dentry(sd, dir);
-			configfs_put(sd);
-			break;
-		}
-	}
-	inode_unlock(d_inode(dir));
-}
-- 
2.47.0


