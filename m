Return-Path: <linux-kernel+bounces-443192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644EB9EE89B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81899282E53
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565E52144A8;
	Thu, 12 Dec 2024 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2YIbAKHi"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09029213E92
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013079; cv=none; b=qF+LdMiU1l767/vqI7ksciQBO1QE58ha8LIdpk2ecMefjirUCZR3+BeSkJgUWtUin7hcGNJwQmvNRs7XamTDoZeydkYHFhIoVD/ZgkU6yU3Td9VNa3MVTu9G50um5xxpqYUUeWfp/brujp6nu9DSRjdlZzL/+iHvXIsDqy7n7MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013079; c=relaxed/simple;
	bh=dScFLmD9AVTq3grxDRRLA/tKV3AESoh6N2/4sCF37L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYc75NIO+VKbrALIM3HNQAO+yVI+NnZf8zyIGgRgE2JEcbxpft1A1s1ZLkQvg/8zjZxY5N5eimy6TP9gpCEKn/6zn2cT7IqgxLakYkwSKPs3NiNEiTYf5//GxqQSlJysQDUPrxZnxt/2t7oN1HpYB9Mm9agPEl2zo+TEdWwylQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2YIbAKHi; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467896541e1so219481cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734013077; x=1734617877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8ajthcpMpapR/N161Mc5i8pJmZRr2mxkpMj7Lx+W90=;
        b=2YIbAKHiDX4HN2JjlyB37d0yJx5ArBleovvqJnbtJilmNTQFgCSvxwbfYsSkdgShEO
         sQLLtrVgeTV2xAaVRvatAZ1zgAlZ/x7vl3T36g5UZt5e2zWvkAIOOV8PH6AGq3+lkVsB
         rjLgTMQOrNHSBz1UEgCkij0ivjp4D8QejI1OIYHHGFq46cfKHuEa0uN2icHxXFsp8/ck
         rleeV+V2595RU9AYrvD7XaBO91NY2VzedzdRvP4RRxDaYLsLnX0ca1aSYrUACNbumyTg
         mj4bPfUK+pUQM31sS3DY5K/+0COFHtsGVXbLKV9Xj36QQQEurR1YqeBzlQzEQjgH6TCJ
         kDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734013077; x=1734617877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8ajthcpMpapR/N161Mc5i8pJmZRr2mxkpMj7Lx+W90=;
        b=fzx3IIeg92jSTh20coLyw9XqbIN82kqcWE2fMViB7pinjiYDfmkg6h5nJiC/f/dCmt
         TCx86/YofDe1O7j4Cm5wGqwg9LR1KJ1eThzpSM06JsuIo4OLvbrahTGbE8er0QwwHh40
         lyOeUhNzI8UD+hJ81Fl3HzEM41ckKtokydoWABHIy+Osce4OvEiwBBiCyfOvcfe6F+/g
         NGvFgvB/kicx8Vc3aSIjRSRnwgFff7rhVjzQZrspFojr87NkOdlt79jFRzT/3OBZMrtu
         5AOt73EKUjDlm6CIIDfF2/TBaWqyH9Y9zkw+YskxtiHoIRr7cPCgG/EyQy1j61DPl4Rs
         cn+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQ7v+Di1WZtFF2h/NEdKlOPSQmQ3CKwYNoXzHID5Tl1Fg4cD0dtLih6ec4ENAZ5qPX7u46aMma3sDaDX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9NVym+x//UephoFjPohcH0Z1y7w9KngNS/61zHOXbg3trMJuE
	R4U8XRwWSMZbU+6+rbaUvBVA4E9zJtlys7JmOWLV6v3G6KMzwgwyGdEOIzNgB4yMFWl6j62PWMp
	/uEQOlilJbTu45sg6nDMjZLLdm8v1o6r3nQ5N
X-Gm-Gg: ASbGnctuLvWBR0R33CGo1Iu/GXocjbKUlhmfCwcoY5swJM7LdOEnn8rRvtlDcuBoded
	CtamxQyO1MQHrP8NN2lOoy4mgt/VXNxobD1UQg0n0O9rTX4+f6s2FBS2YCbk72+YTJOnN
X-Google-Smtp-Source: AGHT+IEeu8zH/VnJryYj8++kCkoXsuJ3rlVdOfU959FqW2gNhYySMGPbFs/mLT5AeOlhVMLkO548p4WwPtmHykH53aY=
X-Received: by 2002:a05:622a:428e:b0:467:8070:1573 with SMTP id
 d75a77b69052e-467a103d0b1mr598111cf.20.1734013076622; Thu, 12 Dec 2024
 06:17:56 -0800 (PST)
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
 <CAJuCfpGOOcRAJ46sbPRoCUNuuhi2fnkM97F=CfZ1=_N5ZFUcLw@mail.gmail.com> <20241212091659.GU21636@noisy.programming.kicks-ass.net>
In-Reply-To: <20241212091659.GU21636@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Dec 2024 06:17:44 -0800
Message-ID: <CAJuCfpHKFZ2Q1R1Knh-LFLUYcTX6CJuEsqNM5AwxRyDUAzdcVw@mail.gmail.com>
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

On Thu, Dec 12, 2024 at 1:17=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Dec 11, 2024 at 07:01:16PM -0800, Suren Baghdasaryan wrote:
>
> > > > > I think your proposal should work. Let me try to code it and see =
if
> > > > > something breaks.
> >
> > Ok, I tried it out and things are a bit more complex:
> > 1. We should allow write-locking a detached VMA, IOW vma_start_write()
> > can be called when vm_refcnt is 0.
>
> This sounds dodgy, refcnt being zero basically means the object is dead
> and you shouldn't be touching it no more. Where does this happen and
> why?
>
> Notably, it being 0 means it is no longer in the mas tree and can't be
> found anymore.

It happens when a newly created vma that was not yet attached
(vma->vm_refcnt =3D 0) is write-locked before being added into the vma
tree. For example:
mmap()
  mmap_write_lock()
  vma =3D vm_area_alloc() // vma->vm_refcnt =3D 0 (detached)
  //vma attributes are initialized
  vma_start_write() // write 0x8000 0001 into vma->vm_refcnt
  mas_store_gfp()
  vma_mark_attached()
  mmap_write_lock() // vma_end_write_all()

In this scenario, we write-lock the VMA before adding it into the tree
to prevent readers (pagefaults) from using it until we drop the
mmap_write_lock(). In your proposal, the first thing vma_start_write()
does is add(0x8000'0001) and that will trigger a warning.
For now instead of add(0x8000'0001) I can play this game to avoid the warni=
ng:

if (refcount_inc_not_zero(&vma->vm_refcnt))
    refcount_add(0x80000000, &vma->vm_refcnt);
else
    refcount_set(&vma->vm_refcnt, 0x80000001);

this refcount_set() works because vma with vm_refcnt=3D=3D0 could not be
found by readers. I'm not sure this will still work when we add
TYPESAFE_BY_RCU and introduce vma reuse possibility.

>
> > 2. Adding 0x80000000 saturates refcnt, so I have to use a lower bit
> > 0x40000000 to denote writers.
>
> I'm confused, what? We're talking about atomic_t, right?

I thought you suggested using refcount_t. According to
https://elixir.bootlin.com/linux/v6.13-rc2/source/include/linux/refcount.h#=
L22
valid values would be [0..0x7fff_ffff] and 0x80000000 is outside of
that range. What am I missing?

>
> > 3. Currently vma_mark_attached() can be called on an already attached
> > VMA. With vma->detached being a separate attribute that works fine but
> > when we combine it with the vm_lock things break (extra attach would
> > leak into lock count). I'll see if I can catch all the cases when we
> > do this and clean them up (not call vma_mark_attached() when not
> > necessary).
>
> Right, I hadn't looked at that thing in detail, that sounds like it
> needs a wee cleanup like you suggest.

Yes, I'll embark on that today. Will see how much of a problem that is.

