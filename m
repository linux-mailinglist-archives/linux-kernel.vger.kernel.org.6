Return-Path: <linux-kernel+bounces-395314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A09BBC43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B93B1C21B9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CA21C1AB1;
	Mon,  4 Nov 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="30pvpT/v"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95071C69D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742390; cv=none; b=rn9z4Pq/t6z3t2TOyoq4I4UKS9eVmXqveWXw2Zb57LcnkJik2Wb0gGl/j01FANpfAdPuvb142MkbEaFvV5IMlec9BFppYKkq8O0WNhL88KjLY0pjGgBH/S2B6TXDE9d3XbDSi2j0dEFtUiuze+vJfTpYo2ns6JmfMD7pSNhopKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742390; c=relaxed/simple;
	bh=gPkWd2wxoxuxg+h0/hCmbQz5P9HcKQfqFk87B9FTzGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3klokv6qXxSrhWSlKFDg5QgTbpSxkMBx7GY2Uu6VU9pxcco1V3Knxr9HEj2B2MPm+Vg/N5wXbLXPfxsqBEH3pi3Pt5FaieO0t8hqSKiqouwt60KtYKKQA+S01Z0Hv9Tnt9sIdIF4Pt8eTuYeIAl3ANh8CaTSyNbgV2cFSEARAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=30pvpT/v; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cedea84d77so1088713a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730742386; x=1731347186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNoiMjw3OVqv17v9meTG6uSwfwajYIf8B5oUpoOvtpI=;
        b=30pvpT/vtknZHYtdOcZJGh5L1h48I4RqnIlw2uYuGRVWrpUzvFguOBjbumayIIB8Og
         YIYhC5IUVoP7cL8Ko+73E4AA5Onev2c1C93/tcb/+I5RE/QnSQz7NOQXbN6AfZWsdCwC
         V+hPhTxCVCaTZZ24tmtfY2B4zXVm3fT2b3MRu0KpQK9rxxA5Kq+jYLii51ph0983cLd/
         SoSbL3OSn3qZ/ch0w6QoMQDLJjOYEUD23jLkrJPOrkXRW0xMQTR4nTmm4f24LtU16Emc
         /5Mm9q5U6etrZAAkSqpSamDSdNsG5yf51HRAIn9FHT7wHcR8LWPB579QB1scE7AtEawx
         WHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742386; x=1731347186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNoiMjw3OVqv17v9meTG6uSwfwajYIf8B5oUpoOvtpI=;
        b=Tab8El5tIzJsQ0KAstf1yI7Fldl8xzCdzibaule33kJzmehv0wqo7fXlivcQoB2XWR
         Aeo8K2p5abY3xf0rKPTHjmOXMJ7p1lQfV8WfHf68xeZmbIdf/wbV9AzOWafJ/Hs7o/Qa
         2BJhESqszIroolxWSACchZ3bKGYxldkSgUylWJFpqNF5n98KkCTkhH5ynkN7rAGLzq3A
         QRwyRO6gtZyaqP3X3C0Qv6s2decLIy1itAjYqiElQhfNJjZyae8rPOq4TUgeamwUEwgZ
         RtS8yZdKi5W3PIpNsAtWlx8dOt49s9KYikwBOMOmRgzdO/gxAOtxRjF/ADf0GcVK2SUw
         YvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNbLu0In2/fe66b75G74TjOYlpNQgLEsawCI7Swo6j5sbRq/pAJAwPEN1Xs1aAAwaQ+RWW5kEvmevHaWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrauPSkuWlHoCe+ESo/izLWL2xP1Xf522JsgIbzAx141PfnlvR
	YOfqYKvFziBzjG3hxo2gHZbeCoR6FO3b+Xv4wNK6AvB4AvYRCfhmtYztG/qi0g==
X-Google-Smtp-Source: AGHT+IGrs35d/XWv8BanrAW8j6PHDnWwBaSo/wZx0w5yxGi7BlKHJcenw8eSrxH3L+MaXjx1Bk+QUg==
X-Received: by 2002:a17:907:7d87:b0:a9a:684e:9a64 with SMTP id a640c23a62f3a-a9e50ba4055mr1494056066b.61.1730742385859;
        Mon, 04 Nov 2024 09:46:25 -0800 (PST)
Received: from google.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a33sm9246366b.185.2024.11.04.09.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:46:25 -0800 (PST)
Date: Mon, 4 Nov 2024 17:46:22 +0000
From: Quentin Perret <qperret@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] KVM: arm64: Change the layout of enum
 pkvm_page_state
Message-ID: <ZykIbvN8LO7pEan0@google.com>
References: <20241104133204.85208-1-qperret@google.com>
 <20241104133204.85208-2-qperret@google.com>
 <ZykFBhlzrUQtjEjy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZykFBhlzrUQtjEjy@google.com>

Hi Seb,

On Monday 04 Nov 2024 at 17:31:50 (+0000), Sebastian Ene wrote:
> On Mon, Nov 04, 2024 at 01:31:47PM +0000, Quentin Perret wrote:
> 
> Hi Quentin,
> 
> > The 'concrete' (a.k.a non-meta) page states are currently encoded using
> > software bits in PTEs. For performance reasons, the abstract
> > pkvm_page_state enum uses the same bits to encode these states as that
> > makes conversions from and to PTEs easy.
> > 
> > In order to prepare the ground for moving the 'concrete' state storage
> > to the hyp vmemmap, re-arrange the enum to use bits 0 and 1 for this
> > purpose.
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > index 0972faccc2af..ca3177481b78 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > @@ -24,25 +24,28 @@
> >   */
> >  enum pkvm_page_state {
> >  	PKVM_PAGE_OWNED			= 0ULL,
> > -	PKVM_PAGE_SHARED_OWNED		= KVM_PGTABLE_PROT_SW0,
> > -	PKVM_PAGE_SHARED_BORROWED	= KVM_PGTABLE_PROT_SW1,
> > -	__PKVM_PAGE_RESERVED		= KVM_PGTABLE_PROT_SW0 |
> > -					  KVM_PGTABLE_PROT_SW1,
> > +	PKVM_PAGE_SHARED_OWNED		= BIT(0),
> > +	PKVM_PAGE_SHARED_BORROWED	= BIT(1),
> > +	__PKVM_PAGE_RESERVED		= BIT(0) | BIT(1),
> >  
> >  	/* Meta-states which aren't encoded directly in the PTE's SW bits */
> > -	PKVM_NOPAGE,
> > +	PKVM_NOPAGE			= BIT(2),
> >  };
> 
> I guess we will still have to keep around the software bit annotation
> for sharing MMIO regions from the host. This would not be tracked by the
> vmemmap but it will still be in the s2 pagetable. As this is tagged with no
> functional changes intended, are we safe because we are not supporting
> MMIO sharing currently ?

That's right, currently no MMIO sharing is allowed -- see how
host_get_page_state() returns PKVM_NOPAGE for non-memory addresses, so
we should be good!

Sharing/donating devices is absolutely going to be needed eventually,
but I hoped we could make that a separate series. And yes, we'll need
_some_ data-structure at EL2 to track that, possibly the page-table,
but could also be something else similar to how this series moves that
away from the pgt for memory. Hopefully that's an orthogonal discussion
we can have later :-)

Thanks,
Quentin

