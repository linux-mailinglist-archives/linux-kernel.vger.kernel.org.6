Return-Path: <linux-kernel+bounces-212404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6492D905FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782191C21400
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FD9D535;
	Thu, 13 Jun 2024 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP3f3zHl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD54BE7F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238724; cv=none; b=F5UJqyVm//sDDUe6d7Faj3Q3p6K5dGILY7dHg6Ag64olBtNr7MqWxU9FUaef9yRf9q9qzyUPRH4TE9TKt6NaATstDIJLn+JXOGuD8qWzLWibvsmjgMRx3fML6QWWyPYBIWs0ECFBKwaPS1f6krC1wUlD3a44DuhlWzLmxFqM3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238724; c=relaxed/simple;
	bh=CzUcaUEwid9QP2s+ip8EXYQc/owNHwh0AeSROulmsmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYAbzm9OOxNh172sfo+WouRtBc4kI7/wll1wDCTiRH1O7AVIZzj4xLdUsTZvnNLvAULdE7YaRn4jNS4+w8i2S+3qp1lhpZJ9vk/9Ew/xiNef/2jckDlieH1OQ3l3hzhaS9H/2tKNzm5dh0hJ4TeSfNG+GsxEGmS/5U+qzou51xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RP3f3zHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D945DC4AF1D;
	Thu, 13 Jun 2024 00:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718238723;
	bh=CzUcaUEwid9QP2s+ip8EXYQc/owNHwh0AeSROulmsmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RP3f3zHljgB69meR2mgyyG8IzWJoRo8SVqkFr5jfvu+xVTg/9RN/q30+sHnDWuMxl
	 cOlOAXD7rIeLJKCCvtMVWLt31QrLWRSCcAch7K95GAH7Mnc8G3A4wMkATg977X20iB
	 B+MLf8f0KbV/kqBoxlbbN6+gSMztY/CT1fFGniRjB+HV6/iIiM38HY0y0dxQJDP2Tn
	 HCsE9Pp9aryZMOnBs/QgAmmtmWj72asyKJPsBCxG8LAtAv8LJPLxo5rrd0QtPjJBR0
	 RlRcvvz+zp5UFD2kSU2GUzfqgLdpXX3xs/Egop2Q/h6r7oizsqbu7GbHCqiuDGHOFA
	 3QXMDfaZ6ZFNg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/lib: copy_page: s/stnp/stp
Date: Thu, 13 Jun 2024 08:18:12 +0800
Message-ID: <20240613001812.2141-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stnp performs non-temporal store, give a hints to the memory system
that caching is not useful for this data. But the scenario where
copy_page() used may not have this implication, although I must admit
there's such case where stnp helps performance(good). In this good
case, we can rely on the HW write streaming mechanism in some
implementations such as cortex-a55 to detect the case and take actions.

testing with https://github.com/apinski-cavium/copy_page_benchmark
this patch can reduce the time by about 3% on cortex-a55 platforms.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/lib/copy_page.S | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index 6a56d7cf309d..4c74fe2d8bd6 100644
--- a/arch/arm64/lib/copy_page.S
+++ b/arch/arm64/lib/copy_page.S
@@ -32,21 +32,21 @@ SYM_FUNC_START(__pi_copy_page)
 1:
 	tst	x0, #(PAGE_SIZE - 1)
 
-	stnp	x2, x3, [x0, #-256]
+	stp	x2, x3, [x0, #-256]
 	ldp	x2, x3, [x1]
-	stnp	x4, x5, [x0, #16 - 256]
+	stp	x4, x5, [x0, #16 - 256]
 	ldp	x4, x5, [x1, #16]
-	stnp	x6, x7, [x0, #32 - 256]
+	stp	x6, x7, [x0, #32 - 256]
 	ldp	x6, x7, [x1, #32]
-	stnp	x8, x9, [x0, #48 - 256]
+	stp	x8, x9, [x0, #48 - 256]
 	ldp	x8, x9, [x1, #48]
-	stnp	x10, x11, [x0, #64 - 256]
+	stp	x10, x11, [x0, #64 - 256]
 	ldp	x10, x11, [x1, #64]
-	stnp	x12, x13, [x0, #80 - 256]
+	stp	x12, x13, [x0, #80 - 256]
 	ldp	x12, x13, [x1, #80]
-	stnp	x14, x15, [x0, #96 - 256]
+	stp	x14, x15, [x0, #96 - 256]
 	ldp	x14, x15, [x1, #96]
-	stnp	x16, x17, [x0, #112 - 256]
+	stp	x16, x17, [x0, #112 - 256]
 	ldp	x16, x17, [x1, #112]
 
 	add	x0, x0, #128
@@ -54,14 +54,14 @@ SYM_FUNC_START(__pi_copy_page)
 
 	b.ne	1b
 
-	stnp	x2, x3, [x0, #-256]
-	stnp	x4, x5, [x0, #16 - 256]
-	stnp	x6, x7, [x0, #32 - 256]
-	stnp	x8, x9, [x0, #48 - 256]
-	stnp	x10, x11, [x0, #64 - 256]
-	stnp	x12, x13, [x0, #80 - 256]
-	stnp	x14, x15, [x0, #96 - 256]
-	stnp	x16, x17, [x0, #112 - 256]
+	stp	x2, x3, [x0, #-256]
+	stp	x4, x5, [x0, #16 - 256]
+	stp	x6, x7, [x0, #32 - 256]
+	stp	x8, x9, [x0, #48 - 256]
+	stp	x10, x11, [x0, #64 - 256]
+	stp	x12, x13, [x0, #80 - 256]
+	stp	x14, x15, [x0, #96 - 256]
+	stp	x16, x17, [x0, #112 - 256]
 
 	ret
 SYM_FUNC_END(__pi_copy_page)
-- 
2.43.0


