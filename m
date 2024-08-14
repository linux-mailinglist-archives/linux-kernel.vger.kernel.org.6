Return-Path: <linux-kernel+bounces-285676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB625951124
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF821C225A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2D26138;
	Wed, 14 Aug 2024 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xDS5o1nN"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ECA171BD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596529; cv=none; b=ebwAMBxEli9gxKMV4lOhslc4IrKX+FpJKcu5AInzmD+wer8GZeve0XLLlQRC6477wfxOUSKoAdk6E8843PZhmB52WWFQtkUAsa8BE6aW0O39IuDNlbUKeWUVlYplVKh/erO60470SYopOrmkzbeXfQNntKTlNPgLx2N/8Q+Mmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596529; c=relaxed/simple;
	bh=X4ExMNxpVsvVWBViy3HcN02sAEI85e4xC0qae/jvwAs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=l/UfRrMjsHlnmFZWkYmGBxOPVzsJBDwMEjD672UnJi9UQigFoVyhiO05xnUULpxDiYre5QD1fPp3QPA9zVDq+N7Q8pSySF5SCF63JbZtxFkgTHbSWMjNuS81/5Cz6smbOppEKqhimJsatW6Xfa0yTAasAeJFMggfrKhNw6Zk0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xDS5o1nN; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723596522; bh=ReZ3OIVJJOOm8FhpzgeIJ1dbD9yDoTF40FYLWUq7Uvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xDS5o1nN56kznkxQLWy3W/XoJPlYs4FakzKOLnLdkuXsh7EAwkKlGtnQ9Iqfj421S
	 9CXDDNJJqwP8t+pnq8JZG1+lzxhoT3MSBgxhitA+0lXfqPIfsrhvmwLwfSXD/cr/eW
	 oetVfbUBWGbtk3yqxiJlCENfNkbUuCUTtZkIcNmM=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id C273AAD5; Wed, 14 Aug 2024 08:48:39 +0800
X-QQ-mid: xmsmtpt1723596519tk48o1yxq
Message-ID: <tencent_E51B7925E5BAF4BBCF33739E5E1BFA4B9F08@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTquzbZ/8GSd2fAmi23hj0naTp7q5gZW9S0I57UXV636KKcIAkjp
	 U1T587HOkaeks4nDPFBfeI5oJY8v+H7WNBQXsXZKZZW6VEzBOymP0EbzmPbCAmcnL/NVHKT0eQ5J
	 Wc7WsOeMwUJjnTVzdnyBM14qxqI6+QDmaR/0dakeNequ5dB5M58kmDkebDvJINuY/jPbhTULxu/e
	 qHxbbmyA1+zvP8oUTiKXU4gpO1ePrqDa5NauKGf7Bu6MHuW9PXjdNsVI9QtFFNv5qGRP8+9nn3sB
	 MAvVp82qwB8XKN5ctdkVypFPx79uaHBgH0/93IMOMC5TNGv13kFe4cv8WcZsRtXn7Ecbo2qvGzXr
	 qvWHmKcH5X3K5VlugL1TNayaSctvwg0K3UaBkMGXlEZ4tTlvrqse78JgQm0VzkNWyRKVQxRMFKPT
	 Hu349V60O7E3uYTV/6Ihpnslc/4jY9fNHcql3sas1HtkOc3ON4nnrkpOk1EimyqS+547SEu44jLW
	 yeyJQnZehVZCUQXT+5GRDfyOG9fDmqcoIQqXhtMZ2Dpq09s4Mk5tw/b2xco6ZDc5soM/701s4XT4
	 Pj/iPAVEPuGrW3AsVsP3Y+EaCqEBTH4tQbCrcCUG+pTmqiASkSBsTDnxUabOy8orLluOME3UikHR
	 DXwQkJQN32ezW8J6CMgcxEN0aPXdgT49Iw+KZ88UqSwB6U+rjzw3PyY07UiMCPdjasLFIaMQ+vlq
	 a3n7Ekkw1gI2dAS/f51KCAUYxS8wnhdFCFj0ELjdRklRGoAIZx1AaxJg1Acq4NJb6zFShsPtgPzj
	 g9WyC7DFADyzz1HsMjLVrH//h8Af9IbwcsfMAu+et/rMTIfi2wELheEZq6uWuLc1NcjaW9iud40X
	 Nt6dTIQmo5aDU2lwroN/y5uHbeVKX0yFS9LjgcsKdpw9Q10J2dTAXQBGhsLh7Y2l3peZYffdxaUT
	 0IDVJIhGmnirVPxVq/Xq5MNevAnAxvNuxelzq2fi8qEB4DqrQvDw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com
Cc: chao@kernel.org,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space in f2fs_commit_atomic_write
Date: Wed, 14 Aug 2024 08:48:40 +0800
X-OQ-MSGID: <20240814004839.504138-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000ebae95061f96be85@google.com>
References: <000000000000ebae95061f96be85@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unlock i_gc_rwsem[WRITE] before quiting f2fs_commit_atomic_write

Fixes: 7566a155c666 ("f2fs: atomic: fix to not allow GC to pollute atomic_file")
Reported-by: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com

#syz test: net-next 9e6869691724

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 741e46f9d0fd..a43054ab0cf1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -389,13 +389,13 @@ int f2fs_commit_atomic_write(struct inode *inode)
 
 	err = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (err)
-		return err;
+		goto out;
 
 	/* writeback GCing page of cow_inode */
 	err = filemap_write_and_wait_range(fi->cow_inode->i_mapping,
 							0, LLONG_MAX);
 	if (err)
-		return err;
+		goto out;
 
 	filemap_invalidate_lock(inode->i_mapping);
 
@@ -407,6 +407,7 @@ int f2fs_commit_atomic_write(struct inode *inode)
 	f2fs_unlock_op(sbi);
 
 	filemap_invalidate_unlock(inode->i_mapping);
+out:
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
 	return err;


