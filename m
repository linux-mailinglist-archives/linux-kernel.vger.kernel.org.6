Return-Path: <linux-kernel+bounces-524777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87099A3E6FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F7F189A63A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A91EF0B5;
	Thu, 20 Feb 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cihh62xD"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA01EDA07
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088275; cv=none; b=tQYQ/5jX1xncF3OM3xCdaoUrWQJ//wBtCPsAQmKh+3MmpWisd1yE22XFKIKnLbOxWY8aDmmFxoR0FE6Nyw09ejciT/VfDf0ooPdEaEBoAaiD1hxAy/gcSCfAM6naK1PLoPrjBJLlJh1YWJtYTH/U8XOKdM0OylJWHnU9xqtWJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088275; c=relaxed/simple;
	bh=POCua1poOqTKX9IA12fXvyapJ0I0k4Fee3XNGMFyIz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZcBRK8bT6o5/xCo6iY5kLN7md8RQhWF8QqRedVPkAdAbyZM1bdnKb1YQlx6RTbL97L2kKlNjxn5MJSFvvGnZKF4I+cf6VEx0n6RF2weKfCg/lTLMPyuHsC1CKhGS6bJre2KuMBaVGA2IDGWhfzUY7USPHFC1IdZhLImy2QPr7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cihh62xD; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 21:50:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740088261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gbpaDL5iHMBEhdVqgt+41QrD5QBpl3QLJHFsb3rcje4=;
	b=cihh62xDjZi0fekPiSBQjw0zchMMygB0z6t5P8JOHvuSdrF4J3ouAiiDDeMapd3ict2H9o
	bRXGYm26thKaxMgH9qyxctJxNDzsgMhVdXBTuWQvto/FQ/a0SaPVxMDxAQsl5dKSEvDOZe
	07x6U1LLk/BbqVqooVATKGVvqC8XceQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] IBPB cleanups and a fixup
Message-ID: <Z7ejvk31gYNCIwFv@google.com>
References: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
 <20250220190444.7ytrua37fszvuouy@jpoimboe>
 <Z7eJurYbxS2kAzvk@google.com>
 <20250220204724.y3b6wx7y2ks3fuct@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220204724.y3b6wx7y2ks3fuct@jpoimboe>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 12:47:24PM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 20, 2025 at 07:59:54PM +0000, Yosry Ahmed wrote:
> > > static inline void indirect_branch_prediction_barrier(void)
> > > {
> > > 	asm volatile(ALTERNATIVE("", "call write_ibpb", X86_FEATURE_IBPB)
> > > 		     : ASM_CALL_CONSTRAINT
> > > 		     : : "rax", "rcx", "rdx", "memory");
> > > }
> > > 
> > > I also renamed "entry_ibpb" -> "write_ibpb" since it's no longer just
> > > for entry code.
> > 
> > Do you want me to add this in this series or do you want to do it on top
> > of it? If you have a patch lying around I can also include it as-is.
> 
> Your patches are already an improvement and can be taken as-is:
> 
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> I'll try to dust off my patches soon and rebase them on yours.

SGTM, thanks!

> 
> -- 
> Josh

