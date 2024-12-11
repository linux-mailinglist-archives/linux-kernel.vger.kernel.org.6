Return-Path: <linux-kernel+bounces-441530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F459ECFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B871889E16
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E51925AC;
	Wed, 11 Dec 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="unwoaA7K"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D7A482CD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931020; cv=none; b=HQxw8PGdcS6No/9zQZGCamLmuJOv6LmW2XO86UhQ1ypvWzA+ATIQy5illZGzvrD1JFIPgzVrCtC1FnQxlA3dqjozNkrU54ZytOy7Np2kx0aMUWRlJd/yh+4FYWLP9VZEfLjCJfWv/NocUlK2ESxHf3Ipw5+/1ecNiFdX3D668PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931020; c=relaxed/simple;
	bh=aR4vpZRbdf1eHVAxxc4pSGF/3WGP2cjCk1EHSwbk0jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9y+S5oqZwepwEpzmHjx8FlShjhdGFfUX/vVsjhJmzvqtfhVMrqOrlSQoj44gCnCooUdOIrvA50l4PsAS7Xgt9R8+nJCWfnwhvoDl1xqfCHXSy1x8ebEOgKPA0yZ76kWfbnLqSKjMxaPkLDFPHaauMxNjTYXiiXCqUebr1sU7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=unwoaA7K; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4678c9310afso188621cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733931017; x=1734535817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7YZmIYZeaqEm4Xe2VazE9uZvY20Q7LU62rBEaUV/dg=;
        b=unwoaA7KJjdatqagQqLI+32pMEtI3u7tUISjatriNz8Sx/RufuyBvyXM8A6Xf5PMm+
         zmjrPLz1lHx/13JV//3XjV3KbYl/bSHPNT00d0CyE36LVMkbe4pil5NxbwgAM8zhbxU/
         SKyzl/6NuzWT6jOklDGLx1Q4vqygksWLZE/8Y8vo2ZvDlHYvEtzOc7nuJYFtaf5fyTuK
         FVRrI4nNDiu7R/kty1J1GFvGJnhMODZ/R55yokMzw4LwetZLgWyuo626WCPHfxHkpLQ6
         sFeui05qBaNAQh/gA4ztAHXg4eQ5roKTTLzZrvNjRdsrLAIS0XhS3VkJiqvq8bMVwZzd
         jLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931017; x=1734535817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7YZmIYZeaqEm4Xe2VazE9uZvY20Q7LU62rBEaUV/dg=;
        b=w4K0sI/xcXVM8LJJvH5vfUaSNhQkAv6lKlCKBa/81iINeAeGlRg4aOq9weWMhl0qNg
         qHWG23nNBQDrxD+Mo8Vrrh7kkF5z8hs//9idET1surg/bJKtpjBFzCabk4OJovblMNGC
         jOG6JM6WeZs9tFtuJst0F/RwHVbAPq0GzHvfZijJ/UWfUviU9JVbpKmLwz3eSdmAI8QY
         tRge+A9bO6QAOcxMs8jBiNRn9/8lIYfS6ivUWJMYTrysaro7kNCiOhSXsUxdzDkvvY9b
         XizHBVBpVfNerH1mwS1Am/mnRpI8nHSgc9uwd/72ASaID19pwIYvF9xdAn95Wy6ecpFn
         hEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU848tTixwMNbjnNlLfSsMX5m0KawKAeYDR3O2GMlnRsLj3RAcYJ05b9GFEhic7F9+RAsCPfPHe/p4aaio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1TSP5hkKwAE4FDmUETiCsXZstytJXsKxVnzdYjlbgnj7cwfT4
	CFuO3YMnoCtb+H7QJTAmkIcH2nD701MczlaOB50wmAXkaGAuTk/7FoGE+CjxZDosmN5+tgLGcHq
	GrpRalyW0vSDTPXfoH/+WAnQnwqb1rUMUXiFY
X-Gm-Gg: ASbGnct69y90hFiftFyVR/+J9xblxlLcXmv0iH0drUM24GzhKMYFZRGobHb3E846A6c
	KdAttR/GxposSq4qO8WsO7ZpNl6lu1TVAOZ5eLD5XIq7f8ep3HJAT2yo3oZPjuoZVMg==
X-Google-Smtp-Source: AGHT+IE8MONiE/ew18nh+QhtE8JOLknbt1NMCdadeKFSl+Zc6Srrvj+4kbt7pHawXTW9L4XIFqtHFRz3pgT/YjmJXaI=
X-Received: by 2002:a05:622a:5196:b0:466:8c7c:3663 with SMTP id
 d75a77b69052e-46789eee51bmr4431511cf.5.1733931016401; Wed, 11 Dec 2024
 07:30:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206225204.4008261-1-surenb@google.com> <20241206225204.4008261-5-surenb@google.com>
 <6b29b2a5-c244-4930-a5a0-1a24a04e7e35@suse.cz> <CAJuCfpFxAZ-JwN8VqNF14zeBnsPM_pD0+-N2PDq5GcQGR1xqLQ@mail.gmail.com>
 <643beb6c-4226-46ca-b7e9-292467479aea@suse.cz> <CAJuCfpHR3LXfAZA_oh_2KBtFe6JQPU5T3nYMZd_ooAjRJd8xUQ@mail.gmail.com>
 <5036d089-0774-4863-88c5-eaaea1265ac7@suse.cz> <CAJuCfpGrnSTU5ZH0Vt_AXyyFX5vAyknqcOtRsfnh4dbpOeyy-A@mail.gmail.com>
In-Reply-To: <CAJuCfpGrnSTU5ZH0Vt_AXyyFX5vAyknqcOtRsfnh4dbpOeyy-A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Dec 2024 07:30:05 -0800
Message-ID: <CAJuCfpHcweCby61FpVr8cAhcr1JkXQyZ_LbKL3HrM8fsFTGiog@mail.gmail.com>
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

On Tue, Dec 10, 2024 at 3:01=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Dec 10, 2024 at 9:25=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 12/10/24 18:16, Suren Baghdasaryan wrote:
> > > On Tue, Dec 10, 2024 at 8:32=E2=80=AFAM Vlastimil Babka <vbabka@suse.=
cz> wrote:
> > >>
> > >> On 12/10/24 17:20, Suren Baghdasaryan wrote:
> > >> > On Tue, Dec 10, 2024 at 6:21=E2=80=AFAM Vlastimil Babka <vbabka@su=
se.cz> wrote:
> > >> >>
> > >> >> On 12/6/24 23:52, Suren Baghdasaryan wrote:
> > >> >> > To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure =
that
> > >> >> > object reuse before RCU grace period is over will be detected i=
nside
> > >> >> > lock_vma_under_rcu().
> > >> >> > lock_vma_under_rcu() enters RCU read section, finds the vma at =
the
> > >> >> > given address, locks the vma and checks if it got detached or r=
emapped
> > >> >> > to cover a different address range. These last checks are there
> > >> >> > to ensure that the vma was not modified after we found it but b=
efore
> > >> >> > locking it.
> > >> >> > vma reuse introduces several new possibilities:
> > >> >> > 1. vma can be reused after it was found but before it is locked=
;
> > >> >> > 2. vma can be reused and reinitialized (including changing its =
vm_mm)
> > >> >> > while being locked in vma_start_read();
> > >> >> > 3. vma can be reused and reinitialized after it was found but b=
efore
> > >> >> > it is locked, then attached at a new address or to a new mm whi=
le
> > >> >> > read-locked;
> > >> >> > For case #1 current checks will help detecting cases when:
> > >> >> > - vma was reused but not yet added into the tree (detached chec=
k)
> > >> >> > - vma was reused at a different address range (address check);
> > >> >> > We are missing the check for vm_mm to ensure the reused vma was=
 not
> > >> >> > attached to a different mm. This patch adds the missing check.
> > >> >> > For case #2, we pass mm to vma_start_read() to prevent access t=
o
> > >> >> > unstable vma->vm_mm. This might lead to vma_start_read() return=
ing
> > >> >> > a false locked result but that's not critical if it's rare beca=
use
> > >> >> > it will only lead to a retry under mmap_lock.
> > >> >> > For case #3, we ensure the order in which vma->detached flag an=
d
> > >> >> > vm_start/vm_end/vm_mm are set and checked. vma gets attached af=
ter
> > >> >> > vm_start/vm_end/vm_mm were set and lock_vma_under_rcu() should =
check
> > >> >> > vma->detached before checking vm_start/vm_end/vm_mm. This is re=
quired
> > >> >> > because attaching vma happens without vma write-lock, as oppose=
d to
> > >> >> > vma detaching, which requires vma write-lock. This patch adds m=
emory
> > >> >> > barriers inside is_vma_detached() and vma_mark_attached() neede=
d to
> > >> >> > order reads and writes to vma->detached vs vm_start/vm_end/vm_m=
m.
> > >> >> > After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_are=
a_cachep.
> > >> >> > This will facilitate vm_area_struct reuse and will minimize the=
 number
> > >> >> > of call_rcu() calls.
> > >> >> >
> > >> >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >> >>
> > >> >> I'm wondering about the vma freeing path. Consider vma_complete()=
:
> > >> >>
> > >> >> vma_mark_detached(vp->remove);
> > >> >>   vma->detached =3D true; - plain write
> > >> >> vm_area_free(vp->remove);
> > >> >>   vma->vm_lock_seq =3D UINT_MAX; - plain write
> > >> >>   kmem_cache_free(vm_area_cachep)
> > >> >> ...
> > >> >> potential reallocation
> > >> >>
> > >> >> against:
> > >> >>
> > >> >> lock_vma_under_rcu()
> > >> >> - mas_walk finds a stale vma due to race
> > >> >> vma_start_read()
> > >> >>   if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(mm->mm_lock_se=
q.sequence))
> > >> >>   - can be false, the vma was not being locked on the freeing sid=
e?
> > >> >>   down_read_trylock(&vma->vm_lock.lock) - suceeds, wasn't locked
> > >> >>     this is acquire, but was there any release?
> > >> >
> > >> > Yes, there was a release. I think what you missed is that
> > >> > vma_mark_detached() that is called from vma_complete() requires VM=
A to
> > >> > be write-locked (see vma_assert_write_locked() in
> > >> > vma_mark_detached()). The rule is that a VMA can be attached witho=
ut
> > >> > write-locking but only a write-locked VMA can be detached. So, aft=
er
> > >>
> > >> OK but write unlocking means the mm's seqcount is bumped and becomes
> > >> non-equal with vma's vma->vm_lock_seq, right?
> > >>
> > >> Yet in the example above we happily set it to UINT_MAX and thus effe=
ctively
> > >> false unlock it for vma_start_read()?
> > >>
> > >> And this is all done before the vma_complete() side would actually r=
each
> > >> mmap_write_unlock(), AFAICS.
> > >
> > > Ah, you are right. With the possibility of reuse, even a freed VMA
> > > should be kept write-locked until it is unlocked by
> > > mmap_write_unlock(). I think the fix for this is simply to not reset
> > > vma->vm_lock_seq inside vm_area_free(). I'll also need to add a
> >
> > But even if we don't reset vm_lock_seq to UINT_MAX, then whover realloc=
ated
> > it can proceed and end up doing a vma_start_write() and rewrite it ther=
e
> > anyway, no?
>
> Actually, I think with a small change we can simplify these locking rules=
:
>
> static inline void vma_start_write(struct vm_area_struct *vma)
> {
>         int mm_lock_seq;
>
> -        if (__is_vma_write_locked(vma, &mm_lock_seq))
> -                return;
> +        mmap_assert_write_locked(vma->vm_mm);
> +        mm_lock_seq =3D vma->vm_mm->mm_lock_seq;
>
>         down_write(&vma->vm_lock->lock);
>         /*
>         * We should use WRITE_ONCE() here because we can have concurrent =
reads
>         * from the early lockless pessimistic check in vma_start_read().
>         * We don't really care about the correctness of that early check,=
 but
>         * we should use WRITE_ONCE() for cleanliness and to keep KCSAN ha=
ppy.
>         */
>         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
>         up_write(&vma->vm_lock->lock);
> }
>
> This will force vma_start_write() to always write-lock vma->vm_lock
> before changing vma->vm_lock_seq. Since vma->vm_lock survives reuse,
> the other readers/writers will synchronize on it even if vma got
> reused.

After thinking of all the alternatives, I think the cleanest way to
handle vma detaching would be to follow the same pattern as for vma
attaching. To attach a vma we do:

vma->vm_mm =3D xxx;
...
vma_mark_attached()
    smp_wmb();
    WRITE_ONCE(vma->detached, false);


lock_vma_under_rcu() ensures that a vma is attached and still
unchanged like this:

lock_vma_under_rcu()
    vma_start_read();
    is_vma_detached()
        detached =3D READ_ONCE(vma->detached);
        smp_rmb();
    if (vma->vm_mm !=3D mm)

So, vm_area_free() can follow the same pattern to ensure vma reuse
gets detected even if lock_vma_under_rcu() succeeds in locking the
vma:

vm_area_free()
    vma->vm_mm =3D NULL;
    smp_wmb();
    WRITE_ONCE(vma->detached, true);

Vlastimil, I think that should address the race you described. WDYT?

>
> >
> > > comment for vm_lock_seq explaining these requirements.
> > > Do you agree that such a change would resolve the issue?
> > >
> > >>
> > >> > vma_mark_detached() and before down_read_trylock(&vma->vm_lock.loc=
k)
> > >> > in vma_start_read() the VMA write-lock should have been released b=
y
> > >> > mmap_write_unlock() and therefore vma->detached=3Dfalse should be
> > >> > visible to the reader when it executed lock_vma_under_rcu().
> > >> >
> > >> >>   is_vma_detached() - false negative as the write above didn't pr=
opagate
> > >> >>     here yet; a read barrier but where is the write barrier?
> > >> >>   checks for vma->vm_mm, vm_start, vm_end - nobody reset them yet=
 so false
> > >> >>     positive, or they got reset on reallocation but writes didn't=
 propagate
> > >> >>
> > >> >> Am I missing something that would prevent lock_vma_under_rcu() fa=
lsely
> > >> >> succeeding here?
> > >> >>
> > >>
> >

