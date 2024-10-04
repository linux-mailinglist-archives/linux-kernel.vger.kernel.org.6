Return-Path: <linux-kernel+bounces-350027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D898FEE3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA1C2849F4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B1F13D279;
	Fri,  4 Oct 2024 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X33GTIxs"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AEB6F305
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728030082; cv=none; b=Zvbv4kMB2lu9d6+efSujc5HrexgeuyjG9KRbvb4raAAQd4F/sC4aOhOOf5lNJZrbGwWWhTun6uxcVt4GQNa2IzQodEEt0bydcwLdmIpMHmWS1ZbzemWv/QvpgxoqCs/ojDaYh1V9PKtWR707VG0P96CQwodcatiIHldce05Aq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728030082; c=relaxed/simple;
	bh=5avRheEtd7SXVO9/VmuYn3yYOFIjFI9nPjJSqm09PVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGNtWqvtZO0wqACy4cJTz9PnyYyfU78BmqmXT7vkL5aVtpfLHIBCoQJSGKyvehlNYCHNmyXtiyLt/HXPIcOTHRrPjIi8sqHuR/JtlcnYh5K6NVDIYUNkvp7WS13Fbl+/viJQadDdm9JMJFkKJ+r10NuWUhy+Lmh8eq0WKeNh43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X33GTIxs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G63XCszoO0HAWiYaNkqIUPrYKSVvExNIqwEoSBjykfI=; b=X33GTIxsrqTCjaEB/5MBqJfaiD
	kSEvBaDxUCm4W/xcwnZ8Ty1SGIS7Uw9zLJtjtqBzMormTWJUAPy+R9Lbjtsi+v93hamSjL/+8ZNv4
	G2J+12M7ONhYaTsqbjl87ReMIC6Ov9mjRQlqKsNRPB/FeCYzmdyQfNZrcp1sZVTFgnnWxfq51d1bI
	Mt/ZkcibqVAgcl5suGwXrDl5EwwGE7um5jcQv0lc8mre4xV+MF/3PISzRfJf6DAfdUMNnvCqFuRAZ
	3LsXnCrvQJk9Ybz1Nm0OkpU/aNxmZDnxhFXrVBl4ldXoXEjsmnSBRrjLqVMYBZhdtPDH8tncszN4D
	8tv4VDbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swdYs-00000003nmx-0pXr;
	Fri, 04 Oct 2024 08:21:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D555530083E; Fri,  4 Oct 2024 10:21:17 +0200 (CEST)
Date: Fri, 4 Oct 2024 10:21:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] objtool: Detect non-relocated text references
Message-ID: <20241004082117.GH18071@noisy.programming.kicks-ass.net>
References: <05fd690797ea4e1ee798b7fa497857519ae840d4.1728001850.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05fd690797ea4e1ee798b7fa497857519ae840d4.1728001850.git.jpoimboe@kernel.org>

On Thu, Oct 03, 2024 at 05:31:10PM -0700, Josh Poimboeuf wrote:
> When kernel IBT is enabled, objtool detects all text references in order
> to determine which functions can be indirectly branched to.
> 
> In text, such references look like one of the following:
> 
>    mov    $0x0,%rax        R_X86_64_32S     .init.text+0x7e0a0
>    lea    0x0(%rip),%rax   R_X86_64_PC32    autoremove_wake_function-0x4
> 
> Either way the function pointer is denoted by a relocation, so objtool
> just reads that.
> 
> However there are some "lea xxx(%rip)" cases which don't use relocations
> because they're referencing code in the same translation unit.  Objtool
> doesn't have visibility to those.
> 
> The only currently known instances of that are a few hand-coded asm text
> references which don't actually need ENDBR.  So it's not actually a
> problem at the moment.
> 
> However if we enable -fpie, the compiler would start generating them and
> there would definitely be bugs in the IBT sealing.
> 
> Detect non-relocated text references and handle them appropriately.
> 
> [ Note: I removed the manual static_call_tramp check -- that should
>   already be handled by the noendbr check. ]
> 
> Reported-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

