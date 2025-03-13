Return-Path: <linux-kernel+bounces-558739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB73A5EA43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22161898D52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7444413B29B;
	Thu, 13 Mar 2025 03:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2TZOL/t"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571CD4CB5B;
	Thu, 13 Mar 2025 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741837956; cv=none; b=KmMk94Zug9xzQwhiuNYG07FZ5cB47ot5gCVx0NMEtExtVByN7RdYh9K+MhFeUDvaQvRfWDs9/PpNHE+BgG1L22zBHIybWrdfwQhKH/aiY6axSGXU82ViM2dNSJKaOtoUvRqcoqzNOXhKJO2tkTupni0F8aGm/9K5HrjHk9Ip9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741837956; c=relaxed/simple;
	bh=CAK6VJsQ4Lt/XG3e6oAlqT4JOIEJttj6FNNZIocFiw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4QNOOMWEBceJkZiTlvk38HVnGOZ+uJekh/xoRuQENMUEowHIH0Ns31A3U8KFUoWnCGMXhZDAaGh+RneK6h1DHW4UMZDbRB43bKesQ+5ziPFc67RAKo0Uml7wGscCyA6WeHua7YvmM0g7GewzWeWDRiwQ67AoPKQ5zsl/tJAqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2TZOL/t; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so525414241.3;
        Wed, 12 Mar 2025 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741837954; x=1742442754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dixt0o39GPmiD7R1LFsj4ci5HN2s7q23k30NE+Mi48k=;
        b=D2TZOL/tca4s1bx3/iUWe5IyegeK/k4qf8GezzxpmbeWmVilF/K2ppLFspUxeT41MG
         AS5AVrzLdGOOZuZUmz/YwPNT/+glsePExfTBZ56yHd2gzVz2q0aorQUKv0yNX+9gvtay
         Yu5bF767NDXfRrMKz0HnC5G2qmFIcthcKh6fTNorv6fTUeAw05RG+4dpFmTQ2BSej2nj
         a/6US/Hz9FScmMa8dUnef7UUiSjlURpZ3SGJiQoAgLNRKlB+k8d4Qv1adiCjiiFZVb1C
         LYXvWzpz1nZt9E9k9/SZCGQGf0M1RdvpZZShoL/Vz66eifwUeBDElIdWTn/jYCkZuQXn
         iacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741837954; x=1742442754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dixt0o39GPmiD7R1LFsj4ci5HN2s7q23k30NE+Mi48k=;
        b=hc6BvSC6OXppMo2Dlll3dqk542bzinBzq3d1B/QgEzgk07NF0QkyXC3PwQD67THVNN
         rnZeWzJU0owZ1xirsmDaLEIOgdCIKeDtqExD2yCFoxkBZUSfbaae68wYWBHjIQ79Bp6d
         +J/m+5XSW0NuuMUksfarfNhlakvyDRvAjxMrFjzDC2+4y6YQhfwlrWKI/Fq/WpDOkqWe
         wRZW3BrHi8tN9gFbR9mMm100xjFJj3uaugXXVxcZXPNVQC/lT+tLucp6BSbsI/Y3OaNB
         DOvQF7U+HLJ6NMtFPCUYM6QqEgO618bX3ZNWwXuhlKgEXxKnz5yBZI0lCUJ3uDA5jbXA
         AAAA==
X-Forwarded-Encrypted: i=1; AJvYcCVTGgW0Je7JGySloo+EFOujGqmlzRNMgGyaBRqg5TmR29vIYza6Zfrdjzrn2W1b0Wu1PoJGPRTDXuUH4A==@vger.kernel.org, AJvYcCX0ZnBBTrPIDx7bbE93UwlpfN8kcOZhtF2any+hBGc3wgtvls5zF6fJhh11j65aErSE0ODF3blfq30dRyZl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6rSQI6eusl5O8mTffOx5M94agcDxvtqIs1SpfvtCHAh6sK3vi
	blud6nPUKfnTgyJ82eB8TaBODMxkVKujiKoafoClI+DKqz6B1YnGR+guixVnyY/9TRyjr1IHkjK
	d3Be4T828HpvDyHWGG5n5lvtRkMc=
X-Gm-Gg: ASbGnctLh0uuGYPI9e55z08LwrFPa5QNcm8jJ25TYrCxuXpII06X5LQfKmxVzcijO1N
	fKrLSLiQvhsJNPkwoVTH1fb/eIzpcp9fjiGMX/f2y0vb3Tonv2aTcciR9CfE4+Tub0aW/TQpLcQ
	H2Ep4LNcsv5m5nR7xGbdOfVkITpfxuq7mBkCvACg==
X-Google-Smtp-Source: AGHT+IElZnLD1RtQvQ1Xa/HL9SBtcFTvUikPJzrreCJkAkwTjpXP1UpN4dl74wMUECd2sr+yNxTt2PDKxbQqviHf2Wo=
X-Received: by 2002:a05:6102:41a8:b0:4bb:c24b:b61a with SMTP id
 ada2fe7eead31-4c30a6d23e9mr19456122137.19.1741837954156; Wed, 12 Mar 2025
 20:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <Z9HOavSkFf01K9xh@google.com> <5gqqbq67th4xiufiw6j3ewih6htdepa4u5lfirdeffrui7hcdn@ly3re3vgez2g>
In-Reply-To: <5gqqbq67th4xiufiw6j3ewih6htdepa4u5lfirdeffrui7hcdn@ly3re3vgez2g>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 13 Mar 2025 16:52:22 +1300
X-Gm-Features: AQ5f1JrExyj5F0Vah_a1_rjhnAnivAK4d453p9csn5RazKNq_dZhJV200JGLGds
Message-ID: <CAGsJ_4yw17rLJPgS6CNXfXNVQnv2pf0PnLSA4UVAR1sUWDhP5Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Improve Zram by separating compression context from kswapd
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Qun-Wei Lin <qun-wei.lin@mediatek.com>, 
	Jens Axboe <axboe@kernel.dk>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Casper Li <casper.li@mediatek.com>, Chinwen Chang <chinwen.chang@mediatek.com>, 
	Andrew Yang <andrew.yang@mediatek.com>, James Hsu <james.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 4:09=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/03/12 11:11), Minchan Kim wrote:
> > On Fri, Mar 07, 2025 at 08:01:02PM +0800, Qun-Wei Lin wrote:
> > > This patch series introduces a new mechanism called kcompressd to
> > > improve the efficiency of memory reclaiming in the operating system. =
The
> > > main goal is to separate the tasks of page scanning and page compress=
ion
> > > into distinct processes or threads, thereby reducing the load on the
> > > kswapd thread and enhancing overall system performance under high mem=
ory
> > > pressure conditions.
> > >
> > > Problem:
> > >  In the current system, the kswapd thread is responsible for both
> > >  scanning the LRU pages and compressing pages into the ZRAM. This
> > >  combined responsibility can lead to significant performance bottlene=
cks,
> > >  especially under high memory pressure. The kswapd thread becomes a
> > >  single point of contention, causing delays in memory reclaiming and
> > >  overall system performance degradation.
> >
> > Isn't it general problem if backend for swap is slow(but synchronous)?
> > I think zram need to support asynchrnous IO(can do introduce multiple
> > threads to compress batched pages) and doesn't declare it's
> > synchrnous device for the case.
>
> The current conclusion is that kcompressd will sit above zram,
> because zram is not the only compressing swap backend we have.

also. it is not good to hack zram to be aware of if it is kswapd
, direct reclaim , proactive reclaim and block device with
mounted filesystem.

so i am thinking sth as below

page_io.c

if (sync_device or zswap_enabled())
   schedule swap_writepage to a separate per-node thread

btw,  ran the current patchset with one thread(not default 4)
on phones and saw 50%+ allocstall reduction. so the idea
looks like a good direction to go.

Thanks
Barry

