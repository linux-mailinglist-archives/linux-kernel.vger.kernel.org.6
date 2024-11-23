Return-Path: <linux-kernel+bounces-419225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613709D6B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155D9281EF1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739AC13D246;
	Sat, 23 Nov 2024 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YBbwVYAO"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D827466
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732389454; cv=none; b=KQSa9aat2qPR0eghwyvgtzWIp2jBYhGZkLfTzrJf641qzuwL8E2hBPGYn93h107B1V+T7nmeuJ4wuUlBSJ5nOdu4yv6LmHMHRDLNaH72afk6I7r/elbHLutS69Ne6gZ4Fxk3vz4RkHXmC+2xG1bdn7Kjvck0XkyAGcqUvn5+Zhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732389454; c=relaxed/simple;
	bh=rYmvIRPT0JSYYaJ9rRZO2FPG3lPc4CSjURyelhhlT4k=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=RkFM/0m0NfqUfvl8zTapxVy8cG0Ci7/1Y5fp2iakbUNudYoVV9mWHCgJ/UMKt6rQvgNJuQrRpspCn7TD2vFduRJfnGrk8wAQO0vz8vRmMTYPWkz/ym9u1tNj3HsBhBtiWEctfb2wqzjTELE3YSBjegKOdsGm/ddqCc7xIbkEhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YBbwVYAO; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732389138; bh=eSGfu26T77d7IY4FTCS0fWJCHz54TUU/hG40FkEQcTI=;
	h=From:To:Cc:Subject:Date;
	b=YBbwVYAO7Wpgmpr779paxBHZVR/KU2TcpVq9oMOPTAqG3y1Qj3D6yUWT23TBcSDYD
	 UlXxbgRX53HHhdqvNL43ltOQUxm09q8nUd8B3Nmmv7Keb0tukbohMJAJnlz9eZejJL
	 wvickF3J0ec44YOUexlh2GEPmneEZ4jdBnyq5AGA=
Received: from localhost.localdomain ([2409:875e:a030:1001:14::90f])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 3111EC3E; Sun, 24 Nov 2024 03:12:17 +0800
X-QQ-mid: xmsmtpt1732389137tysf0osr4
Message-ID: <tencent_57D6CF437AF88E48DD5C5BD872753C43280A@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XHNRjJZFzGWQcJ18ciuvW94XCr6GE9nuCwMrwVOPZSzpjPqyTNE
	 L7rAUID/wf7ggTDTwz2qU2CgfKHNf/wF44HCybgtkAtw9QbZ6zGTLz8Rx/uYQ1u46Wt2RvCzBftX
	 sYUE8BfutSqdklwL4lZZ9+6n/hQZHD6ZTM4KMwETYT2ivrP+v9SUAHCFYLluSAnSRT3Q+K8W7NS3
	 k6jXFydwWFVST4obx13rEaADndBVTvAswqtdvYTbu7jLyuUFNl1FilVLmfJxEltaFuwW0mrh12fx
	 d3CzJswRoK9zrBMemmfVWB/jTxDdHRw5q6wZwjUM8lVUaCMBiBwh6Yuz4haJfAYQ33c5hFmz4SSu
	 f651gxIJsNUeF+x6yvpsVql5INxFsd9Z0HdpEEUDFCw2aNYPOvej5X+zjFpPfxkvgAdJMhgRU5WJ
	 VUny4S97QdjLdRCVQp3OM+i4O3doVzIisZAfDRkhwZ1SyCInMnlWUqQMvtr2iYDNDzshkjkOBW2w
	 f3Y5sNLrJNc+5G163fJE2urymQJg5Y71PcPBDUu0+y5TL2iwP9Osxh0tGlUZieqBeGICZX7soDj/
	 cE7RMiyyIWaDevLRjk+yJfxp9ypFaz1VjzMWZrWqcEj3czXc8ZV6fY4YfR2z9fzmgPlizByINTPN
	 HXw3TBIkjPa//LxGPsAa9oqfP1G8S4RBcx4z4GzBZ4Fwe7c/eTX2q3ROqBx88jisUGY0MQLdLmMq
	 NOtvjc7/BYbS7MvlUSgqxMMznTe/h55oo65Gga7cLj/fkGDCqaYX1kCqCgU8sxQTHsPEgKZFP1uX
	 AVnVpi/+H75Qg6zfelactAjfEbeAuCxTxsCuLIOQRvlyJLQ4/bgAd69S+Rn1oo1o/wxxaMJT0guW
	 Hs/PxIlWauUhAj8014zKTdvnTdF1R1Uu674WjK8PXCnh9TTTMKIwbZGeCcdNyfzWr0bZtrR9AGGd
	 Wk67TISSx6TYyi1VfLGdHMaKA5YQN9BauVCtCcfloS1diOpdQDktqm/mzs1oCz
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Junjie Fu <fujunjie1@qq.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	dave.hansen@intel.com,
	mhocko@kernel.org,
	fujunjie1@qq.com
Subject: [PATCH] mm/mempolicy: Fix decision-making issues for memory migration during NUMA balancing
Date: Sun, 24 Nov 2024 03:09:35 +0800
X-OQ-MSGID: <20241123190935.2433794-1-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When handling a page fault caused by NUMA balancing (do_numa_page), it is
necessary to decide whether to migrate the current page to another node or
keep it on its current node. For pages with the MPOL_PREFERRED memory
policy, it is sufficient to check whether the first node set in the
nodemask is the same as the node where the page is currently located. If
this is the case, the page should remain in its current state. Otherwise,
migration to another node should be attempted.

Because the definition of MPOL_PREFERRED is as follows: "This mode sets the
preferred node for allocation. The kernel will try to allocate pages from
this node first and fall back to nearby nodes if the preferred node is low
on free memory. If the nodemask specifies more than one node ID, the first
node in the mask will be selected as the preferred node."

Thus, if the node where the current page resides is not the first node in
the nodemask, it is not the PREFERRED node, and memory migration can be
attempted.

However, in the original code, the check only verifies whether the current
node exists in the nodemask (which may or may not be the first node in the
mask). This could lead to a scenario where, if the current node is not the
first node in the nodemask, the code incorrectly decides not to attempt
migration to other nodes.

This behavior is clearly incorrect. If the target node for migration and
the page's current NUMA node are both within the nodemask but neither is
the first node, they should be treated with the same priority, and
migration attempts should proceed.

Signed-off-by: Junjie Fu <fujunjie1@qq.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bb37cd1a51d8..3454dfc7da8d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2769,7 +2769,7 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
 		break;
 
 	case MPOL_PREFERRED:
-		if (node_isset(curnid, pol->nodes))
+		if (curnid == first_node(pol->nodes))
 			goto out;
 		polnid = first_node(pol->nodes);
 		break;
-- 
2.34.1


