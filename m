Return-Path: <linux-kernel+bounces-275453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9619485E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190FE1F23853
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75D16EC02;
	Mon,  5 Aug 2024 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RKwoJraZ"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3816B16D9DC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900430; cv=none; b=D20IXuPsF+l+8o7xJfWRyzn4F+CK9sUx2yNlBXI7nMLuZwmX6XzgpTZfvwzdf8FnwX1OQRJie0c4xDozyJuR+GcvKXYvVw9v8oUSFPOQrZ0opdBydoazHsNLY7ROOMPjxe+wI2XDW59lzsG0ZfDqiztCnzMe1n5hhCpxNTBTn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900430; c=relaxed/simple;
	bh=TGXOf7/1guqVacY7V5I/og3eT0WLPefs7Me46InMVQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cy5i0UlIlCcLh/wkc5+SRxDYrVzdvhLEgfp7MqSckRLpcW3l3eW48/W6GhFQeu//GIVlOJc4mpalpb3+x170hwHaIYxW3vx3dv3ql/dbIr3OtFmVDfy5stkysa76Go0tjt0L3FHMP9DzbsSw653I19fN3up0+bVoA9Marc/Rfoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RKwoJraZ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Aug 2024 23:26:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722900421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/Y4ENu+y9slWM0GBwHxlJjHc94wXfdkp05Gs7ZabqI=;
	b=RKwoJraZF8EcCuf9Yeaydj7V+54xjIFKFDGqqwUhB7a+wtctICJfGkJrTsxTgXHoUCGmr/
	MxT6+GXFZukzNHF22AQeMcjuXCNYLrDgYRshsfdGgn8o53cA/EySOVyTW+EnxUHWDvXDVo
	mtK4xMi/hhtI0dNWL878kUCnrmNBHXM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	David Matlack <dmatlack@google.com>,
	David Stevens <stevensd@chromium.org>,
	Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v12 54/84] KVM: arm64: Mark "struct page" pfns
 accessed/dirty before dropping mmu_lock
Message-ID: <ZrFfvjy_-Tyx4xUV@linux.dev>
References: <20240726235234.228822-1-seanjc@google.com>
 <20240726235234.228822-55-seanjc@google.com>
 <ZrFfgzRbiqT-Zi2O@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrFfgzRbiqT-Zi2O@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 05, 2024 at 11:26:03PM +0000, Oliver Upton wrote:
> [+cc Fuad]

Take 2!

> Fuad, you mentioned in commit 9c30fc615daa ("KVM: arm64: Move setting
> the page as dirty out of the critical section") that restructuring
> around the MMU lock was helpful for reuse (presumably for pKVM), but I
> lack the context there.
> 
> On Fri, Jul 26, 2024 at 04:52:03PM -0700, Sean Christopherson wrote:
> > Mark pages/folios accessed+dirty prior to dropping mmu_lock, as marking a
> > page/folio dirty after it has been written back can make some filesystems
> > unhappy (backing KVM guests will such filesystem files is uncommon, and
> 
> typo: s/will/with/
> 
> > the race is minuscule, hence the lack of complaints).  See the link below
> > for details.
> > 
> > This will also allow converting arm64 to kvm_release_faultin_page(), which
> > requires that mmu_lock be held (for the aforementioned reason).
> > 
> > Link: https://lore.kernel.org/all/cover.1683044162.git.lstoakes@gmail.com
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/arm64/kvm/mmu.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 22ee37360c4e..ce13c3d884d5 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -1685,15 +1685,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >  	}
> >  
> >  out_unlock:
> > +	if (writable && !ret)
> > +		kvm_set_pfn_dirty(pfn);
> 
> I'm guessing you meant kvm_release_pfn_dirty() here, because this leaks
> a reference.
> 
> > +	else
> > +		kvm_release_pfn_clean(pfn);
> > +
> >  	read_unlock(&kvm->mmu_lock);
> >  
> >  	/* Mark the page dirty only if the fault is handled successfully */
> > -	if (writable && !ret) {
> > -		kvm_set_pfn_dirty(pfn);
> > +	if (writable && !ret)
> >  		mark_page_dirty_in_slot(kvm, memslot, gfn);
> > -	}
> >  
> > -	kvm_release_pfn_clean(pfn);
> >  	return ret != -EAGAIN ? ret : 0;
> >  }
> >  
> > -- 
> > 2.46.0.rc1.232.g9752f9e123-goog
> > 
> 
> -- 
> Thanks,
> Oliver

-- 
Thanks,
Oliver

