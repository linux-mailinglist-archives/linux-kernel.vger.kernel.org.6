Return-Path: <linux-kernel+bounces-269679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D849435B1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0902853E3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7DC46447;
	Wed, 31 Jul 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSLzsjGc"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0333CFC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450916; cv=none; b=PnVTNVBOd0P6d0uNFay4fkyb9loVTnq/iA55ZezEsBOX9e9fCEG8VMQruQAZgDx4hBB4NVUkxS46yYGN6w52yUL8WF8iommf+QyVyk9om5jt3xnCuQidzOhhmXz1CmXKDbadZdjMSfRshIVwQVix+4HdLA4mPjcupYqtHU8hePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450916; c=relaxed/simple;
	bh=CCfOUEXMCM+KSbathTfwlyJ9gH6wMECiPb7OeXkFWf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAO3zxBwEVZ70Gff4aSbFTeXrWr8hmKqPElvr/rR8OGSWGvVCn/5qSwNkAKBQwQXcp6pmpiUt38WkTbsuiO/7Bv9MIbxaqfwuhTtdmp9DmlICHJaUtVLzEAtg27c9iuqx3na/a833I88eXO3mHRriidbiXKox/J1OOAgWa6C0Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSLzsjGc; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b7acf213a3so31776026d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722450914; x=1723055714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdDEDhBatiVQbzaYWZvpRwACycHKBzrY1H/vlaLquHE=;
        b=nSLzsjGcU+3RzKdtYWH0sh3zLwiT/HCo4/j9k7Ax/OdGByPFSye+Z4r074X6AigREP
         wwUahywVFJYKhdtcEnCHPgPb3XMLSsBZ4ynCFd50KJu0yRq4PJ0bXS6b7bSFtw+ZY10O
         rfHGDsGRmwR5HNeqSXcazjxFiBsvfebkMXj55W80NCBD14JybyVoPF+Wt+YB6RQrOGSI
         p7RQed0V3rkTBmItC29t+LKKfMzUyCTbivH6OsZLTw0BtG4zTXFfzNyxbVGKC0PFkqHj
         Uu98hTgTip8bZLGH9FXwlgYvKPTa0F+XH6acIIyi0z8F2O08TNBeLZrtnNx/qKNzRmwW
         D4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722450914; x=1723055714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdDEDhBatiVQbzaYWZvpRwACycHKBzrY1H/vlaLquHE=;
        b=G97cfIYm6H/9ASuLUbL24DWxmh83ztwl7TWDS6PFxI9Bx6q10LWm8ljSZEH3PzAvkl
         7syJyUP5+ViXZiY9gHEg88oKhvF4lp1srvbjWQM/wzaG7+AS+uBlHk7JQasPPjya+H/P
         YzvqMM81PVicGc+LGczJ5CwXE0IWB7OhozCqUtD4q90o3qzk+kAzoc3cnPWC/QHQQ/mw
         SH/3Z2DSDxoe/Qb1zzxhnO1Nq8DBKNVdl5hCk2JvK4F3XYvJSkga2e7ixmCvJp7OtCiV
         +NykB8QjcebTUUoE+DHuOoyzhcNyQPXTmB7cagXNqvHl4bymzdL7/I6LEmOqZptCgNbK
         muVw==
X-Forwarded-Encrypted: i=1; AJvYcCXV52prPa3Q26RkXB51+8kJUdm8G9GKdCajyuVGXBSWVpboR0IueSmThAc6vuOVWPMzFkWFSSZx4gikl0t6iqlpY8B5gv+lKY5KjD35
X-Gm-Message-State: AOJu0YwbpkKEajfPaCjOt3GD8tlkUx8zuStKPK/vg9SwxA89bYzxvfw5
	DeIeiFDiw+C/BIscyVoTzau8AM4tYfy4+/kEhyy1247XXxzjdk37zryjUxCbDPHmwr/aiT6JDDH
	4m0k4j8w9Gb511JffDsAGDiQf1xg=
X-Google-Smtp-Source: AGHT+IEuHFrKuYdYR9bW9QDOJ52WoNSCF9km2bgNw9D7wyjddAIiBhakhZRyh6QJApWCr8yi7bCaOjAczID+rNj7ymQ=
X-Received: by 2002:a05:6214:3109:b0:6ae:ba6:2136 with SMTP id
 6a1803df08f44-6bb8d79a1admr821976d6.36.1722450913709; Wed, 31 Jul 2024
 11:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org> <Zqe_Nab-Df1CN7iW@infradead.org>
 <CAGsJ_4wfWYGZVouK4JTj9DBDNPKTX_zrfU45iivaUy-Nq-P1bA@mail.gmail.com>
 <ZqkVMpbl5pH35uOq@infradead.org> <CAKEwX=PETirC4P3CXW1uvoHW4H-ozEYpXUGCoi-LnN=jAzMKLQ@mail.gmail.com>
 <CAGsJ_4z1koYbroafQEUm0Sbm3QM2Ag11huUMKA6REQM_bWgRng@mail.gmail.com>
In-Reply-To: <CAGsJ_4z1koYbroafQEUm0Sbm3QM2Ag11huUMKA6REQM_bWgRng@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 31 Jul 2024 11:35:02 -0700
Message-ID: <CAKEwX=N1S6Btd1Bb=FnMHwXnM_74O+8_WkN97hfqgdV-2k-t-A@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
To: Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, ying.huang@intel.com, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, minchan@kernel.org, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 2:06=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> > I'd be happy to collaborate/compare notes :)
>
> I appreciate that you have a good plan, and I welcome the improvements in=
 zswap.
> However, we need to face reality. Having a good plan doesn't mean we shou=
ld
> wait for you to proceed.
>
> In my experience, I've never heard of anyone using zswap in an embedded
> system, especially among the billions of Android devices.(Correct me if y=
ou
> know one.) How soon do you expect embedded systems and Android to adopt
> zswap? In one year, two years, five years, or ten years? Have you asked i=
f
> Google plans to use zswap in Android?

Well, no one uses zswap in an embedded environment precisely because
of the aforementioned issues, which we are working to resolve :)

>
> Currently, zswap does not support large folios, which is why Yosry has
> introduced
> an API like zswap_never_enabled() to allow others to explore parallel
> options like
> mTHP swap. Meanwhile, If zswap encounters large folios, it will trigger a=
 SIGBUS
> error.  I believe you were involved in those discussions:
>
> mm: zswap: add zswap_never_enabled()
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D2d4d2b1cfb85cc07f6
> mm: zswap: handle incorrect attempts to load large folios
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc63f210d4891f5b1
>

I am, and for the record I reviewed and/or ack-ed all of these
patches, and provided my inputs on how to move forward with zswap's
support for large folios. I do not want zswap to prevent the
development of the rest of the swap ecosystem.

> Should everyone around the world hold off on working on mTHP swap until
> zswap has addressed the issue to support large folios? Not to mention whe=
ther
> people are ready and happy to switch to zswap.
>

I think you misunderstood my intention. For the record, I'm not trying
to stop you from improving zram, and I'm not proposing that we kill
zram right away. Well, at least not until zswap reaches feature parity
with zram, which, as you point out, will take awhile. Both support for
large folios and swap/zswap decoupling are on our agenda, and you're
welcome to participate in the discussion - for what it's worth, your
attempt with zram (+zstd) is the basis/proof-of-concept for our future
efforts :)

That said, I believe that there is a fundamental redundancy here,
which we (zram and zswap developers) should resolve at some point by
unifying the two memory compression systems. The sooner we can unify
these two, the less effort we will have to spend on developing and
maintaining two separate mechanisms for the same (or very similar)
purpose. For instance, large folio support has to be done twice. Same
goes with writeback/offloading to backend storage, etc. And I
(admittedly with a bias), agree with Christoph that zswap is the way
to go moving forwards.

I will not address the rest - seems like there isn't something to
disagree or discuss down there :)

