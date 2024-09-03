Return-Path: <linux-kernel+bounces-313226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1125096A20F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 784BFB27E0C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FC91917CD;
	Tue,  3 Sep 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vYYS8ckV"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A341922F9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376634; cv=none; b=SViiDLwd6ABvvgbkj1iQq9/eesS+trIxHn8wVkLss9+Z0M4888LW+X3IXw86YAlxvDzdDXPtDK9oUmVSAyKOyp3JfqLaNzojRwVrX6nvnlVh5o3G14WSRjYFYWmFSANC9TExEZKzvjtXhoCirmg/p55YUJKhouPCkRjxlI+owjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376634; c=relaxed/simple;
	bh=zCrcaSPlVef9fMgj6fnLuhDo1m+kzv16tHWQShTiBI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afJej/kqHJxNuhWPxF/vxa1GetNBf0KJnVgo4IegF43IHX/Kyv00XOBUnfVNtHVEiZswPj25Mc2r8Pxtjyl4xI0hSuRJe0NioGMLFFzI3JJeq1dgA0YXVZRxDmlz1w+V50FnsMOjiyyUEuJuxmIOx/RiUOE/Dy2/smnPAI+Ov54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vYYS8ckV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A0BE33F284
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376631;
	bh=btta7JvkwVu4o++SpqzGVQUNPal7Y+ZsmtoSEosWuhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=vYYS8ckVqaTMWNJBCPphlcouEvbpQ2KhpU/o3bXj7JehDaFasNpBRRcwslGJytNXP
	 G68b3Wgtu8Oz//s9oxjH65eYh0YWsNkLsa1e9PbHfiO1v8XbhcQj+QeklBAjzFxspI
	 Gc6ZdOic9CaCy3KpF+nUVTKjMJHu0JrQC2Xvy9fVqHZudyLFdRLblMG5T+qTrZP8Ya
	 VsISIcnC5UQrMuWdPPOoD3ZcwVjjjWoQq5sefhc0s6DyVXPfTM/feNuf/kM2yTNufo
	 3ptaApsEM5/Px+NIxZulySycVhrslzeams5WVkfjGE6cNKfLN5HfAu5G2cUvj52Psi
	 3tOiPI8mGXedA==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5334191fc41so5250658e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376631; x=1725981431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btta7JvkwVu4o++SpqzGVQUNPal7Y+ZsmtoSEosWuhw=;
        b=XEQb0SKD4LML+vXVtxTDB7FIum9ZK/mOcJC/WQhyAqHnKZmdSDceYDcdetWr95nlVU
         mWJNawl8aNLKNSy6TzxeJ+li3OvHaAAs3HlyXFcACbA0Bk+V2IhsHbpqz/BvvgWlFFOU
         N7drZ6SOf0qs/nAouseCqVBz/C4yCNrQd1Dsdx3nSYEH+fYwVxGx2dQZrYtA9x1BrB9R
         pIzvNkijiLCPrMdwzbG/ve4qYVlFwZOVMaSqUPuG3GzUWDATsyOMqSA3gPiqcg8J797E
         LHzGGfA5z8E+xRgDobkqrDu3zv8+VRPxHcjtf5op0kDiTZxXAR/o8Qn6DttgD249ORAd
         n0CA==
X-Forwarded-Encrypted: i=1; AJvYcCVdqLwpj73Tt1YYbaMie0McOWUiKKCoLoWpODbeu3McYV8G6VGBv4Qk/utTW1e5UshqhGn0us7hgrmlhvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1dShPq8j0QmKrvbePBTOSu/2lOOrbjiHfFr1X5Ie/a4y7Oqws
	7wG5IkeeHNNPLoHCnV1nsVnlIuXfklwvN8qXuIGthGfzaRngZDfWvD0zG92CN5GVyA0iGBpWQ5X
	ekAlj5x+1i2Cmx5kjHpLb1J+U1DYVTu/2C75A5RgqXYWr5FCXolVp1eyQUR4CgnDgNu4/AsKPOS
	8Y1w==
X-Received: by 2002:a05:6512:2215:b0:533:4676:c218 with SMTP id 2adb3069b0e04-53546b191c1mr10714027e87.8.1725376630617;
        Tue, 03 Sep 2024 08:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9/hcou3cmyT9HFV+yv/KjP2e+D8E+jeLocrBSGTUTM5RMK5sgega+1/hOouRDW8vLnMtf4A==
X-Received: by 2002:a05:6512:2215:b0:533:4676:c218 with SMTP id 2adb3069b0e04-53546b191c1mr10713999e87.8.1725376630113;
        Tue, 03 Sep 2024 08:17:10 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:09 -0700 (PDT)
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
Subject: [PATCH v4 10/15] fs/fuse: support idmapped ->set_acl
Date: Tue,  3 Sep 2024 17:16:21 +0200
Message-Id: <20240903151626.264609-11-aleksandr.mikhalitsyn@canonical.com>
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
Reviewed-by: Christian Brauner <brauner@kernel.org>
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


