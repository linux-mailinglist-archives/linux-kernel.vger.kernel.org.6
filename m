Return-Path: <linux-kernel+bounces-214078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B90907F26
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C972B23E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E4D14B090;
	Thu, 13 Jun 2024 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HiNqqARd"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45D757E0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718319636; cv=none; b=P7NBmrUfeDD0xppFQnuGff0BlNqDdxp1V1JcBNQeoJ5Syj2oGKnglkD+gjDzoF43ZLRteELjzWdETzKZjwcpSnUSxBUaUb8wSkBTK/PQrdDgi2Q7TaN/myYVcJsIhhTDa/SAlxfPhhnk9XaSJe/sFbsWlXLL1f7H0SIff8LJ1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718319636; c=relaxed/simple;
	bh=in7bSM65Hqq2fx5cz/q8ttOiOGDO4K8TaJEiNCokU7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXGGjs78+6M05WOlANzNpiriwrpFZF5VwiA8nVP23BK6kX9NgpDN7mLGW3LlBY39Nf1EVayz+EO8few0wQTeCgskCJZeBjRPiY302trwfzSOlL9bp2om6YWb4KvgW0NfmQHZrdttlHcY9pM1Ws3ZUlyGP4hslSkkTDBIlkHw0Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HiNqqARd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6266ffdba8so185195966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718319632; x=1718924432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=in7bSM65Hqq2fx5cz/q8ttOiOGDO4K8TaJEiNCokU7s=;
        b=HiNqqARdRjOl03pwgfkA35UmohkIBAKAVEHatp5Um8zQN2T5DKypzvRM2qoqorfgAU
         eFMDdRWu9IHuq8xsUEod6HUet7IiYRnjz7EBtFGVxlVYWSHkQ9hl4NPg0rIOyixJ0iy8
         1+81e6AGx7KR03om1kJUynAVwRQfG/5/yXTqXx/m/gPbmdFug4Wj0ACo0Mo/f+8gphP0
         NRwwinaf76gFctZw7wjoJ3SVNyvWLqb97tyhHK4TIwTAezyw7eJW9fb3LZx57OuonrwL
         nqL7tERN5byxTvaJFGtzePRSTqY3s5T4VebqDs6RiYuKrio1K/WSrLJb//OCamBpC0Nt
         hswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718319632; x=1718924432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=in7bSM65Hqq2fx5cz/q8ttOiOGDO4K8TaJEiNCokU7s=;
        b=PzPWUupzr8hF2UDYWNeisz9esxThVSvZ1bDwRt5oDPqYvhXdJ14RlyRpNCOFGGy2P7
         GgSQ+3G/UgDUcP2uwhI8E9iUK/oRAZ/DzcUwZxyb6bDkX84v9JV+I1mMbOyd6wNnomt4
         2GlFIMYSc+EfhHuopyR9v7IQ2s1aoB9qCtbsRz+rFyLXev/O0vKGc/dArDYNXCBZE5Yk
         shZiECMlzb3PRzUDvoQoVHQR8qfGjuGPoLxkxRxOyjN0LMa0WtQpvN3UWTn1FZTiOSHE
         MO1/pVUFPmoOB94tDmGfdpoc6LVl2ai256+BqRIWZOMNn9nhCHg59x6tPhN1Bo2kVHZ+
         n36Q==
X-Forwarded-Encrypted: i=1; AJvYcCWs4RjVJSo1Rc+KqCVOc/7KwcK8043Sos+otPutFxJf9SPqMONt260Jd0BuAXvNtvOHSKReZug3kfiFr+Bl6AMEyAtbhJK0NorUdVe6
X-Gm-Message-State: AOJu0YwhhCfnuYwa/c4ZXEcwNis6DDd7Z+kUVZpMc731QpKG0IuHUGjV
	5q6A3kcD5LShOZgpGer7dTrGVtzLEr5u6YrxjU8BfksEJbj8RNgZrt0apmgPgugu9AFmjVFBamB
	1uZKpoCmtvgrWQbTAceS7EpXAcLIRCdE/9lxr
X-Google-Smtp-Source: AGHT+IHv7YL+HgKxexUNIHykjwDr8ejWioEP6isoX94I1D3v366vVcM8A1dCYbCSKG9kzplS+yckur5HwAksdvVaPoo=
X-Received: by 2002:a17:906:d8b2:b0:a6f:11f8:c21e with SMTP id
 a640c23a62f3a-a6f60dc2017mr69033566b.58.1718319632180; Thu, 13 Jun 2024
 16:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <CAJD7tkZdx7xJiDcvayH1aRW9Q6GQaZnF58UhspEOe=GQMBqFiQ@mail.gmail.com> <etjzs45r7derztzgrb5b4tub4c72vobo6esc3ndksyke6kpiov@qj3ar7xwh6ee>
In-Reply-To: <etjzs45r7derztzgrb5b4tub4c72vobo6esc3ndksyke6kpiov@qj3ar7xwh6ee>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 13 Jun 2024 15:59:53 -0700
Message-ID: <CAJD7tkYCr1cUf7jeUPiXQk+bQBzYCB-yHTm-8Ns9SJJB5QgCpQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mm: store zero pages to be swapped out in a bitmap
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 3:41=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Jun 13, 2024 at 02:50:31PM GMT, Yosry Ahmed wrote:
> > On Mon, Jun 10, 2024 at 5:18=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> > >
> > > Going back to the v1 implementation of the patchseries. The main reas=
on
> > > is that a correct version of v2 implementation requires another rmap
> > > walk in shrink_folio_list to change the ptes from swap entry to zero =
pages to
> > > work (i.e. more CPU used) [1], is more complex to implement compared =
to v1
> > > and is harder to verify correctness compared to v1, where everything =
is
> > > handled by swap.
> > >
> > > ---
> > > As shown in the patchseries that introduced the zswap same-filled
> > > optimization [2], 10-20% of the pages stored in zswap are same-filled=
.
> > > This is also observed across Meta's server fleet.
> > > By using VM counters in swap_writepage (not included in this
> > > patchseries) it was found that less than 1% of the same-filled
> > > pages to be swapped out are non-zero pages.
> > >
> > > For conventional swap setup (without zswap), rather than reading/writ=
ing
> > > these pages to flash resulting in increased I/O and flash wear, a bit=
map
> > > can be used to mark these pages as zero at write time, and the pages =
can
> > > be filled at read time if the bit corresponding to the page is set.
> > >
> > > When using zswap with swap, this also means that a zswap_entry does n=
ot
> > > need to be allocated for zero filled pages resulting in memory saving=
s
> > > which would offset the memory used for the bitmap.
> > >
> > > A similar attempt was made earlier in [3] where zswap would only trac=
k
> > > zero-filled pages instead of same-filled.
> > > This patchseries adds zero-filled pages optimization to swap
> > > (hence it can be used even if zswap is disabled) and removes the
> > > same-filled code from zswap (as only 1% of the same-filled pages are
> > > non-zero), simplifying code.
> >
> > There is also code to handle same-filled pages in zram, should we
> > remove this as well? It is worth noting that the handling in zram was
> > initially for zero-filled pages only, but it was extended to cover
> > same-filled pages as well by commit 8e19d540d107 ("zram: extend zero
> > pages to same element pages"). Apparently in a test on Android, about
> > 2.5% of the swapped out pages were non-zero same-filled pages.
> >
> > However, the leap from handling zero-filled pages to handling all
> > same-filled pages in zram wasn't a stretch. But now that zero-filled
> > pages handling in zram is redundant with this series, I wonder if it's
> > still worth keeping the same-filled pages handling.
>
> Please correct me if I am wrong but zram same-filled page handling is
> not just limited to swap-on-zram use-case and any zram as block device
> user can benefit from it. Also zram might not see any simplification
> similar to zswap in this patch series. I would say motivation behind
> zswap changes seems quite different from possible zram changes. I would
> recommed to evaluate these cases independently.

Uh yes. I keep forgetting that zram is used for other use cases than
swap. Please dismiss my comments then (unless it's uncommon to have
zero-filled / same-filled pages in other use cases).

