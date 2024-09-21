Return-Path: <linux-kernel+bounces-334731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE997DB42
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 03:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567491C20E60
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 01:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300DA53AC;
	Sat, 21 Sep 2024 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Qit9LoGj"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8418257B
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726883665; cv=none; b=fDet9tIWIfCm8929fD3jYcKpjPqsU8ypmcAGIIwRyDrdGZtCO4lk+l/1VJSyQd/g4zF4AUIvf35O5gJZ9HcqQU20Qsa39hqaUoNw/P5z21ZXrgdzmn4v5kG95npUk4VAmjgGxrpZ+tTBrQ060dmOdtToC4U+qyjWaXJ2UK/R0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726883665; c=relaxed/simple;
	bh=7/8g2fuAgVMHqexzRbDHmS2bUPStYkoDrWwV+VcVOBM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lagLpNc3KB9xYTMxJlLwaECLWm0KgqlNkXEBXr8d6tJLskvVcY4JnlEi+2A+KDh7O43XGXftCnRkVMjeIs3Eon4weRXlqLoE9VmDoMMPdfrIzkGitcoqrrD6x+5bNkzd7L/HbEWcTux0vIbzPQYJs+gCrQIkCLCHzNLbZIfLD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Qit9LoGj; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1726883658; bh=UJiFXwfKAlpBJRYBa0OheelTVuEqzt+wTSFRaUaUYG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qit9LoGjgmMeXL2coP+97rPaqvhdSz9wc5Kpa6n/oH+kiKn8d3i+6pNoqJ23srDyv
	 lw+a/AQ5km/b5s/YUH1iEG0qKWVDz1ZDyZ27FtNreLWRoziEtRfbkFEK9jrrKgEoIY
	 85URqVKojc/fN66V4W+ftSKDEh6xxjUNDH9+qWX0=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id D8E2A6A4; Sat, 21 Sep 2024 09:54:14 +0800
X-QQ-mid: xmsmtpt1726883654tjo3above
Message-ID: <tencent_8A28BB01332A9E381B7A4BFB1BAB2512BA08@qq.com>
X-QQ-XMAILINFO: Nfm/+M6ONQ57hLVtYhHNwGPDLymwCYniO4ZEeGUKWTkj8lpEcbScnh1BWezX9r
	 tqs/BVz+oQc+79Cr0Ierz+VEKs0YsBnXF4xQbMnjJtYT/J7Mm5Qxdfl6AAcv5naolXdwxxkGpmnu
	 FvIn08XokgWp7jr0s613FtVIohSs41PUUs4SSiNnTNlghdp/1cN5JD8qi7e3+xUc8NmsnH/a4of+
	 OPAJ4HSA4X9iv+JFepeqEsrGF6gIsh1/nfeZz2ci4O2dBlUAFTMOsWdprXRyTATfoG/IW6dtBoGT
	 r/IDXuG3t7wyuM8MOV9xSGKPiv26Wk87EtRqASz6FuP+fmqyBfsn/nb+a8OPCqE2YcxYvrOkntre
	 gz2NEI8XEXOT232ZBmN6v9tMApu6Uu9rgKjN2Dc2s6TO4S8gCdehgAufJt1RMt476LrjryqPlXsX
	 Fqsh/fF5+PTowmmpQaT7GSlzanUp+kJuggECeibIQvwzJ2JR4T6nY+ZU5zGHDrdnOn4w6m3TAwU6
	 zGqANAAk7vq/xPEYgOQRvpYw+ELGwhd8/wGhm/Iy/lAOny+47j8Kq5b0dx/z+Ob8ovoLYjq1TlNO
	 sHY1Ve+3v+gLUfCwqfZnD9GQ7CFpG6zinrPNbq9O47oYSscOYmlVzPurS/sPetFLYDUANdDjr/gW
	 e37sX92QJW7sTGZepZZgc4JDzLuVaT77aJ2zs/s50FyGOuGRfJ94EK57Y/WfwyYOWqNDVHht6g/L
	 xwYcLnQBZvpLbuFws+3T6h1Gda6jfEZmDExNPKUd+HjJGd2xwZiR3h7CgcMy2y3vee/COVSQgWL0
	 NRadaLbAm/UMLnVwLNZl6HiMp4XxbgXlksgfnQ1aWqDtiwlr6JVUB2rF/GsMOyvIN2uUoFqIJfD4
	 qrQWTmiA/pSjSieJ8Xx9ZSkuOm8d6944rQ+15oMJA9tM7wH1o9c6gRkffEdulUkQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0e4e71041c9609d922a2@syzkaller.appspotmail.com
Cc: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] WARNING: bad unlock balance in ocfs2_inode_cache_io_unlock
Date: Sat, 21 Sep 2024 09:54:14 +0800
X-OQ-MSGID: <20240921015413.1196597-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <66edaf4d.050a0220.3195df.0000.GAE@google.com>
References: <66edaf4d.050a0220.3195df.0000.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove excess ocfs2_metadata_cache_io_unlock(ci)

#syz test

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index cdb9b9bdea1f..e62c7e1de4eb 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -235,7 +235,6 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 		if (bhs[i] == NULL) {
 			bhs[i] = sb_getblk(sb, block++);
 			if (bhs[i] == NULL) {
-				ocfs2_metadata_cache_io_unlock(ci);
 				status = -ENOMEM;
 				mlog_errno(status);
 				/* Don't forget to put previous bh! */


