Return-Path: <linux-kernel+bounces-383468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 794FA9B1C31
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 05:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98451F21C20
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 04:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A612D613;
	Sun, 27 Oct 2024 04:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NB3JcIhj"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF532A1C9
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 04:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730005120; cv=none; b=ujjK8nCf8Yl8sjkQV6nomd4iOFX0JZjGcHoYcD0IuwaOqxXjVXy7FCzYN27GqWzbMGRDwuVLHLrrNrHtzW3s36S51fVF6RkTYlHH+kPh3MMOR5oKk9ltN/ZDqJt9yD+4O3qFw0PAWfFfSXfjXrh+z2u4tE3zU2fG2ZXoV7PIaRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730005120; c=relaxed/simple;
	bh=k1X7LpehhpLqwf5OdMdjLof0hvvSka2PXlbmZI4zA4o=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HwyO1gM+wphFLvoRywN8SIZQMsQ19NKmzIg6BWawVCP1WWBcSx11IqbuJe74ASOc+a4nuUK8sh8FcJYiHwUxYlZtbZ7U5gMYT58CtfiQOxzGAu2Z2JrQtX7oF/VFfOsXb45eZxYNywhbjb3eKyFrP5Tnf4xsiGBvPD0AqdNZk48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NB3JcIhj; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730004805; bh=G6PRrk2cyMafR4ldr+/5vM6D6twssbbZjjrt+CQzkt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NB3JcIhjDRgHTHJozbrLQKLsk8tdoNx/qhUb9tc2VGa8tezdFvevX+JMku+9eU8Lh
	 73oXGOEvqndsJtdezdw8zmm9Khw9fn82wmsHSd9LFLWqsitYaxEoJmMn4+Th++Orek
	 waRUc9XYbifOQnLyEFM9SGZskrpowGMklcueIuls=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id D579E2EF; Sun, 27 Oct 2024 12:53:23 +0800
X-QQ-mid: xmsmtpt1730004803t5mrbkije
Message-ID: <tencent_6858E836EFAACEC478A26E8C2E216DE0950A@qq.com>
X-QQ-XMAILINFO: Naw3xMhTNeIu3YZH5sNcDZSJOLhmdJ2kkeYkY9pFwodvc7VWhS0g1QG0qRmkWo
	 c3aco2XzpVzIsF4qyWyYvKIJLzL5y4H/0nWxHgXel4N9zAyI+92UAPRSLkHVW+s4+hSIWcgxjNjE
	 7gsqByGqpxjVuOG+f4KkloSMFncrr6xS6ZqYovj/n6JQByXVtB07Y/e6h2l92/uPY5173hh0JYaW
	 i4fPXvD3DpMHEai/oVPOLxHPsP2u8Pj3k+UXv1pENH3LWDsj64ZOjwgONJgbF0vzVxVjJMEheNpN
	 8J8Z808i1sdelFKYbiUP/JAL2fHiJs8qnQgJHR3WnjmE1z3VEEHS16imiLVmFVgeILGCz6kl9Y30
	 Q9JAJ0BkTc64YLfPHlbYjmwfJi6rhl4+FvR1EjMPF/c89N37uxpsDf0/9eaq0aVuwOh3PLGnkmj3
	 D5l1adsxIG60RTMw4eb3ee4zvXObeQXi7yDOD6oIPAaZ4T0CpHTQ77A29l/GMcIrVoQwGKxoWYCf
	 mEGPGvYx1OiMijr0abUTmRA1NusiQGOMjlK1FV0KCYnRN1AL1cxdiCBKVToRlZKw0PvwYBpbu4lU
	 i+r2O/6ErJRaJ4+hifHZcKRunw6Dkouw2ZW67f0UPNZyJhDQMpt28d4DFcHFIVZcmtBfVn2mL1oa
	 SwbOALBOY1qZyaltiH1G756bnfgM1rgCXSUu3eOVPjHblqFFfPQK+KFzLnZy89Qh5gNnaVUC+S8K
	 eUMCyzj1XuVsrPw3I3zjaS+c7yAJqygufRDk0zCb5GD6iGUDOHmSOl1BN+3VNTIDAy+Gb6906DMI
	 r+G4JEXjuJ3T/j6uQ9wuZMunCUv/h+5kuRDxfLe+p2kfB2Pl1V1kqoYrz4aOp3cUOrnRlLwErqYl
	 hT4c7lyXvNxgzS+Q14O9G6qLIoVQGq5PFr2fPAnT8SGoZGb/oN6RhXrE88/4v/Iw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
Date: Sun, 27 Oct 2024 12:53:24 +0800
X-OQ-MSGID: <20241027045323.1537753-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>
References: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

directory entry space is too smaller than file name?

#syz test

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 790db7eac6c2..cf11dcffe4bf 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2105,8 +2105,9 @@ void ext4_insert_dentry(struct inode *dir,
 	de->file_type = EXT4_FT_UNKNOWN;
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext4_set_de_type(inode->i_sb, de, inode->i_mode);
-	de->name_len = fname_len(fname);
-	memcpy(de->name, fname_name(fname), fname_len(fname));
+	de->name_len = min_t(int, fname_len(fname), rlen - 8);
+	printk("rec length: %d, buf_size: %d, name length:%d, %s\n", rlen, buf_size, fname_len(fname), __func__);
+	memcpy(de->name, fname_name(fname), de->name_len);
 	if (ext4_hash_in_dirent(dir)) {
 		struct dx_hash_info *hinfo = &fname->hinfo;
 


