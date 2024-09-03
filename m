Return-Path: <linux-kernel+bounces-313227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F75396A213
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382E528AAE8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC92193091;
	Tue,  3 Sep 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Q/Y5sx7H"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050E192B70
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376637; cv=none; b=rFCYquwU9PnlVJ40dPdP3G0GKBss7ppLMMFsKanBZwgxEK5G2fIlX8Glz15Z7i69SjSkY14Qm6iRe3wJZtQ1WaJb6jylSGB+8QWSV5nN+kbkU5NaxlV4UfZfkSLC9M7I7UJeDVRBXNhGx7iKxzWTcGLU/x4uQXOlbcXZag0OQ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376637; c=relaxed/simple;
	bh=ezrwIWPEtkVKsO2BZ8GHjfDUp3paNgF+C0sOeuA/x40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lA+4UFpKKBi4ABdQmrjhLs/6DakUJqwYL4Y+pd2eCqK7qlsGNZl9lmX7JvqBRz1o7TAGvcawQcfXbiiSQnk7WlYdSA3tIE3VB4AwyAOdNJXKJB+lXFN/3XMZtv50odi60vZBR92QQpojkIyfW3PY00H4cKpNFyBbulz3pU0b5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Q/Y5sx7H; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CC0093FE1C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376633;
	bh=UlVqr8qfq0zm4LadiFaTT35TCbrEM7DrGylkId+7er0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=Q/Y5sx7Hjj9AbUArEUlD5AOtdoWF3y4v3vXtcfd6nk7K8F9zM0xym8Zp7m4taBnI8
	 JVdquzhnM0MWeDE+S3T29vJJgT0tz+3eXd66a/DkGIRr+vB13t1BYeSc7uiRzpxOKb
	 6oeGYseQgLT7TahKYdTt1Je21izR/Ohy0lNF2pejpwyO3Lb7wChyz09w4snQwKIw3T
	 KeSCwy1Sp2wEop2DTQALtgOpaWqe2q1wZmXC3HzARLQqkl2cvIipjlxbGIdEB2zMO1
	 btU6gfUX0sIyyjIPU6280CIoXvR1seSYXUgiyncTNV6QxZrck/TWegXOEdNaupB1f0
	 y2FDagf6g+gxw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a870cad2633so477434066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376633; x=1725981433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlVqr8qfq0zm4LadiFaTT35TCbrEM7DrGylkId+7er0=;
        b=QvQTXZf1HIQ9jYSE13HbwBO9xSuV0yYkw+t+4MXiCTHm7akYMcs0M1Ij0Awq3znGkq
         6W8gqh1+rCoEkn9pMfS0jiA/YfD4x7kMRFOsgLNn2se5OT/Nw1XClFL6HnF/nrbw2fdJ
         Zn4AzZYuluGkkdtkG3VUuVIf++nBmkJMN823oFkZfZIDuR+2ZXPg14HjooRCvqpQOEQh
         rBtYS0TnnevykjcxmdxXXpT7faepB3Gtj62f5CM89r16DEsqfTS+25id7PTSo9kgKuQC
         N6ZWzKsNdvCznKmYdf8+JQwx0ookqyU+6Smxv/ONYARKpa+zrNqeIojBN+L+iBbWY+Wh
         u0fA==
X-Forwarded-Encrypted: i=1; AJvYcCVqE78iDUh6QBaErt94LxXys52/pVyGyyNQjhLSAqdn7uBel2aAPpwLHJlZYNTcgw0lcUEn8WAqcB6y4UI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0GNcBM4SYywaOf3ANfZzv+yNaW0b5RUcdcW/elvyCmPftC2Yp
	iLgRTPSrd5jAu2D4YElWWwRI2WsRO332A0XUYEn5tkZejvPxTO7cff0xAMAjU2e+KGdVtbwm7Yg
	IxM9SPHtYmH8mRkbPMSW4PhhIASLX2SryX7GnvoESaKMo7Owh7lLGx1fH5AxXsF5+SiUk6kxhIN
	4JAg==
X-Received: by 2002:a17:907:9487:b0:a77:c30c:341 with SMTP id a640c23a62f3a-a897f1c3e3dmr1290756166b.0.1725376633316;
        Tue, 03 Sep 2024 08:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL2gL9kVUAD7c/U4EREwo/0f6jUYuTiYlOJEoA7Rsdp22DZQmd9M2c7KMwQk3rXunkx2Y1ag==
X-Received: by 2002:a17:907:9487:b0:a77:c30c:341 with SMTP id a640c23a62f3a-a897f1c3e3dmr1290754566b.0.1725376632859;
        Tue, 03 Sep 2024 08:17:12 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:12 -0700 (PDT)
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
Subject: [PATCH v4 11/15] fs/fuse: support idmapped ->rename op
Date: Tue,  3 Sep 2024 17:16:22 +0200
Message-Id: <20240903151626.264609-12-aleksandr.mikhalitsyn@canonical.com>
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

RENAME_WHITEOUT is a special case of ->rename
and we need to take idmappings into account there.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v2:
	- this commit added
v4:
	- support idmapped ->rename for RENAME_WHITEOUT
---
 fs/fuse/dir.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 08bf9cc51a65..d316223bd00b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1025,7 +1025,7 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	return err;
 }
 
-static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
+static int fuse_rename_common(struct mnt_idmap *idmap, struct inode *olddir, struct dentry *oldent,
 			      struct inode *newdir, struct dentry *newent,
 			      unsigned int flags, int opcode, size_t argsize)
 {
@@ -1046,7 +1046,7 @@ static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
 	args.in_args[1].value = oldent->d_name.name;
 	args.in_args[2].size = newent->d_name.len + 1;
 	args.in_args[2].value = newent->d_name.name;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(idmap, fm, &args);
 	if (!err) {
 		/* ctime changes */
 		fuse_update_ctime(d_inode(oldent));
@@ -1092,7 +1092,8 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 		if (fc->no_rename2 || fc->minor < 23)
 			return -EINVAL;
 
-		err = fuse_rename_common(olddir, oldent, newdir, newent, flags,
+		err = fuse_rename_common((flags & RENAME_WHITEOUT) ? idmap : NULL,
+					 olddir, oldent, newdir, newent, flags,
 					 FUSE_RENAME2,
 					 sizeof(struct fuse_rename2_in));
 		if (err == -ENOSYS) {
@@ -1100,7 +1101,7 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 			err = -EINVAL;
 		}
 	} else {
-		err = fuse_rename_common(olddir, oldent, newdir, newent, 0,
+		err = fuse_rename_common(NULL, olddir, oldent, newdir, newent, 0,
 					 FUSE_RENAME,
 					 sizeof(struct fuse_rename_in));
 	}
-- 
2.34.1


