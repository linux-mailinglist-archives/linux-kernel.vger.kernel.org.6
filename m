Return-Path: <linux-kernel+bounces-309828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D429670C9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B3A1C21583
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2E617BB31;
	Sat, 31 Aug 2024 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+B7NmUQ"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0791171E69
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099715; cv=none; b=InaabN6PDAsv8MFL5woSFazuhq25+sFMc8HecW1oE8fQzY1T3u34ASN7pWvY8Y12Qd2DEVL6bvdduAnUFIWH+YRHwvg+3o/x8v7kRQVfkcE4QIlzRdOVa7l+AY27KuZFcLP/AuQYP1GyrnOlqrdwvBjsDT62WzADeLlS3PcI3ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099715; c=relaxed/simple;
	bh=a4Hf4OGBxB8Wp61zj2Yl+peALfDUy3M9xKZsJGXRvec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nybEmm+z12mYpDDBjtW2G/OTf6sP8dWZQmRecgeM0vpyC3Aw3/bIE+yUHpmsRpfuDftqZp2FbGdjmO96uI1AiThaiC6ZHqimJjK4JwbWvq/9ZYoi8IabbKH3wvy0X6C1vbplJNi52qRh6CCImjbqN9feYFkgHM1XdpDNpK2H9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+B7NmUQ; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4fd05947340so802573e0c.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725099712; x=1725704512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXxWR/GrNO12m4u8BQtgmx2P5GzluWWtjT+p2Yuyknc=;
        b=C+B7NmUQtTyV2hJJzV9tgG9RzhV/zYBfpOQ8tQU+5fPZDt6igBEsJ3BvxF58NKtSTf
         3P+TqcvUNgPJAUCFW7lsVDyUfU1j7p6Kqo1Lyo41GWpd2/xEFbiEKZRKYzjSLhMbn9Nd
         UNzkF68xunSYaOZc55BCc9HovDulGHbJIQHEhmXpYFLrZJQywCpbzz8kiPuCkmo/MZL7
         kgrjL7jARGftmjLpA2ch+pW2i9EAEpORjlpClvqJ02ywcpYxtXcOxk+YudrVNAtlO5m1
         +gfhZ64K9PmPo7Kzw/5xxs06YLhF5X7slJzTP/YaXVX47vUSEmRBiAilJc8ETU+6nPvv
         enKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725099712; x=1725704512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXxWR/GrNO12m4u8BQtgmx2P5GzluWWtjT+p2Yuyknc=;
        b=b3Dvyo8x5dZzTOYvyoeW6og5UUboyoIQsaGdJyiOGXVAs0jUH3mc7Q7SCTRdB2wT5e
         F6vPJOU35qtWuhpLwiPjdpOGvIVnYAFmQ9oQ3B5zm8MXYsrxWUuSe0nUNWAGUVYI2r3v
         DVyXs0Kfvr8HwirbfGu7YNWHgifzYAz2kxf/hkyTnFUtGjRfrrfQbZyZKc0tGMtt9mUt
         K10oh6mY5Yhk5vT2aqjaU6qHELeCYE+AJCURgNVNuCEiqvFbIIS5oueyzYgFryHch0Pz
         JbZGtpB7d19GHwFN/ABvT56d0PfdxRglscyPX5eqTHBeT1WW6B7HpPljPW8Cv8mD+Ed2
         1Z7g==
X-Forwarded-Encrypted: i=1; AJvYcCVtRZ/UmzgFPhqAG4LfNp3hCqg2dzPaF7PlwNsfQbRlo/3Zi8RV4CwTSrDOcqjz2VVDBOre5Br3D+CQknM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMSjH6h3weNxhR+JM35bRuaUcGAYfRYpO/CpRalI9WeHl3HA0
	pYxgaAzwI+5UJB+Dve8OTCTH7fmD0L3je+I+KLInvqsk0lxyk0DytuxJSrotXvlIzvOXhbtMRqr
	ir+kI6o0n6myHFFgsBGNiSDlQSFY=
X-Google-Smtp-Source: AGHT+IEGalUU1aCVflGtCG2F8YL4OP/GuyfWpZ+ewR17Wef/R0PoUs/Og4VgJ+3Mx2PKqMweVYYEbyen4BddrhvFfSY=
X-Received: by 2002:a05:6122:221b:b0:4fc:e4f5:7f83 with SMTP id
 71dfb90a1353d-5009b1305bfmr2186616e0c.9.1725099712469; Sat, 31 Aug 2024
 03:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831092339.66085-1-21cnbao@gmail.com> <d0b826c1-8577-46f8-8e4c-ca2b72554819@redhat.com>
 <CAGsJ_4ynOeOaRb3=xBc1uETn9oLTkSpZGoEYGpTeJ1F4uqB7bA@mail.gmail.com> <b7853f0f-7044-4c49-931c-c61900229b19@redhat.com>
In-Reply-To: <b7853f0f-7044-4c49-931c-c61900229b19@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 31 Aug 2024 22:21:41 +1200
Message-ID: <CAGsJ_4wwg-f32e=xSHn+Rxv5k7H6VXhUu3+v_ZOShL_mGn2Xew@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: entirely reuse the whole anon mTHP in do_wp_page
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 10:07=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 31.08.24 11:55, Barry Song wrote:
> > On Sat, Aug 31, 2024 at 9:44=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 31.08.24 11:23, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> On a physical phone, it's sometimes observed that deferred_split
> >>> mTHPs account for over 15% of the total mTHPs. Profiling by Chuanhua
> >>> indicates that the majority of these originate from the typical fork
> >>> scenario.
> >>> When the child process either execs or exits, the parent process shou=
ld
> >>> ideally be able to reuse the entire mTHP. However, the current kernel
> >>> lacks this capability and instead places the mTHP into split_deferred=
,
> >>> performing a CoW (Copy-on-Write) on just a single subpage of the mTHP=
.
> >>>
> >>>    main()
> >>>    {
> >>>    #define SIZE 1024 * 1024UL
> >>>            void *p =3D malloc(SIZE);
> >>>            memset(p, 0x11, SIZE);
> >>>            if (fork() =3D=3D 0)
> >>>                    exec(....);
> >>>           /*
> >>>         * this will trigger cow one subpage from
> >>>         * mTHP and put mTHP into split_deferred
> >>>         * list
> >>>         */
> >>>        *(int *)(p + 10) =3D 10;
> >>>        printf("done\n");
> >>>        while(1);
> >>>    }
> >>>
> >>> This leads to two significant issues:
> >>>
> >>> * Memory Waste: Before the mTHP is fully split by the shrinker,
> >>> it wastes memory. In extreme cases, such as with a 64KB mTHP,
> >>> the memory usage could be 64KB + 60KB until the last subpage
> >>> is written, at which point the mTHP is freed.
> >>>
> >>> * Fragmentation and Performance Loss: It destroys large folios
> >>> (negating the performance benefits of CONT-PTE) and fragments memory.
> >>>
> >>> To address this, we should aim to reuse the entire mTHP in such cases=
.
> >>>
> >>> Hi David,
> >>>
> >>> I=E2=80=99ve renamed wp_page_reuse() to wp_folio_reuse() and added an
> >>> entirely_reuse argument because I=E2=80=99m not sure if there are sti=
ll cases
> >>> where we reuse a subpage within an mTHP. For now, I=E2=80=99m setting
> >>> entirely_reuse to true only for the newly supported case, while all
> >>> other cases still get false. Please let me know if this is incorrect=
=E2=80=94if
> >>> we don=E2=80=99t reuse subpages at all, we could remove the argument.
> >>
> >> See [1] I sent out this week, that is able to reuse even without
> >> scanning page tables. If we find the the folio is exclusive we could t=
ry
> >> processing surrounding PTEs that map the same folio.
> >>
> >> [1] https://lkml.kernel.org/r/20240829165627.2256514-1-david@redhat.co=
m
> >
> > Great! It looks like I missed your patch again. Since you've implemente=
d this
> > in a better way, I=E2=80=99d prefer to use your patchset.
>
> I wouldn't say better, just more universally. And while taking care of
> properly sync'ing the mapcount vs. refcount :P
>
> >
> > I=E2=80=99m curious about how you're handling ptep_set_access_flags_nr(=
) or similar
> > things because I couldn=E2=80=99t find the related code in your patch 1=
0/17:
> >
> > [PATCH v1 10/17] mm: COW reuse support for PTE-mapped THP with CONFIG_M=
M_ID
> >
> > Am I missing something?
>
> The idea is to keep individual write faults as fast as possible. So the
> patch set keeps it simple and only reuses a single PTE at a time,
> setting that one PAE and mapping it writable.

I got your point, thanks! as anyway the mTHP has been exclusive,
so the following nr-1 minor page faults will set their particular PTE
to writable one by one.

>
> As the patch states, it might be reasonable to optimize some cases,
> maybe also only on some architectures. For example to fault-around and
> map the other ones writable as well. It might not always be desirable
> though, especially not for larger folios.

as anyway, the mTHP has been entirely exclusive, setting all PTEs
directly to writable should help reduce nr - 1 minor page faults and
ideally help reduce CONTPTE unfold and fold?

What is the downside to doing that? I also don't think mapping them
all together will waste memory?

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

