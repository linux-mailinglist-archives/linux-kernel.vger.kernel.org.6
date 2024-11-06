Return-Path: <linux-kernel+bounces-398941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEA49BF849
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09999283427
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ECF1C3050;
	Wed,  6 Nov 2024 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMbx0ibt"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087AA13CFAD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926861; cv=none; b=upC5FSDrI+uLFc+ZyYmgdBn19MlX2xSkADULSgNycAivf1urTTNruUSZAs94cB2LzUNxCYqxjLFGXm4m26FOOLhGyYCy9C5v/lG5H2Ht8CPEbFoQBTFOWPq+5xq1Jer/98semyA7u7Y5/OjvbIyrFhA0AMmKz674wsMmU+adErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926861; c=relaxed/simple;
	bh=hM6H3aZX+b8NNMeV7fjPJizjkaBE142mV+rqJDNX9Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BASF5xSCfxdiO48/UhChGiheOW6CAl4DilQw794RaJ9kBrtf+AcETETp/smstQpaSvDduS9cCh89LnhuXsUB1UcVzbuvpd+gb/+4USlN9RQJUg3Prmjp+Cxjt4ebZ/mU9FH+YWy19KwGWMCgI0lERC7Wl8xHh1RI0DbuKJv0Pv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMbx0ibt; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-84fc0209e87so72561241.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 13:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730926859; x=1731531659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP4uisdfc1zjfK+2lZpIDlK/Mivf6HgrmxOj3vGs25s=;
        b=TMbx0ibtjzRElv+QDsl9N/ZnWGZzYdGm+NJeu33DAt8uAToJNWgPJWXLsGH+dwLdZW
         0wQoDzsRAx8f6WqoLLNPJNClOvQP1TM8VA/nxXhHfUp3eHNkyrJx9rOS00PnWfNOa8pS
         +0p5pouHce8anSxU5F8BTKAc3/KOdLcKnEfB0iHrOEf0teJYTHQxWKvTL0yTHbUzhCHe
         bGsMUluGegWtmUtFPwo7gn7CpzAJTuH/MdfNfjFIPFqvdKl5g8JK+eFTKkdBeYpyNKEl
         Oha0L0u4a8YLRho8t1/dMr9NO6V2QOGVePQ3h+PifZ2/kokW1+CgPXpJ/6fSeEy00EHq
         kiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730926859; x=1731531659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rP4uisdfc1zjfK+2lZpIDlK/Mivf6HgrmxOj3vGs25s=;
        b=X7AmNWeVFMU8RB6DRTY+2hBHOuHNpHxJXeHh8ccX7URly+6cWB0FlhpUFmLP0tvTef
         UIvWq+i0seRJl2SdCat7dsm64nkQekqq3oOlfiJVL3oDKGdRFDgrAvSLcEpwSXHndwnx
         XVT6V5drEjcP7zyGTVJYXi60Y/6gje9gVzxk+f3E8sI9pObz+s0zZzArIdXO3lIXWsvl
         0yE5WwHtKd+kt9RF9Z2clG3TOW2Om1ohOs7PlcnKUQzBDZEBy9SSxAKU3pKOpcga/WBT
         0L6pT7pzD+oVP2Ld5r6XjMcoF2y7GwFW70Dlgs/zXoWkeoY1//JZ0Z2XuaaZi+r+ss8M
         rUBg==
X-Forwarded-Encrypted: i=1; AJvYcCX3YvFVa9duT7np6gHPkeaDHvNsVBiLytMbPwophPNNJzwDIPMA3jwLC9VWq8v6FUjxmeDmTexHLH5k6Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxudo4RG3MZ0B7FGG+TOS5NCGmqzeNHQr71qD3MCLf8ZfF04KHU
	YYQv88lVRAURL/AVeRLe4nSg8iqyRauyN1K+7HcZDSuXSudcWDf49oC7zTrxC3r36uvdBpYjQlG
	uOjZkEOpjMxjJlamS8HjpnQfXqkA=
X-Google-Smtp-Source: AGHT+IGdSZPexxSpaevgOqWWazi2SAZKv+vK7A6R+O4NfsGyaoOevXiBmae2SCYBTtGbOuPFfR/UNfr3X778bBg/Qvc=
X-Received: by 2002:a05:6102:2908:b0:498:d12b:4774 with SMTP id
 ada2fe7eead31-4a9542a6661mr24402690137.7.1730926858332; Wed, 06 Nov 2024
 13:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105211934.5083-1-21cnbao@gmail.com> <20241106150631.GA1172372@cmpxchg.org>
 <CAGsJ_4zYiRzG6mBnW-2wh7YCo_PJQc7u1syd05DNdic7MaE7Zw@mail.gmail.com> <20241106124225.632b42c3680cae0b940d2871@linux-foundation.org>
In-Reply-To: <20241106124225.632b42c3680cae0b940d2871@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 7 Nov 2024 10:00:47 +1300
Message-ID: <CAGsJ_4xoHbg+6CtGhC7dPePPC44OMH8azQsOWMEJnXpCQs=bDQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: count zeromap read and set for swapout and swapin
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Nhat Pham <nphamcs@gmail.com>, 
	Usama Arif <usamaarif642@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Hailong Liu <hailong.liu@oppo.com>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:42=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu, 7 Nov 2024 09:01:14 +1300 Barry Song <21cnbao@gmail.com> wrote:
>
> > Oops, it seems that it depends on Kanchana's 'mm: change count_objcg_ev=
ent() to
> > count_objcg_events() for batch event updates,' which also isn't present=
 in 6.12.
> >
> > Otherwise, it won't build, as reported here:
> > https://lore.kernel.org/linux-mm/CAGsJ_4whD31+Lk0m2uq-o=3DygvkRsw1uXcPe=
qxBONV-RUXkeEzg@mail.gmail.com/
>
> argh.
>

Apologies for the inconvenience.

> > Hi Andrew,
> > What=E2=80=99s the best approach here? Should we include Kanchana's pat=
ch that extends
> > the nr argument for count_objcg_events() in 6.12-rc as well?
>
> Let's do the right thing here.  I'll drop this patch from mm-hotfixes.
> Please send a v4 against Linus mainline fairly soon then I'll redo
> Kanchana's series around that.

Alright. The question is whether we should integrate Kanchana's 'mm:
change count_objcg_event() to count_objcg_events() for batch event
updates' into 'mm: count zeromap read and set for swapout and swapin,'
or keep it as a separate patch as patch 1/2?

I guess integration would be better, as hotfixes may not be ideal for a pat=
ch
series?

Thanks
Barry

