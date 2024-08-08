Return-Path: <linux-kernel+bounces-280222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6824E94C75E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999A71C2273E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2901649C6;
	Thu,  8 Aug 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XXH8coMX"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D38215F3E6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 23:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723159741; cv=none; b=BfcbGKW73/AWpbbFVCGWUnPsv1YIRwAYhpsugxgMwcINci6DseNGS1hZH2mkOnztBbYoxSot1/Nju3l8k98K/ZZDllCk7M20o9zpatfBxUsuSGevop862/SCGjGrcBNr4FQP42EUaCvq400IPLGmUBezeDw0tP0N048HiQgXOtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723159741; c=relaxed/simple;
	bh=Zw2/aqB1aEwjwi/OQW39VnUMpaEpqcLEKQmT0pAgcVg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uUt0M6KFC7e5d6ejsY4tr2ssFm1iL3UwSlgrcTKV6CzmP9NfTNhExPakI99pceqt2HYxoEBUPVh2A+G0wrqF6S8m/Ed5Ao5LCcDPLbC2pDhV7BLpSp1uaSqM+JoWW5lgdHVqYg9vBTLl0CPhB7n8SBAggoIFqV21/xfVnn8hY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XXH8coMX; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723159730; bh=kFtd3Xgf4zQgY5ltMRu3MMXC+o6c20tMSkdvN8udqJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXH8coMXAqd/I993tVPNBD/rWLnMcMiS6YkJqdxNWj0JKr01J65Y2lmXEEGPRKiXm
	 QufwCihg5SUTic21hazsG0O49LA5/u73g1+lH15LtwPqf/iEM88EaQqwtZLRhjNZ4K
	 T4gyiie/2zsr3CUSA9V9jEfKd3ZfioGqvEewj6Rg=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 5AEA9213; Fri, 09 Aug 2024 07:22:46 +0800
X-QQ-mid: xmsmtpt1723159366tziog3zl3
Message-ID: <tencent_1252C8C67A098E6ECCAED4CC9927E8C6C406@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jm0eXw+cn6PWVm3GG9h/aNLGXw3sFaxk4ExmTq0mBCobhAb3oCE
	 JGy7iNereV9Mih/qvcVjuAwvgXtUJmXxN2Kdn4mC9fkeNhDoe3zmv7AtvI9e3PD5h66wgtS8CF6G
	 3HSxI1uL7mfh+dKaXPtFg4qZsxfdJZU7UEIWQF90WxvvSLF74953/jsMDHFs0e2z3Wm5he3ZAqVL
	 LM7LEmlILkxYTaFAkz0ZgLsYrp6aPf/8yEDquiFoN8KrdbGI+CmM9v82VdbtiPaTokS9XdR3CPAF
	 6WPKBPuM90X6nfkspJuIn3NMaXRL6/BuxFRhDAJBOKb/EfywqU6FDplIoZMNs8haisWnIf75LkYJ
	 wj51ZyJeMP73b8xXsw6fzUgkQaU7u7RkxEGuMS8LGUlPUFXA5Zd0uFlkRRIVMnAeGiOmXyAAgpdW
	 hV17ocJVPwIMXbP+3s8of0I5OUQUdB7fnfrBSDuL4McJrwK1hdUK88La5Tr8G4lj1phiYAqrsv70
	 /LmCcnh32HGphQzWvDCy7gx8AUs9dIMWxGIfJE+693KDVF57r4Wz6GTCqOXun0/IbOBRbiRQk9gs
	 WyiM0bO7hnULOlz4wXlwUFh/ZGKSkDlQLdvQZWQDU7LFmxRksXbOw8fiCzfgebEItgrYOyA5amjl
	 3CyDfGpZsOZJk+KGzffv5jv/LAgAydLmnQ+ciICChG9+F/WOjXl3yoaiTcBDFec2bhrleLWE8UJ9
	 6DUr6tPPDOZ3vbJGNmM6nimX7DRbvXZEdUp5wxRnzno6QylxqMaOBSKslw/A2CIWeSRiOnCJIv5L
	 cfejgt/sSvudDr3DxxEorH5FT4eSTUzcxVx6hsDQtTvGKfeOjJhKSaqE3CJdvxBybjl4/rBw4iOo
	 z0M+u/zHTkkqfdKu5UAnv1C4GwZQF5PMWGp3jdEpMBFdWJOqcJG+M=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Fri,  9 Aug 2024 07:22:47 +0800
X-OQ-MSGID: <20240808232246.1558059-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000007ec511061f00a7b2@google.com>
References: <0000000000007ec511061f00a7b2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debug

#syz test: upstream c0ecd6388360

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index de009a33e0e2..d008ae949047 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -67,6 +67,7 @@ struct p9_fid *v9fs_fid_find_inode(struct inode *inode, bool want_writeable,
 
 	spin_lock(&inode->i_lock);
 	h = (struct hlist_head *)&inode->i_private;
+	printk("ino: %lx, inode fid list is empty: %d, %s\n", inode->i_ino, hlist_empty(h), __func__);
 	hlist_for_each_entry(fid, h, ilist) {
 		if (any || uid_eq(fid->uid, uid)) {
 			if (want_writeable && !v9fs_is_writeable(fid->mode)) {
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index a97ceb105cd8..7768cc70439d 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -34,6 +34,7 @@ static void v9fs_begin_writeback(struct netfs_io_request *wreq)
 {
 	struct p9_fid *fid;
 
+	printk("ino: %lx, %s\n", wreq->inode->i_ino, __func__);
 	fid = v9fs_fid_find_inode(wreq->inode, true, INVALID_UID, true);
 	if (!fid) {
 		WARN_ONCE(1, "folio expected an open fid inode->i_ino=%lx\n",
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..4f02d8f294b1 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -218,7 +218,12 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE))
 			retval = filemap_fdatawrite(inode->i_mapping);
 
+		printk("del, ind: %p, ino: %lx, %s\n", inode, inode->i_ino,  __func__);
 		spin_lock(&inode->i_lock);
+		if (inode_is_dirtytime_only(inode)) {
+			spin_unlock(&inode->i_lock);
+			return -EINVAL;
+		}
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
 		put_err = p9_fid_put(fid);
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 348cc90bf9c5..b0c2cd989854 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -44,6 +44,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	struct p9_fid *fid;
 	int omode;
 
+	printk("ind: %p, ino: %lx, %s\n", inode, inode->i_ino,  __func__);
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
 	v9ses = v9fs_inode2v9ses(inode);
 	if (v9fs_proto_dotl(v9ses))


