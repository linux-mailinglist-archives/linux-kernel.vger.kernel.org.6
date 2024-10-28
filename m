Return-Path: <linux-kernel+bounces-384040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56909B2387
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 04:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139221C20F31
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08D9186616;
	Mon, 28 Oct 2024 03:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etGuEUQL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6228C11
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730085991; cv=none; b=eqarHn7/DAKzxpYHtrBdb5XmFdYGGFGUGIxFSIYnteY/qghyw+FGJldHjRRFhjBtTToN04C3PTfJA8a1gXxgQvUJJ2vsElQ/eoxg3O02RfTPk0nOCDsfoOWsvxqx+q1mOKGbA6RgJxIYx72H6QTcMV2KpO09g9sTs7drATaQedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730085991; c=relaxed/simple;
	bh=wsyKI219Uy+NE28dwnFpejiIUgxT0s45lNvb4gOQOqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Enrb8srmKHhkc+X3wXnykxX/C9oSGr3wRMMqbLcCGaXo6G4o+P+yqOrfTW9OsZ+sDSceZ4OPZOEFZtGIwyc47fxQTTjcv5uu8f24r6tlKO+vkGOrHzMGVlgtYbz8ic3GamyXIU3MffvM7OuArLJybfRJhWXE3DPTeW1+p9yKT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etGuEUQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7970AC4CEC3;
	Mon, 28 Oct 2024 03:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730085990;
	bh=wsyKI219Uy+NE28dwnFpejiIUgxT0s45lNvb4gOQOqI=;
	h=From:To:Cc:Subject:Date:From;
	b=etGuEUQLVkXZOuKI4a4BFVbpHVS6FlG5+QL+meiPq90d1p/8Zde+J9WVOlhFzRoWo
	 ParNe55fL39WDdHJJ9BAzgCuZaYSK7TXA8D6/e1DzQEBuqviww/YGHiU7oj/bcQx92
	 5tNrcbQhQt3tlo3C2z36mNorKrh65Y/XJe6oUVHXF7gS4FaMw28o8YSbUeimwTUACF
	 /9LOvC+bjrF9yB8hoWZ50xKyjCK/t/zDU3ATnAnbE2Yg0vU88i3S4cL/D5+jFlXRPL
	 5MsEciSO8bwwML9cgE9H5hlsslejLazHFp6mLEUZpQqcRueLKO5lrcMGpqm+73LvTV
	 /xxET9jq8Avjg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Leo Yan <leo.yan@arm.com>,
	Mikel Rychliski <mikel@mikelr.com>,
	Viktor Malik <vmalik@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] objpool: Fix to make percpu slot allocation more robust
Date: Mon, 28 Oct 2024 12:26:27 +0900
Message-ID:  <173008598713.1262174.2959179484209897252.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since gfp & GFP_ATOMIC == GFP_ATOMIC is true for GFP_KERNEL | GFP_HIGH,
it will use kmalloc if user specifies that combination. Here the reason
why combining the __vmalloc_node() and kmalloc_node() is that the vmalloc
does not support all GFP flag, especially GFP_ATOMIC. So we should check
if gfp & (GFP_ATOMIC | GFP_KERNEL) != GFP_ATOMIC for vmalloc first. This
ensures caller can sleep.
And for the robustness, even if vmalloc fails, it should retry with
kmalloc to allocate it.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/all/CAHk-=whO+vSH+XVRio8byJU8idAWES0SPGVZ7KAVdc4qrV0VUA@mail.gmail.com/
Fixes: aff1871bfc81 ("objpool: fix choosing allocation for percpu slots")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/objpool.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/objpool.c b/lib/objpool.c
index fd108fe0d095..b998b720c732 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -74,15 +74,21 @@ objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
 		 * warm caches and TLB hits. in default vmalloc is used to
 		 * reduce the pressure of kernel slab system. as we know,
 		 * mimimal size of vmalloc is one page since vmalloc would
-		 * always align the requested size to page size
+		 * always align the requested size to page size.
+		 * but if vmalloc fails or it is not available (e.g. GFP_ATOMIC)
+		 * allocate percpu slot with kmalloc.
 		 */
-		if ((pool->gfp & GFP_ATOMIC) == GFP_ATOMIC)
-			slot = kmalloc_node(size, pool->gfp, cpu_to_node(i));
-		else
+		slot = NULL;
+
+		if ((pool->gfp & (GFP_ATOMIC | GFP_KERNEL)) != GFP_ATOMIC)
 			slot = __vmalloc_node(size, sizeof(void *), pool->gfp,
 				cpu_to_node(i), __builtin_return_address(0));
-		if (!slot)
-			return -ENOMEM;
+
+		if (!slot) {
+			slot = kmalloc_node(size, pool->gfp, cpu_to_node(i));
+			if (!slot)
+				return -ENOMEM;
+		}
 		memset(slot, 0, size);
 		pool->cpu_slots[i] = slot;
 


