Return-Path: <linux-kernel+bounces-449537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F50C9F5084
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA74171251
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E636D1FC0F8;
	Tue, 17 Dec 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9NeR9jW"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F21F76D3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451110; cv=none; b=NPFCGHRVGyvm7EPe+S0W/j+OE1hEkOGUgnYBXKx+0W65bYGsa57aipLc2mvYfCdL8hzVjfDrHn3bXGVfsQ0UQ/tE0EFUY2jFtm4BVAWAqPT4U2gYW+tf1CCPhJMC/wCVhTmErnxI5er4nzPMpCfCKBpt439sWiegIAs82Sj8XeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451110; c=relaxed/simple;
	bh=dBH/+O7g6d06xn0ec8a6KSHrWYZBqAa/QIx306iaTM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sr2IpwWE2GsbFY1tcGU4SZ/uuhz3m/zSu8nMYb4YUQzHAqPNi2CHYSN4KeYv+tc2IgMF70s9pm3JdObshMF4eC2tFghq1Z02U6Ms1XtJOcSwf5NEuS7Ygu1r+e+nDD5MndUlgKfhSbMAJGhuYnfxd6HPeK61eDfoMVDovJvgqYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9NeR9jW; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4678c9310afso260901cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734451106; x=1735055906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbVYvO44lAz7K8MjpLCIdcOgRywKqjJNL2ZPeifyjMs=;
        b=o9NeR9jWFbLpCNIoxkmiukPogdEZ2XuIfq+j/46xSFQia9H6DHMYjpW1GOsYdbsfzr
         1J7sKw/4i/gpfQImHUI3aSHZpBLXdFvmF37MddMAOCza/xITnQwL3ZC/HZN1p3FJMTqs
         OemGFd91XfpAekxBDQlxUDGmZC8UU9pHAmf1qsteVQ8AyqOTJy8e61L3QfxRq0DyVvVt
         ZE5ECIKZSmPnFNOhM74LxvDXciIwxuWNQXMFJt2+Nn0XHi6DgItnxzAxDk7XL9WvluQK
         IIs8z78+KmKRCLrKMO8DlHH+SSMIm2Te723syXP2Om9ayp3DuqSCIPGCcw+vlWq6nl8j
         fTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734451106; x=1735055906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbVYvO44lAz7K8MjpLCIdcOgRywKqjJNL2ZPeifyjMs=;
        b=QtJVcbUfOP/T0/tKGqxs4IHBcDTF9J9sOhvRq60UStJom9PjXz3CHLhfhvXhRcQxt2
         wze3KTsWd2kGxmWg8P4tCDPXsKFDo7g7DxbIrzO4ZPtVP4CvHje/6vNt6kch34hLX3cA
         M1vZzenSxE6QLCoeyiiEfZBkIS+4TJMvDEYBF8uvkQRDlX4pyQooRyPyss6/5SsV8Dsh
         ql74/mDxdhEsleKz3LCWH+JRHRnAkMTcItDRdBw/ZXOkpxdDtM1HHz1QxZ97KomshuZS
         1MlWrKn0b54cyY3VnGIM0AP/NU5oMLizlSbIZ9Bh/9vhwZ/LDdpQlm9IHddkBU45o3X7
         yLkw==
X-Forwarded-Encrypted: i=1; AJvYcCWjuOE2vtTZI5X0ybsz7NcM6X6idO93xtOjJZTaFhjyd37nljk3k/P3NoIXt1nwzt1V3QPemaN5ZHKz1d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMtdeCvPQ6rxPXgGq8Ls75WwT/wwM9c7BVi6WKdXzkiHUtL+c2
	T4BWFgULGSJHOkkyFZ6jTl/hVpToJ5EcI5QWQRAy8ZmJulPbJHUSaX1M03tu7VwuRETETcMzZm/
	8WvOH5Y92dXk2S0vO5JtbX/hKAeh3vW/PkF8G
X-Gm-Gg: ASbGnct5oStu1aZs7X0uyv5pSvecc8PLWhgu35RBEQXlbl0szuTgRCaLUK6WP/Fjo8s
	zNp/JMqCcbIX78sd2IGcdrh2uFdhxBYekd0sDOgwoFGM8nTrEB704zdEQdW0xqzreLZoE
X-Google-Smtp-Source: AGHT+IFoNxbLSivCB8O+mxImiir970GdW7OaKshYzGwkWOn3yHVrguyW7CMWfUXbyO03XcT7Rr+UjXFED1Gcx3L2cUs=
X-Received: by 2002:a05:622a:1115:b0:468:f7e0:ad40 with SMTP id
 d75a77b69052e-468f971ac80mr4409181cf.14.1734451106340; Tue, 17 Dec 2024
 07:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com> <20241216192419.2970941-14-surenb@google.com>
 <20241217102620.GC11133@noisy.programming.kicks-ass.net>
In-Reply-To: <20241217102620.GC11133@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 17 Dec 2024 07:58:15 -0800
Message-ID: <CAJuCfpHMouycE-G7vtph5nu_E92VTMvUdKuoteiqf7Gz0GR0nA@mail.gmail.com>
Subject: Re: [PATCH v6 13/16] mm: introduce vma_ensure_detached()
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 2:26=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Dec 16, 2024 at 11:24:16AM -0800, Suren Baghdasaryan wrote:
> > vma_start_read() can temporarily raise vm_refcnt of a write-locked and
> > detached vma:
> >
> > // vm_refcnt=3D=3D1 (attached)
> > vma_start_write()
> >     vma->vm_lock_seq =3D mm->mm_lock_seq
> >
> >                     vma_start_read()
> >                        vm_refcnt++; // vm_refcnt=3D=3D2
> >
> > vma_mark_detached()
> >     vm_refcnt--; // vm_refcnt=3D=3D1
> >
> > // vma is detached but vm_refcnt!=3D0 temporarily
> >
> >                        if (vma->vm_lock_seq =3D=3D mm->mm_lock_seq)
> >                            vma_refcount_put()
> >                                vm_refcnt--; // vm_refcnt=3D=3D0
> >
> > This is currently not a problem when freeing the vma because RCU grace
> > period should pass before kmem_cache_free(vma) gets called and by that
> > time vma_start_read() should be done and vm_refcnt is 0. However once
> > we introduce possibility of vma reuse before RCU grace period is over,
> > this will become a problem (reused vma might be in non-detached state).
> > Introduce vma_ensure_detached() for the writer to wait for readers unti=
l
> > they exit vma_start_read().
>
> So aside from the lockdep problem (which I think is fixable), the normal
> way to fix the above is to make dec_and_test() do the kmem_cache_free().
>
> Then the last user does the free and everything just works.

I see your point. Let me reply in the other patch where you have more
comments about this.

