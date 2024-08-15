Return-Path: <linux-kernel+bounces-287746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E3F952C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F88EB25DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F6A20FAB5;
	Thu, 15 Aug 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BnNj6wA3"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6D20FA98
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713909; cv=none; b=E3xNFwPOuqPhG7r1uFkp/VoBuvmlP7YR7OtHvsmKOvFbIxyhJOnSngfxD5n9nt4H+tHG3Y/8HxdjsXOcbSWgNWlxbHh6yEZVNLTOGRPqYxNYXmMQuZYuJnY7BaFKAoBv7hQBLD0jmN/8SEtSFBxQLLPQHgn52LqJeaSenEv4WTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713909; c=relaxed/simple;
	bh=ItY86ikXLB5CiOOsAivB6bVSog31+kYXgujXhFdDat8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kd3TlYlzZw/ZAsysdmAicT62FXJ8WV/1JCAzDMHBvak8AZJGt9BwGAgOGEbGVFuzKF+ZjIMUfwQMwciQtYwhlji4hFF9PoMAEIHpbHxqKQdvg3/6Y6valVok9Vf7gAHtI+hvCFb4eKhKBrx99hKzL3UOsbVWpGvf3Tp7bRu10ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BnNj6wA3; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CA53F3F48A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713905;
	bh=AKgOJzf1FD6sazbw1kqXlY4ydMZMTG/q+wfid3Wy6NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=BnNj6wA32LnXZeoy9bPiT9cHPmdDa5RY1xbOnsPZfWZ4Z5pJQ3G27FCyDkou+WP84
	 lP90pDEmHaOETD3tVIhqu4kS1eRBt7xcOS/rCh8WL8CvGvq6yR2a5PIA2RkgqwJuoX
	 pRROiMyYB5vIhmxIYh4ksr+Q5RkvCxiWbRgk4rwg+sjMnP6cBOaaRNfpiM4vlEI8DG
	 AguQw7yvKnashWjPwILQPvm6/VHUVPCLZ5Dvir/46+YiXbDNHZ4FG6ru4dvu6qBly/
	 nL9x43gQgYYJ2BBiHKrAUCNoeZt3JRufpNGgN3DjzImjJ4ngAZP3o17xdx6F/z7IgZ
	 G4M95KqjjvG+Q==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52f00bde29dso872190e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713905; x=1724318705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKgOJzf1FD6sazbw1kqXlY4ydMZMTG/q+wfid3Wy6NY=;
        b=mcdI5SGVQmUyHQ8Y+7ZTz8SROdQ/KThdss4kx11pTcfnhqzVV/VzGXWYuQdW15lCJg
         496FYHlXcQoC4bdaHQstYvFjeX4twIC3SgO5zjSJjq184IuEDRlP6tFC8trwvBlEaiym
         eUQvuGbxSK/QlC53K5wlRTtr83q+Ld8KvS9VyLBnf5+QS7DXI4z9i/tA3/HDfebxYBzQ
         UgrYKnlr1x/PueJvb/c+8C2AJMx+KSFssybHFbm/DmkVXA6cM2/SdYzExeOFgleCZZ/+
         uVFgJXxZCN/6e5Mv5+qsBwTtpL9UYE3Ts9ATcu2EcPSK4fObtbdoKx0o5XJgnP2qKMxs
         bqUg==
X-Forwarded-Encrypted: i=1; AJvYcCU8dfGm88ghFRMoUFQItx53lU8sa2maT8sMya1XK+i9WMOmkKQP7l6ZniPEyEfGpQMQ3rKetfM8L/dfqIsIxz4Baq6HVQmD17+ZUwmM
X-Gm-Message-State: AOJu0YwMjY6Z3qUffUiR3c7uE6DXyfXKArX+9GtzHxj6ELurT13qxUv3
	q7PLohacjV1fXR8W7GyNbFjSFSu30/M5chCGuGZcw/9TSFPYNUu3XdU8Y/YitmnuGVw2XDycWjS
	C39PWxH738eyX75N9EXC3fnpSX5r/JUt7vuyPFp1Rd8/DIu3FhZNdpzprcaVgVXn6xqFaf7AKsj
	ZrMg==
X-Received: by 2002:ac2:5695:0:b0:532:fb9e:a175 with SMTP id 2adb3069b0e04-532fb9ea617mr3817508e87.6.1723713904888;
        Thu, 15 Aug 2024 02:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGx/vdKNpZNgVQz01CbRwoXGyKCak1Dnuqwz633QdtWw+oIMOWdvHhKLICOjgJpC7mpuObEw==
X-Received: by 2002:ac2:5695:0:b0:532:fb9e:a175 with SMTP id 2adb3069b0e04-532fb9ea617mr3817480e87.6.1723713904456;
        Thu, 15 Aug 2024 02:25:04 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:25:03 -0700 (PDT)
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
Subject: [PATCH v3 08/11] fs/fuse: support idmapped ->set_acl
Date: Thu, 15 Aug 2024 11:24:25 +0200
Message-Id: <20240815092429.103356-9-aleksandr.mikhalitsyn@canonical.com>
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

It's just a matter of adjusting a permission check condition
for S_ISGID flag. All the rest is already handled in the generic
VFS code.

Notice that this permission check is the analog of what
we have in posix_acl_update_mode() generic helper, but
fuse doesn't use this helper as on the kernel side we don't
care about ensuring that POSIX ACL and CHMOD permissions are in sync
as it is a responsibility of a userspace daemon to handle that.
For the same reason we don't have a calls to posix_acl_chmod(),
while most of other filesystem do.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 897d813c5e92..8f484b105f13 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -144,8 +144,8 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * be stripped.
 		 */
 		if (fc->posix_acl &&
-		    !in_group_or_capable(&nop_mnt_idmap, inode,
-					 i_gid_into_vfsgid(&nop_mnt_idmap, inode)))
+		    !in_group_or_capable(idmap, inode,
+					 i_gid_into_vfsgid(idmap, inode)))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
 
 		ret = fuse_setxattr(inode, name, value, size, 0, extra_flags);
-- 
2.34.1


