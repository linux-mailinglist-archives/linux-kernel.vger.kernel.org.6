Return-Path: <linux-kernel+bounces-290828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A4955935
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 19:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8FF2826EB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14F154BEC;
	Sat, 17 Aug 2024 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WboctPuM"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E52749A
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723916887; cv=none; b=BOqfuRg6lWsXe1vLrQNB4DMa4sf8b65tUUsr4CcnlJ+Rt65PNFLiVbjE8jNGww/f2rRNYsMobggNBZHQGSDcPxeouLC94ekfBYYqlTwGm4WtrP30wS9KF4zRJJzy84jrtIK3Lj4ydydSXqpV4HPuowauNbTstDEkJG2R1KBW2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723916887; c=relaxed/simple;
	bh=XM3kkaPk8ID0CrMuI7m8FD1sXdbZpfrjLN4JldeQ4bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2pYnVEMDvdsRACSptAzjjSjQYlHzDGVNmFAhAUDCVQmZWpGUd/ZrlX2zG9Cbj/p+SBaTux/p7xy8Dkoax7cHc41SlnSJGVv9bv/Ia7YsXoYXn/CaQlr/oiz/P9rw6AgafDCr2+AfsfHOoMKQI5iLt0l58CpNsmfb6js8oLuvV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WboctPuM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f15dd0b489so42357361fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723916883; x=1724521683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mqGzmAAwp8/+D6emKhOc783bM6P4L7CLETTrYC2FRo=;
        b=WboctPuMV9rfWsW+vHn6/NvyVx0RIsg5RqMAK/Z54OLcf9unQp8gl1icAHo+ljC8xQ
         4eYLBvHdISD/c6F625/nVIXL8NRKnZ99envHw53v9fOZeCPmAX6N0Ggr9jIwzGXbcIFn
         wnZeGSP4+uPYg75doldqS03eNqx796DxfkhbNY+NfPXcTHqsRzTc/Pgj8z72JgNvV2HE
         3MAyxLvWo4IjlJ7n9xkZ+VXid0WYNSU8eUT8zXLnwMPIDMRmtfdlZ/Ze/sHCv71lc2LY
         p2u44+pR9QLTnzXsFIfiIX9nykNSFstLSVQg4tsUZnz+Xcpxg7H2XlTgUdTRk6KUKHJD
         3Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723916883; x=1724521683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mqGzmAAwp8/+D6emKhOc783bM6P4L7CLETTrYC2FRo=;
        b=CIDjGYDn+R3kgN6T2hffAA1sYoVS6Z+9kgJ6UBPmLfuAdWWdp+NcUw+NwGviUAGq+7
         C0j9XGLbFerfbO57BkrxEwInoZCHJNs8go0XkSreAkAr5UHtcYn1cN6E5z4N++j/WA/Q
         7omSLt7RJMnul9gx9JF6Z/sKsEbEMPwMnrYTkxdhW2phe9+9n+fFvAEOKfbD9xhKc6hp
         NlUbXdZvYermopTp/34xoSBf1vkeZpd/Tw/bMRw8RO297HHwWFaWINA/O5wE9NLnuvWA
         oaIVFL3u1RVTqNG8HW/NyY9ok9blqhvWaYkzlYycRw10G3Pr8z1wk+t5O+nHM1VtTAED
         O0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWctWjQV6Hy/LPG1YSvdiYlWECGIozA6HvgCLtZwr/Racf4RZOUcnyhx2IsDZog+t+9kAbLuG9G+TFn08q/1kvHhUMkKb8SX9A14RWA
X-Gm-Message-State: AOJu0YzswjrpmJ1fpc/aZ5MiZ/ykvAS3WfeN6QdyY8isMuvmcXDmN3TP
	yIlx6MhU05pWWLcArsJmw2DqgR0ALB/Kp6+m/YO02MMzin8Q/Xemh2mW4TTj2kb1HnjfHOVGnoU
	eqCA+IxDFQw2XAqTdkYWvl4vbLH4=
X-Google-Smtp-Source: AGHT+IEBotNTKHJO6dOqOuMEUbBEg9Poe6CnESoH4k5zPpkfSwcF5YC1dGfMG+vhpfpptTuu81/GDIH0jMQxW8gv7/8=
X-Received: by 2002:a05:651c:1502:b0:2f3:b078:8490 with SMTP id
 38308e7fff4ca-2f3be57238bmr46031921fa.6.1723916882953; Sat, 17 Aug 2024
 10:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
 <3c79021a-e9a0-4669-a4e7-7060edf12d58@redhat.com> <CAMgjq7CWwK75_2Zi5P40K08pk9iqOcuWKL6khu=x4Yg_nXaQag@mail.gmail.com>
 <87le17z9zr.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbX1EWQk03YcC47s7+vn40kEFb_3wp3D_GmJV-8Fn2j+=Q@mail.gmail.com>
In-Reply-To: <CACePvbX1EWQk03YcC47s7+vn40kEFb_3wp3D_GmJV-8Fn2j+=Q@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 18 Aug 2024 01:47:46 +0800
Message-ID: <CAMgjq7Aztur8WQ=rMWiLBhgRU5_6TGXnLQQ7-RM73AK5jJxEzw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap cluster order
To: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 3:37=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Aug 8, 2024 at 1:40=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
> >
> > Kairui Song <ryncsn@gmail.com> writes:
> >
> > [snip]
> >
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -450,7 +450,10 @@ static void __free_cluster(struct swap_info_stru=
ct *si, struct swap_cluster_info
> > >       lockdep_assert_held(&si->lock);
> > >       lockdep_assert_held(&ci->lock);
> > >
> > > -     list_move_tail(&ci->list, &si->free_clusters);
> > > +     if (ci->flags)
> > > +             list_move_tail(&ci->list, &si->free_clusters);
> > > +     else
> > > +             list_add_tail(&ci->list, &si->free_clusters);
> >
> > If we use list_del_init() to delete the cluster, we can always use
> > list_move_tail()?  If so, the logic can be simplified.
>
> Thanks for the suggestion.

Hi All, thanks for the review and discussion.

> I feel that list_del_init() generates more instruction than necessary.
> It is my bad that I leave the discard list without not a list flag bit
> for it.

Right, list_del_init is a little bit more noisy than list_del indeed.

But considering after this patch, all non-discard clusters are always
a on list (free/nonfull/full) already, and a cluster will be dangling
only when being removed from the discard list (when doing discard
work, it need to unlock si->lock, so the cluster have to be hidden
from other racers).

I think it's good to use list_del_init when deleting from the discard
list in this patch, then list_move_tail can always be used when
changing the list of a cluster.
Discard should be a much less common operation so this should
be OK.

