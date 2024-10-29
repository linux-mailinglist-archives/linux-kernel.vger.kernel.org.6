Return-Path: <linux-kernel+bounces-387432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E4C9B5147
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E40281DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD9A1D7989;
	Tue, 29 Oct 2024 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxFNeMdQ"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169B192589
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224026; cv=none; b=aim1K2UUxFgpoJ7qw/u1SZ/1PuL1tAMmyF64+vDrpew5OLBT01U3gViuJd5mzxy1KU29Ze15XCzt7aiWdlw2/XvbR4qK+Dexx7iLF5EYOM+9gdz1vOMEPdwA6hJZE0lGzr2Qk/mZozesNS506AmfsrQ6r5ynIyxfz/PoI+baa6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224026; c=relaxed/simple;
	bh=o6xVfP4AWDImns9Pcjik5dLlk13C9VGqWiL7EWtae8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHC+81P6ks9TQMZecXvaj3xsRoJ+NsD4rxOO1eVM82c5U6v1bJ2zGU8BQMvMUz03Pzw7PYRSZ89a+SL7DKfkeAff89hJ2IiWFjxq0/58pcdWQKwcRi0EdNzJaKWoW/Edn7SpKxvgkmzbTeY37bOhuxh9WTb8FiHS5NYg3d76J7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxFNeMdQ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e60966297fso3227590b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730224023; x=1730828823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6xVfP4AWDImns9Pcjik5dLlk13C9VGqWiL7EWtae8s=;
        b=JxFNeMdQ7qexPSKJ9Jmt2T7bK1/ErhfWKWGUqG5E6IYZ40tGkvg4/tM5PpPtITc/Fh
         pvx9mm1v8Rt2I2OkRxWiXbhg3N4+gTzJvHXJ2SViCgfu9DRuOX6LKktClwLFQLckys6s
         6JjyGOUBpDwHfy3XiTZJElZ0e3COyGA6faafiV3t8Z7oVrMzrckJ3xgqv7Ojqa4AIMJj
         E5h+JEZ7rthDLHQFSdv903DKwHAPZoDlTfaWI6s35a1Ci8ijfg+H+9Yl5l4Q7Tbr4eWp
         15i3G9UGl762Yak2e6WXykRG1H61SJC0SMZ/YaVZMuXryT5cv42RbqyhULbIJraeWA6F
         0xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730224023; x=1730828823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6xVfP4AWDImns9Pcjik5dLlk13C9VGqWiL7EWtae8s=;
        b=AlbjjTOEmVO6yitxrQMOEbDUZTyZd6fMKVGubDRLiNiTXtcC+YtTO3MP79wqWHbKyB
         Mg1OmgXQYRO6nkyOhWuLin8jXEK/4GxurGjXjmFxoasirWx4HZiOI/l5LQ0DwUliHtzS
         oO5sYuI+DufQHUr2GgFEbJVorssRiapP59sLfCzFA3UrRlTjsxmMmVNyr5UW5WsomL1b
         BBqfnE4RFCTyp6q6YPrhItMgoywupJ3NIzF+1fcAycAWoSOaO7XQLnyc5O5hrJ7gbqhy
         7jzrvtXBUHEpPveTt2Q1XnUD6Rz9ys1kpK73uNRQuDeI1sncA+UPa7FjctTd93k5CDVu
         La4g==
X-Forwarded-Encrypted: i=1; AJvYcCWBGAekJ/82OzB0l80v/3IspwdjpFbP4zTeSIdnvD7mNibKj3REbppsMEwIb+368xf0Vs66a6s1XoA5dNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrmplgcxf4uOIt9Idy+JqV7TBXahPiOQuQH5nfBl9w5gatCkoi
	04rXvldFQp4Y5zJ4O5EM21dboljoATj6WF7+UT0b6n8OiRiERBDg9//dWY8wtuzdBYiewsK1gpd
	ZZCYSQxCEp1Qn9kZChEbB4CILig8=
X-Google-Smtp-Source: AGHT+IE7dKkM6rEd7MQhQz1c94b/1mS1byd5I5IB/6mA1cKHdaYvEfKyEnTsz6bkK3hCok8h0iedHGE2bJDKvYarFuU=
X-Received: by 2002:a05:6808:3c95:b0:3e6:1291:7629 with SMTP id
 5614622812f47-3e63823d82cmr13768963b6e.3.1730224023549; Tue, 29 Oct 2024
 10:47:03 -0700 (PDT)
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
 <64f12abd-dde3-41a4-b694-cc42784217fb@gmail.com> <CAGsJ_4zQmaGxG2Ega61Jm5UMgHH-jtYC4ZCxsRX6+QS9ta25kQ@mail.gmail.com>
 <882008b6-13e0-41d8-91fa-f26c585120d8@gmail.com> <CAGsJ_4yBkry-rw75AciT8OiYWrw+=D0okcxiyXzzNrz=QJxiBA@mail.gmail.com>
 <cba36cb0-66c7-45c1-97c3-a96ea48a6cf0@gmail.com> <CAGsJ_4wXO2Hjs0HZBGsGegBAeE8YxJbCF6ZXQQ6ZnVxgR82AuQ@mail.gmail.com>
 <228c428d-d116-4be1-9d0d-0591667b7ccb@gmail.com> <CAGsJ_4zLNA-1+3j4snNLiujT3NLcmKEVFA4+eD1Sk1bOkqAGYw@mail.gmail.com>
 <03d4c776-4b2e-4f3d-94f0-9b716bfd74d2@gmail.com> <CAGsJ_4zRZFpJ0rWQ3XzspfSXN6xXN4eftCdL3xHPTqqYLUhQcA@mail.gmail.com>
 <CAJD7tkYPB=2c23LMi1+=qrPO+rcr5zJB4+2TPrcjAZHhsm=Vsw@mail.gmail.com>
 <CAGsJ_4yxoBVEY-Zpp3YNbiCCwbKO+v3-9R984uGVRHAtMSLDLQ@mail.gmail.com>
 <CAJD7tkYmBgp5WK9pD=ap=WuqWiiHvEhG0N0J_TiYdGRNaxwLVA@mail.gmail.com> <CAGsJ_4yvWjkYNXu7+FkovEA3RGHu31g1DRAYtNdoQYKhnWcYwQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4yvWjkYNXu7+FkovEA3RGHu31g1DRAYtNdoQYKhnWcYwQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 29 Oct 2024 10:46:51 -0700
Message-ID: <CAKEwX=Mxh+G=6Yq_gSuSoB3XjpGepYEGPg-eYh1RU_690tGedA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Usama Arif <usamaarif642@gmail.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 4:03=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Oct 29, 2024 at 6:54=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Mon, Oct 28, 2024 at 3:52=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Tue, Oct 29, 2024 at 6:33=E2=80=AFAM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > [..]
> > > > > > > By the way, I recently had an idea: if we can conduct the zer=
omap check
> > > > > > > earlier - for example - before allocating swap slots and page=
out(), could
> > > > > > > we completely eliminate swap slot occupation and allocation/r=
elease
> > > > > > > for zeromap data? For example, we could use a special swap
> > > > > > > entry value in the PTE to indicate zero content and directly =
fill it with
> > > > > > > zeros when swapping back. We've observed that swap slot alloc=
ation and
> > > > > > > freeing can consume a lot of CPU and slow down functions like
> > > > > > > zap_pte_range and swap-in. If we can entirely skip these step=
s, it
> > > > > > > could improve performance. However, I'm uncertain about the b=
enefits we
> > > > > > > would gain if we only have 1-2% zeromap data.
> > > > > >
> > > > > > If I remember correctly this was one of the ideas floated aroun=
d in the
> > > > > > initial version of the zeromap series, but it was evaluated as =
a lot more
> > > > > > complicated to do than what the current zeromap code looks like=
. But I
> > > > > > think its definitely worth looking into!
> > > >
> > > > Yup, I did suggest this on the first version:
> > > > https://lore.kernel.org/linux-mm/CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h=
7WQjDnsdwM=3Dg9cpAw@mail.gmail.com/
> > > >
> > > > , and Usama took a stab at implementing it in the second version:
> > > > https://lore.kernel.org/linux-mm/20240604105950.1134192-1-usamaarif=
642@gmail.com/
> > > >
> > > > David and Shakeel pointed out a few problems. I think they are
> > > > fixable, but the complexity/benefit tradeoff was getting unclear at
> > > > that point.
> > > >
> > > > If we can make it work without too much complexity, that would be
> > > > great of course.
> > > >
> > > > >
> > > > > Sorry for the noise. I didn't review the initial discussion. But =
my feeling
> > > > > is that it might be valuable considering the report from Zhiguo:
> > > > >
> > > > > https://lore.kernel.org/linux-mm/20240805153639.1057-1-justinjian=
g@vivo.com/
> > > > >
> > > > > In fact, our recent benchmark also indicates that swap free could=
 account
> > > > > for a significant portion in do_swap_page().
> > > >
> > > > As Shakeel mentioned in a reply to Usama's patch mentioned above, w=
e
> > > > would need to check the contents of the page after it's unmapped. S=
o
> > > > likely we need to allocate a swap slot, walk the rmap and unmap, ch=
eck
> > > > contents, walk the rmap again and update the PTEs, free the swap sl=
ot.
> > > >
> > >
> > > So the issue is that we can't check the content before allocating slo=
ts and
> > > unmapping during reclamation? If we find the content is zero, can we =
skip
> > > all slot operations and go directly to rmap/unmap by using a special =
PTE?
> >
> > We need to unmap first before checking the content, otherwise the
> > content can change right after we check it.
>
> Well, do we have a way to terminate the unmap if we find pte_dirty and en=
sure
> the folio is still mapped after try_to_unmap_one()? Then we could
> activate it again
> after try_to_unmap.
>
> It might just be noise. Let me take some more time to think about it. :-)

FWIW, the swap abstraction layer Yosry proposed last year (and I'm
working on right now) will allow you to store these zeromapped swap
entries without requiring any swap slots allocated on the swapfile.
It's basically the same thing as swap/zswap decoupling.

Not stopping you guys from optimizing it, since all I have right now
is a (most certainly buggy) prototype + there might be benefits if we
can get around the swap subsystem altogether for these zero mapped
entries. Just letting you know there's a backup plan :)

