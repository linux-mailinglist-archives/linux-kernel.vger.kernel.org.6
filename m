Return-Path: <linux-kernel+bounces-205881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D269001D5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEDF6B21D78
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FCE18735F;
	Fri,  7 Jun 2024 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjC6ZkdH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AE187346
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759028; cv=none; b=Jiy4QyIC6R7Ks5XX5fqw+9tT4FFtPY79dkQqU4XLWRjy/sFGlFq5x3JpssuFnhsORnON+MUIeuKMqjZfuYVAjyolQJQwE41t5L7Rtto1BvgyB9tOxtVu2L9j5TIWwwchG+C8L0Ak3ItBx7Xk0naGpPvQB3lwFqJlM1mxMzSrKIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759028; c=relaxed/simple;
	bh=9t/V6lr+JXo0ko6oV1wFcYKchLmN9d+xrlxuBH0B4uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZlD+9ziNARmi5OmuQSZA6bfBjSl37ycfmPie0/yk25B04gT4l5i0gM/vWAYwtnSVmKpxGvBthxptj+feR1YJLiq8r7jCO1SQ+3DGvcEYtlUcNH3o6IfR3wGsjDzWJ/HRRyeR/gE/zj3EQlpRb0uZQBqk8YN7hM597sV+cmlSmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjC6ZkdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760FEC32786;
	Fri,  7 Jun 2024 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759028;
	bh=9t/V6lr+JXo0ko6oV1wFcYKchLmN9d+xrlxuBH0B4uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjC6ZkdHpeOiJwD8KULbH05n5M/aDnRcFKFFGGnaWUSpRoS1uCeOolAzyzEv1hP+6
	 mUYhWu44yslRj8norBzhDPTrCJr+CmzPPYHm/oc53KO0If2gbXF1L1SKDaZ9ItYJcQ
	 vA9IJsyeVt6FBK/2knj2zfmULJeOO1QSy95+jHJ3VI0QYYWQXACDQLzoifobQTTlyt
	 SkPDGB6mxZYCDvYgabn8jbw5y+jmkeywAyfWnRuw09rorSSRQ/+6jsl6H8Eh58lHp4
	 P6C2i44xqMz+SyiUqgWkqpoPLHH9ASRxCSDy/Gi7lnINa/PW2b2jp3wh5vd6hRgRU1
	 bCAjgZS+uyZuw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 01/14] x86/alternative: Zap alternative_ternary()
Date: Fri,  7 Jun 2024 13:16:48 +0200
Message-ID: <20240607111701.8366-2-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607111701.8366-1-bp@kernel.org>
References: <20240607111701.8366-1-bp@kernel.org>
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


