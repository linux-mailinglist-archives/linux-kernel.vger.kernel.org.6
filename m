Return-Path: <linux-kernel+bounces-390488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C291D9B7A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005AB1C21DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACD719D07A;
	Thu, 31 Oct 2024 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aCK+aERl"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98B199FC6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377894; cv=none; b=iLnvOGiYU87VTAnv9fQpMTFeplW9/YXsCsNOI5du/BMI9fYeyuXUnetkoJL8QSvIQY58s1WI3KYTuxqo2Vw9hSjCJuM4RGNGxOaV4GHUdEQLniUUexQfXXxqYmzCgu71YKWdmhPymxNiXUMkhA1X9PQKX/uBjfFLnyMqNEHtcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377894; c=relaxed/simple;
	bh=W7XCud9FVmMOcDLMFZf7BoQEUn20ubg8ErBteF5Ncyw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GEfh7iDlOKXPOs4NnYi1Urwc2uYIOkxCR6ZIoU1zw42ATmQuEoJsQIEqxXGZ58fF7eNNj72LVJ/OyLZUWj4xo6E8MnCvN/MmH7WzC/VCDQNeq0WSYfNkXY7BMJBhrZ98eXooqwE8crP3qHoF3WJ6WYZxN+AKluXIwrqhdnqVrLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aCK+aERl; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730377582; bh=ogJtfMREEClZkzD6LCbDgNaL3DgP+x5pkdyTbcSz+JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aCK+aERlkt6EVKH7ZAllKdgL1D1Kd66qRRC2UUHdFZADz+V6dP+yYoylmpyyzN7IZ
	 jWVsR65ctQN1qt6rFCAQ6a6cRjSn7nD7QWat3MXiLyo6LVY4kJHMk3LUv8VzKy2QmF
	 fS+QaW3ldq73Kct1AQc/Qbw/PkKo6MbpwYcTjYN0=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 6942C855; Thu, 31 Oct 2024 20:26:20 +0800
X-QQ-mid: xmsmtpt1730377580tk22ban05
Message-ID: <tencent_A26C497463A2045397695767E6D4B36EC305@qq.com>
X-QQ-XMAILINFO: MziGzrjZeogZIZukNVclohWNFMQ+rpvqrppEIZZym/YVxj/4Xv3ExVht33WiGG
	 qbc1V/BrKuaYR7Y7cW94UYxNsJbjV24btZ7PG/fKkr6vaQRd3XRYtKJ0Sif1+AxZJdULY9dbZGZC
	 q7TjjhwwjrTEC+xDjnVIVMrTHB4hRHv+5XG8gDztn5nvBQFhJbfk73ae8f1MT6pteNg4ICm2tA20
	 xjLD8qM1yWVFbrcxKeKWVALeBj5nojlOXs+OQ4v1o8XGP3eohLa8cNem7WP3kdxtRKFpwGGNk/FW
	 /3hMfxi3k3bNPqgdoSsy1FmIgvMF6cUxyClgSymqIVAIo/2ZawHgaCv3+1jhoTftP7RO558wh+Hx
	 da6VryLVFfclM8hJuEWKi+/FcwP8MsCNmBD1SWQkeR2gGjRXP1xzP9B9gG/iKfrX8WGnp2Wd5eKG
	 jilkFwdmQS5AFQsGJVOTMaHEfZf7FGxcZbOF39bQMLfcJaDopdvtnmPxNnDRnR3jOMItFQ5SNbBm
	 ZwlKhQBYVvwRHsr0u9RQNJRS82HZD1/5m9AKExEcvH4/z+5+24r8RW914YOWGcaNxrLdvoNhcTB4
	 7rd2tTns45IUGxF1cJjcyyhN253cQRtHROr9vzhrUVZTOm/v+yi6gEjta7yx14/JmVRERyfa8UbC
	 OJNphHTFAm60gaxN4jzzb8mKroqLl0LNMovQpiDJNql9bHtzeAX1UVnPV9f2tJmHm17+n9ae2OFr
	 XLNl6g6r99EHujLE7eg+L1NkydpGgAKBOGZlTRZjc95/VJWQ8zCp6vUbmEF5IpXuFGOA86HdwUjA
	 n43AMHtW7GOKHmmlaRgpt18T1T16wCoqRBIrSP9LpuNfTMt7my1AgaKXjb+A+DytB/FK2iVnG7kN
	 LHk1CEnKhOkgmKvFOD+rnls9zCTF6yOEk8L99pJ2lagsfzkroo0YA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9982fb8d18eba905abe2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] general protection fault in touch_buffer
Date: Thu, 31 Oct 2024 20:26:19 +0800
X-OQ-MSGID: <20241031122618.3831591-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <672270b5.050a0220.3c8d68.052a.GAE@google.com>
References: <672270b5.050a0220.3c8d68.052a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debug

#syz test

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 9c0b7cddeaae..63831711077f 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -32,12 +32,21 @@ static struct buffer_head *__nilfs_get_folio_block(struct folio *folio,
 {
 	unsigned long first_block;
 	struct buffer_head *bh = folio_buffers(folio);
+	u32 fs = folio_size(folio);
+	int fpr = folio_nr_pages(folio);
+	printk("bh: %p, folio size: %u, folio nr pages: %d, %s\n", bh, fs, fpr, __func__);
 
 	if (!bh)
 		bh = create_empty_buffers(folio, 1 << blkbits, b_state);
 
 	first_block = (unsigned long)index << (PAGE_SHIFT - blkbits);
+	printk("bh: %p, blk: %lu, first blk: %lu, blkbits: %d, idx: %lu, %s\n", bh, block, first_block, blkbits, index, __func__);
+	BUG_ON(block < first_block);
+	if (fs >> blkbits < (block - first_block))
+		printk("folio size is too small %s\n", __func__);
+
 	bh = get_nth_bh(bh, block - first_block);
+	printk("after get nth bh: %p, %s\n", bh, __func__);
 
 	touch_buffer(bh);
 	wait_on_buffer(bh);
Upstream-Status: Pending


