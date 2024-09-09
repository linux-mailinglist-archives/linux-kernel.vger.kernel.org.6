Return-Path: <linux-kernel+bounces-322075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F2897239B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22F71F2441E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E77189F58;
	Mon,  9 Sep 2024 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg7XM1id"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D13CF51
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913592; cv=none; b=an54ORm59EWbsjN+qKeSyjHkuxEq1tH27T9/8+tz5Pfo1Y8lVL9T6bho5AupPX0JNWIyQwfMqh1IxbeByFxNpErFMJzzUpyyhBmUu42Q+n71gj9sxAfxyVaAmezokqjJ2E5h6hmO56/aNf3AEHhgxgKo/6s2R0oJru8fQnwDBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913592; c=relaxed/simple;
	bh=V3rJ93Zwx3fhKglzbBXQ0xPAsxMtRNfyG24KXb6eLfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p5cWDGr6ot3Tyqzg0XlT8k2+tYSR5JAux/5cVBvtBQXrZBoP0146Ywa5kW8YKOnJplBiTXOCZJb2b9uiLJwngWGZFnuNVno+8uZKhBU97CKca0zF/SdPKjlPQfIk01tLxQl6lCoQFxn62QpsYdh1AzR15b/JGus6vNxYMZlSP2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg7XM1id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E471C4CEC5;
	Mon,  9 Sep 2024 20:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725913591;
	bh=V3rJ93Zwx3fhKglzbBXQ0xPAsxMtRNfyG24KXb6eLfc=;
	h=From:To:Cc:Subject:Date:From;
	b=Tg7XM1idXNVxN/0TtIWXWZyoRa5V3qVQMI9dW2dwiveiHI4WFmlUhakSf84iWGPr9
	 bWaLNvZxvuKssaRZgzNym12+ID0PLsIBmyVQoLJcNWJM2iq3RvulEMsxLhNDbFwsJk
	 UrNLKFe8r/PYPxU1gf0p6aT9f1J7tVi0IHiqKu0MemvJACtmpHV4ZJW+b0fPP2QBAR
	 RCFNl7dSLwGL7Bj7f0m7XV1FFIU7X2H2O0aiRwhc4dNZn7x6Yp6GU4rKD9LbbwTjKU
	 NBYubRvknIhP2dJdGgqXLwGkbayPlfIEH44fWb5tcXQTA/Lr0vU2M9qxo1XvIdMaF9
	 oshgjWiHUgrEA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chris Down <chris@chrisdown.name>
Cc: Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: z3fold: deprecated ZSWAP_ZPOOL_DEFAULT_Z3FOLD as well
Date: Mon,  9 Sep 2024 20:26:16 +0000
Message-Id: <20240909202625.1054880-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Randconfig builds that use ZSWAP_ZPOOL_DEFAULT_Z3FOLD
now cause a harmless warning:

WARNING: unmet direct dependencies detected for Z3FOLD
  Depends on [n]: Z3FOLD_DEPRECATED [=n]
  Selected by [y]:
  - ZSWAP_ZPOOL_DEFAULT_Z3FOLD [=y] && ZSWAP [=y]

Avoid the warning by selecting Z3FOLD_DEPRECATED instead,
but rename this symbol to ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
in the process so it no longer automatically gets used with
old defconfigs while still allowing users to select it
manually.

Fixes: c68c1bed014d ("mm: z3fold: deprecate CONFIG_Z3FOLD")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/Kconfig | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 7c9930bf8a9d..09aebca1cae3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -146,12 +146,15 @@ config ZSWAP_ZPOOL_DEFAULT_ZBUD
 	help
 	  Use the zbud allocator as the default allocator.
 
-config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
-	bool "z3fold"
-	select Z3FOLD
+config ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
+	bool "z3foldi (DEPRECATED)"
+	select Z3FOLD_DEPRECATED
 	help
 	  Use the z3fold allocator as the default allocator.
 
+	  Deprecated and scheduled for removal in a few cycles,
+	  see CONFIG_Z3FOLD_DEPRECATED.
+
 config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
 	bool "zsmalloc"
 	select ZSMALLOC
@@ -163,7 +166,7 @@ config ZSWAP_ZPOOL_DEFAULT
        string
        depends on ZSWAP
        default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
-       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
        default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
        default ""
 
-- 
2.39.2


