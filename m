Return-Path: <linux-kernel+bounces-522191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5F2A3C736
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000B53AB42B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B8B21481B;
	Wed, 19 Feb 2025 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="brERynim"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67078468
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989122; cv=none; b=ijZvmvR1gtoQbKx0AnGhrcWcIlMiyolvwjmLq/eoLU1Ji51JYN4++3jwqFvmND+E26f+8DqVcar8E0wRvqOsZtaR/044O2xbYjwABTedP1c3CgK42lmQLg33o0u4rcxIxHH9CnVkbhy6+wO+oXeooCPYSSFScm41XQWIFqAwOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989122; c=relaxed/simple;
	bh=h3BF36iDQhX/7MNQc7dfnEuDW6XuNGtIv+43r8Ix9l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO+3N1aM1cUFcXCrF1RFT4VwwujtumFS0tS/4GWNy0DQFdazyj/6HEtMSlOd4gf+kh8EakPAxA1U/TNzddn04LuYba1KOgmkVtsvxGbXmdGQL7uk7UeJip6H4d69iPuNxKKZelRi6iLRoo8XlNTF7eLkVjNcPZBmejKYIl6/SAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=brERynim; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8QgXRG0thpTm9LN63q9uUmYr9UeejQ0COPqacZyG0Kc=; b=brERynimxLJSeBiNpQtPIfDM+b
	55uH4NutRcFahIoJffSarmCY3GLxJrq3RFixfKg3iOUnjR37PZQIkVKKdVMa2wvhlGok1c2pafKma
	aO8PZTGDNKqQK+sU1UGkHrp6VYxTcCHrJj1fBpKreG/RjcTginu3wn7vJbPo0YOZfRSFH/mKtB4B3
	oybvLZZ5R1uJyenSqkf77QFjz44TQfp1E+yjLUEkrvq5m2GqDCLfeYaXGvWw74ZhyTEMktPcBIogl
	HPBjqO+mnALBbQIRaPmP7/Gv9QkTz64fTh8gcTzHM75/Rxp0vZJ16iW3bJ5ZymgoBX5Ond7faI+kb
	nGWSDHTQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkoeY-00000002IkH-0fuA;
	Wed, 19 Feb 2025 18:18:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BD203300783; Wed, 19 Feb 2025 19:18:33 +0100 (CET)
Date: Wed, 19 Feb 2025 19:18:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 05/10] x86/ibt: Optimize FineIBT sequence
Message-ID: <20250219181833.GD23004@noisy.programming.kicks-ass.net>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.791951626@infradead.org>
 <202502190959.C414304@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502190959.C414304@keescook>

On Wed, Feb 19, 2025 at 10:01:15AM -0800, Kees Cook wrote:
> On Wed, Feb 19, 2025 at 05:21:12PM +0100, Peter Zijlstra wrote:
> > Scott notes that non-taken branches are faster. Abuse overlapping code
> > that traps instead of explicit UD2 instructions.
> 
> Some kind of commenting is needed in here to explicitly call out the
> embedded EA in the "subl" instruction. There is a tiny hint of it in the
> disassembly dump of fineibt_preamble_start, but it's very subtle for
> someone trying to understand this fresh.

Ah, but you found my clue :-)

How's this?

---
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1080,6 +1080,9 @@ early_param("cfi", cfi_parse_cmdline);
  *  4:   41 81 <ea> 78 56 34 12  sub    $0x12345678, %r10d
  *  b:   75 f9                   jne    6 <fineibt_preamble_start+0x6>
  *  d:   0f 1f 00                nopl   (%rax)
+ *
+ * Note that the JNE target is the 0xEA byte inside the SUB, this decodes as
+ * (bad) on x86_64 and raises #UD.
  */
 asm(	".pushsection .rodata				\n"
 	"fineibt_preamble_start:			\n"

