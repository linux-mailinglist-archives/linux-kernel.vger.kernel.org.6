Return-Path: <linux-kernel+bounces-226875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6E2914521
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C831C220A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B0961FD8;
	Mon, 24 Jun 2024 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSwBhkq3"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E85380F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218574; cv=none; b=cAXDoxUASakaO+v+7FJwwZDB0tPkZTbdXnscCCSDgFGnlvVdTv99fX/ROGvgpXBZCFzXQiwxPV5hk/TOXk76VeYNYiyQP3QfrsOBoKuk1X9b3yzuS3ZuIcDD4OZKSy4d/PSZSdklOLmcXc6K9b34l2w7pmt7jq1ECoYvxgcaiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218574; c=relaxed/simple;
	bh=H04gQLBXt2tlRsXmgVB+VdhulbAmkHUCdyQBQw5Uyfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrivS5TDfHhIOBDCQU7ezPC8Ju9DBa96dAb9P1ezlPrAEDIYODgbyq4oESu+VV8tLDVa4h+uX0vyTDyJQafyEPYu4KiXKhON1hwy39i6zYC5+MTpnmSQjY1V51VQ/MfVerxmikq9UM4KnDemTw3jTqRHpJkTduup1qsAgS3Bu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSwBhkq3; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-80f599697c1so877080241.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719218570; x=1719823370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR3N3XDYh7FxejJhsMIy7jkLqM/HzTfAOmYIWZ3jYno=;
        b=YSwBhkq3/dBr+zXCqgmFOTN7WLusGUVKTxHVjcP2iky38g8IKagVBvS8ABcv42r0Ne
         36xEEf2w2V+PI/u0bchnoZbFxMLNKC56YlmpcpIIvTDRqYP3AXxiQ2fSPphnthac1kvk
         E2SIP2Tg1ObFji2ESzZ/Af9Y3Su2UruaoSRpvg9H/AtjstX3hwJr3eyJTu+c+1fEZNcj
         qZ9K/+lG4uNDGy2668V4nE8avZG/EI8uxeACRgg8BogEBSukwvkWJRc/vMQ3oQk1NdLf
         hXWL3UWUgqSoK1JSKY1Pz69smf73A7hwZGeUgGwy1xRRMB7qJ2wzhG2iELniXrvZO8Gd
         tF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719218570; x=1719823370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QR3N3XDYh7FxejJhsMIy7jkLqM/HzTfAOmYIWZ3jYno=;
        b=lLgAaX3JYoZIccwmf/+V0bVPvRRLpiI4y1YIg+prO3IRs/YTGNWe+5mEULzFRGtPvo
         y3ihcaVP2x/lB8evc5ri/E0WgDaCtW3d+vme2AyzskefZMi1RBdEt+AyQOQBohUctx4d
         hyxCreIi2z93cjEhbV96BD8prrSuk4+vO9wso5BTbJ9s2neHdNo68c7Zg5NFrCpf8mS8
         LHlyN0LAW5jl6OcPfvojInNUGflwAUiyjO263UTg7a60BRT04t0ADLdxMueQTzdjMvit
         3nre6K8y2FNfJNK46Pz35Y1m/qMUnLnGGmaL3RoeBrbLjICDtOpoGv2/NR0VCo9mrIah
         w7GA==
X-Forwarded-Encrypted: i=1; AJvYcCVt5e6E7I2NwlqKdiNHpQDNqmj+1Irs4SlUIimoH1xOeFRI23jwEkzletbzEW1EDUhR5bh86j3VbVncBkDVOcbPvVVTgYny9yq87UhT
X-Gm-Message-State: AOJu0YxPV/tgvCIef1gFy3T8+VYQF0dyXM9XzLds+7ECMxMVFZMZowX4
	NhC4HZ6wXaWo/uLOIgvgvLWmgsvKhJs5/kjIA00gkNcLli5kDIZXy4pjflMGsKjYpUmKCfwY3My
	zkxUKvEVqOWz/AEHk4IrSX4xXNoY=
X-Google-Smtp-Source: AGHT+IEu9YxAg6mAofEAxDSCoMytUMO7lY2xbjkJ2Z6/GdMVLt+4WmxFotDcpmWbDP+RO9wFxWMbMYNU84J3fsxWDa4=
X-Received: by 2002:a67:f48a:0:b0:48d:920a:bd43 with SMTP id
 ada2fe7eead31-48f52b802b1mr3414514137.29.1719218570105; Mon, 24 Jun 2024
 01:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622071231.576056-1-21cnbao@gmail.com> <557d7f05-6ba9-482d-b3fb-29eb72cdf09c@arm.com>
In-Reply-To: <557d7f05-6ba9-482d-b3fb-29eb72cdf09c@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 24 Jun 2024 20:42:38 +1200
Message-ID: <CAGsJ_4zQ0vjX1UM62o0Wsgh9XYW0SGv2cyG5gUpbP_+Tx3WZLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] tools/mm: Introduce a tool to assess swap entry
 allocation for thp_swapout
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	david@redhat.com, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com, 
	ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 8:26=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 22/06/2024 08:12, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > -v2:
> >  * add swap-in which can either be aligned or not aligned, by "-a";
> >    Ying;
> >  * move the program to tools/mm; Ryan;
> >  * try to simulate the scenarios swap is full. Chris;
> >
> > -v1:
> >  https://lore.kernel.org/linux-mm/20240620002648.75204-1-21cnbao@gmail.=
com/
> >
> > I tested Ryan's RFC patchset[1] and Chris's v3[2] using this v2 tool:
> > [1] https://lore.kernel.org/linux-mm/20240618232648.4090299-1-ryan.robe=
rts@arm.com/
> > [2] https://lore.kernel.org/linux-mm/20240614-swap-allocator-v2-0-2a513=
b4a7f2f@kernel.org/
> >
> > Obviously, we're rarely hitting 100% even in the worst case without "-a=
" and with
> > "-s," which is good news!
> > If swapin is aligned w/ "-a" and w/o "-s", both Chris's and Ryan's patc=
hes show
> > a low fallback ratio though Chris's has the numbers above 0% but Ryan's=
 are 0%
> > (value A).
> >
> > The bad news is that unaligned swapin can significantly increase the fa=
llback ratio,
> > reaching up to 85% for Ryan's patch and 95% for Chris's patchset withou=
t "-s." Both
> > approaches approach 100% without "-a" and with "-s" (value B).
> >
> > I believe real workloads should yield a value between A and B. Without =
"-a," and
> > lacking large folios swap-in, this tool randomly swaps in small folios =
without
> > considering spatial locality, which is a factor present in real workloa=
ds. This
> > typically results in values higher than A and lower than B.
> >
> > Based on the below results, I believe that:
>
> Thanks for putting this together and providing such detailed results!
>
> > 1. We truly require large folio swap-in to achieve comparable results w=
ith
> > aligned swap-in(based on the result w/o and w/ "-a")
>
> I certainly agree that as long as we require a high order swap entry to b=
e
> contiguous in the backing store then it looks like we are going to need l=
arge
> folio swap-in to prevent enormous fragmentation. I guess Chris's proposed=
 layer
> of indirection to allow pages to be scattered in the backing store would =
also
> solve the problem? Although, I'm not sure this would work well for zRam?

The challenge is that we also want to take advantage of improving zsmalloc
to save compressed multi-pages. However, it seems quite impossible for
zsmalloc to achieve this for a mTHP is scattered but not put together in
zRAM.

>
> Perhaps another way of looking at this is that we are doing a bad job of
> selecting when to use an mTHP and when not to use one in the first place;
> ideally the workload would access the data across the entire mTHP with hi=
gh
> temporal locality? In that case, we would expect the whole mTHP to be swa=
pped in
> even with the current page-by-page approach. Figuring out this "auto sizi=
ng"
> seems like an incredibly complex problem to solve though.

The good news is that this is exactly what we're implementing in our produc=
ts,
and it has been deployed on millions of phones.

  *  Allocate mTHP and swap in the entire mTHP  in do_swap_page();
  *  If mTHP allocation fails, allocate 16 pages to swap-in in do_swap_page=
();

To be honest, we haven't noticed a visible increase in memory footprint. Th=
is is
likely because Android's anonymous memory exhibits good spatial locality, a=
nd
64KiB strikes a good balance=E2=80=94neither too large nor too small.

The bad news is that I haven't found a way to convince the community this
is universally correct.

>
> > 2. We need a method to prevent small folios from scattering indiscrimin=
ately
> > (based on the result "-a -s")
>
> I'm confused by this statement; as I undersand it, both my and Chris's pa=
tches
> already try to do this. Certainly for mine, when searching for order-0 sp=
ace, I
> search the non-full order-0 clusters first (just like for other orders).
> Although for order-0 I will still fallback to searching any cluster if no=
 space
> is found in an order-0 cluster. What more can we do?
>
> When run against your v1 of the tool with "-s" (v1 always implicily behav=
es as
> if "-a" is specified, right?) my patch gives 0% fallback. So what's the
> difference in v2 that causes higher fallback rate? Possibly just that
> MEMSIZE_SMALLFOLIO has grown by 3MB so that the total memory matches the =
swap
> size (64M)?

Exactly. From my understanding, we've reached a point where small folios ar=
e
struggling to find swap slots. Note that I always swap out mTHP before swap=
ping
out small folios. Additionally, I have already swapped in 1MB small
folios before
swapping out, which means zRAM has 1MB-4KB of redundant space available
for mTHP to swap out.

>
> Thanks,
> Ryan
>
> >
> > *
> > *  Test results on Ryan's patchset:
> > *
> >
> > 1. w/ -a
> > ./thp_swap_allocator_test -a
> > Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 2: swpout inc: 231, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 3: swpout inc: 227, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 4: swpout inc: 222, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > ...
> > Iteration 100: swpout inc: 228, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >
> > 2. w/o -a
> > ./thp_swap_allocator_test
> >
> > Iteration 1: swpout inc: 208, swpout fallback inc: 25, Fallback percent=
age: 10.73%
> > Iteration 2: swpout inc: 118, swpout fallback inc: 114, Fallback percen=
tage: 49.14%
> > Iteration 3: swpout inc: 63, swpout fallback inc: 163, Fallback percent=
age: 72.12%
> > Iteration 4: swpout inc: 45, swpout fallback inc: 178, Fallback percent=
age: 79.82%
> > Iteration 5: swpout inc: 42, swpout fallback inc: 184, Fallback percent=
age: 81.42%
> > Iteration 6: swpout inc: 31, swpout fallback inc: 193, Fallback percent=
age: 86.16%
> > Iteration 7: swpout inc: 27, swpout fallback inc: 201, Fallback percent=
age: 88.16%
> > Iteration 8: swpout inc: 30, swpout fallback inc: 198, Fallback percent=
age: 86.84%
> > Iteration 9: swpout inc: 32, swpout fallback inc: 194, Fallback percent=
age: 85.84%
> > ...
> > Iteration 91: swpout inc: 26, swpout fallback inc: 194, Fallback percen=
tage: 88.18%
> > Iteration 92: swpout inc: 35, swpout fallback inc: 196, Fallback percen=
tage: 84.85%
> > Iteration 93: swpout inc: 33, swpout fallback inc: 191, Fallback percen=
tage: 85.27%
> > Iteration 94: swpout inc: 26, swpout fallback inc: 193, Fallback percen=
tage: 88.13%
> > Iteration 95: swpout inc: 39, swpout fallback inc: 189, Fallback percen=
tage: 82.89%
> > Iteration 96: swpout inc: 28, swpout fallback inc: 196, Fallback percen=
tage: 87.50%
> > Iteration 97: swpout inc: 25, swpout fallback inc: 194, Fallback percen=
tage: 88.58%
> > Iteration 98: swpout inc: 31, swpout fallback inc: 196, Fallback percen=
tage: 86.34%
> > Iteration 99: swpout inc: 32, swpout fallback inc: 202, Fallback percen=
tage: 86.32%
> > Iteration 100: swpout inc: 33, swpout fallback inc: 195, Fallback perce=
ntage: 85.53%
> >
> > 3. w/ -a and -s
> > ./thp_swap_allocator_test -a -s
> > Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 2: swpout inc: 218, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 4: swpout inc: 220, swpout fallback inc: 6, Fallback percenta=
ge: 2.65%
> > Iteration 5: swpout inc: 206, swpout fallback inc: 16, Fallback percent=
age: 7.21%
> > Iteration 6: swpout inc: 233, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 7: swpout inc: 224, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 8: swpout inc: 228, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 9: swpout inc: 217, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 10: swpout inc: 224, swpout fallback inc: 3, Fallback percent=
age: 1.32%
> > Iteration 11: swpout inc: 211, swpout fallback inc: 12, Fallback percen=
tage: 5.38%
> > Iteration 12: swpout inc: 200, swpout fallback inc: 32, Fallback percen=
tage: 13.79%
> > Iteration 13: swpout inc: 189, swpout fallback inc: 29, Fallback percen=
tage: 13.30%
> > Iteration 14: swpout inc: 195, swpout fallback inc: 31, Fallback percen=
tage: 13.72%
> > Iteration 15: swpout inc: 198, swpout fallback inc: 27, Fallback percen=
tage: 12.00%
> > Iteration 16: swpout inc: 201, swpout fallback inc: 17, Fallback percen=
tage: 7.80%
> > Iteration 17: swpout inc: 206, swpout fallback inc: 6, Fallback percent=
age: 2.83%
> > Iteration 18: swpout inc: 220, swpout fallback inc: 14, Fallback percen=
tage: 5.98%
> > Iteration 19: swpout inc: 181, swpout fallback inc: 45, Fallback percen=
tage: 19.91%
> > Iteration 20: swpout inc: 223, swpout fallback inc: 8, Fallback percent=
age: 3.46%
> > Iteration 21: swpout inc: 214, swpout fallback inc: 14, Fallback percen=
tage: 6.14%
> > Iteration 22: swpout inc: 195, swpout fallback inc: 31, Fallback percen=
tage: 13.72%
> > Iteration 23: swpout inc: 223, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 24: swpout inc: 233, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 25: swpout inc: 214, swpout fallback inc: 1, Fallback percent=
age: 0.47%
> > Iteration 26: swpout inc: 229, swpout fallback inc: 1, Fallback percent=
age: 0.43%
> > Iteration 27: swpout inc: 214, swpout fallback inc: 5, Fallback percent=
age: 2.28%
> > Iteration 28: swpout inc: 211, swpout fallback inc: 15, Fallback percen=
tage: 6.64%
> > Iteration 29: swpout inc: 188, swpout fallback inc: 40, Fallback percen=
tage: 17.54%
> > Iteration 30: swpout inc: 207, swpout fallback inc: 18, Fallback percen=
tage: 8.00%
> > Iteration 31: swpout inc: 215, swpout fallback inc: 10, Fallback percen=
tage: 4.44%
> > Iteration 32: swpout inc: 202, swpout fallback inc: 22, Fallback percen=
tage: 9.82%
> > Iteration 33: swpout inc: 223, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 34: swpout inc: 218, swpout fallback inc: 10, Fallback percen=
tage: 4.39%
> > Iteration 35: swpout inc: 203, swpout fallback inc: 30, Fallback percen=
tage: 12.88%
> > Iteration 36: swpout inc: 214, swpout fallback inc: 14, Fallback percen=
tage: 6.14%
> > Iteration 37: swpout inc: 211, swpout fallback inc: 14, Fallback percen=
tage: 6.22%
> > Iteration 38: swpout inc: 193, swpout fallback inc: 28, Fallback percen=
tage: 12.67%
> > Iteration 39: swpout inc: 210, swpout fallback inc: 20, Fallback percen=
tage: 8.70%
> > Iteration 40: swpout inc: 223, swpout fallback inc: 5, Fallback percent=
age: 2.19%
> > Iteration 41: swpout inc: 224, swpout fallback inc: 7, Fallback percent=
age: 3.03%
> > Iteration 42: swpout inc: 200, swpout fallback inc: 23, Fallback percen=
tage: 10.31%
> > Iteration 43: swpout inc: 217, swpout fallback inc: 5, Fallback percent=
age: 2.25%
> > Iteration 44: swpout inc: 206, swpout fallback inc: 18, Fallback percen=
tage: 8.04%
> > Iteration 45: swpout inc: 210, swpout fallback inc: 11, Fallback percen=
tage: 4.98%
> > Iteration 46: swpout inc: 204, swpout fallback inc: 19, Fallback percen=
tage: 8.52%
> > Iteration 47: swpout inc: 228, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 48: swpout inc: 219, swpout fallback inc: 2, Fallback percent=
age: 0.90%
> > Iteration 49: swpout inc: 212, swpout fallback inc: 6, Fallback percent=
age: 2.75%
> > Iteration 50: swpout inc: 207, swpout fallback inc: 15, Fallback percen=
tage: 6.76%
> > Iteration 51: swpout inc: 190, swpout fallback inc: 36, Fallback percen=
tage: 15.93%
> > Iteration 52: swpout inc: 212, swpout fallback inc: 17, Fallback percen=
tage: 7.42%
> > Iteration 53: swpout inc: 179, swpout fallback inc: 43, Fallback percen=
tage: 19.37%
> > Iteration 54: swpout inc: 225, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 55: swpout inc: 224, swpout fallback inc: 2, Fallback percent=
age: 0.88%
> > Iteration 56: swpout inc: 220, swpout fallback inc: 8, Fallback percent=
age: 3.51%
> > Iteration 57: swpout inc: 203, swpout fallback inc: 25, Fallback percen=
tage: 10.96%
> > Iteration 58: swpout inc: 213, swpout fallback inc: 6, Fallback percent=
age: 2.74%
> > Iteration 59: swpout inc: 207, swpout fallback inc: 18, Fallback percen=
tage: 8.00%
> > Iteration 60: swpout inc: 216, swpout fallback inc: 14, Fallback percen=
tage: 6.09%
> > Iteration 61: swpout inc: 183, swpout fallback inc: 34, Fallback percen=
tage: 15.67%
> > Iteration 62: swpout inc: 184, swpout fallback inc: 39, Fallback percen=
tage: 17.49%
> > Iteration 63: swpout inc: 184, swpout fallback inc: 39, Fallback percen=
tage: 17.49%
> > Iteration 64: swpout inc: 210, swpout fallback inc: 15, Fallback percen=
tage: 6.67%
> > Iteration 65: swpout inc: 178, swpout fallback inc: 48, Fallback percen=
tage: 21.24%
> > Iteration 66: swpout inc: 188, swpout fallback inc: 30, Fallback percen=
tage: 13.76%
> > Iteration 67: swpout inc: 193, swpout fallback inc: 29, Fallback percen=
tage: 13.06%
> > Iteration 68: swpout inc: 202, swpout fallback inc: 22, Fallback percen=
tage: 9.82%
> > Iteration 69: swpout inc: 213, swpout fallback inc: 5, Fallback percent=
age: 2.29%
> > Iteration 70: swpout inc: 204, swpout fallback inc: 15, Fallback percen=
tage: 6.85%
> > Iteration 71: swpout inc: 180, swpout fallback inc: 45, Fallback percen=
tage: 20.00%
> > Iteration 72: swpout inc: 210, swpout fallback inc: 21, Fallback percen=
tage: 9.09%
> > Iteration 73: swpout inc: 216, swpout fallback inc: 7, Fallback percent=
age: 3.14%
> > Iteration 74: swpout inc: 209, swpout fallback inc: 19, Fallback percen=
tage: 8.33%
> > Iteration 75: swpout inc: 222, swpout fallback inc: 7, Fallback percent=
age: 3.06%
> > Iteration 76: swpout inc: 212, swpout fallback inc: 14, Fallback percen=
tage: 6.19%
> > Iteration 77: swpout inc: 188, swpout fallback inc: 41, Fallback percen=
tage: 17.90%
> > Iteration 78: swpout inc: 198, swpout fallback inc: 17, Fallback percen=
tage: 7.91%
> > Iteration 79: swpout inc: 209, swpout fallback inc: 16, Fallback percen=
tage: 7.11%
> > Iteration 80: swpout inc: 182, swpout fallback inc: 41, Fallback percen=
tage: 18.39%
> > Iteration 81: swpout inc: 217, swpout fallback inc: 1, Fallback percent=
age: 0.46%
> > Iteration 82: swpout inc: 225, swpout fallback inc: 3, Fallback percent=
age: 1.32%
> > Iteration 83: swpout inc: 222, swpout fallback inc: 8, Fallback percent=
age: 3.48%
> > Iteration 84: swpout inc: 201, swpout fallback inc: 21, Fallback percen=
tage: 9.46%
> > Iteration 85: swpout inc: 211, swpout fallback inc: 3, Fallback percent=
age: 1.40%
> > Iteration 86: swpout inc: 209, swpout fallback inc: 14, Fallback percen=
tage: 6.28%
> > Iteration 87: swpout inc: 181, swpout fallback inc: 42, Fallback percen=
tage: 18.83%
> > Iteration 88: swpout inc: 223, swpout fallback inc: 4, Fallback percent=
age: 1.76%
> > Iteration 89: swpout inc: 214, swpout fallback inc: 14, Fallback percen=
tage: 6.14%
> > Iteration 90: swpout inc: 192, swpout fallback inc: 33, Fallback percen=
tage: 14.67%
> > Iteration 91: swpout inc: 184, swpout fallback inc: 31, Fallback percen=
tage: 14.42%
> > Iteration 92: swpout inc: 201, swpout fallback inc: 32, Fallback percen=
tage: 13.73%
> > Iteration 93: swpout inc: 181, swpout fallback inc: 40, Fallback percen=
tage: 18.10%
> > Iteration 94: swpout inc: 211, swpout fallback inc: 14, Fallback percen=
tage: 6.22%
> > Iteration 95: swpout inc: 198, swpout fallback inc: 25, Fallback percen=
tage: 11.21%
> > Iteration 96: swpout inc: 205, swpout fallback inc: 22, Fallback percen=
tage: 9.69%
> > Iteration 97: swpout inc: 218, swpout fallback inc: 12, Fallback percen=
tage: 5.22%
> > Iteration 98: swpout inc: 203, swpout fallback inc: 25, Fallback percen=
tage: 10.96%
> > Iteration 99: swpout inc: 218, swpout fallback inc: 12, Fallback percen=
tage: 5.22%
> > Iteration 100: swpout inc: 195, swpout fallback inc: 34, Fallback perce=
ntage: 14.85%
> >
> > 4. w/o -a and w/ -s
> > thp_swap_allocator_test  -s
> > Iteration 1: swpout inc: 173, swpout fallback inc: 60, Fallback percent=
age: 25.75%
> > Iteration 2: swpout inc: 85, swpout fallback inc: 147, Fallback percent=
age: 63.36%
> > Iteration 3: swpout inc: 39, swpout fallback inc: 195, Fallback percent=
age: 83.33%
> > Iteration 4: swpout inc: 13, swpout fallback inc: 220, Fallback percent=
age: 94.42%
> > Iteration 5: swpout inc: 10, swpout fallback inc: 215, Fallback percent=
age: 95.56%
> > Iteration 6: swpout inc: 9, swpout fallback inc: 219, Fallback percenta=
ge: 96.05%
> > Iteration 7: swpout inc: 6, swpout fallback inc: 217, Fallback percenta=
ge: 97.31%
> > Iteration 8: swpout inc: 6, swpout fallback inc: 215, Fallback percenta=
ge: 97.29%
> > Iteration 9: swpout inc: 0, swpout fallback inc: 225, Fallback percenta=
ge: 100.00%
> > Iteration 10: swpout inc: 1, swpout fallback inc: 229, Fallback percent=
age: 99.57%
> > Iteration 11: swpout inc: 2, swpout fallback inc: 216, Fallback percent=
age: 99.08%
> > Iteration 12: swpout inc: 2, swpout fallback inc: 229, Fallback percent=
age: 99.13%
> > Iteration 13: swpout inc: 4, swpout fallback inc: 211, Fallback percent=
age: 98.14%
> > Iteration 14: swpout inc: 1, swpout fallback inc: 221, Fallback percent=
age: 99.55%
> > Iteration 15: swpout inc: 2, swpout fallback inc: 223, Fallback percent=
age: 99.11%
> > Iteration 16: swpout inc: 3, swpout fallback inc: 224, Fallback percent=
age: 98.68%
> > Iteration 17: swpout inc: 2, swpout fallback inc: 231, Fallback percent=
age: 99.14%
> > ...
> >
> > *
> > *  Test results on Chris's v3 patchset:
> > *
> > 1. w/ -a
> > ./thp_swap_allocator_test -a
> > Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 2: swpout inc: 231, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 3: swpout inc: 227, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 4: swpout inc: 217, swpout fallback inc: 5, Fallback percenta=
ge: 2.25%
> > Iteration 5: swpout inc: 215, swpout fallback inc: 12, Fallback percent=
age: 5.29%
> > Iteration 6: swpout inc: 213, swpout fallback inc: 14, Fallback percent=
age: 6.17%
> > Iteration 7: swpout inc: 207, swpout fallback inc: 15, Fallback percent=
age: 6.76%
> > Iteration 8: swpout inc: 193, swpout fallback inc: 33, Fallback percent=
age: 14.60%
> > Iteration 9: swpout inc: 214, swpout fallback inc: 13, Fallback percent=
age: 5.73%
> > Iteration 10: swpout inc: 199, swpout fallback inc: 25, Fallback percen=
tage: 11.16%
> > Iteration 11: swpout inc: 208, swpout fallback inc: 14, Fallback percen=
tage: 6.31%
> > Iteration 12: swpout inc: 203, swpout fallback inc: 31, Fallback percen=
tage: 13.25%
> > Iteration 13: swpout inc: 192, swpout fallback inc: 25, Fallback percen=
tage: 11.52%
> > Iteration 14: swpout inc: 193, swpout fallback inc: 36, Fallback percen=
tage: 15.72%
> > Iteration 15: swpout inc: 188, swpout fallback inc: 33, Fallback percen=
tage: 14.93%
> > ...
> >
> > It seems Chris's approach can be negatively affected even by aligned sw=
apin,
> > having a low fallback ratio but not 0% while Ryan's patchset hasn't thi=
s
> > issue.
> >
> > 2. w/o -a
> > ./thp_swap_allocator_test
> > Iteration 1: swpout inc: 209, swpout fallback inc: 24, Fallback percent=
age: 10.30%
> > Iteration 2: swpout inc: 100, swpout fallback inc: 132, Fallback percen=
tage: 56.90%
> > Iteration 3: swpout inc: 43, swpout fallback inc: 183, Fallback percent=
age: 80.97%
> > Iteration 4: swpout inc: 30, swpout fallback inc: 193, Fallback percent=
age: 86.55%
> > Iteration 5: swpout inc: 21, swpout fallback inc: 205, Fallback percent=
age: 90.71%
> > Iteration 6: swpout inc: 10, swpout fallback inc: 214, Fallback percent=
age: 95.54%
> > Iteration 7: swpout inc: 16, swpout fallback inc: 212, Fallback percent=
age: 92.98%
> > Iteration 8: swpout inc: 9, swpout fallback inc: 219, Fallback percenta=
ge: 96.05%
> > Iteration 9: swpout inc: 6, swpout fallback inc: 220, Fallback percenta=
ge: 97.35%
> > Iteration 10: swpout inc: 7, swpout fallback inc: 221, Fallback percent=
age: 96.93%
> > Iteration 11: swpout inc: 7, swpout fallback inc: 222, Fallback percent=
age: 96.94%
> > Iteration 12: swpout inc: 8, swpout fallback inc: 212, Fallback percent=
age: 96.36%
> > ..
> >
> > Ryan's fallback ratio(around 85%) seems to be a little better while bot=
h are much
> > worse than "-a".
> >
> > 3. w/ -a and -s
> > ./thp_swap_allocator_test -a -s
> > Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 2: swpout inc: 213, swpout fallback inc: 5, Fallback percenta=
ge: 2.29%
> > Iteration 3: swpout inc: 215, swpout fallback inc: 7, Fallback percenta=
ge: 3.15%
> > Iteration 4: swpout inc: 210, swpout fallback inc: 16, Fallback percent=
age: 7.08%
> > Iteration 5: swpout inc: 212, swpout fallback inc: 10, Fallback percent=
age: 4.50%
> > Iteration 6: swpout inc: 215, swpout fallback inc: 18, Fallback percent=
age: 7.73%
> > Iteration 7: swpout inc: 181, swpout fallback inc: 43, Fallback percent=
age: 19.20%
> > Iteration 8: swpout inc: 173, swpout fallback inc: 55, Fallback percent=
age: 24.12%
> > Iteration 9: swpout inc: 163, swpout fallback inc: 54, Fallback percent=
age: 24.88%
> > Iteration 10: swpout inc: 168, swpout fallback inc: 59, Fallback percen=
tage: 25.99%
> > Iteration 11: swpout inc: 154, swpout fallback inc: 69, Fallback percen=
tage: 30.94%
> > Iteration 12: swpout inc: 166, swpout fallback inc: 66, Fallback percen=
tage: 28.45%
> > Iteration 13: swpout inc: 165, swpout fallback inc: 53, Fallback percen=
tage: 24.31%
> > Iteration 14: swpout inc: 158, swpout fallback inc: 68, Fallback percen=
tage: 30.09%
> > Iteration 15: swpout inc: 168, swpout fallback inc: 57, Fallback percen=
tage: 25.33%
> > Iteration 16: swpout inc: 165, swpout fallback inc: 53, Fallback percen=
tage: 24.31%
> > Iteration 17: swpout inc: 163, swpout fallback inc: 49, Fallback percen=
tage: 23.11%
> > Iteration 18: swpout inc: 172, swpout fallback inc: 62, Fallback percen=
tage: 26.50%
> > Iteration 19: swpout inc: 183, swpout fallback inc: 43, Fallback percen=
tage: 19.03%
> > Iteration 20: swpout inc: 158, swpout fallback inc: 73, Fallback percen=
tage: 31.60%
> > Iteration 21: swpout inc: 147, swpout fallback inc: 81, Fallback percen=
tage: 35.53%
> > Iteration 22: swpout inc: 140, swpout fallback inc: 86, Fallback percen=
tage: 38.05%
> > Iteration 23: swpout inc: 144, swpout fallback inc: 79, Fallback percen=
tage: 35.43%
> > Iteration 24: swpout inc: 132, swpout fallback inc: 101, Fallback perce=
ntage: 43.35%
> > Iteration 25: swpout inc: 133, swpout fallback inc: 82, Fallback percen=
tage: 38.14%
> > Iteration 26: swpout inc: 152, swpout fallback inc: 78, Fallback percen=
tage: 33.91%
> > Iteration 27: swpout inc: 138, swpout fallback inc: 81, Fallback percen=
tage: 36.99%
> > Iteration 28: swpout inc: 152, swpout fallback inc: 74, Fallback percen=
tage: 32.74%
> > Iteration 29: swpout inc: 153, swpout fallback inc: 75, Fallback percen=
tage: 32.89%
> > Iteration 30: swpout inc: 151, swpout fallback inc: 74, Fallback percen=
tage: 32.89%
> > ...
> >
> > Chris's approach appears to be more susceptible to negative effects fro=
m
> > small folios.
> >
> > 4. w/o -a and w/ -s
> > ./thp_swap_allocator_test -s
> > Iteration 1: swpout inc: 183, swpout fallback inc: 50, Fallback percent=
age: 21.46%
> > Iteration 2: swpout inc: 75, swpout fallback inc: 157, Fallback percent=
age: 67.67%
> > Iteration 3: swpout inc: 33, swpout fallback inc: 201, Fallback percent=
age: 85.90%
> > Iteration 4: swpout inc: 11, swpout fallback inc: 222, Fallback percent=
age: 95.28%
> > Iteration 5: swpout inc: 10, swpout fallback inc: 215, Fallback percent=
age: 95.56%
> > Iteration 6: swpout inc: 7, swpout fallback inc: 221, Fallback percenta=
ge: 96.93%
> > Iteration 7: swpout inc: 2, swpout fallback inc: 221, Fallback percenta=
ge: 99.10%
> > Iteration 8: swpout inc: 4, swpout fallback inc: 217, Fallback percenta=
ge: 98.19%
> > Iteration 9: swpout inc: 0, swpout fallback inc: 225, Fallback percenta=
ge: 100.00%
> > Iteration 10: swpout inc: 3, swpout fallback inc: 227, Fallback percent=
age: 98.70%
> > Iteration 11: swpout inc: 1, swpout fallback inc: 217, Fallback percent=
age: 99.54%
> > Iteration 12: swpout inc: 2, swpout fallback inc: 229, Fallback percent=
age: 99.13%
> > Iteration 13: swpout inc: 1, swpout fallback inc: 214, Fallback percent=
age: 99.53%
> > Iteration 14: swpout inc: 2, swpout fallback inc: 220, Fallback percent=
age: 99.10%
> > Iteration 15: swpout inc: 1, swpout fallback inc: 224, Fallback percent=
age: 99.56%
> > Iteration 16: swpout inc: 3, swpout fallback inc: 224, Fallback percent=
age: 98.68%
> > ...
> >
> > Barry Song (1):
> >   tools/mm: Introduce a tool to assess swap entry allocation for
> >     thp_swapout
> >
> >  tools/mm/Makefile                  |   2 +-
> >  tools/mm/thp_swap_allocator_test.c | 233 +++++++++++++++++++++++++++++
> >  2 files changed, 234 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/mm/thp_swap_allocator_test.c
> >
>

Thanks
Barry

