Return-Path: <linux-kernel+bounces-416452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EBB9D44ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 01:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16606282AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1238D5234;
	Thu, 21 Nov 2024 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OzzDboaO"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A4023098C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732149231; cv=none; b=PlFzylH96K211dEq3tYRTZFPYaOdyxJj159cscBbM4rZTLVGXIEUKv1hL4MVTlh1/Rgfw/By8UdVIY29rG3YZOadApK3dXNcqshvS5p31cv6UN45OQ5bCjQVQ5nduK2g26Kk/mVAVsgNmQihlzkHyazz9Tkd6HPp++2MJ8LM38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732149231; c=relaxed/simple;
	bh=2hIBDyppP+989TTRPQ9tHS6PzGNn5GnwulBsDMjTvLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbb3YkWrBWAzJ4H4+16TATDZ5PbjTx7h22RC0wDCqTIfQl2SmjyqJaAKblnC7M5HGOInxY1GMn8kRxROxLBUnkkOZqpql4XZOiZNEAyXQkYwJhBS0msgwieVVRowjMHLN3VOI8t4t8Ih3PO36UzozWox5uY3MS6rcSN/ZG8uQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OzzDboaO; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4608dddaa35so161351cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732149228; x=1732754028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlniKgym+Q90GvuHd3GoZB7/NP0pryZ3yXdMK0RESg4=;
        b=OzzDboaOJORqBWXpsaT6tus7RJbQSemghgiV3WNGr08tHtJNggF6Gj3pmeQdWvHGxn
         4gIQfz9ubVgk3IqnpM4noiEpyEeBBvXpoYmyOZ1LxF9iSd29V3iaNPXc8vCUaxMYznh2
         FWH0GhjLShSZz4PRuvVM0yHOMk5erQV7GJ3lO+iWUUE5JunEawjgMdcsXuEM1hgieWs1
         YWu4b2gM+Z4RVc1wqjkzx0LQqZiNks2MsIVBeIXmS6g9mX6bGeBbV6PMtA9nw2qHAiab
         wWmpaWYB+L6Lw1WweIsXAb43YYenUylq3dnvyD0aPfbqVdzdt5YKN8fNxj7donJ9kvGh
         O+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732149228; x=1732754028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlniKgym+Q90GvuHd3GoZB7/NP0pryZ3yXdMK0RESg4=;
        b=t6JUs/kEOo7woKV9wYUGsLK7zmzutokoY1PZYalafYOfFXaNU22kvqyl7QURNWT9a3
         l8Y1ldGE/vB8HEdqkmOpH1Jbei4M4qr3GCmtOMNbs7kALatMJqr+Juke4C56QlT/zCGz
         08YbMFCLQyCAoHbh+E+eaxM0hJ/uRU4Z7h51XkbXFuofwzqBXVlUhShbg5x5w0Lrmicj
         U+4kaIhf4dDscs6zMoPVNMTWErzF2fHE5xJp1oVjT+eZ8MxONYgJwCJs0QCxfRkw5Wms
         obCsYHkSRvYpacLCJcYz1+iAL4XhHsNvg0Oe26wGO5j6ZiSplWjfy9uuUs4uazwNpe8c
         nezg==
X-Forwarded-Encrypted: i=1; AJvYcCUGkeJoumKTvQVwukJsMV9jFPMrN8y2qs8jOchL7DE0mRJL6MGYjge/snP29yLXSMTYPnLBakOTYT0H5DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOuqdLauVSj6yWvO+bTNnNuozoVEcH+pp1TqZjEbYEzj16xox
	s0cqrB12KjYfmIdiHW/nN9CjWvTNLgJjNMpTk3MpMUUIaFPYzXm6UWZRMCXmrvQoAH9iqt41Qz6
	zLUDj5+SlXWYKps4n249yFcQctgmHsR/KCn/E
X-Gm-Gg: ASbGncs0t+D83IZkkacdjIRgCIVXIjZSRb5fV3y9mDc2TzRiUuKs6i1ZCbClgkh7H/R
	/c4zWjrjdm1H9Y6Z/SUPZ5YSXub3l3uk=
X-Google-Smtp-Source: AGHT+IFQ/4vehjWSFCMPc5HZk4dt8N+0X4OiwXr6PNMh/c4OX08XmHwTEq8nAVQsyDRLqHOEJlqtef+ZYaSBMLoAvgU=
X-Received: by 2002:ac8:5811:0:b0:461:66ea:ea70 with SMTP id
 d75a77b69052e-465318e24c8mr659041cf.15.1732149228248; Wed, 20 Nov 2024
 16:33:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120000826.335387-1-surenb@google.com> <20241120000826.335387-3-surenb@google.com>
 <zfd7xdkr5dkvvx3caqao3oorh2pxxifhdhwsw2iyxcuzbevo3n@sobu7xhw24vv>
 <CAJuCfpFAh-gw_BVCaEB4+saedVC6aPB7HfyPikvTujyGRLXPwQ@mail.gmail.com> <wnwfgk32wyvx7tzd522ajwk5uixls7iayksrtho6c3dkvgdpek@25yqv3ohljzc>
In-Reply-To: <wnwfgk32wyvx7tzd522ajwk5uixls7iayksrtho6c3dkvgdpek@25yqv3ohljzc>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 Nov 2024 16:33:37 -0800
Message-ID: <CAJuCfpGx6LCd7qCOsLc6hm-qMGtyM3ceitYbRdx1yKPHFHT-jQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm: move per-vma lock into vm_area_struct
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, souravpanda@google.com, pasha.tatashin@soleen.com, 
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 4:05=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Wed, Nov 20, 2024 at 03:44:29PM -0800, Suren Baghdasaryan wrote:
> > On Wed, Nov 20, 2024 at 3:33=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Tue, Nov 19, 2024 at 04:08:23PM -0800, Suren Baghdasaryan wrote:
> > > > Back when per-vma locks were introduces, vm_lock was moved out of
> > > > vm_area_struct in [1] because of the performance regression caused =
by
> > > > false cacheline sharing. Recent investigation [2] revealed that the
> > > > regressions is limited to a rather old Broadwell microarchitecture =
and
> > > > even there it can be mitigated by disabling adjacent cacheline
> > > > prefetching, see [3].
> > > > Splitting single logical structure into multiple ones leads to more
> > > > complicated management, extra pointer dereferences and overall less
> > > > maintainable code. When that split-away part is a lock, it complica=
tes
> > > > things even further. With no performance benefits, there are no rea=
sons
> > > > for this split. Merging the vm_lock back into vm_area_struct also a=
llows
> > > > vm_area_struct to use SLAB_TYPESAFE_BY_RCU later in this patchset.
> > > > Move vm_lock back into vm_area_struct, aligning it at the cacheline
> > > > boundary and changing the cache to be cacheline-aligned as well.
> > > > With kernel compiled using defconfig, this causes VMA memory consum=
ption
> > > > to grow from 160 (vm_area_struct) + 40 (vm_lock) bytes to 256 bytes=
:
> > > >
> > > >     slabinfo before:
> > > >      <name>           ... <objsize> <objperslab> <pagesperslab> : .=
..
> > > >      vma_lock         ...     40  102    1 : ...
> > > >      vm_area_struct   ...    160   51    2 : ...
> > > >
> > > >     slabinfo after moving vm_lock:
> > > >      <name>           ... <objsize> <objperslab> <pagesperslab> : .=
..
> > > >      vm_area_struct   ...    256   32    2 : ...
> > > >
> > > > Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 =
pages,
> > > > which is 5.5MB per 100000 VMAs. Note that the size of this structur=
e is
> > > > dependent on the kernel configuration and typically the original si=
ze is
> > > > higher than 160 bytes. Therefore these calculations are close to th=
e
> > > > worst case scenario. A more realistic vm_area_struct usage before t=
his
> > > > change is:
> > > >
> > > >      <name>           ... <objsize> <objperslab> <pagesperslab> : .=
..
> > > >      vma_lock         ...     40  102    1 : ...
> > > >      vm_area_struct   ...    176   46    2 : ...
> > > >
> > > > Aggregate VMA memory consumption per 1000 VMAs grows from 54 to 64 =
pages,
> > > > which is 3.9MB per 100000 VMAs.
> > > > This memory consumption growth can be addressed later by optimizing=
 the
> > > > vm_lock.
> > > >
> > > > [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@go=
ogle.com/
> > > > [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9=
020/
> > > > [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP=
53cT_kbfP_pR+-2g@mail.gmail.com/
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > >
> > > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> >
> > Thanks!
> >
> > >
> > >
> > > One question below.
> > >
> > > > --- a/include/linux/mm_types.h
> > > > +++ b/include/linux/mm_types.h
> > > > @@ -716,8 +716,6 @@ struct vm_area_struct {
> > > >        * slowpath.
> > > >        */
> > > >       unsigned int vm_lock_seq;
> > > > -     /* Unstable RCU readers are allowed to read this. */
> > > > -     struct vma_lock *vm_lock;
> > > >  #endif
> > > >
> > > >       /*
> > > > @@ -770,6 +768,10 @@ struct vm_area_struct {
> > > >       struct vma_numab_state *numab_state;    /* NUMA Balancing sta=
te */
> > > >  #endif
> > > >       struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +     /* Unstable RCU readers are allowed to read this. */
> > > > +     struct vma_lock vm_lock ____cacheline_aligned_in_smp;
> > > > +#endif
> > > >  } __randomize_layout;
> > >
> > > Do we just want 'struct vm_area_struct' to be cacheline aligned or do=
 we
> > > want 'struct vma_lock vm_lock' to be on a separate cacheline as well?
> >
> > We want both to minimize cacheline sharing.
> >
>
> For later, you will need to add a pad after vm_lock as well, so any
> future addition will not share the cacheline with vm_lock. I would do
> something like below. This is a nit and can be done later.
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 7654c766cbe2..5cc4fff163a0 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -751,10 +751,12 @@ struct vm_area_struct {
>  #endif
>         struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>  #ifdef CONFIG_PER_VMA_LOCK
> +       CACHELINE_PADDING(__pad1__);
>         /* Unstable RCU readers are allowed to read this. */
> -       struct vma_lock vm_lock ____cacheline_aligned_in_smp;
> +       struct vma_lock vm_lock;
> +       CACHELINE_PADDING(__pad2__);
>  #endif
> -} __randomize_layout;
> +} __randomize_layout ____cacheline_aligned_in_smp;

I thought SLAB_HWCACHE_ALIGN for vm_area_cachep added in this patch
would have the same result, no?

>
>  #ifdef CONFIG_NUMA
>  #define vma_policy(vma) ((vma)->vm_policy)

