Return-Path: <linux-kernel+bounces-449228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD39F4C12
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615DE189424D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AD71F755F;
	Tue, 17 Dec 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WnnqC8lr"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26271F7088
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440885; cv=none; b=u8ipVpnhLNFZjWBPnp3PcpluXc4oGBy6di70xIvTXeDIN/TBuJQ8hR9AV/i1nhVFOV197aG6dMy2MNBxuP8StDprKL3IZU/fjt6zvKJmfr2vG7fNXDeZtsQfkifl1p2zEnEZ4xoJ9Hia0TD88RmTWTSflLawMMvCN5I3rIJpY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440885; c=relaxed/simple;
	bh=58eBS3P6Q99T+Ll2P7RPlryhCoPeOMuQvZcOjVzhwCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6YGy+tDN7w2wAKpEl8S7ktCody0vZr4sd6SfbtZKQxIFXlX2SgXMvD5j+Jc655AglfMnfMwu6ZtCYPKg9+R4ECJxfawIiXOnWi/IqS62Kvl72lqoOFkt3x5CrjWxuPgkbj/dKCiZVGHdsSXFb0lxyvyd+UnIN+iMANJR0TIoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WnnqC8lr; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso8372707a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734440882; x=1735045682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxP352xQrJECWy5yVL3g0J4iVO0b/TvCNJ0J8iinEAk=;
        b=WnnqC8lr8aL+vodJSmS1wXXLbI3O6BkkplcPNejSMEBjdtMtcoRSnoeqeYO2kOEBZ0
         7mKKqxgPhxyjDAxtJNTYz5PQ+UHc2xBqha5VwhKRm39jBbFZrE7vl/IOYJjTpDlU/t9T
         Og7FH7p6Py7dUHNfS1crBXdoWwzruTRB5UXOiemgiYpe3aCWwcU8Nw41mnozTQug3iju
         jplmiualGHLDM6qukRES+u341jrhSSB3HWxLTkFpvziZPmB4Hy6MRGGvuspiV4l1zHIB
         eIavoINXSTg9wvIXM8oe2R7aEOw1+uFx7CsCwRaxKcldZdd6AmgYRiWMOg4dy9PA9Igt
         PyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734440882; x=1735045682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxP352xQrJECWy5yVL3g0J4iVO0b/TvCNJ0J8iinEAk=;
        b=YF53XBOS+pTn0oJ+O7qoxm46cbbnujXG1foeAvPbCOenEpccyiZWnc2CdLOHUzJYh1
         R6q0520WTWfrmP+MZ3fO4aj24Wu1wX2gwe/KgFzduERTcSF3OmEMyD/xW8NzKTmU1Fxc
         IprbI3kN3uHQsA3jsT5H2Vh1SBwb4X1Yri866bTjyC+y1bE1LtDyw9evtrB6n8/Njs7H
         f4QN3WNHvKlzjlAVBpmffXvr0PMTXvSeDWN27CDDEmFjB036lgRVRtuAjLzQw7ie+Xf7
         MFrBQyuVqTWAfBxhOnXEXTPqM4Z+SdZ8UW9tC2DmC9W6AV5d82txXh1iKVXaEFH7zIBw
         C/8A==
X-Forwarded-Encrypted: i=1; AJvYcCVlWamcpNJc7QHqOaD2X2prJwV6CyJHdZmrqxn4lzsiolAKV68R8d8QDXVqA83uWFQIocM6+GJkxMFH/W8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5MjH7hMvshHASTm+tkvJLraPsUseKkWa6VGfy+8JANknNQ17
	abI1LlBGG1t2DsYF98zkrJ3qqrWjWGZBd7zdOKeIBZREBui8vLV13ZUKapkwWw==
X-Gm-Gg: ASbGncvPrWYWVbC6ldhGgT9RHwyQS1v/iGKtzkjKsg4n/6tcQx5RZFffxW/9lo9zu6V
	nEKt2Ahnxdx6LyHHq89ObCRlSwF1gozIQJB1SEbXDGQSriyhR9TD7U5sO62B40o461yqmzwdjkG
	twK80ZLVVG+NSmXDaLk2XOGaolUFaxl9zCpxx/0F6Mw+lGjLvBmF2fKn6vKnmFm7NM7rZwvzBD7
	BX1t6x2vD3BptAxEPWNPpyR3WRJIKaZyMrZglSdhTqSTrzfT8FF/a1HAzEA6Wi9T1v12UfWWm1/
	GIBkNlERQTzBQ2U=
X-Google-Smtp-Source: AGHT+IHPCDUKwR/FGRi6mHLODl5BviSg7xFz4W1NW5gTkYq7HIYlXpzWI3patHH94VqPS2+uTzBEng==
X-Received: by 2002:a05:6402:4349:b0:5d2:60d9:a2a0 with SMTP id 4fb4d7f45d1cf-5d63c42d641mr15856567a12.33.1734440881906;
        Tue, 17 Dec 2024 05:08:01 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ae12a7sm4261850a12.50.2024.12.17.05.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:08:01 -0800 (PST)
Date: Tue, 17 Dec 2024 13:07:58 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/18] KVM: arm64: Change the layout of enum
 pkvm_page_state
Message-ID: <Z2F3rveiCEuPwxhN@google.com>
References: <20241216175803.2716565-1-qperret@google.com>
 <20241216175803.2716565-2-qperret@google.com>
 <861py6sht3.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861py6sht3.wl-maz@kernel.org>

On Tuesday 17 Dec 2024 at 10:52:08 (+0000), Marc Zyngier wrote:
> On Mon, 16 Dec 2024 17:57:46 +0000,
> Quentin Perret <qperret@google.com> wrote:
> > 
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
> >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > index 0972faccc2af..8c30362af2b9 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > @@ -24,25 +24,27 @@
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
> > +#define PKVM_PAGE_META_STATES_MASK	(~(BIT(0) | BIT(1)))
> 
> Shouldn't that be ~__PKVM_PAGE_RESERVED, given that you just defined it?

Sure thing, I followed the same pattern as PKVM_PAGE_STATE_PROT_MASK
which was explicit in which bits it sets, but very happy to change.

> >  
> >  #define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
> >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> >  						 enum pkvm_page_state state)
> >  {
> > -	return (prot & ~PKVM_PAGE_STATE_PROT_MASK) | state;
> > +	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > +	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > +	return prot;
> >  }
> >  
> >  static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
> >  {
> > -	return prot & PKVM_PAGE_STATE_PROT_MASK;
> > +	return FIELD_GET(PKVM_PAGE_STATE_PROT_MASK, prot);
> >  }
> >  
> >  struct host_mmu {
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

