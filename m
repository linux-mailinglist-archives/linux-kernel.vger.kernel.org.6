Return-Path: <linux-kernel+bounces-323398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B9C973CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6C2B20E15
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC96E19E989;
	Tue, 10 Sep 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rF4sBVsr"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC818DF72
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983826; cv=none; b=W8ftwJLRQ+CPadPYLvJdwPoKdR/7MBvBqmYxJHnDq85HnFYfvk9vgKniSLLS/dhJ/Cbe5qakZs7/ZFpF5HoKXSkKj4z/IkA8OP/rsG9v7Papug/JaQMVWhHw8PA5QePTQ9GzbpC9ueRdC+PUdvpnIXCWNzwI/fusbrNmERVkSSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983826; c=relaxed/simple;
	bh=cW14aL2kByVBLDiSFE3bHdvErdW/UecAKHQcX/CiYRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8Vogmz2Xmdef73Iy8z7OqlTprjP+ZqvFHgo+kQiDp7J+Txh1ne37I+q3ynDPgc7a+2d6vibpskHhDHEwUKerNq9jWlCUj50Oxo2ZZshRnVJeRGJy6t7VxdXf2Bk00sh4PHqi3Ayi99A6Yk57KQCIT4BUgbh3G1Tg5Yq7kgjRoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rF4sBVsr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159159528so15406988276.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725983823; x=1726588623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tzvNQMp3vCXB8Yr+79tCmZju/CJm9McEg1D0ZzYNM4=;
        b=rF4sBVsrycR9OEWlOQhYoz81rkeWhADCG4GbD6Q8kdd5KNwU0CiK5oUBpKfuDnh7kf
         vBm/LFAWi+/Xnc761bApaDAv/izLA03kVvnvMT4ffviTzr8dILs3FCrkqHLoQbAb/6dD
         2v12kZRjTaGDGceDSuLOyLRdSdNco5VQ6v7e1QRCvvb7y8CROwfvStzo8jkxPhzIn1E7
         ytLRFtK8ornBzkYEivuS9wWhx2tyRjyUgVT8IOLxGig3BOlTrnGOx+PhMbEvUVY/FnsY
         uuUIyzSXlSSKQ+2tivQpKX75XJC6emxAKxU7hhMU6oZcKnvIIuc4ROSRCHHivaLFmio3
         NbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725983823; x=1726588623;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7tzvNQMp3vCXB8Yr+79tCmZju/CJm9McEg1D0ZzYNM4=;
        b=tlY6AHr9R1dIdblUzaIGctThkX+Q53p+D0ZPfbxkWvfRqyIszefAgh3TM3zies33EU
         8KT/U0Ewdu22+DL0hcCi144r/g4aA074C0igsch5/cFRVagYMdbpCN2aP9zJ+Fnexg7W
         LQPTFIH82jfNomtxxe9dUTwsek7ILJe9tBqVGOLPlYmT2WYfJvsNJqaixNRLuazHwGZM
         D+AueIkcnfD3jhxWiRLXCQHddWptRsDV4A1nnrNrYNFP9jLS8hGdhN9e+zV6v9l1ZCZo
         yQ7h7o5tB43a062fXpDF4kzFZItkhMOpcAY5ml0+gojXmPwcfQU2FOpyeufRyH8df7M8
         6ivQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtkfbCybg+zj0UHpR9/tzlkyt8EFdoNId56jtfjqdGdhFF9CSA3IGbBKtKQFcv55Vz9NtNS9Zz9gVcuXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiUt8rAtTC7LrqCQ4uwGtLKQoRikTCQG9Rzz5pUu+q9eEXQ+D4
	7l8GJefs0ljN6S2SlnsyEi+twkxYM+dFHryX0WEpmNW/oFVkHlHIUnMB2DSFg49SCFfK6+NPr+4
	4YA==
X-Google-Smtp-Source: AGHT+IH4LocodMSDLJCCpxDd2CcB7y06IMVHPbMZyWXohbePH6HffUlwoCeXp11+A2QcZOcjbMisCFflk+8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:b16:b0:e0b:acc7:b1fd with SMTP id
 3f1490d57ef6-e1d7a09b1a0mr17840276.4.1725983823594; Tue, 10 Sep 2024 08:57:03
 -0700 (PDT)
Date: Tue, 10 Sep 2024 08:57:02 -0700
In-Reply-To: <CABgObfayLGyWKERXkU+0gjeUg=Sp3r7GEQU=+13sUMpo36weWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904030751.117579-1-rick.p.edgecombe@intel.com>
 <20240904030751.117579-10-rick.p.edgecombe@intel.com> <6449047b-2783-46e1-b2a9-2043d192824c@redhat.com>
 <b012360b4d14c0389bcb77fc8e9e5d739c6cc93d.camel@intel.com>
 <Zt9kmVe1nkjVjoEg@google.com> <1bbe3a78-8746-4db9-a96c-9dc5f1190f16@redhat.com>
 <ZuBQYvY6Ib4ZYBgx@google.com> <CABgObfayLGyWKERXkU+0gjeUg=Sp3r7GEQU=+13sUMpo36weWg@mail.gmail.com>
Message-ID: <ZuBsTlbrlD6NHyv1@google.com>
Subject: Re: [PATCH 09/21] KVM: TDX: Retry seamcall when TDX_OPERAND_BUSY with
 operand SEPT
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, Yuan Yao <yuan.yao@intel.com>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	Kai Huang <kai.huang@intel.com>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024, Paolo Bonzini wrote:
> On Tue, Sep 10, 2024 at 3:58=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > On Tue, Sep 10, 2024, Paolo Bonzini wrote:
> > No, because that defeates the purpose of having mmu_lock be a rwlock.
>=20
> But if this part of the TDX module is wrapped in a single big
> try_lock, there's no difference in spinning around busy seamcalls, or
> doing spin_lock(&kvm->arch.seamcall_lock). All of them hit contention
> in the same way.  With respect to FROZEN_SPTE...
>
> > > This way we know that "busy" errors must come from the guest and have=
 set
> > > HOST_PRIORITY.
> >
> > We should be able to achieve that without a VM-wide spinlock.  My thoug=
ht (from
> > v11?) was to effectively use the FROZEN_SPTE bit as a per-SPTE spinlock=
, i.e. keep
> > it set until the SEAMCALL completes.
>=20
> Only if the TDX module returns BUSY per-SPTE (as suggested by 18.1.3,
> which documents that the TDX module returns TDX_OPERAND_BUSY on a
> CMPXCHG failure). If it returns BUSY per-VM, FROZEN_SPTE is not enough
> to prevent contention in the TDX module.

Looking at the TDX module code, things like (UN)BLOCK and REMOVE take a per=
-VM
lock in write mode, but ADD, AUG, and PROMOTE/DEMOTE take the lock in read =
mode.

So for the operations that KVM can do in parallel, the locking should effec=
tively
be per-entry.  Because KVM will never throw away an entire S-EPT root, zapp=
ing
SPTEs will need to be done while holding mmu_lock for write, i.e. KVM shoul=
dn't
have problems with host tasks competing for the TDX module's VM-wide lock.

> If we want to be a bit more optimistic, let's do something more
> sophisticated, like only take the lock after the first busy reply. But
> the spinlock is the easiest way to completely remove host-induced
> TDX_OPERAND_BUSY, and only have to deal with guest-induced ones.

I am not convinced that's necessary or a good idea.  I worry that doing so =
would
just kick the can down the road, and potentially make the problems harder t=
o solve,
e.g. because we'd have to worry about regressing existing setups.

> > > It is still kinda bad that guests can force the VMM to loop, but the =
VMM can
> > > always say enough is enough.  In other words, let's assume that a lim=
it of
> > > 16 is probably appropriate but we can also increase the limit and cra=
sh the
> > > VM if things become ridiculous.
> >
> > 2 :-)
> >
> > One try that guarantees no other host task is accessing the S-EPT entry=
, and a
> > second try after blasting IPI to kick vCPUs to ensure no guest-side tas=
k has
> > locked the S-EPT entry.
>=20
> Fair enough. Though in principle it is possible to race and have the
> vCPU re-run and re-issue a TDG call before KVM re-issues the TDH call.

My limit of '2' is predicated on the lock being a "host priority" lock, i.e=
. that
kicking vCPUs would ensure the lock has been dropped and can't be re-acquir=
ed by
the guest.

> So I would make it 5 or so just to be safe.
>=20
> > My concern with an arbitrary retry loop is that we'll essentially propa=
gate the
> > TDX module issues to the broader kernel.  Each of those SEAMCALLs is sl=
ooow, so
> > retrying even ~20 times could exceed the system's tolerances for schedu=
ling, RCU,
> > etc...
>=20
> How slow are the failed ones? The number of retries is essentially the
> cost of successful seamcall / cost of busy seamcall.

I haven't measured, but would be surprised if it's less than 2000 cycles.

> If HOST_PRIORITY works, even a not-small-but-not-huge number of
> retries would be better than the IPIs. IPIs are not cheap either.

Agreed, but we also need to account for the operations that are conflicting=
.
E.g. if KVM is trying to zap a S-EPT that the guest is accessing, then busy=
 waiting
for the to-be-zapped S-EPT entry to be available doesn't make much sense.

> > > For zero step detection, my reading is that it's TDH.VP.ENTER that fa=
ils;
> > > not any of the MEM seamcalls.  For that one to be resolved, it should=
 be
> > > enough to do take and release the mmu_lock back to back, which ensure=
s that
> > > all pending critical sections have completed (that is,
> > > "write_lock(&kvm->mmu_lock); write_unlock(&kvm->mmu_lock);").  And th=
en
> > > loop.  Adding a vCPU stat for that one is a good idea, too.
> >
> > As above and in my discussion with Rick, I would prefer to kick vCPUs t=
o force
> > forward progress, especially for the zero-step case.  If KVM gets to th=
e point
> > where it has retried TDH.VP.ENTER on the same fault so many times that =
zero-step
> > kicks in, then it's time to kick and wait, not keep retrying blindly.
>=20
> Wait, zero-step detection should _not_ affect TDH.MEM latency. Only
> TDH.VP.ENTER is delayed.

Blocked, not delayed.  Yes, it's TDH.VP.ENTER that "fails", but to get past
TDH.VP.ENTER, KVM needs to resolve the underlying fault, i.e. needs to guar=
antee
forward progress for TDH.MEM (or whatever the operations are called).

Though I wonder, are there any operations guest/host operations that can co=
nflict
if the vCPU is faulting?  Maybe this particular scenario is a complete non-=
issue.

> If it is delayed to the point of failing, we can do write_lock/write_unlo=
ck()
> in the vCPU entry path.

I was thinking that KVM could set a flag (another synthetic error code bit?=
) to
tell the page fault handler that it needs to kick vCPUs.  But as above, it =
might
be unnecessary.

> My issue is that, even if we could make it a bit better by looking at
> the TDX module source code, we don't have enough information to make a
> good choice.  For now we should start with something _easy_, even if
> it may not be the greatest.

I am not opposed to an easy/simple solution, but I am very much opposed to
implementing a retry loop without understanding _exactly_ when and why it's
needed.

