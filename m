Return-Path: <linux-kernel+bounces-374926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311FA9A7210
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA031C228AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5151FA272;
	Mon, 21 Oct 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="euvnf9m6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885D1F9AA3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534394; cv=none; b=KISQjs9tplWAqHO2w/aMyawfRvgr2ZOXzWnOuXfTs3REE/ZJb9AwNPxOkjJtwFNQKKwWBv7YlBs/N9OzCbSupv+VRzhykP3H4bpvtqjWuPY00syFxWxdeb+PO4iCn1RxYO0D+QVbWVIGE1RmajGJwp6pIg/y0j0lQ/CFmIFJnYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534394; c=relaxed/simple;
	bh=YeXYNnt8ENmKuB15YwhakNFnDdgCdBZF4Bj1D5TS0z8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AUjlCxbXSEawf+JohCk0kveNH+4iAXhPdR1OLgPbGjXCgdmpBJL45FIjy6xW3bZNfiDP1nQMGu8EMPm/vxCXeyotYxXHbPyzRyVAr4EOAVmlcRfw5IUqJTrK+adD6brzlSpNOhNZVzNFmtWx+6ISoigMYG/kJogypuJdvbvjo8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=euvnf9m6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3d660a1afso84025817b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729534390; x=1730139190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aTJKIPGdXYIQ4z1/mPhLVqGYb++KmSjcoFUbuTd6EE=;
        b=euvnf9m6h38cfleq8wzhcd4+GPezfWhDdSBEJghp3op9X86av4HWg2QtcWhCtMBXNq
         XFKil0NVwBZRIO7Zy9h9NW/I+jNndbeC8nOEucR0KzKiO0KPk2JAMZL4kw/HS3gImzM1
         7b1jSoBzFdWVAFnvs87kNBTtfAK8yFeuA5jkWJ2Qmop/DOj4nIxCIU+06f1szBnmxs4y
         h8Sgi1ltzAdT5jbwyIVOxnoxN8/TQb6D8duuHJuVoJV4Cy3ewh+7uks4GgMJ9dlkEQYI
         OFic8q7W0Ct8OQwCxk8ZVW2sUbg6POxpEGgxIzv9Sl+flZmIKpCzd1bOEz5mNoOBs+Bm
         lnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729534390; x=1730139190;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/aTJKIPGdXYIQ4z1/mPhLVqGYb++KmSjcoFUbuTd6EE=;
        b=IscksqMsIzQBJTyYAvap1n36Fgyz5dmiN60c+RmM3hSP/A0X9/kwvsulWwQfXVz44r
         D1flW6dOyG12WFafoR8LAVMsWper4VUgGeVD3oy/WI/m3vRPBkoxOolGxcCxT8uY2lic
         iuMFk+SXpctgO4juVYBqcbHlLL5qyjZHrpvRLS7uLv1LhkvgnQ2M2IQ1xiTQrQYunmcL
         tAH28FAte3Pd30d+DU8GP8tEtJw8deEgzd1s2zWGm0s2PJEmdMWj3GGcKyZWjsVuRh/1
         P5VSUlFDzkm0KkQeqy00fFZVt4iy2dfU0sGZU1fljFsVK4DCQ8eMyF/b80WRuEvmGSS6
         84ng==
X-Forwarded-Encrypted: i=1; AJvYcCWnXGLiU6egkWGwpxrYgcBLmlx/7ukAFb9ODbF0rpya8qj9+ZVhCI6k8VTT7wPRkCzPukJvuX6LncHHOAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycC/r2XY2Xv5ra9Oi1msMpzW0Rp2du6jM+wImS+g2egX1VX0Px
	dc/QXtoL6eNMkPwl+R29y0G697yuaDPsFOEIxrWPOWwzqUiwypOLh77xAZqDbzm7wedHlYka+YS
	CBw==
X-Google-Smtp-Source: AGHT+IGB051RPG0qZ1hHpRMmy9gqDX/0GH7so+xa+rGGnhbzxuPrj+6CH4debSRqPENvRC2d7Upq2p/funE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:8389:0:b0:e2b:e955:d58a with SMTP id
 3f1490d57ef6-e2be955d949mr2592276.7.1729534389536; Mon, 21 Oct 2024 11:13:09
 -0700 (PDT)
Date: Mon, 21 Oct 2024 11:13:08 -0700
In-Reply-To: <ZxYeFKl2KbZ3Ila1@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com> <20241010182427.1434605-35-seanjc@google.com>
 <ZxYeFKl2KbZ3Ila1@yzhao56-desk.sh.intel.com>
Message-ID: <ZxaZtJGfN2_5Db6h@google.com>
Subject: Re: [PATCH v13 34/85] KVM: Get writable mapping for __kvm_vcpu_map()
 only when necessary
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024, Yan Zhao wrote:
> On Thu, Oct 10, 2024 at 11:23:36AM -0700, Sean Christopherson wrote:
> > When creating a memory map for read, don't request a writable pfn from =
the
> > primary MMU.  While creating read-only mappings can be theoretically sl=
ower,
> > as they don't play nice with fast GUP due to the need to break CoW befo=
re
> > mapping the underlying PFN, practically speaking, creating a mapping is=
n't
> > a super hot path, and getting a writable mapping for reading is weird a=
nd
> > confusing.
> >=20
> > Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  virt/kvm/kvm_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 080740f65061..b845e9252633 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -3122,7 +3122,7 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t g=
fn, struct kvm_host_map *map,
> >  	struct kvm_follow_pfn kfp =3D {
> >  		.slot =3D gfn_to_memslot(vcpu->kvm, gfn),
> >  		.gfn =3D gfn,
> > -		.flags =3D FOLL_WRITE,
> > +		.flags =3D writable ? FOLL_WRITE : 0,
> >  		.refcounted_page =3D &map->pinned_page,
> >  		.pin =3D true,
> >  	};
> When writable is false, could we set ".pin =3D false," ?

Hmm, maybe?  I can't imagine anything would actually break, but unless FOLL=
_PIN
implies writing, my preference would still be to pin the page so that KVM a=
lways
pins when accessing the actual data of a page.

> Also not sure if ".map_writable =3D NULL" is missing.

Doh, my previous response was slightly wrong, it's implicitly initialized t=
o NULL,
not false.  I forgot map_writable is a pointer to a bool.

