Return-Path: <linux-kernel+bounces-173151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ABE8BFC3C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A611C20AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0DA824BB;
	Wed,  8 May 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ex3Q7xo6"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F9E29CF0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168274; cv=none; b=oeiobjAOZGV6aZ0O9UHAQNCvFWxTaRpRX6zDXhNV8AlZ5C0UnbK2Jj4OBx604HnlcBAZDYal2iNGNZHqt6uSazNuN/90sV1C9vwGTdjulobspa2FqgS3byjmIEJgiuRuf2iyjyCWg+tVy76nmx0iCF0/gLhdy3z7QgdjJX32mhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168274; c=relaxed/simple;
	bh=sxN0YLCXI7Y0n4Vqh32lIleqSk9k9glYHc0FeQ3opkw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MPi71J2yuwSFTKN3v+0+bO/69I43nvyyef2S+M8ZKaM6IF2bfUSfdhuEnSYIvBx3avxm/RGk3REfJ4RnEr+prIBTtGNDL7VKbXyVaj4lD73ekJSEbAch7BQspf/Q5SgQpwRVEf11vKIrZMCAwcd13zRamANaR7wdUv22eMJVKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ex3Q7xo6; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715168270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nriJEVBMEpCdnex06+BPZnBx6tE8hsLyPOQq2hal354=;
	b=ex3Q7xo6XxXF9sAXpowIwtq58PLnspUgVPY7Jq67105CmPW5K8ZUerwT2EcgIiEadTMPlc
	huyN3mAiw9RQq9uTbS2fzOh5XtoPRXdokFTA4viKM3qK0/m+h0XN80hoQWzn/K5wo8Mi0P
	1EhyYdbqJ3g37Qh2MBFEMmtqh5W6wFQ=
From: Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH 0/2] mm/ksm: optimize unstable_tree_search_insert()
Date: Wed, 08 May 2024 19:35:40 +0800
Message-Id: <20240508-b4-ksm-unstable-insert-v1-0-631cdbc2b77f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIxjO2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwML3SQT3eziXN3SvOKSxKQcoHQe0IQSXQNjI0sTEzNjQ/NUQyWg5oK
 i1LTMCrDB0bG1tQCaTOApaAAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Stefan Roesch <shr@devkernel.io>, 
 Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715168266; l=1099;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=sxN0YLCXI7Y0n4Vqh32lIleqSk9k9glYHc0FeQ3opkw=;
 b=auCEXbRktUQ9FKc3gKpYnYUR7iK9/N90VPMUkT6rOdxgYnMpoJViDw/Krb3BzqjXzp9UHYrax
 bnrgoo4ea6RCOB7VY06Xr/EL6EdKRT1LTL9bxwJvwOKZkl7vTIb/cut
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

We use unstable_tree_search_insert() to find matched page or insert our
rmap_item into the unstable tree if no matched found.

Now it may return NULL too early in which cases we can do better:

1. get_mergeable_page() return NULL: which means tree_rmap_item is stale.
2. tree_page is migrated to another node and !ksm_merge_across_nodes.

In both cases, we can just remove the staled or migrated one out of the
unstable tree, so our rmap_item can be inserted successfully. The code
flow becomes clearer and may increase the merge possibility too.

Thanks for review and comments!

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
Chengming Zhou (2):
      mm/ksm: re-search unstable tree when tree_rmap_item is stale
      mm/ksm: flush out migrated rmap_item to insert our rmap_item

 mm/ksm.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)
---
base-commit: fb0f40125feec3de7ef4524600ac83946207117e
change-id: 20240508-b4-ksm-unstable-insert-0329446317e1

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>


