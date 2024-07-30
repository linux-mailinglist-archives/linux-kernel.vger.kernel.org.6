Return-Path: <linux-kernel+bounces-268231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8364942202
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44A05B2446F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1268188CA8;
	Tue, 30 Jul 2024 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrlHbLqK"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9338B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373592; cv=none; b=nSx82w918TZAGJ4rRTb9k6wLoCpSqke0ty+sGQlBz3bK5u/rK3loZfp88ad1z3xiwchjAEY9UswSBeR1H11LyauDduLJYfS59pG7CeAghgkW5xoSZF1j3VucSg5ZJtMT8I6uoDpLA4PMN9D2xWvXDXvuo4GnU3DBL0hwM+7z/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373592; c=relaxed/simple;
	bh=u8dzcOs8mOmkyobWOKM+idyFO+5dRbGUujh+YwHXib8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWswJrXqUKYdoD51/BBTPzatpBBwZlSB1Q6VprY1rcxWlKahhnMi4Khmch3oOFhSxCPctF+shAX0jS+cRuX4enRn8EdA7M/aZHAPeO2Nbfbs/ossVBXs6Oh31oL8RSnKbIU8qU9W5OEeTf3xMZ6WRz+n4ym2ZYpnkksF2p2ucH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrlHbLqK; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f4cdb520f3so148885e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722373589; x=1722978389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WG3Gt1G23WdjFYsF5tUz4H0BzIw3odLjVlIK2ek5M8k=;
        b=PrlHbLqK6f327pHbvD/+SVxskb6N+1p3SBSdeGoTXHf8dQlzEMwChTK5D0lHiGSJn1
         fPkIDSF5ZAQYJd4BDCvt4VfXfoQZn+5VtaP8bs+Ztua6E0fACukccHiMfzKlq5rG8xq8
         o6clda0S9ROCM8iBpaLFCH4gB9cCyRPOLWZU7nQsrGfbTnmpAuEpU6ep1ns1Z1mDW7Wm
         iA5zr3Bzn4D2rRRcaTS6y5lI0krYvYO+Bb6LS7ups8PuH78jKpMr56VdVF2ywZNsHPGu
         KB76V85kp1mFIZ8+cM9RIKMOUGlwmGgij/VWjs70OXwPOVvQbxhYyklyRht41xENi6Hf
         dvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722373589; x=1722978389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WG3Gt1G23WdjFYsF5tUz4H0BzIw3odLjVlIK2ek5M8k=;
        b=ez927aAqRdEE+kwg5dX0U1waguuaWlAM1/Bulxxnn/0gH8tDW2KJvD/v2tYpyvZxuo
         dkLpRcTlZcF/B7HhS1YBiGAJCLGUqcyEjm1ljOcuDDnEaLUG6zOnQX9IFuDVF+KOOuGN
         rb+U0EbomD1AQkbE0iQInSa2hF5PHH3pr4jLuJtPK+vEU0YGAATAnwd4avMRZQPaMvuC
         fl4D2w1syBi/rYemTn7FaLHIWj41nlgbYH/uJWgrxik1BDZWhRZzdxxToHcPzKmz7jaf
         xJrO6OsaAtuW5HSLnkv6apVPxXvTl1DtFCqOTUOwLe9xOOrr8eFAN0AAUlgrTsrskB2S
         hi8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJt/ohj59U8akxK+CNn59dO+197qLbZg1MM3t7j6CwlkA2ZoIPT5JCu39hWp0a4MgaNgbTTp1taou7Fw+1rcb3bAAUV4K4H0X3LCeC
X-Gm-Message-State: AOJu0Yw+Jn8DtULXHG3X9vcSS+rCnDQ+dgjqdQ05yAdQenblVnSCBjol
	RFP45YwrT2+HQMScndqMZ4rerlyBRqXiXxMQyJ1uj9N0G24naT6DZSkH0uRS9MiukmjkqVq8nQ0
	vWe+83G433Sg9utyp+7OHj2iksCM=
X-Google-Smtp-Source: AGHT+IHP8BxyNMgmlFObFcaCBGgz+PTn1MIlsm0UPlqiJ5IRjvYvHp0Uv1eb88Z4ccrdAoAabbZWtbeGNCDU97bG07U=
X-Received: by 2002:ac5:cd50:0:b0:4eb:ddd:4b95 with SMTP id
 71dfb90a1353d-4f87f6c753bmr2031976e0c.0.1722373589200; Tue, 30 Jul 2024
 14:06:29 -0700 (PDT)
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
In-Reply-To: <CAKEwX=PETirC4P3CXW1uvoHW4H-ozEYpXUGCoi-LnN=jAzMKLQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 31 Jul 2024 09:06:17 +1200
Message-ID: <CAGsJ_4z1koYbroafQEUm0Sbm3QM2Ag11huUMKA6REQM_bWgRng@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
To: Nhat Pham <nphamcs@gmail.com>
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

On Wed, Jul 31, 2024 at 7:28=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Jul 30, 2024 at 9:30=E2=80=AFAM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> >
> > Well, that is the point.  zram is a horrible hack that abuses a block
> > device to implement a feature missing the VM layer.  Right now people
> > have a reason for it because zswap requires a "real" backing device
> > and that's fine for them and for now.  But instead of building VM
>
> I completely agree with this assessment.
>
> > infrastructure around these kinds of hacks we need to fix the VM
> > infrastructure.  Chris Li has been talking about and working towards
> > a proper swap abstraction and that needs to happen.
>
> I'm also working towards something along this line. My design would
> add a "virtual" swap ID that will be stored in the page table, and can
> refer to either a real, storage-backed swap entry, or a zswap entry.
> zswap can then exist without any backing swap device.
>
> There are several additional benefits of this approach:
>
> 1. We can optimize swapoff as well - the page table can still refer to
> the swap ID, but the ID now points to a physical page frame. swapoff
> code just needs to sever the link from the swap ID to the physical
> swap entry (which either just requires a swap ID mapping walk, or even
> faster if we have a reverse mapping mechanism), and update the link to
> the page frame instead.
>
> 2. We can take this opportunity to clean up the swap count code.
>
> I'd be happy to collaborate/compare notes :)

I appreciate that you have a good plan, and I welcome the improvements in z=
swap.
However, we need to face reality. Having a good plan doesn't mean we should
wait for you to proceed.

In my experience, I've never heard of anyone using zswap in an embedded
system, especially among the billions of Android devices.(Correct me if you
know one.) How soon do you expect embedded systems and Android to adopt
zswap? In one year, two years, five years, or ten years? Have you asked if
Google plans to use zswap in Android?

Currently, zswap does not support large folios, which is why Yosry has
introduced
an API like zswap_never_enabled() to allow others to explore parallel
options like
mTHP swap. Meanwhile, If zswap encounters large folios, it will trigger a S=
IGBUS
error.  I believe you were involved in those discussions:

mm: zswap: add zswap_never_enabled()
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D2d4d2b1cfb85cc07f6
mm: zswap: handle incorrect attempts to load large folios
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dc63f210d4891f5b1

Should everyone around the world hold off on working on mTHP swap until
zswap has addressed the issue to support large folios? Not to mention wheth=
er
people are ready and happy to switch to zswap.

I don't see any reason why we should wait and not start implementing someth=
ing
that could benefit billions of devices worldwide. Parallel exploration lead=
s to
human progress in different fields. That's why I believe Yosry's patch, whi=
ch
allows others to move forward, is a more considerate approach.

Thanks
Barry

