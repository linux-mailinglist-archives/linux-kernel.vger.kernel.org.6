Return-Path: <linux-kernel+bounces-179636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D6A8C6297
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6821DB21258
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE34C61C;
	Wed, 15 May 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVwn63BW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C848CCD
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760765; cv=none; b=N//QfI7GnlCFViy5AE0vuiAbtJalyU6yyDpuGb0i+veSQNHHVR8lv3Ybo0wtfaU8gcgGmQNVQ+uLwPztYXPWgIepf7+5872jn0QBVdK5YQSaGVpRy96QQ0D3+7hMoyC/jrq3SNSw0s9ZRnPDo1HXHkkwocT2I3+HA0Gm4kbYt1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760765; c=relaxed/simple;
	bh=czMNo6nRJc7COieIC50Mp3lh9PWzedr3ZXgWeiNj9QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bsJmPCv+eMDe8PhYgdPn/wcKN8Yx7KCBtgEOatQFqLvng3Gd+YxiixGNy8vWHRUnTxOfc1HKuXOa2QcWXAGpwqcB1mNNFnLXJxROm/5m07OsvYd/rLRC6KkeG7ZgiksUddYblqRz9/0fXBX5X41efqLTaqzyCiN782B7gyodF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVwn63BW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB685C116B1;
	Wed, 15 May 2024 08:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715760765;
	bh=czMNo6nRJc7COieIC50Mp3lh9PWzedr3ZXgWeiNj9QQ=;
	h=From:To:Cc:Subject:Date:From;
	b=tVwn63BWD9TTLpCLWIXhXveu7N22dfhKA/xrSzrZ8n3rgx2KgRIBrD/cq71vK96qG
	 wkXUQeID48+sDk/Z0nBYMUzlXWCb7qKXQ3P7yrLYUtQbalGU3i27XfaYp52k7or0kh
	 dLyVOHpVYCgY+zUBsxturwkZpCwpdQZbBRLUheGs8KcorZJebrI/c4YwO1PNf5BhkU
	 q2bdxpmQGGCptamE7USW4h13xzeG3GQu0U1JE2VgLfXR9TTv9NEikFu6EIrt2BNx0H
	 FAzNwQjCcpz6sAWlofkghwKStCpGMsALY93Naqj6y4IgBmjFdpF/li6+5hAz/19Ndc
	 VPIS6X50bNYag==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: add support for FS_IOC_GETFSSYSFSPATH
Date: Wed, 15 May 2024 16:12:33 +0800
Message-Id: <20240515081233.2463848-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FS_IOC_GETFSSYSFSPATH ioctl expects sysfs sub-path of a filesystem, the
format can be "$FSTYP/$SYSFS_IDENTIFIER" under /sys/fs, it can helps to
standardizes exporting sysfs datas across filesystems.

This patch wires up FS_IOC_GETFSSYSFSPATH for f2fs, it will output
"f2fs/<dev>".

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index daf2c4dbe150..1f0f306cbcac 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4481,6 +4481,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 	super_set_uuid(sb, (void *) raw_super->uuid, sizeof(raw_super->uuid));
+	super_set_sysfs_name_bdev(sb);
 	sb->s_iflags |= SB_I_CGROUPWB;
 
 	/* init f2fs-specific super block info */
-- 
2.40.1


