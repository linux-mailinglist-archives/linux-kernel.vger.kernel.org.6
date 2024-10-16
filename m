Return-Path: <linux-kernel+bounces-367185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F22A99FF95
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA10EB23B00
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A907F17C234;
	Wed, 16 Oct 2024 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CN0CLsC2"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7AB21E3B6
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050035; cv=none; b=Yg6cB0qunno1//+QkIADu2UvGC/EZcDG2YurM6pvH7yJ+vY6f+hfGuKnCHcYBbrN/QAsl2v/XU7cNWvo5rsZsBbJ2H1V/auAmA6SdxWZOqWc24EtinVjCGxoJzFnN+4bjTT6Qt6qwukMDfYzjeYXk/kMqv3A6+1DqCnuvzbLTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050035; c=relaxed/simple;
	bh=dWuQLFfpl4oe17hKQrx44TE/dGKZUXtC/nteCoi6AW8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IkeqL6dNfUSf5BYt66vShNZEpMc4vyc8OnqLsKmHJ8FBhiZMC0RMIwRJ3d1fQTSBbdAaG5oJ7HLMWzm0DomV/XMvBIJJQTlbB66OptH6JV/jMpNmdpQsONKHCxe/zjLe/dMLevyjLupVAD09s4JMFRVLMqUrIbqCGZgNIogWS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CN0CLsC2; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729049727; bh=J9VC9fq8bPBfap7xHfzuAW6j8vD/eAImDgKaz8KugFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CN0CLsC2Aa7FnUw9qHXdh7bVEYa2+QqG1D9hmjjEKeDzM+IqqVKKmlhPx54FA3VTe
	 hhAaGszEtEmsvbXV/ZP3viAXAjV2n91Ahlg6t2ckTOtFNjK0vZ1M+bB/XT2NIqmS1J
	 V6IvHEFfddXaZqhgGnuMFbGT2NWmDemPPdgLzfAs=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 582A367B; Wed, 16 Oct 2024 11:22:02 +0800
X-QQ-mid: xmsmtpt1729048922tp4l8pmvx
Message-ID: <tencent_2D332A9E751B474B521BD22569BA27BB0D08@qq.com>
X-QQ-XMAILINFO: MCKLvPxUEMECXK0NDUEUncz8Cen+tvC9jvvr85GJ+j3obXvbDXejRZXM+yx6SB
	 Cxgj8pKszLOc63VrFcv2cxmaOpJWM1VDCgiZT2Nsr1SurhFy+A0GwjCL3I7lDC9x9SXzC9Ok3zWx
	 Jt0xxj9WVlueCIrweYIFL80pxnsYOhvVS/E6svd5VfZJLpfRaZ+LzLy781i95Gi9GBKKKj7/5hBA
	 dulBjhyL+xZLXUz9CGIggHuBOQa9okA9EUAj5oEPhgS8o18Ma5pfaKQ2JSEt/DbWLHXwg9sVtN4E
	 yQOzINMBbLW95TG9QZUYMtY4d3g6opO5Caa+ht+x8IdpXPxpEezL0W4wbWE75wpdeKKMGkDHrKSk
	 e/Xld62QK3PxdyrR+qFp6cFQLohL6klyexQbepaxhHuS9a7yJO2Cg/YM1SsunuEEe6epxAAb5cC0
	 ltT3n95yOO0tDxgu18mR0ZCVmvUCzD/1uBK98ycP8dxNOBgMoPhDlO9/DL1JKN8uiQQ/wZ+QIf0f
	 ++tNFr4vM5P6sCxrb8MIkN4r8BiSGs8SwnEhAAMEYhj6G0La8sjAPDM9AN5gWtsBynTnNhOcoA5Z
	 lfoD3YQfkbAUZG6mQUObSuoBZ1/pzIQeZbJDk1mmoTg/coRjvzRvDdPogEVpjQHBrFQXyye0dYz+
	 UnsN4RTIaUolxAyPTjb2gLeW/cPYIy/6oCrdQ+m2rgbPdmTZTLC1GddYMw4moRLHhfLYIEEUP8uw
	 e3neTcYvAOLao0RdQuJA2DWyw2lFifBZu8gQSdaC56NPuvqb3fkG7R2fwJNK1J+P60jDi+U10mNs
	 WlBXZuIU0xYFUNudv+6XwgmX79ettG2bUkijNPdBu8//OnNPwhGALqnLrlVCGnD77Yqzj269DdY8
	 rHcdTCT1Xg0pSK8VZV+3cylJkn3hPMdXO6jPY+SBMA0KTmgYo6gd7t4OU+VN9l5fgAfTblATm7Cr
	 VYKpG32rzC3/FxxzsE+w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: joseph.qi@linux.alibaba.com
Cc: eadavis@qq.com,
	jlbec@evilplan.org,
	l@damenly.org,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V3] ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow
Date: Wed, 16 Oct 2024 11:22:03 +0800
X-OQ-MSGID: <20241016032202.424258-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <40f48906-09fd-4695-aef0-7647de46ea42@linux.alibaba.com>
References: <40f48906-09fd-4695-aef0-7647de46ea42@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a kernel BUG in ocfs2_truncate_inline.
There are two reasons for this: first, the parameter value passed is greater
than UINT_MAX, second, the start and end parameters of ocfs2_truncate_inline
are "unsigned int".

So, we need to add a sanity check for byte_start and byte_len right before
ocfs2_truncate_inline() in ocfs2_remove_inode_range(), if they are greater
than ocfs2_max_inline_data_with_xattr return -EFBIG.

Reported-by: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=81092778aac03460d6b7
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: move sanity check to ocfs2_remove_inode_range
V2 -> V3: use ocfs2_max_inline_data_with_xattr return value replace UINT_MAX

 fs/ocfs2/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index ad131a2fc58e..9327aa2f1bf4 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1784,6 +1784,12 @@ int ocfs2_remove_inode_range(struct inode *inode,
 		return 0;
 
 	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
+		int max_inl = ocfs2_max_inline_data_with_xattr(inode->i_sb, di);
+		if (byte_start > max_inl || byte_start + byte_len > max_inl) {
+			ret = -EFBIG;
+			mlog_errno(ret);
+			goto out;
+		}
 		ret = ocfs2_truncate_inline(inode, di_bh, byte_start,
 					    byte_start + byte_len, 0);
 		if (ret) {
-- 
2.43.0


