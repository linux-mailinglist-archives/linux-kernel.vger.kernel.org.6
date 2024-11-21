Return-Path: <linux-kernel+bounces-417219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1979D50C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33177B21CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF352309B4;
	Thu, 21 Nov 2024 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyoFesxE"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15820157476
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206750; cv=none; b=rXyeynlmSyXzTUJ7q4vujIJjHAkI1YkvXUQmjFp8UrfM1EPlgJaS6M3A1QHrEWBJb7aqOWc5Ese6gcd+FeUmvcLP9TtkzAbDRTBoScGy+V1K9dOm9orxAcCb1d46rTFg6yIL/4tw3skAuM1syWcfEdUGsVpoHRT46sK3WXUTZ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206750; c=relaxed/simple;
	bh=0071SProcnj54azKnrgs9O4CTcBQWiKx7fiDtH0v6QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNB53skL7xVpZ7zRA+Tmxib8gVdSsRTrqz087JDv/o0981PyTQUtm9X6BqDqBP/7SwglTD0zi1YOeS8RK53ark5p42NkQGioQp8YsgXVVcl+pE/VYbRY6n8MFz7xnN5xYArxCrwd+X5Y6dWtxrWLQ4FZTZSwk+jE40pSsIkiMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyoFesxE; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460969c49f2so331501cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732206748; x=1732811548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KinxbNGywfMnxHwtq/MrCSYbQ52bStWS5PDW/rvFKDU=;
        b=UyoFesxE9cDB7mn3kizkXDUJUgVZl4iK/Ehl0kua6JRvLUfsVTibYxJKpa+KEjKRme
         b6OKsHSb2We7Ewtih4a5V5KHHX3gzuIlDEPPwdPYe29lfcJHR1MGijV+DSuMWqLeXQTt
         VfN38AyAOUdsidX08ezXwa+UV1FnQAqtyuw1QjBo5XalOg9NpB7CjkFD4fZL/N/bzztm
         KJ5k0toPx5p7VBnCvysRqeUgdAaW+uO3jUgCaDj9fDcGbNOYvMh1IoNKK0FKVYFQOdJB
         yw33w9TyTOtwVQfy5hv3xuMs0KtGHunY1PeIgJ1Cs5El4uNcAuzMh9FLbbBG105VONPI
         gvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732206748; x=1732811548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KinxbNGywfMnxHwtq/MrCSYbQ52bStWS5PDW/rvFKDU=;
        b=uT2zkOCPrAVMEIRuZ+pYyAxMUbNdJ2usdh/brsBkgy/olK1flkJW0PlszE8P6L+G4i
         8JlGMtERANcAzgg1OJm+FEhXTn9i60lYWZLrb4zghCrdeIvQi5x0QRG7GAH2rM4ImTko
         8uLQMYBFe0UmhFIOj+xL6nmQYTnDFWoC39rwbvhE9TaBlyumGevW2F1QUHs092wOj851
         rL1jLzG0i/uUcxYSYs4SIUpHMPhA3OwcxqE9pFeJFxjAM0dku2/uuNKSr97ggqqB4XqM
         opJv6O5FKssNLExjGJ3UFeqvYbL/EBv7TQegK0xEOO66EqtTTc2ZJDQsUIWf8t75+J1O
         lV4g==
X-Forwarded-Encrypted: i=1; AJvYcCVDPustrg+ITFf2aGhDY38G7ETNKzE1UTWPbdL1yu1lzg7xTRI+8I1wclYBb/nraYX0rRWwDIv4iN7KF9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKChmsBu/FjkqYJ1C8EB5cW1zT19pCtzz4n7UMPw7ZbPtvJyI
	sSagtc5kibZhgDDLad7KWCCLEjwLS/4iFxOT2s/pDSun9rOma0gfjDbSWKPr6i83XHXhoKXLOkN
	ZG5kDI/EsFIoaadBWxdYK1L/X2QUB4aVit8CL
X-Gm-Gg: ASbGncuROD5VsMmbTa7IlQAzQRQaSMP1k5es5a/nI7iCuWPJw+oFVFbe+bdVWPCM+gB
	o3ouZhogEofjaFpqh4TH0cv2c3GihlVEWN5o3WXpHLqOqPicKSm9EflSyzmAj
X-Google-Smtp-Source: AGHT+IEAnK3ZNayNZX1MZKPWNaHHSfD9Gcs0HsfhavIX8PgOJ4JyzfKBkGAXcCXM+vNSiBpmS2gA+HMqANSVxnOf0r0=
X-Received: by 2002:a05:622a:1aaa:b0:465:31d8:6f1a with SMTP id
 d75a77b69052e-4653bd85a6emr194851cf.23.1732206747600; Thu, 21 Nov 2024
 08:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <20241028010818.2487581-3-andrii@kernel.org>
 <20241121144442.GL24774@noisy.programming.kicks-ass.net> <20241121152257.GN38972@noisy.programming.kicks-ass.net>
 <CAJuCfpE04MtnmRR+JYpYqC07-u9yXRUF0FB2mSaQatzwSkNNdw@mail.gmail.com>
In-Reply-To: <CAJuCfpE04MtnmRR+JYpYqC07-u9yXRUF0FB2mSaQatzwSkNNdw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Nov 2024 08:32:16 -0800
Message-ID: <CAJuCfpHpDtis0+KwcUCb5oAbjNmgCtJB=K18Jr=MMRRE=Mkaig@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 2/4] mm: Introduce mmap_lock_speculation_{begin|end}
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 7:36=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Nov 21, 2024 at 7:23=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Thu, Nov 21, 2024 at 03:44:42PM +0100, Peter Zijlstra wrote:
> >
> > > But perhaps it makes even more sense to add this functionality to
> > > seqcount itself. The same argument can be made for seqcount_mutex and
> > > seqcount_rwlock users.
> >
> > Something like so I suppose.
>
> Ok, let me put this all together. Thanks!

I posted the new version at
https://lore.kernel.org/all/20241121162826.987947-1-surenb@google.com/
The changes are minimal, only those requested by Peter, so hopefully
they can be accepted quickly.

>
> >
> > ---
> > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > index 5298765d6ca4..102afdf8c7db 100644
> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -318,6 +318,28 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    t=
rue,     mutex)
> >         __seq;                                                         =
 \
> >  })
> >
> > +/**
> > + * raw_seqcount_try_begin() - begin a seqcount_t read critical section
> > + *                            w/o lockdep and w/o counter stabilizatio=
n
> > + * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variant=
s
> > + *
> > + * Very like raw_seqcount_begin(), except it enables eliding the criti=
cal
> > + * section entirely if odd, instead of doing the speculation knowing i=
t will
> > + * fail.
> > + *
> > + * Useful when counter stabilization is more or less equivalent to tak=
ing
> > + * the lock and there is a slowpath that does that.
> > + *
> > + * If true, start will be set to the (even) sequence count read.
> > + *
> > + * Return: true when a read critical section is started.
> > + */
> > +#define raw_seqcount_try_begin(s, start)                              =
 \
> > +({                                                                    =
 \
> > +       start =3D raw_read_seqcount(s);                                =
   \
> > +       !(start & 1);                                                  =
 \
> > +})
> > +
> >  /**
> >   * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
> >   *                        lockdep and w/o counter stabilization

