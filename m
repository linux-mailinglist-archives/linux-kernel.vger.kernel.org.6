Return-Path: <linux-kernel+bounces-206834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C10900E72
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 01:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F051F239E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1D21386C6;
	Fri,  7 Jun 2024 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar+GMn7D"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B999B1BC43
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 23:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717802924; cv=none; b=NrRBCAMB1yGOqMbx7OmIGkij2ADjQGiBckTmFNiYn3k6Ip3w32wLTMHy7rP5g93kNN9yDOPYeSyY6m0hILFLmBKtiCNb+07TvyUBatj5TLfBrBu2bPOMM3HvQVCLZmWjnuI77kQWm1/XaHufLKaEDPMUqPlVXkK2QjS0YDsJCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717802924; c=relaxed/simple;
	bh=FoXr25pihRsGvoWplY9lKcd/DOl4KWMymXCbOR80aMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDa08zdWzCIIDmZLZcSs+cTceuqHnz5MeSG6aVpLfEo6ybgFeXIoC96H17Ns8mvG2c6ikHkM6EqudFGz78qeWgqDdjPizuRRiJhX8JfiNyD7A2UWrDjGj5Y3UTzqcN8zrQV5u4f/2llws/vhK1cNFkeqLvewUfWlgflbm2ogVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar+GMn7D; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4e4f0020ca3so866656e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717802921; x=1718407721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoXr25pihRsGvoWplY9lKcd/DOl4KWMymXCbOR80aMQ=;
        b=Ar+GMn7DjF+/HrS72LxDltZVETUkHqIZRen/mmajqwZjM3ocjC1yniQVDM6vo55xZ3
         zIiZVxCEScy60wFo1bQ1cltNf3AmjfKGtjEYX6hw/Gu8LdgXFn59xk54w4Rv+89rMICu
         sirwlY4TbV84wjCTZP4eAOniL5ch/ffQw8z4A6rNd2Duv2QIS5gtrRjFFYcV/VLMyKIK
         II6YkiwZDqaJArpC0swqy6NHy7JFvN1uhkBGqz1xaKfm19nDNJprbDDBAv/LaEnEadXm
         8wQzfssrDDd921JODBKLXPwXtNzE8oulaB4DeUKPhdx7Chord/V9wbJ9mPzuH77Aso5Q
         pwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717802921; x=1718407721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoXr25pihRsGvoWplY9lKcd/DOl4KWMymXCbOR80aMQ=;
        b=HNLYlSDAeAr1InTo79OLBh6s3zL+WQ3fT6sIBgIsjyyA6mEPdCnpc4FLU6TKQUljep
         aOtEjJrGwAnphuWszizJ9QZdYffrl0axRkidn6QKx733eHTgco5ZG2LBD00bh/MYWdBH
         +Hfvl4ss00DNKHC4+ggD7R+/zGz653iZJs1GbDy7/ewpGJurbD5g2MW1s2v0WUYBTSdX
         8oktZAt0qUEZUHcDZbjaiI8FM2E8siQGVzAEyH/4Xe7Orxl2Vg8ZjvkJIpIi4NSyzfbZ
         DMZQ8HQPjPgvQH96LHLXE1KCbbvqEeGR67T6+5NT3Uwq3oK1mTzeI8SSR8fm3D/SzDT/
         lqzA==
X-Forwarded-Encrypted: i=1; AJvYcCVQTF3ilMqdC8CWdoev7tBfQg+VUAImf/YZdPNMcgKD/nNjdhwH3096whSqHgE5/2mmEOY7crdn1OMOvq5qrfGXDr0HqWItCSBp1z1L
X-Gm-Message-State: AOJu0Yx4powNigSM0S84mGw3uLQ0XVdfz65tNoQrqFGxoN86ONqnxWuD
	b8BDEvxc5Opty+M1BbwhK0RGAZZJ7Zs43Aoc2PeIqADMgS/4GUwSCXmOI8GPfwWrwn/Tdaz97xZ
	+MmFToq7djmzlXLvYGdnB1g1y7Sc=
X-Google-Smtp-Source: AGHT+IEddrkcciPyjk/jy+C8jOOvaiscpFh798lcV3tGhcixFJW2X9gXquf54JGBLgptrXGl/+0cokSrTnar1XabApQ=
X-Received: by 2002:a05:6122:4124:b0:4d3:31fc:4839 with SMTP id
 71dfb90a1353d-4eb5621b763mr4657457e0c.2.1717802921472; Fri, 07 Jun 2024
 16:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606184818.1566920-1-yosryahmed@google.com>
 <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com> <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
 <7507d075-9f4d-4a9b-836c-1fbb2fbd2257@redhat.com> <CAGsJ_4w_dEyLsPhdJCtRMReXDD116p+U979Yk-8EBu=zx5FWgQ@mail.gmail.com>
 <CAJD7tkYnZCvwUSTAx-N-08b+mVF4yHEdDTbp9oqYrVQXX8M1Cw@mail.gmail.com>
 <CAGsJ_4wAYbofjg99iEr7cEAptH9Ve9WcrSXho8A-Sw54vb8Msw@mail.gmail.com>
 <9374758d-9f81-4e4f-8405-1f972234173e@redhat.com> <CAJD7tkZBzSB_6pAZP0n0nq+W=J1XKQGFzZZLzPmSH0apwaqTNg@mail.gmail.com>
 <CAGsJ_4ywmVbO+nrbcxz9YMdzi_y5qSUG3Cg=3oz3kNpQ6gg6iA@mail.gmail.com> <CAJD7tkZkChE_bGJCnf3u0493PZOe1=+Y8S_nq2=j1uP-BtZ9Mg@mail.gmail.com>
In-Reply-To: <CAJD7tkZkChE_bGJCnf3u0493PZOe1=+Y8S_nq2=j1uP-BtZ9Mg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 8 Jun 2024 06:28:21 +0800
Message-ID: <CAGsJ_4zU0fVj8M-qKnQAKoXdrQrBuQchs_yZ32=e2uY80kvxxA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: Yosry Ahmed <yosryahmed@google.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 7:17=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> [..]
> > > One problem is that even if zswap was never enabled, the warning will
> > > be emitted just if CONFIG_ZSWAP is on. Perhaps we need a variable or
> > > static key if zswap was "ever" enabled.
> > >
> > > Barry, I suspect your is_zswap_enabled() check is deficient for
> > > similar reasons, zswap could have been enabled before then became
> > > disabled.
> >
> > I don't understand this. if zswap was enabled before but is disabled wh=
en
> > I am loading data, will I get corrupted data before zswap was once enab=
led?
> > If not, it seems nothing important.
>
> If zswap was enabled and then disabled, some pages may still be in
> zswap. We do not load the pages from zswap when it is disabled, we
> just stop storing new pages.
>
> So if you just rely in checking whether zswap is enabled at swapin
> time to decide whether to use large folios, you may end up with a
> situation where zswap is disabled, yet parts of the large folio you
> are trying to swapin (or all of it) is in zswap.
>
> This is why I think we'll need to track whether zswap was ever enabled
> instead (or if a page was ever stored).

Thanks! It doesn't seem good. Do we have a simple way to clean zswap
when it is disabled? seems not easy? Just like we do swapoff, or disable
cache, we ensure they are clean - this is a real "disable".

Thanks
Barry

