Return-Path: <linux-kernel+bounces-393679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C349BA3F6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5BF281DC2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36A0136326;
	Sun,  3 Nov 2024 04:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NcugLhHJ"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD22A31
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 04:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730608974; cv=none; b=uBig7bMBxm8P6EAaJGKiy0rvBfw8IJaSqvK8ymQuyxPAyrWfOlYyCmAFLfmY3xxJXo25SGyN4kKJdNVvcEVNlA95LrtqYUGHC6FK3ziyk3lmK5R15X+1cObLqOkXf4goePATHeb9T0i5h09lgPusZqfVUGW19h1ZIVcIO1K6suI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730608974; c=relaxed/simple;
	bh=/eqGqDuA5NymL6DmOUX2hptY7IwZniuV1SvU927iY6E=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lgZoqZ7GgMrU5pL0yTppk3h4iViYQE2CZUaNO/3p+35JgBDo11qK27nCvNkDwSBxl/lJ4UpQfXnzKIEZntham6VHsT1rt/KpKEPZ7bd3sylL+7FCoAtg/fqapFviQ0QHNmqM2cMDgRIymfRpsbSaNpW8UzYElLChQez9Uuq2ECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NcugLhHJ; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730608660; bh=ITD7gbe+dMZ12c1POu8Pw0g1t3WIbLhh020/XwSbj4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NcugLhHJDIvzw06Wq2AfkiGfhdPK/LGaJy8Wv030G8vaO/jhk5wUq432w/x8BfVka
	 WtDXN4Qs0v/PW3fzDaT9kqJhq2F6c31ygx6jPKZThOJcja3Od7PytSPPHcdpl8fzr9
	 FMn+R2hm3v6SvK8ZyJ6M/tRB/c0ol7qc4gbY7gYs=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id 96699206; Sun, 03 Nov 2024 12:37:38 +0800
X-QQ-mid: xmsmtpt1730608658t8m2l6fys
Message-ID: <tencent_F692365DD35DD7192C4FB18DEFA5F30DE107@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQ3AGfhbGlchSm/CMjQIUNbQGBHHKbZjcRjJlNlsc5Y2P6bde0Fi
	 GX7fycZsEv6W30ICxCzAU5dLGYEPIYTpEdlj2KKAgdmF/EzQA0plSr8krXRHJF+ZpgWB5n2ScveP
	 Icf+mXKtRIx05Pv3vxs+aunllswap6hzXZveC+p3b59X9KsXR5NTsCRLR4CFuvKWNiNfcuO6fHmk
	 8+pwyRHJXwATXQJN5BGYvD4xtLRwQgkkcjq/lmnrcrZ9XtSuDhfoYKFCWBK5hIdMM6OGyk9MibbP
	 efCiGMAEAq87oRFh88lqiGVK5j88fPsBQMRHLj8NrTI+eff8WC8fEtP7ou5UPhm7Gibxv/emle6l
	 VlUZhQ9KjEIeGulUE1IuG1AZ4yJNm+uQc+VGMZU96FUc8C59AwWrf6CLFKBheP8Umh7TgimKpFPt
	 ZAlLEvRma045eM/xupFTcWWcr/kDlT7IiEAtRxT5+yWFIZCryPc2FbshBiLBN7OHDdYHMFdK3RcS
	 DY+skGXX+TK8PzpSALUqRdg7MZTs47YIgXtb8ytpC46q9KMTPyRr0ZSVWFAOj/CPbnxl6JhCWZYD
	 2UK+eyNshJaZZ8j790lqWdaFqGFq03D0ewEhSHaxZSEep9ZVgnwQ280h8k5Mtgmkj67ne9DEHKPJ
	 ggYRAkIDWX35dXDigBP30hfkYN9rYXoLApM17z6NjwAFuOV8deio/mhtn3NbDJcYZSXzsWFJRp/c
	 gkNT9NoTUERC0obkaHfCzbwiIti4Ib6Uo1V9vEGjLg4Ss1+PvphMCZeWlLzb7ZNv7EgHV6XlsGfh
	 /d9op7fmFefJlDGCX1lYrjZ68pmArK4MdeHwTaf59DxnSWcSErkoxFrmeinZFuCFpHWOe2c4vg4z
	 zytL5DILd5PjLqF5ruIPdps2AlvO9FSJoHMNI540cBx6vlvqsr2N8=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bfs?] general protection fault in bfs_get_block (3)
Date: Sun,  3 Nov 2024 12:37:39 +0800
X-OQ-MSGID: <20241103043738.723423-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67218131.050a0220.4735a.0265.GAE@google.com>
References: <67218131.050a0220.4735a.0265.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add a check for new bh 

#syz test

diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index fa66a09e496a..10287a1a5846 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -40,6 +40,11 @@ static int bfs_move_block(unsigned long from, unsigned long to,
 	if (!bh)
 		return -EIO;
 	new = sb_getblk(sb, to);
+	if (!new) {
+		bforget(bh);
+		return -ENOMEM;
+	}
+
 	memcpy(new->b_data, bh->b_data, bh->b_size);
 	mark_buffer_dirty(new);
 	bforget(bh);


