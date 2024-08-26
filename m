Return-Path: <linux-kernel+bounces-302110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD2495F9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD1BB22C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B5112CD89;
	Mon, 26 Aug 2024 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajPZObjA"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442AA1F943
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701593; cv=none; b=rfPYQZcZkOQfPONRhe4D9nyOp0IucDDEV7ETJSsrpdmEdEFnuJ/A7pjqv6XgCTgvmHCO434UcdsL+gWXYgRKyUjtR3bEsNX93+b0dQHMoUDRYNO53gtsvH8/Sp8kZVOuidfJyEjbb7lgTOEdFUVzX2px7IgADu8HFXyWnzOKDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701593; c=relaxed/simple;
	bh=FT0Hw62fCG93HERjwl90JnMREgtvpMGelThq898G1fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2bD6ChmLweSF5n4TKIBosjDlSjFqTsRQRiT5acRz4e2PZ9bWTlhM1sh8gT7sHdadps29fof0oUAyzLGQip86WPdFrh77VuDsrTs9O7qztmn8OWJc2jYPRJ/4ifwQz1ZJRj6TkOFsd0AqwfzD9qc/qXSB8MIdgy+JI1C5ZU3DoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajPZObjA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf7658f4aaso24963036d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724701591; x=1725306391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkcwhp5wUP0PARWUzg25EzXMSiZptOh2qK3AVZk7sM4=;
        b=ajPZObjAEDFlJx3hoYGNUd3oZGcMFqMUyTZDQQwm/Xzc2bm4hvQ8Tn0S/dcJWFis2D
         Xt08dnPq5cVzKTTnB/l5VubCsPUD84evGAShA7QIjHiphr7dNBd92RPFBsqG/mYtJHUo
         2QCOUBaV3ZMriOoBtYXWmbKUWS1P7ZZBka4IKnUSlEaHqycpyNN+vXn15A/cBnVsTIou
         L7N2ERtHf205a7pXzXoOLicAOlBs2aaxyhVwN2/ws1+L0oO42Wn3znuiEMm3rd+guiTf
         qHXknHQK9mmOafTQ89/x9C6pmHXRX/xIwzNbYieWl823Q6yAZUBIO/ZlFTOqMkvS1uVN
         Ns8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724701591; x=1725306391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkcwhp5wUP0PARWUzg25EzXMSiZptOh2qK3AVZk7sM4=;
        b=Jou5mORwIPo3Pt/NMHo21I2a2nuxvjj1fMiH3BYISIh4nWLfmNJHvLap/dnUKkyxOu
         1r3AHBRGLFmtl7n0sFTXyFTdgTFYmns3K5YZmo6mOk6scK5TSXb+hVYAS2X8FBaHHJeN
         DuJJhuX06DTTPwdBu9dDBlmMw9eoEVtisEvp/Rss85O/PEpB5+t0oc9FuCfy+krw5S7h
         4NOhAabziwyaTIBXO2xjo89OjoyTKDIr8QrylkPLli07FQ1JprvoBBh49V++G5xSMzth
         HA+cNILVLqedxLMoLYhL+HkjE6LrhFqYoqj2w10PF2oBnUP6vhD9WUMMXxAJ2qd7vmlB
         K4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhpHY80M/sNzolIbx0xzynDAvZtL2VU1nDXoL7tXjBw9v504alVPWEK4Xh8Us+KjSeoZy3ZfgZSAO6OdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfgP+GZebRpMQbjD032aA7spIThMRz2EIxcNWTuyKLgqp555a
	GNDO9fEvGP7LmPAi0mRk+apjhmOhq6tYku3HjDWElWZjYE52SfZQhnsnBrETi4EUfF+o6zQCvtm
	8Peh3N8R9DxHQzFbeEqEIGLEcMHU=
X-Google-Smtp-Source: AGHT+IEzelaGzWbS77Np0l8c2438Rxo5NWk0QoxlbS0DBGhDscOGwbnwXNj8sR5VP+DAMuyPNrBeK4US8tc9JoLZrN0=
X-Received: by 2002:a05:6214:2b84:b0:6bf:6dc2:e002 with SMTP id
 6a1803df08f44-6c32b677f0bmr6678776d6.12.1724701590962; Mon, 26 Aug 2024
 12:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821074541.516249-1-hanchuanhua@oppo.com> <20240821074541.516249-3-hanchuanhua@oppo.com>
 <qim6ug5d3ibrn6mgrk7oybml7qatgw654y2t6wlc25pnpddr2i@yniwf64alx23>
 <CAGsJ_4wgC+yaCYinv8FYm9RHJfT5wiFxHMn_WTGysdpiH0HS7g@mail.gmail.com> <i6jki2zocqzsjcjgraf6lyl7m3cjzv5lnsuluq5xnvznw7bsge@4easx2ucpxml>
In-Reply-To: <i6jki2zocqzsjcjgraf6lyl7m3cjzv5lnsuluq5xnvznw7bsge@4easx2ucpxml>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Aug 2024 07:46:19 +1200
Message-ID: <CAGsJ_4wGK6pu+KNhYjpWgydp6DyjH5tE=9+mje3UyrXdFJOuNw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hanchuanhua@oppo.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shy828301@gmail.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, hch@infradead.org, 
	ryncsn@gmail.com, Tangquan Zheng <zhengtangquan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 5:56=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Hi Barry,
>
> On Thu, Aug 22, 2024 at 05:13:06AM GMT, Barry Song wrote:
> > On Thu, Aug 22, 2024 at 1:31=E2=80=AFAM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Wed, Aug 21, 2024 at 03:45:40PM GMT, hanchuanhua@oppo.com wrote:
> > > > From: Chuanhua Han <hanchuanhua@oppo.com>
> > > >
> > > >
> > > > 3. With both mTHP swap-out and swap-in supported, we offer the opti=
on to enable
> > > >    zsmalloc compression/decompression with larger granularity[2]. T=
he upcoming
> > > >    optimization in zsmalloc will significantly increase swap speed =
and improve
> > > >    compression efficiency. Tested by running 100 iterations of swap=
ping 100MiB
> > > >    of anon memory, the swap speed improved dramatically:
> > > >                 time consumption of swapin(ms)   time consumption o=
f swapout(ms)
> > > >      lz4 4k                  45274                    90540
> > > >      lz4 64k                 22942                    55667
> > > >      zstdn 4k                85035                    186585
> > > >      zstdn 64k               46558                    118533
> > >
> > > Are the above number with the patch series at [2] or without? Also ca=
n
> > > you explain your experiment setup or how can someone reproduce these?
> >
> > Hi Shakeel,
> >
> > The data was recorded after applying both this patch (swap-in mTHP) and
> > patch [2] (compressing/decompressing mTHP instead of page). However,
> > without the swap-in series, patch [2] becomes useless because:
> >
> > If we have a large object, such as 16 pages in zsmalloc:
> > do_swap_page will happen 16 times:
> > 1. decompress the whole large object and copy one page;
> > 2. decompress the whole large object and copy one page;
> > 3. decompress the whole large object and copy one page;
> > ....
> > 16.  decompress the whole large object and copy one page;
> >
> > So, patchset [2] will actually degrade performance rather than
> > enhance it if we don't have this swap-in series. This swap-in
> > series is a prerequisite for the zsmalloc/zram series.
>
> Thanks for the explanation.
>
> >
> > We reproduced the data through the following simple steps:
> > 1. Collected anonymous pages from a running phone and saved them to a f=
ile.
> > 2. Used a small program to open and read the file into a mapped anonymo=
us
> > memory.
> > 3.  Do the belows in the small program:
> > swapout_start_time
> > madv_pageout()
> > swapout_end_time
> >
> > swapin_start_time
> > read_data()
> > swapin_end_time
> >
> > We calculate the throughput of swapout and swapin using the difference =
between
> > end_time and start_time. Additionally, we record the memory usage of zr=
am after
> > the swapout is complete.
> >
>
> Please correct me if I am wrong but you are saying in your experiment,
> 100 MiB took 90540 ms to compress/swapout and 45274 ms to
> decompress/swapin if backed by 4k pages but took 55667 ms and 22942 ms
> if backed by 64k pages. Basically the table shows total time to compress
> or decomress 100 MiB of memory, right?

Hi Shakeel,
Tangquan(CC'd) collected the data and double-checked the case to confirm
the answer to your question.

We have three cases:
1. no mTHP swap-in, no zsmalloc/zram multi-pages compression/decompression
2. have mTHP swap-in, no zsmalloc/zram multi-pages compression/decompressio=
n
3. have mTHP swap-in, have zsmalloc/zram multi-pages compression/decompress=
ion

The data was 1 vs 3.

To provide more precise data that covers each change, Tangquan tested
1 vs. 2 and
2 vs. 3 yesterday using LZ4 (the hardware might differ from the
previous test, but the
data shows the same trend) per my request.

1. no mTHP swapin, no zsmalloc/zram patch
swapin_ms.   30336
swapout_ms. 65651

2. have mTHP swapin, no zsmalloc/zram patch
swapin_ms.   27161
swapout_ms. 61135

3. have mTHP swapin, have zsmalloc/zram patch
swapin_ms.   13683
swapout_ms. 43305

The test pseudocode is as follows:

addr=3Dmmap(100M)
read_anon_data_from_file_to addr();

for(i=3D0;i<100;i++) {
      swapout_start_time;
      madv_pageout();
      swapout_end_time;
      swapin_start_time;
      read_addr_to_swapin();
      swapin_end_time;
}

So, while we saw some improvement from 1 to 2, the significant gains
come from using large blocks for compression and decompression.

This mTHP swap-in series ensures that mTHPs aren't lost after the first swa=
p-in,
so the following 99 iterations continue to involve THP swap-out and
mTHP swap-in.
The improvement from 1 to 2 is due to this mTHP swap-in series, while the
improvement from 2 to 3 comes from the zsmalloc/zram patchset [2] you
mentioned.

[2] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.com/

> > >
> >

Thanks
Barry

