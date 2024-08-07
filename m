Return-Path: <linux-kernel+bounces-277478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2932394A1F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E1C1F21F37
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330F1BD507;
	Wed,  7 Aug 2024 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Th7dN6L0"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5218D651
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016720; cv=none; b=VSXRzMv9yorW37PywH0N5Bt54Qo3l+4eTW0Dq38l0PoVLLtNIxTC9kLe0qnf+OoJxUCq2xDciePAcFOZFlSdnE/WFZ7DcSBxW+xlOprsqLY75cumRkeF799aq0vVyF37I1oeOHtTd0UzzvCgvTd4ImBeqpwdUw6fXXUXwcivU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016720; c=relaxed/simple;
	bh=KgiyTf6aSyuMumwWxLopEn9KPS7qUYffLiU0qDd9l4s=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=HTuKscXZ3yByPc4eMMpW3T1uOs2Af25mfb2rMMEsFWqhmp/pq9rQ9OiKm3RhkyDIi5He4al/HHHtOtB5FA81h/IgpCZVKCsNueoj3zDc6EZU1/7vr+BD/iWJqbYV6FU6VQ1VAT9py3KldFZhdcK8qVElVZtxZe3PMJd0RVOyh/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Th7dN6L0; arc=none smtp.client-ip=43.163.128.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723016694; bh=Y3CpHhgGRy3wxGFg+mt4rHeVeRMRfsePx/Ri1lVfaR8=;
	h=From:To:Cc:Subject:Date;
	b=Th7dN6L0HMs8aQHk40aLQHV9vxzkTGc3OxDHy4oeDhUHD8Y8qsH7PcrCwa0WiEOSL
	 3VnOcev4LiYckZf6op8uqnTj9gAF3Rv8LKtEOvjBTO/QYXdXHhZeu46Wowozm4CigF
	 b7B7IHZgePi176cRpwFrV21oyhIQnlGD9QRXmnIY=
Received: from zjh-VirtualBox.zhaoxin.com ([180.169.121.82])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id B329301F; Wed, 07 Aug 2024 15:44:50 +0800
X-QQ-mid: xmsmtpt1723016690tdbqx5ipn
Message-ID: <tencent_AD5C50E8D78C07A3CE539BD5F6BF39706507@qq.com>
X-QQ-XMAILINFO: NOPaPRYlCiG+Y7Y9xg+Fi/hSizbaCbvV5CcI9+BecLxfYPquBCPCYkw21RXIwl
	 mH81F2W7XD4sgmHuDCFUp9NJoD2ZfXWtEPD6ScyNxDoIlOtLtgG94dcPISoYJzQHmgZMMHqWaznl
	 g2dTQXK3Uir50mkSgvKbTWWfafp9sbZpBWzXgr3QGtDYsyqEEmWmVsBk7cxvJZiGE8y5xnpENiQu
	 U6iIQv7agL2q8gwWKoxVTaoC/R+XvDbefpyk0cagd82v8XpWgQpAUQWlC4qRSuMEMfs1iTPsyoWK
	 hs4nJFYwvFRm/ZntLXSPpIy8P7YqecBxkl4oCG6lUps3nueiHWPDwuCQUCA6MqBBcPZk5myCpzVr
	 f5CTdcJ57FoijG9h78KALrgdS5h/SRCHbXRZspKInoEjhMjXa6J/xokdiAOzwcOR03NVL1cz7isr
	 UJVcodbjjE844eJqjy98Yd4J2W13XHkIOTdhuMZDIHOq+Gm2S04ib6WI+i+/sa8Dj9T2gPlwstLa
	 t0ZFAKfjyv5syIFfn/kUwUqkCsgshSXhz8Gr2VyrshV6nYKEYFNCegAUF84W9ePYxduF9bQ/NPZH
	 5ZbE2Ts/B6EnlC5/k1ku62aDRhyQwFcPgQO6QZvXas9z1VqiSPR3WD6ZbQDz1jvFjJuPiiRCCn88
	 xl+87tjz8KfF0rQJ32cpESa+FYdLItwxOAD07oqYTc4INyNHTaijC8dzo6C3WZLOaC20kxXjjspm
	 EKh4WdKCwsjtquBWs/nBOaufr707WlKreiTFCql96TqYtGn7XMemi4Kzfh+81Na78AiN/gGygWcW
	 54UgSJqUuqhR4zkK9XUY3r/aLs7pNOhH1zUNlXqZnvPguu8ItoZ8/f/MIjgqUVGY9gsykp58W+uQ
	 pUcYlp0mAD8nK2bFqUSKLHIYSOIaFfaEPTuK5Wg/HDEGaKgfPTdH9vUki4Txf2NIbfWizN9nRtOJ
	 kaeHuZtCB8V9QNvoGeErMYGb0mWJkGikK4EZ+ZO950woY0czbXPLsoofB8f06sCMlUSA+YtPURpy
	 pfJd/UaNIZ9W3rTtSm0jUECF7VX9dXDKLb8gzF0N8qAU1uCGmJ1NqyJ2DemI0bgfgE5SFDwZBGwx
	 6L5XrFHVKndZIktzW7T3Qh83QUFQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Jianhui Zhou <912460177@qq.com>
To: dennis@kernel.org,
	tj@kernel.org,
	cl@linux.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	JonasZhou@zhaoxin.com,
	Jianhui Zhou <912460177@qq.com>
Subject: [PATCH] percpu: remove pcpu_alloc_size()
Date: Wed,  7 Aug 2024 15:44:48 +0800
X-OQ-MSGID: <20240807074448.31034-1-912460177@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcpu_alloc_size() add in "mm/percpu.c: introduce pcpu_alloc_size()",
which is used to get the allocated memory size in bpf. However,
pcpu_alloc_size() is no longer used in "bpf: Use c->unit_size to
select target cache during free" because its actuall allocated memory
size may change at runtime due to its slab merging mechanism. Therefore,
pcpu_alloc_size() can be removed.

Signed-off-by: Jianhui Zhou <912460177@qq.com>
---
 include/linux/percpu.h |  1 -
 mm/percpu.c            | 31 -------------------------------
 2 files changed, 32 deletions(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 4b2047b78b67..b6321fc49159 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -135,7 +135,6 @@ extern void __init setup_per_cpu_areas(void);
 
 extern void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 				   gfp_t gfp) __alloc_size(1);
-extern size_t pcpu_alloc_size(void __percpu *__pdata);
 
 #define __alloc_percpu_gfp(_size, _align, _gfp)				\
 	alloc_hooks(pcpu_alloc_noprof(_size, _align, false, _gfp))
diff --git a/mm/percpu.c b/mm/percpu.c
index 20d91af8c033..da21680ff294 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2216,37 +2216,6 @@ static void pcpu_balance_workfn(struct work_struct *work)
 	mutex_unlock(&pcpu_alloc_mutex);
 }
 
-/**
- * pcpu_alloc_size - the size of the dynamic percpu area
- * @ptr: pointer to the dynamic percpu area
- *
- * Returns the size of the @ptr allocation.  This is undefined for statically
- * defined percpu variables as there is no corresponding chunk->bound_map.
- *
- * RETURNS:
- * The size of the dynamic percpu area.
- *
- * CONTEXT:
- * Can be called from atomic context.
- */
-size_t pcpu_alloc_size(void __percpu *ptr)
-{
-	struct pcpu_chunk *chunk;
-	unsigned long bit_off, end;
-	void *addr;
-
-	if (!ptr)
-		return 0;
-
-	addr = __pcpu_ptr_to_addr(ptr);
-	/* No pcpu_lock here: ptr has not been freed, so chunk is still alive */
-	chunk = pcpu_chunk_addr_search(addr);
-	bit_off = (addr - chunk->base_addr) / PCPU_MIN_ALLOC_SIZE;
-	end = find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk),
-			    bit_off + 1);
-	return (end - bit_off) * PCPU_MIN_ALLOC_SIZE;
-}
-
 /**
  * free_percpu - free percpu area
  * @ptr: pointer to area to free
-- 
2.25.1


