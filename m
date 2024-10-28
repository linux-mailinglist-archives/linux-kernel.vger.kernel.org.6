Return-Path: <linux-kernel+bounces-385230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BCC9B3448
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FD71F228CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552CB1DE2B5;
	Mon, 28 Oct 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJani4A8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E618FDB0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127842; cv=none; b=cl0YWfFMKcDuiOBuArd3YWn4Z/AIyCHq14QwenNWdLkcYt7KFiqXIJVBpfzTSpdIO3/QDBw7kdHxOaedtfMZ4NZ3+DKz0yOIZ1oSWn7c1mLjn8vdkCzOG8lpurGcFb38bxjIMFcCbxP9aQMXAt5hxCdjfSPELuvmo2GuOqBzaCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127842; c=relaxed/simple;
	bh=9DKucJAMVJnnAVsXS4EbUuo5VofsFWCwsQVHMFgdhCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PNBMNcD+nJPJcTDLboGbx0SwEAXFgx4u7KgJG+NUTzQ6t/sj/DzIx/9P8UM1J7tLva/p6IyyuTDHodcTjeG1zkUR0ZbX+YzXZA1kHJQlUtP7N0zGROs+xWEwI5y1Ev9Ihjni4rhWmDcnln14Pdw+kzMvHeVvCqOLn2O6GMRFQK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJani4A8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C1DC4CEC3;
	Mon, 28 Oct 2024 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730127842;
	bh=9DKucJAMVJnnAVsXS4EbUuo5VofsFWCwsQVHMFgdhCQ=;
	h=From:To:Cc:Subject:Date:From;
	b=JJani4A82gdCARix81qoV0FwX/XHiDTUO+8EQ/Q4TtsYJkxIjOTHs1FItrYCdO+B6
	 6NzfDRSEGNFMirHsAK0NW3dsWJ/OgmTgzj4yD45obmUDNp9iVf3FOKOuAyLMnT6aki
	 VHlD849YOm2VwMz0r71/rpmYjUWdfHkYxbbXuvcqT2bBiOemt4iWYv3QHTjZbu5xdW
	 VuQYjtH5HMdBw3rQTsLjdEPcw1BLUjSucbkIbyZvTch3A6WBCHeLg+A3azaDL7+txd
	 n0ukrWp2mtaYHBQouNjm5W200INRBMC2UKtt7n/GsqL58mibGycl7yq2rF0+KhBELK
	 gMS7/pUkQrgpA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Suren Baghdasaryan <surenb@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mike Rapoport <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Song Liu <song@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] alloc_tag: hide execmem_vmap() on !MMU
Date: Mon, 28 Oct 2024 15:03:53 +0000
Message-Id: <20241028150355.2574425-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added function fails to link on nommu kernels, but is also
not needed there:

ld.lld-20: error: undefined symbol: __get_vm_area_node
>>> referenced by execmem.c
>>>               mm/execmem.o:(execmem_vmap) in archive vmlinux.a
>>> referenced by execmem.c
>>>               mm/execmem.o:(execmem_vmap) in archive vmlinux.a

Move it into the #ifdef block along with execmem_vmalloc().

Fixes: 57bc3834fb6f ("alloc_tag: populate memory for module tags as needed")
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/execmem.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 5c0f9f2d6f83..317b6a8d35be 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -64,6 +64,22 @@ static void *execmem_vmalloc(struct execmem_range *range, size_t size,
 
 	return p;
 }
+
+struct vm_struct *execmem_vmap(size_t size)
+{
+	struct execmem_range *range = &execmem_info->ranges[EXECMEM_MODULE_DATA];
+	struct vm_struct *area;
+
+	area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
+				  range->start, range->end, NUMA_NO_NODE,
+				  GFP_KERNEL, __builtin_return_address(0));
+	if (!area && range->fallback_start)
+		area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
+					  range->fallback_start, range->fallback_end,
+					  NUMA_NO_NODE, GFP_KERNEL, __builtin_return_address(0));
+
+	return area;
+}
 #else
 static void *execmem_vmalloc(struct execmem_range *range, size_t size,
 			     pgprot_t pgprot, unsigned long vm_flags)
@@ -368,22 +384,6 @@ void execmem_free(void *ptr)
 		vfree(ptr);
 }
 
-struct vm_struct *execmem_vmap(size_t size)
-{
-	struct execmem_range *range = &execmem_info->ranges[EXECMEM_MODULE_DATA];
-	struct vm_struct *area;
-
-	area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
-				  range->start, range->end, NUMA_NO_NODE,
-				  GFP_KERNEL, __builtin_return_address(0));
-	if (!area && range->fallback_start)
-		area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
-					  range->fallback_start, range->fallback_end,
-					  NUMA_NO_NODE, GFP_KERNEL, __builtin_return_address(0));
-
-	return area;
-}
-
 void *execmem_update_copy(void *dst, const void *src, size_t size)
 {
 	return text_poke_copy(dst, src, size);
-- 
2.39.5


