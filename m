Return-Path: <linux-kernel+bounces-572786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49952A6CEB7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773433B444F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A560202998;
	Sun, 23 Mar 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wjp5SYyG"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900E5C13B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742725891; cv=none; b=HxNQFONuDiubKHfdthmiOsVHrvAyYVs4whYK+1pOLb3VRjFEy2izE4tD2BuAl/Guq+cIp+ApJzA0g5RXvFfdsfkmKaqcvWv3+0hcVs4+CyEpfSClWxsL22KKnZ8CtATfd2OZY4zsUsTsp8Fvv42kBgAYzfaL/liocJ9EDt2j/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742725891; c=relaxed/simple;
	bh=QF2AoGg4scdjGWHF1iTW3PLjW1x1Qy+EIJuQuxRWCIs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oxEIbPc9j51+hSCeZfs117JlZQg2MaBr405JJokqmoLfxOxjIl7JxxOI+uktMpa06VRukvLB54kq93yLNuVDFhMb6MXH5gSOR2nn1x9b6jz5o5m9kBj3uzBqS0M++MU7UFsnvLMokDX4PVxMtJsNIRd7iNvwT9WYgPvtXv5r+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wjp5SYyG; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742725883; bh=gPZ7ziPiLzQDZVptNglZpYyCmUeSKA9szXDAGJ1TCZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wjp5SYyG+C8LT5N8gdms0L5VCbkNQS7FGZvnt75x53b1bx9tbIOL6E79ktR2W6FyZ
	 MWnHSswlsGLJ7OTdOXC+ymNbxnrgIUAyG7nl68ws6PWTGDwx4qRes2AKsG6jbOizgz
	 TqDnsCe6FLvvTk2ZG8rnXoyq4B8t+ZQ8rM/v4kBc=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 446B280F; Sun, 23 Mar 2025 18:17:06 +0800
X-QQ-mid: xmsmtpt1742725026tqxfyiews
Message-ID: <tencent_2E6078366F502DC96E3897D0EBBAED7ACE0A@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70SJl5l0WEAPRClGy+Um0GYnpsbKKdrAkCdSfmmnt1W5vS21eRor
	 Q59xaO9UNjQA5rJJVHjAaTyvn3UUXHzudqJSvrOvVt8JSowDx+m5dlVsxVDPEo6/h5XlXB2c6XCI
	 1xEE9sYQL0AgskNEJev/55vEtWW7rvrjdLFDaggIkLLkyTWb5DYi9IQRNqJW9aBH8/x8XMVWRCdG
	 p79O7Er/xtByBNHs+UdDlitntVZE2UY25UI4I7nP35SD+qOLpntqaAIQYRrTtRbvEtRLckylTrch
	 6zxTvJbPUdwlGErckzbxUp+8K1sZxMbAiwzzmhQoeLnPcBuHtSFKMlC5/18v3LYXZT6//6XFEtez
	 Y23YMt7lCkGy68+kKFHes4eM3DCWwaDjd2mszJKycXoZ9A0a5XOpBbi+bvIAjAtKeUj3jgP4YJjI
	 OIIWYWDICFs2HMzk5uK+t+k8b2nf/1GNB9pIRNmXWqtRz6j9gnRM7Lj4mUPMaiIqZX+H9ZXi+jdb
	 FutUs3qM7ZGw8AZNps6MGr8vaHlMps1UGT221Nrz8Mz/d1yUxy171AnlnvGcgiETPwrl1v7qQ51+
	 Ne/lFpDJQXwmuIFbGKf+j82ioGfbWct9HacWTe09qSj8jSeM9tZ+mgJaV3kHmz2cDDKZNoLVnppl
	 g5k2Bkspm0XCH5uZnCq6ARKwnKMTJLqfnYSYqyMMohOl7NChd1EaoiqwD5l+FLEad+D3pp4zzsK1
	 thBFN+V00b+knSFiZIIGHqAMQ04J06Cz914gEPpcOvAi0y3M7LRx7VJ4PDBKQ5G/EXJOg0q0ZKkW
	 miVhE0JPsh14MShgTN/s+RbIUvsjmIG/UNGIo99IHBX37tHkHXr1QQ/4nXnKMImS111xAsjNzbQx
	 qR575YJRgPWcg2jtxqWDC55i4Z54Dkie/cmwQsI+chMERRYMN+r6g=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
Date: Sun, 23 Mar 2025 18:17:07 +0800
X-OQ-MSGID: <20250323101706.1245289-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
References: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 2956d888c131..a6e8376045b5 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -307,6 +307,12 @@ static int ocfs2_add_recovery_chunk(struct super_block *sb,
 		kfree(rc);
 		return -ENOMEM;
 	}
+	printk("ents: %u, sb: %p, chunk: %d, blksize: %lu, rcb: %p, inited size: %d, %s\n",
+               ol_chunk_entries(sb), sb, chunk, sb->s_blocksize, rc->rc_bitmap,
+               (ol_chunk_entries(sb) + 7) >> 3, __func__);
+	int bit;
+	for_each_set_bit(bit, (void*)dchunk->dqc_bitmap, ol_chunk_entries(sb));
+	printk("dqc_bitmap inited all chunk entires. %s\n", __func__);
 	memcpy(rc->rc_bitmap, dchunk->dqc_bitmap,
 	       (ol_chunk_entries(sb) + 7) >> 3);
 	list_add_tail(&rc->rc_list, head);


