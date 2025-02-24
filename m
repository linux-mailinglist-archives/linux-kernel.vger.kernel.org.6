Return-Path: <linux-kernel+bounces-528041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92176A412C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0065189499C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE761581F1;
	Mon, 24 Feb 2025 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sm0z9XSr"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DFB1624F8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361394; cv=none; b=Lm9RMpB59KVkvT3GZMNiH589iT87IdU9AiLq2iQquGchmtHVrBE6UCEtVOzwpzw10VM64y1bxGf+mUo0hZeObIpTcNpUpNlzeIxQ9tszo2uhDLgrxcoawWt/qaNrlGLSJH7xtVTKb8KsiSFIDWSNXKKF3S4rH0ZgaxH8lBrebzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361394; c=relaxed/simple;
	bh=vdtp4eQZcAfe4JNSX52sOZpuWEKdb6wt8qJjerVOHDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSTjKaa/WJNAEeXH8Zs5lCJu8Qjvt/aPxxR6vEo8bx+/OgKgtlroNWLCn0mR8RgW7ycXPMJWyVXW9udjsT+a3BLeudJJjFTontp4qAnCzKvvMq0qGnFpm7Hqr/O1FsAhnyKrRqXP33czixizrlI445ktXQ/vDCol65PmdAqBg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sm0z9XSr; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471fa3b19bcso309431cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740361392; x=1740966192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs4/qefU1QtpU6+89lIxVt3csQSR47g1ulJgvu+2+tI=;
        b=sm0z9XSr/H9I10CD4fPvS8qlEdMwYoe9SjwkHgjetHeyKp5wAqzpyCjXOLUXPuKdBX
         JvfdgQljmfsCQkyCBAqbtjgLfrb9dupa0p8sg0McngWTHx4Blz30Kaj4t5Qsk9by8OVH
         /E/K3DgI8dvPLnwvg/mfNYiSNMTAvEO09NvZ9vqZ9BOhrOdb6mwa8brXSVy1VeNBaBIu
         K8yPvw4CC87vvWnCB93DapnyaIKXEtORYC2Xp7hRwLwQwdUb/BSdbBg+iN3cVXv1qKPX
         4sJLgwVXRIvySsx7eK8bBjzaZbJcq1S5VrtRnvP1UQYiyWxjNh3dqK6ZXskLLv3dXFUy
         muPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740361392; x=1740966192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hs4/qefU1QtpU6+89lIxVt3csQSR47g1ulJgvu+2+tI=;
        b=iLi3R0gZS1WNew6NEenV+lnipdYaVXS2d76tV5fsqZ0mMipUzG4ebCL4r+9C+lfb17
         76x+iktk282r/Y/5f5T9wRb2j814j5V816vTqFPnp2bBypkVidh3p1lO1R/woKnZ34GA
         pubZnUWdSxvvxrUBTrgBA2pmI7BjBeDVMIIUA+EV13uT8Nt4oe/ps5Lhncmnz9SLgzV8
         3Z/zpp4jsbkob0ZahPRVDiSDSbZ9DcVvT7GGWxVWhLJIaozc5XFViCSNYFBr5gyZNkcA
         tZtceSfEFb70nASR0F27JnXaUfITTJNz0VejMsvhowMFU4UpASB7b/3gzyB9pzKc9NR4
         yp3w==
X-Forwarded-Encrypted: i=1; AJvYcCV/sbaNs4Cw5ZedfeVIL/nQBNpFGVxAb3+UxRq0PgiNkT/AaXDAMMiUs00x3NM/wIpmo2tLByNS0U4aXCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5x6g33esgMXFJxN4zX8VExoj3AQyK9hK4X2ZD5fiiW6nJ54HE
	6SYmova1TrsLgUyUWZTAZ+UtUqkRCtb5qSXRAwnbvn7Y6MSwwbdD/MaCahNrHsliOWLeePJtKeS
	+z/xGuRSesbK5KWtyYBr+cXhi9VhN4lRHB0tM
X-Gm-Gg: ASbGncsNJL1NHz5stySV4Ym+HhXlM4Hhj0VUuP0c9xJVJdCouAJMcJqt+ME8G1wyAdd
	vg2uTh2oAdk1AQJ3sL9tUTJef1tBNeG9A4I1P5Xq0myz1BkNDCVrfub3RB8gQVrr1ygl06T1X/6
	CDSMXlodM=
X-Google-Smtp-Source: AGHT+IF7PPzw9XcMzPgLGpS7L2yRjtVaj+8b437HR+N/kpecVcMii6hLGNH3rtRgLFLnrd2gUYIVZgktNFtVKAFAVsU=
X-Received: by 2002:a05:622a:120f:b0:472:744:e271 with SMTP id
 d75a77b69052e-47233587224mr4504221cf.24.1740361391878; Sun, 23 Feb 2025
 17:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
 <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com> <CAJuCfpEq8P4cz7HXaRVqaagONPBKrFgOSqdigEYU60sGAE4-rg@mail.gmail.com>
In-Reply-To: <CAJuCfpEq8P4cz7HXaRVqaagONPBKrFgOSqdigEYU60sGAE4-rg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 23 Feb 2025 17:43:00 -0800
X-Gm-Features: AWEUYZmBheVTFZ7LsU1XyyiDk7lQ-8DjR4Kpy3qUz4phiAg_D9I2iBy4_sFiFc8
Message-ID: <CAJuCfpEQb=ZmTcAvCMNZrD+-r1hkPfqfw-VvDR_X2a5wm=K_ew@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 5:36=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sat, Feb 22, 2025 at 8:44=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Sat, Feb 22, 2025 at 4:19=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Fri, Feb 14, 2025 at 05:27:36PM +0100, Vlastimil Babka wrote:
> > > > - Cheaper fast paths. For allocations, instead of local double cmpx=
chg,
> > > >   after Patch 5 it's preempt_disable() and no atomic operations. Sa=
me for
> > > >   freeing, which is normally a local double cmpxchg only for a shor=
t
> > > >   term allocations (so the same slab is still active on the same cp=
u when
> > > >   freeing the object) and a more costly locked double cmpxchg other=
wise.
> > > >   The downside is the lack of NUMA locality guarantees for the allo=
cated
> > > >   objects.
> > >
> > > Is that really cheaper than a local non locked double cmpxchg?
> >
> > Don't know about this particular part but testing sheaves with maple
> > node cache and stress testing mmap/munmap syscalls shows performance
> > benefits as long as there is some delay to let kfree_rcu() do its job.
> > I'm still gathering results and will most likely post them tomorrow.
>
> Here are the promised test results:
>
> First I ran an Android app cycle test comparing the baseline against shea=
ves
> used for maple tree nodes (as this patchset implements). I registered abo=
ut
> 3% improvement in app launch times, indicating improvement in mmap syscal=
l
> performance.
> Next I ran an mmap stress test which maps 5 1-page readable file-backed
> areas, faults them in and finally unmaps them, timing mmap syscalls.

I forgot to mention that I also added a 500us delay after each cycle
described above to give kfree_rcu() a chance to run.

> Repeats that 200000 cycles and reports the total time. Average of 10 such
> runs is used as the final result.
> 3 configurations were tested:
>
> 1. Sheaves used for maple tree nodes only (this patchset).
>
> 2. Sheaves used for maple tree nodes with vm_lock to vm_refcnt conversion=
 [1].
> This patchset avoids allocating additional vm_lock structure on each mmap
> syscall and uses TYPESAFE_BY_RCU for vm_area_struct cache.
>
> 3. Sheaves used for maple tree nodes and for vm_area_struct cache with vm=
_lock
> to vm_refcnt conversion [1]. For the vm_area_struct cache I had to replac=
e
> TYPESAFE_BY_RCU with sheaves, as we can't use both for the same cache.
>
> The values represent the total time it took to perform mmap syscalls, les=
s is
> better.
>
> (1)                  baseline       control
> Little core       7.58327       6.614939 (-12.77%)
> Medium core  2.125315     1.428702 (-32.78%)
> Big core          0.514673     0.422948 (-17.82%)
>
> (2)                  baseline      control
> Little core       7.58327       5.141478 (-32.20%)
> Medium core  2.125315     0.427692 (-79.88%)
> Big core          0.514673    0.046642 (-90.94%)
>
> (3)                   baseline      control
> Little core        7.58327      4.779624 (-36.97%)
> Medium core   2.125315    0.450368 (-78.81%)
> Big core           0.514673    0.037776 (-92.66%)
>
> Results in (3) vs (2) indicate that using sheaves for vm_area_struct
> yields slightly better averages and I noticed that this was mostly due
> to sheaves results missing occasional spikes that worsened
> TYPESAFE_BY_RCU averages (the results seemed more stable with
> sheaves).
>
> [1] https://lore.kernel.org/all/20250213224655.1680278-1-surenb@google.co=
m/
>
> >
> > >
> > > Especially if you now have to use pushf/popf...
> > >
> > > > - kfree_rcu() batching and recycling. kfree_rcu() will put objects =
to a
> > > >   separate percpu sheaf and only submit the whole sheaf to call_rcu=
()
> > > >   when full. After the grace period, the sheaf can be used for
> > > >   allocations, which is more efficient than freeing and reallocatin=
g
> > > >   individual slab objects (even with the batching done by kfree_rcu=
()
> > > >   implementation itself). In case only some cpus are allowed to han=
dle rcu
> > > >   callbacks, the sheaf can still be made available to other cpus on=
 the
> > > >   same node via the shared barn. The maple_node cache uses kfree_rc=
u() and
> > > >   thus can benefit from this.
> > >
> > > Have you looked at fs/bcachefs/rcu_pending.c?

