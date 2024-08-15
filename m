Return-Path: <linux-kernel+bounces-287745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B69952C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB59282625
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F069920FAAD;
	Thu, 15 Aug 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UIYCB4+z"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01720FA9E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713909; cv=none; b=LwLt321+Uh/r25dSe5BmAms+kBvLogHwIGXCBorIUnJXo3UMSpzvFzuPTszg8ruq7UeMlKgatitY8yUt8n6UbR4kF2E1aurf7wrqRgZxoQ72EBi5bqbJW5H+7od0xGt1xyfxKS4WgTICKFcd8GAdfvfrq9GDgbHDXaBuJtCLnS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713909; c=relaxed/simple;
	bh=4adc61tKzjK2fTdo7B9pTquQAHQKVd/XEnUnW9CoK7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rMPDENPrrGvUQ2E3iZ+hk2cZKVWE5qUL5o8dj71CT4YzwVC896lf1cI9YMbeCwBl5ZCkpuvguLwuu3qMMgokF2SkQV0wZJdY8+vrZW0W1ZzisfjNxjF4lPzy/wuE7K5cdbM9AaTmGpyFut4O6GNjqudpVXSl5jSWgMRKJIS9Ftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UIYCB4+z; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A81BE3F1F4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713904;
	bh=ftHOv+os2MH3Qk9OKnsGMHrGZxHBoFg3umKFJ4e1joU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=UIYCB4+z5EbOWyrXTzJdInv1JeaqJIpamaPIE3EVfbPSGfDqPQKuNKPAkmpxn/lmw
	 nXabgONUnyHho9shbaI1ckjznDFKQIejPGQn+985282MPtRumZEYs5FK4TYRFRBvn6
	 29FIVlWJ9cMJzh7iT+VWmXzA9Ukkl4YNecpD4TKrGaDbJq1z9bnZtwU8FePf0gRoKa
	 P++0uE7BwnQ/ZlaNMDTP/8rwGv0CU7s3tOtD8CSJN8MV3UKEM/al2c+g6CDliCQNAH
	 7nNemvLUYwdXjJl47u/07H2X2VC4IEkalZvJZvFIKjBlHi8zttjvKQULUWOxb6+S3D
	 XBjh9xHYDxHsQ==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52efce218feso776964e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713902; x=1724318702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftHOv+os2MH3Qk9OKnsGMHrGZxHBoFg3umKFJ4e1joU=;
        b=aSDGjLL+oUtkc2/dyl/1aqCcLcauL+nsQgASktVsIcGk4MLYOFAf9g/1S/DiZg6+Fg
         snq+Uf16ZoOxPBu5+KdzDpG0W9hFpFqtdR6SXTEf7Lc9drpwg4UXHSHN6veaVHYzX6+s
         T3UaYXWs8mSHoeY8u4oDcjK6SDibfwZohSHEgrxuy+XUHvHgNBBeQWWDByLW8TB773h8
         kSXxenW5CNxoqw1ynCUjQP8ulNG/WkdFXPMcuUWjkMjzW0J8g+ppm7IYfE/YnF39ruyJ
         DX1dqrm5amVfwuU7RK/vsy3rr3Xg51zTQ11sO2YSmrFz9TES9cYnnus4oqznbFVVf15O
         XEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp3n/FkEMcJQ3F4OFfohYGKJxhOjUU/q1l7ipq2nZdAo8RRDLSmjuOi+bL9YcCojUyuUmW//z8Xz+dIqt9+L9aYICcT+gq/N/gEEj6
X-Gm-Message-State: AOJu0Yy5Pp9aMH4bMh1ce1IPSOF2bbsFjdXM6Q+1CKrFgwvNeJVPsD9L
	qdRYRjMq9Xse8r9G6n13BtIU7p4PxzQkDjKGV218EqmGv8cQJoq8PO21CdcW9XWWQS751Irjdl3
	kw3hHXneROM+UjYV7IYVkWT7BJpU0HUb5hj7o87gXNiyG+LFOzlMqnRIql01yBRKzPfrQ40AtF8
	MrlQ==
X-Received: by 2002:a05:6512:282a:b0:52d:582e:410f with SMTP id 2adb3069b0e04-532edbbcdddmr3352417e87.46.1723713902561;
        Thu, 15 Aug 2024 02:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTZkKDHUW/a1SQ8jPfQJ+Q+tEU5ep/4T2uXV0NfHa+967OhzX5TBfB5pRRpmHTOYVJYolsYw==
X-Received: by 2002:a05:6512:282a:b0:52d:582e:410f with SMTP id 2adb3069b0e04-532edbbcdddmr3352395e87.46.1723713902114;
        Thu, 15 Aug 2024 02:25:02 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:25:01 -0700 (PDT)
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
Subject: [PATCH v3 07/11] fs/fuse: drop idmap argument from __fuse_get_acl
Date: Thu, 15 Aug 2024 11:24:24 +0200
Message-Id: <20240815092429.103356-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
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


