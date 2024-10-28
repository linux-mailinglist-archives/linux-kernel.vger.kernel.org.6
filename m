Return-Path: <linux-kernel+bounces-385722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052CC9B3ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A52E1F20FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6371DF75C;
	Mon, 28 Oct 2024 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSrWnXGr"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55118D65D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145277; cv=none; b=Ihv4D53Fp91BhKSSrhW+63dPBGVksc3lS+KZra00YwA/t1MkL83rW3+ypplPo/fzlXkdS1tG9odRp/gjlWZjD9yNMyNm/nFbcEiuBQQi7ylY8cP+Kp9tQGZbEVQy5We1OzkESjMgaY+o72XL0RaxHh8dN9s4zaOtaqQ/Pkt7UrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145277; c=relaxed/simple;
	bh=xEqSFdphUj/m4lVNP4wwRMew36LE0V9bUPR/s/JiXY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqRApMDJf3bmIx+mI7sshGqwwKpFRTsFNrHUkYj9N8gp9/pvTIUkF0uni8Q7jg7IwsLY8OspehNvxzpGCf0RiTeh0+rdE8oD3KlWfsyfOMx7RETuO+2XY/d63Fl+QLiidpDQZiXNZziEcYWTVhUl09h3ycPxpDQhHwOGF0XFLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSrWnXGr; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a5b15cedd6so1574406137.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730145274; x=1730750074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEqSFdphUj/m4lVNP4wwRMew36LE0V9bUPR/s/JiXY0=;
        b=bSrWnXGrSBhkukdg67gWkbaJaGTdsIsonU0BDW/KXjST8S3A9L9xV+paEJCzNCHLCS
         ZInQu+1ycgk3nFrRLBC82WXqLlzwFeX+AV6hSfk781xmmskLw28pYcguR1/a2TA2h1Wl
         eHVUG8aO6TEf1yFEr+GC4omdA9SPLEkfm9Hokfqgkj/eQzkS6JuUiQRVK6lBzacVIM+O
         0SafF1K2hLilLWP2Uu1AYhPZpZAtaKL2nFi7f7MUxMsroGJjFkqf8BHtuC55qBP+YJEv
         m+co6oOshGB3cSpMRNdV1FZHJaxxXy/yPT2OJlHC2M01qiFkuDIfgWZA9w9kLr6LXOa1
         cmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145274; x=1730750074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEqSFdphUj/m4lVNP4wwRMew36LE0V9bUPR/s/JiXY0=;
        b=U6483RbKM8qlGABXC2Z0HsmVa78stw+9RFRRyIDbo6fb7B3BYV8YH+ctXeYv73SKno
         90W6zDRcrMC04G153SliHqPe07E3x5Lv1O41nXOnjdKeDUaZojATbG9/jPWfPJ9dR7fn
         OGa6uVH/wdeGpy94AXWNtL/eot1AHlOtFYRxQSEKUaAaQ1IseLsmoLC7CKH1UBQCPRoc
         N9fQftgAIF7csTY+Ty8y3q2TXaOUrKGfS7MQPuQTs68UL8nCAENv2dZ5u8d8Dqu75Ivt
         VOWbIQJZCDRRQPNbdOiFjFYNY80fFnI3kZgp1aYbP603cRKblPDO9/9PJ1MIBZsfrmfV
         z3jA==
X-Forwarded-Encrypted: i=1; AJvYcCXKH2vcjVJVOipy308w1uKWJ3UCnYCOYnBsJpsI7lFeJwDpekRLH8OKwecvq9LoL0xBgdGej2e3DOqiTDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8W9bo3iWgLIyA4uLhyCvxRs1jZPGwznWKO6QdrXKxjrkiz8BK
	Sh7BQ4Q91pKhscJi3S88kl0p3AYmO85M2ZJiLSTYOYplhjSR8JzurVcmafppwKPEiB/nA1QuNua
	166nmtS1YZwslaXoU12LJtk8dPrY=
X-Google-Smtp-Source: AGHT+IE6nUCB0gz9ZT81xKQAodQPYCEtrgM8tH4oLOMLzbv9hVWzWlWjq9nnbsIhqCd39U4jbUlo2rcB8J5m7nf9CkE=
X-Received: by 2002:a05:6102:dcf:b0:4a3:cb2b:9745 with SMTP id
 ada2fe7eead31-4a8cfd3abfbmr8429227137.22.1730145273747; Mon, 28 Oct 2024
 12:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027011959.9226-1-21cnbao@gmail.com> <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
 <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com> <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
 <6303e3c9-85d5-40f5-b265-70ecdb02d5ba@gmail.com> <CAJD7tkZpO1nEvdh7qPWt4Pg=FU1KZfEd3vA9ucEpqdc-7kF0Jg@mail.gmail.com>
 <64f12abd-dde3-41a4-b694-cc42784217fb@gmail.com>
In-Reply-To: <64f12abd-dde3-41a4-b694-cc42784217fb@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 29 Oct 2024 03:54:22 +0800
Message-ID: <CAGsJ_4zQmaGxG2Ega61Jm5UMgHH-jtYC4ZCxsRX6+QS9ta25kQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 1:20=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 28/10/2024 17:08, Yosry Ahmed wrote:
> > On Mon, Oct 28, 2024 at 10:00=E2=80=AFAM Usama Arif <usamaarif642@gmail=
.com> wrote:
> >>
> >>
> >>
> >> On 28/10/2024 16:33, Nhat Pham wrote:
> >>> On Mon, Oct 28, 2024 at 5:23=E2=80=AFAM Usama Arif <usamaarif642@gmai=
l.com> wrote:
> >>>>
> >>>> I wonder if instead of having counters, it might be better to keep t=
rack
> >>>> of the number of zeropages currently stored in zeromap, similar to h=
ow
> >>>> zswap_same_filled_pages did it. It will be more complicated then thi=
s
> >>>> patch, but would give more insight of the current state of the syste=
m.
> >>>>
> >>>> Joshua (in CC) was going to have a look at that.
> >>>
> >>> I don't think one can substitute for the other.
> >>
> >> Yes agreed, they have separate uses and provide different information,=
 but
> >> maybe wasteful to have both types of counters? They are counters so ma=
ybe
> >> dont consume too much resources but I think we should still think abou=
t
> >> it..
> >
> > Not for or against here, but I would say that statement is debatable
> > at best for memcg stats :)
> >
> > Each new counter consumes 2 longs per-memcg per-CPU (see
> > memcg_vmstats_percpu), about 16 bytes, which is not a lot but it can
> > quickly add up with a large number of CPUs/memcgs/stats.
> >
> > Also, when flushing the stats we iterate all of them to propagate
> > updates from per-CPU counters. This is already a slowpath so adding
> > one stat is not a big deal, but again because we iterate all stats on
> > multiple CPUs (and sometimes on each node as well), the overall flush
> > latency becomes a concern sometimes.
> >
> > All of that is not to say we shouldn't add more memcg stats, but we
> > have to be mindful of the resources.
>
> Yes agreed! Plus the cost of incrementing similar counters (which ofcours=
e is
> also not much).
>
> Not trying to block this patch in anyway. Just think its a good point
> to discuss here if we are ok with both types of counters. If its too wast=
eful
> then which one we should have.

Hi Usama,
my point is that with all the below three counters:
1. PSWPIN/PSWPOUT
2. ZSWPIN/ZSWPOUT
3. SWAPIN_SKIP/SWAPOUT_SKIP or (ZEROSWPIN, ZEROSWPOUT what ever)

Shouldn't we have been able to determine the portion of zeromap
swap indirectly?

Thanks
Barry

