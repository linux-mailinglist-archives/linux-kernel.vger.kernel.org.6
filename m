Return-Path: <linux-kernel+bounces-199527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EBE8D8823
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AB8288ED9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436B137C33;
	Mon,  3 Jun 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIaFus9/"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABC135A6F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436569; cv=none; b=ok9/4XIT3i1sG2HEDo4TOa1XEr1fgyN3/PheDm3aBYdME5iMMu2RcxTx4qtEO5TCKBNPNnYL7JyboxEK43E9KJtaT2U4erKZeCAxrcZN8/Sxe6yitSnciHz/mOl7atq48LD7sW99TeeB6OzDzRtOGV8EGDtmwKVvSjZv61HBZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436569; c=relaxed/simple;
	bh=rPAoZy6vxBtVU7x0pj3UdhVhA7bFxTF9Tss9xmCjp8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJq3iof6nvE51isYCe+YhusoW7QcsOWaw0r6Qx6zBeDbYC/VRuejgb/OeUOcrK6h7suLBLKKXxqgC2uyq/OffZezzx1sloNx5EajixovmcZE7ohElsts86EXjoLyj1U69E071xG0GIpfWmn4a9OiB7njJnYAxhX7ZdqHS6MrxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oIaFus9/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a2f27090aso5938445a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717436566; x=1718041366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX46hsOnvcHYWQ2/08aJP6HMfOKz/H2iKz5LdOxxIiY=;
        b=oIaFus9/oBerxQMTo6NcQ0OmtrzbzjrX9z6s6pVYRayTVWbyOzBtKMKYikdhUbIHMy
         FouGfFbcoFPRiDM90aN7G5K9zMwgRTir1toWGRZJhiPhGLnWF5vHTzAup2pMCtM+s/lQ
         ZsIU7T+Vo22Vcf2SjHcPRy+4RT0zfXJyDGDxeN+uIfJOMtjGxbi81v7jVQT9NitPLwVs
         475SNAT5R4WXf5pd0UNvBFi92f5iJCKi76ZLEeujm13QGLtyX8BcwahjYi+Xj6qgAuXw
         8lERZebgRkK0rWX4KNFuLB0uF83QOO5W7Wxvp5AoDkvxOhm6pWrQr4hbYlb3D+9eiZK0
         hi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717436566; x=1718041366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cX46hsOnvcHYWQ2/08aJP6HMfOKz/H2iKz5LdOxxIiY=;
        b=MsztaVjyooKk90leWEIlh79MSUB41BnofWYYYfXZrJdeL5RNha0MQk//6iZWelePzm
         TY0kuc8LEbyzTcsPZ+aHLGWer72qZ3y3X0K2VAUlKvkaHk7w/f28Y2fV1XqHSXSYPw/c
         UfVT6Y7bzJuEPEm768DY8DsOYUl9W2PzEsbhfHdSLLG2Rqu9pwIzZOCXLyBwUMLsF6qw
         E2JsiVKAwXfoxQhiiKPA4WgDgXBJeJX0mgL82vhZ4O5H/oWg9L3B/Iug3Ze6/S1W9aU5
         AEKoAaTc3G1hMTGxhk0bW0Rcq7LvIopOb99WuCnBwDk/Gdh6/IghXf5Wy1qyv8oWE/pZ
         jG6g==
X-Forwarded-Encrypted: i=1; AJvYcCVG3moLJM1coDbG4oNge9CoPcLZHl6vTtnV+FhZzyq+5WJn5BzkKhpf4IFQBB4ga1N3rCEqCtjoN53w9YkqACkzQW2ZlvwUh5wbw9mT
X-Gm-Message-State: AOJu0YwQiVOXssv8t930r0OBQSBLOJVN2RzZ3sY1TBkXwH6LhPqpKrjw
	mpXVKJh5quLmZHBgsTEAGLxN1VlbLwKXdlbJvptKlE4yQoU5jhTsP7cb+aaWECIaD1Zv7XGeKOC
	2fnClwjnVe6pafh8i445kq9lI9rzk+yth/mQa
X-Google-Smtp-Source: AGHT+IHi+ZsXWMd56cnJoCCuxUXLuaKUiF6CkEcw+xlGa1Gq7gdbgvhyC/+OuXMSzHHUjT2c42a3lstZlU6g7HMSpZw=
X-Received: by 2002:a17:906:d0d4:b0:a59:be21:3587 with SMTP id
 a640c23a62f3a-a69541453d3mr31147066b.8.1717436565933; Mon, 03 Jun 2024
 10:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGFP0L+BaNAtCF7c7cJ1bvbjomp03Fy0=6=w6dj29Fnr0ygSCA@mail.gmail.com>
 <CAJHvVchjzxLVfg844SNjK9EWmC+yhVneGaf1vVscmjomH_aaow@mail.gmail.com>
In-Reply-To: <CAJHvVchjzxLVfg844SNjK9EWmC+yhVneGaf1vVscmjomH_aaow@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 3 Jun 2024 10:42:07 -0700
Message-ID: <CAJD7tkaV8a-fVv4D_6_5LgmOHnMFXJWy-DwqvRDCTjEqyJkdKA@mail.gmail.com>
Subject: Re: [PATCH] fix: Prevent memory leak by checking for NULL buffer
 before calling css_put()
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Geunsik Lim <geunsik.lim@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@elte.hu>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Hugh Dickins <hughd@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 10:32=E2=80=AFAM Axel Rasmussen <axelrasmussen@googl=
e.com> wrote:
>
> On Mon, Jun 3, 2024 at 5:33=E2=80=AFAM Geunsik Lim <geunsik.lim@gmail.com=
> wrote:
> >
> > This commit addresses a potential memory leak in the
> > `get_mm_memcg_path()` function
> > by explicitly checking if the allocated buffer (`buf`) is NULL before
> > calling the
> > `css_put()` function. The prefix 'css' means abbreviation of cgroup_sub=
sys_state
> >
> > Previously, the code would directly call `css_put()` without checking
> > the value of
> > `buf`, which could lead to a memory leak if the buffer allocation faile=
d.
> > This commit introduces a conditional check to ensure that `css_put()`
> > is only called
> > if `buf` is not NULL.
> >
> > This change enhances the code's robustness and prevents memory leaks, i=
mproving
> > overall system stability.
> >
> > **Specific Changes:**
> >
> > * In the `out_put` label, an `if` statement is added to check
> >   if `buf` is not NULL before calling `css_put()`.
> >
> > **Benefits:**
> >
> > * Prevents potential memory leaks
> > * Enhances code robustness
> > * Improves system stability
> >
> > Signed-off-by: Geunsik Lim <leemgs@gmail.com>
> > Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
> > ---
> >  mm/mmap_lock.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index 1854850b4b89..7314045b0e3b 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -213,7 +213,8 @@ static const char *get_mm_memcg_path(struct mm_stru=
ct *mm)
> >         cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
> >
> >  out_put:
> > -       css_put(&memcg->css);
> > +        if (buf !=3D NULL)
> > +                css_put(&memcg->css);
> >  out:
> >         return buf;
> >  }
>
> I think the existing code is correct, and this change actually
> introduces a memory leak where there was none before.
>
> In the case where get_memcg_path_buf() returns NULL, we *still* need
> to css_put() what we got from get_mem_cgroup_from_mm() before.
>
> NAK, unless I'm missing something.

+1

We already skip css_put() if get_mem_cgroup_from_mm() returns NULL.
Whether or not get_memcg_path_buf() succeeds is irrelevant here.

