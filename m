Return-Path: <linux-kernel+bounces-334739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 891E897DB7E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 04:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E39AB21857
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9678512B94;
	Sat, 21 Sep 2024 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Srb0XPSI"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27208C07
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726886434; cv=none; b=OjPIb6eUE4wM8y063Tpd6DMKDvhUYuHnfdZzT6hWf3GP9kjl7yyQ060EeR9OZ2ZDa0L0QV3HsNuWFugrXp9CtwSOQ8tlR8GP9z1YoEgyzd0ectO/tXw347XQG7fG1oQyqoHEYU7j6UWkGjkmfhjnEB1zVTE5sti8B4FPl3k68oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726886434; c=relaxed/simple;
	bh=F5Cc4Qnuaq4/+TFIiSCQCb2clyGJ26TQzJlfEiKKZWo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ht5ffLD8LRcODGNr4SVDNZG+skSnz7JmLPYlk3RfFv+3/bnWZ1If011TPLJXfdnB24gXjTWHLfDDW2PjJZaoMWchUPhyTSnX7DZTZe9FyKSjR7SzalYOVIfLuSQ2JNbJGStVwedeDYeQyg6u3EXHL0Y0vKx9rcd6urH+oZHMj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Srb0XPSI; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1726886430; bh=0+nXvJ0cpAFTJs+fwZb26FfD211gL4HLCxWS5HqA8DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Srb0XPSIkX8kHVIBngpyAdGIM8vyfnWREMyMy+VrZ0REMnD+DB/yL2YVWwJUIgeQd
	 FjLhq1NsKjvwbi8RxujiVfDl4i6QlltlxQXaeVobw5uQNbYkJvIu+yTMf+nlcX5g06
	 ExCNZHGFueJU2e85TvlBYDtKdun6Tx+txYr+7nZE=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id A1B9CAEE; Sat, 21 Sep 2024 10:40:27 +0800
X-QQ-mid: xmsmtpt1726886427t223q0w76
Message-ID: <tencent_E64425D6BAF8BBC833499EEE1BDC4BD41B08@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/+lCY4jeTXxmHgKoCtwmy3yHPYaDt/h8VF5Ip8kmXhY2W5ngqm+
	 yvpDRP0B0VBwM7R1CPcV+HOrlcBhfufv/3PDblVwEXXLX5CAaXP6GIzaez8k3k42MbgWDaNSEIIO
	 FZHAl33uiox60tTQINGZRJ5AtFss7Y96i7DCoUS6L2LCaU05pHAARBF+1MQ3RwLRgg8LlC9iJ3wz
	 VqXqfm51FYeDMRVuHy5u3pZIQb2tfVodC/hmgi7goZ6FYPzRUgwuYMlDyAiEB6oP0yfLF5uZveY3
	 HGyiBU4ape+dABVxPygf6yey/81FGcU02jtilqCMmwTKFblCQTP3bM0AvxZbIhMu1KAolxa9rwAR
	 YZvCS0K4M1YvoIkktLv2QxJWbIbQ2yvGTdIGF7MCZ6IqdAn0A81P+iDLahGf5IjPB8MtxO5gnedE
	 kpumL/n0jJZaYxVDQsJEPXEin8nJOHy3lIzflGlfCQU3qMdZ09m/VWwh3+SWhFp0s8AF7BkXoCuV
	 Cs91FO0j5C7V0VO5LOGv2Q7jMMh79qL1X+T2MDaYTpKlPDeu9YRlvbMSL59zSjPPEew7nVhRMYfW
	 7vGKWKMw4kz5aJ245SQDVY7PS6Ivt2ZYVu6XXI5kWbMp9ardLuNtLojwKPxiCi4vDFtwTLUE459d
	 g/fiXpFMgCqQ8i1f9/iYmZHK4qn7ZKPB5heMRMtcVRPJmKGt548ub57Ehez8KtCanIDVfRxHimwP
	 sWqfnb813MfDGNfc2gQ5CpN53elqhH0SkOlMPas+aIqXMI3YaSMsjYGUpMibVmbQSM1NUgSYgDHB
	 o5N+0Tze2zG0y8ajvD6HM9loLwFFh5wLf2YQuU1Ino9Npr1EVF4fDQQtCnZkyYPHxi/EQcimyleE
	 S0q+4Had6cKP8dg0/604ow82Xf7YXh2hU14ArYqYizmzcVvatsyfsdKyY8VtM2aRapifpxefiD
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
Cc: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in from_kuid (2)
Date: Sat, 21 Sep 2024 10:40:28 +0800
X-OQ-MSGID: <20240921024027.1240120-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <66ed92f2.050a0220.29194.005a.GAE@google.com>
References: <66ed92f2.050a0220.29194.005a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use inode's uid and gid to replace attr

#syz test

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index ccc57038a977..d4be183bf149 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1129,8 +1129,8 @@ int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			    (unsigned long long)OCFS2_I(inode)->ip_blkno,
 			    dentry->d_name.len, dentry->d_name.name,
 			    attr->ia_valid, attr->ia_mode,
-			    from_kuid(&init_user_ns, attr->ia_uid),
-			    from_kgid(&init_user_ns, attr->ia_gid));
+			    from_kuid(&init_user_ns, inode->i_uid),
+			    from_kgid(&init_user_ns, inode->i_gid));
 
 	/* ensuring we don't even attempt to truncate a symlink */
 	if (S_ISLNK(inode->i_mode))


