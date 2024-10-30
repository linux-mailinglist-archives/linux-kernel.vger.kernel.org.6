Return-Path: <linux-kernel+bounces-389561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B489B6E71
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCCE1F21973
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C29D2139A4;
	Wed, 30 Oct 2024 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NnqyD99o"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43F14F90
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322657; cv=none; b=Y5mrFUEQmHpMvJZB6Pc0BLv8SkC9suPTD56vjtSbimxaVdUfaGcHbnDiapWxcPoMNCVuze571h41F46beGE+QcbltkmYxnflibWGV0FFg8Qdku0io9bGAsCTuG/04Ch2JqI/DYCLt5CsrjMMtsoYgSA4LNkpyKpcb2KsbVsGZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322657; c=relaxed/simple;
	bh=Yv64QlET2EPMrWiN3Hx3EoPUYscpfQCW7OcH/MAi+rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpdQ6QF0Xt7WjkiSh5RvAALgQ36aO8KUXH/gK/+mKWnkfe2xkXmPuWW7deKwzaLGCkXKZqVa5TPzQNR6jL/RFf1KZ3r3VoKDcu+on0lVuEvO8jzj+E8IUBpiqfa+kfm691APP8pM21PGtCM6lEvCHhx1MNpJFrEzkmMl+hg+UwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NnqyD99o; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbe9e8bbb1so2051916d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730322654; x=1730927454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv64QlET2EPMrWiN3Hx3EoPUYscpfQCW7OcH/MAi+rs=;
        b=NnqyD99oF4jdubTlGN6rqWb6YeQEGgrc+/ioq0JnK/WLA9AnmpnbJauX9JxngdMNO5
         XqZwqvEqAfVyaMK6fEtE3tIVNrAbLC4JgX7V/rScbL/l0CBCPsHgisHPqLStB7g25avK
         RBLn9B/id6a2G4Tvo3LBvC2nGFucCbOrXo71yEMkornlQTfp9Q+esXS6rgFKTk3RnlSH
         wb5P3XKT7Qbzx9QnCfMfzjEI1M3jXchWeogP2OHdfwCLRdf6wpNx1wws6DpAZBwZ4O5v
         tJNwS7ZBCPiwWY48kXzbpC4o45O34KEne4UHyousPon+rMc15paN0LFeFQyHs6kTNCBj
         GXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730322654; x=1730927454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv64QlET2EPMrWiN3Hx3EoPUYscpfQCW7OcH/MAi+rs=;
        b=oUq8Mp0PE2U/3mknupZlFEC2v9S17OWlvID0i/q364KqYuvpBAw1kS8Z8WGswOn7O5
         al73Noo8QkjBHUyKKOhC+kM4EZmoYqHL9mVYvfDSP11fgNdrnRwBgEEWrHqrDaY5AfTd
         ed1rVjmBs0VAouN5heuymfRPKC3nqzkqLeZxVhx2QheUNBLsN7T7l5ra4M5KSBy56g8M
         EN6QyLK1x7LQHK0iZQSqa3dRM6Uc1qIlSCLn6aH1FlSFx1Bg668vyL67n7OFRm7R8EPy
         3A7dW7qi0XoLRckjyFiLR6oc1tz1h46uU/ZieySi7BMEVhZbQI1Po0y1ZvLu3TX4DGcg
         hA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP6V3GpRNcGVMDix9jSiha0ZFGmpPOWw+c6dh00D04+e1/vWHX59d4NM9vWRE0g5jIR0NQASmFpYOPpbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhoPam6LvdIpApISkGooNtKRR5w+XyDPmc2nyMBwCRF+LDKZ8A
	y0qfwxq2tIqRHsiSQx8ljrmeFs2eVRPmvADSo+n3G3biZjnaMHtrZMS0wNKECBHDw8z2J2tRkdb
	UAU8EAIrtgZYFmK4lqTOjyxjPON/VIDeh7NBp
X-Google-Smtp-Source: AGHT+IFSS2YttB6l2HQFCMEWaOmu1/SVUYpulUyhAF2c1/XqkoK6fuxeN+Gt2NutPLnZPmax2rGmjblrytR5r69cBr4=
X-Received: by 2002:ad4:524f:0:b0:6d1:8599:5d85 with SMTP id
 6a1803df08f44-6d185995f3fmr202244166d6.48.1730322653802; Wed, 30 Oct 2024
 14:10:53 -0700 (PDT)
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
 <03b37d84-c167-48f2-9c18-24268b0e73e2@gmail.com>
In-Reply-To: <03b37d84-c167-48f2-9c18-24268b0e73e2@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 30 Oct 2024 14:10:17 -0700
Message-ID: <CAJD7tkbO0SVUfhHQ46rONy45e8FmoWESegtTLz561aPy2N-Uhw@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Usama Arif <usamaarif642@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[..]
> >>> A crucial component is still missing=E2=80=94managing the compression=
 and decompression
> >>> of multiple pages as a larger block. This could significantly reduce
> >>> system time and
> >>> potentially resolve the kernel build issue within a small memory
> >>> cgroup, even with
> >>> swap thrashing.
> >>>
> >>> I=E2=80=99ll send an update ASAP so you can rebase for zswap.
> >>
> >> Did you mean https://lore.kernel.org/all/20241021232852.4061-1-21cnbao=
@gmail.com/?
> >> Thats wont benefit zswap, right?
> >
> > That's right. I assume we can also make it work with zswap?
>
> Hopefully yes. Thats mainly why I was looking at that series, to try and =
find
> a way to do something similar for zswap.

I would prefer for these things to be done separately. We still need
to evaluate the compression/decompression of large blocks. I am mainly
concerned about having to decompress a large chunk to fault in one
page.

The obvious problems are fault latency, and wasted work having to
consistently decompress the large chunk to take one page from it. We
also need to decide if we'd rather split it after decompression and
compress the parts that we didn't swap in separately.

This can cause problems beyond the fault latency. Imagine the case
where the system is under memory pressure, so we fallback to order-0
swapin to avoid reclaim. Now we want to decompress a chunk that used
to be 64K.

We need to allocate 64K of contiguous memory for a temporary
allocation to be able to fault a 4K page. Now we either need to:
- Go into reclaim, which we were trying to avoid to begin with.
- Dip into reserves to allocate the 64K as it's a temporary
allocation. This is probably risky because under memory pressure, many
CPUs may be doing this concurrently.

