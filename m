Return-Path: <linux-kernel+bounces-374918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4219F9A71FE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCD92810AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69211FCC64;
	Mon, 21 Oct 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kvy2TT4n"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C61FAC23
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534135; cv=none; b=VW/4NfOheVtNfnwD3u/ganfGhOSJ1Ok4DJxfT9Sm1Pzdzl3E1ncJeeQ0bRnEKDappDMDvZmvj/XvJs78PY+TucoydGrEbQDzNq1ttsp4mupKhy9i9CUqzl+6ydU8iiJ+zTWbnmhsD558SNBdblvJm3HbWkz3LEyvLCw6Fely3z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534135; c=relaxed/simple;
	bh=lGAahFUJB47Jv0GHevlLPsXzZ4O8VtjPyAFbuGdCp8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V8yxmmgUWFlSHjAU2lmMhZjNhaM9FjWJE8MNrRLyr9mgsakvFLX2PlHk7xHH/x0HWLLybt7NiEKDSR+OUMJodqGvC9RsoPbADPzKOTaNCiXHtKpIXFGSb+lSomU/2PeKQePDtQehdJVVh5qR9WAgCysYuYHu9gSYRl3Dyik4hfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kvy2TT4n; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e2d396c77fso6060534a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729534131; x=1730138931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4nB5AD8jm9woOflkJu9LaOALYzY3FWUJ+pKW1FSB8o=;
        b=Kvy2TT4nFNRE4v6qOhuvlFoeLee0AdD4xf9oblSyYyxEb8GhQukzYNy1Ol8V+YhjMD
         C3NGaSmYp8oth+na2vGGhm3ih9Koiclz5KYzTxNy5pcVr9ARX+mnJ7B613cFBUpFK71x
         iWfh/ohEyQ3Xp1/YPlK/EY1B9iYSmr4Yc2fpQbUSrFtQAag2BJB0DTanRLhydyrkVu9O
         GSS75Wqwr+13Ik7si/pFv+bQ9H6zv6VW5TQn/3oPp/u1JWFq2rLcxcl9vwwiK6DdqnGd
         IvqPdPaVrspj8hHudi68Q1kFLiJtYZwvkWAsKsGoodfBahhHBnpIyInghyeovWvoyWBg
         r/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729534131; x=1730138931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4nB5AD8jm9woOflkJu9LaOALYzY3FWUJ+pKW1FSB8o=;
        b=ZmrKyknVnGFyR6p2kKJGf9R8PCAmAqVs40B63r2vGNW31AqhrbqcS53VxCuqLBf8Ob
         YjRToZ2GTOs/pW/OIS2Ymn2lkKJzdyqX2tbeV3OE1CRfRwr5F7H88g6GBJu/PmEPm8Mm
         USxyjzk0scIpuEFaNMf2DHKO+HYDCxeswzif4abontxtsr1GDVpFzHpnw3cHKGC53jrX
         OxSq2CqrfdGBKitr41Lq3DrtUgokDVO4SkhMAoggkAsD6JsK0HUgqbMcuCKyusz3CCXE
         5cYQDsa0xTxUcFywzGvTyiIvz0/37ex8hOrYwJhPlRUo4OVAiV04ZDvwPpyKn9fAuj0P
         x9PA==
X-Forwarded-Encrypted: i=1; AJvYcCXv1w79UXQg0UczN4VeMgB4zPZYRD125j1lNVcDOJ+HPU1Yse3OGOpstNJjsYvAFWKhrGaF82wvb5qiReM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZjh9v5LuYw7DT6sNtUTiwYEdCQkVtxumXUBxDTkbSQ7DbDdLL
	VD8zDZEa557mMSUa8wVXU29hvBiKxdSfT3fa2RHRTVpUAjLPseZflrcRGMQVuBBqIGSH7ANGxwl
	07g==
X-Google-Smtp-Source: AGHT+IHz/sqxbIaZMzAhwQE+KHAQ50pc4vGOx7OQ/MlEMfrpYKQ16K4ySzEgLcCV5+myw9EmSbX31Z6uvf4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e147:b0:2d8:a9c2:2f3a with SMTP id
 98e67ed59e1d1-2e5616d8f42mr22750a91.3.1729534130899; Mon, 21 Oct 2024
 11:08:50 -0700 (PDT)
Date: Mon, 21 Oct 2024 11:08:49 -0700
In-Reply-To: <ZxYVnsW9WF1Wp8mx@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com> <20241010182427.1434605-20-seanjc@google.com>
 <ZxYVnsW9WF1Wp8mx@yzhao56-desk.sh.intel.com>
Message-ID: <ZxaYsfc0m6UHmi10@google.com>
Subject: Re: [PATCH v13 19/85] KVM: Introduce kvm_follow_pfn() to eventually
 replace "gfn_to_pfn" APIs
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"Alex =?utf-8?Q?Benn=C3=A9e?=" <alex.bennee@linaro.org>, David Matlack <dmatlack@google.com>, 
	David Stevens <stevensd@chromium.org>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 21, 2024, Yan Zhao wrote:
> On Thu, Oct 10, 2024 at 11:23:21AM -0700, Sean Christopherson wrote:
> > --- a/virt/kvm/pfncache.c
> > +++ b/virt/kvm/pfncache.c
> > @@ -159,6 +159,12 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
> >  	kvm_pfn_t new_pfn = KVM_PFN_ERR_FAULT;
> >  	void *new_khva = NULL;
> >  	unsigned long mmu_seq;
> > +	struct kvm_follow_pfn kfp = {
> > +		.slot = gpc->memslot,
> > +		.gfn = gpa_to_gfn(gpc->gpa),
> > +		.flags = FOLL_WRITE,
> > +		.hva = gpc->uhva,
> > +	};
> Is .map_writable uninitialized?

Nope, per C99, "subobjects without explicit initializers are initialized to zero",
i.e. map_writable is initialized to "false".

