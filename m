Return-Path: <linux-kernel+bounces-180337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413168C6D10
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E47B22D81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C99715B0E5;
	Wed, 15 May 2024 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="s2fcUMEF"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6115ADA6
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715803556; cv=none; b=XFDWcEnCYzXXhV+BFVvsS+s5TrBkZnmyhtyLEERcUXtYyZH6j38kED5pM2PPIf0JIGbeLPQlr8jkh+XwqHiVJSLurmqFMxotak+c+IFec1faneLLdaBVtu7dKCW+bjoJ3CtXjKzdznVK4/UB7tLIlZDrtPZY1oXNbQQPULsrghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715803556; c=relaxed/simple;
	bh=MRYqyK/eh+ejjz299sxXMgWxMTryii2TTKrFc4cKNX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lQKNgTss6FOmfjCz/XjqvubquK0rEA8fHQSbjgsKEzegQ7aM/GXJ9/FLayBAtYTUQFnddAQQwALq7Q/jH+JpBPEXWWlOUB4LCsz12TZ4UtqyQVucuiOgk04exGFcdKtmCSEGa5yizcM6pMrzmvBIYOcYPYQty5AvGrzMaRcw2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2fcUMEF; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-65705318a0cso564254a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715803554; x=1716408354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYjGNuXfJGyYKmZiraJ4nTzv7LRInOqO/1LJt0EInfk=;
        b=s2fcUMEFvKnsLhi3f8WFi5UtArGU2bsS1rcDB0AQ9jECYIJbhrWb127XD1AfAkn8GZ
         s4Lh/9g/fN77bPTwaHhOXmc7c7BSs1Ynbu/YZunU1DCcgE8/2u0ls28tOxLtUL3Fn5IC
         yQIlSMXsNuc8Z0i/FbQuBOf4/3fUJ3qbFejvzBbFDT6lK1baj9slFCbChDU0uOnsuDzt
         FWmKwho6+4Aj4Kug101dnmXgzhJgt/ouH6s8P9iNQ8E/eg7dVRtYOiTtUc8+U6hXDdpD
         hvTh42/zHaKtSKLP0jUMcY7/AMm9ZuettZMMUDwoYLID3emVySohgiFaTMjHLdESR1eg
         3dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715803554; x=1716408354;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jYjGNuXfJGyYKmZiraJ4nTzv7LRInOqO/1LJt0EInfk=;
        b=XNH42WnZ8xBOIr98EouJTeDd64VcnubiiZaEVD6/eLmYlCqkNOUfUvbD/v/YZNetS8
         2bLIOJXztd7h+bcb5VQp4mxNYRtqBVTw+izqWXbKQCJQr+GfzplZ+Jppa3TYfqPUbt8J
         E/pP8uAMrC2w5xB7FyxKShm5VD8c7cEnEtnbYX7NYRXkshzO8YTVCUPKk3ZFXbBgqXT1
         P6O28Gb1Sisa84i10V7mUmNV5o5haY5ggFhqz5VMGyMh/zexwdA32ikBLD0Sis5rvO9Q
         FVVouCL73UWAegWCRuAX0KyDnm9sB/hwa6BVzpuTH2h92KLV41jVS4pTD7biGjhbPGn0
         uwxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdkrHxKcd8fknn+eKU9mA58MZ4wPLI7Qg5cA+3q4S3Fd+zkjWJTPTMMSvtFRODKnDIxqMljf5WWlg6QcFhX+gX2DgId36o/1BW1mJ7
X-Gm-Message-State: AOJu0YxGd/o2UJW8y1QkbnfjVLaOuzKQ9/eBVkAhUZ4E0dqWmIHCFiBP
	9dvkPD4ZL298LW7E6at6PEOwwUkdr7NI06kQmSpnDzOTcq2AlIC4KYLe5bFFvZotqiuvl27ayXX
	RXw==
X-Google-Smtp-Source: AGHT+IGhgl+72xHXi1XwqVj8A0OHpgEJA0VV0DtQPx3LUgviGBkN7o33SBsG7c4LPS/NRnUi7VZkMKXc1eM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:4801:0:b0:635:62f6:d5ea with SMTP id
 41be03b00d2f7-6373d2191f9mr45096a12.4.1715803553662; Wed, 15 May 2024
 13:05:53 -0700 (PDT)
Date: Wed, 15 May 2024 13:05:52 -0700
In-Reply-To: <1257b7b43472fad6287b648ec96fc27a89766eb9.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515005952.3410568-1-rick.p.edgecombe@intel.com>
 <20240515005952.3410568-3-rick.p.edgecombe@intel.com> <b89385e5c7f4c3e5bc97045ec909455c33652fb1.camel@intel.com>
 <ZkUIMKxhhYbrvS8I@google.com> <1257b7b43472fad6287b648ec96fc27a89766eb9.camel@intel.com>
Message-ID: <ZkUVcjYhgVpVcGAV@google.com>
Subject: Re: [PATCH 02/16] KVM: x86/mmu: Introduce a slot flag to zap only
 slot leafs on slot deletion
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kai Huang <kai.huang@intel.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, "sagis@google.com" <sagis@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "dmatlack@google.com" <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024, Rick P Edgecombe wrote:
> On Wed, 2024-05-15 at 12:09 -0700, Sean Christopherson wrote:
> > > It's weird that userspace needs to control how does KVM zap page tabl=
e for
> > > memslot delete/move.
> >=20
> > Yeah, this isn't quite what I had in mind.=C2=A0 Granted, what I had in=
 mind may
> > not be much any better, but I definitely don't want to let userspace
> > dictate exactly how KVM manages SPTEs.
>=20
> To me it doesn't seem completely unprecedented at least. Linux has a ton =
of
> madvise() flags and other knobs to control this kind of PTE management fo=
r
> userspace memory.

Yes, but they all express their requests in terms of what behavior userspac=
e wants
or to communicate userspace's access paterns.  They don't dictate exact low=
 level
behavior to the kernel.

> > My thinking for a memslot flag was more of a "deleting this memslot doe=
sn't
> > have side effects", i.e. a way for userspace to give KVM the green ligh=
t to
> > deviate from KVM's historical behavior of rebuilding the entire page
> > tables.=C2=A0 Under the hood, KVM would be allowed to do whatever it wa=
nts, e.g.
> > for the initial implementation, KVM would zap only leafs.=C2=A0 But cri=
tically,
> > KVM wouldn't be _required_ to zap only leafs.
> >=20
> > > So to me looks it's overkill to expose this "zap-leaf-only" to usersp=
ace.
> > > We can just set this flag for a TDX guest when memslot is created in =
KVM.
> >=20
> > 100% agreed from a functionality perspective.=C2=A0 My thoughts/concern=
s are
> > more about KVM's ABI.
> >=20
> > Hmm, actually, we already have new uAPI/ABI in the form of VM types.=C2=
=A0 What
> > if we squeeze a documentation update into 6.10 (which adds the SEV VM
> > flavors) to state that KVM's historical behavior of blasting all SPTEs =
is
> > only _guaranteed_ for KVM_X86_DEFAULT_VM?
> >=20
> > Anyone know if QEMU deletes shared-only, i.e. non-guest_memfd, memslots
> > during SEV-* boot?=C2=A0 If so, and assuming any such memslots are smal=
lish, we
> > could even start enforcing the new ABI by doing a precise zap for small
> > (arbitrary limit TBD) shared-only memslots for !KVM_X86_DEFAULT_VM VMs.
>=20
> Again thinking of the userspace memory analogy... Aren't there some VMs w=
here
> the fast zap is faster? Like if you have guest with a small memslot that =
gets
> deleted all the time, you could want it to be zapped specifically. But fo=
r the
> giant memslot next to it, you might want to do the fast zap all thing.

Yes.  But...

> So rather then try to optimize zapping more someday and hit similar issue=
s, let
> userspace decide how it wants it to be done. I'm not sure of the actual
> performance tradeoffs here, to be clear.

..unless someone is able to root cause the VFIO regression, we don't have =
the
luxury of letting userspace give KVM a hint as to whether it might be bette=
r to
do a precise zap versus a nuke-and-pave.

And more importantly, it would be a _hint_, not the hard requirement that T=
DX
needs.

> That said, a per-vm know is easier for TDX purposes.

