Return-Path: <linux-kernel+bounces-537445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAB0A48BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C850616F82D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0D023E354;
	Thu, 27 Feb 2025 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIbWNI1f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA0E277818;
	Thu, 27 Feb 2025 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696312; cv=none; b=C4NcuETXzjsBjojE15FIT+RrhfmMPiFm5tmoMSombMM/GLVAbeDTK6AwXkeJzvpgJJQz/sktmpyhb7fDMpmkiJAqg8DZ85Vl4bVF8tVruRC1MaBbFsOJTj5RW6rNbWiiwzzZIViDNhmxlgZPeBp8jAerjpb6+KfXzgL24i1jCVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696312; c=relaxed/simple;
	bh=5VUaBxuG5jp6oEMwAW0wKmDoN3rdkjGw0TFuNrg+m+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IpsnInm/nlbo2PLSt8VoleaYYL1MdlB2fi9odP+6bC/WU1S+iCTys+uMzJWZibVEd7wHT85Ga3qZQj9MAecw9aU/ZojrZ9zC3Gq7BMblMhzo2KEuRWIbfBD1PHKRCpFzdUAdG/0yS7BDaDLh7DqS156GbjobWV9crDFBXUHz36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIbWNI1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64B26C4CEE8;
	Thu, 27 Feb 2025 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740696312;
	bh=5VUaBxuG5jp6oEMwAW0wKmDoN3rdkjGw0TFuNrg+m+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AIbWNI1fPa7uLDSTJHqb+aMq4O2v6EjYleUo/trN0mvO5DnibejG3dT2HjLPaepFh
	 ZnhsEQ30ZZY3pM+5p/thRs9BPloJHBRZCkBn3MrAT3SHlGPFMgHk5Dm7yzRk0LHL0A
	 09R8dO5+S/4hunZS+zMlzRzgx4xeWNjnnLoIa9ZsiNBDr1zAaa3ySW6AFgtpFvNb2f
	 uHRzYoTjAEDOJrv/dqXNVTK09k2kwBOFcrQLuZVeR3kl9RzFrpDzRocxIx0kM+P6Gm
	 w0SP2VSrM8qfJkHEigWSVyOucD4I05vdGilmSj4S7exw+CdeWNlNC5Jjkgc72cSLp2
	 M19qkLV2KER4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AA5C282C7;
	Thu, 27 Feb 2025 22:45:12 +0000 (UTC)
From: Thomas Prescher via B4 Relay <devnull+thomas.prescher.cyberus-technology.de@kernel.org>
Date: Thu, 27 Feb 2025 23:45:07 +0100
Subject: [PATCH v2 3/3] mm: hugetlb: log time needed to allocate hugepages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-hugepage-parameter-v2-3-7db8c6dc0453@cyberus-technology.de>
References: <20250227-hugepage-parameter-v2-0-7db8c6dc0453@cyberus-technology.de>
In-Reply-To: <20250227-hugepage-parameter-v2-0-7db8c6dc0453@cyberus-technology.de>
To: Jonathan Corbet <corbet@lwn.net>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Thomas Prescher <thomas.prescher@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740696310; l=1238;
 i=thomas.prescher@cyberus-technology.de; s=20250221;
 h=from:subject:message-id;
 bh=DnQm/ufrOp5KRhZift3qcnZk9CLmrzaedzUcrpSfRg8=;
 b=7/+8mcgFy1AHR3tc4v90RSb52SvqhIl5u321vKgF5hXYbL35rYRH5EJuWaxQKtZBEANJ4FLsE
 GApQqF2DaSKBUdDMSL2HpAgAZcgZL7SlkW9ZTzWOBBtKUR8eUEF7l+i
X-Developer-Key: i=thomas.prescher@cyberus-technology.de; a=ed25519;
 pk=T5MVdLVCc/0UUyv5IcSqGVvGcVkgWW/KtuEo2RRJwM8=
X-Endpoint-Received: by B4 Relay for
 thomas.prescher@cyberus-technology.de/20250221 with auth_id=345
X-Original-From: Thomas Prescher <thomas.prescher@cyberus-technology.de>
Reply-To: thomas.prescher@cyberus-technology.de

From: Thomas Prescher <thomas.prescher@cyberus-technology.de>

Having this information allows users to easily tune
the hugepages_node_threads parameter.

Signed-off-by: Thomas Prescher <thomas.prescher@cyberus-technology.de>
---
 mm/hugetlb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 98dbfa18bee01d01b40cc7c650cd3eca5eae2457..373b6ac4a3824555f91ad9895e66f631f6e1ba82 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3430,6 +3430,9 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 		.numa_aware	= true
 	};
 
+	unsigned long jiffies_start;
+	unsigned long jiffies_end;
+
 	job.thread_fn	= hugetlb_pages_alloc_boot_node;
 	job.start	= 0;
 	job.size	= h->max_huge_pages;
@@ -3457,7 +3460,14 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 
 	job.max_threads	= hugepage_allocation_threads;
 	job.min_chunk	= h->max_huge_pages / hugepage_allocation_threads;
+
+	jiffies_start = jiffies;
 	padata_do_multithreaded(&job);
+	jiffies_end = jiffies;
+
+	pr_info("HugeTLB: allocation took %dms with hugepage_allocation_threads=%ld\n",
+		jiffies_to_msecs(jiffies_end - jiffies_start),
+		hugepage_allocation_threads);
 
 	return h->nr_huge_pages;
 }

-- 
2.48.1



