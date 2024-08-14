Return-Path: <linux-kernel+bounces-286193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2829517C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAF81F25193
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F521448C1;
	Wed, 14 Aug 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xy87WijU"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F53CF5E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627926; cv=none; b=pxZqx6XVCHZGLgbUjitcdxRsa6F7cZUqYrt3hUucXBrKQrstolZaIavMKvkSb/gaawC+GmqwBA2bm69AK7rWipzeze+4HoxQqoMM66KnuU+vveCmMxyKz352wt2LzW3qWqRkzNACC5hXHYX5uDdfCw9zHh6g5p6rN+PQlK3FczQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627926; c=relaxed/simple;
	bh=7K1wMLTsX7xoRiV2EGWLfmS4OgCLAEdJHKEzZKgzXg8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mSZnMKctZcpLbrU3pgYdzb4LA4t0IxRHrfXNcp5TnKDatUgV39CmIL8ejeQtAF2I0Qei90E4D7XJxo0vfBbxMnIT/WtVOaWYOrHrDYJxaRCfCUAw8rSJSJz1Jlt0B7K2ywEOLycVsXZn9xQgj/bjtpQYB5CsZXmegXKBaPWcid8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xy87WijU; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723627613; bh=BjWm5iNW6k12cGHitMBH2GV92WfnpXy1msZhJDgkWs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xy87WijUcu4+bjesxdbUY3w9WaKLHUkaeLDT12HViYsBQLTHNPgsoCdxYdt5Z1BH5
	 56FO6suFDqTbXe5XtkmBw2FwJZj4AzpbcNyysQ/L+obzOSUeAQSug284zXj/TekazX
	 5+lBqJfFnPHVneqE1fFBmMODm3pwMLjjyIyfScn4=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 6B395873; Wed, 14 Aug 2024 17:26:51 +0800
X-QQ-mid: xmsmtpt1723627611t4ll7hh0p
Message-ID: <tencent_5D5C3C9B368696CC37D64A8A755F77196609@qq.com>
X-QQ-XMAILINFO: NY/MPejODIJVIqbu1gSDHSOAM7fPuif85TmEWB2TZ/Wuk46c2p3Ue3SwYhvTCM
	 078wlgS2zKbB2pBY1RmVW/mDZc60oby8r+toV66u3XokAvkp0m2C9fyAFe4OrNfCerg0Xv6Uz+QW
	 FJ6EzK151PdY+SKkqcFYg04Opt3+Zm/XktJySn68uGz5GxrQfJsu/NV3hBpDRmhcvgIede8wEQPX
	 rFGnPSG7AfLEcyxW50I3l8m5iSwzrfIxB2bQ9CxUf7DrQJoRzVCxEC3B5zBFppQvnh7T+iJ3Stj1
	 OcCDQEvtGo9cE5xSzS2bJOWhuNqxRTL2U/g2Qw+2LC5KL7oVnb1r55VvXDzsygTCJl/KQyoHEtot
	 UsqY3lIaGNU7jOBibiPN7pAgdO+rQrxpWS1ppTY68TD/bcKjjuh5QtGNveQSLElJDXOIfzDFmB75
	 yw9UhFv2Maj5NouzIA/lDxDvvt4RcXGLndq18yHpTfIWKN+N5h5cRDaVfSSJHrbOW7MruDovYIpV
	 PvbpyUltyfaIPZTnOFbS6oAvVJ7a+T6aNsMaVgk1w0zUSpTQu9y+B7/YhDVL9DNCP6Y4LgNkJf25
	 5vypNHSdJSlyvx7JFd4BLBXblT7gtJG2ZkqMVVla+Bxv8kIjY3VQ9/1nB1qPQtpfYD2Q9kZxYAnW
	 A3Ea1bp31NqTc6AhlYO7P9GKz5Sr+9wAli/4MdHX+klJlUHHnT039MRpY2oT3szgdhOofLt35KMO
	 OoF1JUQ/NVb+KEH3RNMWOqv0os0RyZKEU/uyX3l0Jno5ZmOkjOtIQxwkL1tI+eDeQW7ytex1z8Qq
	 KVhUsvhS7SqaxC13BhkBncXPVZMO1HrlN4+c6YQpW/Bsm6T5bN8x9sDIB2mW4PSlybMPrFA8saGF
	 G6BYWkqUVsS/XyzFkQR2dFneWDdt1Vj/AmBJEFHwt9OZGD7yfZZrFoTrEde/QP3Q/ZC/9PIc+p
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Wed, 14 Aug 2024 17:26:52 +0800
X-OQ-MSGID: <20240814092651.1028802-2-eadavis@qq.com>
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

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..cb511d49e35a 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -218,8 +218,10 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE))
 			retval = filemap_fdatawrite(inode->i_mapping);
 
+		printk("fid: %p, %s\n", fid, __func__);
 		spin_lock(&inode->i_lock);
-		hlist_del(&fid->ilist);
+		if (refcount_read(&fid->count) == 1)
+			hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
 		put_err = p9_fid_put(fid);
 		retval = retval < 0 ? retval : put_err;
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 348cc90bf9c5..acee5f6570a5 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -52,6 +52,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 		omode = v9fs_uflags2omode(file->f_flags,
 					v9fs_proto_dotu(v9ses));
 	fid = file->private_data;
+	printk("fid: %p, %s\n", fid, __func__);
 	if (!fid) {
 		fid = v9fs_fid_clone(file_dentry(file));
 		if (IS_ERR(fid))
@@ -80,6 +81,8 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 
 		file->private_data = fid;
 	}
+	else
+		p9_fid_get(fid);
 
 #ifdef CONFIG_9P_FSCACHE
 	if (v9ses->cache & CACHE_FSCACHE)


