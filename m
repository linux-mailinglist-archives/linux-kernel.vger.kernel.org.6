Return-Path: <linux-kernel+bounces-516684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E2A375C7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B7F7A21FE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C49919AD48;
	Sun, 16 Feb 2025 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eB90miJq"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246B1EB2A;
	Sun, 16 Feb 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723443; cv=none; b=YMo7IV65o1d064bYVQm0BRW6Z02DhQ/QRpnQ9ofeD+QzyBZ8fe/F4p6GMrAvnjMEj0cuAnvXngOGZrlng1wl266uBezUFss3blNuMuYgSzp1/Iz7vKl3s5O1Y+AQgZ2LubYJAO+AGNCirRHczMUKqL8B3MvJSufl6tF2ACUOorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723443; c=relaxed/simple;
	bh=XUueMceg9DxHK3H1zwriL3J9Xlwq7Hdyuvt6k5oIh3M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jKlUOuMkYt1PSuKC3hw8NcoqVLOf6DpyRvlh5uwPKIl3fGytKgbH4jLnC1nYkPGbv5GGEw/t9t6cDaomMLsZgl91W7yxbZ5IbqQM67t3c3WakvhpWwBcEKgrCmc1qbbwoPlTFCqCsd4CfX0ZkHe+gR/YOufcldIe2d6VdJRwx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eB90miJq; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739723441; x=1771259441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NaJZIyPZAIfV6LNidT78LeIrY2+uo/+ruqMk5M8d7O0=;
  b=eB90miJqB6Pl0O+6k+Kkhw3+IaHi4PrRs3lHoUijc+POYq70jc12fDjB
   84icdkFwg7VBQm5GBZWysVUBrgP6CHUFQVctved0psTy32xLPHrSLS6iY
   ZB7wAwuTPDOKaG8PPc4rgkZ+BqhVOk3YlcxnGi+LxCeFfMDvz0URuAgrR
   U=;
X-IronPort-AV: E=Sophos;i="6.13,291,1732579200"; 
   d="scan'208";a="172956246"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 16:30:40 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:38396]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.73:2525] with esmtp (Farcaster)
 id 92bb0ce0-6e42-4b4f-82f1-1290ee735eb2; Sun, 16 Feb 2025 16:30:39 +0000 (UTC)
X-Farcaster-Flow-ID: 92bb0ce0-6e42-4b4f-82f1-1290ee735eb2
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 16 Feb 2025 16:30:39 +0000
Received: from b0be8375a521.amazon.com (10.118.254.38) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 16 Feb 2025 16:30:34 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Gilad Naaman <gnaaman@drivenets.com>, Joel Granados
	<joel.granados@kernel.org>, Li Zetao <lizetao1@huawei.com>, Kohei Enju
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH net-next v1] neighbour: Replace kvzalloc() with kzalloc() when GFP_ATOMIC is specified
Date: Mon, 17 Feb 2025 01:30:16 +0900
Message-ID: <20250216163016.57444-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

Replace kvzalloc()/kvfree() with kzalloc()/kfree() when GFP_ATOMIC is
specified, since kvzalloc() doesn't support non-sleeping allocations such
as GFP_ATOMIC.

With incompatible gfp flags, kvzalloc() never falls back to the vmalloc
path and returns immediately after the kmalloc path fails.
Therefore, using kzalloc() is sufficient in this case.

Fixes: 41b3caa7c076 ("neighbour: Add hlist_node to struct neighbour")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 net/core/neighbour.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d8dd686b5287..344c9cd168ec 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -518,7 +518,7 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 	if (!ret)
 		return NULL;
 
-	hash_heads = kvzalloc(size, GFP_ATOMIC);
+	hash_heads = kzalloc(size, GFP_ATOMIC);
 	if (!hash_heads) {
 		kfree(ret);
 		return NULL;
@@ -536,7 +536,7 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 						    struct neigh_hash_table,
 						    rcu);
 
-	kvfree(nht->hash_heads);
+	kfree(nht->hash_heads);
 	kfree(nht);
 }
 
-- 
2.39.5 (Apple Git-154)


