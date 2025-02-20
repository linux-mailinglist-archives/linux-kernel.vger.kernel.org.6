Return-Path: <linux-kernel+bounces-524663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE5A3E593
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F8619C5011
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E892641D4;
	Thu, 20 Feb 2025 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zA7e5Idv"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E414214218
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081957; cv=none; b=Tdxd7pDR8Uyy2JTqCqVVKxZucia+S3yVGQAY84P5hXmFwBjoLyMh5AG83aZmoTTpAZyJWE4dgGsyI2O7JCsCoVMLucTcDEpttfnXwzRPMtO8wm+N1yJ5xN2ITSZk6jTMY90OUxBKox9PFK7BeOjZFyuHyFEy1F/zrJOtgqYyhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081957; c=relaxed/simple;
	bh=IJow1z7dhxz8U07mAsnZNtj71/6KBe7c5qMG6/IG0RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rB9cAAgOLPqdQt3f+56DCHsjM97OSOu34/AZ6cFv4nvNVEzjyJa1pvG4ctZUSwZ0fECyx0Xg0eexznX7bQyR6clUx7+9pAOc5MZyQZXXIkJEzFyEp2IpA5A2IwYqMf8Y9xG36NTjurHIISaVZW6/6PAv27tZd5+5TcTm9L0ovW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zA7e5Idv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471fbfe8b89so78581cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740081954; x=1740686754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNja6bf2CBLil5N3vi6N4tMwJOKIzlMCtRpPJd2q9CY=;
        b=zA7e5Idv7Zglowpdh9Y/q7K/rZX4AxKBeN33SbYU0cT6fzN0hjffWa66uYznuAuToH
         sLMPtz7S0Bmq9sq7wXHzeAat5a1+9UXgPYPcU4lPmWzdIHwX0TbH2/6SbzdXlhJkkEYw
         Sp0nhec1+KANBPSZwffbKDstnRWt/SgDhsenUnXusFqlbOcYL+45/rStOxJzS+gydE45
         tuxNN0rBLs/8R1w8faEDYS/222ksFh5nZN6UbeB/gYOiCnG+CqIw9CyIUxlM2PIFFNyQ
         d+wG+u5U/Fc0L+XrjDMBg3mh8hHZxdkBVYvd9URljqjRQBB2KgTt61kk1mnQ9w0B/Wmn
         Dq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081954; x=1740686754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNja6bf2CBLil5N3vi6N4tMwJOKIzlMCtRpPJd2q9CY=;
        b=ACfH8FN0mDLkvKVT8iQVJ9djcyuyoeNjEuIHWTvw3BJHURduHur0Bcfd/ijwYKfBoN
         FsWpGPL4IY8Qqjy2YESE0O2cGucalOEkfRx2LCDha8JNpU7j7nCSuG24ZskDJ4HR/hS9
         sWvHUsimllv2qex0TzpnMjUJ1KlrS1rZqYUYrHge6za5qYbBkWDNKxIMaLNLYV4JI7DM
         Ije2HMNQ9JtR9fvOey1iy7JfifnM7u29RMKVUG/R2m3kBPtQVhgofNDkoUt+K55zPf4l
         aQ/0vftyMsgmb+T5FqjYkwGPDB+DlYV77c0RAWapiJOfhvTK5n2RdSjSgMP2Qr13wW5X
         Tv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUS0HQwENHTDJohqBvkNjk6dF6Jo1JvM3R7CTypjv4e6i8Pd6+elTS92fns6KrP45V1C3MR3/gAgYw+xbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUKye4rtT/fitpK8FxRn9zs2WeIBQf0ifcBDg2tdKUX3rzZZ7
	7ySyQY8ZgGB+qI3pg2ywDWsIaBClLL1cYqO1FMWjCqdasEW0UjeOwRK7O52O9tbvq9b82+BNUCo
	x8r2diKvOP5hVbbjj34HPVC2k+uGNtNzjXUGO
X-Gm-Gg: ASbGnctuADxCnw/RCYmvNb7cGBTi0dTs4yV/7Z1D35Gk9LpAoQhvmrPxAVgMpZE/7lR
	UE36T9M+ztxu9D3B0L1WqcduhEPdnma09VAwbPNdK+4iFBdqXUOoMO4PxsN9KATbXi2T/yNT+t2
	khLhXCR8OS5tOHgdc+mBOzjux2QHQ=
X-Google-Smtp-Source: AGHT+IHpz6m4G/n59ZlD8R9nrH67RBcmMemJBj92EGjiGmRxgpyfygUckCwhV73JoH60FmYTGhx1XKBybLiRY1/9bnM=
X-Received: by 2002:a05:622a:254:b0:471:eab0:ef21 with SMTP id
 d75a77b69052e-47223afbfb2mr371871cf.13.1740081954006; Thu, 20 Feb 2025
 12:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com> <20250213224655.1680278-13-surenb@google.com>
 <20250220185304.8313A7d-hca@linux.ibm.com> <CAJuCfpFPaVY1EHus1p0SY1=hpiGogdPCkgtft7fNZ4gPPj2TGA@mail.gmail.com>
In-Reply-To: <CAJuCfpFPaVY1EHus1p0SY1=hpiGogdPCkgtft7fNZ4gPPj2TGA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 20 Feb 2025 12:05:42 -0800
X-Gm-Features: AWEUYZlbD-smqwGs3rLt0rUzzc_SeICGoC9WORx4H6WlodkEvgawJox22U4G20I
Message-ID: <CAJuCfpGc+Q=rabcTZoxOj9YSZJnR7GzaTNa-PL-G-3hdO+SmjA@mail.gmail.com>
Subject: Re: [PATCH v10 12/18] mm: replace vm_lock and detached flag with a
 reference count
To: Heiko Carstens <hca@linux.ibm.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, willy@infradead.org, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	david.laight.linux@gmail.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, lokeshgidra@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, klarasmodin@gmail.com, richard.weiyang@gmail.com, 
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:03=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Feb 20, 2025 at 10:53=E2=80=AFAM Heiko Carstens <hca@linux.ibm.co=
m> wrote:
> >
> > On Thu, Feb 13, 2025 at 02:46:49PM -0800, Suren Baghdasaryan wrote:
> > ...
> > > While this vm_lock replacement does not yet result in a smaller
> > > vm_area_struct (it stays at 256 bytes due to cacheline alignment), it
> > > allows for further size optimization by structure member regrouping
> > > to bring the size of vm_area_struct below 192 bytes.
> > >
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > > Changes since v9 [1]:
> > > - Use __refcount_inc_not_zero_limited_acquire() in vma_start_read(),
> > > per Hillf Danton
> > > - Refactor vma_assert_locked() to avoid vm_refcnt read when CONFIG_DE=
BUG_VM=3Dn,
> > > per Mateusz Guzik
> > > - Update changelog, per Wei Yang
> > > - Change vma_start_read() to return EAGAIN if vma got isolated and ch=
anged
> > > lock_vma_under_rcu() back to detect this condition, per Wei Yang
> > > - Change VM_BUG_ON_VMA() to WARN_ON_ONCE() when checking vma detached=
 state,
> > > per Lorenzo Stoakes
> > > - Remove Vlastimil's Reviewed-by since code is changed
> >
> > This causes crashes (NULL pointer deref) with linux-next when running
> > the ltp test suite; mtest06 (mmap1) test case.
> >
> > The bug seems to be quite obvious:
> >
> > > @@ -6424,15 +6492,18 @@ struct vm_area_struct *lock_vma_under_rcu(str=
uct mm_struct *mm,
> > >       if (!vma)
> > >               goto inval;
> > >
> > > -     if (!vma_start_read(vma))
> > > -             goto inval;
> > > +     vma =3D vma_start_read(vma);
> > > +     if (IS_ERR_OR_NULL(vma)) {
> >             ^^^^^^^^^^^^^^^^^^^
> > > +             /* Check if the VMA got isolated after we found it */
> > > +             if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> > > +                     vma_end_read(vma);
> >                         ^^^^^^^^^^^^^^^^
>
> Doh! Thanks for reporting! I'll post a fix shortly.

The fix is posted at:
https://lore.kernel.org/all/20250220200208.323769-1-surenb@google.com/
Quite embarrassing... I missed removing that extra call. This change
was done only in v10, so never appeared before.

