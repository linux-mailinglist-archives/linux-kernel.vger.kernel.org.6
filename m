Return-Path: <linux-kernel+bounces-268146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096789420CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 758B7B2519D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1348C18CBE2;
	Tue, 30 Jul 2024 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWfirlZU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15918C92D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368540; cv=none; b=cBPsNQZFE9teL4/QFenwluv6WoTG1jWAoAbLOTxqDXT6dYQOPge9G2FJCmoPCiaP0UE5tKxI7H9n7ty/rfuk5wDy8hyJOCRCx12+GXvS6bAz1Hae2TAAZLByi3Yep1INQcHXD6jSzz89UeBBwdk08a0zI31Gy78E3bKfG0DLKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368540; c=relaxed/simple;
	bh=2LdP+yaGyLvvhYc3Idvuj/mK+BX++D9CaCktI4AVghc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZJniaTQ11MD9EisvWd6/tqvlcZibDnRXCbgtAnyMkMXQTArEAdPhF7f5sllPwkoPAcdh+DWU+sTebzpXj+5g7IUIuIXKCoGJvnWhGdruhS8PVcBemOEfePSjJBU38I1NhMedA4z/bt42stDBcWEMIDKRaNQucV1bJDsP2rFFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWfirlZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88303C4AF0B;
	Tue, 30 Jul 2024 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722368539;
	bh=2LdP+yaGyLvvhYc3Idvuj/mK+BX++D9CaCktI4AVghc=;
	h=From:To:Cc:Subject:Date:From;
	b=qWfirlZUmxvQU4E3uad68ZRUdQdYOQoS2Dlu3zOu90XNN3UVB2SfIEI1u93uByfs4
	 /nAnsk9fzX+GOzuQElEDngL2EzwpGr0fiGlyhKKKFUb6OqXA1+DCWFF017EAIblUm8
	 eYn5+orLLFewFDwnymqLVrwTZprZc80wHvOwiMf1K2JgSbyQvH9XGxYBfMiFzyy+Z6
	 YQlg1kLbrVVjlfdAabf00WPulMXYXIsOQo/sLuLvVfl+E4UsXmlVVnnW44B/lvOFcR
	 eiqCk1VZ2UunbCoVl67eqd356b126hCOuEgoR0J+ec1T4aps1lvp9qv82mHz4yKh6z
	 2v71OZIVs64Iw==
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
Subject: [PATCH 1/2] mm: krealloc: consider spare memory for __GFP_ZERO
Date: Tue, 30 Jul 2024 21:42:05 +0200
Message-ID: <20240730194214.31483-1-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
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

base-commit: 7c3dd6d99f2df6a9d7944ee8505b195ba51c9b68
-- 
2.45.2


