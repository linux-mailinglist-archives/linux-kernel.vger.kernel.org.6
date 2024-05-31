Return-Path: <linux-kernel+bounces-196787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C77D8D61D9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379A91F263D0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA92158D66;
	Fri, 31 May 2024 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lko8zPPA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D93158844
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158917; cv=none; b=jAwuIskMj5LA2ttyJGncLPacIlaM9AhkxZr8Cn9QFboKiJjRhbuDaXr2m3QvMXBunE5/quASJ5D4VfsdQw95YHK4CyROjTEwygjl1MC7VqdDdJrBrjTT+ryuFCHSLCDxxe5lrltWe7uQqQRFUOmkgvI5Nf1oyXOL9fQp2gJNo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158917; c=relaxed/simple;
	bh=9t/V6lr+JXo0ko6oV1wFcYKchLmN9d+xrlxuBH0B4uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3YBoNiq8QoflaMOBHexd47dbDaw1YUL5q3bttEYUOMXZIT0rES04R7nOPcZtHZDIzkJjrIv/TKT6ly+6+v1zCtwqkLjJu3MoXmxd8SjpA0PKmRnLfklTqizOrhtXENlLoqAR3ZfP0weRmo9h5rMQwpXeaizvZo33hdL2knWreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lko8zPPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FDBC32786;
	Fri, 31 May 2024 12:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158917;
	bh=9t/V6lr+JXo0ko6oV1wFcYKchLmN9d+xrlxuBH0B4uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lko8zPPAPktjqk+dyMkOTnRhDoggyTctDZErDEUn+DmFwHj6kOJbpgxFRczveQ6CV
	 DfvY+ez/OYnFZw2X82y25U5EMpUlgKV4YfiPCBrhV30/GfvxGCxt2BYhB1/bz2PtPY
	 xDsqPdj5WIcdb8JHPnDYQh/D5Z2iKZXBCXip3hcsVbgGZtBYEXbTSLNk18+DwoTNy0
	 vB6+7vy+aKfyM5MKzSgtWJ7N84UJNstAja/Y5BTotOrbQBP1hEtXyOP7dl0Gyx9ljw
	 o2VTbvbKJBIJ5hHKhs0DxBh+GQ8Q1wZKmWhO8eFglFeWSSRGVfnc5k/2naQwOi+eiw
	 TNmg7fZVQMDmw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 01/14] x86/alternative: Zap alternative_ternary()
Date: Fri, 31 May 2024 14:34:58 +0200
Message-ID: <20240531123512.21427-2-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531123512.21427-1-bp@kernel.org>
References: <20240531123512.21427-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Unused.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index ba99ef75f56c..6db78909180a 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -271,9 +271,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
-#define alternative_ternary(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
-	asm_inline volatile(ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) ::: "memory")
-
 /*
  * Alternative inline assembly with input.
  *
-- 
2.43.0


