Return-Path: <linux-kernel+bounces-383501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E80899B1C8E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC5A1F2162F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 09:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B9C55E53;
	Sun, 27 Oct 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rx8tSTJn"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EB4161
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730019598; cv=none; b=NzTHQUMnj8V+NNWZOCa3Nzc0yok70QP6UblDd3hC8MblFAN2g3Ei3aGXJB7//M1Qjz1GlE6dGiAKH1ASRsELE3UZv0mmJhqUFbgP5LVkEarBhfv3jWJlM+c3XkzEhB26/rJf71MF4gJxYcwW3jSI6z7rq6+S79rGNzpc8h0QIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730019598; c=relaxed/simple;
	bh=11i1AgQow2WhGLzPpBPh7Vb/cUhrEUuBhncxE38/cGA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=SdnnMen+pUr7LzLyqjwMA7ZQ4RJVBDLEx+cPK1NNs6flII8aFgmfATAHqo6tS284bbtYPntwcOPnnb5q80RBoLKcD7QhwKICjmngIqCDgeYy6MeTvh8yTkZ0hWYPkJGexXyOx3YgkWP5diG7tpJIYUjhqsxN/xMpidzrI0OkO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rx8tSTJn; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730019285; bh=d9eB+SnHR+98czXwGSKWmX6BOVpjxwH6QUJ7429JbHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rx8tSTJnrXpumqI6yM5Kzyi92qfFggN+On4YbU/gyzZQkQy/7WZSUFDVN8jUvmo6+
	 CT5rzFoXoG1wiMJyrkwFsxf+V0Gj1q/oPzqnvMI6CuTygLddrgcv+TbvgG8gsi/TEw
	 ghyhWvHqqGud6EohLk5swA8W1aSdPBZBawLXQ5vU=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id DABA88CB; Sun, 27 Oct 2024 16:54:43 +0800
X-QQ-mid: xmsmtpt1730019283txyjqbrio
Message-ID: <tencent_4E83A7C006C212DC065509AAEEC86EC48C06@qq.com>
X-QQ-XMAILINFO: NhDhJCJPIfnTumN+Tm4o6xvRGoCMAAMFn3u2pOgl9Zj42REsCGGPl00BCedlrP
	 GXpBH1gtSkY0yNL844D42p7Dx3NNh5sZr/ZEOE8M4u41B2gAx8kg2cYqY9NztPXEb1mAkiS9UADW
	 Pq+mmOJE48IQYT+KMURLCgJIXBpVa1TzAFiat2Iad3LWUrOarqwectvbU/QJWwGPulD/qc817B4T
	 yjp00OZU/PbgHx/94CuKIFuI3yD581PJNMo3I3vXq+w/KGRM3m9TsicvEAMwxIKW8QVbYIrWihjD
	 F3PxNv9MMbbvZWRsh/Ds2FWdBymK3GNQR8J+4aEcfjGXthkz2fBO74ORqzHeR4rkFCpW+YtjZnbS
	 D17SgmKfefHNM4WDH5dldwI4UkmO/jLENxHDWXKacRbh3SVthenhyO/KQw7MfNeUXgagMrZxavqX
	 h9RSbQtSsSVCmzJZVA7LiOddzl8ONdxS71AXzhgGeqaU6uq8Um1vf7llJhPBsSjpbN/6M/nWMhVC
	 IWr8Jtwre9auIdNTniGGmFcCcD8eruOdddt7Q9OGvLhk7YE4nlsQYb0ipsPhqt1FfQcjt0K5ko49
	 EzGJRoS+zmHsXvbVks9xZ+kzMmA5t26ylUS7k8Ws3nHiJIVotTtXb4bCs00nfXncLF4SeEO7UH5u
	 IQEpUPlDVx3GWgz8ZY/0L8DMKzzacYZ11Dydy0glwW/Z9zo9u8SAxJwCmLjoTwrMMjyl3WDL0OJb
	 /Uux7n3qGNOgZznsOJDx9Fac3qBptWKC81CYhVbsmxxKQYHE9SFpQYWW6nuFcYvtnEGd9ieekKR0
	 HdUCqEFwV3rJTXF5FO5iUeeV5PQpNpOk8onSaKZ7sUhAfm6PLKCf6HdYtI0bXsopKkF561aXruDJ
	 6lNY9ARlQzaPWOeA2NAn9MgSGkeI8gwkKBw1d62WBz/gOsp9LlhIKVfphDRNzvfg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
Date: Sun, 27 Oct 2024 16:54:44 +0800
X-OQ-MSGID: <20241027085443.1753197-2-eadavis@qq.com>
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
index 790db7eac6c2..cd1e1e8e0c04 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2098,15 +2098,19 @@ void ext4_insert_dentry(struct inode *dir,
 	if (de->inode) {
 		struct ext4_dir_entry_2 *de1 =
 			(struct ext4_dir_entry_2 *)((char *)de + nlen);
+		printk("old name: %s, old nl: %d, oonl: %d, %s\n", de->name, nlen, de->name_len, __func__);
 		de1->rec_len = ext4_rec_len_to_disk(rlen - nlen, buf_size);
 		de->rec_len = ext4_rec_len_to_disk(nlen, buf_size);
 		de = de1;
+		rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
 	}
 	de->file_type = EXT4_FT_UNKNOWN;
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext4_set_de_type(inode->i_sb, de, inode->i_mode);
-	de->name_len = fname_len(fname);
-	memcpy(de->name, fname_name(fname), fname_len(fname));
+	de->name_len = min_t(int, fname_len(fname), rlen - 8);
+	printk("rec length: %d, buf_size: %d, old nl: %d, name length:%d, %s\n", 
+		rlen, buf_size, nlen, fname_len(fname), __func__);
+	memcpy(de->name, fname_name(fname), de->name_len);
 	if (ext4_hash_in_dirent(dir)) {
 		struct dx_hash_info *hinfo = &fname->hinfo;
 


