Return-Path: <linux-kernel+bounces-356626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD77999644D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59230B24AF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3834E1891A0;
	Wed,  9 Oct 2024 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ps0NkZRY"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3F018785C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464408; cv=none; b=lRpmQQNwwXoWoKyWIZe8H39FZ41CbJfiDa6gwVzJedew1IN4giAWose40LLZnmQN6TqwpEtkShF5uhvasGwukzRlWz2djUM+po/cf7DMiAq/sdzT1gXHIBEtm9dShcLcWFLxCtTQcTwZk1TM7qzMUIibcmbEMTLkJFewIU+6FwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464408; c=relaxed/simple;
	bh=t0NL+wtrF+U/K3tCq2Z2PJbCMCMyvDmcCTlMzR/Vx1A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IbqAAtMTU7duKoqF4gKe5QM/Fr8Xf5ZqMZJhHrzbPq8/s8uVKpWNxjqjWrkH6yMCycnLTuEJlXauqYzBDi3h+q1AGOeChw8tNlMBDKk/2oP26iAGWzlw/YdjuaQvXggIY5aABKbevyCnV6MFxA6es6HsdPWlqV3KgvJ2C2IdA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ps0NkZRY; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728464404; bh=M64ZegpfQ35OAjqFyPNCkYJlWwvtGwUIgoAYZGAzRm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ps0NkZRY3EltxXofzsMggJR9gMztGLeuahc17/FJRPIywrQxOEM5fdMvWvss5fqA2
	 fNACKa7UNtnoSViCK2Sz3y2QxOYRbrzZghnwQWIeUDwGZjTtSYQbYbVEFF3Bd7MIzV
	 UPNd876Vo8fHxSQPLRG/Rgyt4zSUutmhedq8jNwg=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 2A5640; Wed, 09 Oct 2024 17:00:02 +0800
X-QQ-mid: xmsmtpt1728464402tq51bhyqh
Message-ID: <tencent_11642C456F589720E8CEEC46CD2879666E0A@qq.com>
X-QQ-XMAILINFO: MBjwNRQMz5zUyhBIGYYy0YDly4YokW4ebcg4XW+4NFVUjKADWC5xTL2dW9Yhfe
	 OQZib1EdXvwzTxniiYGsV9JYw7Vf9C3m1+KzDrST5o3MRb+R/AePzChh0afa5iGLE9Bsh7B+FyYu
	 aa4eCZ6ZuUs9ADrfz8KS286duEQsZq26SFfqmf+Z/+CS/qFk4EKdj09XeM+vjh6bUTStO1kDkh/4
	 rB9+uvhw0YNFD/DVtHlq+TS3M0zeIkRb+Q1fAsBb4E6M3LVPEPHATW7zgfr+8xziJp26Zhyp1cp+
	 GrdxAULo5ul2RQbUeUG8z8nTU7iU2fy3AlGJ59f/dQbLpXyy/W9TFm6J9f2fP8K6YY+NvTXwVQTu
	 lpJ6ur0dnbXXwLoSGU210cnQrylJ11sjvUw54Ot2SxBXMokSBYpnxn/U0MLWsjKPh2JGWI4IIX0t
	 /ahcWwdx/lIquuO9hPYwA6+nQ02PnThoecivI0oellF3q8YBvTs0yxdj5YY9ZZ+59TWQWrF58ZyX
	 TwMey2M8S99qbp8jtSinQfx0v2SU5QfZVfNJjLFFkOStIGuTUPket0ZrIBZdIoF0V7irFPkGycsD
	 L/gaWACPjWvmdCI+s5hMZZtlnwdUUpeZT4JaRQJI43s64axYXMWZddX4U7oQk6GuwWCZdkqwD6ui
	 zhoFwt8JxMq+FM2lZAhNKD+Bn2p/mqombUemtF1Ld1rXijhyaiaiGKiqMo0Zw8bsokLYZEToYrCs
	 ODOqF3kAwXdSPnvJfXb0w13xTR1ZCk0Oa77QbC2dCSe2un4pCJWeK/DULtfBkwqryg7tgFlOFegM
	 /lgg0/tJizgYg6HNWuba86M/bJfPQWjja5hZk++F7km9LJOalxcvAYlFZlWrZfQw3v0dIrHxcXRI
	 6E1nHDeSVC6feRDAMUFm0QjKIJuPF1xPjy+i0/CDz0/qcuJeYi1MZz6uE0C4iB9KQDDY9XjJRf
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [ocfs2?] kernel BUG in ocfs2_truncate_inline
Date: Wed,  9 Oct 2024 17:00:03 +0800
X-OQ-MSGID: <20241009090002.1230579-2-eadavis@qq.com>
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

offset or offset + len greater than UINT_MAX, if true, it will overflow in ocfs2_truncate_inline

#syz test

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
 


