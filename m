Return-Path: <linux-kernel+bounces-416425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD51B9D44A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FFF1F222E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290FC1C1F12;
	Wed, 20 Nov 2024 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PocFkz5+"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1101BD9F3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146285; cv=none; b=Qv6uTJEtLmzJ/ko4u4Mb6+L7KQ2ShYkHz4vgH2ZHsMqyYO6r7pVK6wEXi6sWo7bqvgRMoPFSc43ez5vYkWvNhJRTrU7dOpJMusYOPRSWy6D/gvY2XLDmQH9MHgAtfHUDHKedfcnEBPwgz+BbtC6lqrfk1+5TRutQ+tupFB0XYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146285; c=relaxed/simple;
	bh=VYULMpEDAPylKL42wS5fy2eOiSVaq0rxnmEIT0A+0PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLs1ISfWdIsKaOG4MZLn6ucL4/sFrNmByUMwm/gYEwcE6fQrpTuz5dQjSfd+Qp8fXU3LGaX6V50CHtiGmPh6yKLl4ZpZX01O1GlhA1umOcUtg9Eawlp427nFP4vSp9tmdAqkOAZo2PSnjBmyOzOWcH5LG78quAWOP+9dzopA0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PocFkz5+; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4608dddaa35so148161cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732146281; x=1732751081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxlIf7epPu0Gfnfexi0C2Kwjnv8g1AAJhtWmrHEoFGU=;
        b=PocFkz5+DbtHtQhl6X7LgWuMfTW4YsjG4dRxHPmUv8ViG3okYtdZB9R7/WiPaxchna
         Uuvzdv5el4KfFbf7CU87+LsuKfH5FifpyrNKdS9jP2VfkEN0faJ0nlr4u+MUHgXDzE30
         fQH664GKRmjTIMIRQVE6HOqTniT+uVY4uwaXhvaW9X1B3twd28PlUPGVvqBGTPs19F7K
         v/Dxad+C1H7ZGY9dei7AMNfXbON1/GOspskgVHhQwV7VFvsoTQ4cgj2qVRgM2Qyp+wk1
         PjDBGaw1ntFUdlBM5gw+MRIW3muN+tnFs5Jk/1X8THhp+fKSO1WtRERa32lk94KkvCLJ
         CBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732146281; x=1732751081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxlIf7epPu0Gfnfexi0C2Kwjnv8g1AAJhtWmrHEoFGU=;
        b=qzTC68YUXfFbB3vyfZ4mb7u3nTbCLMGIUPFqG+mPi1n5kOtGsyO+ABmkpDnHzJGmvO
         XIpsrfstvkNVGPAAUx09OrBl7K8D1M8mbw7IncGqXBTKvBzX6+EGnZZgZGtyf1vR826P
         gm8krd95W167M7fGSJlR8DKhclEWcB95B7Rz2XyIwh/ilLjUbQcNt5Uhqh0VjIPMTjti
         vEBp4XqdRQZxPBlrF59G4z3q4oYp1JZ3NGNFxNm0o4WpBB0y+xNFNfFsyBr1rz3P7Yke
         FHVwz+70wN4AJrMCSfd2AJ8caICBPbICzn+tmkpAXTlFLRoUtj9cICvLSZDuAorA+p4E
         hgHA==
X-Forwarded-Encrypted: i=1; AJvYcCWfydjdiRnXBua6YR5VAXvqvSQD1iGWtYoxu/bO+6xktQaKGMQzb92KF7PGZS5PgBAVwTff9m6D87/lo78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfF51Ocn5pMZ8/3ogJmoK6taSNM2EIERUVav7uKVSIS3vbOJ7b
	bbUm6GwYxVy8ZXG2MjImOx35TGoSBq2bwfDU6hOmCw9gacDDk+o35hxxpdMvoxuru2d/yHmBI2N
	Ns+8/KW6QENYjIWvvVABz4K3f26Z/haefvC6n
X-Gm-Gg: ASbGncusxsXeKLpk1BiDr6IDXZMiTmqVTImSmu7fDr/mUPKE5VrsPMU0hotOsX/OEa2
	KNB1ONsZYOD2IsLPWze5tDZvnT5k35fs=
X-Google-Smtp-Source: AGHT+IEe3+sA9ZC//JKUWhAcs4Y8+fxRca4+aY14pz1BRAB49A2SGTYA3dnT6lGqw0fmkJDYqZoIMrZMcDmmK2UU1uA=
X-Received: by 2002:ac8:7d0c:0:b0:460:f093:f259 with SMTP id
 d75a77b69052e-465300c93f2mr1217201cf.22.1732146281054; Wed, 20 Nov 2024
 15:44:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120000826.335387-1-surenb@google.com> <20241120000826.335387-3-surenb@google.com>
 <zfd7xdkr5dkvvx3caqao3oorh2pxxifhdhwsw2iyxcuzbevo3n@sobu7xhw24vv>
In-Reply-To: <zfd7xdkr5dkvvx3caqao3oorh2pxxifhdhwsw2iyxcuzbevo3n@sobu7xhw24vv>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 Nov 2024 15:44:29 -0800
Message-ID: <CAJuCfpFAh-gw_BVCaEB4+saedVC6aPB7HfyPikvTujyGRLXPwQ@mail.gmail.com>
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

On Wed, Nov 20, 2024 at 3:33=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Nov 19, 2024 at 04:08:23PM -0800, Suren Baghdasaryan wrote:
> > Back when per-vma locks were introduces, vm_lock was moved out of
> > vm_area_struct in [1] because of the performance regression caused by
> > false cacheline sharing. Recent investigation [2] revealed that the
> > regressions is limited to a rather old Broadwell microarchitecture and
> > even there it can be mitigated by disabling adjacent cacheline
> > prefetching, see [3].
> > Splitting single logical structure into multiple ones leads to more
> > complicated management, extra pointer dereferences and overall less
> > maintainable code. When that split-away part is a lock, it complicates
> > things even further. With no performance benefits, there are no reasons
> > for this split. Merging the vm_lock back into vm_area_struct also allow=
s
> > vm_area_struct to use SLAB_TYPESAFE_BY_RCU later in this patchset.
> > Move vm_lock back into vm_area_struct, aligning it at the cacheline
> > boundary and changing the cache to be cacheline-aligned as well.
> > With kernel compiled using defconfig, this causes VMA memory consumptio=
n
> > to grow from 160 (vm_area_struct) + 40 (vm_lock) bytes to 256 bytes:
> >
> >     slabinfo before:
> >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >      vma_lock         ...     40  102    1 : ...
> >      vm_area_struct   ...    160   51    2 : ...
> >
> >     slabinfo after moving vm_lock:
> >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >      vm_area_struct   ...    256   32    2 : ...
> >
> > Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 page=
s,
> > which is 5.5MB per 100000 VMAs. Note that the size of this structure is
> > dependent on the kernel configuration and typically the original size i=
s
> > higher than 160 bytes. Therefore these calculations are close to the
> > worst case scenario. A more realistic vm_area_struct usage before this
> > change is:
> >
> >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >      vma_lock         ...     40  102    1 : ...
> >      vm_area_struct   ...    176   46    2 : ...
> >
> > Aggregate VMA memory consumption per 1000 VMAs grows from 54 to 64 page=
s,
> > which is 3.9MB per 100000 VMAs.
> > This memory consumption growth can be addressed later by optimizing the
> > vm_lock.
> >
> > [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google=
.com/
> > [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
> > [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT=
_kbfP_pR+-2g@mail.gmail.com/
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks!

>
>
> One question below.
>
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -716,8 +716,6 @@ struct vm_area_struct {
> >        * slowpath.
> >        */
> >       unsigned int vm_lock_seq;
> > -     /* Unstable RCU readers are allowed to read this. */
> > -     struct vma_lock *vm_lock;
> >  #endif
> >
> >       /*
> > @@ -770,6 +768,10 @@ struct vm_area_struct {
> >       struct vma_numab_state *numab_state;    /* NUMA Balancing state *=
/
> >  #endif
> >       struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     /* Unstable RCU readers are allowed to read this. */
> > +     struct vma_lock vm_lock ____cacheline_aligned_in_smp;
> > +#endif
> >  } __randomize_layout;
>
> Do we just want 'struct vm_area_struct' to be cacheline aligned or do we
> want 'struct vma_lock vm_lock' to be on a separate cacheline as well?

We want both to minimize cacheline sharing.

>

