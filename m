Return-Path: <linux-kernel+bounces-293931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B969586A8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5FB1F25488
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7AD18F2FD;
	Tue, 20 Aug 2024 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vXwja2Sl"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183F18E353
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156049; cv=none; b=jA8/m5owTFGrqWr/zRLnwvUpXqQqfwVooz7nGDEhqX/e/dI8Isd9OcvSIawE2d4Aqv/qlW9TmprZASTOMVeqUwR0bJ20zvrCPyXxDQiqX61CfkMs83k1TE4Aj4lDhswuSEGfMpzvib5K+VZokiKrTNnHLvihx35/CXTVVifksk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156049; c=relaxed/simple;
	bh=S50PeNGLLYC54M5FyDXyqvjnu5GWYnNr3f0atY4Z+so=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=f8qpkojvRCIrgLQ4QW7lUkeWg2GCR7rX6VFGHRfk/IPEpC6FP2GZhtH89Se5Zs7sQ331abfgErt2tNrY4jsDDRwLqoy/z1QcC0kNbBxLBZY0IttBfJ9h1yhORWWX4PxxKzPYigOwMiCQTO3wut9v4J+CNaBPosDS22dHWeSFB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vXwja2Sl; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724155741; bh=46r17CzYPvxoYDwAKCyXtsfXX2O1n+ZtU/svMrYG7Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vXwja2Slvvmy9eUhfbNLz4UP2/vbAuU9ESYdAMHOb+ildJnNshVaTDWJj5k3yRs15
	 ZleXgUSa1kqiT2yhcKgXVdplgPRIGtxKt8OG3gYuDS1QpbJv4clLZyZPLi7hLS+w0P
	 tMbF1GGxRQJT8Fgn6CS7VF+7XkD/onkccL3iAwNI=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 23A1CEDA; Tue, 20 Aug 2024 20:08:58 +0800
X-QQ-mid: xmsmtpt1724155738t6m2xanqe
Message-ID: <tencent_EC9ACDC0793A6F742D7D6FA094F0E96AEF0A@qq.com>
X-QQ-XMAILINFO: NfyThBV/OCX5milxwBW/FlfEKiZVbdflebNR9IzfdiZ2orYiq75o+/rYgaaAbK
	 9hL895WWGDoXGn+8G7uZFj0Fu/ph/Qg/Ee0yHtTZC6WqbmZBLMXvtw2eCoffPSGoVAk37hpC3it5
	 WJsFRmQaTDsi3uux89KvDqQuvXLOKYkfZbTRQ6pcCzB3X1F2mjIrEE0Yomm0Ox2Vg1kP5rALcJkO
	 U6lpkZW+DH8gnsX4qROlUGchmd/u4o6pjvRQ8dDXQKOts8Xb7svpD3uC202wXiuWI1878qljMPAB
	 wujU3MEL53bd4q7dy3my9E9VyZxcuZ5EYbEMeuLYnVCQQwUK0II+3OLgShgAedn6IyO/qx3mBYeV
	 6q8QY124re/q2b3jos118HViuG5psUCUMvDlAaJ4W7KEl9FzPEQpBucLODUCuy+xUHWq8bDmQSfz
	 l2kXpxVNmrCy3XIWABtX25Ooce1/2CNG5OGCsx0qYQKswjdby5Rb5QihPVJEJTYWR5ZTJ+4qTwme
	 y3pvL8ftb2zjIYZNmc8chLw1+BNn57ZE1Nr4I/AkJ74dkyKcUtI6GZ1pw7lUW1h/cFFRFxuCCxBK
	 vsx8TW+dAi1dpqXLdNy2Iu0mV5StXYWhxaLrckGS6OGpk51K0NoiXhC6v7T142Ie6GfcLIBzeDMA
	 ix0wkPT9DwNU6LoEFh7UbXBIzFosDzYxj5Rqb3vWahEKIptnsIuujXl6p2QPoKrc0W9rHFiLc6FY
	 6RnAsacCf9lLkHAFGZyiok/jCl0xESSNylJqS4YYSVK0YatL7uhcaJaqa3w/LS+pDVhm/fTj3S9I
	 vhE36AW6xuPbaz4fGqzS35E77ecEgMBkH1U8tcc7IYsW1v6sNIs7d0pNmmb+kAfDke4tFDutExaL
	 DUegdoPRshE53zp/YyeXudLCJsPI5i2pPhWyjqZXgwKzYAevjEwf+bm2OMnrApfZvaFCVHUYZm
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com
Cc: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] ocfs2: Add i_size check for dir
Date: Tue, 20 Aug 2024 20:08:38 +0800
X-OQ-MSGID: <20240820120837.3948179-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <0000000000005894f3062018caf1@google.com>
References: <0000000000005894f3062018caf1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the i_size of dir is too large, it will cause limit to overflow and
be less than de_buf, ultimately resulting in last_de not being initialized
and causing uaf issue.

Reported-and-tested-by: syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ocfs2/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index d620d4c53c6f..c308dba6d213 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -3343,6 +3343,8 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
 	unsigned long offset = 0;
 	unsigned int rec_len, new_rec_len, free_space;
 
+	if (i_size_read(dir) > OCFS2_MAX_BLOCKSIZE)
+		return -EINVAL;
 	/*
 	 * This calculates how many free bytes we'd have in block zero, should
 	 * this function force expansion to an extent tree.
-- 
2.43.0


