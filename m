Return-Path: <linux-kernel+bounces-546933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8DBA500DF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047347A7A44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C98F24CEE9;
	Wed,  5 Mar 2025 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rrfIlOfe"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350D24C69D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182202; cv=none; b=ZSqMX9qksgB1KX9vOM7ws4TWImkMa23rOfab8xjwyZAw74YuMC8Arv4F8TqfTLf+hRbdhlZF2iLoeZHD3EDSEWCzSKX8kS24QOUzFgDMPQ2557QiK24DD+1+o3vR1Jjvhc2QRYSnEQaZRCsBGJMEGpGMBjnTvXTWQPleZCrLqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182202; c=relaxed/simple;
	bh=fK5zQ/WZjEbYA+TpmqkINi2b97itDxogVpvAk5QyjG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WDuIqS61UunbGfT3pPwXpg7GD1DbT5oRVMswdTTnrNm2tH4ZEdXJIrRHpuGdVldlxkr7IiwYtRWxE1SvQsae49vwulRvFiYBVO1iuj7G194HZQXvUWsQbzx/IR0LknbLLLgwECIyssSj1e6gxSU/8pEhuADbwySRVDxriwm3DKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rrfIlOfe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=UGg+ouxLIKsh/+oUO6t9EAmcDlK9cpsHvOVQR2Exv04=; b=rrfIlOfexzXdKv9ihM3XOnhOmf
	tsEfuZ8KTitTNv3Np4aArbcfX+v3xf3XU6njk3xRxYEIeJacyAfHvn1C25YNCctrQh1/eL247MZrA
	ewOUNg4VMOEYC/SMWphmv4+VwFzdgp6kIxVksOL0dzImhRvcAEPO7hajkxjr9iqRXxSSRC29ZH+qR
	F4NN0MsXP3XXt4qeBPol2Ei48g6eeGqIGA0Nk3YuDRCM4M++pw2N6El4MsxJhpVJOfPVK/+AfMgTA
	n/7X8BN1R3nvrkdOvFYQmEGZGihxxw8DS9ueful28+WV7pashaGe0K7HvHaumOebjgLbeJnfcgz7i
	bVtNiW7w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tpp1o-00000005amO-2fXA;
	Wed, 05 Mar 2025 13:43:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D88F030049D; Wed,  5 Mar 2025 14:43:15 +0100 (CET)
Date: Wed, 5 Mar 2025 14:43:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Subject: [RFC][PATCH] overflow: Twiddle with struct_size()
Message-ID: <20250305134315.GB16878@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kees,

I keep getting hit by the struct_size() brigade, and I keep having
trouble reading that macro.

I had a wee poke and ended up with the below, WDYT?

(I also tried to create a __must_be_flex_array(), but utterly failed :/)

---
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 0c7e3dcfe867..2123d0e238bb 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -352,9 +352,10 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
 #define flex_array_size(p, member, count)				\
-	__builtin_choose_expr(__is_constexpr(count),			\
-		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
-		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
+	(__must_be_array((p)->member) +					\
+	 __builtin_choose_expr(__is_constexpr(count),			\
+			       sizeof(*(p)->member) * (count),		\
+			       size_mul(sizeof(*(p)->member), (count))))
 
 /**
  * struct_size() - Calculate size of structure with trailing flexible array.
@@ -367,10 +368,12 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  *
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
-#define struct_size(p, member, count)					\
-	__builtin_choose_expr(__is_constexpr(count),			\
-		sizeof(*(p)) + flex_array_size(p, member, count),	\
-		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
+#define struct_size(p, member, count)					       \
+	(__must_be_array((p)->member) +					       \
+	 __builtin_choose_expr(__is_constexpr(count),			       \
+			       sizeof(*(p)) + (sizeof((p)->member) * (count)), \
+			       size_add(sizeof(*(p)),			       \
+					size_mul(sizeof(*(p)->member), count))))
 
 /**
  * struct_size_t() - Calculate size of structure with trailing flexible array

