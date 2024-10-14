Return-Path: <linux-kernel+bounces-364728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D779F99D879
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760F51F21375
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D991D12FA;
	Mon, 14 Oct 2024 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3oHYq2i"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16361D0BA4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938918; cv=none; b=hz6xaZCjdrthmxnz2egJgc0JJBc6u52ipdmal/KAAQ87uX/k5SwDV0i2p6WyJfDTE4wuqYcYaEyWptdUAYa6eZw0ymlCTmz6fXqV9UtGgsEqQpqZjAZRMO+KiFF9zgPLcDv7pLbyGwwKQwGZDSJbbU2y8iZYigKjLhduWVxEYYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938918; c=relaxed/simple;
	bh=oLiOJMlbQiOQsxhqpnja9W8p5wjHHPLRN1lJCefWKIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1Nv+GpsEAtZfCvsjWzlRSn2mgTEWIn07fbUBxT3UJKJpai1TliPPLvEoe0YggAM6yO6JbZ0XxFa2id4KSqnobBD/pw87VJQETxBm25zHg/sNZloEcBS4PG3kJvCJr4C+KgsWsG/TuR2Z3ahZDyPf6gyCL/hJHzT3JJyO6pLAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3oHYq2i; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c8ac50b79so327665ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728938916; x=1729543716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLiOJMlbQiOQsxhqpnja9W8p5wjHHPLRN1lJCefWKIQ=;
        b=A3oHYq2icxsJJhuHZJ76PIZC/B8owrWq4oGhC0ybqMsNnT926a2I7NDiDIO0WNOAk3
         SUyyM+SF1O6+m19vpzWc+oCTO1VNmadjYUAn4ERqYrA7ANLIn7iigwaHP/UUDerddsOD
         bYs+yT+sJejmyMZMeQdVBnrMscZ9rAJKqvcVlkG7HjxljptNamPs7xFovEvkVFehplUI
         nbkvOyXaMuoAM3SKAuQpsS451DMXhdf2cxLM0DN6nWF9YP4omRYfHuVNZJB9RDLa3Kv1
         m5M3A1LLsmYwJJ/T69m5sZBCQmIkG8+oz5HdkrWGJQVapJdKfQQuxln6G5GMjw88s+Fw
         HReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938916; x=1729543716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLiOJMlbQiOQsxhqpnja9W8p5wjHHPLRN1lJCefWKIQ=;
        b=YgTdz5O6EQAF4BnKlz0rWyaWUPmKCa+2hcg64X2P0odYdWlABbfHm9WpJE17fJl+PB
         gVl/Jo99YJLwMT+UB6S1R2NSGcArjlB5pqlIBPDR2DmMx2dViWsrV7YTqg7wo7+ofYh4
         4KV6HaMvcpG4r2Z6L8wvcr7jJvvn2eWGP+WTkDYfybDCUQ/RgqD1rIpSo+ucchLHDq9x
         gZ8UPQ/QRWfovqiUImHN40SlVAmyChWxnVaWOi5/4O26bXYW4NBWAiv2DlWvSZ6dmZXO
         toYGeTrM/SnG7u0Stegj9ISHG+JiR0TyNpl/rL/1Liac4BBo8V2mLzrsBfSQsSycpIrh
         4Z0g==
X-Forwarded-Encrypted: i=1; AJvYcCXbeyO1lljnkZzy18u+46QlJGRvOt/7hXVCIZZWtF3eiVw0IOveY5z0xAMrJwctq0dlsH1H5906TtDhNRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/DXP4E8CTsfVpxFaKKWAQXTr0xBv8uXQrIl1nejsZW0byLYb
	W3FDhTL8OXM1c9nBT/UDoCaItaNUZHDaMsEWgUIP3n4/NuZ/PDWqs1qSU0UPO0/4cw1Bkbygk57
	rJaJ/WUbF5p/VeB5wdIQ4Xruc/asFVBh4bxVQ
X-Google-Smtp-Source: AGHT+IElWbl5AVByUDgVhkR4DJhOP0D4H2xXZYriU+tuWxs0dxelbS2co5cCS0cZFwpG8zDMPaW/VapnM4qXE+UzLNw=
X-Received: by 2002:a17:902:ea0d:b0:20b:a6f5:2770 with SMTP id
 d9443c01a7336-20cbce0d691mr4772125ad.6.1728938915788; Mon, 14 Oct 2024
 13:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-2-andrii@kernel.org>
 <haivdc546utidpbb626qsmuwsa3f3aorurqn5khwsqqxflpu3w@xbdqwoty4blv> <CAEf4BzYRiE9vYCRLmiRHD+fqb_ROwqrb0sX6sktqDNdfeH85DA@mail.gmail.com>
In-Reply-To: <CAEf4BzYRiE9vYCRLmiRHD+fqb_ROwqrb0sX6sktqDNdfeH85DA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 14 Oct 2024 13:48:23 -0700
Message-ID: <CAJuCfpF+YeXVYuEuTt_XKFJuSbu_BxWU96znnfnwG6mMQC7ETA@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, akpm@linux-foundation.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	vbabka@suse.cz, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 1:27=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Oct 13, 2024 at 12:56=E2=80=AFAM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> >
> > On Thu, Oct 10, 2024 at 01:56:41PM GMT, Andrii Nakryiko wrote:
> > > From: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Add helper functions to speculatively perform operations without
> > > read-locking mmap_lock, expecting that mmap_lock will not be
> > > write-locked and mm is not modified from under us.
> > >
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > Link: https://lore.kernel.org/bpf/20240912210222.186542-1-surenb@goog=
le.com
> >
> > Looks good to me. mmap_lock_speculation_* functions could use kerneldoc
> > but that can be added later.
>
> Yep, though probably best if Suren can do that in the follow up, as he
> knows all the right words to use :)

Will add to my TODO list.

>
> >
> > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> >
>
> Thanks!
>
> >

