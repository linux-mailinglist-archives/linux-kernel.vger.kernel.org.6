Return-Path: <linux-kernel+bounces-180103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CD98C6A20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70FC6B21281
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEB015624B;
	Wed, 15 May 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2FRPYHxA"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E20155723
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788930; cv=none; b=VaYkHXVNxsBmyO2vjvMEORz/pE9A8JiJHEYP542ee70Xweq1+GMDzXGreVzBKniJlixsJcsCUh7BsWbY9IjuAVpLWhvEwnX6MgmIp3QtTYwWy7B0LAxFncEjQpjuUKZV4+aObbnRtZSqpe4wUXwLAQCgWwed0m9LpPfedTIzhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788930; c=relaxed/simple;
	bh=dHp9YY0yUz81Klbcbarf2tktRzWRTMeL2ufthxa+Lvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oI/UZI02c5tQJzgR7+T1u5WHblZU59BO4pVUyxrsbrLCr9uSPuM/vAl1uJW0yoHkRMz+YBqw4J6ckLGf0GcmaFpMjcvgpGJ8fAOsH2DMEMS+urkMFiaacbKBorY5CPEu3fVhXG5qYzrXj8er9Iql1+hF/uP1XmI93Ns1mBFvcHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2FRPYHxA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627751b5411so5812977b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715788927; x=1716393727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Leaj1hGD/l4qMnCDX6HAbzcyf5xPcTNn9ubyVFrolYs=;
        b=2FRPYHxAnZjbH4EO51l4RxbGPtkoRqqbgC7JJlJYHXO9f32/U3brEPAN3Dxqo1Fz4W
         JPwcgFCw9O0Nn1rnnIqVl7S5SUw7TC80P1EFI6mADucXWWK/4pHSL9o4xlDuC67fuJGM
         hvjwu5tikOrfJ3ul16/LAc3UoOeRNfmAuAG/3Tvxqi/EBLgSF3T5kb/sZUaKF3hVo9kI
         3F0q3XMjqdZqsCmJJcrYd8nZCgirwittdCnCypviwcvB7cXZ9tb+7zgES66xyuG974W7
         uIRAYIO7B9OVl8cu2kJSI6jSyGwNnxlw3KGYEZIPGqQGHrK19C7LeSPh4Uca+SehPpDK
         bs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715788927; x=1716393727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Leaj1hGD/l4qMnCDX6HAbzcyf5xPcTNn9ubyVFrolYs=;
        b=MveGr1w4T9papE8xpPRg9yzY2V5odAvUvt7hUnBmOrgucyNK6ruE6VfwdRDs7Vlq9O
         i0CgzKG5Boy/GxbJA63HVOwTT+uAEF/pZfKq31PDNzLSdj7dbgp4krYUHMFIkqxIN7cL
         8BRiFtY6eQnqSuUe1Nt5fo9KPu0Yc0ZZrmM+kXDIkLjA2YiX93QVpD37737nLU9SKP9f
         kB5K9CQwnj8dA9c+stM2QW78Gp4ScHhtpIRJCkIyNk93lMpjAVGtNIQGBCm4rXbr73f+
         R5sr2JdNpsppRpLg9VHIVZI8BhU8sC6ZFgGNJgeuAomJsHtQa8MGY44YIc78tBmIiQFt
         FSGQ==
X-Gm-Message-State: AOJu0YzEMxrm5B66Ny3M301YOGynmzAyfWCUAjcle1ooKJe90L0hLzhE
	nJRKngJHqTo9sG2+mJ5EXIW5Jwzcoqk2GH1ZkOD5ePnCXLdhe8D2pCBh4ISjoPdmXbbi6kWEJ+/
	c0Q==
X-Google-Smtp-Source: AGHT+IGPwheN6AaZMallYW5on/mieXkwwDJnuyPkb/L15W89sdb/Xu1kDKQkw1QV4ydleb3vm7DTRtu99bs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ea0d:0:b0:622:cd7d:fec4 with SMTP id
 00721157ae682-622cd7e0027mr29802577b3.9.1715788927600; Wed, 15 May 2024
 09:02:07 -0700 (PDT)
Date: Wed, 15 May 2024 09:02:06 -0700
In-Reply-To: <747192d5fe769ae5d28bbb6c701ee9be4ad09415.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515005952.3410568-1-rick.p.edgecombe@intel.com>
 <20240515005952.3410568-9-rick.p.edgecombe@intel.com> <ZkTWDfuYD-ThdYe6@google.com>
 <f64c7da52a849cd9697b944769c200dfa3ee7db7.camel@intel.com> <747192d5fe769ae5d28bbb6c701ee9be4ad09415.camel@intel.com>
Message-ID: <ZkTcbPowDSLVgGft@google.com>
Subject: Re: [PATCH 08/16] KVM: x86/mmu: Bug the VM if kvm_zap_gfn_range() is
 called for TDX
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, Erdem Aktas <erdemaktas@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 15, 2024, Rick P Edgecombe wrote:
> On Wed, 2024-05-15 at 08:49 -0700, Rick Edgecombe wrote:
> > On Wed, 2024-05-15 at 08:34 -0700, Sean Christopherson wrote:
> > > On Tue, May 14, 2024, Rick Edgecombe wrote:
> > > > When virtualizing some CPU features, KVM uses kvm_zap_gfn_range() to zap
> > > > guest mappings so they can be faulted in with different PTE properties.
> > > > 
> > > > For TDX private memory this technique is fundamentally not possible.
> > > > Remapping private memory requires the guest to "accept" it, and also the
> > > > needed PTE properties are not currently supported by TDX for private
> > > > memory.
> > > > 
> > > > These CPU features are:
> > > > 1) MTRR update
> > > > 2) CR0.CD update
> > > > 3) Non-coherent DMA status update
> > > 
> > > Please go review the series that removes these disaster[*], I suspect it
> > > would
> > > literally have taken less time than writing this changelog :-)
> > > 
> > > [*] https://lore.kernel.org/all/20240309010929.1403984-1-seanjc@google.com
> > 
> > We have one additional detail for TDX in that KVM will have different cache
> > attributes between private and shared. Although implementation is in a later
> > patch, that detail has an affect on whether we need to support zapping in the
> > basic MMU support.
> 
> Or most specifically, we only need this zapping if we *try* to have consistent
> cache attributes between private and shared. In the non-coherent DMA case we
> can't have them be consistent because TDX doesn't support changing the private
> memory in this way.

Huh?  That makes no sense.  A physical page can't be simultaneously mapped SHARED
and PRIVATE, so there can't be meaningful cache attribute aliasing between private
and shared EPT entries.

Trying to provide consistency for the GPA is like worrying about having matching
PAT entires for the virtual address in two different processes.

