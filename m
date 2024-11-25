Return-Path: <linux-kernel+bounces-421320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E80D9D89AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C284BB23B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845C11B4129;
	Mon, 25 Nov 2024 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qM8nhMu9"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFD21B393C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549478; cv=none; b=E8lnkL4JHdqIb1M8gK4tNzlfEMhBJxjMkyHVM6xDewhpP71tgsiZAUJCCiSgkKp6gDkdS9quMJcCQYnqa6hcOGA5quBTmNzGykN5/a8AI+S2/VJJ00W/5Nx903WK8v8O74jVxPC45E/tJW6jERTKwacYwT6qCFd5EUsl/i0C0q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549478; c=relaxed/simple;
	bh=k0J7cdgG8ks0yKGQsm7oyOmsZLIKOC2JOO6K0l0qCvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X3RvulXExNawfjoGj5MS92TDbUezwxQ1KYgEu1rg8XAsrAvzBZv6u/P93l+Mwj9sAjMn0GYHMM8AFFU55stavDVByjQCqM2ctVSZnH3pmhJPqMYCGkYxfd68sOScvb3fAiHoQnJRrl79J3Fb8PoLc3zCqNgYyqcCeuJwTCa2rYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qM8nhMu9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-724e565cd84so2807604b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732549477; x=1733154277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s49siFswnYJqise7IBA67ylLigPWlT1O8x62ECi7gWY=;
        b=qM8nhMu9DwVwkr/jZrjmx9sMPOindmqvxUqrdNqX+bGyi65Rjx70CyXy6HojPkhsye
         dr0C8x8zq5H1U2V5gyQSlv8CiVbsi1h9kb43KeYTymrVg4WOPPIbuocWPj8wlY3Ehc5s
         4x/lP320GYCsmgJJlZUW5pY4yfhs31K7dftoI7PBExevV1kZ84zhIpmphjCH7HD87LJG
         qmJhr5crNdxlzTqGqnNeY8IHVc+uUIlk8TCo8tzF4/gVkXVS127V/u2ifkCW14pChFOz
         7v0mZT+Npj7V8a8QwD7L5q+tWnnw+O9We124j1LVs11mKlL/qOwc2TwOKEN/GwF7nHwG
         r6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732549477; x=1733154277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s49siFswnYJqise7IBA67ylLigPWlT1O8x62ECi7gWY=;
        b=LUqvJa61YJn6nL0l1CXKcIC2byQm17tg12pu/IioLTo0fMHmQoAK883dB294XfubiV
         xGgRodZYdLtF9d0GrSXihci+EhLSmY4ktsvAVjfMPLbRIS2BtsCEx0Yvt7q5JR1W/C/r
         ICJOqIP8xv1hN4Xyv8FIH7KWZ00dvQv3UtgC9nncJgE9J0vdbrGQCVchXckzeZ+EP3Sk
         ubget0226I0NHKnaEtMzAM3P30RfbVVjRq4iAsXIoUNuhTIWJrXvV5qWbSn672hqGwqT
         /abSRnHr+gV6I1DEqCq7PWS4gM9kgeyri/QcFs4cReeOzh7Kmsu3x6grZ6gGyiK+8bpp
         wv1w==
X-Forwarded-Encrypted: i=1; AJvYcCWQMnb8al41SYNaan1eWmmT9m1i+9ikY1kIfHn4apFZGAxyqyLILD33zbYjMx96mDceeUNQWC2nPHoSq3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsWf5YDYhvxxQNAn9zUFKMDAd4a+rVGEeGS7eUt4mh6+ri2Byn
	q6cz+BkKJ/2EOglK1Zl09eBZLIukyeC3eprkNgiWYK4qhNLPe0Asogui+NWZFg7PCobn+72G71U
	/oA==
X-Google-Smtp-Source: AGHT+IFhBxq93qQHLR1eb3eUOxjNGlaFOEGalzPBmpyOIfTBB2kKogtVIU5S2oVaZxk5JZeZRsg/VdkBF/Q=
X-Received: from ploh14.prod.google.com ([2002:a17:902:f70e:b0:206:fee5:fffa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2288:b0:20c:98f8:e0fa
 with SMTP id d9443c01a7336-2129f21a154mr204435955ad.11.1732549476840; Mon, 25
 Nov 2024 07:44:36 -0800 (PST)
Date: Mon, 25 Nov 2024 07:44:35 -0800
In-Reply-To: <6903d890-c591-4986-8c88-a4b069309033@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241115202028.1585487-1-rick.p.edgecombe@intel.com>
 <20241115202028.1585487-2-rick.p.edgecombe@intel.com> <30d0cef5-82d5-4325-b149-0e99833b8785@intel.com>
 <Z0EZ4gt2J8hVJz4x@google.com> <6903d890-c591-4986-8c88-a4b069309033@intel.com>
Message-ID: <Z0SbYzr20UQjptgC@google.com>
Subject: Re: [RFC PATCH 1/6] x86/virt/tdx: Add SEAMCALL wrappers for TDX KeyID management
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	isaku.yamahata@gmail.com, kai.huang@intel.com, linux-kernel@vger.kernel.org, 
	tony.lindgren@linux.intel.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	x86@kernel.org, adrian.hunter@intel.com, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Yuan Yao <yuan.yao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 22, 2024, Dave Hansen wrote:
> On 11/22/24 15:55, Sean Christopherson wrote:
> > On Fri, Nov 22, 2024, Dave Hansen wrote:
> > I don't know the full context, but working with "struct page" is a pain when every
> > user just wants the physical address.  KVM SVM had a few cases where pointers were
> > tracked as "struct page", and it was generally unpleasant to read and work with.
> 
> I'm not super convinced. page_to_phys(foo) is all it takes

I looked again at the KVM code that bugs me, and my complaints are with code that
needs both the physical address and the virtual address, i.e. that could/should
use a meaningful pointer to describe the underlying data structure since KVM does
directly access the memory.

But for TDX pages, that obviously doesn't apply, so I withdraw my objection about
using struct page.

> > I also don't like conflating the kernel's "struct page" with the architecture's
> > definition of a 4KiB page.
> 
> That's fair, although it's pervasively conflated across our entire
> codebase. But 'struct page' is substantially better than a hpa_t,
> phys_addr_t or u64 that can store a full 64-bits of address. Those
> conflate a physical address with a physical page, which is *FAR* worse.
> 
> >> You know that 'tdr' is not just some random physical address.  It's a
> >> whole physical page.  It's page-aligned.  It was allocated, from the
> >> allocator.  It doesn't point to special memory.
> > 
> > Oh, but it does point to special memory.  If it *didn't* point at special memory
> > that is completely opaque and untouchable, then KVM could use a struct overlay,
> > which would give contextual information and some amount of type safety.  E.g.
> > an equivalent without TDX is "struct vmcs *".
> > 
> > Rather than "struct page", what if we add an address_space (in the Sparse sense),
> > and a typedef for a TDX pages?  Maybe __firmware?  E.g.
> > 
> >   # define __firmware	__attribute__((noderef, address_space(__firmware)))
> > 
> >   typedef u64 __firmware *tdx_page_t;
> > 
> > That doesn't give as much compile-time safety, but in some ways it provides more
> > type safety since KVM (or whatever else cares) would need to make an explicit and
> > ugly cast to misuse the pointer.
> 
> It's better than nothing. But I still vastly prefer to have a type that
> tells you that something is physically-allocated out of the buddy, RAM,
> and page-aligned.
> 
> I'd be better to have:
> 
> struct tdx_page {
> 	u64 page_phys_addr;
> };
> 
> than depend on sparse, IMNHO.
> 
> Do you run sparse every time you compile the kernel, btw? ;)

Nah, but the 0-day both does such a good job of detecting and reporting new warnings
that I'm generally comfortable relying on sparse for something like this.  Though
as above, I'm ok with using "struct page" for the TDX pages.

