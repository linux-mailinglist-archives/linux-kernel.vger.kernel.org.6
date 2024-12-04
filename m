Return-Path: <linux-kernel+bounces-432205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840199E476F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC9F163928
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0464B1990DB;
	Wed,  4 Dec 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jypwH+ZI"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE3191F9C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350027; cv=none; b=iQqBXmB6NUZ9EBpWAI12Tq4Uz1mwc91G7fOW/DBj9VqXmUtR2LRaSkTRPERqq2z4vcVG8nBh4zO2fPvVikFK86+hf/VfA7JbzZJM9OJFs90tezFPDIP03a5pU7nHjgAX+XqkI2WzzU87K8oPts40BYtbK+EmEF2ciQax3pK85kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350027; c=relaxed/simple;
	bh=hcKJkigpDfJnVEw+g7V0Jj2o3XXwPHpc8NPohID/TZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LyoeEkwPuTZJTlbltuIcYMhEwU0ZYZ0dyVpo2oPNsRM9GxiGPr+oS2Us84KNeTY+MTNa3hMy7ELrJfJhktTYDre5h+EJN3j/viqdu7eQsHBDCB8DgfS1kG/VYshJwwuwOZ/G3AMZUs4miV4NWHYRcr7ymE5idf51+wl2vx4599w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jypwH+ZI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7f8b37ede6bso266894a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733350025; x=1733954825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtfbGj6yD8jziLUL93ECE0Ci1aFCtpcn9XBirZhmTWc=;
        b=jypwH+ZIWriM7GEy/cIzjLytXeM1ys4jdK+aQIQ/1/5g2p4alby9vr5wlqFvvTbtRP
         jnPkH2G47wN56kGa70ARbR4zRpOIaPjMfzOcxNKjmjjOBEjUj9IuqieHBzucsTQ2Ufbl
         j/cJG8UcFAWT0ccPLvTrcQ+JRuzfbjUnROAi1fSHXUps1hPtrBH4g/BOEyb/j6eWs1SZ
         o4/whbtDd8D/n1f3rQTMdJyVAnskq+mIZqJuQ9BWVDTtlg3hGyH8JthJWhw3tBkp+23J
         Ip6zpFSVcBTbMutLZ9hyoCFhzYjJ77XkxV+TbfD2RlsJmaarnc7RAL+gJdBMhPUsngt0
         crxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733350025; x=1733954825;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PtfbGj6yD8jziLUL93ECE0Ci1aFCtpcn9XBirZhmTWc=;
        b=iJ3aE/AKh/CxaMa8CQn+/DmJZ6eX5JCTd0NgdmoT8jSj4tEYzpNy7DrPYs/JcMX4VT
         88/BCO3KqWpN4exE4mjvttKUTu5Za77bKTxQzFocV9W1sEnFgdgvP9Xz3Ouuu8Go8g2V
         rFTZac9Xk944kXNdFLaQVbo9E3zn4HGKe0g+HWBodFgucObaN30EdT4xmVzqetc4Q1Xl
         nXtEw/3RH0E4KL4vXgZqybITvHwF3RRUw0PAq7U3gJuMQSU3SUtX2GS8dq7qXfnQ0Z1L
         smQ9ykeUlNnH98sToCRKoaGeF7Z7WZeEelOFeyQ8cSlWQTcxu+pOjDuGt4Huvn5IB66B
         AfwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzco+cc1WJ2BPFltSUApoKmcE/oGet7XJxJAdGwPgd6tWoKdTOtdKTQJpUZE9mFg5Gx8Luk3SMRnIWW6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEQk2J6lXquBULnWSsYx91kPbHBtmMOxUCT8Y0dvDHIYXDzYj
	Xrb9c2tbslfD/6q+I4BKeC5G6yICmzrFINftuwgEwvffR+GOS/n0/ciCkRJlwt6OYVSqZPUlcO5
	tTw==
X-Google-Smtp-Source: AGHT+IGPXD2ivV206newVgIjgG0cM79vtCVvTqItdXqiGWrhdXRy+QwdJhqaPWzEJIHaT7cvQqYC9m/CM0M=
X-Received: from pfbcu14.prod.google.com ([2002:a05:6a00:448e:b0:724:e19a:dfd1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:118e:b0:1e0:f059:cd4
 with SMTP id adf61e73a8af0-1e16539f77cmr11618855637.4.1733350025283; Wed, 04
 Dec 2024 14:07:05 -0800 (PST)
Date: Wed, 4 Dec 2024 14:06:58 -0800
In-Reply-To: <CAGdbjm+GmtYEQJsVspFC3_-5nx83qABDroPmyCHPebiKRt-4HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240411140445.1038319-1-szy0127@sjtu.edu.cn> <20240411140445.1038319-3-szy0127@sjtu.edu.cn>
 <Z0-h73xBQgGuAI3H@google.com> <CAGdbjm+GmtYEQJsVspFC3_-5nx83qABDroPmyCHPebiKRt-4HQ@mail.gmail.com>
Message-ID: <Z1DSgmzo3sX0gWY3@google.com>
Subject: Re: [PATCH v4 2/2] KVM: SVM: Flush cache only on CPUs running SEV guest
From: Sean Christopherson <seanjc@google.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Zheyun Shen <szy0127@sjtu.edu.cn>, thomas.lendacky@amd.com, pbonzini@redhat.com, 
	tglx@linutronix.de, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2024, Kevin Loughlin wrote:
> On Tue, Dec 3, 2024 at 4:27=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > > @@ -2152,7 +2191,7 @@ void sev_vm_destroy(struct kvm *kvm)
> > >        * releasing the pages back to the system for use. CLFLUSH will
> > >        * not do this, so issue a WBINVD.
> > >        */
> > > -     wbinvd_on_all_cpus();
> > > +     sev_do_wbinvd(kvm);
> >
> > I am 99% certain this wbinvd_on_all_cpus() can simply be dropped.  sev_=
vm_destroy()
> > is called after KVM's mmu_notifier has been unregistered, which means i=
t's called
> > after kvm_mmu_notifier_release() =3D> kvm_arch_guest_memory_reclaimed()=
.
>=20
> I think we need a bit of rework before dropping it (which I propose we
> do in a separate series), but let me know if there's a mistake in my
> reasoning here...
>=20
> Right now, sev_guest_memory_reclaimed() issues writebacks for SEV and
> SEV-ES guests but does *not* issue writebacks for SEV-SNP guests.
> Thus, I believe it's possible a SEV-SNP guest reaches sev_vm_destroy()
> with dirty encrypted lines in processor caches. Because SME_COHERENT
> doesn't guarantee coherence across CPU-DMA interactions (d45829b351ee
> ("KVM: SVM: Flush when freeing encrypted pages even on SME_COHERENT
> CPUs")), it seems possible that the memory gets re-allocated for DMA,
> written back from an (unencrypted) DMA, and then corrupted when the
> dirty encrypted version gets written back over that, right?
>=20
> And potentially the same thing for why we can't yet drop the writeback
> in sev_flush_encrypted_page() without a bit of rework?

Argh, this last one probably does apply to SNP.  KVM requires SNP VMs to be=
 backed
with guest_memfd, and flushing for that memory is handled by sev_gmem_inval=
idate().
But the VMSA is kernel allocated and so needs to be flushed manually.  On t=
he plus
side, the VMSA flush shouldn't use WB{NO}INVD unless things go sideways, so=
 trying
to optimize that path isn't worth doing.

> It's true that the SNP firmware will require WBINVD before
> SNP_DF_FLUSH [1], but I think we're only currently doing that when an
> ASID is recycled, *not* when an ASID is deactivated.
>=20
> [1] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/=
specifications/56860.pdf

