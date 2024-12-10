Return-Path: <linux-kernel+bounces-439920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014839EB60D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF199282E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4D11BC09A;
	Tue, 10 Dec 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4nylvokc"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801E51AAA0E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847662; cv=none; b=bbwHtYFWhNrkPBKQtzOU+451B+0KwGg1i3g/DeONJKeqVtLAsXs702TiILbEtByYw0O3Y9xE9T4cdi8LDN52kp1B5PU3ZnwCdMDIL6YcOiOsUG+GR9bREE4shJWBbGDYpPfS9hjsO+Wm1O0CkhYwQy7WlnMLMYplbm4YgOqmfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847662; c=relaxed/simple;
	bh=WCz5g5BOqJlIYebnOOzSEgEWhNJnw8cMCnPXPn40gB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QO+gF0fq/j/tk3wknUeoN2lm715qcD51jxi/hMxZPKwJgwZC7uiQkYffRkfMwLXuMfF4mrDV9qXfZGX+YTOtVXc5iMU4Ht/vFjVLPXp98KOLRvRMdT7731jGDwHBA5mDrAhl+tewsAxNJA4yAu/gVncQpIRVZvuj5Rvan8W5K5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4nylvokc; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467431402deso198801cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733847659; x=1734452459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2hiMkjjjVlbn+YVdVeNdJ0jmHrRa7EL5H/2Jru6fxk=;
        b=4nylvokc8cX/q6hJUpBb1owBUtyQqV9ScwA/wXbBQFEu1YDgdbpFk0V4biNXRO3962
         oXt/zAXkfs6W8sd03CUb6Wt8O8R8hYsaXn1h+m1MkkyMsRt8K4N5yOEerNuAZqTZdLGt
         OJuAa0EAnbuVqVPXu749PFxmc8qpjbJzATOPwFVX3wjRtyxZv/qulrBTrDZK1baJHU51
         XYfb3LKoKbz3Q7D7dupPl9bIoaR2Lfm7+4ztsU4flpyXlW2HbZsc41JxU464vQ45+RtG
         0r7jQyTun1d05fRVTp1MQW4XPC/XsEn/c/MuGKOPNb5QPIbPH4p4auj3kaz0wS5XeKRR
         N0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847659; x=1734452459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2hiMkjjjVlbn+YVdVeNdJ0jmHrRa7EL5H/2Jru6fxk=;
        b=b47WKg7Oa+2wn1ZxGWI3HIoCNJU7nkbeU4PMR45496iS2WWQ0TYRev2VLyDpSTAYF5
         XqAWv79ZuHGYlC+zo3mWZ+zoO0bbgvQxJxGVQN/e/FF8P1gKwA4rILWGH6rntOEPMaDJ
         OVL96lX9QhSzuvWE3fRBYKJaNzED8IKBPY+a9kw4y5DUBgUB98Tt/N1Iw8AYNj59CLvk
         RYjkT3LHw7hEoy5jwaUaAR5gTYitgwvbYYFOn8XA26jjyDfAeyzk6niem4I9c4dTrO3b
         ip/2ylRHv4ADdkIJlNtZixODCpDkARumWEitRIK5hRVRNihcuKvruERARQUM1ORSKc5d
         TfkA==
X-Forwarded-Encrypted: i=1; AJvYcCUpnI9MunvxbIrfEzwpPOIsj3YZoddA1H0BGy6Jnfy138+dim+o3ibSSnzaUxl29VIMgS1SFA9C4AQneJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDDgwvflFoIsJYdZq5SYp0kyJ+yOpq5yu0Pfyq41tMUOIq7c+0
	c7Appnp6LNZrp8bBc4WWmdxMOgaGOk2B9Zx3AHInPj8ExVyMaJZl1smr+FICKkcWwsszKw4rMfn
	YxFAB8m2MwCFNtEIiq/UaVVz/IA2CJuKTd5N2
X-Gm-Gg: ASbGnctR6bqiGIVWOQ+rghmXx6Sz9WACBS1T0J6teFqOhnjl11XQReQEHLCcWR8VogI
	KVq3naeve/xzWudxJEqMqPTQraaFAPDqW0ABWFofi+xI0UXwfACiGKg0XntJpgY8w6g==
X-Google-Smtp-Source: AGHT+IEK52d7RE1NdbydIAQRmCAaAzJc6Wse0Ga444Vy7SdCxJyRTZz+lZVsbT/20lTHNDne5D6oKbW6pS20DgMSCSQ=
X-Received: by 2002:a05:622a:5a19:b0:466:9b73:8e3c with SMTP id
 d75a77b69052e-46777658682mr4146491cf.13.1733847659152; Tue, 10 Dec 2024
 08:20:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206225204.4008261-1-surenb@google.com> <20241206225204.4008261-5-surenb@google.com>
 <6b29b2a5-c244-4930-a5a0-1a24a04e7e35@suse.cz>
In-Reply-To: <6b29b2a5-c244-4930-a5a0-1a24a04e7e35@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 10 Dec 2024 08:20:48 -0800
Message-ID: <CAJuCfpFxAZ-JwN8VqNF14zeBnsPM_pD0+-N2PDq5GcQGR1xqLQ@mail.gmail.com>
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

On Tue, Dec 10, 2024 at 6:21=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 12/6/24 23:52, Suren Baghdasaryan wrote:
> > To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure that
> > object reuse before RCU grace period is over will be detected inside
> > lock_vma_under_rcu().
> > lock_vma_under_rcu() enters RCU read section, finds the vma at the
> > given address, locks the vma and checks if it got detached or remapped
> > to cover a different address range. These last checks are there
> > to ensure that the vma was not modified after we found it but before
> > locking it.
> > vma reuse introduces several new possibilities:
> > 1. vma can be reused after it was found but before it is locked;
> > 2. vma can be reused and reinitialized (including changing its vm_mm)
> > while being locked in vma_start_read();
> > 3. vma can be reused and reinitialized after it was found but before
> > it is locked, then attached at a new address or to a new mm while
> > read-locked;
> > For case #1 current checks will help detecting cases when:
> > - vma was reused but not yet added into the tree (detached check)
> > - vma was reused at a different address range (address check);
> > We are missing the check for vm_mm to ensure the reused vma was not
> > attached to a different mm. This patch adds the missing check.
> > For case #2, we pass mm to vma_start_read() to prevent access to
> > unstable vma->vm_mm. This might lead to vma_start_read() returning
> > a false locked result but that's not critical if it's rare because
> > it will only lead to a retry under mmap_lock.
> > For case #3, we ensure the order in which vma->detached flag and
> > vm_start/vm_end/vm_mm are set and checked. vma gets attached after
> > vm_start/vm_end/vm_mm were set and lock_vma_under_rcu() should check
> > vma->detached before checking vm_start/vm_end/vm_mm. This is required
> > because attaching vma happens without vma write-lock, as opposed to
> > vma detaching, which requires vma write-lock. This patch adds memory
> > barriers inside is_vma_detached() and vma_mark_attached() needed to
> > order reads and writes to vma->detached vs vm_start/vm_end/vm_mm.
> > After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_area_cachep=
.
> > This will facilitate vm_area_struct reuse and will minimize the number
> > of call_rcu() calls.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> I'm wondering about the vma freeing path. Consider vma_complete():
>
> vma_mark_detached(vp->remove);
>   vma->detached =3D true; - plain write
> vm_area_free(vp->remove);
>   vma->vm_lock_seq =3D UINT_MAX; - plain write
>   kmem_cache_free(vm_area_cachep)
> ...
> potential reallocation
>
> against:
>
> lock_vma_under_rcu()
> - mas_walk finds a stale vma due to race
> vma_start_read()
>   if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(mm->mm_lock_seq.sequen=
ce))
>   - can be false, the vma was not being locked on the freeing side?
>   down_read_trylock(&vma->vm_lock.lock) - suceeds, wasn't locked
>     this is acquire, but was there any release?

Yes, there was a release. I think what you missed is that
vma_mark_detached() that is called from vma_complete() requires VMA to
be write-locked (see vma_assert_write_locked() in
vma_mark_detached()). The rule is that a VMA can be attached without
write-locking but only a write-locked VMA can be detached. So, after
vma_mark_detached() and before down_read_trylock(&vma->vm_lock.lock)
in vma_start_read() the VMA write-lock should have been released by
mmap_write_unlock() and therefore vma->detached=3Dfalse should be
visible to the reader when it executed lock_vma_under_rcu().

>   is_vma_detached() - false negative as the write above didn't propagate
>     here yet; a read barrier but where is the write barrier?
>   checks for vma->vm_mm, vm_start, vm_end - nobody reset them yet so fals=
e
>     positive, or they got reset on reallocation but writes didn't propaga=
te
>
> Am I missing something that would prevent lock_vma_under_rcu() falsely
> succeeding here?
>

