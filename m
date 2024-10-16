Return-Path: <linux-kernel+bounces-367299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614899A0096
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9316D1C240C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552F918BC31;
	Wed, 16 Oct 2024 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFRGkUgY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610418BBB7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056476; cv=none; b=h+hksVGyi6SpnIo7vTEF9u9MGCVpAKes0SJCf7d7qWK7CsQ1WDNqhdVDVQ+dFBQ/dhMG7Q+ew62TJCwvnBnMbQ5GYljbf9VTQ9cix2vk+WHIa7pQWFIZCu+O6X8LhOzX7pqrdvvsz05bZSPT0t7ojTFkews+qah00HEqWWYTKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056476; c=relaxed/simple;
	bh=//4Cx99p5jogEeFkicaoyIn2GOAS1p2Dbd+QLByWjhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MP5bBWxI9t3+ubG1O4eClpaATiR/xKYz2kA8RXltWZyPw+dR9L9eUxaiySaYa90v7FOf+dD6cHEjRO3TF8ytVSOY19JS6n7S+uww4xraM5DDF6qXayS1uuOS5pbwSEmdV2GuzG0pLhv7WPAJp9mgXUYjpUBJQ50tFS9yOxAnZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFRGkUgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A100C4CED1;
	Wed, 16 Oct 2024 05:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729056476;
	bh=//4Cx99p5jogEeFkicaoyIn2GOAS1p2Dbd+QLByWjhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFRGkUgYtZNKeG774KNogSUIWZp4KHQZzO3bZCW27MX+I3d3Ohz08BJshkQB/TNor
	 vFV/AygFwrhh6QsxyXjQgK27CT11YlX7xRWwC7vN8AaOF2jr6kX39EPDQZClVZ3sz0
	 5F16BFDbmLvDaUFYc4yjtsgUM2FjtWaKpZ4o+63IJ4gd8hcu3CHuUOYTv1fZb25UnY
	 F+5nuoMNs8H7wN2reW6UQgtZ5D8N23Px5gLkTUzvCuk4IOJMzPwagsOx8FlZ0RDyqb
	 n5lnZpxNElVXny3hvRBJjxMRSaeAi9/JgNIv2iDb8VTc3WA6zsUFFciGGYgAxjhYwN
	 zW+Xv43o1DV7A==
From: Vineet Gupta <vgupta@kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 3/3] ARC: build: Use __force to suppress per-CPU cmpxchg warnings
Date: Tue, 15 Oct 2024 22:27:49 -0700
Message-ID: <20241016052749.1640081-4-vgupta@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016052749.1640081-1-vgupta@kernel.org>
References: <20241016052749.1640081-1-vgupta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the cast of the first argument to cmpxchg_emu_u8() drops the
__percpu address-space designator, which results in sparse complaints
when applying cmpxchg() to per-CPU variables in ARC.  Therefore, use
__force to suppress these complaints, given that this does not pertain
to cmpxchg() semantics, which are plently well-defined on variables in
general, whether per-CPU or otherwise.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409251336.ToC0TvWB-lkp@intel.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: <linux-snps-arc@lists.infradead.org>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 58045c898340..76f43db0890f 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -48,7 +48,7 @@
 									\
 	switch(sizeof((_p_))) {						\
 	case 1:								\
-		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
 		break;							\
 	case 4:								\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
-- 
2.43.0


