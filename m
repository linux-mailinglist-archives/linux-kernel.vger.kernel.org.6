Return-Path: <linux-kernel+bounces-252997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447A931B03
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3586281F04
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4504F1369A3;
	Mon, 15 Jul 2024 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOXWL647"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95F31758
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071732; cv=none; b=oxEo4TlQk+ipDQqo7cmq6BUPJnTBkQiaLLlBN0tufxdZWIyGEc9ENeW0ht2um13HtSA/g2ApbqRBalJkYBGZAwhQ1iMj20wK4t35nF1k41rjaExDE+ERktt8/Mm0ibIvM+G0r9nwkkTGccE7TJj35qzVIS8YwEYWOYeqHf8ot1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071732; c=relaxed/simple;
	bh=dzUiu4N9MqVbq0UlB0Fw5kXCttnLRUaDQ96RVLcV1ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpYnQCu90E7yc//BRD7q1GAdaANfuRXv41sxD2HwQmIc1T2awaja4bSWGavyECmF/JbW3tb+n34rUhD3dWKuI/rg8gmTlFS9yXjQBCoRLm/6vUTHK58VJF0TgfqV4mVdFzR0qh4F0qXEPqSruQeFLJ5XGKiY2RK80aScKRX6uwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOXWL647; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E240CC32782;
	Mon, 15 Jul 2024 19:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721071732;
	bh=dzUiu4N9MqVbq0UlB0Fw5kXCttnLRUaDQ96RVLcV1ho=;
	h=From:To:Cc:Subject:Date:From;
	b=LOXWL647vlaPwg5bbyi9t6JTvq9piJsBm2ht1ZEqwd7c+17GqqMrbleLQZid31gSa
	 GbyW+lY9wBiMyPrLoQBZ1xnt+/VXSxS5c3HNZ7jlz9ECUJ9uqNTckWXFd2zABQ88fP
	 6mqo9HwBx+wUli/Tlo4yYYtdTNF+WMy3+353/DA4tkhMnFzFk8mbEuzH5AMU3Jrpiu
	 x4+c9GV1aNV2X8+HBWe98YV4t+gvIHOpZEGOd/QCRkyU2nsLZyVwhPMdQfKdJVE3Bu
	 JyalU2YETzU6Or4l/NHPqKk8Az07ueyUtnb6PGcwc0a2J63kDelLm9uuG2hLimuet3
	 g8cx70mrK/P8w==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2] arm64: remove redundant 'if HAVE_ARCH_KASAN' in Kconfig
Date: Tue, 16 Jul 2024 04:28:17 +0900
Message-ID: <20240715192843.2201439-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 0383808e4d99 ("arm64: kasan: Reduce minimum shadow
alignment and enable 5 level paging"), HAVE_ARCH_KASAN is always 'y'.

The condition 'if HAVE_ARCH_KASAN' is always met.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---

Changes in v2:
 - update description
 - add reviewed-by and acked-by

 arch/arm64/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c87d16b12e9b..d37cbfc3031e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -167,9 +167,9 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN
-	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
-	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
-	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
+	select HAVE_ARCH_KASAN_VMALLOC
+	select HAVE_ARCH_KASAN_SW_TAGS
+	select HAVE_ARCH_KASAN_HW_TAGS if ARM64_MTE
 	# Some instrumentation may be unsound, hence EXPERT
 	select HAVE_ARCH_KCSAN if EXPERT
 	select HAVE_ARCH_KFENCE
-- 
2.43.0


