Return-Path: <linux-kernel+bounces-537933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812CBA49298
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAE6188C5FF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8CF1DC197;
	Fri, 28 Feb 2025 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a4goRKM7"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84911DA614
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729525; cv=none; b=m7m2YM/OFKvDWSHDKMhDK/6tvEFkW89b2gxXRxUMD0irE5RWqRkl5RaLBGgeTvlkjQ4WiRMB3Su+6JxixKtrD4Af4mZI+qWQuTzi0GrnwyR8Mz9jxPLdgK/Gs8PhZYuQFUHsO2pMrlEJKnb3Y/8daasL3NSABosO3Tff1r+nxzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729525; c=relaxed/simple;
	bh=6PbihMNTnIkkQvZLlThPRIBzMBGa5NVhsdPURXHpnno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5qZP9XZkl08Z4HCQG1Dp2TujYwF9b+bwZmTuJLK7AJyFWukS5x5HodgjRH8i2UjcLKzutLGy1PyCLq7V0YZIOTZIVgfbwUrqZaQeL5V906dKTYfelfQhkVu6j+3anigFGvaj4ogpmNpfuRJTq0qdGYIEX98BPaH0Ok6DTWJEgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a4goRKM7; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740729521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BK/lHOWMvSnS+WIRroS9/stVhRR6z5AG9NC04iFYhYg=;
	b=a4goRKM7J4ZIFDTPgn+GjDlc39QJ1F7e412TgXrydAts3sFCMK9dW4A0cowefVceam44tp
	K3tH5jwmqqjoQI8//8jeZpIbMkvjfX4T0xF1SsSOoa542AKlyodxF5cSdAiGkuD8KaGpJn
	j3xB5Zl+kCBqKe9Kkn2PM8DhkM1po7Y=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 3/3] page_counter: reduce struct page_counter size
Date: Thu, 27 Feb 2025 23:58:08 -0800
Message-ID: <20250228075808.207484-4-shakeel.butt@linux.dev>
In-Reply-To: <20250228075808.207484-1-shakeel.butt@linux.dev>
References: <20250228075808.207484-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The struct page_counter has explicit padding for better cache alignment.
The commit c6f53ed8f213a ("mm, memcg: cg2 memory{.swap,}.peak write
handlers") added a field to the struct page_counter and accidently
increased its size. Let's move the failcnt field which is v1-only field
to the same cacheline of usage to reduce the size of struct
page_counter.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/page_counter.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index e4bd8fd427be..d649b6bbbc87 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -9,10 +9,12 @@
 
 struct page_counter {
 	/*
-	 * Make sure 'usage' does not share cacheline with any other field. The
-	 * memcg->memory.usage is a hot member of struct mem_cgroup.
+	 * Make sure 'usage' does not share cacheline with any other field in
+	 * v2. The memcg->memory.usage is a hot member of struct mem_cgroup.
 	 */
 	atomic_long_t usage;
+	unsigned long failcnt; /* v1-only field */
+
 	CACHELINE_PADDING(_pad1_);
 
 	/* effective memory.min and memory.min usage tracking */
@@ -28,7 +30,6 @@ struct page_counter {
 	unsigned long watermark;
 	/* Latest cg2 reset watermark */
 	unsigned long local_watermark;
-	unsigned long failcnt; /* v1-only field */
 
 	/* Keep all the read most fields in a separete cacheline. */
 	CACHELINE_PADDING(_pad2_);
-- 
2.43.5


