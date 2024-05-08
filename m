Return-Path: <linux-kernel+bounces-172999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AEF8BF9E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D0D287AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B847D08F;
	Wed,  8 May 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FWaZtJ6E"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CE7C0B7
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162182; cv=none; b=VeCryYyNOMmmxauBSGbUwRPO2fifLP2hrewhu7XeFYaGjd+hoit1ZbBb+K9mrXWeuHvsZpODtZGjRSTjb5v/zIhY6VQLC7qz9dDbUVhF5jp6d1r1GI0WraF0Bv9ziwRqrblj8r+By9rddv7p+7N8/Upznf3hBn4+vnV4sQkKJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162182; c=relaxed/simple;
	bh=Xxa7Ak0JI97EX+j9mxn9LmkgnjWch4hCajYnLCWYtp0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LlaTZtCxd118goJQrJStTgdqLIE6MUhh35NBnNVYHoYhJMCNZmyyKRMAIUuf27vhXX7e+hs/GZY7YY56nyK8nzIf6xTf7S8TnOFiEZZpHTiJCg3FN8MFqtNkCvcK4dbvfc/97zCcw28wZ7DVbV0OVsXf1k0mQOmN60iy/RDIw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FWaZtJ6E; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715162177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3rfrWz+6jXK312Dthrz355nwHvsfvj5vadJvhiAehC4=;
	b=FWaZtJ6EmE5ajyj+bblbTGBTtgONcus1MnonF9Pkh+aQFyhRFoq+NBumkk3xIwkzheiMu0
	jV5mhd1pVi+7dDBiMnBLL42njPH+qsK9nB5gvcfXc1Fbgsv0r5pkaA8zJ/uGXjBvF4IB1m
	kB4JdnlkEgEzOR7tsvbJZzvnZ1c4mDk=
From: Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH 0/4] mm/ksm: fix some accounting problems
Date: Wed, 08 May 2024 17:55:37 +0800
Message-Id: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABlMO2YC/x3M3QpAQBBA4VfRXJsarMiryIWfwSRLO0ht++42l
 9/FOR6UnbBCk3hw/IjKYSOyNIFx7e3CKFM05JQbKqnGweCmO47HbS92imTqrBoMTQUzxOp0PMv
 7H9suhA/i9v2yYQAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, Stefan Roesch <shr@devkernel.io>, 
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715162174; l=1119;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=Xxa7Ak0JI97EX+j9mxn9LmkgnjWch4hCajYnLCWYtp0=;
 b=+IXTS3FedlIkxYy/lsaCO6YZfszKIIILCFsM7u+20GeXZ1GpnMkUzX6VWlPxYgNbKOMKgUeqM
 dYSbvZXHXR4CZVw7OpPEQ8SHtqq1Dhrw1oJjEuh/tC/1/VsThtKXtAH
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

We encounter some abnormal ksm_pages_scanned and ksm_zero_pages during
some random tests.

1. ksm_pages_scanned unchanged even ksmd scanning has progress.
2. ksm_zero_pages maybe -1 in some rare cases.

The first two patches fix these problems and the last two patches are
minor optimizations about ksm_stable_node and general_profit calculation.

Thanks for review and comments!

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
Chengming Zhou (4):
      mm/ksm: fix ksm_pages_scanned accounting
      mm/ksm: fix ksm_zero_pages accounting
      mm/ksm: union hlist_node with list_head in struct ksm_stable_node
      mm/ksm: calculate general_profit more accurately

 fs/proc/base.c           |  2 +-
 include/linux/ksm.h      | 22 +++++++++++++++++++---
 include/linux/mm_types.h |  2 +-
 mm/ksm.c                 | 33 ++++++++++++++++++++-------------
 4 files changed, 41 insertions(+), 18 deletions(-)
---
base-commit: fb0f40125feec3de7ef4524600ac83946207117e
change-id: 20240508-b4-ksm-counters-04817b40d3ee

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>


