Return-Path: <linux-kernel+bounces-283856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EE394F9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1ADD284174
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004FC1991DD;
	Mon, 12 Aug 2024 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0Zlwqli"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185A198A29
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502237; cv=none; b=gYv0qjF6UGglq3QpXIXPNWxrzdrVdQ+uYXsFId6eJyeN25tEsxdpxLHdNlGHbMP0PXglSdC2YEGxfNOw+qPFiLBnC5XnL288Ny5BsWdmLbq0JmakF4lHySK8hr6tWOv4IOq0XdJ7E7mulJgr1uIM5oYUDut1qrIuyzcb4YrDGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502237; c=relaxed/simple;
	bh=7wzGtViqpVZzuhPvzkBp87xBfZgW05gIDV+YZ+kbWBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4e5ZF+toOKfAsBVsrTlfEq+imkkwrzTpq5O+rAd20p5vCBqWWWK/On3TdBnKeWzw9eQHt+nXpOMHRIkaKuuj3uNJ26MCAmosgYzJ5AG039p/ZM3kGtLogydAO3N8HVbKrzSdp3UgpSg2AVhmyj4HLiE1zrS58WIwbGVsc6rYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0Zlwqli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2223C4AF0E;
	Mon, 12 Aug 2024 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723502237;
	bh=7wzGtViqpVZzuhPvzkBp87xBfZgW05gIDV+YZ+kbWBs=;
	h=From:To:Cc:Subject:Date:From;
	b=u0ZlwqliEa4GkN26rqrReNTi8sLMWHeLTMcZTdnYeLxiOlM34WlgqIYJctY8xbBMt
	 vc5oIwzc3PrtHD3K1Pr6zaBgOfMoL82RbGY+yoFRIXuMh+J63DXFsXZxaoloi3PEiM
	 y2GrHd8ORrVDDyjdaiMXrEn0ZEQBZj/LTq8pFgOfPnKcCjZ1Y7UIwydNngQAj1KQ9K
	 6csANk59USYfuAeGekJH2daB7B5fx1XpyoWghfiOQIlAeB6yiJvCZ41LlraJZE3L/F
	 Y3niujXL7/EbpqXKuZlWY/wQXdcnDyHKPLCW9/KNcUDBK9r2Dkz1oFiTCLcOiE9gae
	 Xq9Q1D+2J7UrQ==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 1/2] mm: krealloc: consider spare memory for __GFP_ZERO
Date: Tue, 13 Aug 2024 00:34:34 +0200
Message-ID: <20240812223707.32049-1-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As long as krealloc() is called with __GFP_ZERO consistently, starting
with the initial memory allocation, __GFP_ZERO should be fully honored.

However, if for an existing allocation krealloc() is called with a
decreased size, it is not ensured that the spare portion the allocation
is zeroed. Thus, if krealloc() is subsequently called with a larger size
again, __GFP_ZERO can't be fully honored, since we don't know the
previous size, but only the bucket size.

Example:

	buf = kzalloc(64, GFP_KERNEL);
	memset(buf, 0xff, 64);

	buf = krealloc(buf, 48, GFP_KERNEL | __GFP_ZERO);

	/* After this call the last 16 bytes are still 0xff. */
	buf = krealloc(buf, 64, GFP_KERNEL | __GFP_ZERO);

Fix this, by explicitly setting spare memory to zero, when shrinking an
allocation with __GFP_ZERO flag set or init_on_alloc enabled.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 mm/slab_common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 40b582a014b8..cff602cedf8e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1273,6 +1273,13 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 
 	/* If the object still fits, repoison it precisely. */
 	if (ks >= new_size) {
+		/* Zero out spare memory. */
+		if (want_init_on_alloc(flags)) {
+			kasan_disable_current();
+			memset((void *)p + new_size, 0, ks - new_size);
+			kasan_enable_current();
+		}
+
 		p = kasan_krealloc((void *)p, new_size, flags);
 		return (void *)p;
 	}

base-commit: b8dbbb7fe1db26c450a9d2c3302013154b3431df
-- 
2.46.0


