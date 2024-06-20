Return-Path: <linux-kernel+bounces-222011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E8B90FBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8030D282E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D39224CE;
	Thu, 20 Jun 2024 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nrv6QlIA"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7111EF01
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853856; cv=none; b=ES6OiOk8TStyumQmoPs4u6BG1eC/DeSNSPJBcs/EE33aSFtjvTT5ovPCpDlGi2O2uiZUwvFxhbxljb+nR42i3bkeOaLsyOI71VP41LbHX3HTO4WxU5Mm0GjHo4aJWnzbSX+dIYQ1pHsKEpEtmfNNXjvs3xTqrcmeoCthmg11XrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853856; c=relaxed/simple;
	bh=7GOdlpxAnTIQz9LWIEh1ljv/lbMR4nQOh5qOOSCyJ/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fgCGteBS+dybQ8rVFXS4HJycI1vOtXc2aIlmpUPbGnwTSPIGLtetAr+N1L/MFBjjaF8rr/6sv6myQFT591eEZ4oWDpNoatWk1FD+AiN87nIkFJrB1KBI3hjgTzUNhVjKC35QvbHw8zTPqAVEN74TcNZ2ElkFXJMMwv1GnxTfmzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nrv6QlIA; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: viro@zeniv.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718853852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A63/JYmEm04bcb67Y5GvfbOJO1Si9x3i8LU8CU9/NzY=;
	b=Nrv6QlIAtbJvAFP+1oXsWRC1DeAN0TlBs4uI3DH3HwTzcNNBje/scSBAkpzTT6rFblCnQH
	Z5/DdY0cbMS/kJZTAFid8gPYIBuCQKl7D3n3fBLTyH2teuQvCTgBKzCn/UV25b8ooruBBx
	ZIa0cTwwe/Hrn5YVJjlMii3j2sO4IfI=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: miklos@szeredi.hu
X-Envelope-To: jack@suse.cz
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: youling.tang@linux.dev
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 3/3] fuse: Use in_group_or_capable() helper
Date: Thu, 20 Jun 2024 11:23:35 +0800
Message-Id: <20240620032335.147136-3-youling.tang@linux.dev>
In-Reply-To: <20240620032335.147136-1-youling.tang@linux.dev>
References: <20240620032335.147136-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Use the in_group_or_capable() helper function to simplify the code.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/fuse/acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 3d192b80a561..04cfd8fee992 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -146,8 +146,8 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * be stripped.
 		 */
 		if (fc->posix_acl &&
-		    !vfsgid_in_group_p(i_gid_into_vfsgid(&nop_mnt_idmap, inode)) &&
-		    !capable_wrt_inode_uidgid(&nop_mnt_idmap, inode, CAP_FSETID))
+		    !in_group_or_capable(&nop_mnt_idmap, inode,
+					 i_gid_into_vfsgid(&nop_mnt_idmap, inode)))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
 
 		ret = fuse_setxattr(inode, name, value, size, 0, extra_flags);
-- 
2.34.1


