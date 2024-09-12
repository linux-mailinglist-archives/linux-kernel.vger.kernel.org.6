Return-Path: <linux-kernel+bounces-326143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34649763B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6C71F22BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B404318E052;
	Thu, 12 Sep 2024 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C4MHiq3t"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577611712
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127857; cv=none; b=vAPFAm1zJfzfIBfGnLTB0SqksojbgP8YNFYcucAO7MMNxNe1PK8pELG7qtp5kZKSg069Sx7GDiVIqzHR71V4hWixF/FWGHymyHORlQPWbPZ9N2XF85VRpmTeX8WAY7CkRISsgKh4hiabDWIaBX0Xce6OFjgDkFpw084F78jVTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127857; c=relaxed/simple;
	bh=4owx4Wqu2R2POydNIQZ52gNsSQF5XNE5RC5+E9oEuck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKYv1HkBAGvkCKNQ3QIgICyKxQ3pN14OHVK2geMd7PsvoXI/S2Q7XZXTT0aIG5vR1JEw5KmJVkDAhRyHRTjiAiWlJCRg/PxReSm0QkqqjF9VRbzaoGbBkYEhFs0BVQU8ggyTbrzdOEwFQwo+9v+aPjvTD072JfKh3Q15z/mqStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C4MHiq3t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wkFE4W0KH2WJCIKG6g/ZAlvM5RFAUp+pAzzvd64O7n4=; b=C4MHiq3t03x479aAppM9adTm0k
	500j5sRE1nmuF6cPP6pwr8gImJdt3IQCDRZ5kgdEdWWAru1sIbmEKbVTdOyc/CLaV+NlVKj3EPGcK
	tvxssh8pl6gAeXXaogqKsvMSrR4t6DKHkGerNJxvntSYr4vWY7IvQMR+egUr42YbkuB/VKJNgLn7j
	tXxfESWQNcGXl22vmtGkYyOehrs4XDCO/oy6ImCcGNbz1fJhs17PCT1fr33BpPTe79CU8tVLF9TzU
	wnxYqO2JpU/6zC0nbZof7mQU2j+SaPBSWu9j77A92KUeWPX5vslsBHHYPjKkcpgjuCGnMZacOOElV
	U90vmmsg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1soehX-00000004ptS-2vh5;
	Thu, 12 Sep 2024 07:57:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DA35D30047C; Thu, 12 Sep 2024 09:57:14 +0200 (CEST)
Date: Thu, 12 Sep 2024 09:57:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v1 1/1] x86/fred: Clear the WFE bit in missing-ENDBRANCH
 #CP
Message-ID: <20240912075714.GT4723@noisy.programming.kicks-ass.net>
References: <20240911231929.2632698-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911231929.2632698-1-xin@zytor.com>

On Wed, Sep 11, 2024 at 04:19:29PM -0700, Xin Li (Intel) wrote:

> +static void ibt_clear_fred_wfe(struct pt_regs *regs)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +		regs->fred_cs.wfe = 0;
> +}
> +
>  static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
>  {
>  	if ((error_code & CP_EC) != CP_ENDBR) {
> @@ -90,6 +107,7 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
>  
>  	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)) {
>  		regs->ax = 0;
> +		ibt_clear_fred_wfe(regs);
>  		return;
>  	}
>  
> @@ -97,6 +115,7 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
>  	if (!ibt_fatal) {
>  		printk(KERN_DEFAULT CUT_HERE);
>  		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
> +		ibt_clear_fred_wfe(regs);
>  		return;
>  	}
>  	BUG();

So, why not clear the bit the moment we know this is CP_ENDBR?

In the fatal case, we'll hit that BUG and die anyway, nobody cares about
the tracker state in that case.

diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index d2c732a34e5d..fde4bdd25a73 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -88,6 +88,8 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 		return;
 	}
 
+	ibt_clear_fred_wfe(regs);
+
 	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)) {
 		regs->ax = 0;
 		return;

