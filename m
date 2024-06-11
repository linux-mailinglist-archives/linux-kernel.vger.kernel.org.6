Return-Path: <linux-kernel+bounces-210652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6E29046C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0841F25589
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED621552F8;
	Tue, 11 Jun 2024 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOWgC4Rn"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645777711C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144000; cv=none; b=d6xUCDVUoaRcOtYd1yu3gwBuqFAvIKQG5Skv2caOXml5C9cQEjYrhs4fxCnsvosrh1AFM6FLLGNunYe0XpC7DP4Zc3+vTpofYtY/bZ1WEeEqWIHPzNfdKYsmsgR1Dj1RrlgJdzU81A3K55+aB5HEgvGT080M8kYxfykaPwtoaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144000; c=relaxed/simple;
	bh=cxBhsOvwM8lIkQIy21XPEcwo/O8iEqEX2jWFVpaV6qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X715tA8YRXc2+ckAM2rMray4R9bWoPQPr4zUVKNfor/2qS+AoiUlQE/jPz+GQw884PmRKSOHYVbF/bmkqxOYO5iWjqjMPnvIMuj8rrq+hQ5KRigUykEBNWrvQ2yOgkHGSyp9uZCYT/EHHMRSFpkC/C66bzlGKX1J5kBlufd0wRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOWgC4Rn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-440655e64bdso16658961cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718143998; x=1718748798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPKZqSlAbaQuMLhwthwfzm4L0DNHV7L8sJdV9gURtUM=;
        b=hOWgC4RnbChzfUMjEZcCb+QyxoRIi3zc+Rwq+lgNtpoYu/NYCIc354ZTIegxqrKPr7
         8jvnY3YgwYR7/3uWoyZysYAGuZw1JAH2KVBUdTNg5b9DAbsD6pc+E+9RGmbjk30LP6ww
         Gh6jLRmJNTpr1dyH1TRvqsDeLFUEwuIdTgiEUQu9ZYYa06nKaTxC9y1M5j8/rBFZOru/
         gcjumTRiIYsr2myqwWElzSa+qbS1uUo2jWDIfxBWbYlO7gadxG+jSaAehKmegVQWsfoI
         wbCjqB2W0R8C7lpKKjxgtxhGSiTCxdO79GzUDb1v9c8trGnLsCGa22AzGJm6iX1SBvto
         OX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718143998; x=1718748798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPKZqSlAbaQuMLhwthwfzm4L0DNHV7L8sJdV9gURtUM=;
        b=wkD7Tp+nUFZcKYyH8fqOUsoAYu+wXXSd8lKDyBdc81LN3rI/WeZMpnWbUePPWhqnM+
         cHOHodOZ8fQkIxZMxADnD8vxdqapR1WmUAdfRMjK2ziDzzYekysC9uFRJAbeLreNRySt
         XyDZC0zhIbsLjcXQI+cnelqUGxidly5T+zV5kQsJ90S6PVxnwdZSRnFG6eDwfeN3/+J3
         hh8EkOGyRjAkTrHfse9eUqT5RgoHG1Zw0pOyAyW3WZ8VXZlEKoLUhVZ2w9koRURI0QYN
         GyalQsZLce7np5oXa7q9rXkohqiwf6b5OcYOpk0WGyPT5PcRVCNQUDlhS22azge8zq98
         5XBA==
X-Forwarded-Encrypted: i=1; AJvYcCXZyDSAu5Ccl0wae6u4KnAv0mxXh5zYtgOBoyLfyJHVSE/tJSSuetusiJqPWbgPrEYo/mJWpxmFwFuqmu24GJj3tpZk+PSRMavxoSG6
X-Gm-Message-State: AOJu0YwSl+CQyJBInvMtqnDtaGhfD9uqT2K735MvDToSY6YiiOvvRwRV
	aDhN8iWRFMeVTVRlxS7CmtYLWSbNe7oQ3BRsB+/0ptxZ5hkrTtX8CBFIepT9Jia0XykwHIgatPx
	wGzB6dSDbHuEPj/HhT1xzcl03qe8=
X-Google-Smtp-Source: AGHT+IHRKW+4TAFuiyd6TaF9HhkOMg9tjED6ruWvkwLADjsp/TEZ1jg4S5wZWE6+/Q3li0FjiSMZUY57hDIlWn0R1tY=
X-Received: by 2002:a05:6214:2e44:b0:6b0:6525:4115 with SMTP id
 6a1803df08f44-6b191d472e3mr18116d6.19.1718143998205; Tue, 11 Jun 2024
 15:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-6-21cnbao@gmail.com>
 <c9702789-5772-4750-a609-e44a5bbd8468@arm.com> <CANzGp4+p3xSo9uX2i7K2bSZ3VKEQQChAVzdmBD3O2qXq_cE2yA@mail.gmail.com>
 <emvsj7wfy24dzr6uxyac2qotp7nsdi7hnesihaldkvgo3mfzrf@u7fafr7mc3e7>
 <CAGsJ_4zTpcBj_0uC9v4YOHihx-vEek+Y6rr=M1noijwbhfBw7A@mail.gmail.com> <ly745k53gpkef6ktaoilbib4bzrwyuobli7adlylk5yf24ddhk@l4x2swggwm3f>
In-Reply-To: <ly745k53gpkef6ktaoilbib4bzrwyuobli7adlylk5yf24ddhk@l4x2swggwm3f>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 12 Jun 2024 10:13:06 +1200
Message-ID: <CAGsJ_4xVerq0bukCeZgXmjn2uBUviBEBjY6AWM4wm1M4D2N0og@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Chuanhua Han <chuanhuahan@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com, steven.price@arm.com, 
	surenb@google.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 5:24=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Jun 11, 2024 at 12:23:41PM GMT, Barry Song wrote:
> > On Tue, Jun 11, 2024 at 8:43=E2=80=AFAM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Thu, Mar 14, 2024 at 08:56:17PM GMT, Chuanhua Han wrote:
> > > [...]
> > > > >
> > > > > So in the common case, swap-in will pull in the same size of foli=
o as was
> > > > > swapped-out. Is that definitely the right policy for all folio si=
zes? Certainly
> > > > > it makes sense for "small" large folios (e.g. up to 64K IMHO). Bu=
t I'm not sure
> > > > > it makes sense for 2M THP; As the size increases the chances of a=
ctually needing
> > > > > all of the folio reduces so chances are we are wasting IO. There =
are similar
> > > > > arguments for CoW, where we currently copy 1 page per fault - it =
probably makes
> > > > > sense to copy the whole folio up to a certain size.
> > > > For 2M THP, IO overhead may not necessarily be large? :)
> > > > 1.If 2M THP are continuously stored in the swap device, the IO
> > > > overhead may not be very large (such as submitting bio with one
> > > > bio_vec at a time).
> > > > 2.If the process really needs this 2M data, one page-fault may perf=
orm
> > > > much better than multiple.
> > > > 3.For swap devices like zram,using 2M THP might also improve
> > > > decompression efficiency.
> > > >
> > >
> > > Sorry for late response, do we have any performance data backing the
> > > above claims particularly for zswap/swap-on-zram cases?
> >
> > no need to say sorry. You are always welcome to give comments.
> >
> > this, combining with zram modification, not only improves compression
> > ratio but also reduces CPU time significantly. you may find some data
> > here[1].
> >
> > granularity   orig_data_size   compr_data_size   time(us)
> > 4KiB-zstd      1048576000       246876055        50259962
> > 64KiB-zstd     1048576000       199763892        18330605
> >
> > On mobile devices, We tested the performance of swapin by running
> > 100 iterations of swapping in 100MB of data ,and the results were
> > as follows.the swapin speed increased by about 45%.
> >
> >                 time consumption of swapin(ms)
> > lz4 4k                  45274
> > lz4 64k                 22942
> >
> > zstdn 4k                85035
> > zstdn 64k               46558
>
> Thanks for the response. Above numbers are actually very fascinating and
> counter intuitive (at least to me). Do you also have numbers for 2MiB
> THP? I am assuming 64k is the right balance between too small or too
> large. Did you experiment on server machines as well?

I don=E2=80=99t possess data on 2MiB, and regrettably, I lack a server mach=
ine
for testing. However, I believe that this type of higher compression ratio
and lower CPU consumption generally holds true for generic anonymous
memory.

64KB is a right balance. But nothing can stop THP from using 64KB to
swapin, compression and decompression. as you can see from the
zram/zsmalloc series,  we actually have a configuration
CONFIG_ZSMALLOC_MULTI_PAGES_ORDER

The default value is 4.

That means a 2MB THP can be compressed/decompressed as 32 * 64KB.
If we use 64KB as the swapin granularity, we still have the balance and
all the benefits if 2MB is a too large swap-in granularity which might caus=
e
memory waste.

>
> >
> > [1] https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gma=
il.com/
> >

Thanks
Barry

