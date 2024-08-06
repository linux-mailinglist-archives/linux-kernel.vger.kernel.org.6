Return-Path: <linux-kernel+bounces-276058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E7F948DD5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3676E28355C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351521C379E;
	Tue,  6 Aug 2024 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="g6//r6h9"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C661625
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944436; cv=none; b=kwV6hexyd1RVU0XY9UE0pCK6d/CnzsRFfyByfow0gK12NcJ8mnx5yqpc8WSxFmNwyejCfgmtyIeF/lw3rGniNmsrppoxaC/seqbByrqHiI0pLks/kSVMqsdp7AdOyRehZSQSVpBEM/A8WHi7/ZITm/4s65awkT9xqjTI4ZXMOqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944436; c=relaxed/simple;
	bh=n0OObZrYN4bQLUPGSuiMpQRkgQEnLHAgD/HWVtcqWNk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cXfAcznv1ao5QQIxVZ7CLhcd21oMMF1nPRMWI9vrocssMCTcoWF9/+v7/sTRoaLk+eA0C6EF3cCj+OV4b2Emy4SsPyQVIiYYzo0yOl7LWeiry9Em3CIXZzExubAF6WUxu/LZTCShqhVhdO9hnCnOnd94mP9av722CtXcX6fuEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=g6//r6h9; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722944124; bh=wHurUGFO8xBeT+iiiHYJlcpo/EERCB4a4RoP2prTvTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g6//r6h9oIiEM9MzBsF7MoBbcSYD8NbxpU8t/wNShTV0WzetiKfbQWXXLk5sz/VMK
	 ukjqNc2iYiPtIfevowLmNQuUjUOfxNS68asW8Vy8CEpJZArkvVsRG44bwn7vW11Q6l
	 Cd6OVR0GiSj3UD5F3GAEnd84BeV0SK6sIc7Uvgw0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 8D680AF0; Tue, 06 Aug 2024 19:35:22 +0800
X-QQ-mid: xmsmtpt1722944122tvznbm41h
Message-ID: <tencent_1E67D386C552C806488981AEDBAEDF8CAD06@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+z2/XQPWS9ixDCt3fzqbm5BnEFzxDFHPwL+NX1tfuN8qlb8UIlOF
	 PQM3cjcaERpT+Y9WNfhoTyhjPzwXQMGwydAWkRlHIl8dx4fiCyO1d+31AtMRjzdQwZp9RGuOfnkJ
	 G5bR4UjTJ0Yv0fRHM8Y24jOEPjKfBsJ5I9yHhUc97zEZy5CxQMyeFXfyJHI/4esq4aU7iSyWsk4y
	 2HxeXpO95gRUxVzYRZQWT40iChYc0eLLBL0ub2nUubn8vobZbI4Lo2wsJAf1T02xyj14KxcfRjES
	 OeN+XfSq6Zu1pUr0RbH62V9DhWLYz+ZIVrevChBZVc8XoU8Ji4KkDfBVnIR4zRqu2raHYjnmtLFu
	 VWsB+Hg5mp5BVAZVjzi/x46Hn84uI/InqcrdhD/vJFFFlQtbYIetFNVyXCWw0rLiPhPrs1NDUCOf
	 L/0p6wjiuay/zQGk8yFrDL+XVx/dafir+5vXIkWRmgari2Lyb83HZxQTpVCpuasklXburX2+kVKE
	 oovNq/j7t0yNByme5Smdk3AJ7OD5ZNZtqYiw5bJcnaOD/3w1q/wujxxbDDMiMBX398P2x2XL+Umq
	 /A/XeWPgpq6QWTAoR+kRcceTOceo6MVDVZv+ljUuKle/CY4AtXov2tTPEs779FEqiYoDo8yF8jBP
	 mOzTdIp9ItbcxBT2QKA6TcIG+p5KSaxVI0tyWZBkTcjOEeOSF1QGTk4dPF4n2T3Ph5s+eMplvjNC
	 QVZY1gs6570xc1qEhu4LH3EhslZlIIf4ejKZArbbcmCW0YW5rTXH5ZIHtDurplKDa+p0XRSkUKJz
	 6hXh9YHu4hkw34AZ10aAcMs9NhiR9c+UsohEVuaao0sFDoTtWBqEbBOKsvT1USiODD4EFEFl8Dyj
	 tX8sBeBCEJ+4LLGgMch1V0GOvgZm/3LjpMuzjTL7wazYI7o8QANe0=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Tue,  6 Aug 2024 19:35:13 +0800
X-OQ-MSGID: <20240806113512.3720620-2-eadavis@qq.com>
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

Is request writable ?

#syz test: upstream c0ecd6388360

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index a97ceb105cd8..ac69716aad07 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -33,8 +33,12 @@
 static void v9fs_begin_writeback(struct netfs_io_request *wreq)
 {
 	struct p9_fid *fid;
+	bool writing = (wreq->origin == NETFS_READ_FOR_WRITE ||
+			wreq->origin == NETFS_WRITETHROUGH ||
+			wreq->origin == NETFS_UNBUFFERED_WRITE ||
+			wreq->origin == NETFS_DIO_WRITE);
 
-	fid = v9fs_fid_find_inode(wreq->inode, true, INVALID_UID, true);
+	fid = v9fs_fid_find_inode(wreq->inode, writing, INVALID_UID, true);
 	if (!fid) {
 		WARN_ONCE(1, "folio expected an open fid inode->i_ino=%lx\n",
 			  wreq->inode->i_ino);


