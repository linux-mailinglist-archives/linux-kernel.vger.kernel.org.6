Return-Path: <linux-kernel+bounces-546755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA98A4FE57
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594611886F95
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5777220469F;
	Wed,  5 Mar 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ut/Uf62L"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768B1624CB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176877; cv=none; b=OheVYsgp0+7tE6BeRsaRVFJCmgfNaeqlPRME925x6h0I9x3p5kDAfJRJ06ain1JEOAjvMg728TFQEKeaGHtVXzmXiY2rwFOUdDqvbHC75DrrkoCdzCCtt+MTFfc0wK9xkl6XwBKh1JFhQCm0mLt6ucJ0/lrBgCVpqKmKuYMWok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176877; c=relaxed/simple;
	bh=C+aCoe3mzqCdsoUlP1PAuTWUiScqmThctUvTj2EF0pc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qCj+GKS5aC4AqvnXqq2ViCKQ4hGFeagdf3tKPLQwvJWQI9hOm2GkaADRTkbRrmG0/z6x5PP+nKmmox/mOLf8ulDmvPBEpJJwQVcD/PshLxQrcOveikwxObNNdv/cCSr045rlGaMaVaqcRb/5Sk3SKxAg9ZmhiGo88VVxGmuPmGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ut/Uf62L; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741176868; bh=AL4UTIT/Q//9RWdqkAY+weCmzen/56dSnVF4yF6yBJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ut/Uf62LRfq15IQShr3i/KJTRI+8AFg41W3Drk3vcrqLZcoPOCicvHiJK0kzP6AaE
	 Oz/2WHNVpWdbH/569VMY7986leJnGiRNKuScqpliampmXXGMGTfBGTZHvFWX8NOpL7
	 wYUNzoM1L2JArh9ALuWQlG7amB1VRbbix1JMYdAI=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 21224033; Wed, 05 Mar 2025 20:08:18 +0800
X-QQ-mid: xmsmtpt1741176498tf9194jey
Message-ID: <tencent_7BFC4CBAA7D1C6F652C1C660898EEEF5EE06@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3Uxh4ErHnOyJM7fgTp6eAKwj4hXvQ+xc/RomM4Wt0dH9Un0dDNr
	 We5w13//zjDFXmFuCxyNI+aD1weptBesgGvPrxuYs/xaRLhT76GfUKKGEEyJJuLrn7FQEXZhyfw5
	 P+gH6zlNb7zRX4nHJBXneNEEAsJ6QJSYuedDpaZT0+c8kt0WQg6xokReNGak0nouoP+NFfYpzCXw
	 tv4LtNSqAXl1sA9fP1tLNG7iENM6XV2BNQFuutp8yKrc2DP+ILm9/vxyUA5HoGJ7EVV3bQqQi+8Q
	 yzCBHLfSKCNoZLj3+FtIRuUV/huJdkcRH2tR08T5OUHmMTfQr3JbycazWfn/g55jCR8XQOQOBmdn
	 XnELdemZ1s88OWED+bU4ZSFx6UgPyFA/jDkwEEG0I4nV5Gwh2K7F6oJaP1ZTttZwWhqe8ZsF/6pw
	 YUHOhGbkCjuZW/lsvY4iRdi4skb+r2jW6KqLy+4rXYfDzucQX0mqDhrDeDNgZlV9XrzVLXmYcS+2
	 BhtFo7dRObxGD+1O5BYowboNtoD29UbEWnb1KpWPZQ8cV/wGDOjjkgel1WGJUie+oLBUzA6tIy/v
	 mlnb6VbwvwwAV7Y0RiIki4KtOg/POFx58NnqUhBx6EYatXF2RiycPuo9rZ+uQzxQCBUiY6BQggwG
	 lMcEQKIcQ20sc/A2fmSeCWYYCub8AL/tbFGG0mqFwNyGISyaQC2qJL4pSCNjV5zcSsUAqJ7VSEhq
	 N2dZYL/X+ER08c2VH4FuN8CVzL00maVjjDLPTO4LhdBOOykbegfFiTeEhwOWgCe0kyXzDm5wjFLa
	 Dj+1p+mpOnGNT8PXnvhL2hnavZwTBlLcZ+SGdt+R27FoRJrXs8mFD6PzsAGR1nhtxQs0MZww9qWG
	 bVMY5EZG+KnS9eQKMhreY6+3enPBJH420+oILanUkeUnF+RVNFiwY=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_cksum
Date: Wed,  5 Mar 2025 20:08:18 +0800
X-OQ-MSGID: <20250305120817.1427038-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67c72724.050a0220.38b91b.0244.GAE@google.com>
References: <67c72724.050a0220.38b91b.0244.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index f8851ff835de..6b7eee3c9f7f 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1583,6 +1583,7 @@ xlog_cksum(
 		int		xheads;
 
 		xheads = DIV_ROUND_UP(size, XLOG_HEADER_CYCLE_SIZE);
+		printk("xheads: %d, size: %d, %s\n", xheads, size, __func__);
 
 		for (i = 1; i < xheads; i++) {
 			crc = crc32c(crc, &xhdr[i].hic_xheader,
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index b3c27dbccce8..257abbe9c3fa 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2969,6 +2969,7 @@ xlog_valid_rec_header(
 	 * and h_len must not be greater than LR buffer size.
 	 */
 	hlen = be32_to_cpu(rhead->h_len);
+	printk("hlen: %d, bufsize: %d, %s\n", hlen, bufsize, __func__);
 	if (XFS_IS_CORRUPT(log->l_mp, hlen <= 0 || hlen > bufsize))
 		return -EFSCORRUPTED;
 


