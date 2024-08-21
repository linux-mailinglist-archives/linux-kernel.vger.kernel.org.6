Return-Path: <linux-kernel+bounces-296155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E2895A657
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E117D1C2232A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433C0170A37;
	Wed, 21 Aug 2024 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2XeSoPW"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081FF16EB5F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274800; cv=none; b=nRN77TGhloxU79069cgz5EqksERDdBQmbjs6X5SLDVbaC8XD1GFItHXG6CtHr1c+Fy29fawcEbDNXGdHO6gMnjLGTadumK2gfa+EQ4Ses9z6Y8fvyrDC8exv1cCVp5gvcl13hY5T8GOByk/2iy+eBDtHXG1RydWO+LrgVxPK1Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274800; c=relaxed/simple;
	bh=hPE8e0nDJ3vjJizX1yPE9sPDn+EHd9HtNgoU+Ab90bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWyLjxoyfZgSiEWDoIz/qOyqauzzMO4aG9KKnCBG+TPVv7d7iYaloDpr53FFxGnEi8IPi2lNQPW3czb1knqIXhl/OldxS+bHYovoX61bTg/s+4UxtaeGF9sIHpuCLm9x7JabuKg6zszEorKUbpu1CfZah4wzKa/6RUD3GUny18c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2XeSoPW; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-842fe7187b3so46183241.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724274798; x=1724879598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2O1JoDxU9kDe9y5+KIXDvq6QJWLz1iNgPtLbdhgykc=;
        b=O2XeSoPW9Vmr4fSOkmPfp7WRtb3vztz5C3fk6tHbl09KoMvztTUcFayb8gPBjOlA6T
         2cq9ZFlRtiWGprFzDdlgMj2Lnxn5VXLSa1J6kKG9bnkM0c9DV0OUO07cOnTCsLlHo/Ex
         CNqQAbTaOUCHbFGcDJhfCeW8kfbz0QGz9GnG4MSUWvJz4mxvEAjKCGZ7K9w7Zf5uT6hr
         Pyzi/zNFD/wrwdc4H32no0tb6VOFsxBzcSlVhWoPAFQgxY7VCqrmxTNwWEtm0yZq31Dj
         hLL/opOEhnhHPVIFby9+6J+atiMT2lLhO93v0ZPYUwT+Kh4NSXZmfyBjOnbgPjlFF00Q
         yczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724274798; x=1724879598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2O1JoDxU9kDe9y5+KIXDvq6QJWLz1iNgPtLbdhgykc=;
        b=HsOLbI3n3E371copPISN0/tKwju+rmGjQ1NFnpRkBh8Ou1eS3yQMN28BK6xJ/mVNyM
         d7tyQ9GdnkocLO5pDw6XHo4xxnubFKOyCBpP02LwHHUauC9s2TeP38EXZdWmWU15FjHf
         xGcrkKNtMSottqrWEReGv3o9LLf2ILxRwNoplRrzNsjbUmbVh9WSdam96aWFWVWWYpqM
         pxKVpK49II465XccbkjIbBhwPr92k13x0+G5joEOl6ydaKtHp9xAZiDBiT5LIlvsoqaZ
         HXxrHsVSLGC8De7QyUV1sVUm72SWYkt0wF3VFNlN5U1NHQ6+IPiIPL78q3xacYbl/s+8
         TyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfDkl2/EDoZRRiECqowwJJOHv9CzvGFs3Hytsxqv0LAWSzHx7tHaUOr34lIy5NoO8IW38UpqN09VFK16Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJmdeZrkVC4ElXCuYgayFpqYJ+2RtiR8drleG2EkF1DCcuOrg4
	qIu9GXPy8WxZjf3WlUkWpqphSxzr+2A4AaqYz3SRVFzHlJ4mXxj97/MbJPkIy1tHdi9XSpR/MDC
	ZjFU645BtUSA3ueRvHBUsKPwVgvs=
X-Google-Smtp-Source: AGHT+IH1ZeFh/1Y3kn9DHRZ43+4kdmu5+2f/xLgaBgzi5/jsg9ZnudHuJB5WU+nuIc6BsfXEGG56PqGfzMBkJR8ie7s=
X-Received: by 2002:a05:6122:4698:b0:4fc:e713:6572 with SMTP id
 71dfb90a1353d-4fcf1b98922mr5165569e0c.11.1724274797848; Wed, 21 Aug 2024
 14:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821074541.516249-1-hanchuanhua@oppo.com> <20240821074541.516249-3-hanchuanhua@oppo.com>
 <qim6ug5d3ibrn6mgrk7oybml7qatgw654y2t6wlc25pnpddr2i@yniwf64alx23>
In-Reply-To: <qim6ug5d3ibrn6mgrk7oybml7qatgw654y2t6wlc25pnpddr2i@yniwf64alx23>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 22 Aug 2024 05:13:06 +0800
Message-ID: <CAGsJ_4wgC+yaCYinv8FYm9RHJfT5wiFxHMn_WTGysdpiH0HS7g@mail.gmail.com>
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
	ryncsn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 1:31=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Wed, Aug 21, 2024 at 03:45:40PM GMT, hanchuanhua@oppo.com wrote:
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> >
> > 3. With both mTHP swap-out and swap-in supported, we offer the option t=
o enable
> >    zsmalloc compression/decompression with larger granularity[2]. The u=
pcoming
> >    optimization in zsmalloc will significantly increase swap speed and =
improve
> >    compression efficiency. Tested by running 100 iterations of swapping=
 100MiB
> >    of anon memory, the swap speed improved dramatically:
> >                 time consumption of swapin(ms)   time consumption of sw=
apout(ms)
> >      lz4 4k                  45274                    90540
> >      lz4 64k                 22942                    55667
> >      zstdn 4k                85035                    186585
> >      zstdn 64k               46558                    118533
>
> Are the above number with the patch series at [2] or without? Also can
> you explain your experiment setup or how can someone reproduce these?

Hi Shakeel,

The data was recorded after applying both this patch (swap-in mTHP) and
patch [2] (compressing/decompressing mTHP instead of page). However,
without the swap-in series, patch [2] becomes useless because:

If we have a large object, such as 16 pages in zsmalloc:
do_swap_page will happen 16 times:
1. decompress the whole large object and copy one page;
2. decompress the whole large object and copy one page;
3. decompress the whole large object and copy one page;
....
16.  decompress the whole large object and copy one page;

So, patchset [2] will actually degrade performance rather than
enhance it if we don't have this swap-in series. This swap-in
series is a prerequisite for the zsmalloc/zram series.

We reproduced the data through the following simple steps:
1. Collected anonymous pages from a running phone and saved them to a file.
2. Used a small program to open and read the file into a mapped anonymous
memory.
3.  Do the belows in the small program:
swapout_start_time
madv_pageout()
swapout_end_time

swapin_start_time
read_data()
swapin_end_time

We calculate the throughput of swapout and swapin using the difference betw=
een
end_time and start_time. Additionally, we record the memory usage of zram a=
fter
the swapout is complete.

>
> > [2] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.co=
m/
>

Thanks
Barry

