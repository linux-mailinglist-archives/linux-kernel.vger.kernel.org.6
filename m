Return-Path: <linux-kernel+bounces-290904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650DF955B07
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DA91F21071
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 05:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92FFB66E;
	Sun, 18 Aug 2024 05:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IK8J2RLW"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358324437
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723958340; cv=none; b=QlzFNWUwviLDbucaCatgGS292G3agmGsivXRqfwvppfT2kHMFCjEx5Y6F3BDuYDqg7Z7TLeVxI/8CD8Z7IGJNWrxcATLIhp71tlQ0r87ZDLUSz9n1GO6oYziw0DZEIOsFpb+02pl0bfzDyblvETdcwTn7bo3g55d3f3bsCBb5mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723958340; c=relaxed/simple;
	bh=pMFMozzUZ5zBXpmPi5bdGsMbcBmWfnDsPgUJzUJ2E00=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=njVGVFhwRSeVFA3g2eWIqdfoMABds2akLLQPSvO4uSLtkmsLRFpUS5NnLsvfSOkFKurFXrZFz6I7mw5xVTVzB6f97geIQOWFtPZ/+yFVlsoeb84iXS07tW/2LzEsAbjqhO/aVhA3iAyZi59Uv0/u6wsvf7jhVdfOmPSZQHSg30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IK8J2RLW; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723958026; bh=pMFMozzUZ5zBXpmPi5bdGsMbcBmWfnDsPgUJzUJ2E00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IK8J2RLWoVc7pNHdPa7uIuJ7XlzwaenKc5c0fjtc01VecHVInfq1Ea7Lo87/jVjqS
	 u7ZU4ij4nGaruK9l9PpX5/V6Ui6BqoB/oriXE+szlhajwP64jzM7dQgMTdZLi+UnU2
	 pAF10ZcSYRyo1YT6wrJ1w7iQJkCWhkDVfOVgodKg=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 36C224C6; Sun, 18 Aug 2024 13:13:44 +0800
X-QQ-mid: xmsmtpt1723958024too9imvcg
Message-ID: <tencent_B1542E456CC49638E98AEF12CDEC79866F0A@qq.com>
X-QQ-XMAILINFO: MOpJcPT3Yy24d1pMrR15LeUKLWBPxk0lmIg5kK/gu/87GlDD3TrqjtBwuhmgLz
	 +T1wQZYBdmd7KfD3FbX37Wc07pR7IW3g8vXnzVBlt/ZrRn7PCIYvrU3M55woiFiu7BB4UiD7U7h5
	 WkOq/Yc0zVtWLdrvXvzBCfUhl5ukOuLSpjl5Qskj/zY+tusV4e4q5D0t7A4a9LL981jUpsbtchrL
	 IOboFlw4XCMl5+MDUpsDpHfqBRSchyoMbqnA+G1LWSeU6Z3ZmlSTvmYxKQMJ8VIby4m2CPpTq2Hv
	 4J49qHitUd3pY/s1h3Glf7WOGvpUEtr317v+PaAE7Lpu1Q9In7OX5+C5tk0FaGhHqAHOyo7iEAn/
	 CqttNCdjbrYnGEEuTSF4ug/qR5kTgUtXfX34GG6z2tr1YP1/yI/G2PWLU05TZ/Q39WkCrGhiR75J
	 U1OzPQ9LxcmBlWYJJWwYwNBeUTVlexZWK0UW8mOIR76jZ3VsBdvC0q3vBg7ph6MIYzCPcoIxm6Zk
	 DLHYZDKTMMOtLkwP3LdS4JzFX4oe+hu7GBDst9iPjwjincE2s3PYsjhnLJcoI2g+m8FXw1znXaZI
	 df65J002f9ZKnh8Wx+NOzCeZMm9SVJTmrtCJyZ2To7FMmRAjzAGI57W8OQ2hvfp4X4ysNiLKC1c+
	 ltyWSIjHm+xfdysvpCOq+Ndy3X/ZkIUk9F7BXPzNOtbgibm/+97UAOIJz1z1FF2j4R+/tGfNmyVE
	 +LxKrkVW3Lx4StNqhl7eit51E7mgjFBp7EKWiVAjbxEOgga90axF2YadN0ruAGnHy2BU/TXSswvr
	 4AFx+HraQ9hQhxegd7V1GVL0xGSiKzR05NfbYuofzARsBW/Hf5Nb+whgd7Yd3U2fnHcNCEvoSJds
	 lcUmkLrAXexagFVRwF6GFNKwfj+gfo96UJRKNDOd+t
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] kernel BUG in __sock_sendmsg
Date: Sun, 18 Aug 2024 13:13:45 +0800
X-OQ-MSGID: <20240818051344.2622578-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000b2bab3061fdcad9b@google.com>
References: <000000000000b2bab3061fdcad9b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: upstream master


