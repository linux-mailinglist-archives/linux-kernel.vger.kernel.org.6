Return-Path: <linux-kernel+bounces-389585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB619B6EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C8F1C2174C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E701E1C09;
	Wed, 30 Oct 2024 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la+qQ4LC"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20976025
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323302; cv=none; b=AntE+28fMkG9zYe4H5GaRRY9BHSWZ49npUsSa0haJ6ff7P4KS2e3mJUp4APpgU2APcMsA8/GapWJGDB/O52YJHyctlRI8EWqwLgHjwZN6Us2vBwvArqmXQlfRsgbfBcjwA5VF0tNMaMpC1P416lf+Ga7d0nAgej8pKwblpHPcfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323302; c=relaxed/simple;
	bh=04NnIStJmZ8v6ISEsRCwFl6t2OPeokZR8SUSj6bruwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASeHCaB7YZPVJqv4/Nxd8NO8TEpVe4jsOM+j/ywNdkp5GwegdfUsbuix3IDhQFHuUmV/2U4Px+Q+1ke0w9gMx9JOKmfCN+1On3ljIIe+m10uxz8MOM1rZEwkGe80vDVhPNO5EK1xbLC/rgihneks3NglS4ABe0zVl3BqnRQcpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la+qQ4LC; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50d4797098dso100042e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730323299; x=1730928099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04NnIStJmZ8v6ISEsRCwFl6t2OPeokZR8SUSj6bruwE=;
        b=la+qQ4LCon9ygizP2QVceyTKPjQ2wFcNrpb+W0yMDVK+CFesAnXz47m18VQGhfcvCp
         gosswDnTp3efVB3dQJEr19prx4V1kXtEQNjxxE/JkYXX6Bk9sAA60cNGudRUgcl4r9U0
         FRJPJJ77eb1Bx0F/zFX3YgdctzichuQEOoKFePp7GGdRraFvxgGykntcfEPn4ec5DEsi
         Pkfbs/tOI18zxqqI5YWaP8vVMff65be+zITv+H/XqQOi89Ma0HfUJDxdGtyt0CfiEb1x
         IG7g4/9U56Q60LyUNtINRpQ69YyGslkT0tvXpf+zRt+E3Qv2SJzbxtxR6QmKHJwalpoN
         qqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323299; x=1730928099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04NnIStJmZ8v6ISEsRCwFl6t2OPeokZR8SUSj6bruwE=;
        b=OrEmhBMcvfvvxYv3ZTsaiPeszzCYWAZ5KZprV4C8SGMvMJAFMMRzkQPab+lFnhNYUB
         eaAQ5fF06PVREQ8w3zw+2wDKZCYUjzcD8v153cM8CJowyCM4kFGZufEtuY0KFJ5UETLk
         K/0+YKGdaN93yUAmPNpMXfVJ/Wh835ai6FafrWTz6X9DaGbEbSiMKwSTXEYNLHKn4CK4
         +RGrIRmborELSoVT7a1KeTXjSkelBva7XJ66D2iqIE1H5ZCQH0YkUJf1D+xn6z9qXeDx
         d7fL5TXNB3Vb9rUcnozGgUdTOzOElPJFZVkKrlioeSgJ6illcRbHvbAnyZBj9mABQfN/
         Apdw==
X-Forwarded-Encrypted: i=1; AJvYcCVnIpVfSD0K6K6zjz8uteUFaqMkopDK4C/I4jUaZvdcIFeYXRSx/AViDCODYtru8y3OIT14EnrVe1QjarA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywOkT3ENCxyjKwYtZoRxSlSn7SzmrfdtrsVjqWItvU/nJfXfcj
	lv9p1XyLV0pDX9y1WdFBqiPVQTlc4BP6UcBh1eKwQQQzDQliyVWo3Z8Np6MVR1buo5CVHaFUWCG
	9ap/msVOQLe4HAA7MGt5qb8w6f3c=
X-Google-Smtp-Source: AGHT+IFxiyrwwaNSACU73R5/Ge2xftYZNBnNjr5FG5CX1TISQoFPGGIsLQr5PcgYW0gS2eOgzgOLL7Rp4yLNbAcKJ40=
X-Received: by 2002:a05:6122:3196:b0:50c:4efb:835a with SMTP id
 71dfb90a1353d-51014ff7a57mr14380982e0c.1.1730323298876; Wed, 30 Oct 2024
 14:21:38 -0700 (PDT)
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
In-Reply-To: <CAJD7tkbO0SVUfhHQ46rONy45e8FmoWESegtTLz561aPy2N-Uhw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 31 Oct 2024 10:21:27 +1300
Message-ID: <CAGsJ_4zrgsgzHLWrcr8Fa9nMni7FSokgEkY6yk6Eu6R3O_wL2w@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Yosry Ahmed <yosryahmed@google.com>
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

On Thu, Oct 31, 2024 at 10:10=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> [..]
> > >>> A crucial component is still missing=E2=80=94managing the compressi=
on and decompression
> > >>> of multiple pages as a larger block. This could significantly reduc=
e
> > >>> system time and
> > >>> potentially resolve the kernel build issue within a small memory
> > >>> cgroup, even with
> > >>> swap thrashing.
> > >>>
> > >>> I=E2=80=99ll send an update ASAP so you can rebase for zswap.
> > >>
> > >> Did you mean https://lore.kernel.org/all/20241021232852.4061-1-21cnb=
ao@gmail.com/?
> > >> Thats wont benefit zswap, right?
> > >
> > > That's right. I assume we can also make it work with zswap?
> >
> > Hopefully yes. Thats mainly why I was looking at that series, to try an=
d find
> > a way to do something similar for zswap.
>
> I would prefer for these things to be done separately. We still need
> to evaluate the compression/decompression of large blocks. I am mainly
> concerned about having to decompress a large chunk to fault in one
> page.
>
> The obvious problems are fault latency, and wasted work having to
> consistently decompress the large chunk to take one page from it. We
> also need to decide if we'd rather split it after decompression and
> compress the parts that we didn't swap in separately.
>
> This can cause problems beyond the fault latency. Imagine the case
> where the system is under memory pressure, so we fallback to order-0
> swapin to avoid reclaim. Now we want to decompress a chunk that used
> to be 64K.

Yes, this could be an issue.

We had actually tried to utilize several buffers for those partial
swap-in cases,
where the decompressed data was held in anticipation of the upcoming
swap-in. This approach could address the majority of partial swap-ins for
fallback scenarios.

>
> We need to allocate 64K of contiguous memory for a temporary
> allocation to be able to fault a 4K page. Now we either need to:
> - Go into reclaim, which we were trying to avoid to begin with.
> - Dip into reserves to allocate the 64K as it's a temporary
> allocation. This is probably risky because under memory pressure, many
> CPUs may be doing this concurrently.

This has been addressed by using contiguous memory that is prepared on
a per-CPU basis., search the below:
"alloc_pages() might fail, so we don't depend on allocation:"
https://lore.kernel.org/all/20241021232852.4061-1-21cnbao@gmail.com/

Thanks
Barry

