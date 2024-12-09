Return-Path: <linux-kernel+bounces-437325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526599E91D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1ED31887AB5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B9021A939;
	Mon,  9 Dec 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GqlIPUsZ"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC45218AA4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742617; cv=none; b=hCwU+8OYlA8SRMjIHp+2IncgVgrcZiLk4PaBflO+ev5x0N/zbJKZy1TNrolMt/dTIYWm5YVht3Tvrp/DK34pK0GCXXw7MwmzphsOYffTSwcQGEojvrNE+ucOv3hIUVNHR03H99VgVgVmqiB97FbHNokEfCTPMMhPj/9lx8Ntt3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742617; c=relaxed/simple;
	bh=VdSKiBu+Rcqkn3++TzGUEBtx2tT3dY6aOPFhyXnz9XE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKQw5GnTq7hHFKpTyVSzNZ2ZB7h8zGANfrgbJG7XqCCLJFbdPx64m+d7pXl89PDX1DtBG3/xtKrYaccV0bYBYewRRHM3r169JJdwLLYwUhsvKJV/RD4kNHCuU9NHaX88zjb88QUO3f5b3wuCNl75wkxBWFjwXqzq/ON63R+Ho/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GqlIPUsZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733742612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uv++zCxQI5KkY3e/HSPDNpzOsNvtyw72J+e80my38dY=;
	b=GqlIPUsZ9NCxnB9VbroiBOqIm3wOUdJzcde3RjClNngkXTTk7OsGfop63CdvnOyV5p50xS
	Y6EqwfXUKeh3ZvrlXPrM3KnZtsNgj699bgmNC6BVRqwQDukoAqWI6QsqOpRB2R8CwoN2RO
	MdjSVTxk0Fj/X3ynkXV6ozyB4Y5BD+0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: Remove zero-length alignment array
Date: Mon,  9 Dec 2024 12:08:56 +0100
Message-ID: <20241209110856.40132-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Align the whole struct to 16 bytes instead of using a zero-length
alignment array.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/xtensa/include/asm/processor.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 7ed1a2085bd7..5c88c97abe4e 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -160,9 +160,7 @@ struct thread_struct {
 	struct perf_event *ptrace_bp[XCHAL_NUM_IBREAK];
 	struct perf_event *ptrace_wp[XCHAL_NUM_DBREAK];
 #endif
-	/* Make structure 16 bytes aligned. */
-	int align[0] __attribute__ ((aligned(16)));
-};
+} __aligned(16);
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
-- 
2.47.1


