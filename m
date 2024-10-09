Return-Path: <linux-kernel+bounces-357303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6179996F61
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F115D1C21A12
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BFD1E1A2C;
	Wed,  9 Oct 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VsPw6W7H"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A819994D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486349; cv=none; b=jQDZR/+sz8GvnPr0Tgt5Rf7KDSrn3Trd7xKaCDUEzgoQ3Hzz8JiFMCyPE6o/9GRP5r7jhRAgbg68UdhkD7y4x6PrJeFuDpH5KrzX30X0YTJpyC2a8M9XwjM1a9kTX1nyVEei3JI1d+9uPtWiSu4iX7upSWSzUiZQDWzqvoi794I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486349; c=relaxed/simple;
	bh=lxVkjeqcgTi8Qj7Tn7qa4mbaz/3lmo0ODYWBOUdIDnc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lH0ZSgKDyWWcn2++Vmc4f3WXXLaaE70ULyWir3Mi8LKmQ8AubPmo4M0Ow7Dy3NLhbwv6iUg0RsqUb63akbkfxRsSL8wDnJCOYX9CQ0qLmYrXupJxG6AmPvKSu9XYbCG4DDaM3wo79QPoLKmmmVuyA3/dnk15cXAnEYiQWpJgdA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VsPw6W7H; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728486344; bh=3AcLT5cVXlL+9HeGz8dpIv8K+ePt2O9N12m/C3/Kk08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VsPw6W7HSSYUcGFKSeheufS5j0NUpZbxl6GVfzNT1t73ixQ67Ud7b7Fnbw5dhCC8A
	 dCH4aWq4pE80SxFSyYAjAY+NN5iKPrXpSIy5na+VVy613qO4bVIAwAZEpBt17UKFPo
	 /3Q5CyI7NCL8ejjZLCBHs4FIc1n1LurErizw/FiM=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 1692FA11; Wed, 09 Oct 2024 23:05:41 +0800
X-QQ-mid: xmsmtpt1728486341tfhqsg3sh
Message-ID: <tencent_B22CA96C8896C0E9FEEFD2CCAC795A6E500A@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieHUBSR0h8MKTmRH3ISJl68dnigd3jpclZS20rbXT0/ttlcbcMFI
	 gK//TnHGsv32S1q7sFEx9Y+zyP+W9F9ZTlBsg+6XWSlcxoHw+HE6Co3hxnCMu77ItqfhDDijEV6I
	 72eYEQwUi+nMEYSTabUN0oSid4xRX+R+sQ7u3JNSU4JWMWTJxTVOwiC1RA/fGzqF6KCUzfMAxANg
	 uiN0Izp0EeoGIU9Mnch1/iUWSXbM3g+de5M8aQsuCuPR2Mf2gBHKJPeoyyF8uBmXb89K92jwxkbu
	 92J0ooryDs+La65F1M8eWAYn8fcZJ2kH5gW8nKdRPCgBmfppOSdDnGDmr+y9MOfpPbbGDyo4cgAy
	 9OJ2GyPO24bh4lE3qIojrwBBFKfsWRaFcrLc92Nege9kPUE1l9ZcmAFfJ1WfLDXTU6HL/mv0qqHv
	 0Z9iBkkN5Tbyq2K3IbRzEPG/LddoXwNsZsbeRzh9VpkUrJlYsaEYvdXuoAFWzVjvyEScYOJsguhQ
	 CgpkBACMAIQs5zJroUD2IP7Su6YJNnC8owU3JQvH/GcDX9dLZhoxFwaDuM1Mq14KbAE7xzWXr7Rs
	 aUgfj4VzTF959DyWV0fsrteQfks1/JnZKXj8yMhW7O5e11K6gkaT3vXfPvtJJpDZQsLl/jxjIoZ9
	 yofO0WFIV4YEY9i4JZi8IGh6XG/BICTMbKb1QANtpMuIL77OKrR8yAJ/2yLfmOfguiZFmDKxPLTS
	 5S4aSNc2H0MCFveUDzFkXkn1ye+hWjbM53TupQGXlsfTr2wycNFToa0dn6XI4VjHX8e/8OFL5+vQ
	 qiRCew58ZrETs9CbkrFJufpmt34sxHmDbcsUoKi8bu/6hF0v5L6R0kzIYcDyuXSoTRKHfjvjZfax
	 oAESi22fF2r5DQGlaNHBa+4mNohMJx/Jv3YnKxEgrxGC1G5l5R+MVrP7v3txA5bjPhE0MTMwjf6u
	 jlSZgHcH8Z3GR27vEvciRsvEOEWPU0
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
Cc: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow
Date: Wed,  9 Oct 2024 23:05:41 +0800
X-OQ-MSGID: <20241009150540.1595244-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <67062030.050a0220.3f80e.0024.GAE@google.com>
References: <67062030.050a0220.3f80e.0024.GAE@google.com>
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

So, we need to add a sanity check for offset and len in ocfs2_fallocate, if
they are greater than UINT_MAX return -EFBIG.

Reported-and-tested-by: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=81092778aac03460d6b7
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ocfs2/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index ad131a2fc58e..ed26ec8ac6b6 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2117,6 +2117,9 @@ static long ocfs2_fallocate(struct file *file, int mode, loff_t offset,
 			return ret;
 	}
 
+	if (offset > UINT_MAX || offset + len > UINT_MAX)
+		return -EFBIG;
+
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		cmd = OCFS2_IOC_UNRESVSP64;
 
-- 
2.43.0


