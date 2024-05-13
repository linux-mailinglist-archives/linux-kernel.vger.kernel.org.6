Return-Path: <linux-kernel+bounces-177121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0318C3A62
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3962812CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 03:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E96145B20;
	Mon, 13 May 2024 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PmPPUFps"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3712AAEA
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715569727; cv=none; b=rM6EfkKD9WHsLdoV8p3Swdgdt58n92TOeled1dLCYeoLNvGnADwuLr869PWv0T/s6roPNx3sWxAbMd+ODPCZQsyYeUfU12TLeqo4IiAVmubb0k9LMxZlPaleDvjdgIGcNslhMykK1QMQyNYZAnaC+oV4TzL3qaK/RkxnS1Kq5SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715569727; c=relaxed/simple;
	bh=gA/7lXvyMG7IHm8IrlNnrTBKaBmoPVKDklOfk18TL/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Kahs3VxKBMTz+ol6uQH25+b7LM63VR/v5xisEYeyFwDC3Zy0kPyFj4dAv/vIobJmVGPp2dix5pn3N1HJ5FJe1VFoDIsSVjCYR3rM3iN6vVTJvcsGNnZPycHkWPH2O/rnOcph/Ttw6Z5H5IC6OdqHZwjt/M33Ai9urmxk9w8PeBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PmPPUFps; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715569722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tnZpkKg9cgdujd3Aq4lD9/9/FxuyG285EmfT33GGzAE=;
	b=PmPPUFpsmDLdW9nAkuKBKOvQZhhIMr8XxYT78ICVRwJkHxeFtr3iwVxZeKxFfc+l48Hb+U
	qEtyYgQxc6qVfOvr38nbMTX+k8D7q2NQOQYMtI/90IYOLKoL4qsJUSjQ5aToFa+TB10LYA
	K7vD1DH5aJPSMiMe6JRe8ICGml5Hu2E=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Mon, 13 May 2024 11:07:56 +0800
Subject: [PATCH] mm/ksm: fix possible UAF of stable_node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-b4-ksm-stable-node-uaf-v1-1-f687de76f452@linux.dev>
X-B4-Tracking: v=1; b=H4sIAAuEQWYC/x3MzQpCIRBA4VeRWTegZgW9SrTwZ6yh0nDujQviu
 19p+S3O6SDUmASuqkOjHwvXMmEOCuLTlwchp2mw2jp9MkcMDl/yQVl8eBOWmghXnzHGeMlkczq
 HBDP+Nsq8/ce3+xg7I7TMe2gAAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Stefan Roesch <shr@devkernel.io>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715569718; l=1596;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=gA/7lXvyMG7IHm8IrlNnrTBKaBmoPVKDklOfk18TL/A=;
 b=B1X1HMHHKXtit/7X6hdcXthfuE0UbCscRgiIoqnVwo40ChWPCoX/sArCTV7ZidHLIxvtW5T7l
 YL7nsjs5gk9Bhu6S6h66FOVNFhh0XGvCuDXijPKZ9B8GBzQtTuj9mRK
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

The commit 2c653d0ee2ae ("ksm: introduce ksm_max_page_sharing per page
deduplication limit") introduced a possible failure case in the
stable_tree_insert(), where we may free the new allocated stable_node_dup
if we fail to prepare the missing chain node.

Then that kfolio return and unlock with a freed stable_node set... And
any MM activities can come in to access kfolio->mapping, so UAF.

Fix it by moving folio_set_stable_node() to the end after stable_node
is inserted successfully.

Fixes: 2c653d0ee2ae ("ksm: introduce ksm_max_page_sharing per page deduplication limit")
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/ksm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index e1034bf1c937..a8b76af5cf64 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2153,7 +2153,6 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 
 	INIT_HLIST_HEAD(&stable_node_dup->hlist);
 	stable_node_dup->kpfn = kpfn;
-	folio_set_stable_node(kfolio, stable_node_dup);
 	stable_node_dup->rmap_hlist_len = 0;
 	DO_NUMA(stable_node_dup->nid = nid);
 	if (!need_chain) {
@@ -2172,6 +2171,8 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 		stable_node_chain_add_dup(stable_node_dup, stable_node);
 	}
 
+	folio_set_stable_node(kfolio, stable_node_dup);
+
 	return stable_node_dup;
 }
 

---
base-commit: 7e8aafe0636cdcc5c9699ced05ff1f8ffcb937e2
change-id: 20240513-b4-ksm-stable-node-uaf-ccc7fe2fd6bd

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>


