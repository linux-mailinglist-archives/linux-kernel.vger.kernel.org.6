Return-Path: <linux-kernel+bounces-547095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B469A502FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C83189DBF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C10724E4CF;
	Wed,  5 Mar 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duOc922p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE7324CEE1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186465; cv=none; b=lT0TEOO1UEQHCbWCtdLcI19tFrzglaw+/jQuVui8tFvbCdJkEOgjgbAZ+OBrDCuHshQAd/Yu3OAR3fi3KSneTe8H9R8Sgj7T92+t4LmnAFQVygoAewXdf9zpiGYvMUXkUlGRlcReScIvkmioj7WV9PROAwI6LJULi7wvEHzXmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186465; c=relaxed/simple;
	bh=p4UtG3lt8etjyR4QSuHV4b+bVzVCE8Zwt/muQtfpYVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9QbVtqFQ7oFSWdrPT569UePKKY6ckWcrZJrobohRrlQLrPyyZUx2q6oySiNgFEciI4fei+jPxYF0SLuh7IDP7RA8y9X6SsMUmaUb0o7FQxPnXsKOh8XYrLDzUxaHurqItgAJ1vCZd12URDivhdAmwHqUsrvaAq9t7YzC2isvhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duOc922p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741186462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cox8z8lPi8h9WF637SHJRl9fGGbJ29Arrtfjq01tB+8=;
	b=duOc922pgvhhmREy2G89QG4E/O2zOFsgeU79GboaFO9YM0is5NvwUbEvaKu30Tvjs6hI/v
	HhKhO24OkRuMrxRNHyiGUWJ8XQ2ziuSavhusXS/fq6bNUJu41+MHNYts4irBxc2t9xl+K4
	WYUg8yY5a5OCHI3ohj83SIQBcEHrwZI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-Edq3Zz1UNLytrZlTVV5LsQ-1; Wed, 05 Mar 2025 09:54:21 -0500
X-MC-Unique: Edq3Zz1UNLytrZlTVV5LsQ-1
X-Mimecast-MFC-AGG-ID: Edq3Zz1UNLytrZlTVV5LsQ_1741186460
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390f11e6fdbso2458657f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186459; x=1741791259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cox8z8lPi8h9WF637SHJRl9fGGbJ29Arrtfjq01tB+8=;
        b=D0V8Rqcpdx1wggQZjukNM+SjlqQZDveJM7ZyHNZ5csgoS78CF0rRmqFRx7BYlglvM4
         5Zkjypdky5fhvTHdQQW8cOybTMrF1N2svB2sYTdO2H9bFVUJBQcGFIgMpxiI5egvkfmr
         vy0BUB5sl7wQiK8SSuZxfhCGBmlpnIpNa7JoiWfKTQmdO16TOWLxLzqhyJLj2DoIiQZM
         xJ64uR3NUmHY1DBvXNs9M7y6NX/AEUQQjeGwkdBXMMEffc8PHhikb8DUKRH93QMNZegG
         Gbu43KXt9lrt05LwURwcAirU0TDQl6XnKt62hkS9HMHtEfq7pljHdDixdEcc3PTl9+ND
         L70A==
X-Forwarded-Encrypted: i=1; AJvYcCUaB6qA0wkir1tGgx3u/DENi2eH0DOblbQoUabOYbjWZAkMQQi2PzIFdzun6MGiDxFaU5sMXTXisIFjImA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdAQXmzbskH3yn/er0RjA3to/531bwcDWKRaIHewLL79JcarG
	nJKbWHuE5MHB2Bfvn3DBU4py/PyxB5+tEG/XoY+fye0KakL7w/wKMUe137Ef73Remw8PsJelcaD
	BSDJGIQwUEpEcP4OyPuYMZ9TAYEkKYU2xoCXOcCXPhTpqVgtG0mCrZwRVGqM4I1Ue5VMCXKaCql
	e2o3+k1Kur+QrUpT0Pat/kGz1udkzhr65yK+L5Nlnjvi72Af52RDKF
X-Gm-Gg: ASbGncsCOCGj2+rlV6ooZJ+Va9XBkW2yFb+xqC4l3pFUstXGLo7KtMty/3HBmboGflg
	KLp6qWHE4l+4+cEcAanW5hOsqXJm8SEse9WPkC2f5XTGKblAI7fktrZpR+8zOgXan5GiuyhuO
X-Received: by 2002:a05:6000:136f:b0:390:e1c5:fe2 with SMTP id ffacd0b85a97d-3911f7bac6bmr2620730f8f.38.1741186458845;
        Wed, 05 Mar 2025 06:54:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4PvVuGKTxjn5+5ksdqhrhoFlLx86CRmMyFCnvhKsn1bSfHEsAqd2/zQT4R+Gyx1q0iDsSyD24ytNHcUzKCCU=
X-Received: by 2002:a05:6000:136f:b0:390:e1c5:fe2 with SMTP id
 ffacd0b85a97d-3911f7bac6bmr2620699f8f.38.1741186458470; Wed, 05 Mar 2025
 06:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112095527.434998-4-pbonzini@redhat.com> <DDEA8D1B-0A0F-4CF3-9A73-7762FFEFD166@xenosoft.de>
 <2025030516-scoured-ethanol-6540@gregkh>
In-Reply-To: <2025030516-scoured-ethanol-6540@gregkh>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 5 Mar 2025 15:54:06 +0100
X-Gm-Features: AQ5f1Jq9Q6hjcyw1JQehTB9dj5tz1yQanFW326sta5ahk4Wq43oLtxt1PyaZ6q4
Message-ID: <CABgObfb5U9zwTQBPkPB=mKu-vMrRspPCm4wfxoQpB+SyAnb5WQ@mail.gmail.com>
Subject: Re: [Kernel 6.12.17] [PowerPC e5500] KVM HV compilation error
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, seanjc@google.com, linuxppc-dev@lists.ozlabs.org, 
	regressions@lists.linux.dev, Trevor Dickinson <rtd2@xtra.co.nz>, 
	mad skateman <madskateman@gmail.com>, hypexed@yahoo.com.au, 
	Darren Stevens <darren@stevens-zone.net>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 3:19=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> On Wed, Mar 05, 2025 at 03:14:13PM +0100, Christian Zigotzky wrote:
> > Hi All,
> >
> > The stable long-term kernel 6.12.17 cannot compile with KVM HV support =
for e5500 PowerPC machines anymore.
> >
> > Bug report: https://github.com/chzigotzky/kernels/issues/6
> >
> > Kernel config: https://github.com/chzigotzky/kernels/blob/6_12/configs/=
x5000_defconfig
> >
> > Error messages:
> >
> > arch/powerpc/kvm/e500_mmu_host.c: In function 'kvmppc_e500_shadow_map':
> > arch/powerpc/kvm/e500_mmu_host.c:447:9: error: implicit declaration of =
function '__kvm_faultin_pfn' [-Werror=3Dimplicit-function-declaration]
> >    pfn =3D __kvm_faultin_pfn(slot, gfn, FOLL_WRITE, NULL, &page);
> >          ^~~~~~~~~~~~~~~~~
> >   CC      kernel/notifier.o
> > arch/powerpc/kvm/e500_mmu_host.c:500:2: error: implicit declaration of =
function 'kvm_release_faultin_page'; did you mean 'kvm_read_guest_page'? [-=
Werror=3Dimplicit-function-declaration]
> >   kvm_release_faultin_page(kvm, page, !!ret, writable);
> >
> > After that, I compiled it without KVM HV support.
> >
> > Kernel config: https://github.com/chzigotzky/kernels/blob/6_12/configs/=
e5500_defconfig
> >
> > Please check the error messages.
>
> Odd, what commit caused this problem?

48fe216d7db6b651972c1c1d8e3180cd699971b0

> Any hint as to what commit is missing to fix it?

A big-ass 90 patch series. __kvm_faultin_pfn and
kvm_release_faultin_page were introduced in 6.13, as part of a big
revamp of how KVM does page faults on all architectures.

Just revert all this crap and apply the version that I've just sent
(https://lore.kernel.org/stable/20250305144938.212918-1-pbonzini@redhat.com=
/):

commit 48fe216d7db6b651972c1c1d8e3180cd699971b0
    KVM: e500: always restore irqs

commit 833f69be62ac366b5c23b4a6434389e470dd5c7f
    KVM: PPC: e500: Use __kvm_faultin_pfn() to handle page faults
    Message-ID: <20241010182427.1434605-55-seanjc@google.com>
    Stable-dep-of: 87ecfdbc699c ("KVM: e500: always restore irqs")

commit f2623aec7fdc2675667042c85f87502c9139c098
    KVM: PPC: e500: Mark "struct page" pfn accessed before dropping mmu_loc=
k
    Message-ID: <20241010182427.1434605-54-seanjc@google.com>
    Stable-dep-of: 87ecfdbc699c ("KVM: e500: always restore irqs")

commit dec857329fb9a66a5bce4f9db14c97ef64725a32
    KVM: PPC: e500: Mark "struct page" dirty in kvmppc_e500_shadow_map()
    Message-ID: <20241010182427.1434605-53-seanjc@google.com>
    Stable-dep-of: 87ecfdbc699c ("KVM: e500: always restore irqs")

And this, ladies and gentlemen, is why I always include the apparently
silly Message-ID trailer. Don't you just love how someone, whether
script or human, cherry picked patches 53-55 without even wondering
what was in the 52 before. I'm not sure if it'd be worse for it to be
a human or a script... because if it's a script, surely the same level
of sophistication could have been put into figuring out whether the
thing even COMPILES.

Sasha, this wins the prize for most ridiculous automatic backport
ever. Please stop playing maintainer if you can't be bothered to read
the commit messages for random stuff that you apply.

Paolo


