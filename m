Return-Path: <linux-kernel+bounces-286382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F2951A46
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19636282392
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BE51B5835;
	Wed, 14 Aug 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Y5E1Ogwl"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27AF1B581A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635696; cv=none; b=XGMRgm8OdZqcgd4urfUMGivWIf3XA93Yzyp0HDLOgOgEMgSuRUo+DgH0v61iQRMzQ2+6AbHaKSic/3+HO2ZiVX9/+sZSjec4bDiUrgcUSFt6bFSDEeg9AvAbXAzN22SGEz9buiPcDs3JApJRp2SPSPzuAkeAVYq9krHM7e+83xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635696; c=relaxed/simple;
	bh=ONyUrWrgUBZRJvO+nhcwWS/g3zi/w0z15wLOTv3nesw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IqkeRy4fMrrS9e5E8h5WYrfi10TgeFUEvAz+a1ntflH/TFuyQkoH3jULUu9K/G5TaNtB0gJ7duhWCBHDUYNs2lc4+poZSeT83Wa4aFEuo5nIJ3TE0sj3i9yjJPcuivCdI1O1VTcAtUocthN/6sXi0Z0YVUAVYvo4gi9aTMkSBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Y5E1Ogwl; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6431E4596A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723635693;
	bh=+wGAYIUsqVxDBSfRQAij7GIIUQJC7PY8L940f+LK16E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=Y5E1OgwlICh8d+kK1UBixZ4okzc04l6jhRuTM/iuFhdscitsgPZhCG/A7cpM7bb9w
	 TxICb8D06O2U8Q5ZR22LanANrfRnOs0zNjfBn/kQlbTp2vo9LPc2CmPm+Uw2QiMJgr
	 kpdDEIES0mUe0ZpEsVLszf4raWcJgyb4FYr8DDovGhEAbBn95OXG2EqGoAclqzwryj
	 1fmx+wRn1rob3lGdpB8+SAxf+YFjItE+QAXuwh3ktjCpM5mj+KAJARzQR7IotMlGOe
	 OX8vRA8Uc8Q2njOLBRZ/OQhFTtJZrGtjHwPsFzfwpeIwp3CJaU63ElgmKXlwlKeRAW
	 ljsls1DP0esjQ==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5b58f321a2dso4674341a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635692; x=1724240492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wGAYIUsqVxDBSfRQAij7GIIUQJC7PY8L940f+LK16E=;
        b=q3BsbC/fxlZ6s23ORBYbxppkbytmQm2SZGMuBqAkI86i0q/9hoftq+8IdARIwTOcLG
         7evHlIl1Rb8CBhdqtPYRl6nWeXGwtulTepjcltgADs0XNtOrl2mtyvLZpxZ8bJEKdK0e
         70RG7h71pvwTy9e6h7mPJLpRLZBmWRPAPjDjIJ55cADmraFQlulPcC7in+ZrxzI6ANA+
         XjamKTaMh6BCZQIsfiS2fNAD9foyB9ogmDwxLkR6D9p01fK8ZUAHj5jycY41qizxCJyR
         dUPMxAYc4Nbvfkwqwus3vR1szMppQzTTShqb9B3lfoKVOXvzJecdEhKCnj0qSXtnC6BO
         i06Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkpjHonRfFlSzGP8nVdOqOUW7tqh5hOwgvYOxWsAno8VEVlMQCRg/u2tcNIDAjdO5oWdWN+l2zf7Sj9Lj6FhvMJFWkCmxQWENmAJ5R
X-Gm-Message-State: AOJu0YwcfYhODuIApaYPBrgnQm43v2U7GEp086c5KN5ued7g+JTvgtA0
	R+WsQTzunwPYz7vbx8/XedfNSpLL/h8KFepsX2tAaGmnXQjsezQ0S5x42DOSeccMwb+Cml5DulB
	bB+5zYXG5l+inwMdW4EayQvpNRLdqjr5qRRrtw43+9DXnnrgRNOBDdvo6pQby8dPj0HYSlzwn9i
	6xTwcTHd6uhw==
X-Received: by 2002:a17:907:e299:b0:a7a:a30b:7b93 with SMTP id a640c23a62f3a-a8366bfc205mr185943966b.2.1723635692272;
        Wed, 14 Aug 2024 04:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVElzlGQvCp40SGYdLshfg4SAiY1Lf5Iy2oHIC3dUD7p8/6p96C39Yy7gEUeBpOKaBSMFHag==
X-Received: by 2002:a17:907:e299:b0:a7a:a30b:7b93 with SMTP id a640c23a62f3a-a8366bfc205mr185941466b.2.1723635691845;
        Wed, 14 Aug 2024 04:41:31 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa782csm162586166b.60.2024.08.14.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:41:31 -0700 (PDT)
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
Subject: [PATCH v2 4/9] fs/fuse: support idmapped ->permission inode op
Date: Wed, 14 Aug 2024 13:40:29 +0200
Message-Id: <20240814114034.113953-5-aleksandr.mikhalitsyn@canonical.com>
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

We only cover the case when "default_permissions" flag
is used. A reason for that is that otherwise all the permission
checks are done in the userspace and we have to deal with
VFS idmapping in the userspace (which is bad), alternatively
we have to provide the userspace with idmapped req->in.h.uid/req->in.h.gid
which is also not align with VFS idmaps philosophy.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a5bf8c18a0ae..cd3b91b60cae 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1567,7 +1567,7 @@ static int fuse_permission(struct mnt_idmap *idmap,
 	}
 
 	if (fc->default_permissions) {
-		err = generic_permission(&nop_mnt_idmap, inode, mask);
+		err = generic_permission(idmap, inode, mask);
 
 		/* If permission is denied, try to refresh file
 		   attributes.  This is also needed, because the root
@@ -1575,7 +1575,7 @@ static int fuse_permission(struct mnt_idmap *idmap,
 		if (err == -EACCES && !refreshed) {
 			err = fuse_perm_getattr(inode, mask);
 			if (!err)
-				err = generic_permission(&nop_mnt_idmap,
+				err = generic_permission(idmap,
 							 inode, mask);
 		}
 
-- 
2.34.1


