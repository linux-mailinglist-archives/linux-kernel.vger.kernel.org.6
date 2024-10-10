Return-Path: <linux-kernel+bounces-359504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F44F998C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1441C242DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E071CC15C;
	Thu, 10 Oct 2024 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfced6c/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7D1BD509
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575691; cv=none; b=oOUefVLk0VJEeWisMbK/L7P3ud6pz6v+D5odGj1vhcEqBZkGJyk4FBlYnoF/FgLNGEo8iI6TjCJidoKYR/3iP35WFP0VqN8Ua2hTHtf7TMPqL9dUy47S9vjgECJ1AXkYEtCLBRrakrURrhn6kCxlV/QcjpcqwklyubMwY+Txs2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575691; c=relaxed/simple;
	bh=GN1t3J+8W3oSQGGj3dHb4DWWtjz0LsnfS6J+U5wKFFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AgbEzVm3cs40rRf/Hon8f3GxJ1vVJaepNSEFjOhhRx7RcZrK3CPhxwAcbpjZH4a2dKLRFYv1o1cbYMSPf7245nwjR2PjV2Zh3L7TrLbpjrV/sTbAgUB1+TVQUhpAY+fZu/jYzKMJdrzH45MXYENt4ffoweYdLgxQD105YoD8o0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfced6c/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A19C4CEC5;
	Thu, 10 Oct 2024 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728575691;
	bh=GN1t3J+8W3oSQGGj3dHb4DWWtjz0LsnfS6J+U5wKFFE=;
	h=From:To:Cc:Subject:Date:From;
	b=bfced6c/jQJQmCK28yq2N1pTXN/WCsdOUn8fqiQlm357nae9iIPUVU54iUSvAbYo1
	 +0KQkOtSqJK2QfOwQ+lKYxJR+bFJMVObJ5zggw38O3VieBezyQlRTbZBmUHGyqVEwW
	 xcgj0NoUCY5tdzo+uO2uNgFA4EfE39DSoETvXSGSZYUSnE2R15o+J6S/7/fOPZfhrs
	 1O7AFBUcGhCgKVKBCbwFyMWXHm4kyAkmLPNNc+R1pMxYG0Y9Vg+bHoiLdKUEG9IZn+
	 o/G72XzXBuh75uFWUz4L5uemzbMeEvVXn2J+gK5yCpcPpVY5KHNwfhsE3j4QPVabB+
	 /lnxtxpqw/LIg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/kmemleak: fix typo in object_no_scan() comment
Date: Thu, 10 Oct 2024 18:54:39 +0300
Message-ID: <20241010155439.554416-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Replace "corresponding to the give pointer" with "corresponding to the
given pointer"

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 0400f5e8ac60..17006d8a2afa 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1011,7 +1011,7 @@ static void object_set_excess_ref(unsigned long ptr, unsigned long excess_ref)
 }
 
 /*
- * Set the OBJECT_NO_SCAN flag for the object corresponding to the give
+ * Set the OBJECT_NO_SCAN flag for the object corresponding to the given
  * pointer. Such object will not be scanned by kmemleak but references to it
  * are searched.
  */
-- 
2.43.0


