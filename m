Return-Path: <linux-kernel+bounces-195872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16E98D53A5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2C2287668
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08221A0AF6;
	Thu, 30 May 2024 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DaqdWv6/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCE17B4F2
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100215; cv=none; b=RFn2mL3bZih1YqS1M7EoAnLSfPu5yJUZp+qRiX9en2ip94TBz64BUzNWRpAiKvKj8Vy+c+uOsrSrLNw/uvtkMYZILHCs5VcrnaJ4bKFJcfNzTT+c/CQwliS4jZBZ95u8EzjpElB0YLUkx+jyrRCsDlY3fDZq3YdyzN5XyDfuZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100215; c=relaxed/simple;
	bh=w/LlhHGvNr9h36RirGQv+V9ut5ip0myLpxA0mSnObZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1XHPPA+uWwuW5cHVFlLziuVrOKcSRBdFLWwo98IR2hKsl6Vb4KBoYy1q379SOYB6fnpdGHtclyRpCkdXW3mw3ZegJDaKIZFaoun9Bf0mXlM8Hw684No438hBWCXUpKOZtQmMurul6DOzqiN7RWVw+fh7Yw8Yl00cGc0GjccyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DaqdWv6/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a62972c88a9so140854966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717100204; x=1717705004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OTWf97i9msDaAtUbKTlawU5KSwt/tocxmyS3gYffoM=;
        b=DaqdWv6/LcQ9h42zhRV2fJ6CiQZXO6NhuN2qzzUo/z2TRSTM6baz/YqV4e40YVhtz4
         VUkik5pfuhut8yVtUlXr12sj4EzSVxlxrxDaBIvSlde79Jqu64qN26zuh8wW4QVqBZEL
         /PzNNpaINagJ1w8G/ubHP0a9nxVLbV3qWKoqxzDL05Hr5dcTrPLj8ZV2+zj4O+IudTJW
         cvZ1krMzS7Om9i38jQd8nKLv/GEeNOz5FaA/+sKhPFfa3TyMra4mvl+uBSSBTuk8buiP
         OR+toEhjfRxybnXoM3bLSpI+r9BBpEZYL9GKtiADxN8ASP8jv2UfXiuEN3Sh8VlpW0VN
         Ah8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717100204; x=1717705004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OTWf97i9msDaAtUbKTlawU5KSwt/tocxmyS3gYffoM=;
        b=VWkTeka4xK343wXWGl9ilXE+rhuF95flccVXCFVkhSzLwc1xZVxNDG771oqDuYogDG
         zaarskfQw8JESWVd4e+u6S3MRhjq555jqRNvRb3dD1vco7La9DD9qkt9O7e9lodozVMC
         0Zzp4lbdgtBGHp6R9dd8rdP+Baa4CABGWSxim9plv3huEtOS9ZU+D+iprmb/BZZFi5P4
         f/DsOzwSe/PUyd3f/i2ZxMVGSR5Nl7qdOiziDfd+4TKBHZ1gDG870TuVWiV5NHv+0T8o
         tRJYoYnuMChu5a+QXNUmVzyGl+veTTEdF/GXeUuP2Vf8Wx7Zrv7caCfeUR41KLNfW1vE
         FnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFraXN7ozn9RhV3W6mApsDkmycy6NzV17q2LNfX04BRwGHCtZJfPgdtRYIypY93s/ilphiS+DyVQDGUqJ6R9L/Ys5B+G9LICYJDdpG
X-Gm-Message-State: AOJu0YzWCWeV1JxRpN5WqEeTs4iYwVJCC175uhtVzruwpll9Kc8HB9bb
	Gm3gbTg1sRxsBB4f7yR8F0Jv6BN2liwOp5cWpxcnGWwVNxHlxt+SACITGoQDoMqFaZ6jgaEcS2q
	+I7eXYsqSTlOwgAzba21u1tYNKDLG5+d+LztDWxpiDibg6jz7+xyT
X-Google-Smtp-Source: AGHT+IGfhSphpt3Xt9x/htvOQl3pSYxwOhOVDjvz7uv3zgNs2OoaZVoWnDiNErSEG6McsHKtRKsOInjy25s7jMJjoKI=
X-Received: by 2002:a17:906:abd0:b0:a5a:8a63:9fee with SMTP id
 a640c23a62f3a-a65e8d2b827mr209645766b.3.1717100203599; Thu, 30 May 2024
 13:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530102126.357438-1-usamaarif642@gmail.com>
 <20240530102126.357438-2-usamaarif642@gmail.com> <20240530122715.GB1222079@cmpxchg.org>
 <CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h7WQjDnsdwM=g9cpAw@mail.gmail.com> <ZljbwMj-FNw9TqDV@casper.infradead.org>
In-Reply-To: <ZljbwMj-FNw9TqDV@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 30 May 2024 13:16:04 -0700
Message-ID: <CAJD7tkb4iTnm2xGvncmVwr+uqV=99hv0kZzMdMc34xc4GUyXJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: store zero pages to be swapped out in a bitmap
To: Matthew Wilcox <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Usama Arif <usamaarif642@gmail.com>, 
	akpm@linux-foundation.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Hugh Dickins <hughd@google.com>, Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 1:04=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, May 30, 2024 at 09:24:20AM -0700, Yosry Ahmed wrote:
> > I am wondering if it's even possible to take this one step further and
> > avoid reclaiming zero-filled pages in the first place. Can we just
> > unmap them and let the first read fault allocate a zero'd page like
> > uninitialized memory, or point them at the zero page and make them
> > read-only, or something? Then we could free them directly without
> > going into the swap code to begin with.
>
> I was having similar thoughts.  You can see in do_anonymous_page() that
> we simply map the shared zero page when we take a read fault on
> unallocated anon memory.
>
> So my question is where are all these zero pages coming from in the Meta
> fleet?  Obviously we never try to swap out the shared zero page (it's
> not on any LRU list).  So I see three possibilities:
>
>  - Userspace wrote to it, but it wrote zeroes.  Then we did a memcmp(),
>    discovered it was zeroes and fall into this path.  It would be safe
>    to just discard this page.
>  - We allocated it as part of a THP.  We never wrote to this particular
>    page of the THP, so it's zero-filled.  While it's safe to just
>    discard this page, we might want to write it for better swap-in
>    performance.

My understanding is that here we check if the entire folio is
zero-filled. If the THP is still intact as a single folio, we will
only apply the optimization if the entire THP is zero-filled. If we
are checking a page that used to be part of a THP, then I think the
THP is already split and swap-in performance would not be affected.

Did I miss anything here?

>  - Userspace wrote non-zeroes to it, then wrote zeroes to it before
>    abandoning use of this page, and so it eventually got swapped out.
>    Perhaps we could teach userspace to MADV_DONTNEED the page instead?

Why wouldn't it be safe to discard the page in this case as well?

>
> Has any data been gathered on this?  Maybe there are other sources of
> zeroed pages that I'm missing.  I do remember a presentation at LSFMM
> in 2022 from Google about very sparsely used THPs.

Apart from that, we may also want to think about shmem if we want a
general approach to avoid swapping out zero pages.

