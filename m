Return-Path: <linux-kernel+bounces-417156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721A09D4FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35446283BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F281DD0DC;
	Thu, 21 Nov 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3xC5VWd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6721DBB19
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202999; cv=none; b=QiDmZRhZCWPFUARQoryN5y9eFEUWw9aIug4QeSCa5g2RTz+1gLPHMtM+zbigwq1qd1Hm1b6p1c4Tln7LKMD0uHIf/8NehhbywwLkLDmCmF96RMxCY1j6QhUIEU8OC3sd4VmobleIo7Qw/ojbAkq0IZXfgiB35jBulfYrVEyjDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202999; c=relaxed/simple;
	bh=F5igAvDvGxe5zSohUU0aBj7vqkvV7yrcGAfEW1EiIq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAs5Br4h07/N5SOfv2gZGKopw3s03OFd9MzMt6Dz2sFkmYMj1R5yNeqOjVDe4JqvlbFpkMckA7hgLpx1XLx8gsAoiSWHQBiqPQwm17mR2YBnKf3OADS6+1XYEckXkdn/fBmwuM/p609RCQ8k/5ZU7wVAjpy8wPKABGAep2K6AGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3xC5VWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69A0C4CECC;
	Thu, 21 Nov 2024 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732202999;
	bh=F5igAvDvGxe5zSohUU0aBj7vqkvV7yrcGAfEW1EiIq4=;
	h=From:To:Cc:Subject:Date:From;
	b=V3xC5VWdxChbC1RKGEgCmkK1MgbPvKMFuXG4p/BVtvLZzedPb0RvxevRyDzSAr2Wh
	 5MWaWTkBBNfjSGxR5OWqoATzeFF7eGHs0xOBH8Krh/8gtb0DB+rxQ7L9gZtXezZ5Zp
	 sp/6rOMC1xQNR9YjVzXNPmEU1bneMsCn8e9Y2vW639/XvjlxtQIyuE3UW/XpCOWlGd
	 SC+gi0Ill+ZV/Gb2SxsYvCf34EL3AJx2gya3zLhlnTDpEuWFQrQXdxHENIe/H2bcvJ
	 JHoVYgOsH/AEU5QcH71X9MJ3vYv4mPYPzkviTv28qn3SFC6uFOATPpgvbDlJ7K4V3e
	 +3z91jfATJZXw==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH] delay: Fix ndelay() spuriously treated as udelay()
Date: Thu, 21 Nov 2024 16:29:31 +0100
Message-ID: <20241121152931.51884-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent rework on delay functions wrongly ended up calling __udelay()
instead of __ndelay() for nanosecond delays, increasing those by 1000.

As a result hangs have been observed on boot

Restore the right function calls.

Fixes: 19e2d91d8cb1 ("delay: Rework udelay and ndelay")
Reported-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/asm-generic/delay.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
index 76cf237b6e4c..03b0ec7afca6 100644
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -75,11 +75,11 @@ static __always_inline void ndelay(unsigned long nsec)
 {
 	if (__builtin_constant_p(nsec)) {
 		if (nsec >= DELAY_CONST_MAX)
-			__bad_udelay();
+			__bad_ndelay();
 		else
 			__const_udelay(nsec * NDELAY_CONST_MULT);
 	} else {
-		__udelay(nsec);
+		__ndelay(nsec);
 	}
 }
 #define ndelay(x) ndelay(x)
-- 
2.46.0


