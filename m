Return-Path: <linux-kernel+bounces-286264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3E9518D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41CB1F221D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7D41AD9F9;
	Wed, 14 Aug 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QUpzCwxj"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123883D552
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631496; cv=none; b=PwA4HZlWFAh/sdQX95k9qbrJE15PaCmY5zV7eSYHJmisJWG3e8/IdY3bWKFDjq/QhfI0rDzgo7QIaMoO2CRYFvStAz65J+PacSMSwactdlIByS47WF2hrih46ee9dIwEKhJJHvM3TlGW3Im+0o8pFDrU0aTokflpNI+4Bzzhdaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631496; c=relaxed/simple;
	bh=Tg4tygCQprfzp3BUYCzNkr+WKWJZYaNwG/OTPKtwaUw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ihZl5XmYmyaMlz3xejbFcqBkeIgBgO/hLH+7iOcmCscCU3zprZxC88fX9AbxLDEdCeog7VZi35g8MhBhXMeCQYp5Rc8bzInu4qhKCIefamut9PIt5LNlCb2ptOV2vUEPmB6PuCvpB5Rp19Vn7ElPWRzmkcSDlGa9o0yl35T3nec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QUpzCwxj; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723631492; bh=lKYEMxukreESiYpgKdIf+nPzxCncnsQwFLEmg00xCC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QUpzCwxj+k8p8/+mHOAaT9JWV+LqKO5MyKF7VQ93ysBnwjHNrBHvgYr+48DTBpgwr
	 iZGFCKEY+9FHtrKctlicUEvQTM6BxPm2VT4PSCT6YrKMOH6A50+R9zfXW94NU/m6pr
	 Jn9ULjJJkYp1ddKBn4z6wB2ibMxlpQZAJSuhBGts=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 65BAAC69; Wed, 14 Aug 2024 18:25:27 +0800
X-QQ-mid: xmsmtpt1723631127tnnin2zau
Message-ID: <tencent_82F24B9E1BD32515BAE8BBDB33A09E7F1B08@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/wsuTk5GiXDLU4WoPMD7zYaDh1ff2GDFpM9dReHQMkkj4dEJgaK
	 8pxbCjT7Kdwc2vmsTltHJM5iCR/TUQueDtReTVkZ32oBLu8rQlFQsEtbjuILLOlj20UTpc8zHogo
	 Ed7zmOwSZrytqMgnu8GBSZ8pV1sEmHLmOOOJg5c6RokON/mljjDltX3Pge5ClVUhX50a60fQvsV+
	 Zx3BWx8Jt4bj16aAZqJbbOfCmFIzJfp3DLJCj8vctP7YHZ66PpL/87AwAqJoj6n3/OZJuthM1g9s
	 /YWlyxPn3ExO3fRWX4K3UKT59cliX2ShJlQp1cbZlGvhoUwabY63jvqGZuhsORobvLjjVlu/z/gA
	 9ln9sCATrh08YstsAGSLXyKV0e5Ml3QhQ7tr1bijRAIYG/52Ymvnj0BcYOjhlLZAfDY4wmPVNkTq
	 SNl6ifOH0iAkj4Mml8gz3N4gK/RoQ9yqWZR/krNFtKA3LWWo2wJpgkuyOYGH5MbU6u0ZE9kQ3/Cj
	 dMiViytiK1kh7G6MdWguxlNvPmC2sS4mbGXTq3mmqvtkyXJ+OseUVtbHoh2Z3gtRbBdZeuLclZDU
	 U4w0wBsvKznu2S8uFHEND4W6ZSIdh02ccvxVEW8w8ENwDHwxJTaZYxg2/s+0KqJs30tj6WouDMJh
	 RlmqI6v0BapMD6LN0BdXWwYU5dCS7RoYkAXlMLFLI3abrXj25GiLGQHBnCHiAm9GrN6LfTFpUZAd
	 rsuxWHo2uRyevnoOei3zdByJrnd4EvNIdncgTycSwsXTQ+YonSTdNE7co7+iN6AwsssOL6fElkjP
	 cX91K/o8idh3VK1EMGVQ4UtqwSJBHGNQUbumqLTx6NwQI+DwZefH8ame6KDVhJ501dAtkp/3KEbh
	 zbvFWmZnJhAp8w4AQ1pLqleKx6IAsy7zcXad/y0n8REFTwzG1geYVRsMnxp4LH2qfx5diCkPxp
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Wed, 14 Aug 2024 18:25:28 +0800
X-OQ-MSGID: <20240814102527.1086693-2-eadavis@qq.com>
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
index 348cc90bf9c5..129354d5b284 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -80,6 +80,8 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 
 		file->private_data = fid;
 	}
+	printk("fid: %p, %s\n", fid, __func__);
+	p9_fid_get(fid);
 
 #ifdef CONFIG_9P_FSCACHE
 	if (v9ses->cache & CACHE_FSCACHE)


