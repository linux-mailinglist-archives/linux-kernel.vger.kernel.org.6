Return-Path: <linux-kernel+bounces-273218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B879465E9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CC71C217B0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA21339A4;
	Fri,  2 Aug 2024 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5hSFL3U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18B1ABEB6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722638450; cv=none; b=hZgByfDk7QZsQacxw5lVG4u9FvsB+Q5ySPfyP8R4yR0TyEU6ZsC3+IUIx+8AnQ/ES2xfhmSSOuXwd3SsRJdw0dEdQryA6IjxxTlm6Ngqthia2zt2BeIyZZjJEi2WBaxzQxVMJanMlF7T8b3/p50KKa9oSUZ9SmS273wPwhoZmc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722638450; c=relaxed/simple;
	bh=2Ox92wS/j6LT6RW2Owt087/gAztSsKgOWN6KoTSnzI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxf7n+EaSNxb3LQ29Aq3u6PXsMLCFNtY7CU4mdQoskXDj+/GSndvSTvFJ3UDF9S2JsH6OCaSWeYlDHJiL6HUotyHFTlTvHcinEf9wvyqama0pVGNC8Ll5Zf9o42ZZyJt15rsB2nHg+QSl3LseLw5O9W5XCYlxaq314QWE/VE4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5hSFL3U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722638447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIQ24+48TE0Ta9LNm8rRrMJXnuaT0qzUCWhnHkojtRo=;
	b=C5hSFL3UBYsGPDVqyTmba/8c/CqjFUOS4CmD/mWs5YP5mL2Qjcw+urMQmCL3jgFSdDGGKS
	So9nqwpc5MLZb7gXeufCdQLSZDIVa0aau6sEsUXbfHg6DOdgJWTelOLKS2ecmDw10TOxo2
	Mt1F5EPFndv4uRzxV5O2RCS16o4EqSc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-sBxff4u-MUi0yngatPjhzg-1; Fri, 02 Aug 2024 18:40:46 -0400
X-MC-Unique: sBxff4u-MUi0yngatPjhzg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b799897270so14280826d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 15:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722638446; x=1723243246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIQ24+48TE0Ta9LNm8rRrMJXnuaT0qzUCWhnHkojtRo=;
        b=FsLRuiV2p8p1KasKznC769AVGVORSWW/5NZwNmnaAB7pgt07BnxZ70XJ+88l5q5KOC
         6BIGdrR6c0te8TcDJRfBW4GMuKFq0sG8kPAVmhvWDLZIGtRmwnXj1SE5pVNOd2B9wKvf
         OP8ZDMKfVsignVS6f0fAAJdWpGN25Jr00dJyv4qpc9U/eOjy6vhdTkwTnre7abqubMwX
         aGc2q2YxoDeNpNBcZ7FcuGO1uo9YHg7qtBsBTsamABdkeOhUk/WGMNw3dmbE7aCOwulT
         PiY2gCAfFCtOeQmkjo4j4ncNSGfOpoYl0QLtMGHfzUjvrxNPz9mrRjjiBZYxNE70zUU/
         sgPA==
X-Forwarded-Encrypted: i=1; AJvYcCUfAS/vv/VVMxasoYVSQK8cZj7oDrsEYCNkDXuebSNuwlicP2zJZNzbIJHGDFDD2/XU9GdcfJlTmboDe5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8VT+LMj6KbonZdq5xdSE+2p4Sq0sNGaT5inmBbgXLrHSapkC
	aZtCNsr0UIn0TQ/oy9KKjmha27eH+sWKu2jo+cshXaW8Oz/U6dPXbxNqOTyJ9/zAfru6z4U/j7p
	3KSqYTzMdfKUK2i+C58u3h0UVKMR0TE9ZcoUeL0VppU4zVcNn5XBSIG0+RmF3Yw==
X-Received: by 2002:a05:6214:3008:b0:6b7:885c:b750 with SMTP id 6a1803df08f44-6bb9832e268mr35451756d6.1.1722638445942;
        Fri, 02 Aug 2024 15:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGuQ/TysjxPmr8e9IL8H+rnOjczzC8Pn9LtVkMqryMZ3GwIYnbZ1EzE5cR19PNfrempSFmMA==
X-Received: by 2002:a05:6214:3008:b0:6b7:885c:b750 with SMTP id 6a1803df08f44-6bb9832e268mr35451646d6.1.1722638445539;
        Fri, 02 Aug 2024 15:40:45 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c86baa8sm10847796d6.118.2024.08.02.15.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 15:40:45 -0700 (PDT)
Date: Fri, 2 Aug 2024 18:40:42 -0400
From: Peter Xu <peterx@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Carsten Stollmaier <stollmc@amazon.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, nh-open-source@amazon.com,
	Sebastian Biemueller <sbiemue@amazon.de>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] KVM: x86: Use gfn_to_pfn_cache for steal_time
Message-ID: <Zq1gavwLBHeSr2ju@x1n>
References: <20240802114402.96669-1-stollmc@amazon.com>
 <b40f244f50ce3a14d637fd1769a9b3f709b0842e.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b40f244f50ce3a14d637fd1769a9b3f709b0842e.camel@infradead.org>

On Fri, Aug 02, 2024 at 01:03:16PM +0100, David Woodhouse wrote:
> On Fri, 2024-08-02 at 11:44 +0000, Carsten Stollmaier wrote:
> > On vcpu_run, before entering the guest, the update of the steal time
> > information causes a page-fault if the page is not present. In our
> > scenario, this gets handled by do_user_addr_fault and successively
> > handle_userfault since we have the region registered to that.
> > 
> > handle_userfault uses TASK_INTERRUPTIBLE, so it is interruptible by
> > signals. do_user_addr_fault then busy-retries it if the pending signal
> > is non-fatal. This leads to contention of the mmap_lock.
> 
> The busy-loop causes so much contention on mmap_lock that post-copy
> live migration fails to make progress, and is leading to failures. Yes?
> 
> > This patch replaces the use of gfn_to_hva_cache with gfn_to_pfn_cache,
> > as gfn_to_pfn_cache ensures page presence for the memory access,
> > preventing the contention of the mmap_lock.
> > 
> > Signed-off-by: Carsten Stollmaier <stollmc@amazon.com>
> 
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> I think this makes sense on its own, as it addresses the specific case
> where KVM is *likely* to be touching a userfaulted (guest) page. And it
> allows us to ditch yet another explicit asm exception handler.
> 
> We should note, though, that in terms of the original problem described
> above, it's a bit of a workaround. It just means that by using
> kvm_gpc_refresh() to obtain the user page, we end up in
> handle_userfault() without the FAULT_FLAG_INTERRUPTIBLE flag.
> 
> (Note to self: should kvm_gpc_refresh() take fault flags, to allow
> interruptible and killable modes to be selected by its caller?)
> 
> 
> An alternative workaround (which perhaps we should *also* consider)
> looked like this (plus some suitable code comment, of course):
> 
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1304,6 +1304,8 @@ void do_user_addr_fault(struct pt_regs *regs,
>          */
>         if (user_mode(regs))
>                 flags |= FAULT_FLAG_USER;
> +       else
> +               flags &= ~FAULT_FLAG_INTERRUPTIBLE;
>  
>  #ifdef CONFIG_X86_64
>         /*
> 
> 
> That would *also* handle arbitrary copy_to_user/copy_from_user() to
> userfault pages, which could theoretically hit the same busy loop.
> 
> I'm actually tempted to make user access *interruptible* though, and
> either add copy_{from,to}_user_interruptible() or change the semantics
> of the existing ones (which I believe are already killable).
> 
> That would require each architecture implementing interruptible
> exceptions, by doing an extable lookup before the retry. Not overly
> complex, but needs to be done for all architectures (although not at
> once; we could live with not-yet-done architectures just remaining
> killable).
> 
> Thoughts?

Instead of "interruptible exception" or the original patch (which might
still be worthwhile, though?  I didn't follow much on kvm and the new gpc
cache, but looks still nicer than get/put user from initial glance), above
looks like the easier and complete solution to me.  For "completeness", I
mean I am not sure how many other copy_to/from_user() code in kvm can hit
this, so looks like still possible to hit outside steal time page?

I thought only the slow fault path was involved in INTERRUPTIBLE thing and
that was the plan, but I guess I overlooked how the default value could
affect copy to/from user invoked from KVM as well..

With above patch to drop FAULT_FLAG_INTERRUPTIBLE for !user, KVM can still
opt-in INTERRUPTIBLE anywhere by leveraging hva_to_pfn[_slow]() API, which
is "INTERRUPTIBLE"-ready with a boolean the caller can set. But the caller
will need to be able to process KVM_PFN_ERR_SIGPENDING.

Thanks,

-- 
Peter Xu


