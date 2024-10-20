Return-Path: <linux-kernel+bounces-373093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68279A5220
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 05:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393B328315C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 03:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535CA4C7D;
	Sun, 20 Oct 2024 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="U+loifyh"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368B2F2D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729395740; cv=none; b=gANJOv7oVWD2yLXarzEk8+6e9fST1Y6AiNbtmMZL0VV7ncYp6t+TEh30N2fHfjCyOooSwtTzRyxmw5mGeKb6qiee91XSwOoU4nkt/dVCIPnqIyVnfqPWWD5nrWzS+dPzga1XufvfkU8NuXFwLc9d5m+GjqYj4PVspvqomr3n/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729395740; c=relaxed/simple;
	bh=dEJQECuNH5ZcfHh2z08YOBGA5MesJj48c/xBz+Kp4k0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cBrEdF1ykgNb/kwrXc37JmM9gxfsyFj9BddygNCDGVxKWdKhT7mm+PIj1U2xxDLpGEJ30bjaunp9BNgjRD/5Q7C81fYHhR3G1ubmhpeARBAGpHqwrskHmPyNvlir0qgKHUSQIatwip8bm+RowU5zGHLbsbKla9mPMZoNytsVffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=U+loifyh; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729395734; bh=RI/8Mst8dYNyCIRIjKn8Of/Y5x5jHi3P+UX7Pnvlgzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U+loifyh2XonW4blnXjDcUoKMvR0teNSUjKflhIssq0PfinV+l9J9pLInu6cITf+B
	 9+hda06N0q3BaAZDimO4Hp08Nb8s+5ekWdXrRTzMi7waX5lqnmxjraxAU3FVRY9gJp
	 MRM5E5WIxBQRU6aRLDz6VgJb/4P1AFlAn/8LCe7s=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 9048A8F3; Sun, 20 Oct 2024 11:36:04 +0800
X-QQ-mid: xmsmtpt1729395364t11ghiefo
Message-ID: <tencent_97F875737633662A3CB3362E968E37E44A09@qq.com>
X-QQ-XMAILINFO: N26DAMVpW7UEj72reyQjlAkyqrclyuwg+jWyD1u6uMiAv92onm040UtlAdbcIA
	 F4kRCyRFa9mSQ9UpI+05Jdcmu/sFBeUI+CULXuysG7Q6kt1f/O0p3xd41bamFE8YRbUNHNlicMbZ
	 zuwNHVtyvKmEMsLOI1r7wFSe7H2YOnwMQPbz211QKs8Zq7TkvFgaHAlQ8XGNBAMdAoQYp6S7rq3T
	 OPBzoeX3yBHNKGpJSAk1BcCKyRIBXMt5pVCYEEgDgkwukTKyjSzH2WKJZu1cw2rKj7T/h8J32U6O
	 F19Z5GqoWH0aD0Ital/TpMS17Y51/BGS7XF54JB/AGdg35++I9D7DomJ+7hSWFF5uKMZ/x2sYsws
	 1ZzpdLRz8C6vMtJt4T2D/Tn+4YWjHK5rgfuIfibVn631Uxobq8Wh0cl2kL2K/KHEPrpUAoVD3Zvc
	 JmQkkLVUYK3KVXZMneZRVMwTI72zAh9dK40if5KSuEEAd2g7efvvJCofzXydv1ksCDGJlm8e3fjh
	 U2J8s926gdh3d4yMwoLtn5YzU3vhXtGkXxpecHFD6hBWM4OBoH2mV/m+rMCl5pmqJHQb6OAb9fQc
	 7qKs/qt4Wtyh89mtAG8Tr/6XmxiXd7y6wPMILeL8LTv3SKTfT6obVCzV/7Koa7EF/a6DWn3qKBPs
	 5OXGyrdhDaRKu8x9GPFyjTxNgiQqdkRakeW+qbekUh2NXsWf7dIl+jz5DbnLzkB78zxDRE3tZO6y
	 /FyBL1QzgJyZxZu9LGSzjU+wfT5W8sK2E1TJL5B7GJtHzlyjOx9QMV1x3Rt6lml0PKlmxNvBIwxP
	 DndHcrqyv19/ATmFaT/YtQ/XwLQUhagSP6ZEee9jnBJJiJ64VYJ2aklNA5UO7JRyd25P2ydQGUtq
	 wPNwhkdmqV+AIW/OrmQFpR8n2srKz//wSD4fQeo9bflKVkdFnc7KN7059u/MYYzR1SLIkgDfTBNy
	 lKpjix+3itHEbak9RS+04RsuGPvPqjh+LFkj69TClGtiklndISQTcQJxj+vtD3uDkiFUHwaaw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9ef37ac20608f4836256@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] possible deadlock in nilfs_dirty_inode (4)
Date: Sun, 20 Oct 2024 11:36:05 +0800
X-OQ-MSGID: <20241020033604.2327599-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67134033.050a0220.1e4b4d.001f.GAE@google.com>
References: <67134033.050a0220.1e4b4d.001f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make sure all allocations with GFP_NOFS

#syz test

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index be6acf6e2bfc..183c16ad8776 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -252,11 +252,14 @@ static int nilfs_write_begin(struct file *file, struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	int err = nilfs_transaction_begin(inode->i_sb, NULL, 1);
+	unsigned flags;
 
 	if (unlikely(err))
 		return err;
 
+	flags = memalloc_nofs_save();
 	err = block_write_begin(mapping, pos, len, foliop, nilfs_get_block);
+	memalloc_nofs_restore(flags);
 	if (unlikely(err)) {
 		nilfs_write_failed(mapping, pos + len);
 		nilfs_transaction_abort(inode->i_sb);


