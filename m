Return-Path: <linux-kernel+bounces-325268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C5A975734
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4FAEB28FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D781AB6C7;
	Wed, 11 Sep 2024 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQjY4j4j"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8F1E498
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068837; cv=none; b=LqhQmn8qkKCenSE/KJrhwXQnGpX2sv59RokKnQM2xVJ8yPIA7pImKtuwjsJZEq9QISlhvf0jLp+ln5qe5IhD0jNw9zsYkJWmBTQHx3R4ZfirgM3niir5LTIXWtAH3OZG4iY7sJe9JivsCgDpSBJo3D+pA8z7knJOdkGZXOu1G+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068837; c=relaxed/simple;
	bh=ayl5RujrcIoIbZiylngRNpI68XJsjFCab88H7hrJBBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g7fSBOrNib6dR68LqViJYUj5H3OyVMcjoEw4/GDt5Th+TfmFSSfhHrZdkurUxrGyVEL0BC1Rbjuaed8itovn7k72iv8Ze71QK232T+vtTnxRtY9d/B75cYJJgtRBKYAZQe0w4lnh+IkdwqDIHJl1ryvNPsmUOqKH71Gx8on7ZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQjY4j4j; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d8b7c662ccso2486063a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726068835; x=1726673635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9PjfZ/H+0hBJSkcWiHIbXsU+9SAnJ63aVgh3FD7FYE=;
        b=iQjY4j4jMyoOLMPmtn08rcp/s496Iv7oU5cie4QKYH8RB8aR7r38vq/aGVO30uaedR
         5NJ9qNEVZEEeS2KI5j7JCdteJ514vcv8KByEp8ji60WtCa47qrn8RmV9luBFrc+DGS2M
         ctlMDXt4G+VbJE6qeRS5kNnkYWc1nENZq/61mtIkPcdKBxw7RgdTPeugevZlRs/VnOfW
         +dFcKum7zl6+lq2bCsbVJHM+yt0xe308otlCDCrt9Dx0+JcBRoZD06WKKggxxIxdAMHg
         /IVRz6TbkDJ1lBuSQvAykfLNj84XVroMmrhfeF/V80BxdUWqrIvL4R5WTyJfwSuGci6F
         UoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726068835; x=1726673635;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n9PjfZ/H+0hBJSkcWiHIbXsU+9SAnJ63aVgh3FD7FYE=;
        b=GzmYsbgkFrGzHCu+zoFjSQl8JzHAOv/hESoR8Ma52MMZA6rTDOTX6+/etxNWaL1Vkg
         cWNUTwTWhhn4py2yq+sm96L6oQtfguc6ePoolEPfxWvIzr6IDVEhPSlJa9F+Vo7frhmM
         xzMgwE7xS93+LyVu9oFil1aFYHkRDLP6kuoTua/fOGLBejW4ocSzYSGgxQ+mXmIcUr5G
         FqO5WvolqobUpEpC+jgRrokHRj5seVDjW+XpPfv6CxbrEA4QNUBnA7wtXUWA8d4/5Mja
         EW980ZAgIlB2Y1/yBooF/M1JdYc+1vTvYeS7DUjCGwl2KCBy7aIH8j/ihD4xpchjG5LP
         uIFg==
X-Forwarded-Encrypted: i=1; AJvYcCXB+DcosyktEh6RJbYtalqWzKeswK50p7VCtlu/JwA7Dzo8SnAuVigJ/tzL0Ix4O5aQTjPsbaQ2A8GvC7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Cb7vli5pRSptBLsTFw55ndEnOKam9EJvSNWnu/B283M4BqfR
	LxWgbycG3WEbBgiDofpaG7MbhSCre7Acxgn+pOQy2TJG/v9zEUDJB+1cK/+elV3lQ2JJ72NoVtm
	YPg==
X-Google-Smtp-Source: AGHT+IFpZ9ndY7Ts97EEPr2ASMuCzC5PgXkvhoZjCrqJDmQXEhIoN17GXMOiW9kwAQyxWgil0J2fQ/kYSDY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e50:b0:2d2:453:1501 with SMTP id
 98e67ed59e1d1-2db82e64986mr19872a91.2.1726068835051; Wed, 11 Sep 2024
 08:33:55 -0700 (PDT)
Date: Wed, 11 Sep 2024 08:33:53 -0700
In-Reply-To: <CADrL8HV1Erpg-D4LzuRHUk7dg6mvex8oQz5pBzwO7A3OjB8Uvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com> <20240809194335.1726916-20-seanjc@google.com>
 <CADrL8HWACwbzraG=MbDoORJ8ramDxb-h9yb0p4nx9-wq4o3c6A@mail.gmail.com>
 <Zt9UT74XkezVpTuK@google.com> <CADrL8HW-mOAyF0Gcw7UbkvEvEfcHDxEir0AiStkqYzD5x8ZGpg@mail.gmail.com>
 <Zt9wg6h_bPp8BKtd@google.com> <CADrL8HWbNjv-w-ZJOxkLK78S5RePd2QXDuXV-=4iFVV29uHKyg@mail.gmail.com>
 <Zt-kHjtTVrONMU1V@google.com> <CADrL8HV1Erpg-D4LzuRHUk7dg6mvex8oQz5pBzwO7A3OjB8Uvw@mail.gmail.com>
Message-ID: <ZuG4YYzozOddPRCm@google.com>
Subject: Re: [PATCH 19/22] KVM: x86/mmu: Add infrastructure to allow walking
 rmaps outside of mmu_lock
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024, James Houghton wrote:
> On Mon, Sep 9, 2024 at 6:42=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Mon, Sep 09, 2024, James Houghton wrote:
> > > I take back what I said about this working on x86. I think it's
> > > possible for there to be a race.
> > >
> > > Say...
> > >
> > > 1. T1 modifies pte_list_desc then unlocks kvm_rmap_unlock().
> > > 2. T2 then locks kvm_rmap_lock_readonly().
> > >
> > > The modifications that T1 has made are not guaranteed to be visible t=
o
> > > T2 unless T1 has an smp_wmb() (or equivalent) after the modfication
> > > and T2 has an smp_rmb() before reading the data.
> > >
> > > Now the way you had it, T2, because it uses try_cmpxchg() with full
> > > ordering, will effectively do a smp_rmb(). But T1 only does an
> > > smp_wmb() *after dropping the mmu_lock*, so there is a race. While T1
> > > still holds the mmu_lock but after releasing the kvm_rmap_lock(), T2
> > > may enter its critical section and then *later* observe the changes
> > > that T1 made.
> > >
> > > Now this is impossible on x86 (IIUC) if, in the compiled list of
> > > instructions, T1's writes occur in the same order that we have writte=
n
> > > them in C. I'm not sure if WRITE_ONCE guarantees that this reordering
> > > at compile time is forbidden.
> > >
> > > So what I'm saying is:
> > >
> > > 1. kvm_rmap_unlock() must have an smp_wmb().
> >
> > No, because beating a dead horse, this is not generic code, this is x86=
.
>=20
> What prevents the compiler from reordering (non-atomic, non-volatile)
> stores that happen before WRITE_ONCE() in kvm_rmap_unlock() to after
> the WRITE_ONCE()?

Oof, right, nothing.  Which is why __smp_store_release() has an explicit
barrier() before its WRITE_ONCE().

> IMV, such a reordering is currently permitted[1] (i.e., a barrier() is
> missing), and should the compiler choose to do this, the lock will not
> function correctly.
>=20
> > If kvm_rmap_head.val were an int, i.e. could be unionized with an atomi=
c_t, then
> > I wouldn't be opposed to doing this in the locking code to document thi=
ngs:
> >
> >  s/READ_ONCE/atomic_read_acquire
> >  s/WRITE_ONCE/atomic_set_release
> >  s/try_cmpxchg/atomic_cmpxchg_acquire
>=20
> I think we can use atomic_long_t.

Duh.  That's a /facepalm moment.

> It would be really great if we did a substitution like this. That
> would address my above concern about barrier() (atomic_set_release,
> for example, implies a barrier() that we otherwise need to include).

Ya, agreed, not just for warm fuzzies, but because it's necessary to preven=
t
the compiler from being clever.

