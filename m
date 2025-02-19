Return-Path: <linux-kernel+bounces-522047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648A0A3C532
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3F63B92DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D844E20CCCA;
	Wed, 19 Feb 2025 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bV36ePHT"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484521FF1DF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983014; cv=none; b=HIBBORXFl5SiX5jdIVG3K94suZig6ooXzKqJxozHuSYjKiio5EWnyRrJsFOx/FRr0Igz8cCG8jcUB0Qo+7vDUn2sbHE338oAycsn2EfmmcqBz/q7s//r8IQqfoMaVSFVdEaKaG2DyXg/9Sjr1fniL5YJwoCDqMdcVKbiIAmeYDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983014; c=relaxed/simple;
	bh=4qlEk+2cA0A2mCx18eN4QRncWR/yLUGSj1VHVWvZTQ4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IB7IOanNl2mmGsfdPAMNnw++HIJwsaF8lpbuQixxmKB2vO+DWH3ftPcE0gbGjTtXKUX02vgRQIbNzMjpfhSIt1pPp3ddnxZ0SbhoK4B9KVwKR5j4s2+LMged1U5aNPQPQ23p+emtOdXy9++CChILQmv/ppn1xvL5JV1lCjuuZjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bV36ePHT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=TqS8RQT0Cc1AuRp0tf3Zy97LsglkPcKd8GoxoofXqeQ=; b=bV36ePHTSizscnBsrTl3o0/AT2
	YzrotZKwL2xH3s3kpMH1TcOXXGzEmEFSDVVRYhFhiIPRScFpmyB5/1fxpR6yvFcL5hOjKoAWiixsE
	xpnBi+u31EG8bWfoQESJZvVLXq1y3zAbi9c2PpNcfVFiq6ahnF2DA5ARSKHh1JiHkH2vqLTfZMmAa
	mg/ZGkNZ+yATidWc0TcUVx3SUboEfjL9dYsad+MBjyP0x1oACdCz9vu7QbAzrLnXgpq2eSZlCV9CY
	zuErbquJi4Gl2ZCX6n5NDxM4Qcp5AxRoKaAylT55pypqdq106fnztulI9CmrZ9UH30sU2qfy+doPa
	8MgTfJvg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkn40-00000002HAF-0GxZ;
	Wed, 19 Feb 2025 16:36:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EEADC3007A4; Wed, 19 Feb 2025 17:36:42 +0100 (CET)
Message-ID: <20250219163514.475718637@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 19 Feb 2025 17:21:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com,
 mhiramat@kernel.org,
 jmill@asu.edu
Subject: [PATCH v3 02/10] x86/ibt: Add exact_endbr() helper
References: <20250219162107.880673196@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

For when we want to exactly match ENDBR, and not everything that we
can scribble it with.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -863,6 +863,17 @@ __noendbr bool is_endbr(u32 *val)
 	return false;
 }
 
+static __noendbr bool exact_endbr(u32 *val)
+{
+	u32 endbr;
+
+	__get_kernel_nofault(&endbr, val, u32, Efault);
+	return endbr == gen_endbr();
+
+Efault:
+	return false;
+}
+
 static void poison_cfi(void *addr);
 
 static void __init_or_module poison_endbr(void *addr)
@@ -1427,10 +1438,9 @@ static void poison_cfi(void *addr)
 bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
 {
 	unsigned long addr = regs->ip - fineibt_preamble_ud2;
-	u32 endbr, hash;
+	u32 hash;
 
-	__get_kernel_nofault(&endbr, addr, u32, Efault);
-	if (endbr != gen_endbr())
+	if (!exact_endbr((void *)addr))
 		return false;
 
 	*target = addr + fineibt_preamble_size;



