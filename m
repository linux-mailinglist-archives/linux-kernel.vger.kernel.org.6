Return-Path: <linux-kernel+bounces-362719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F419E99B898
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 08:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8179B282632
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 06:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D85A77104;
	Sun, 13 Oct 2024 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ej3bX+Df"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A1C17557
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728801151; cv=none; b=VIvMnMeTLn/eZA5Y9y4XANkNO7aeL/GxULgPUCAshxYTbvKgczJ8nxtR7hsjwqF9TpCX8r0Cm2UMNUAp8XLqgfMVxFDdWAHUiDHkLOmD7+Reha5yOY5PoEprXb1v4qU1M+CFLo48x8mM8UGaO0iSWg6KahwCONjH+JQOkgtl+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728801151; c=relaxed/simple;
	bh=7+dOgtcx49/fQEvF7hM6Gh/KpvfePNXzh4+lbzLUt1k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dXIMuNKrDTrptejScEz6PvjJCFyCYlbRXSD/M691+vM94WG2PBe3NpGTHtlerLlcV/mp2b7Ghi3dLRW5ajzApJWbNpI0O/DjV6QJJ91G+mHEin1LtYgmk0mD5aAOV9R5bNDIx4hbyp8UAmXV/op3pB2G04h2VuQJbRJu+F4YFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ej3bX+Df; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728801139; bh=5j1nFwUMRoP4O40Gn/efBdjIEx+72pkMHcuGBMyU+/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ej3bX+DfIcmMJf+TjY6LYSRVRDT8XwxnY9u96AedXvRAC4BXKET/Gotlf4Jf3J97O
	 GFhpqhtCKf7wUvHU0jyJFa/mDp0/WIf2CMQ/z7K3zq82HOqBMgxaH/fgWpTh0XOsm4
	 gdARA64tQGyCBQT/DVDsANNne34B39UuSweHDEB4=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 4F42DA65; Sun, 13 Oct 2024 14:19:52 +0800
X-QQ-mid: xmsmtpt1728800392t5kfmmyox
Message-ID: <tencent_D10C2E5D6C0C9404EB3EED72CF4878F66F0A@qq.com>
X-QQ-XMAILINFO: MBhxx2BUoWsxiYHy1wjW4owB2zScaGdKpsYAbl5UP+HIP18HznGZTYcyOOz8Ou
	 /MCkLAwVaxWIXm3ts875mPmO2+3KFIsGPCzY9f+4kh/ZQJrJEwueRum998Xij14MAV1nGJraifKN
	 Ye6g0BbPOD0+jzPNQTZ5UTeB4nk3ZWuihLUi/gV2Yew/cBnn480mJo6hVQPvgYfwRACr44k83+xk
	 unRyytmasW2siIOmYJfJ2Nu1VdDRiyqA+0qYWTNMlRXK0utmWmaKwZTYO3KYS/H1B1/sBpdz2xej
	 wcgi1MO1TjvUyoOZEiYKFiFz4Gc8QkQsSLXpfLwwkx2XltfSu+YFT/WfOQokplnt9gxObVdE6wRh
	 51lsxeBfYyUghAtgiJC4nEyeSZuPgrNTTqJ2F09V1hIemXA1WEM+7Lu5KDs5sswjZD+nw8UEaTFv
	 D7IWw6+oqCglC3lKxWfSZ2/QJ+FPJCk2EfhkIowZCQTXMGYPbOcEW28WiPmGDf5btAd8TvIUIhxU
	 b13/xx0UCe+6R29mNvlD/xEb1G0L0iueoCxYXWnxPIH9EZ6cYu3dHkc3d/2gkHajer6piEx93eCM
	 6FI/2tfnJZioEsryQuoMp22xBUyF1S2Ni/Cl9qdPIsjEdCuKMfgOmYtpvfu5osbcbJLP8BTWJiY8
	 j4FM4B3tZVxNoYDN/DVfMbwmrukBsOHV16J+Emlc8kStdvowMRxludAOpY0C+ST2eNtX1klXZN3x
	 xddnsYO6A7IVZajeOu4mbKn/Hxf2oRwgtJvGSPXFSXgsvK4mImGsiPu0zOzVv8YIBkqDTHfs7OxW
	 k4Dh+5OhpqIeoVdvtzzam06vHpo1Qeti90YJ2DMBkvrrZZ579iQV5/3/+sSbHnpxSVRZMEC4BL+T
	 4jKFyDHBfZwleFPM3xSjtNN77UqGEbBlRJSiDZZZA3/kMFKWS5tkkSYlv5ruuS2w==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [ocfs2?] kernel BUG in ocfs2_read_virt_blocks
Date: Sun, 13 Oct 2024 14:19:47 +0800
X-OQ-MSGID: <20241013061946.2378266-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <670a46a0.050a0220.4cbc0.001e.GAE@google.com>
References: <670a46a0.050a0220.4cbc0.001e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if the value of flags is 0, it is meaningless to check it contains OCFS2_BH_READAHEAD

#syz test

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index f7672472fa82..0043c2428ef2 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -968,7 +968,8 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
 
 	if (((v_block + nr - 1) << inode->i_sb->s_blocksize_bits) >=
 	    i_size_read(inode)) {
-		BUG_ON(!(flags & OCFS2_BH_READAHEAD));
+		BUG_ON(flags && !(flags & OCFS2_BH_READAHEAD));
+		rc = flags ?: -EIO;
 		goto out;
 	}
 


