Return-Path: <linux-kernel+bounces-201839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0178FC422
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35172288945
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52AC18C32A;
	Wed,  5 Jun 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHzXOXpR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F6A190490
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571306; cv=none; b=fCBGHv/XhOGs9ODGEDERh5I9TaiXm1oCUL+9GE/IClDyGxm7feHaj7kcE5bY2GA0/j3CVHRiemR+Ip7m09TWWSCegeJdnbwjJXYZnaMWtSXqIrS7B/QT8dzdxc/OfjahhqudKYD8D2YyUJmHXvX0B1H6sP12Mw1kzGgi9sxBp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571306; c=relaxed/simple;
	bh=zjM++pe63O6XKtNRcatJaeIibgHtGuI8Go40VKO/Xa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4I23boGn7uCzD6g6msTRaAKzm/J8TcF9SszUXOXsODwRnWwWUA3ZPslryiegzEjotitdA7NLzP0vL2LOrS8HMdpi8v5PPBfBRCtGDgFribvLeqQEEej9ymGdhdMX/4Jlgqmj8BXO/c+fftXR2LAPMBrNHH+VNRUFOEiPUxAEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHzXOXpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F17C4AF08
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717571305;
	bh=zjM++pe63O6XKtNRcatJaeIibgHtGuI8Go40VKO/Xa4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dHzXOXpRvCf/XxBUz4jNV0jJFNe0IXGlYUPEfIoyFPl8zb7yT7dJQnFRmi0qjLrEm
	 txx1QcCSjUyjogWpbFpmJm8r7Yfa10it/+YgKdVoaCTpNq3QIR3ZRknLTskg0ENfZl
	 OleR/xIbuI6Jtqg6Ta2BFdte2HdGIao/f1Qjdc3JDaSFWBVUH3TI3ipz3nYhw/+51Z
	 mqqXYVh5M3/CGfYJ2VD9vcxxy7bnZpF4PBOwxnQBMSKkuQl55n5LS0huj2J/mvIzQu
	 /EX9Us5X9AUaiuomZ44NaGZ/tKRzfJqLUWaBdYAdxXXRXcUzwhEjDc/dz8ZR06XzMA
	 rQVhQvrWURVyQ==
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-374a817a184so8666645ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:08:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgWlgbKS6UsIx3jZUjeDzydcAquxOGXMl2NUi5z18v/d8c03I7LOe9vmMu30lpy+SFLc84WypGsnxgz9JUeRFAHm5Ti97GIKdmlrMP
X-Gm-Message-State: AOJu0YxF9U0osBGhoUcoyKzGOKVcsyeY6cwURMbXz/Nag9iInhf/0Xo2
	i3s4EA8AitbYI81BaEvv5iXR8MzSwfjWbohE0/999Y0S2r7MrYh7i6mz2OACOyKIKasRVb0Ceec
	Drh50+hTI8Eq2Oo2UgvACvZzZ2U3GYvUIqUUh
X-Google-Smtp-Source: AGHT+IEnS98wNsaLy6nngBjTzn7eeLgDDA4TXWawq105LwHHH4IZMeX8vB8ppQSpQT8iDwKH7n9Ay27zmewlXKNnS1c=
X-Received: by 2002:a92:ca0b:0:b0:374:ad0f:1b00 with SMTP id
 e9e14a558f8ab-374b1eff031mr16421305ab.15.1717571304752; Wed, 05 Jun 2024
 00:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
 <87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
 <875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuMc3sXKarq3hMPYGFfeqyo81Q63HrE0XtztK9uQkcZacA@mail.gmail.com>
 <87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 5 Jun 2024 00:08:12 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPLhmJqMi-unDOm820c8_kRnQVA_dnSfgRzMXaHKnDHAQ@mail.gmail.com>
Message-ID: <CAF8kJuPLhmJqMi-unDOm820c8_kRnQVA_dnSfgRzMXaHKnDHAQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 7:37=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Wed, May 29, 2024 at 7:54=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> > because android does not have too many cpu. We are talking about a
> > handful of clusters, which might not justify the code complexity. It
> > does not change the behavior that order 0 can pollut higher order.
>
> I have a feeling that you don't really know why swap_map[] is scanned.
> I suggest you to do more test and tracing to find out the reason.  I
> suspect that there are some non-full cluster collection issues.

Swap_map[] is scanned because of running out of non full clusters.
This can happen because Android tries to make full use of the swapfile.
However, once the swap_map[] scan happens, the non full cluster is polluted=
.

I currently don't have a local reproduction of the issue Barry reported.
However here is some data point:
Two swap files, one for high order allocation only with this patch. No
fall back.
If there is a non-full cluster collection issue, we should see the
fall back in this case as well.

BTW, same setup without this patch series it will fall back on the
high order allocation as well.

>
> >> Another issue is nonfull_cluster[order1] cannot be used for
> >> nonfull_cluster[order2].  In definition, we should not fail order 0
> >> allocation, we need to steal nonfull_cluster[order>0] for order 0
> >> allocation.  This can avoid to scan swap_map[] too.  This may be not
> >> perfect, but it is the simplest first step implementation.  You can
> >> optimize based on it further.
> >
> > Yes, that is listed as the limitation of this cluster order approach.
> > Initially we need to support one order well first. We might choose
> > what order that is, 16K or 64K folio. 4K pages are too small, 2M pages
> > are too big. The sweet spot might be some there in between.  If we can
> > support one order well, we can demonstrate the value of the mTHP. We
> > can worry about other mix orders later.
> >
> > Do you have any suggestions for how to prevent the order 0 polluting
> > the higher order cluster? If we allow that to happen, then it defeats
> > the goal of being able to allocate higher order swap entries. The
> > tricky question is we don't know how much swap space we should reserve
> > for each order. We can always break higher order clusters to lower
> > order, but can't do the reserves. The current patch series lets the
> > actual usage determine the percentage of the cluster for each order.
> > However that seems not enough for the test case Barry has. When the
> > app gets OOM kill that is where a large swing of order 0 swap will
> > show up and not enough higher order usage for the brief moment. The
> > order 0 swap entry will pollute the high order cluster. We are
> > currently debating a "knob" to be able to reserve a certain % of swap
> > space for a certain order. Those reservations will be guaranteed and
> > order 0 swap entry can't pollute them even when it runs out of swap
> > space. That can make the mTHP at least usable for the Android case.
>
> IMO, the bottom line is that order-0 allocation is the first class
> citizen, we must keep it optimized.  And, OOM with free swap space isn't
> acceptable.  Please consider the policy we used for page allocation.

We need to make order-0 and high order allocation both can work after
the initial pass of allocating from empty clusters.
Only order-0 allocation work is not good enough.

In the page allocation side, we have the hugetlbfs which reserve some
memory for high order pages.
We should have similar things to allow reserve some high order swap
entries without getting polluted by low order one.

>
> > Do you see another way to protect the high order cluster polluted by
> > lower order one?
>
> If we use high-order page allocation as reference, we need something
> like compaction to guarantee high-order allocation finally.  But we are
> too far from that.

We should consider reservation for high-order swap entry allocation
similar to hugetlbfs for memory.
Swap compaction will be very complicated because it needs to scan the
PTE to migrate the swap entry. It might be easier to support folio
write out compound discontiguous swap entries. That is another way to
address the fragmentation issue. We are also too far from that as
right now.

>
> For specific configuration, I believe that we can get reasonable
> high-order swap entry allocation success rate for specific use cases.
> For example, if we only do limited maximum number order-0 swap entries
> allocation, can we keep high-order clusters?

Yes we can. Having a knob to reserve some high order swap space.
Limiting order 0 is the same as having some high order swap entries
reserved.

That is a short term solution.

Chris

