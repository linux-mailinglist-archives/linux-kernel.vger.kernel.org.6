Return-Path: <linux-kernel+bounces-292044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401F3956A77
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5AC6B26712
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C26D16B389;
	Mon, 19 Aug 2024 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HjjbDOOt"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0DF1684B9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069293; cv=none; b=mQWeM+7hitdHUD+I9MW8x8VT46WvLgpoF+fouXOKjGnlw8X7PVOZ88UisRmGAiD0YduLF/TlNAVv/j6M+6G6bpa0r9GLbLYvO97oFmcDqzw9fYMiZnRuAN+U/kM8IaZeXTVZE7HhSKPNDqNKQDO8I87x80R22AHA1v9o8Cu2M0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069293; c=relaxed/simple;
	bh=IspQebAavTU0pDdp1LzcbyVvohTrawkQFQUl9Jd2K4Y=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OleZ3uNS44/U5w84ggIRKKbHZ1ngstjl5skQmC/EwrLuUeWxt3r3GdNcVCDY10mmMzQeOmqKHJF9MJFV9WpFfTfxlS5u0OB7yV9tBK5m9XpagoXYkVsUZnGoCEOg2ejfzdjzH2m2LyPP+xaxAavxlRXFF1TTmRFSfig1PzOFRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HjjbDOOt; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724069282; bh=CxzdAZmYb+GzPCBp0FktRWfw2HNkazq2/tmzeD7tCm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HjjbDOOtqkk7xHyABa0RNHJ4BGmXv5agPd8a14gY74IgL/9E5m9mRaGXxx1X0kD4+
	 tFmMshdjVZdz9CdYeInnhH8BbH7VONF8ila23kMcsQmIquyrxe+HHUPTqFpMpc3j8U
	 tYXdDWamEsYt2WkCjc/mXR+7Llp6Y1Jj3vFVpPxE=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id CAA832E0; Mon, 19 Aug 2024 19:50:42 +0800
X-QQ-mid: xmsmtpt1724068242t04ruc7p7
Message-ID: <tencent_E137D8972436B24AC274C1761367D83C5D09@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieGsIzOrzWZscnseovEz6AC7KbbQUOSOJ9uoZSkrQ0jUrlj4xsJ3
	 +cO4Ksea8Mas9OpAHjm+vZkkXQHlMLNvytjkwF1FgYNfNM+EoVGC5boWv/asXLZtZZQ4ZXOelO0i
	 uB6UfxAOQ6zF/Ld5FEm2A6MeB4b7MtoTqNJYj2dVFUPVP2smBffurssdU4Y9EYM3I0EgPgbDOBIe
	 5yekdDwuZm6cmsfUxaRKjT0/M6vrgeXgd7m0TBftjBOyY4es0RAxF2snuASDRiESfgYXPDML70CE
	 wGsz8GFVeStm7tjccNTcqx7M+L0PsDA2dDyHlnNi63Vwc9xxz0d1lBPYXGmurlGIQ825srVh3W9x
	 f0FFoIC56WwuroK7TNnN6k7XnzTKFSfXfSPpeFk+Z6A3klJXgTUbMC1ltCCgHzrR7XTtbVPdnIBm
	 j6tuOwaAloQKv2Fnkbht4S9PtgUdu6sqcmJki5d+Gh4yUC9ftjXogC/5XIkaeJQ1blMnKjnMT4CS
	 Pl/gWhhOhfusVQpNg5QB+w8INmKIGUl2OISAOXlX7ZdGrTtTDAeJmDSFf6bJ1szln0ZUWXXhIHs6
	 SedP0AZ0CCKE4qC38UQUidbnOcJdGBvlauc7rxDv4CWuh3Eb+EAgjChophOsUNBATyrrZT6mGXuB
	 6vhRNqp/mkKKn891Uj3rYHTwtkCnN7vbjtCy4+cMcWs6or9BSTVCV0WUNn1v7WiIhgV/eJRP9dWn
	 STxY1QpbVyWvbikK+wR/7Dyj+hqdCylysnzR/yMyB4EI5L6cAAy1eh1W3JEmtncAedD51lSy+ucL
	 REKWxIOFSJncIYneA57VQtl4wnrZJ9fjQncYmuIMTkjDQpfp7WvgsKEGY3JQzEwYFWQvlIYMfZXL
	 jFo0MG99EkUXLVBvwFducNizZd+zvFakHSBqrz8xxmbO97RQQa+FXb0S4P3PhpnQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [ext4?] [ocfs2?] KASAN: null-ptr-deref Write in jbd2_journal_update_sb_log_tail
Date: Mon, 19 Aug 2024 19:50:43 +0800
X-OQ-MSGID: <20240819115042.3155983-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000742b9d062005fc1c@google.com>
References: <000000000000742b9d062005fc1c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Journal too short will cause ocfs2_check_volume failed, and will set journal->j_sb_buffer to NULL

#syz test: upstream c3f2d783a459

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index afee70125ae3..1ac19ac2ba2c 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1819,6 +1819,9 @@ static int ocfs2_mount_volume(struct super_block *sb)
 	status = ocfs2_check_volume(osb);
 	if (status < 0) {
 		mlog_errno(status);
+		if (status == -EINVAL)
+			osb->s_feature_incompat &=
+				~OCFS2_FEATURE_INCOMPAT_LOCAL_MOUNT;
 		goto out_system_inodes;
 	}
 


