Return-Path: <linux-kernel+bounces-440171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0189EB9AD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A681885C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE60214232;
	Tue, 10 Dec 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0xZUDPg"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77321420B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856827; cv=none; b=kEGptBTgcd/+CifhDLZlVKdsYkqOTdoMi3ZSItqeXYbI7suGChzxvXBcFIRsNCVWT9yyuVQr/sq7d+VASdMp38K5l+hWusGhmJMp0ptdnGpYjFK2RvfKPM1NC1IWH46TY3Yiujqj78q4/qO/vIv7tPnIIdH9SRxplXYmB+hBWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856827; c=relaxed/simple;
	bh=mihFzbzb4/9usHBmDcHcQnIEb4ZUQV9UbcqCAyW9vpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lm4oY8yoBSx9mt/RDspJloOD3fv/koC47Xi9zs6/jdM7W6jvDUTIfbep/XJaV8hvoA650HW5WymFCnVeEzJUDCFIbcQ1x4i1na0EsY3egKyKN4AIGqWcgsh9JzsqSJphJ5rqG6Zz/cCHoLinuSBGvJ+3uZeoXi14wmqkIcMOKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0xZUDPg; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4674a47b7e4so30341cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733856822; x=1734461622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTxg1Tv9B28JSqo18UFTvQ4Yt+t7p72F7E79Abgqc2Y=;
        b=C0xZUDPgcjlsGd1+qrBPDJKK2WvyoeJFq8r3+77inj9j/YTflIxgMWB5qCT7yT4+jc
         2tbea7sZeMfqAM2juRzlY/GYNJHYug4WnBXjE6xeMk0ggGUNBAtuookZDJRhxVp91HRe
         w8rgxVx0+lR1SzlYTv8cW30KACGTmq58pAhF9EsRRMvdfdlH8RUSiZ98bmnspHAoCkAz
         xbZmImKLMFuQn5L6F08c8RfpvufK8o5Wy+rHRCfZOrxfalGc0YiRf6pqGnEvc/IoUS5N
         sauokkkLZ7bMYbi/o8b4ZBQjcs2qcT8pwq2AXk8el2Dyixka0ztQW840N+ZFJnDB98rk
         ElbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733856822; x=1734461622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTxg1Tv9B28JSqo18UFTvQ4Yt+t7p72F7E79Abgqc2Y=;
        b=vktoiwd4ZVzBHWlacZAcXrr68EzVFniGrXp6zcKH4/qNgNDnWchu8tPPPUFgWGqXXa
         30T/fIGS/YC1foat9Ahs4Vaz1+I2gwrSrKGT0Wu+rrPvzy904nsMP9AvuzifeJ7r/wmF
         rI5FxMmma2fccewoULVbA87tpVcLNuqcrumt9G2ALRSjY4165L2PCKqH88HC5pQHXD9h
         LCv8+FiSl7G5PC+2AaTRc6+CZWbSSVJKXIXtT/VR1NGV9Qfx67bF8Tzj+SOAWOMdTThw
         HZILD+unEreWaM0Qmi9aLV66cmDNF6xOnsg2GGL2J94HTQMslLk8Q9p9d7rp3a4s8c/Q
         u2sA==
X-Forwarded-Encrypted: i=1; AJvYcCWCvXjTjK3V6YYg8masWAXfHtH/XO7W7LP/qVkRQNxD0YYPdBk7e+lkzcBfMs1BztDfTsYwdVQQalN5x40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwosKMEuWtxqtR2dniYNW711pZcuZJw+yVqqnwcgxyt3KSd7yER
	OwRiemMMJXxG5wAbQCrcck592NPHLPzW0Ggrjr1cfNWSxbatBmT2FARGYxEgVVpOwBe4yRabTZ4
	JQoE1WrNxh72ggx8VlAVEDmF4CjqU+ljxS4SZ
X-Gm-Gg: ASbGncs/2YPiTFjKonQ8grC6Yvjka+j0+CYy5qqjW9tGkxQFFrkANFln6N4LbeVp5xa
	zS7ZgkMf5vBiNQa6MI0BSy7ySVypSDO3M+q/K411sou4us83tvFE5ffEoIoeiaIb6GQ==
X-Google-Smtp-Source: AGHT+IGGTh7Wd7c9V0Hn51P0NeOMcT2HJORM6+yXkwY1q0Jtracb0QUR4je6F0teZ8jcQ/XBsI0mY88C2MXRP4HxjV8=
X-Received: by 2002:a05:622a:418c:b0:467:82de:d949 with SMTP id
 d75a77b69052e-46788c9c18dmr204051cf.12.1733856822128; Tue, 10 Dec 2024
 10:53:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206225204.4008261-1-surenb@google.com> <20241206225204.4008261-5-surenb@google.com>
 <6b29b2a5-c244-4930-a5a0-1a24a04e7e35@suse.cz> <CAJuCfpFxAZ-JwN8VqNF14zeBnsPM_pD0+-N2PDq5GcQGR1xqLQ@mail.gmail.com>
 <643beb6c-4226-46ca-b7e9-292467479aea@suse.cz> <CAJuCfpHR3LXfAZA_oh_2KBtFe6JQPU5T3nYMZd_ooAjRJd8xUQ@mail.gmail.com>
 <5036d089-0774-4863-88c5-eaaea1265ac7@suse.cz>
In-Reply-To: <5036d089-0774-4863-88c5-eaaea1265ac7@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 10 Dec 2024 10:53:30 -0800
Message-ID: <CAJuCfpGj4vAs7_0h92CNHhAC4rpkrW5e5sakyZGtB2=TJr9Khg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 9:25=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 12/10/24 18:16, Suren Baghdasaryan wrote:
> > On Tue, Dec 10, 2024 at 8:32=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 12/10/24 17:20, Suren Baghdasaryan wrote:
> >> > On Tue, Dec 10, 2024 at 6:21=E2=80=AFAM Vlastimil Babka <vbabka@suse=
.cz> wrote:
> >> >>
> >> >> On 12/6/24 23:52, Suren Baghdasaryan wrote:
> >> >> > To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure th=
at
> >> >> > object reuse before RCU grace period is over will be detected ins=
ide
> >> >> > lock_vma_under_rcu().
> >> >> > lock_vma_under_rcu() enters RCU read section, finds the vma at th=
e
> >> >> > given address, locks the vma and checks if it got detached or rem=
apped
> >> >> > to cover a different address range. These last checks are there
> >> >> > to ensure that the vma was not modified after we found it but bef=
ore
> >> >> > locking it.
> >> >> > vma reuse introduces several new possibilities:
> >> >> > 1. vma can be reused after it was found but before it is locked;
> >> >> > 2. vma can be reused and reinitialized (including changing its vm=
_mm)
> >> >> > while being locked in vma_start_read();
> >> >> > 3. vma can be reused and reinitialized after it was found but bef=
ore
> >> >> > it is locked, then attached at a new address or to a new mm while
> >> >> > read-locked;
> >> >> > For case #1 current checks will help detecting cases when:
> >> >> > - vma was reused but not yet added into the tree (detached check)
> >> >> > - vma was reused at a different address range (address check);
> >> >> > We are missing the check for vm_mm to ensure the reused vma was n=
ot
> >> >> > attached to a different mm. This patch adds the missing check.
> >> >> > For case #2, we pass mm to vma_start_read() to prevent access to
> >> >> > unstable vma->vm_mm. This might lead to vma_start_read() returnin=
g
> >> >> > a false locked result but that's not critical if it's rare becaus=
e
> >> >> > it will only lead to a retry under mmap_lock.
> >> >> > For case #3, we ensure the order in which vma->detached flag and
> >> >> > vm_start/vm_end/vm_mm are set and checked. vma gets attached afte=
r
> >> >> > vm_start/vm_end/vm_mm were set and lock_vma_under_rcu() should ch=
eck
> >> >> > vma->detached before checking vm_start/vm_end/vm_mm. This is requ=
ired
> >> >> > because attaching vma happens without vma write-lock, as opposed =
to
> >> >> > vma detaching, which requires vma write-lock. This patch adds mem=
ory
> >> >> > barriers inside is_vma_detached() and vma_mark_attached() needed =
to
> >> >> > order reads and writes to vma->detached vs vm_start/vm_end/vm_mm.
> >> >> > After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_area_=
cachep.
> >> >> > This will facilitate vm_area_struct reuse and will minimize the n=
umber
> >> >> > of call_rcu() calls.
> >> >> >
> >> >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >> >>
> >> >> I'm wondering about the vma freeing path. Consider vma_complete():
> >> >>
> >> >> vma_mark_detached(vp->remove);
> >> >>   vma->detached =3D true; - plain write
> >> >> vm_area_free(vp->remove);
> >> >>   vma->vm_lock_seq =3D UINT_MAX; - plain write
> >> >>   kmem_cache_free(vm_area_cachep)
> >> >> ...
> >> >> potential reallocation
> >> >>
> >> >> against:
> >> >>
> >> >> lock_vma_under_rcu()
> >> >> - mas_walk finds a stale vma due to race
> >> >> vma_start_read()
> >> >>   if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(mm->mm_lock_seq.=
sequence))
> >> >>   - can be false, the vma was not being locked on the freeing side?
> >> >>   down_read_trylock(&vma->vm_lock.lock) - suceeds, wasn't locked
> >> >>     this is acquire, but was there any release?
> >> >
> >> > Yes, there was a release. I think what you missed is that
> >> > vma_mark_detached() that is called from vma_complete() requires VMA =
to
> >> > be write-locked (see vma_assert_write_locked() in
> >> > vma_mark_detached()). The rule is that a VMA can be attached without
> >> > write-locking but only a write-locked VMA can be detached. So, after
> >>
> >> OK but write unlocking means the mm's seqcount is bumped and becomes
> >> non-equal with vma's vma->vm_lock_seq, right?
> >>
> >> Yet in the example above we happily set it to UINT_MAX and thus effect=
ively
> >> false unlock it for vma_start_read()?
> >>
> >> And this is all done before the vma_complete() side would actually rea=
ch
> >> mmap_write_unlock(), AFAICS.
> >
> > Ah, you are right. With the possibility of reuse, even a freed VMA
> > should be kept write-locked until it is unlocked by
> > mmap_write_unlock(). I think the fix for this is simply to not reset
> > vma->vm_lock_seq inside vm_area_free(). I'll also need to add a
>
> But even if we don't reset vm_lock_seq to UINT_MAX, then whover reallocat=
ed
> it can proceed and end up doing a vma_start_write() and rewrite it there
> anyway, no?

Ugh, yes. It looks like we will need a write memory barrier in
vma_mark_detached() to make it immediately visible.

Case 1:
                                      lock_vma_under_rcu()
vma_complete()
    vma_mark_detached(vp->remove);
        vma->detached =3D true;
        smp_wmb();
    vm_area_free(vp->remove);
        vma->vm_lock_seq =3D UINT_MAX;

                                       vma_start_read()
                                          is_vma_detached() <<- abort

       kmem_cache_free(vm_area_cachep);
mmap_write_unlock()


Case 2:
                                      lock_vma_under_rcu()
vma_complete()
    vma_mark_detached(vp->remove);
        vma->detached =3D true;
        smp_wmb();
    vm_area_free(vp->remove);
        vma->vm_lock_seq =3D UINT_MAX;

                                       vma_start_read()

        kmem_cache_free(vm_area_cachep);
mmap_write_unlock() // changes mm->mm_lock_seq but does not matter
                    // reader holds vma->vm_lock, so new writers have to wa=
it
    ...
    vm_area_alloc();
    // sets all vma attributes
    vma_mark_attached();
        smp_wmb();

                                           // if is_vma_detached() called
                                           //  before this point, we will
                                           // abort like in Case 1

        vma->detached =3D true;
                                           is_vma_detached()
                                           // check vm_mm, vm_start, vm_end
                                           // if all checks pass, this is a
                                           // new attached vma and it's
                                           // read-locked (can't be modifie=
d)

Did I miss any other race?

>
> > comment for vm_lock_seq explaining these requirements.
> > Do you agree that such a change would resolve the issue?
> >
> >>
> >> > vma_mark_detached() and before down_read_trylock(&vma->vm_lock.lock)
> >> > in vma_start_read() the VMA write-lock should have been released by
> >> > mmap_write_unlock() and therefore vma->detached=3Dfalse should be
> >> > visible to the reader when it executed lock_vma_under_rcu().
> >> >
> >> >>   is_vma_detached() - false negative as the write above didn't prop=
agate
> >> >>     here yet; a read barrier but where is the write barrier?
> >> >>   checks for vma->vm_mm, vm_start, vm_end - nobody reset them yet s=
o false
> >> >>     positive, or they got reset on reallocation but writes didn't p=
ropagate
> >> >>
> >> >> Am I missing something that would prevent lock_vma_under_rcu() fals=
ely
> >> >> succeeding here?
> >> >>
> >>
>

