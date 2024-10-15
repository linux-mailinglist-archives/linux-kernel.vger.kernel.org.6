Return-Path: <linux-kernel+bounces-366620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 157E699F7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A831F2239A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D31F76B4;
	Tue, 15 Oct 2024 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfIeVi2w"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E991B3936
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023036; cv=none; b=MbFRj82gf4qMf325a9oXv3o9HGAWLuAYO93Kt5P8Yc4r5n/hCzahuJiTm4u9eSQdooAVp2Tqs/j1E+RhZRr/f4pKOuroJN2ohb8kb3aKrOHjuAZ+UAka3Wob5i9mB8GoP9Jx9HTS1ToAPq3coLiLadkE+w6iTMZAM1Li5pkmYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023036; c=relaxed/simple;
	bh=+IZLUbdC3a5VkG6ekzM6z6vzbHg+prIGmN6C1yRHEsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDb9axVPKgGzgBiJlbut3Ae0zTkG+y7TsaqCZmE2o6hxuy4i3CpWC96mNizuzH2/7rAkVadEML1dj3t3A4411OtgVDZYeGCYdGGZbKcjMZHMX1d6hPTDZ+7uRFwg5hwMP4/ftb5JJxLX2zno3x2diwU8O2F+a5OXW3ONJrBKufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfIeVi2w; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50d431b0ae2so120269e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729023033; x=1729627833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoX7+hLaC0C/69Spu6+hOK+MSkV4/XZ7Txsz18m8pxg=;
        b=OfIeVi2wNm+DtPsLDRerkuZv8c5upZl4OoNPLJP+OWSj1M8QEBX2z76icG+/T9Hy+e
         OAcUT0hX6psc7D0445gd7I5NRrpwlXj0RBBHgfIq1HEduMORoNlHXML8CV/OGPfnib5Y
         cDy1f25CoPzKSJwuIAmf4CT8x56bDQxVlCEXOu6z0gNSQ+JBS5ayzUI2hwJQn1fcYNWt
         lLTLJ0zpq4xyJvW8vrc0XA8at32/h9e5VpOzvJSQkaAhakLNxfx5jlAnvk/y/s3FZl9j
         DTXcrXnHQ6z+tKmVk/zEGRQrJPqdZaoeIsKZmy2/rSYsKB1OfqGD5ikm8EE7IRU5GrQJ
         zStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729023033; x=1729627833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoX7+hLaC0C/69Spu6+hOK+MSkV4/XZ7Txsz18m8pxg=;
        b=BljV0ByFBzJjiBkDxdEeaxM9pv9dTqaeq0aVy9RomX+rLpqD9YDo9MoQpzgcYJW22g
         n53negeF1fBc3yXrNO0XarlsJaX+Z4iSTMoYOXHU/dlOjeEiCYw7gpbU7SIqy6wSGG9T
         ApbNkopZzIQE8/2k0eE2rHK1VQCdc41ga4qqOl8HvFN1HerMumZl0indy0iP/9XKO+dq
         o4WP4u9cxL6gl+LesD5crzRLWdu23VcBmjScWOiwYrSXeURKIDbGvb82d/6zEpSra/jL
         iDwuAJqdNScGgn59lWTwefbAXSUMlOQFj8tDrMtBGo75xIwY7Neln5DzalH5sbymwjvx
         9nWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLHdBSsNB0C2G749M17aLQaicCMkDk8qOJZF97cvNV5aBJoCp4W4nVYBTiTu3vTQx+KbOOSccuKqzuGME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoHlTI0rQbKBRfzeLBkhq/p8qxpmNNJrJ+8JJOB9yPYkwuxMSV
	QBVqQ08SSOhBqFmL3VueuQfaSbSoWQ2msteJnQTjW9NVihsL+/RWHXo729oVlKDXgeOpwfZOjoG
	b+SUu3wyQZUy8imhx/3a02G2qADc=
X-Google-Smtp-Source: AGHT+IEsYPsTX4eylMTds43/bzmQobTVe9+2pqaFnScuD8Bd/Iwkduivlw6dP8DrCJn+8z6kLaQ0xdwcdJurNvKh8Ag=
X-Received: by 2002:a05:6122:2216:b0:50c:ef20:6bed with SMTP id
 71dfb90a1353d-50d1bb18ba6mr11219904e0c.3.1729023032911; Tue, 15 Oct 2024
 13:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914063746.46290-1-21cnbao@gmail.com> <92f97c8e-f23d-4c6e-9f49-230fb4e96c46@redhat.com>
 <CAGsJ_4zdqXtvUS8fHzUhM=iGrPpC8X7uw8wt4sSfCvsrh7um3w@mail.gmail.com> <7dcd3446cd8c4da69242e5d6680c1429@honor.com>
In-Reply-To: <7dcd3446cd8c4da69242e5d6680c1429@honor.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 16 Oct 2024 09:10:21 +1300
Message-ID: <CAGsJ_4xF6FuncfErMmMotkOYNGZcqPXqS20zORAyVZ4LYbO0_w@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mglru: provide a separate list for lazyfree anon folios
To: gaoxu <gaoxu2@honor.com>
Cc: David Hildenbrand <david@redhat.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"mhocko@suse.com" <mhocko@suse.com>, "hailong.liu@oppo.com" <hailong.liu@oppo.com>, 
	"kaleshsingh@google.com" <kaleshsingh@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lokeshgidra@google.com" <lokeshgidra@google.com>, "ngeoffray@google.com" <ngeoffray@google.com>, 
	"shli@fb.com" <shli@fb.com>, "surenb@google.com" <surenb@google.com>, "yuzhao@google.com" <yuzhao@google.com>, 
	"minchan@kernel.org" <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 11:03=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
>
> >
> > On Wed, Sep 18, 2024 at 12:02=E2=80=AFAM David Hildenbrand <david@redha=
t.com>
> > wrote:
> > >
> > > On 14.09.24 08:37, Barry Song wrote:
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > > >
> > > > This follows up on the discussion regarding Gaoxu's work[1]. It's
> > > > unclear if there's still interest in implementing a separate LRU
> > > > list for lazyfree folios, but I decided to explore it out of
> > > > curiosity.
> > > >
> > > > According to Lokesh, MADV_FREE'd anon folios are expected to be
> > > > released earlier than file folios. One option, as implemented by Ga=
o
> > > > Xu, is to place lazyfree anon folios at the tail of the file's
> > > > `min_seq` generation. However, this approach results in lazyfree
> > > > folios being released in a LIFO manner, which conflicts with LRU
> > > > behavior, as noted by Michal.
> > > >
> > > > To address this, this patch proposes maintaining a separate list fo=
r
> > > > lazyfree anon folios while keeping them classified under the "file"
> > > > LRU type to minimize code changes. These lazyfree anon folios will
> > > > still be counted as file folios and share the same generation with
> > > > regular files. In the eviction path, the lazyfree list will be
> > > > prioritized for scanning before the actual file LRU list.
> > > >
> > >
> > > What's the downside of another LRU list? Do we have any experience on=
 that?
> >
> > Essentially, the goal is to address the downsides of using a single LRU=
 list for files
> > and lazyfree anonymous pages - seriously more files re-faults.
> >
> > I'm not entirely clear on the downsides of having an additional LRU lis=
t. While it
> > does increase complexity, it doesn't seem to be significant.
> >
> > Let's wait for Gaoxu's test results before deciding on the next steps.
> > I was just
> > curious about how difficult it would be to add a separate list, so I to=
ok two hours
> > to explore it :-)
> Hi song,
> I'm very sorry, various reasons combined have caused the delay in the res=
ults.
>
> Basic version=EF=BC=9Aandroid V (enable Android ART use MADV_FREE)
> Test cases: 60 apps repeatedly restarted, tested for 8 hours;
> The test results are as follows:
>         workingset_refault_anon   workingset_refault_file
> base        42016805                92010542
> patch       19834873                49383572
> % diff       -52.79%                  -46.33%
>
> Additionally, a comparative test was conducted on
> add-lazyfree-folio-to-lru-tail.patch[1], and the results are as follows:
>                workingset_refault_anon   workingset_refault_file
> lazyfree-tail        20313395                 52203061
> patch             19834873                 49383572
> % diff              -2.36%                    -5.40%
>
> From the results, it can be seen that this patch is very beneficial and
> better than the results in [1]; it can solve the performance issue of hig=
h
> IO caused by extensive use of MADV_FREE on the Android platform.
>

Thank you for the testing and data. The results look promising. Would you
mind if I send a v2 with the test data and your tag included in the changel=
og?
I mean:

Tested-by: Gao Xu <gaoxu2@hihonor.com>

> Test case notes: There is a discrepancy between the test results mentione=
d in
> [1] and the current test results because the test cases are different. Th=
e test
> case used in [1] involves actions such as clicking and swiping within the=
 app
> after it starts; For the sake of convenience and result stability, the cu=
rrent
> test case only involves app startup without clicking and swiping, and the=
 number
> of apps has been increased (30->60).
>
> 1. https://lore.kernel.org/all/f29f64e29c08427b95e3df30a5770056@honor.com=
/T/#u
> >
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
> >

Thanks
Barry

