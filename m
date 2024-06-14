Return-Path: <linux-kernel+bounces-214635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D452B90876D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C50B24B49
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAC11922E4;
	Fri, 14 Jun 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMg1JEWD"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1482AEE9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357369; cv=none; b=VKIeMuR4OO3oU6i5L73FLCmBSVds4+EIbGNBVSldNoqabU16pda+Qa7ajy84uqygkmBDbh4ExrXvCCfP7DUTEs+ulLCSIwNsVrp9YDLblNoawEXd3VjXMbQBI8WZeRai5xLaMwDZySRXmqhxKwBW+BiGZgeZOZG3L0vWqssz62k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357369; c=relaxed/simple;
	bh=2EFgdU2m8MZMkfNPC/OdfW+RXLLf0iLElY/mcH8eE44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2P4NG73eVrBHUqUlbjSvgddtlITRLstaMBLF5U8Ln8cJUZJxKAx0p5DF1spPIGOUx9KaBp0gAYpjaljanuTQIKIDtAnKVnjMFQjyxlqhczVMuDjd+YtrsiUI4XnhL9Qz1aIhgxDBtTuil21Bhcf/QCAG3Rzckjz9HJbZmShnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMg1JEWD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a1fe6392eso2584093a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718357366; x=1718962166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EFgdU2m8MZMkfNPC/OdfW+RXLLf0iLElY/mcH8eE44=;
        b=RMg1JEWDOKlQBP4Exg5GO+jkD3sjKzKNUMC7grM2QA6evW1W4n1jYuwqpLlUtiX56s
         +ayzbzaIXUtbISMaelgsoG+go5KrlwHkPRWEiGXKlSIQEwVCaGsebwPTdbsly09VeJVz
         Oj3C54biCNPZIiHrFGqdCGJCNrXbXiJuYRYJ8j36nOZCaY5zlmhWXNMlQufSAcPhAiON
         3LTRMJsU81xas9hDYA46+0DJX9J3TfWfvILDR38xn3il1UAOApFpdsFKm4mI84cYsi9s
         JlzFHcfe290K1db7YX9Q0lfOgBLHOBM4MUCGDh2K2pNasx2+Ck87QL7eRY8NNdGh9Y2G
         cYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718357366; x=1718962166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EFgdU2m8MZMkfNPC/OdfW+RXLLf0iLElY/mcH8eE44=;
        b=SNyAi/kQnUl90AE2LD3s9YGBmf/CuhESH1H36LHSbXDlpuQ8qKzjCSmwWpoZsB3Qlp
         v+6ugXycbRNcig2dV4z2FwKP/8uiDElr2RBbQsqpGL3FOee1QXYjfWssuJ2TByRKYSWP
         hjRQFmhcp9zoe+hnMvfyx9tKAOavk3EV9ItPZpU/3Mx/HgqT/3CHoNcLJcdFWgyqwa0I
         HHZFPfG25nTNNiaCKt6V2J3bF6tGO3BgmdW2lclRMoDE75VSyHfM9IfeVpIenECs0FQQ
         6ahxAVHZ+cdcBPU7KxCQlTQGN7Yro/EAuiDZ1d3hA9ICN2B107oWKXHCwTRUrzXcHjyS
         zw9g==
X-Forwarded-Encrypted: i=1; AJvYcCVT7Ec74a8Zgu702EgpZDMkPzNR20cgoue3cK8DdtZdjXMnrTyCn2nET3woHKyJIl9/0hbSEbf5aafRdbG7d6NpVCVgW4GjvJvX2aoX
X-Gm-Message-State: AOJu0YwGeHVs+U1ZBWR9b6qNEnWci0kI/4Oy6N7xw6lKxDaaeN7lL38I
	614MHqnbOTAoGk0YC55m5sinc2A9lpnzyrA4w4dG7VfYnAhV//LvvlSdVSCrXtYRGRuy8Mxdh2g
	39gcl5GkIp3ZmMzvET8HArMlEB2cY8g5regDa
X-Google-Smtp-Source: AGHT+IE/Dsm5sUO90WDhySqhQle8Wcf1bswme3pUqrR0JWcYyB5h/4IPxDUk/BYo+n4AtSKF3b8oVx+F2L267FDc7+s=
X-Received: by 2002:a17:906:b814:b0:a6f:5609:9552 with SMTP id
 a640c23a62f3a-a6f60cee4ebmr125971166b.10.1718357365840; Fri, 14 Jun 2024
 02:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <CAJD7tkZzHhvVNjECqMiFKEu988eteiFk4aGpE=f=gXE4tnF4NA@mail.gmail.com> <52df55b7-2e1d-4a95-85bf-19f6680e3fec@gmail.com>
In-Reply-To: <52df55b7-2e1d-4a95-85bf-19f6680e3fec@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 14 Jun 2024 02:28:47 -0700
Message-ID: <CAJD7tkYRU-8_fxco6B+--9wVCKzHWOWM19AwfzJTLpVcJ_1P0Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com, 
	ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 2:22=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
> On 13/06/2024 22:21, Yosry Ahmed wrote:
> > On Mon, Jun 10, 2024 at 5:18=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >> Going back to the v1 implementation of the patchseries. The main reaso=
n
> >> is that a correct version of v2 implementation requires another rmap
> >> walk in shrink_folio_list to change the ptes from swap entry to zero p=
ages to
> >> work (i.e. more CPU used) [1], is more complex to implement compared t=
o v1
> >> and is harder to verify correctness compared to v1, where everything i=
s
> >> handled by swap.
> >>
> >> ---
> >> As shown in the patchseries that introduced the zswap same-filled
> >> optimization [2], 10-20% of the pages stored in zswap are same-filled.
> >> This is also observed across Meta's server fleet.
> >> By using VM counters in swap_writepage (not included in this
> >> patchseries) it was found that less than 1% of the same-filled
> >> pages to be swapped out are non-zero pages.
> >>
> >> For conventional swap setup (without zswap), rather than reading/writi=
ng
> >> these pages to flash resulting in increased I/O and flash wear, a bitm=
ap
> >> can be used to mark these pages as zero at write time, and the pages c=
an
> >> be filled at read time if the bit corresponding to the page is set.
> >>
> >> When using zswap with swap, this also means that a zswap_entry does no=
t
> >> need to be allocated for zero filled pages resulting in memory savings
> >> which would offset the memory used for the bitmap.
> >>
> >> A similar attempt was made earlier in [3] where zswap would only track
> >> zero-filled pages instead of same-filled.
> >> This patchseries adds zero-filled pages optimization to swap
> >> (hence it can be used even if zswap is disabled) and removes the
> >> same-filled code from zswap (as only 1% of the same-filled pages are
> >> non-zero), simplifying code.
> >>
> >> This patchseries is based on mm-unstable.
> > Aside from saving swap/zswap space and simplifying the zswap code
> > (thanks for that!), did you observe any performance benefits from not
> > having to go into zswap code for zero-filled pages?
> >
> > In [3], I observed ~1.5% improvement in kernbench just by optimizing
> > zswap's handling of zero-filled pages, and that benchmark only
> > produced around 1.5% zero-filled pages. I imagine avoiding the zswap
> > code entirely, and for workloads that have 10-20% zero-filled pages,
> > the performance improvement should be more pronounced.
> >
> > When zswap is not being used and all swap activity translates to IO, I
> > imagine the benefits will be much more significant.
> >
> > I am curious if you have any numbers with or without zswap :)
>
> Apart from tracking zero-filled pages (using inaccurate counters not in
> this series) which had the same pattern to zswap_same_filled_pages, the
> nvme writes went down around 5-10% during stable points in the
> production experiment. The performance improved by 2-3% at some points,
> but this is comparing 2 sets of machines running production workloads
> (which can vary between machine sets), so I would take those numbers
> cautiously and which is why I didnt include them in the cover letter.
>

Yeah this makes sense, thanks. It would have been great if we had
comparable numbers with and without this series. But this shouldn't be
a big deal, the advantage of the series should be self-explanatory.
It's just a shame you don't get to brag about it :)

