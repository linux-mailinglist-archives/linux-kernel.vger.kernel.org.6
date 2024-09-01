Return-Path: <linux-kernel+bounces-310419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E86967C81
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 00:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0171C21137
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B177B185B4A;
	Sun,  1 Sep 2024 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5HoYQvS"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9C61FCF
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725228819; cv=none; b=qT2FAmpBdfOLzbLMlzTOG6LyN3M6wp39dPJjMHl80HSfqbBQ9eP1lfI+cFGI4sd9kOPOxAqN8Wtf6JHvWQbaK1rwyZSDnpOmRCNYPGqa9nVTtFF4wah4HjdtztHhYHFHmOHL22BMcnA31r3ETxhon4/HERl4QS9FSSg0CGPPtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725228819; c=relaxed/simple;
	bh=uu05Fo9Mc9YyfS0pauXPeDLboNox95mhvm+3wRYnh/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/LXYY4IPqDJz57kKtZUy0NKTGj6ZffJ3h7JHh2MVplArdt1QUDTRO6RErTOrgg3RJhtZ1TZJMe6iMeZsemREXTATJtXzGbaf/ik23yn/+lZd4cqSWidIVxBxByc4Di6c3XImRdiBPDLz2277ma3EX1mYqtOH/UpJofDUjIOXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5HoYQvS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b6so3375691a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725228815; x=1725833615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uu05Fo9Mc9YyfS0pauXPeDLboNox95mhvm+3wRYnh/M=;
        b=L5HoYQvSSlimahe5nDdKY+OsMeQdTe8XPAvdvaR5HPIiB/HeX8TSTeqmdY5/RvAMzh
         VKW2gn2XX+x/GUnCrKA2hfOa36u5wJlp/qE13DRWHegejgCMbDKF3RoKpd+LRcIrHalN
         p5Vq2JqHRyq6ZrHe4QAL/lCjv9gYJsKbQX8IwVLmQg0jpyhXDLxhVVQhFetxc1CIljJB
         qj6nb4iUtgKT7x8eWtlOHVXlc1l/6QAvYitbAOxKCKakk5boThWkL/0BuoXHu/jx7lQA
         FrMzBmge9ZLr8irQMNjFsI6gkddDQRt/gJvnrOtMCuMIUgsmskmSmFAZQPHJSSk6AK46
         8mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725228815; x=1725833615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uu05Fo9Mc9YyfS0pauXPeDLboNox95mhvm+3wRYnh/M=;
        b=QsZTIDT9o0+S/pvuPFofA47Nzi57UnqGP0U6QpAetGEBOqT2twJ4Q+on+PIlRZU9fS
         nrupMt+6/2P1J695z/ndnWZMs0bYpLXCpLONrVUbSl0oDPqQAAHZX+40y7rTLSmWTBQr
         +nC3LfOhdYIFyUn8zs3EoHe1+yK7AeKICjzauzWFg3zYz+601H5TBybPyytaCpIZbVLa
         M1nvi/rGLP6o2q+2Z2mEXG/bnKuGAlOIfbGwd7eU8uor3AljsbHZ5C3v5o8j0El2Hk3U
         8jw84c45R4IWXm8jK6vROj+OC11LTKfRJRsqufDZL/z3qVPr6E7sLq+Lhf4BlpzbhQcL
         9mQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnlG7KqqNO6HjwALaBDYn4iAQzLIzeCDlzJdhSvGUbBaYYWNnLdKmrnAssF3JM+hUtLs7F+tuJlYpS1cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFX+Gu4myix22TyygyggPaglQIL2B2HhfiTp9CWraiasjqDsq9
	C8EbuJ0BjPJeYKAPVWOYXemduIX3dPsj+CYYY11CFh5nYIr6KpCkuQmtDqZqfEc1mmuNSEGXSHA
	NKqwH/yaDc+hJlsd7Ht7bkexb9KQ=
X-Google-Smtp-Source: AGHT+IFMdVXB5CtReViBHo6ZhW/u0gI00NEcTW4LRdI2PTBS9Mb/sIzLvXxJSyV4w9+NPYGKmPmEWrB7UW/pabnX7Ng=
X-Received: by 2002:a05:6402:2550:b0:5be:da7c:6176 with SMTP id
 4fb4d7f45d1cf-5c21ed3dfd7mr8870092a12.10.1725228814579; Sun, 01 Sep 2024
 15:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzX71UKndfu8JECMOzc9kf4s4pp9cWTMWwE476cQXt_Yw@mail.gmail.com>
 <CAHk-=wijFJM9MHvwGSS4ADs8ncRagrXYi2E9SvhK8coMH32D7A@mail.gmail.com>
In-Reply-To: <CAHk-=wijFJM9MHvwGSS4ADs8ncRagrXYi2E9SvhK8coMH32D7A@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 2 Sep 2024 08:13:13 +1000
Message-ID: <CAPM=9txF4+rC_CXQTftPctUd0N37t306YKcV3oKPjz+_zQGqag@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.11-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
	lingshan.zhu@amd.com, "Koenig, Christian" <Christian.Koenig@amd.com>, 
	Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 12:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 30 Aug 2024 at 14:08, Dave Airlie <airlied@gmail.com> wrote:
> >
> > The TTM revert is due to some stuttering graphical apps probably due
> > to longer stalls while prefaulting.
>
> Yeah, trying to pre-fault a PMD worth of pages in one go is just crazy talk.
>
> Now, if it was PMD-aligned and you faulted in a single PMD, that would
> be different. But just doing prn_insert_page() in a loop is insane.
>
> The code doesn't even stop when it hits a page that already existed,
> and it keeps locking and unlocking the last-level page table over and
> over again.
>
> Honestly, that code is questionable even for the *small* value, much
> less the "a PMD size" case.
>
> Now, if you have an array of 'struct page *", you can use
> vm_insert_pages(), and that's reasonably efficient.
>
> And if you have a *contiguous* are of pfns, you can use remap_pfn_range().
>
> But that "insert one pfn at a time" that the drm layer does is
> complete garbage. You're not speeding anything up, you're just digging
> deeper.

I wonder if there is functionality that could be provided in a common
helper, by the mm layers, or if there would be too many locking
interactions to make it sane,

It seems too fraught with danger for drivers or subsystems to be just
doing this in the simplest way that isn't actually that smart.

Dave.

