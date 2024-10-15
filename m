Return-Path: <linux-kernel+bounces-364994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5EA99DC07
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C7A1C21A65
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF3315539A;
	Tue, 15 Oct 2024 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2LDSNvE+"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E314F9FF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957804; cv=none; b=PLB9P4rBaOjSLS/+ZbIzcmwy2b56nFuxccq4b3UO62jrzlDRIdQGz5dxW0bPy86UmNqt/5h4ztCC2z0fD0Pfl5EOeIBVvBibH8dCetYoKu4eZu1tL9O8WHjr76Ajt2IQU8wD7FcCM9vahqTGs+WVnfwtr2FcJMFKGfBG4L3hWMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957804; c=relaxed/simple;
	bh=5wTsSQ/ZteQC0fqm4XIkBYQrO+1DuCu5F5z48nco1wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRDbvaT8qJ6QQCedW3kvHLo3iUHsV9CPRJaRI816xWvgG7KwrLv3OrKDq3SSWHSxPBOYY+/5lH9tEoq5O46gJKbWVv2vr1jWxsX+KPXuT8pv5JyXzx8+WHNpZ0ka+xpd0zFoTnEUFdeE8ya+iyDv28NxPuqK9VGmOcLX7vONbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2LDSNvE+; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3b3f4b599so1085655ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728957802; x=1729562602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rzz1jGRp9QodkmkWLX5NeHSpM63VF3iwIHkCWIBMD0=;
        b=2LDSNvE+tDhB1MpiXj6rAVJ7L/+qkAhpDxz4WenNerU0p81/GOoVjsyXZhJlVQAxw7
         2pyK0FNxfXHjMTxFY/gT/006uH0St7DNitpTmoEw2glt8PKoWmUFgr4W60F4H7lhTfQ5
         vpCH2hBy7GQVOfWOEHXeeuLVrRgw2qEKvWDxq5J/VKfcYIa7FGvvKi8DRrNiR4YjIRhc
         xyaqN/LjeHdPoteOP4ee5B0f3PqurbOe10+Su4Yb6TylbiY9zpZVxvDyQ7U1iPjk9UF3
         FC7GVUjQdXdNGiVnsmN6zyqGcHMSrHgD+uglf3fNwlOWuFSNPdSVpAiQuHY2hvU2Cysh
         hoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728957802; x=1729562602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rzz1jGRp9QodkmkWLX5NeHSpM63VF3iwIHkCWIBMD0=;
        b=Ek51kP4McWZmcFEd4mFVSMubLhrHZ5sfby6SJc4VZ4llz0SLpmhRU8XrVA1ttKM+GY
         Q4ZpuqUhTgWgzOj9sh5Go3A/xP4xofEynDliu94j1LJpj/8oX1sB8t+JdfMsGT6Tvytz
         X8RkgEju4vcEOBoTGA+UxBjycxBy+S1eDf578Bc20rHsMrwhWgKZwrVvT1Aowt1AeP9F
         EGMIAkDpzOODNEGoiICBwmw+IoKo7OPKLDiKobraTQuQuzPNZWx0l2syoElUiz5Qkf4q
         aQzreF8zUKuJiq0QSgU5h7QK5fL8ZMXgMF2mahytr8zietiv/73qqD4h7fC6Wp6rO6OX
         FXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHor0jgF0S62bNAH6vMsq3tIglyaLXnI4enEb8Eyl4OG9X1ZjrvKhS5jqtF04IncgVXfAFzpyUlJpLEds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhrtiyO5V4ncboHaKVQ5AICUz+1DSn3KKEZyHdcZTe5dSd3DcK
	cftk+cmVJpTN5slanSuRhExgG5iJvyWDhKp3XODmH24hTD/f+/gpxH3VKAS/MXFU+4yZn2kT7y0
	v6LvlFI8t8LW1HEoFkhfO+1tP4KhA9nsFT3Oe
X-Google-Smtp-Source: AGHT+IFHRKUmX7WPQa7TLc3Eciew7PeeIWsTXjQyYb43yIoNadPTvoEyJAZLfxlGaMHaRWROX46C4pFUHE3PQcVkQ5U=
X-Received: by 2002:a05:6e02:1445:b0:3a0:44d1:dca4 with SMTP id
 e9e14a558f8ab-3a3bd2b62c4mr13456695ab.6.1728957802071; Mon, 14 Oct 2024
 19:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-6-surenb@google.com>
 <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
 <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com> <CAJD7tkY8LKVGN5QNy9q2UkRLnoOEd7Wcu_fKtxKqV7SN43QgrA@mail.gmail.com>
 <ba888da6-cd45-41b6-9d97-8292474d3ce6@nvidia.com> <Zw3H_7mlrqxRwz_H@casper.infradead.org>
In-Reply-To: <Zw3H_7mlrqxRwz_H@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 14 Oct 2024 19:03:10 -0700
Message-ID: <CAJuCfpGT8_t04Va94bZj2dBo8EhbX2rvVCdN6Jokfk1rjedV_Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Yosry Ahmed <yosryahmed@google.com>, 
	akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, 
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:40=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Oct 14, 2024 at 05:03:32PM -0700, John Hubbard wrote:
> > > > Or better yet, *always* fall back to page_ext, thus leaving the
> > > > scarce and valuable page flags available for other features?
> > > >
> > > > Sorry Suren, to keep coming back to this suggestion, I know
> > > > I'm driving you crazy here! But I just keep thinking it through
> > > > and failing to see why this feature deserves to consume so
> > > > many page flags.
> > >
> > > I think we already always use page_ext today. My understanding is tha=
t
> > > the purpose of this series is to give the option to avoid using
> > > page_ext if there are enough unused page flags anyway, which reduces
> > > memory waste and improves performance.
> > >
> > > My question is just why not have that be the default behavior with a
> > > config option, use page flags if there are enough unused bits,
> > > otherwise use page_ext.
> >
> > I agree that if you're going to implement this feature at all, then
> > keying off of CONFIG_MEM_ALLOC_PROFILING seems sufficient, and no
> > need to add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS on top of that.
>
> Maybe the right idea is to use all the bits which are unused in this
> configuration for the first N callsites, then use page_ext for all the
> ones larger than N.  It doesn't save any memory, but it does have the
> performance improvement.

Thanks for the idea! This would be more complicated and likely would
require additional branching instructions in the allocation path. I'll
think more about details but would prefer to get the simple solution
first before adding more complexity.

