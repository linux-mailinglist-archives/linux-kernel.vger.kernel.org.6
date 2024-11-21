Return-Path: <linux-kernel+bounces-417251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FA29D5146
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB81B2B60D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3618B198A3F;
	Thu, 21 Nov 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H69m0zDy"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777E10A3E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208735; cv=none; b=R+fmILPx0RPryvlUMyMi1yONStHLDvphParL4etTDYRfbfRrFPjzQT2nsFvKasyDkqA+224+K11aX/sqHfQxrhpxsjU85emAJYwmF8GKt7Je1oqUwQIa+tbQo01KpozWtI4QFcDq7SLwEFXwRuNviydR45u80mjS0eEJ861SSaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208735; c=relaxed/simple;
	bh=CbaenAERdzcCNRG1oChBWu9T6RdVY5QgrQue3cb2CBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZPlYA4zW3iYzA+ZyWQcWGy61XK5QLKJm/yoitYbZFx+yu4GgcffXHgHTxToHmZZ8yP8RKU2sSt+GA/JF2F18newB7oPfupK9T/usKvP4GnaM6ycImt/PWevhX3SmHxnXaaE0Yta7Jx7PXoIw8qiruMnC/vxJ+pXUwBJf4iLOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H69m0zDy; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460969c49f2so345651cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732208733; x=1732813533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbzeelOTslR/KHrOgwW0t93Zwe+09I3fmH31n/QNlAQ=;
        b=H69m0zDyUKmfNutXbdGIMgnbwAqgFkxSMG0GX+wgG1zWhSD+uvNG96debh34q29zmJ
         +HDNZnMqxltDyNUiLwEZUswOyFViOJECZjI2lHgOkMom5j31jJposAJqkXIFS59KTSxp
         SCJksGHvyqwAJC3rzA+5fJ6KCXKf9gGpn/eJ/p4ufuYLsm1MB8wPS0/h/wsaHTBjOtgX
         QES9eBqDX7F699OizeaYf8PAmUtJPY2UiidG7Bx2PiXulszHItc75lwZx59U9i67D3Tw
         5p0ZS070wNlvsf1XN5renfXEBhcmFUOh2+gyv0iRysijWh/2QXJ/bd9s8qjDwGV6trID
         Yycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732208733; x=1732813533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbzeelOTslR/KHrOgwW0t93Zwe+09I3fmH31n/QNlAQ=;
        b=lj7+q9dzrlo8Tx7Bl9CZjX5EF7oZVUyHKlVP3CqHo81vfA/YV5dUhhshIL1L9fch4i
         AmUq5yz60FdPTrvaneslKeOjqQvkdbIP5rWmqp+bH46nVHDaLf/5S75eXcLAa6ZR6KP4
         QPldXqtz5GBu07PepYQGtPaw0nMGj8HS9ziSigXh38wt4Ohbyd8pt8kfGu0VYfDahLkM
         495dcLw3BHAv3WMqMYxNR7LwHklP3/ctUJPJXUMZEOzI8YwoFFdXDeMkO11JkWpg10Ax
         3ZRJjJTXWaQrDHKcy+01FJDIkv2M+v2szF7geThlwtmAbUtEed/hlsGTSngIPWo8zyYc
         549A==
X-Forwarded-Encrypted: i=1; AJvYcCUZePOPq+liy/Z+w4gRvlZV4Scdd5Mk1UzDVgQ+ZOI/5hmbTq+0Ocw9HccA7dQOCypLMyWx5JgjuDN7xao=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl7chAjrP2/RoLLDKGs5+rNsBKjsT8z39xsR4VMz1pwPzEKo0g
	OXVs/Gyj+jA8q/0+jBhPSidyjwPwDXmyC/R5+yoJY2hzauEPQsI0Yphp4cp+I2gtrBfk559L5Th
	hSGLevEB9XjDGS03S/S2EAVE1VcIIYxfMaUpA
X-Gm-Gg: ASbGncuG42iqdDnOnLTla6P6pbkYYnkH/E0wZHq0FPqfEBkE2LE1wWJnzllzGUBThOt
	PrxrAOhtShwssmqhX59JTVlw5yEL8wlkSj4AqBSABzFdshrW4ifsAPACKPEFg
X-Google-Smtp-Source: AGHT+IEmxC31siYh0URWSvBOXH/D6mpJAtcWIEuMEukulOsxIf+33rCEYQo9mERxz5BBpt3yaGO4a9w2aMpXBv0P0VU=
X-Received: by 2002:a05:622a:30b:b0:461:6832:8805 with SMTP id
 d75a77b69052e-4653bcdcf41mr342011cf.12.1732208732479; Thu, 21 Nov 2024
 09:05:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120000826.335387-1-surenb@google.com> <20241120000826.335387-3-surenb@google.com>
 <zfd7xdkr5dkvvx3caqao3oorh2pxxifhdhwsw2iyxcuzbevo3n@sobu7xhw24vv>
 <CAJuCfpFAh-gw_BVCaEB4+saedVC6aPB7HfyPikvTujyGRLXPwQ@mail.gmail.com>
 <wnwfgk32wyvx7tzd522ajwk5uixls7iayksrtho6c3dkvgdpek@25yqv3ohljzc>
 <CAJuCfpGx6LCd7qCOsLc6hm-qMGtyM3ceitYbRdx1yKPHFHT-jQ@mail.gmail.com> <iw34akksaz6wjlygwuztlkvto3aiduekrhw6rjlqq4lr7vzmug@tprkddvgrj3e>
In-Reply-To: <iw34akksaz6wjlygwuztlkvto3aiduekrhw6rjlqq4lr7vzmug@tprkddvgrj3e>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Nov 2024 09:05:21 -0800
Message-ID: <CAJuCfpHVQyVGR9sPtKLYt4a7rQUUopX0cBfk53=3RqpYK4=V8w@mail.gmail.com>
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

On Wed, Nov 20, 2024 at 11:02=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Wed, Nov 20, 2024 at 04:33:37PM -0800, Suren Baghdasaryan wrote:
> [...]
> > > > >
> > > > > Do we just want 'struct vm_area_struct' to be cacheline aligned o=
r do we
> > > > > want 'struct vma_lock vm_lock' to be on a separate cacheline as w=
ell?
> > > >
> > > > We want both to minimize cacheline sharing.
> > > >
> > >
> > > For later, you will need to add a pad after vm_lock as well, so any
> > > future addition will not share the cacheline with vm_lock. I would do
> > > something like below. This is a nit and can be done later.
> > >
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 7654c766cbe2..5cc4fff163a0 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -751,10 +751,12 @@ struct vm_area_struct {
> > >  #endif
> > >         struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> > >  #ifdef CONFIG_PER_VMA_LOCK
> > > +       CACHELINE_PADDING(__pad1__);
> > >         /* Unstable RCU readers are allowed to read this. */
> > > -       struct vma_lock vm_lock ____cacheline_aligned_in_smp;
> > > +       struct vma_lock vm_lock;
> > > +       CACHELINE_PADDING(__pad2__);
> > >  #endif
> > > -} __randomize_layout;
> > > +} __randomize_layout ____cacheline_aligned_in_smp;
> >
> > I thought SLAB_HWCACHE_ALIGN for vm_area_cachep added in this patch
> > would have the same result, no?
> >
>
> SLAB_HWCACHE_ALIGN is more about the slub allocator allocating cache
> aligned memory. It does not say anything about the internals of the
> struct for which the kmem_cache is being created. The
> ____cacheline_aligned_in_smp tag in your patch made sure that the field
> vm_lock will be put in a new cacheline and there can be a hole between
> vm_lock and the previous field if the previous field is not ending at
> the cacheline boundary. Please note that if you add a new field after
> vm_lock (without cacheline alignment tag), it will be on the same
> cacheline as vm_lock. So, your code is achieving the vm_lock on its own
> cacheline goal but vm_lock being the only field on that cacheline is not
> being achieved.

Sorry, I should have been more clear. It's ok if some fields which are
rarely accessed in the pagefault path are placed in the same cacheling
with vm_lock. In fact I've done that to pack them better in the
previous version of this patchset here:
https://lore.kernel.org/all/20241111205506.3404479-5-surenb@google.com/
(removed for now based on the feedback). So, vm_lock being the only
field on the cacheline is not my goal. After this patchset I'm
planning to try packing the members better and save some memory.

>

