Return-Path: <linux-kernel+bounces-196793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E98D61E0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C5B2831E7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19415DBC4;
	Fri, 31 May 2024 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM2ozbUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C215B978
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158925; cv=none; b=O/+sngNK6l4QAXSUjia2D46+tNycRjrCFZWjqwoJ0dBSrk1OdfyjAz343k7y4gx41g36utBDnHdP6IBwx4VlL8IaxYUAKBlf0fM4+Uk+xaaM0M46pTNNhHftGgXwncoRgv5BFBHvGPZ85xLXVySF49+ZA21yCDAnQhN/I3tnCX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158925; c=relaxed/simple;
	bh=j0mGso8kNgtVmg3sLyotcKOfUTQN9/QvAP75p19vlTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQK3suHklcj4S6h9vud7bbpcalxmVwAaRrhpjv8bBi62xfZTy1nx3cdxzcAuRKzLC7k/QTABYaKAjk6kOFAK0JWFus/pcjMENdYgE9Q8QfhkfPIxNKyY/PYO78z97ntjDmuL68jVMMYXYwoS1HO3MJhqOuzfbGdBbmbN8tsfqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM2ozbUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3EEC32789;
	Fri, 31 May 2024 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158924;
	bh=j0mGso8kNgtVmg3sLyotcKOfUTQN9/QvAP75p19vlTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eM2ozbUvVXe39GTTF8OpF6nwnO+Dl7pzaar+wMEacViymfI/QXVJh8AYvs07tsgsM
	 8l9mFzbF2nBKCKGs6YaPTjAarPyZY4IdJg/SUlZDyqZoafkNjLiMG0evFxWwaZCvE9
	 GT0ObNnWZZrsb9+UGbKw8BTA7ZQMayQoWM7GFkPyDsVYuJL4qsr1GOwl06gFAE6rQI
	 aaqiJBKrO2Cwo/CHC2ysDMKq6IPykgQTvCNIsLLhyxg7r3C/JCjHyGY5lR7ItxNyyd
	 vTAJSJi+G9YiGVFmU+L3qMhhYr/DrZ4M+quL7fU2opVjFb0vs8zpfZu6fBxhaP+nUd
	 6Q8M5CMRyaJQA==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 07/14] x86/alternative: Convert alternative_call()
Date: Fri, 31 May 2024 14:35:04 +0200
Message-ID: <20240531123512.21427-8-bp@kernel.org>
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

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 8a0a6ba4b741..bc696c60848d 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -340,11 +340,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile (ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
-
-#define n_alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile (N_ALTERNATIVE("call %P[old]", "call %P[new]", ft_flags) \
+	asm_inline volatile(N_ALTERNATIVE("call %P[old]", "call %P[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
-- 
2.43.0


