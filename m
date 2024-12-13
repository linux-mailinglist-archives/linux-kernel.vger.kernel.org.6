Return-Path: <linux-kernel+bounces-444274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 260819F03E5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F57D169616
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ACE157E9F;
	Fri, 13 Dec 2024 04:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oj2sxyEw"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730663D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734065347; cv=none; b=gScMDC08XhOR6JqvU4l3V4gUMMqud9Nv3KjPlr46vzaOHXmfSGZIrXJ/oM09S6wQXA/PwCbRDHznySKAWL6yqXiE21pmlgCbLOzr/QjH0o9ty/JJbiN+70Y5M8sj2sSnnH/+UygODeZaxIVHEYA4cj00fa1WSBHDauVnSkyXS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734065347; c=relaxed/simple;
	bh=wWvlg86nnvYdmWi19+e+JOean4rcHoBiU0RbujYIRv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lM/ipLKkdT0Kjuu/j8/Mj0VXI0ElLSjFMhNWzhs16rCToBLae/9/5N3zEcgqRUlvci3EW9aTNzdioHn8ZD+qzbW2LMC/1iitSq6zNIaS25tgpemJHqEfmmLsEVXhMhlpJlWcJkI6bWIfAtbBz/6VXyCwCW/lKIVgF012AzRD7jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oj2sxyEw; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4675936f333so82401cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734065344; x=1734670144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyKXtJmevA9J1gjLkDCWf2rvJGPBPi1c5QO3oGVTNNs=;
        b=Oj2sxyEwuwWj9aX/+1c6GEPSik1JaDt+ugH6IWLO8Cgu+iDx+5FXq9ajR7hPe71/ZQ
         zmYjdpS/gek1m8AS5QInPmajuochqSWVFVlUbIGL99qMqAHN2fr9UgWH/a2LC+DewZFr
         i29/9rILFQ0jnLZmgIVmpFWMBfZKNo9eCco30tl9Q2VRI9+jGbE7ZlVQ8OTmVOpHWp1M
         J98f6Rz8tg+EmKiaVzYuuufjHAwbONiXqnveW1QG6VOojczoexTPmPMZmsbTPN+alz7P
         ZHnovHHkudCH+iSHbTOc2RJTeLbH5ThmIhx2V2rYkycKUdZ2017PJaq7nmbzHPIn7mTw
         s3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734065344; x=1734670144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyKXtJmevA9J1gjLkDCWf2rvJGPBPi1c5QO3oGVTNNs=;
        b=eIQ2Qw6DEj+Ia80yJViBbdyV9l3hnBgqi4MVlpb5X9+dWLSgUqjMgM/3PTNB3Dp1xu
         Jh7L8NgDK8czAoV0H3TNAFYatUBk8c5ho0xBgo6LOt2yTFEIi675T1NtrJSI1h33tVdJ
         2+KWK2JCAauAEZdwRmCWU9Q3G3tYQV3gvgp/fmd7NAC9bHECVdReGaWsU5g2DbQYqE59
         zgZstrQNR2sAOyDCSZPLUfl7RHoOjidLGcIErOLfqZ4Wbo68q1pm68OPQ3E0fF8SxIFT
         RUf8IlWUQGPCW2eQ2ZoKSZOni4JFC9COg6o2WfDHY6d3+8nR9yFndi7zpF+yBNOZ9OEi
         QqEg==
X-Forwarded-Encrypted: i=1; AJvYcCUwb+X+FOZH8BWN+RYBVtHvqgb7bBMdxJni+/suqMYyK68yP3A/dXhD6EfaNMWHRxiI7sGIpu2HgRMBrRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPv/Clk9XO+9Y7Yg83QdusB8Afma2iS7IWXhjTasRU1O+c6VOE
	HSOBDKxOooZcNxuu6IsgmosL6xpx7Rq7a914ScTvJ19MCeNWwCWWed+ALhEArMVMLTfmjztKQ7A
	fii4Tw64WdO0OO4CXZxgmG8CjFgFa7PwO+FDM
X-Gm-Gg: ASbGnctWBtr+K19wswHtpUs4PDZwVKDWj5VRqURIDInX7k4F4ONe0ZZVmkCsFYCI3T1
	ds8dLP0x8/MU6kRVnaOln0NBvdZM+4GldYAcR1g==
X-Google-Smtp-Source: AGHT+IFVRVj5b+YtZOxsCPfKPMEuiih8mLUGJyZ2MQP37hYAM9kY+0XKaSq6UxN3JVSNRWmfOQDKcyU5UdXVO+YzM/8=
X-Received: by 2002:a05:622a:1e92:b0:466:975f:b219 with SMTP id
 d75a77b69052e-467a424b2e1mr2331841cf.8.1734065344059; Thu, 12 Dec 2024
 20:49:04 -0800 (PST)
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
 <CAJuCfpGKEthmc2JkbOcfEJqsM_cBcm0cAvv0VFe-acMi169fcQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGKEthmc2JkbOcfEJqsM_cBcm0cAvv0VFe-acMi169fcQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Dec 2024 20:48:52 -0800
Message-ID: <CAJuCfpGJcrCkzOtaZDH98_oQK01+HNxHzzsf7SS95cXVRyXUPg@mail.gmail.com>
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

On Thu, Dec 12, 2024 at 6:19=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Dec 12, 2024 at 6:17=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Thu, Dec 12, 2024 at 1:17=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 07:01:16PM -0800, Suren Baghdasaryan wrote:
> > >
> > > > > > > I think your proposal should work. Let me try to code it and =
see if
> > > > > > > something breaks.
> > > >
> > > > Ok, I tried it out and things are a bit more complex:
> > > > 1. We should allow write-locking a detached VMA, IOW vma_start_writ=
e()
> > > > can be called when vm_refcnt is 0.
> > >
> > > This sounds dodgy, refcnt being zero basically means the object is de=
ad
> > > and you shouldn't be touching it no more. Where does this happen and
> > > why?
> > >
> > > Notably, it being 0 means it is no longer in the mas tree and can't b=
e
> > > found anymore.
> >
> > It happens when a newly created vma that was not yet attached
> > (vma->vm_refcnt =3D 0) is write-locked before being added into the vma
> > tree. For example:
> > mmap()
> >   mmap_write_lock()
> >   vma =3D vm_area_alloc() // vma->vm_refcnt =3D 0 (detached)
> >   //vma attributes are initialized
> >   vma_start_write() // write 0x8000 0001 into vma->vm_refcnt
> >   mas_store_gfp()
> >   vma_mark_attached()
> >   mmap_write_lock() // vma_end_write_all()
>
> s/mmap_write_lock()/mmap_write_unlock()
> >
> > In this scenario, we write-lock the VMA before adding it into the tree
> > to prevent readers (pagefaults) from using it until we drop the
> > mmap_write_lock(). In your proposal, the first thing vma_start_write()
> > does is add(0x8000'0001) and that will trigger a warning.
> > For now instead of add(0x8000'0001) I can play this game to avoid the w=
arning:
> >
> > if (refcount_inc_not_zero(&vma->vm_refcnt))
> >     refcount_add(0x80000000, &vma->vm_refcnt);
> > else
> >     refcount_set(&vma->vm_refcnt, 0x80000001);
> >
> > this refcount_set() works because vma with vm_refcnt=3D=3D0 could not b=
e
> > found by readers. I'm not sure this will still work when we add
> > TYPESAFE_BY_RCU and introduce vma reuse possibility.
> >
> > >
> > > > 2. Adding 0x80000000 saturates refcnt, so I have to use a lower bit
> > > > 0x40000000 to denote writers.
> > >
> > > I'm confused, what? We're talking about atomic_t, right?
> >
> > I thought you suggested using refcount_t. According to
> > https://elixir.bootlin.com/linux/v6.13-rc2/source/include/linux/refcoun=
t.h#L22
> > valid values would be [0..0x7fff_ffff] and 0x80000000 is outside of
> > that range. What am I missing?
> >
> > >
> > > > 3. Currently vma_mark_attached() can be called on an already attach=
ed
> > > > VMA. With vma->detached being a separate attribute that works fine =
but
> > > > when we combine it with the vm_lock things break (extra attach woul=
d
> > > > leak into lock count). I'll see if I can catch all the cases when w=
e
> > > > do this and clean them up (not call vma_mark_attached() when not
> > > > necessary).
> > >
> > > Right, I hadn't looked at that thing in detail, that sounds like it
> > > needs a wee cleanup like you suggest.
> >
> > Yes, I'll embark on that today. Will see how much of a problem that is.

Ok, I think I was able to implement this in a way that ignores
duplicate attach/detach calls. One issue that I hit and don't know a
good way to fix is a circular dependency in the header files once I
try adding rcuwait into mm_struct. Once I include rcuwait.h into
mm_types.h leads to the following cycle:

In file included from ./arch/x86/include/asm/uaccess.h:12,
                 from ./include/linux/uaccess.h:12,
                 from ./include/linux/sched/task.h:13,
                 from ./include/linux/sched/signal.h:9,
                 from ./include/linux/rcuwait.h:6,
                 from ./include/linux/mm_types.h:22,

./arch/x86/include/asm/uaccess.h includes mm_types.h. But in fact
there is a shorter cycle:

rcuwait.h needs signal.h since it uses uses inlined signal_pending_state()
signal.h needs mm_types.h since it uses vm_fault_t

The way I worked around it for now is by removing signal.h include
from rcuwait.h and wrapping signal_pending_state() into a non-inlined
function so I can forward-declare it. That requires adding
linux/sched/signal.h or linux/sched/task.h into many other places:

 arch/x86/coco/sev/core.c                                     | 1 +
 arch/x86/kernel/fpu/xstate.c                                 | 1 +
 block/blk-lib.c                                              | 1 +
 block/ioctl.c                                                | 1 +
 drivers/accel/qaic/qaic_control.c                            | 1 +
 drivers/base/firmware_loader/main.c                          | 1 +
 drivers/block/ublk_drv.c                                     | 1 +
 drivers/crypto/ccp/sev-dev.c                                 | 1 +
 drivers/dma-buf/heaps/cma_heap.c                             | 1 +
 drivers/dma-buf/heaps/system_heap.c                          | 1 +
 drivers/gpio/gpio-sloppy-logic-analyzer.c                    | 1 +
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                        | 1 +
 drivers/iommu/iommufd/ioas.c                                 | 1 +
 drivers/iommu/iommufd/pages.c                                | 1 +
 .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c    | 1 +
 drivers/tty/n_tty.c                                          | 1 +
 fs/bcachefs/fs-io-buffered.c                                 | 1 +
 fs/bcachefs/journal_reclaim.c                                | 1 +
 fs/bcachefs/thread_with_file.c                               | 1 +
 fs/bcachefs/util.c                                           | 1 +
 fs/btrfs/defrag.h                                            | 1 +
 fs/btrfs/fiemap.c                                            | 2 ++
 fs/btrfs/free-space-cache.h                                  | 1 +
 fs/btrfs/reflink.c                                           | 1 +
 fs/exfat/balloc.c                                            | 1 +
 fs/gfs2/ops_fstype.c                                         | 1 +
 fs/kernel_read_file.c                                        | 1 +
 fs/netfs/buffered_write.c                                    | 1 +
 fs/zonefs/file.c                                             | 1 +
 include/linux/fs.h                                           | 2 +-
 include/linux/rcuwait.h                                      | 4 ++--
 io_uring/io_uring.h                                          | 1 +
 kernel/dma/map_benchmark.c                                   | 1 +
 kernel/futex/core.c                                          | 1 +
 kernel/futex/pi.c                                            | 1 +
 kernel/rcu/update.c                                          | 5 +++++
 kernel/task_work.c                                           | 1 +
 lib/kunit/user_alloc.c                                       | 1 +
 mm/damon/vaddr.c                                             | 1 +
 mm/memcontrol-v1.c                                           | 1 +
 mm/shrinker_debug.c                                          | 1 +
 net/dns_resolver/dns_key.c                                   | 1 +
 42 files changed, 48 insertions(+), 3 deletions(-)

I'm not sure if this is the best way to deal with this circular
dependency. Any other ideas?

