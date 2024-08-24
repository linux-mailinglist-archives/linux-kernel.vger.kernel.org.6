Return-Path: <linux-kernel+bounces-299823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB3F95DA6A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 03:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38C628316A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AA279FE;
	Sat, 24 Aug 2024 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BqUr0MOR"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62979C0
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724463412; cv=none; b=cH8IEtlNP1m8fEeJUPL+bRETZVmc12g2Om6651SkInxX+Psd85IVms7JbwdF4tj0kBHYsC25PAWrJ9JT5K0n3FcWyPbb2oZvUx8z2+3H+H1a4FRNYDkd8CEGRpLwu9u6C/smafWSXXMXjLhMPmNxkQMaNoPdoxV1eOkA7HWr6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724463412; c=relaxed/simple;
	bh=CLeTk6zu5zwG6uOLpWjvkjRR9qq7XJ1dbaG8bO4HbQc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DEiEiYUYgPPe9UPKqC+rOVFBHKy5k67ejSdIvF/EP0RtWP1kSjS6B6SyYM9yjTroNlXMSK9zuFfRV/97S8Nl6sdP2Zx5D+9xlnN3dTGSb7Un+MN9Xn+s6AENWy8y3HUMpQsuSjAPuVdZ+9HwJCRPROQQd0utyX4TKRHh3l1Z9Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BqUr0MOR; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724463104; bh=TIPYW9qmUIPgznmK90J1yU9u2VOYbreOfofhUKZddDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BqUr0MORZ6dz+YNV6wr8TP5wcIcCwUPOE+Z/GXiQyncIAMsGpuRyor74/NYnNWFCA
	 lgDdS8o0yBFPfgy+i+8pg0KpmjWiBJFfnPUQf26qoEe/CtDLu/8R6phshjpnPLkkYg
	 Jb4JXq+ocfMTyffGyb/+hNZy3IUYtn4V2HU3zXU0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 65619CF3; Sat, 24 Aug 2024 09:25:22 +0800
X-QQ-mid: xmsmtpt1724462722thau1kgja
Message-ID: <tencent_21361896E437004A0E753576A367A03C1F09@qq.com>
X-QQ-XMAILINFO: Mrv6PNPZjcp6CHs+D1s83S2Yll23Z262UQqmINKV1rboOfkdKLh35h8yUNOCIC
	 LwFiSOlEwDAZkKpdvOmLDEnKdz3qLDADKEKPO94krRnaQbOzQoJwLdy2Ey6ueSDe9cTm+nB8zwU5
	 fu2Y5ivVgxTjvuP7w1mx5ZxZpCkjHX0pj5JO0lt+h+0CPh6OIUVZUgeOepziqGG9M/8uunVsc+OP
	 80bfG/fW7YViMP3xPDnBvHhYyP3Q/CNLCXfiwHDwf2EeZIr3OVP18MzOeh3dgd94Fxn5yu/7a/K1
	 N7jvOc09FYJCIg4NANl4F8v7yS3VkSEynUy8Bm3EqjnHlAhjKEAdHZQ7sTJGgV6QBCJ4ORjNVfzC
	 U7c7t6EiDcuWkLCn51A48loPrNn/gW4kaaGmMqhV7saZdb53RJbP5oKTtWwRvlm9+9b3JOvM4S0p
	 abSk43Ongd3Y4ba8n3OKtgU1P12F4Dt84e6CQsGlPOCspGvB1a2r4z/HkxF7cEY9Eq3H4Y8ETJW2
	 bAP5FgtcojB3f9+RjmRnKAoSxvtD1hU3TZfh/MxdGO70g3Bv86Dl09FhtSJbVrwYY+k6WlvD02U1
	 O39Dbw+0GmysLGqTzvX9QhbMqp5UxWDV7mCvPwXCycVqfYk/drejsaKduwLX4W0jws4/tlJ4ZeFu
	 m0ykGOu6ooQyRSt4r89tLLJR0S3pBQLc2uTMr84XblU1LLRMgd3I7TprtZTRkpUDmCnqPPzL/WXB
	 uZ+RS0JLAO8sSH5vwxMyxGOzLNzwWGvgGo6DkZ7y9EVJu+cnk/nq1SsT/LtyibsmYo6Gd90dtAIF
	 hbpFQrYPieYvQCEsF5T4dmTg6t7nvWvEe5+7AJtD5xICst4ZD3c9CoA83uMo5eoPsTX7Iv2GyZ6m
	 Cie1uT0M62c/dhoxNh8c7n6gpneXTWNKnhulzGS/+vUrKhA9l210sNb2Z6Glg3jZ9ObOyNm9XKDO
	 5evqVLpjlLLYNspskmPcAMojvxeNEg
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: dave.kleikamp@oracle.com
Cc: eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+dca05492eff41f604890@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V3] jfs: check if leafidx greater than num leaves per dmap tree
Date: Sat, 24 Aug 2024 09:25:23 +0800
X-OQ-MSGID: <20240824012522.1186031-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <386ef374-25f2-4a10-bd15-0913137f1c9f@oracle.com>
References: <386ef374-25f2-4a10-bd15-0913137f1c9f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot report a out of bounds in dbSplit, it because dmt_leafidx greater
than num leaves per dmap tree, add a checking for dmt_leafidx in dbFindLeaf.

Reported-and-tested-by: syzbot+dca05492eff41f604890@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dca05492eff41f604890
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V2 -> V3: Exclude control page

 fs/jfs/jfs_dmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..516bac758053 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2976,6 +2976,8 @@ static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
 		 */
 		assert(n < 4);
 	}
+	if (!is_ctl && le32_to_cpu(tp->dmt_leafidx) >= LPERDMAP)
+		return -ENOSPC;
 
 	/* set the return to the leftmost leaf describing sufficient
 	 * free space.
-- 
2.43.0


