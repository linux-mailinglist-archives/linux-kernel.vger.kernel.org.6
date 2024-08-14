Return-Path: <linux-kernel+bounces-286384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE98951A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7F11F22D46
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C933E1AED54;
	Wed, 14 Aug 2024 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="anhspGiT"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E01A1B86F0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635701; cv=none; b=g5KxdvSbzoGNCKbyvWBTwP8W8QDPfzgMDDp+QvjG7mATpfQmJrz5xVP8ynyLHfGWGdPVCq6j7PLqaZoqg5jUKZ62UramvyV8T+kNE5D/ieypXMOK2tSZPGEyahXbErT1GNt/mRE5vlm5/qTQfpTBGoUqGYF3Wzq2m3cy8+RjnyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635701; c=relaxed/simple;
	bh=4adc61tKzjK2fTdo7B9pTquQAHQKVd/XEnUnW9CoK7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DoPmn0D5PB1O7Ubzih6Ng3KSCqv8DzUUCsO/TqxNt4KUOSf4mEq1xaOn2YowXOWGm0jzhnmFSOYSOG6m3gOKJ4xTEqCws38LqIkXg965M9ZrOJ7QO2KyF4GpUO59f2O26RzjQYylnBmQ+WBlAN66glxSzGUr9UJPYdFrjdU4AD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=anhspGiT; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DF612402E8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723635697;
	bh=ftHOv+os2MH3Qk9OKnsGMHrGZxHBoFg3umKFJ4e1joU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=anhspGiTCGzdMTo/vaun3DzQpCpPvdq4ZQddlSqroyh76F4yoPsaYky8lxSLhbmld
	 DdHcqdvCtjO9MXtKtJzM1IwgH0CIqYhGY/UwxTet1o2JlIldVZ3hKrbawwEydrAJID
	 N49fb4BLpGxk5zpQkq4L16/mknLgAJVhV8ljenGEhu9c3K4xQTRi6O0Uzt9TIzLTqZ
	 t8kjor2PCbyDyE5J8MEnpbpdRAL1NWgQFNIWplPfCU0qFqo3KHzUuMBOPpBQowJ8Uc
	 RXFE7slJiWSt0YVvH5Vyb0plyXuDs/f1JX6030HjMrqL8S7EBpcDmJyKJsZGGv6qpv
	 MTWd3fGmz4BaQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7aa26f342cso498671466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635697; x=1724240497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftHOv+os2MH3Qk9OKnsGMHrGZxHBoFg3umKFJ4e1joU=;
        b=uKPtCn+IetVfi6ineNl9c4M03wpSvwIXNUmixS4I7JoAUieUOml4Cwrek3R5HlQBiG
         SbxnOj1fDUYlw/JLuOn+GDqqveP2BJulbdmmSEbsPPFPCYbWZMQT9I3HhuRydhMU5bOd
         Gthap/nCORqatQmpe7UqhA0FTTA/5vKv1ceN4/FfmvQ6Yqo7niZBSp/rkC1MHd9KczVs
         CFZkW/q4zUssxqRj9xI9wVFZv8qWlV8FCbIgebJcnO1v2bRi5HVCSCrcy8LxFTxQa8ll
         QEYu7IS6B5/znVs3G5ViB9upAOBQSNw0XAEetdHDK+6fy2ZBqKxR6CAVONc51jFPLvEL
         kJXw==
X-Forwarded-Encrypted: i=1; AJvYcCX8zZgFE1XMkc570r3HGU31NBq0TVxT97mLyfoyxnClawjdTas2mr34GQzy3iNZUasxbZc7f+aYqbq1n07KAn9TULpvJYrSV7TUuq+J
X-Gm-Message-State: AOJu0YzT7kSNrX1jUih5G+CSNV+8Wgs3wo29LYfGa0WS0tJOHknCRT5/
	Gh09fn31XLOZxZ/pK72YLRToc9qS8sv5WqeGNAIYz/bVrD+RQW77dzAS7SmcydSh5Ne+eK3rI8C
	89NJ+K3mA15P/jOEu5A9BAG6gFYeJXLxEg4+FqafyzK7v32RnZQgJDu8FeSVhOFECs7hNbeX+2M
	VEqA==
X-Received: by 2002:a17:907:60d6:b0:a7d:a178:cd35 with SMTP id a640c23a62f3a-a83670bd5b2mr177717866b.64.1723635697361;
        Wed, 14 Aug 2024 04:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmjKqsGrx0ul0wb1XIoGECqCVrDs1V6uhHyqPC1//LdYgqMr4vyNwmguX/RN/gAEhqphkSRw==
X-Received: by 2002:a17:907:60d6:b0:a7d:a178:cd35 with SMTP id a640c23a62f3a-a83670bd5b2mr177715066b.64.1723635696887;
        Wed, 14 Aug 2024 04:41:36 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa782csm162586166b.60.2024.08.14.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:41:36 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] fs/fuse: drop idmap argument from __fuse_get_acl
Date: Wed, 14 Aug 2024 13:40:31 +0200
Message-Id: <20240814114034.113953-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to have idmap in the __fuse_get_acl as we don't
have any use for it.

In the current POSIX ACL implementation, idmapped mounts are
taken into account on the userspace/kernel border
(see vfs_set_acl_idmapped_mnt() and vfs_posix_acl_to_xattr()).

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/fuse/acl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 04cfd8fee992..897d813c5e92 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -12,7 +12,6 @@
 #include <linux/posix_acl_xattr.h>
 
 static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
-					struct mnt_idmap *idmap,
 					struct inode *inode, int type, bool rcu)
 {
 	int size;
@@ -74,7 +73,7 @@ struct posix_acl *fuse_get_acl(struct mnt_idmap *idmap,
 	if (fuse_no_acl(fc, inode))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return __fuse_get_acl(fc, idmap, inode, type, false);
+	return __fuse_get_acl(fc, inode, type, false);
 }
 
 struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool rcu)
@@ -90,8 +89,7 @@ struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool rcu)
 	 */
 	if (!fc->posix_acl)
 		return NULL;
-
-	return __fuse_get_acl(fc, &nop_mnt_idmap, inode, type, rcu);
+	return __fuse_get_acl(fc,  inode, type, rcu);
 }
 
 int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
-- 
2.34.1


