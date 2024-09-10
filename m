Return-Path: <linux-kernel+bounces-323632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA479740E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E6B28587F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869D1A42A4;
	Tue, 10 Sep 2024 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irA5/AfL"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086E019D8A4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990144; cv=none; b=mZcO1r+Z+kITFLjsaOS2bSDGZ3EsndDjg0xoqNCqU7KxxEBHHRUfftOMjKCvr3VNQeDkmCW5OPIYgNtzLhpglgLdyOnchxmzHU9a/d0EJ4cs6eQxBQLxEMhxtI50bVN0+4/XkwG2ZFJa6xN294Gg3U8StZVjwWth2vnZGFfuKSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990144; c=relaxed/simple;
	bh=u25THlA+Z7bzJGAEhSU19gr82UmAL417zQhjoh7buU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PaNVPH5ZlvGyknA0FkZPAQb5ar2zRQ/r60SCajMkux+aahMNioYye2UL6bD3oc+nqLK3KucNy//xc6vIo+8Vl4k5lJeTuUc5RwStRyFLWUK6RXluBdbmS/u0kuxWNPaKbjJhm76VmA/Wop/qhkM6Yyg3gdd2+qoKlYkKT9WEo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irA5/AfL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7174c6cbdbaso7579968b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725990142; x=1726594942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gg6skOg0GP1/0D73Nu093tI0yLfhQmox3hveal8dqPA=;
        b=irA5/AfLBypu8MgsAKfmqwHlY+Othsn7MZE2kKqwSUlQNzTOJwtl0biaMgL5yaJo7K
         JVg0bCxikMSQ+ik5VFazU4uyEFkWr5cyYgO4Mi4xjcSqncHWdzRnbDSGo0OHEwzItKNG
         n3SfVsbSu/hHpdQSNswXEWSeT1wpx6BFYh9d40FbHAHQbD/7YPsJ5nfbpNgMd32bsBmg
         OtoYnWauRMBBYgfHGTKZalbwhxXnF/kUqkL+/qw8YdwYN/4f700e3KkdqYcl4TZJi361
         HCY6TfuAKUqVHFSMaoBLsLfaWWsWnEcT5/Wr/3NS2ToIMkm6eEcJChezGLQFbU/kZ7Fi
         v9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990142; x=1726594942;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gg6skOg0GP1/0D73Nu093tI0yLfhQmox3hveal8dqPA=;
        b=ka4/CHbjAn5EGEMiSMRRTTevjSzHTu0zqk0KyiUo8UahzKSzOQy4WTtJtcpk5fip7V
         o/4k8DXHkXG9a4P0WtQhAgiVH7Lz5wDyyNZhDDDqiopjv+YPgrow+8VhpZ7YQbmt/sEn
         wsuQQnrfglCit7DYIv9FssECD92hZBcKPbAwb/w0TgqPQdybu6ylGe2lLNIBp7gv+u0G
         wyFMt1/a+6ppstYsrwC+b2zjJQCZJ5UY6qXJCn1z3HdmlalYIzf2QKX2EAdhHJbNYQqZ
         9YaZhWH4XbzbjycYXPRfndumHHnsvAQ2D5umi+RJf/vw+zOHS1f/afvJ44Ki5FiahdAX
         PtGA==
X-Forwarded-Encrypted: i=1; AJvYcCWTrC49D67afuwIV9QGhVyUAZc5Zd7tYi7EamTQUsrwnvRnGNHSJtck0bIICRy6NbeYN1Rc1+Y0r/kZEzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3m7wJnZHpuTnYAYDJTovM1xdakucgfAxBsFwPyG0q4bebjJSv
	EoJC2bDfwvju0PyXCvek04w4qnyGhhUURgW3xaUdXmrtejPhr2mU28KCGgBXaydjCwj7YgWLB66
	gdA==
X-Google-Smtp-Source: AGHT+IE8OvwIv/WWjiojX1BJ9/jZfPx7CjqCmsLFPOIiZ8H3mbzDo/1m95EORYptPvhzt4+2cVR8hRJXts0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9182:0:b0:710:4d6c:a504 with SMTP id
 d2e1a72fcca58-718d5f45b47mr57116b3a.4.1725990142098; Tue, 10 Sep 2024
 10:42:22 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:42:20 -0700
In-Reply-To: <655170f6a09ad892200cd033efe5498a26504fec.camel@intel.com>
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
 <ZuBsTlbrlD6NHyv1@google.com> <655170f6a09ad892200cd033efe5498a26504fec.camel@intel.com>
Message-ID: <ZuCE_KtmXNi0qePb@google.com>
Subject: Re: [PATCH 09/21] KVM: TDX: Retry seamcall when TDX_OPERAND_BUSY with
 operand SEPT
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Yuan Yao <yuan.yao@intel.com>, 
	Kai Huang <kai.huang@intel.com>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dmatlack@google.com" <dmatlack@google.com>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024, Rick P Edgecombe wrote:
> On Tue, 2024-09-10 at 08:57 -0700, Sean Christopherson wrote:
> > > Only if the TDX module returns BUSY per-SPTE (as suggested by 18.1.3,
> > > which documents that the TDX module returns TDX_OPERAND_BUSY on a
> > > CMPXCHG failure). If it returns BUSY per-VM, FROZEN_SPTE is not enoug=
h
> > > to prevent contention in the TDX module.
> >=20
> > Looking at the TDX module code, things like (UN)BLOCK and REMOVE take a=
 per-VM
> > lock in write mode, but ADD, AUG, and PROMOTE/DEMOTE take the lock in r=
ead
> > mode.
>=20
> AUG does take other locks as exclusive:
> https://github.com/intel/tdx-module/blob/tdx_1.5/src/vmm_dispatcher/api_c=
alls/tdh_mem_page_aug.c

Only a lock on the underlying physical page.  guest_memfd should prevent ma=
pping
the same HPA into multiple GPAs, and FROZEN_SPTE should prevent two vCPUs f=
rom
concurrently AUGing the same GPA+HPA.

> I count 5 locks in total as well. I think trying to mirror the locking in=
 KVM
> will be an uphill battle.

I don't want to mirror the locking, I want to understand and document the
expectations and rules.  "Throw 16 noodles and hope one sticks" is not a re=
cipe
for success.

> > So for the operations that KVM can do in parallel, the locking should
> > effectively
> > be per-entry.=C2=A0 Because KVM will never throw away an entire S-EPT r=
oot, zapping
> > SPTEs will need to be done while holding mmu_lock for write, i.e. KVM
> > shouldn't
> > have problems with host tasks competing for the TDX module's VM-wide lo=
ck.
> >=20
> > > If we want to be a bit more optimistic, let's do something more
> > > sophisticated, like only take the lock after the first busy reply. Bu=
t
> > > the spinlock is the easiest way to completely remove host-induced
> > > TDX_OPERAND_BUSY, and only have to deal with guest-induced ones.
> >=20
> > I am not convinced that's necessary or a good idea.=C2=A0 I worry that =
doing so
> > would
> > just kick the can down the road, and potentially make the problems hard=
er to
> > solve,
> > e.g. because we'd have to worry about regressing existing setups.
> >=20
> > > > > It is still kinda bad that guests can force the VMM to loop, but =
the VMM
> > > > > can
> > > > > always say enough is enough.=C2=A0 In other words, let's assume t=
hat a limit
> > > > > of
> > > > > 16 is probably appropriate but we can also increase the limit and=
 crash
> > > > > the
> > > > > VM if things become ridiculous.
> > > >=20
> > > > 2 :-)
> > > >=20
> > > > One try that guarantees no other host task is accessing the S-EPT e=
ntry,
> > > > and a
> > > > second try after blasting IPI to kick vCPUs to ensure no guest-side=
 task
> > > > has
> > > > locked the S-EPT entry.
> > >=20
> > > Fair enough. Though in principle it is possible to race and have the
> > > vCPU re-run and re-issue a TDG call before KVM re-issues the TDH call=
.
> >=20
> > My limit of '2' is predicated on the lock being a "host priority" lock,
> > i.e.  that kicking vCPUs would ensure the lock has been dropped and can=
't
> > be re-acquired by the guest.
>=20
> So kicking would be to try to break loose any deadlock we encountered? It=
 sounds
> like the kind of kludge that could be hard to remove.

No, the intent of the kick would be to wait for vCPUs to exit, which in tur=
n
guarantees that any locks held by vCPUs have been dropped.  Again, this ide=
a is
predicated on the lock being "host priority", i.e. that vCPUs can't re-take=
 the
lock before KVM.

