Return-Path: <linux-kernel+bounces-257353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB799378ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF881F222D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27A3144D37;
	Fri, 19 Jul 2024 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqtVf+Ca"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38629144D10
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398164; cv=none; b=Qz8NiLfEFT3T3JPtUw9+6ROZnsISFouBdc2QhrhvDbZiV6oUQ2XvTArPMmGxnsiEuz3/g5SLlulyyq0ruuvYvbtG8jiXZw3NpRF2hUgVnMgjGuC7p+qcHMhMCr0dHJL51TGachK3pQjaQm1+eotnA0Gqnq8ujKE8wmHvdItX5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398164; c=relaxed/simple;
	bh=yrT+Bc+klEJuHiw98KfpGH71hLcGRLqA81h5h2dy/zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlVZLG2uCxBZYQGuUEv33MA+akY+q9LYHVzNZ92MCAtLWr7aae/HcmsBW81z5A6A4AZ0Dd+M1iEAjaryzt0YuV2jG0XNB2r2yqGJVuXxuRTEsJO+a3tcOi4osf3whWRfLpxvaXtJDJPV8Tb65jKMVK9rus2AMRdroNYlJGz2GEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqtVf+Ca; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so12480a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721398161; x=1722002961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPrxOA5Jo5X8ogv77DWTSjqpheBlFxY6lo9/95nhICY=;
        b=HqtVf+CaM8LuyHCH7Vz2LBFaMPxTdIliRUhg2Ns7HHVGgcwHtEmL9gAC4XdrLDy7lG
         GMuxsuOoH1lPctThD/45wpyP32IEnO5y/WwxcO73jOjFEMy2jLKb59nHzBnachybIoBe
         c1F+G2rBfSu4PYyqeUVpr2ITeOF2yEDpi1RdwZCDMBU8whpN3woaLoo22nJlzBwflEkj
         SWFyarEuvlK/tcTkBpYCk5hg7+OReLUla4fLOKeiO0ceIFs0tzc1gyk4ee7h6O0RI2f4
         Q7w2tgrVIlkiILLlAI3TxDzIJ/+61GKKbaq1Jej+a+bIMddzn88go8WK5IOcDgqCcGEo
         A/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721398161; x=1722002961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPrxOA5Jo5X8ogv77DWTSjqpheBlFxY6lo9/95nhICY=;
        b=t0LQcU+2wP2bvFPVj55opKg14exhhZh9+zzhLepOw9ff2weEJLZGuKoguuHCnBjN2P
         T+mZcQTnRGEMw/30p+ZQb85WI/Wy3k899YG0OvxclAkx9fAfipbgqrtwWqZvSPz06TSn
         JHEYpyzsg/uI3uV1KDRKUU/rwHUX1AljfX8yZwlxCVX7P27RXY0RejOcUgJlZsRlkU2L
         RECIz58dOxBYlEA377SuUVbl2WvzWr4X2Zy9EiZ7/62d830Lnn3AW4WRySFme8CxT16n
         dV6+cdMqICCc7pQ6eBmEFlIQXsM3zfwl88SEQdepu6nejsSilA0zu+3hM34fMeIffESJ
         cZyA==
X-Forwarded-Encrypted: i=1; AJvYcCUGqsmihsFkSo+urw1XmGyvgEpbkrY3t75t1YuzTdUJo8DfLsN2LMgVAcw9PkiTA4kGbb9e1crkQ0YvhaUfZuMcpry/uu6KIP9g1jQ8
X-Gm-Message-State: AOJu0YyYAcG924ygfDcL6E45gv5x+EJJgTvtOK2S/jyNd68OtiBcFMuL
	ac2wOgVcJCfZ+1P6Klv75PztN0JyTsSzuzmmN8Vb8/ZACPOsRaTP6tZsdYlBUw==
X-Google-Smtp-Source: AGHT+IGnXJyyFRlm/DzULfk3KGAkpy7LZO4NL6G+C38+3NI6Cxge1cG7pYzTXj+BCtoveuiX65kSqw==
X-Received: by 2002:a05:6402:50c9:b0:57c:c5e2:2c37 with SMTP id 4fb4d7f45d1cf-5a2f262b220mr155977a12.3.1721398160978;
        Fri, 19 Jul 2024 07:09:20 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368786848f9sm1722929f8f.1.2024.07.19.07.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 07:09:20 -0700 (PDT)
Date: Fri, 19 Jul 2024 14:09:19 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v7 5/6] KVM: arm64: Initialize the ptdump parser with
 stage-2 attributes
Message-ID: <Zppzj1oIDivlAFpP@google.com>
References: <20240621123230.1085265-1-sebastianene@google.com>
 <20240621123230.1085265-6-sebastianene@google.com>
 <ZoJsAyrmtge4mXJY@google.com>
 <ZoK6v2_pJnc57LHM@google.com>
 <ZpZEjW1m2LypTHjF@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpZEjW1m2LypTHjF@google.com>

On Tue, Jul 16, 2024 at 10:59:41AM +0100, Vincent Donnefort wrote:
> On Mon, Jul 01, 2024 at 02:18:39PM +0000, Sebastian Ene wrote:
> > On Mon, Jul 01, 2024 at 09:42:43AM +0100, Vincent Donnefort wrote:
> > > O Fri, Jun 21, 2024 at 12:32:29PM +0000, 'Sebastian Ene' via kernel-team wrote:
> > > > Define a set of attributes used by the ptdump parser to display the
> > > > properties of a guest memory region covered by a pagetable descriptor.
> > > > Build a description of the pagetable levels and initialize the parser
> > > > with this configuration.
> > > > 
> > > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > > ---
> > > >  arch/arm64/kvm/ptdump.c | 143 ++++++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 137 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > > > index 36dc7662729f..cc1d4fdddc6e 100644
> > > > --- a/arch/arm64/kvm/ptdump.c
> > > > +++ b/arch/arm64/kvm/ptdump.c
> > > > @@ -14,6 +14,61 @@
> > > >  #include <kvm_ptdump.h>
> > > >  
> > > >  
> > > > +#define MARKERS_LEN		(2)
> > > > +#define KVM_PGTABLE_MAX_LEVELS	(KVM_PGTABLE_LAST_LEVEL + 1)
> > > > +
> > > > +struct kvm_ptdump_guest_state {
> > > > +	struct kvm		*kvm;
> > > > +	struct pg_state		parser_state;
> > > > +	struct addr_marker	ipa_marker[MARKERS_LEN];
> > > > +	struct pg_level		level[KVM_PGTABLE_MAX_LEVELS];
> > > > +	struct ptdump_range	range[MARKERS_LEN];
> > > > +};
> > > > +
> > > > +static const struct prot_bits stage2_pte_bits[] = {
> > > > +	{
> > > > +		.mask	= PTE_VALID,
> > > > +		.val	= PTE_VALID,
> > > > +		.set	= " ",
> > > > +		.clear	= "F",
> > > > +	}, {
> > > > +		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > > > +		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> 
> KVM_PTE_LEAF_ATTR_HI_S2_XN is actually a mask covering 

It is not a mask covering here but in the ACK kernel.

> 
> KVM_PTE_LEAF_ATTR_HI_S2_XN_XN, KVM_PTE_LEAF_ATTR_HI_S2_XN_PXN and
> KVM_PTE_LEAF_ATTR_HI_S2_XN_UXN. 
> 
> I believe here what we should do is something like?
> 
> .val = FIELD_PREP_CONST(KVM_PTE_LEAF_ATTR_HI_S2_XN,
> 			KVM_PTE_LEAF_ATTR_HI_S2_XN_XN) | PTE_VALID
> 
> > > > +		.set	= "XN",
> > > > +		.clear	= "  ",
> > > > +	}, {
> > > > +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> > > > +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> > > > +		.set	= "R",
> > > > +		.clear	= " ",
> > > > +	}, {
> 
> [...]

