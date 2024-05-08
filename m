Return-Path: <linux-kernel+bounces-173002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DBD8BF9E6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD8E288209
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748607EF02;
	Wed,  8 May 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TxoxqQr6"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D197C0A1
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162198; cv=none; b=j+JpLm9kL0MYRR92syQ5rvF0N6YCmLlPLQ4y4Mz3y15ZrLv2yPk8Sh5q6k//XlT/+iowouL27cecPYMVsdIWIy29sW90r6iMMl3GkUU93eZovt+RU6d7sVVzRxzg9LIKI6Ko6fFfdcT2y+MgzJGHDOq498NtuQix50PiMxxRUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162198; c=relaxed/simple;
	bh=9T02FTklfVUMR7drM2v/kaRCwGZRX7z9/r7McdEQClU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SUQskFnd3Oc3ZgkGvXrB2TL0WwTwQcq5oUhphydIiEdHLZLPld+53hbSN2My1Och/HDDyVSxsIPyzIxwEZy974WyX4tyH1Drtu6ldOiVnuMrfbRf8HJ+5NW5T4AXsWQafKmTHck2b6JPam7N4mT35lZRlE2jalROIkmoUTarnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TxoxqQr6; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715162195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7esPxFrHeeBhwH9TcjMg5ONohBvtI4PjIYPbV7umvFg=;
	b=TxoxqQr6IkPtfChwoT38ktZdFciaSGa3+CEFn0j3iaJM2QQ9PI0C6oA8r+CCO5OyIuLQKk
	5iZps/f6cdsTPnSvWzVrdidclmBnSAFZwtFbVxwMIp3x7I4ElQut3qTe6idS+3e3QHKs8Y
	ZZi2Ih6oQEmzqFu75yMvT9mYIfnqKDI=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Wed, 08 May 2024 17:55:40 +0800
Subject: [PATCH 3/4] mm/ksm: union hlist_node with list_head in struct
 ksm_stable_node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-b4-ksm-counters-v1-3-e2a9b13f70c5@linux.dev>
References: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
In-Reply-To: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, Stefan Roesch <shr@devkernel.io>, 
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715162174; l=892;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=9T02FTklfVUMR7drM2v/kaRCwGZRX7z9/r7McdEQClU=;
 b=YuJNdQkZ4hOohg/ChgI1eEPAZsFyNzgMZ72nhyyjbRyA7QWsyafXvdi4d09ef4lYNSfT+KoKj
 QrNHFhfTfVcBUsmVogPymqqloYcrkQfyOf2Imn1RNmK07HWkiZyl0Ux
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

The ksm_stable_node->hlist_node is used for linking on chain node hlist,
and ksm_stable_node->list_head is used for linking on migration list.

We always stable_node_dup_del() first before adding it on migration list
or list_del() first from migration list before adding it on stable tree.

So we can union hlist_node with list_head to save some memory.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/ksm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 6e0dca3cecf3..87ffd228944c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -162,7 +162,7 @@ struct ksm_stable_node {
 		struct rb_node node;	/* when node of stable tree */
 		struct {		/* when listed for migration */
 			struct list_head *head;
-			struct {
+			union {
 				struct hlist_node hlist_dup;
 				struct list_head list;
 			};

-- 
2.45.0


