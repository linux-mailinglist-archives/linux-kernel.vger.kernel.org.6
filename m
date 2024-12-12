Return-Path: <linux-kernel+bounces-443194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BCC9EE89F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A731888CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731592144A8;
	Thu, 12 Dec 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPGZcJnh"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C46F307
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013205; cv=none; b=nDw0Wzh0VbfYVm5vkeJpJcD7HkB2M4qZenCw2Gwo/nkzkUFo1e8mbVjRMZiozRruytz8Ex2eOUFxZXtvhILraJ6p5FMMfxaejaDly7ueURnF6kr8d6Y29ZWTMQsqM8tDW2GcJ7zgcYKfgBryo5T5+xkfSw+yc5GnaQH2UvhW3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013205; c=relaxed/simple;
	bh=e9XUCK4rE5aLvdLkM9dbdsfQBZu/KuTDO2apDqkN10Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpQvBdayZH/9Q0gYoNblsnEDcmUx/NMgfsdBZ2A1WOTw/iCcNQsSYgMCKkT7b8qukF+kDrOzxbsOm2Sx1Xh0oAb7siYk7Kx4HtgtIhBeamHZtMu9KfMeN05V12kiD1VNl6FD8yHZXEbH9hmrZCxOIEB3/h5zI4l5tiT7Mf1PDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dPGZcJnh; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4679b5c66d0so181651cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734013203; x=1734618003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCVMFBpGFbUIZbev/pXMJAK+krnsD/kF9SAOCAuF0H0=;
        b=dPGZcJnh/t4OSbugsGw920PrGYA9JFQJcxTEX6mTUOlhDVCI1fmdZ4CvhZRGDE5FBx
         RZ/S6rFQmtYe/U3DkldB3ytc40YTlnfShAcVxL0ids3b6800KX+of9AzCa1gDGXHdt7y
         BySVA6rWHNaoWMKc0FjOEkG24Ls5IixQ1DS+XQsbMeT8FaS/biONMPbnPRvtoMe7+st9
         RlhE9HmxpQ5k8PlAQ1DeBSTlrFiOJFm/GTAzXRLQDfpOh8ophzOo9YvB/BugBxg9bAhL
         SDGcJpgLj7k6HAaHVUlkUTUqo6KktjO9M4010N300GDgETItGM22qvLfPpbhyl9WenYm
         tsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734013203; x=1734618003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCVMFBpGFbUIZbev/pXMJAK+krnsD/kF9SAOCAuF0H0=;
        b=f6VSNPymdXds9wZrLGePu/sf6u/Ke90XsfwNAizucxa68TeZ7EuF10mzbeEfFex2sR
         kuN2mQU7PBf2cpg6zEvbInsD7f32AsnRrU2qT78uObt9z6hNdLEqBofJthnd08o2vFaZ
         ZEsiZ6HhgQRAiu33Tez6ChbtgRCSIvVpUzLy3sx1mjbRE5G8d77lRM2eTx851/lNyecf
         B71QTWvvyawOeBVIGIFKRIsGlOEwEqNlZKkDntWwGlaBh2PVu/ozLN535ngviKJ60IWm
         fKCOsst1GunXUXAfoc1opHyUn2NSfYg8YgowCAeG7f7aoBkOWYfmlfpP1TmeW/eLXZUP
         +ifg==
X-Forwarded-Encrypted: i=1; AJvYcCWu6c9X3tHXu/0rXmfOx2J9vlA9hN3ieu4CAiqL8JeiYMLbRmy+r8asjhReObvbTumApH7PZki/6r1Kn4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxM/WF1jiYrG+GBDZEK764Mk2S4xSGHZzDduGEpi9D30O+tYdF
	AljhTDK/U9H9mhzra74cfntYUVMrLdZ5rk24bM5oCEg4qLL0I7Jr02x1l5+fXGCcVJAievKDJm0
	lcf04t99qZbZ73xv17clMaSfKwXhCHGtt0z/T
X-Gm-Gg: ASbGncu7qm8cz2cAgtoUnOM4vybKyPU208KCQciz/buILfq/qHRS2sECuhbmoPUrUq0
	cCB648DK9syZCkyv9m7zf5zV3pu79b6FHskhKe7u76Fimj2/2MWl3cNnC57IJDlMHTNkf
X-Google-Smtp-Source: AGHT+IGQD28bFCgREVH5GOLTWkXyk6w0rQZbOiNATXbvgagTXwWuRCrJ8uEbfZTGbMgsqTIRIKjOlTWvx6CUpOJPP4A=
X-Received: by 2002:a05:622a:230c:b0:461:3311:8986 with SMTP id
 d75a77b69052e-467a0fd4b60mr653601cf.18.1734013202866; Thu, 12 Dec 2024
 06:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111205506.3404479-4-surenb@google.com>
 <ZzLgZTH9v5io1Elx@casper.infradead.org> <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>
 <20241210223850.GA2484@noisy.programming.kicks-ass.net> <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
 <20241211082541.GQ21636@noisy.programming.kicks-ass.net> <CAJuCfpEMYhAmOPwjGO+j1t+069MJZxUs1O1co-zJ4+vEeXCtng@mail.gmail.com>
 <CAJuCfpGOOcRAJ46sbPRoCUNuuhi2fnkM97F=CfZ1=_N5ZFUcLw@mail.gmail.com>
 <20241212091659.GU21636@noisy.programming.kicks-ass.net> <CAJuCfpHKFZ2Q1R1Knh-LFLUYcTX6CJuEsqNM5AwxRyDUAzdcVw@mail.gmail.com>
In-Reply-To: <CAJuCfpHKFZ2Q1R1Knh-LFLUYcTX6CJuEsqNM5AwxRyDUAzdcVw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Dec 2024 06:19:51 -0800
Message-ID: <CAJuCfpGKEthmc2JkbOcfEJqsM_cBcm0cAvv0VFe-acMi169fcQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 6:17=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Dec 12, 2024 at 1:17=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Wed, Dec 11, 2024 at 07:01:16PM -0800, Suren Baghdasaryan wrote:
> >
> > > > > > I think your proposal should work. Let me try to code it and se=
e if
> > > > > > something breaks.
> > >
> > > Ok, I tried it out and things are a bit more complex:
> > > 1. We should allow write-locking a detached VMA, IOW vma_start_write(=
)
> > > can be called when vm_refcnt is 0.
> >
> > This sounds dodgy, refcnt being zero basically means the object is dead
> > and you shouldn't be touching it no more. Where does this happen and
> > why?
> >
> > Notably, it being 0 means it is no longer in the mas tree and can't be
> > found anymore.
>
> It happens when a newly created vma that was not yet attached
> (vma->vm_refcnt =3D 0) is write-locked before being added into the vma
> tree. For example:
> mmap()
>   mmap_write_lock()
>   vma =3D vm_area_alloc() // vma->vm_refcnt =3D 0 (detached)
>   //vma attributes are initialized
>   vma_start_write() // write 0x8000 0001 into vma->vm_refcnt
>   mas_store_gfp()
>   vma_mark_attached()
>   mmap_write_lock() // vma_end_write_all()

s/mmap_write_lock()/mmap_write_unlock()
>
> In this scenario, we write-lock the VMA before adding it into the tree
> to prevent readers (pagefaults) from using it until we drop the
> mmap_write_lock(). In your proposal, the first thing vma_start_write()
> does is add(0x8000'0001) and that will trigger a warning.
> For now instead of add(0x8000'0001) I can play this game to avoid the war=
ning:
>
> if (refcount_inc_not_zero(&vma->vm_refcnt))
>     refcount_add(0x80000000, &vma->vm_refcnt);
> else
>     refcount_set(&vma->vm_refcnt, 0x80000001);
>
> this refcount_set() works because vma with vm_refcnt=3D=3D0 could not be
> found by readers. I'm not sure this will still work when we add
> TYPESAFE_BY_RCU and introduce vma reuse possibility.
>
> >
> > > 2. Adding 0x80000000 saturates refcnt, so I have to use a lower bit
> > > 0x40000000 to denote writers.
> >
> > I'm confused, what? We're talking about atomic_t, right?
>
> I thought you suggested using refcount_t. According to
> https://elixir.bootlin.com/linux/v6.13-rc2/source/include/linux/refcount.=
h#L22
> valid values would be [0..0x7fff_ffff] and 0x80000000 is outside of
> that range. What am I missing?
>
> >
> > > 3. Currently vma_mark_attached() can be called on an already attached
> > > VMA. With vma->detached being a separate attribute that works fine bu=
t
> > > when we combine it with the vm_lock things break (extra attach would
> > > leak into lock count). I'll see if I can catch all the cases when we
> > > do this and clean them up (not call vma_mark_attached() when not
> > > necessary).
> >
> > Right, I hadn't looked at that thing in detail, that sounds like it
> > needs a wee cleanup like you suggest.
>
> Yes, I'll embark on that today. Will see how much of a problem that is.

