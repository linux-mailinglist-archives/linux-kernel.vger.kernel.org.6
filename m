Return-Path: <linux-kernel+bounces-376211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB129AA1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CD41F22C93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D27219C553;
	Tue, 22 Oct 2024 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MB9m83L3"
Received: from xmbgsz5.mail.qq.com (xmbgsz5.mail.qq.com [113.108.92.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F26197A81
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.108.92.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598550; cv=none; b=EWZrw8u/0ylp5h8nQTOvO32Hw/KUe38qzX38FjShnT2D0fu919js50OGatIk0CEf3bL9nWigbNfVLBg2KOlRqBXo9fLJqHw/N55EkcNBXvne8u1IHQXP5vcvfqqctQd7P/pe0PPP8bU5acznCma6vg4cFCii/VpLQbkZS/4Qvmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598550; c=relaxed/simple;
	bh=FfMiYOthHv5ejeC1MKyXtIk5JKjmg2uFBBGggAcW34E=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oRqdqide6Te97d/M1AtF6fvqIDgPxaUIc7BvaERR6IifE3jkJGN0+EezjzRAHjdFePZkxVH1BrTZGAZhofhuHF3sgIPBGax9DTSzy9T4ANetGWkcF+OcA/MQimRo083CXssuHZSCSr/ZcLLi1P8MVapgD2QQhiD/kPL5zgtKgIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MB9m83L3; arc=none smtp.client-ip=113.108.92.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729598544; bh=gWUpfejarJXQzzLNwUibvCdYZYVYYe5lWx8Ue+0vVnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MB9m83L3eOsy1/mVezV/GqFojU2lba9PbW9dcySX67LQKC5viOm+jiBXuw4Qk1uWC
	 TVesoqDi2EUvk/ZJ1bsva7KKkdEKKvtxH1dvxsBlO51YJuZOzrKWo4JhWv6cVzjK1O
	 M/GNvXuZ7RJrtkU+eF+/wB6R13jQ/Od6D4+GRcY0=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id D5092405; Tue, 22 Oct 2024 16:53:16 +0800
X-QQ-mid: xmsmtpt1729587196tg8h9o4ab
Message-ID: <tencent_C037D4960236004B087403760766583DD909@qq.com>
X-QQ-XMAILINFO: MdoRYM9mYrydGtE1K4kxJJ6d+g2aWYXeWQkoYTIXGXZqoBzMzx/DBar8tNx6mM
	 XJF9DQ/ZO+PcSbbqpt9avVHVpQ+PsZTmiZYzh1+ORy2ZWhze0iOl9bIl1rG+yB3wXZ8M3hPYIHYT
	 /FRFLDrlaEOT0fvTEu72iUj1uOBOEay1aQRB3MUDnEwfaqB0Kh/8Uo77fuPDlq7jKGjH+KEx6n8t
	 x540/l7TeyuCnYiRrmjobjc37zDFf0IRg/3MRgNQRzIHwdBSF6DkmjqJ9AIrQAYXx7T94l7PYphF
	 Hr911/dEIIoYl9FX1FMq/4joMpSV629IJicin2zM+7Ndk6EzMhgb52CzDy3QiH/Ph3tahSYCY4Dv
	 S2s5HaveI1mToBvhH/3XOIn4YhOlN7FK/Rf1QncGzmQM4sZV1ltmsMzEGtPnVjEgEtfpHH5aHsjR
	 INCrDFU94FuG2IZrIm5RqaTs1+3CHyRwGylNn6DWEhA2kPk7jNco6qgiSriBmG6DEmsQZwrtwoqk
	 CpJZaCinLguKEgqJ3Cc2LZmb7VjNalH4JLcGYpy205PiuWq9vHlejfdOe7WrfbgNjRwE7z1k1c9S
	 4qYAb1LWABhe88EDbz008wcPdZ/Fui74+9VAIKiKsA/QUmiJCbnAcSFmsspy16z3/nv2nsyzA/Yl
	 A9mauwjjLwzEX1ogTMsb7dJU3sIcujMpPA1m52xsXTexjYQZYS24QCUp18aD9RxpbVInhMzOcLFW
	 /k/0RSCvnCICBQRCkMAXRiyelLUCWjFp3BQtGP7zSOjz1utBwqCaOjmM2C00EMUUUN0iYZ3BcJRf
	 AErOnXtCiXFAGAFzSmMvSjj5VfNJ8vmYlFLcInnm1uzRJXwPGkm3Ny7oDns1NOM1jPvK9Yy7JU7K
	 MAvRKiLXJlyP6VVoYGcpdx2NdRtyKce2jGgjfv3c7C8BHof98uSXv72TtRBiWquCctbVq1T5op8y
	 4Ehxjk4QwCL3XqNJffKzqxNqdF5Rhz
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a234c2d63e0c171ca10e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [serial?] BUG: soft lockup in debug_check_no_obj_freed
Date: Tue, 22 Oct 2024 16:53:17 +0800
X-OQ-MSGID: <20241022085316.3522726-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6713d23a.050a0220.1e4b4d.0029.GAE@google.com>
References: <6713d23a.050a0220.1e4b4d.0029.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maybe we can insert cond_resched()

#syz test

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 5ce473ad499b..5cc5b21ae71f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -975,6 +975,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 repeat:
 		cnt = 0;
+
+		if (in_task())
+			cond_resched();
+
 		raw_spin_lock_irqsave(&db->lock, flags);
 		hlist_for_each_entry_safe(obj, tmp, &db->list, node) {
 			cnt++;


