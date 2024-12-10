Return-Path: <linux-kernel+bounces-439828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8BF9EB46F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9998284024
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C421946DA;
	Tue, 10 Dec 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZ+Lmnn5"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F1F23DEBD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843761; cv=none; b=s/A2s1fzdwosmeaEHUAVkSPRoh9mCdwuFOzOkTFYrI6z3QA4wg/Ly2V4xTfTIg27ZuVRlzruCvVOQu9JKQTjtN/GR40BgQ34hr0HDaMJBCa6HVhPdxWYZKpwmMNhtmvLmH9ompNR34TlFooy4PaCOJeHbQaJgNhuomGlA7uH/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843761; c=relaxed/simple;
	bh=8kN6LxvVCu219DP/ty/ojwWtnjH8wcUqw76Wx1ztkOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0gPoGrSceOczuhdF0e+k1/N20yAEpZnKrtIvSBikLd36m6ic7rNwW3zX+2O06QRx7oMep7oOVPAikr85n3FAWyyzPnD2EDGtEPTnxK8hNcOPzVAeUL8FPCfS0tZ4SlLiqWJEXYAs3d4mF9Nh5VIrgQp7DDPdypD5FIOiLrgvuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZ+Lmnn5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d2726c0d45so8707695a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733843758; x=1734448558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lccj5szcR2Loq0SLYGfcfm6VfqCNUTcb2r9ZMHJPtZI=;
        b=fZ+Lmnn5vvzw/VZdakE8tKdcTcfEBkkofECKCYkoHzB1GlaU+629NZIUuHnvubuHkW
         q0yTCl0sBTO92bvAgiFTaEdh1crM9+H/pekJbTtAiDRzBsJIwdUepxn+yz9WLeJOtXfD
         XOxrhQJ7pllYH5e6nARarMBQ5KFvrZaJHQJ796aJ9ldeB9GBoN2X1A9eyO5l8pJVR1lH
         OUDIc/OvREnfKbU6ltcK2SuyA34dQqD4Ruqm83fmxyi46s6xM9fEpf2+hftCg/chhK+j
         C7P/94aAQ8CMdCXQxJk+vsI9riwBNMPv9xq1f46lD5nHoFalHRK2EbXjK4FPJKt4Z6Iq
         cR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843758; x=1734448558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lccj5szcR2Loq0SLYGfcfm6VfqCNUTcb2r9ZMHJPtZI=;
        b=JvmMwHMKk5cuV17LBWAO5YK85E5UjZc73NH8IsRPhCX9aA+EBhBYn2V+Uw7+jwJU6w
         t6AaE/nfbUcWrioLime6xyk1yspIa3L0UnC9jy65swWPytUZZjWXdHbp8oVljNcm4DPj
         CNtw7H54GKsDIcU43f5uRGnhHv14rTT6RyncZw8HfFcG8kXcX+7atOid/RDCyS5w/2m6
         zwBU+3/TEJnT2IbdHogCqVMNpugNsA1U6dZy8YQhV+TaLb2N0ylfUuN2iOE7JQ4u67Hz
         eZAHIwhTWUmM6JjJogD+XlvnEQ3yRtIkW361F4i8oTRsH94Jpr8XvNK46GKJ3eA7W507
         EhXw==
X-Forwarded-Encrypted: i=1; AJvYcCUIJd8Rmy1ZJ068bey0PqYzRsLUViVJqSOxsfNTPZGbq0iXSLRdju7Oil/431deS0mzzWcohmojLsyHAo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP0gHDkiSJTKNs8npHBNxpF4n+S2Os0Z3JGurgyJVn/68Fct75
	CjvstCISxoX8eywbnUMdUnxmCacVDWI/3ZiLCYcNsIXCGGOQIB8k/pGSrY13XQ==
X-Gm-Gg: ASbGncu0yE9jRhx3t5L/AWJi1oGDfDm5OE0DbHf6M4C0E5/UhcX6PnPkmdJHfitaM9S
	94Ouy2W0PzVT8K6I3cwMYlLlX3C5pQJZUqfwADKCOZbZzwd4CGtf1wBzJSxjE5Xa1XwvN6oewbj
	tTvyC5WEo+BS+mUNlp5pKjDdhTMC3vkvLWDUvT1jE/cgKMInUxSq7NDBA7+mc60WS11tTLd2vfi
	Y2vFgvGl08lRPL615xu72XHLzXuNEl/XD23wsCB+XnSCruduEZJkev0pDn74YhRkQdBnm0KYxjG
	GlathcXzJjGP
X-Google-Smtp-Source: AGHT+IGQyoODgkoUO+Oc0opjizE3auLPjFl7HcIY2FHdwIvo4FWM24+WSW6gR/vIwAErqWTGt1UzGQ==
X-Received: by 2002:a17:906:4d2:b0:aa6:aa89:6d5e with SMTP id a640c23a62f3a-aa6aa8971d4mr141516366b.18.1733843758225;
        Tue, 10 Dec 2024 07:15:58 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68f4eb962sm281095666b.3.2024.12.10.07.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 07:15:57 -0800 (PST)
Date: Tue, 10 Dec 2024 15:15:54 +0000
From: Quentin Perret <qperret@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/18] KVM: arm64: Change the layout of enum
 pkvm_page_state
Message-ID: <Z1hbKrUPXdEokXpP@google.com>
References: <20241203103735.2267589-1-qperret@google.com>
 <20241203103735.2267589-2-qperret@google.com>
 <CA+EHjTxfchr+ggO_z_zrrFTrFpS3oTJXt13t-854xWxYY=oSQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTxfchr+ggO_z_zrrFTrFpS3oTJXt13t-854xWxYY=oSQQ@mail.gmail.com>

Hey Fuad,

On Tuesday 10 Dec 2024 at 12:59:44 (+0000), Fuad Tabba wrote:
> Hi Quentin,
> 
> On Tue, 3 Dec 2024 at 10:37, Quentin Perret <qperret@google.com> wrote:
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
> >         PKVM_PAGE_OWNED                 = 0ULL,
> > -       PKVM_PAGE_SHARED_OWNED          = KVM_PGTABLE_PROT_SW0,
> > -       PKVM_PAGE_SHARED_BORROWED       = KVM_PGTABLE_PROT_SW1,
> > -       __PKVM_PAGE_RESERVED            = KVM_PGTABLE_PROT_SW0 |
> > -                                         KVM_PGTABLE_PROT_SW1,
> > +       PKVM_PAGE_SHARED_OWNED          = BIT(0),
> > +       PKVM_PAGE_SHARED_BORROWED       = BIT(1),
> > +       __PKVM_PAGE_RESERVED            = BIT(0) | BIT(1),
> >
> >         /* Meta-states which aren't encoded directly in the PTE's SW bits */
> > -       PKVM_NOPAGE,
> > +       PKVM_NOPAGE                     = BIT(2),
> >  };
> > +#define PKVM_PAGE_META_STATES_MASK     (~(BIT(0) | BIT(1)))
> >
> >  #define PKVM_PAGE_STATE_PROT_MASK      (KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
> >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> >                                                  enum pkvm_page_state state)
> >  {
> > -       return (prot & ~PKVM_PAGE_STATE_PROT_MASK) | state;
> > +       BUG_ON(state & PKVM_PAGE_META_STATES_MASK);
> 
> This is a slight change in functionality, having a BUG_ON instead of
> just masking out illegal states. Is it necessary?

Yep, this is arguably a bit zealous. Passing e.g. PKVM_NOPAGE to
pkvm_mkstate() would be properly bogus, so having a WARN_ON() or
BUG_ON() in there is still a good thing, but it should be done in a
separate patch.

I'll rework in v3.

> > +       prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > +       prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > +       return prot;
> >  }
> >
> >  static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
> >  {
> > -       return prot & PKVM_PAGE_STATE_PROT_MASK;
> > +       return FIELD_GET(PKVM_PAGE_STATE_PROT_MASK, prot);
> >  }
> >
> >  struct host_mmu {
> > --
> > 2.47.0.338.g60cca15819-goog
> >

