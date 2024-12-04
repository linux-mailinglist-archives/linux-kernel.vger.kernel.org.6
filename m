Return-Path: <linux-kernel+bounces-432075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A619E44A8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21FB165846
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9497C1F03CF;
	Wed,  4 Dec 2024 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSMoJViR"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF11F03C8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340829; cv=none; b=EciCjtf+CQNwU8l6Z0nty/jHAeOtDGMLkLdZXv48ILLv0yJr4eL8fYukTHnThlt6GqMjGeNowTU91I83d34yVmFp0ffRqp/DVjGi4jOLn/b2YlP7ZLVGOp98RB8FPssqLwwabyFs6p7XrIC0Dr0KMhkLHUCdnFVzyhB9bWry6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340829; c=relaxed/simple;
	bh=9F3e/w8zRQBkz1K1ukTQGcopLkMd+RbSVvAztJlrQLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFe42e/7VbRJ6c8SX8chimx7Xm///TF/FinvgCHsC6wH+O/G/H5JBUW2D+SxYZaKkzHWzfFsnAVt6x11v0prEYXtRfvpusqfU6kVZycc6tWPfsSS9UH7PxIBsVXuspx9u5D3QCkO3iXSHVhjxC/VJhyW7juFCbO0jOAjO+T1V4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSMoJViR; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-515c79715bbso55741e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733340827; x=1733945627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqZPIVY/3iDa1HNFBFi4GDdk6giQ2wdWgZ2ZEsXKX8U=;
        b=PSMoJViRcw5UBflHTkjmQH3FU7zg/HlbYOTh3Fp2lpmNyW8cNCP42IRJdqg4A4mmdj
         gbZSabGiIAhMe75VzbEXfcyaFEDQsfHMgQ2IOKKa9WUie4pJWsoaH53fH6I/XUTqWwpU
         G1Go5d/DPStWV0R4/cBumj8TNqJbdcxSx6Gey301UdpB8j+05lQQ+b61nWPf+p22g6wO
         LSsPcGUTuRZRrUSrz/U2Q+jkUMkAk87UVDBxHaIy9cYrAK51QbNqrSiMNWqoA1WtE39U
         dyeeYdLt5JOfiDjcF2vSHu5ach3ek4DPD1DK98f0x+j2YsC2Q+LFZbL7XGi0kWQdCXpc
         /Oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733340827; x=1733945627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqZPIVY/3iDa1HNFBFi4GDdk6giQ2wdWgZ2ZEsXKX8U=;
        b=PhzQzhqmSg41HxNEVurr4AMOGZ5YEpvWWuadYPx5ItihQ8YsTHcMCehZKKS8bG00aJ
         A0+AXbhq8bZ5nPiJr5ncz9CMuPCBLG+mRdES5YqTOmX3MH4oTw8TI9OdZI1Qj8lAgzuJ
         Ea9rp5lsivXUjpLZ1/7N5fKLhYs/wKRZbqXlrQ2t/3DOFPNaN/HzzaOMmWT7Nc1s66Fm
         Fr0A69cCuTIVJF9Cl2ApDq/zaOXHHMahpfJ4nZh9GXuvfjLfr2wdvNd7PJprXIBKQVE0
         HwSDYOERqHuQsO7FWb6XSbCBd8+9PV9yg2iN+2V/GH3R16XUpw8GYSvEsFRe/FEu4SMv
         ZPjA==
X-Forwarded-Encrypted: i=1; AJvYcCV0rUimBg0iUV/WRSOVBDNjkcEPcE0GmT5g7a4cK0oyuqsmRdhQbnTgWZEh/XfwgWuGE9RfsnSfbAEwyiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Uw1vc5SnzDsy8wculPQsVV6OjkL+s0hqtlT7TKpLpfAIt/0U
	91b4sCChuISwp+xzzoVTc5wI/0DumdVCq9NehzAJLkG4GputQ9iDRRyd4yYb5o1DFli9E3dnt3U
	oblTH99Hdv3LWsTzOQMjbI5VF/wL6/DY4zJv4
X-Gm-Gg: ASbGncti5VaDko7RaJ0eHaq0WYXJwrUCc50IQT5+TyuIELdkU5Vj3/nkUDDp3hukgNw
	JdHB5wRwLQdBJ3YVnQ2EpwwKuDrSxKvV8efNCYi4UksrofSeUFzl4oJsOx9unHQ==
X-Google-Smtp-Source: AGHT+IEAlkvT4fN36KOseH6y1570s9BaJPOuriRpbufCEy/BVd0+5kp/KA7mkyh33aXPapzDTnVXl4rVI1BiIngTFes=
X-Received: by 2002:a05:6122:906:b0:50d:35d9:ad60 with SMTP id
 71dfb90a1353d-515bf3053e3mr11851091e0c.5.1733340826846; Wed, 04 Dec 2024
 11:33:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411140445.1038319-1-szy0127@sjtu.edu.cn> <20240411140445.1038319-3-szy0127@sjtu.edu.cn>
 <Z0-h73xBQgGuAI3H@google.com>
In-Reply-To: <Z0-h73xBQgGuAI3H@google.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Wed, 4 Dec 2024 11:33:35 -0800
Message-ID: <CAGdbjm+GmtYEQJsVspFC3_-5nx83qABDroPmyCHPebiKRt-4HQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] KVM: SVM: Flush cache only on CPUs running SEV guest
To: Sean Christopherson <seanjc@google.com>
Cc: Zheyun Shen <szy0127@sjtu.edu.cn>, thomas.lendacky@amd.com, pbonzini@redhat.com, 
	tglx@linutronix.de, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 4:27=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Apr 11, 2024, Zheyun Shen wrote:
> >
> > +      * that are running a SEV guest and be used in memory reclamation=
.
> > +      *
> > +      * Migrating vCPUs between pCPUs is tricky. We cannot clear
> > +      * this mask each time reclamation finishes and record it again
> > +      * before VMRUN, because we cannot guarantee the pCPU will exit
> > +      * to VMM before the next reclamation happens.
>
> Migration is easy enough to solve (I think; famous last words).  KVM is a=
lready
> forcing an exit to service the IPI, just set the associated pCPU's bit if=
 it has
> a running vCPU loaded.
>
> However, to play nice with multiple flushers, we'd need something like
> kvm_recalculate_apic_map() to ensure subsequent flushers wait for previou=
s
> flushers to finish before reading the cpumask.  Maybe a simple mutex woul=
d
> suffice?  Contention should be extremely rare for well-behaved setups.
>
> Kevin, since I believe your use case cares about vCPU migration, is this
> something you'd be interesting in tackling?  It can go on top, i.e. I don=
't think
> this base series needs to be held up for fancier migration handling, it's=
 a clear
> improvement over blasting WBINVD to all CPUs.

I'm happy to take a look. I agree with your initial assessment of what
needs to be done. I also agree that we don't need to hold up this
series for it, nor should we hold up [0] ("KVM: SEV: Prefer WBNOINVD
over WBINVD for cache maintenance efficiency") (assuming that patch
series checks out, of course).

[0] https://lore.kernel.org/lkml/20241203005921.1119116-1-kevinloughlin@goo=
gle.com/

> > @@ -2048,7 +2087,7 @@ int sev_mem_enc_unregister_region(struct kvm *kvm=
,
> >        * releasing the pages back to the system for use. CLFLUSH will
> >        * not do this, so issue a WBINVD.
> >        */
> > -     wbinvd_on_all_cpus();
> > +     sev_do_wbinvd(kvm);
>
> Hmm, I am not convinced that optimizing sev_mem_enc_unregister_region() i=
s worth
> doing.  Nothing here prevents a vCPU from racing with unregistering the r=
egion.
> That said, this path isn't exactly safe as it is, because KVM essentially=
 relies
> on userspace to do the right thing.  And userspace can only corrupt itsel=
f,
> because the memory hasn't actually been freed, just unpinned.  If userspa=
ce hasn't
> ensured the guest can't access the memory, it's already hosed, so I suppo=
sed we
> might as well, because why not.

Yeah, I see your point but likewise vote for "might as well" for now.
There's some additional (arguably orthogonal) cleanup in general that
could be done that I believe is best handled in a separate series
(discussed below).

> > @@ -2152,7 +2191,7 @@ void sev_vm_destroy(struct kvm *kvm)
> >        * releasing the pages back to the system for use. CLFLUSH will
> >        * not do this, so issue a WBINVD.
> >        */
> > -     wbinvd_on_all_cpus();
> > +     sev_do_wbinvd(kvm);
>
> I am 99% certain this wbinvd_on_all_cpus() can simply be dropped.  sev_vm=
_destroy()
> is called after KVM's mmu_notifier has been unregistered, which means it'=
s called
> after kvm_mmu_notifier_release() =3D> kvm_arch_guest_memory_reclaimed().

I think we need a bit of rework before dropping it (which I propose we
do in a separate series), but let me know if there's a mistake in my
reasoning here...

Right now, sev_guest_memory_reclaimed() issues writebacks for SEV and
SEV-ES guests but does *not* issue writebacks for SEV-SNP guests.
Thus, I believe it's possible a SEV-SNP guest reaches sev_vm_destroy()
with dirty encrypted lines in processor caches. Because SME_COHERENT
doesn't guarantee coherence across CPU-DMA interactions (d45829b351ee
("KVM: SVM: Flush when freeing encrypted pages even on SME_COHERENT
CPUs")), it seems possible that the memory gets re-allocated for DMA,
written back from an (unencrypted) DMA, and then corrupted when the
dirty encrypted version gets written back over that, right?

And potentially the same thing for why we can't yet drop the writeback
in sev_flush_encrypted_page() without a bit of rework?

It's true that the SNP firmware will require WBINVD before
SNP_DF_FLUSH [1], but I think we're only currently doing that when an
ASID is recycled, *not* when an ASID is deactivated.

[1] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/sp=
ecifications/56860.pdf

