Return-Path: <linux-kernel+bounces-313224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CF696A20C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F335C2823C8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904ED1922E0;
	Tue,  3 Sep 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AxoFDJrR"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8871917F8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376632; cv=none; b=cXfXLQb/T00BChQF2un6TBQLM4H4mg5zex3B+SQIB15AvhDTd3fHzBq2VSauAq9mCRMZs2SvwrEkKN+blz/E/tdtBoemSpVuOEXP7zeUWtJ83if618OTVK4El1Q4AcyP5m6zNWBYBja8hFayOM1QVGjxLVZqJtxA+F1mloelYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376632; c=relaxed/simple;
	bh=4adc61tKzjK2fTdo7B9pTquQAHQKVd/XEnUnW9CoK7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oukpmMrhpnJJj939H9h4EluGQIuTHdLWtTk+oUhe/4B5wbqUbuOZNowP7mvnJ7A4falyS1c3tgXfKHN4OjHEG8Z97oglOJ93Ozrr76l0PTqBGrjSkScDXoAZ1vLKLbtKMddak6gu4frYBA775HqbInKAgRFj+KkqrP5LbLQOY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AxoFDJrR; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BAD383FE24
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376628;
	bh=ftHOv+os2MH3Qk9OKnsGMHrGZxHBoFg3umKFJ4e1joU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=AxoFDJrR/uAvx2WbQfxnvYk5PgY958HjeB1+ETaE1JDOhukN+meK7erSN4/UDSHfz
	 0GneFHw0ulyFq1IGnJEvknX8NCLVMNbEVZbRCNb51VplxrCWb37Q1kKrPPc6HAPMnb
	 604DJ/AN51av/3k1dFrvvRRMOAOo1xIxzrYzPfsZo1z87KhUCNQXFGnpHy0TtGgc0b
	 JwEgok/I5/kabsva8iPoVYmdBmgSbCKuj8WSo3tDT7WbByzgw/6cQTvU3KVxglDHVw
	 XFISOpAoRJGWTeLvPJ8qn6ikozoGJUxpFIZpz3qA5c3b/LziTY13DgBWKSXXxR3gJl
	 MP8d2mZBqXtmg==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53440ff1ecfso5784295e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376628; x=1725981428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftHOv+os2MH3Qk9OKnsGMHrGZxHBoFg3umKFJ4e1joU=;
        b=szveIeHwWcQhQevs9b0h9rPYyXWvQ4h2FBL+oWPLPNIGIKS5HW2j/eP425cz5XqswJ
         vM6DFNWgFzKy+c2c0IOkN0xtcpzto1enfvVIwGcdaS1PEwRz0+9OBXmjWKVvLPcybkV4
         zRAkJIsr8V5HYVbrvJFDgtGbMmeHF6zfsUkseCx7BzmP3D4JsyKV997F007SjUQCtrGk
         IYVHX6HaKVIl9zBbKP9WahE2LdQR942fS+pmcFkoJolOhUy+w52dxjuc+y9yb0U5UVr4
         S0PTSFS7BoH0k6BI0ww6ihCzFqMGykllkIRiBj5u6y5DY9mzcDdsXxNqPxcAASNYxkZm
         GSkg==
X-Forwarded-Encrypted: i=1; AJvYcCWWDDN81ehg6IQx/aTCJLjQi4pCwakBWJkYdggP8NTuB4ssSRkpTByT4oBCYLEc6bAP4pShPT1xKNw5EBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4NG/tsf7Nm9Rvf6jWmQwqnD8ym0NguKKMscrQGrM3rcXwcsd
	6nfu5VKNh+xnQYcAwtz16ldFJF20LO8MinaEuhlizM/2Xk8qP7z6pIUpnauICZlA5KSLXzTdTc3
	KsAbLsewDRLDkBgH28FYYrc2uTVjoVfTuxCHdihYpgZAHu4KPIlnpXXG+Ob11W1FoNvrudJodIg
	kSsQ==
X-Received: by 2002:a05:6512:282a:b0:533:6f3:9844 with SMTP id 2adb3069b0e04-53546afa387mr10490570e87.11.1725376627977;
        Tue, 03 Sep 2024 08:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5r2bdM4b8pU4WooC0ysEsGd9NXSqimzWCsNEiz5JuzrIziCYp6jmEEIfAj6my8kq7tExZbg==
X-Received: by 2002:a05:6512:282a:b0:533:6f3:9844 with SMTP id 2adb3069b0e04-53546afa387mr10490545e87.11.1725376627555;
        Tue, 03 Sep 2024 08:17:07 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:07 -0700 (PDT)
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
Subject: [PATCH v4 09/15] fs/fuse: drop idmap argument from __fuse_get_acl
Date: Tue,  3 Sep 2024 17:16:20 +0200
Message-Id: <20240903151626.264609-10-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
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


