Return-Path: <linux-kernel+bounces-389614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EB79B6F06
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8ED1F25C64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4392021500A;
	Wed, 30 Oct 2024 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIpDK+Dy"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F31CF7BB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323951; cv=none; b=sDQxOlEJv1dBXG9ONoy9OsfaAXj+ZtgIywRSwcvmKKpB3SjrlTj3qq6Yhm2g+s7eubXYoPYuh2IQs4sShLGiDsJ0cKi8CHy4QR5P7HnXCi6q+1DEiMOENc0UeSD7cnf0Zod9Mf4k2CQE6uHjIYTxRxMlcmCL1Vk6w4qpwzYbAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323951; c=relaxed/simple;
	bh=tmQdUbtLnzYjF/xLQA+VMZk9QzQVpT+DQcxpiDhLHm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZdW2IfJaq79+tkEmt75P8cxXKdu9rSlrOTFa2lb1KWE0lVqPkAqVCa1CCxaGZmBQiC4g3QYVVJJlYxaG//Y+2mk2B7HqkFq5tiaLxUYglEuPHqzGrTwGU1atr5DlowGHm2YDzLKgHP8+6rLO84ikjl2A+TOadV00boTHbAvh3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jIpDK+Dy; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b15d7b7a32so20634685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730323948; x=1730928748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmQdUbtLnzYjF/xLQA+VMZk9QzQVpT+DQcxpiDhLHm4=;
        b=jIpDK+DyW39Un8czhqLArqqilSPRD79vdibbgiTbtpIx48+90jlwhC+5pajlws7sr0
         hvOCLnDERo6kMjK8LN1RTasFzHIZhmVgXnrGs0wKuRfBt+ATqh6T4ZfaNsUx/VpP02pD
         HWM7LqpcY6OM/fdEKE7fE7dmiOeNbsNRKSwNYQe0wJIXH85LitWTpwNdEUbW8QiySwWt
         6BxvY3S6YmASnlmCsyagTtNLqMn0+VH1zLA81sH7X1CHKA/6XCQ6hlQLtq+mj4U/pbIu
         hCrJ0Ba/wIK6HckCmgPm0Z7ZHhn8AJzISfWoNE5nnd8lewkzrx3FgvZxm1B7HOntaIa2
         E06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323948; x=1730928748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmQdUbtLnzYjF/xLQA+VMZk9QzQVpT+DQcxpiDhLHm4=;
        b=ZZTzby9C9CmENWew90ULGeEvub79jSefGokv+Sq//O5BPFbsfc9EAS8F+ElpTXgf76
         W2o2xiBFXDnjOPhBGEuTcbxy0xtb3pFb5An2XW/M9o2EgXwFdnhsTOqWxhoie1U1AUM3
         5f1brQr9+TqngzGjfa+lsQySroaLejnwQBt/MaEb8rH/Q274HWMjwhpMZLpEpqd3Ytyr
         uYg/mpFWcN648aBtA1E2MbgXR4PB+dGSn8LvqLYqBjjlP24fM8AYQjilfia5qryzYCl+
         A5awzJU7INv3uOvm4mUCpDO8uVwlz+SeT2MaAQat6cx8Fq6J/SZudMQFnruSH7MvAkUk
         ex7w==
X-Forwarded-Encrypted: i=1; AJvYcCXJw7qZuIhVz369qr/fjNT95KCN1N1Mu17Iq+3xkUmx1t7Vj68hl03zBnPl/AKs80ze62c4iW2mBnrRqXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMmjUKxacxXE2XDnV5nLrnLC8QBqsrByunRGcmSapXDd0OkkZ
	uZXOxtiQLHHBnP086qa+sCKYkRDwF1XEM3+LHZkW+W+7ZKJqR6jJ2CGfpLcs77fBs6xcWbrtpBy
	GV0lPboTpnSMwkvMUWM5/LCHvpd9HnTrOiY+v
X-Google-Smtp-Source: AGHT+IHhPc0t3DXIjTXga1D1bgTqV3v6iXrlbt5OARx5K1uEA7GiXoaRC3cOoo8s2D5UuAdlcyfBv9zOj5lvCzqfJfU=
X-Received: by 2002:a05:6214:458e:b0:6d1:77ce:6a3c with SMTP id
 6a1803df08f44-6d185832ab5mr293513116d6.38.1730323947839; Wed, 30 Oct 2024
 14:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027001444.3233-1-21cnbao@gmail.com> <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
 <CAGsJ_4wdgptMK0dDTC5g66OE9WDxFDt7ixDQaFCjuHdTyTEGiA@mail.gmail.com>
 <e8c6d46c-b8cf-4369-aa61-9e1b36b83fe3@gmail.com> <CAGsJ_4wx-JH8T5wNjJURKvpQ4hUueMeF9Q6cu9WaFhEc7AEG2A@mail.gmail.com>
 <d88867ba-32e6-4b28-961e-756389d345ca@gmail.com> <CAGsJ_4xyEg-hsAcDMM11f3K=FS28-Xp7sy4uo0fzCS5xR2EArg@mail.gmail.com>
 <03b37d84-c167-48f2-9c18-24268b0e73e2@gmail.com> <CAJD7tkbO0SVUfhHQ46rONy45e8FmoWESegtTLz561aPy2N-Uhw@mail.gmail.com>
 <CAGsJ_4zrgsgzHLWrcr8Fa9nMni7FSokgEkY6yk6Eu6R3O_wL2w@mail.gmail.com>
In-Reply-To: <CAGsJ_4zrgsgzHLWrcr8Fa9nMni7FSokgEkY6yk6Eu6R3O_wL2w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 30 Oct 2024 14:31:51 -0700
Message-ID: <CAJD7tkZzFRm4qBGJi+EBNqG-3btS9azJaCxdqsQvTnEaPhZzBQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Barry Song <21cnbao@gmail.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 2:21=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Oct 31, 2024 at 10:10=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > [..]
> > > >>> A crucial component is still missing=E2=80=94managing the compres=
sion and decompression
> > > >>> of multiple pages as a larger block. This could significantly red=
uce
> > > >>> system time and
> > > >>> potentially resolve the kernel build issue within a small memory
> > > >>> cgroup, even with
> > > >>> swap thrashing.
> > > >>>
> > > >>> I=E2=80=99ll send an update ASAP so you can rebase for zswap.
> > > >>
> > > >> Did you mean https://lore.kernel.org/all/20241021232852.4061-1-21c=
nbao@gmail.com/?
> > > >> Thats wont benefit zswap, right?
> > > >
> > > > That's right. I assume we can also make it work with zswap?
> > >
> > > Hopefully yes. Thats mainly why I was looking at that series, to try =
and find
> > > a way to do something similar for zswap.
> >
> > I would prefer for these things to be done separately. We still need
> > to evaluate the compression/decompression of large blocks. I am mainly
> > concerned about having to decompress a large chunk to fault in one
> > page.
> >
> > The obvious problems are fault latency, and wasted work having to
> > consistently decompress the large chunk to take one page from it. We
> > also need to decide if we'd rather split it after decompression and
> > compress the parts that we didn't swap in separately.
> >
> > This can cause problems beyond the fault latency. Imagine the case
> > where the system is under memory pressure, so we fallback to order-0
> > swapin to avoid reclaim. Now we want to decompress a chunk that used
> > to be 64K.
>
> Yes, this could be an issue.
>
> We had actually tried to utilize several buffers for those partial
> swap-in cases,
> where the decompressed data was held in anticipation of the upcoming
> swap-in. This approach could address the majority of partial swap-ins for
> fallback scenarios.
>
> >
> > We need to allocate 64K of contiguous memory for a temporary
> > allocation to be able to fault a 4K page. Now we either need to:
> > - Go into reclaim, which we were trying to avoid to begin with.
> > - Dip into reserves to allocate the 64K as it's a temporary
> > allocation. This is probably risky because under memory pressure, many
> > CPUs may be doing this concurrently.
>
> This has been addressed by using contiguous memory that is prepared on
> a per-CPU basis., search the below:
> "alloc_pages() might fail, so we don't depend on allocation:"
> https://lore.kernel.org/all/20241021232852.4061-1-21cnbao@gmail.com/

Thanks. I think this is reasonable but it makes it difficult to
increase the size of the chunk.

I would still prefer for both series to remain separate. If we want to
wait for the large folio zswap loads until your series goes in to
offset the thrashing that's fine, but I really think we should try to
address the thrashing on its own.

