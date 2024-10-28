Return-Path: <linux-kernel+bounces-386026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E34899B3E48
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6630B1F23241
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BEA1E0B93;
	Mon, 28 Oct 2024 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQkP2GAw"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3F188CDC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156605; cv=none; b=nUvEJeXZr3ETORnJPMBvoWkfAV3t8GNS+eIdoLP3Bp2SpsoouT2Y/LHcRjRYjatkz923k4ork3YcGJUNtFTdu2mwNv5pcER5I7TiYQcP0+RrPEweieVtSxOdPo9O4NIY2aanOastxW44I9DivFF8vrPxkWgRMW9Fm5LHyhnzPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156605; c=relaxed/simple;
	bh=Azy0v9jtjkVLRmMSUwvVawjYHa/FT9WykC0F8frkrbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBMobys6LDb0CL7EfI735LxsfDuOJhkfdXdRoQfz7eOYA94Kgp8/tGMUBbJ5iVpDdznWVenil3dXMOVNe1DzR+suS3UWDbRaaKSapc8M/0Vlqm1azuvtJNfqTMKOx/EEUy0jYdOpmS7fnZrIcyQlLTsQUxg2QNaHcLWRiJcSUsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQkP2GAw; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84fd616acf0so1596594241.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730156602; x=1730761402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Azy0v9jtjkVLRmMSUwvVawjYHa/FT9WykC0F8frkrbY=;
        b=AQkP2GAwGC5YcGUc95vdpaVRkie+HgndxqHxLe+OjxZAy8b8X+ER0psvqXXjkUKABH
         uYAOseWdAf5dvse0x15FizNacmSjzmHdgeFCtGOkpk4Sco2SHQNslxoyq87a6k9XSIuM
         nqMfTU9EHvFfKexYXs9Dq8o0NOeyL9E3+S46lNtKvSmT7OKQiw3vowJ2wyt4Scn29Irf
         q0f/qkm4MIiV8Cvb55uYNvYaoKVU2aTqEE0rjFJRHOqt3DTgKGe7n6E31zxt1GczZg0G
         0i6MrzFIkN+ZWTKGi1oGdhU78qoZ/MDBlibQgDGM6bC+h7Fbld7ykkfr2HBXWdfOXP6P
         WtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730156602; x=1730761402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Azy0v9jtjkVLRmMSUwvVawjYHa/FT9WykC0F8frkrbY=;
        b=U3XVRs7HOXNRTtJKIZ22RTF7WkMlPYNslcr3gFMiBmCc1omXCGLptCdfOnfMDlpvFJ
         ynpZDmyuHyaDUwNVPEaV/zTHXKBSghtvSFrArdEPcaW+ZEHMmQ58+XNy5OuR0n9zJrkg
         LRyJW+TtA34kwhQrReUMjDHfXgccb+LpVB82QUODXvHTDWOtS9J9q8IjjKj7mut4dlsw
         cZP/0/xwCzGkchJKj0Qy7WfgRe+4/99STDTJaUTxykfMwwtdkRRCM7DMpyNgCDtTwMpf
         IXBZSKidTgNlvNYXHw942yNZbRyh06vuRm2D3et9YDCLFWLriGfEP+ERju19Za3c7aKV
         vcyg==
X-Forwarded-Encrypted: i=1; AJvYcCXYy/Xu+KEHS/YSbVuD/fFzr0B0/OSWtdgxsuSY8ltcwJP2tpP/GBO70c+CLhPDBIQ8FPGpRAcutwik1iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+0u1wg18ftqNURcTgkY5TbQgAHZGd19PpOjZNInqINp5vrTh
	IvGZ/wb45j29Z/Hd3c0u75isFECWfFXax2N5r3pRHd8CWZuJMHwFMm5OO1QDyeD/RrNphyzLVpB
	33m5gsoN8wszte8DVjY+4RK3oXoI=
X-Google-Smtp-Source: AGHT+IEGbeMUDYWfp+H60X5Eb7NfSJtT/bmNi74QInOCuoBT3cy9A90I/F9VBhCDZLNwMJsfzZ8QBVFvElzFOSBbR/c=
X-Received: by 2002:a05:6122:1796:b0:50d:a577:dec0 with SMTP id
 71dfb90a1353d-510150306e9mr6602082e0c.5.1730156602563; Mon, 28 Oct 2024
 16:03:22 -0700 (PDT)
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
 <CAGsJ_4yxoBVEY-Zpp3YNbiCCwbKO+v3-9R984uGVRHAtMSLDLQ@mail.gmail.com> <CAJD7tkYmBgp5WK9pD=ap=WuqWiiHvEhG0N0J_TiYdGRNaxwLVA@mail.gmail.com>
In-Reply-To: <CAJD7tkYmBgp5WK9pD=ap=WuqWiiHvEhG0N0J_TiYdGRNaxwLVA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 29 Oct 2024 07:03:11 +0800
Message-ID: <CAGsJ_4yvWjkYNXu7+FkovEA3RGHu31g1DRAYtNdoQYKhnWcYwQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 6:54=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Oct 28, 2024 at 3:52=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Tue, Oct 29, 2024 at 6:33=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > [..]
> > > > > > By the way, I recently had an idea: if we can conduct the zerom=
ap check
> > > > > > earlier - for example - before allocating swap slots and pageou=
t(), could
> > > > > > we completely eliminate swap slot occupation and allocation/rel=
ease
> > > > > > for zeromap data? For example, we could use a special swap
> > > > > > entry value in the PTE to indicate zero content and directly fi=
ll it with
> > > > > > zeros when swapping back. We've observed that swap slot allocat=
ion and
> > > > > > freeing can consume a lot of CPU and slow down functions like
> > > > > > zap_pte_range and swap-in. If we can entirely skip these steps,=
 it
> > > > > > could improve performance. However, I'm uncertain about the ben=
efits we
> > > > > > would gain if we only have 1-2% zeromap data.
> > > > >
> > > > > If I remember correctly this was one of the ideas floated around =
in the
> > > > > initial version of the zeromap series, but it was evaluated as a =
lot more
> > > > > complicated to do than what the current zeromap code looks like. =
But I
> > > > > think its definitely worth looking into!
> > >
> > > Yup, I did suggest this on the first version:
> > > https://lore.kernel.org/linux-mm/CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h7W=
QjDnsdwM=3Dg9cpAw@mail.gmail.com/
> > >
> > > , and Usama took a stab at implementing it in the second version:
> > > https://lore.kernel.org/linux-mm/20240604105950.1134192-1-usamaarif64=
2@gmail.com/
> > >
> > > David and Shakeel pointed out a few problems. I think they are
> > > fixable, but the complexity/benefit tradeoff was getting unclear at
> > > that point.
> > >
> > > If we can make it work without too much complexity, that would be
> > > great of course.
> > >
> > > >
> > > > Sorry for the noise. I didn't review the initial discussion. But my=
 feeling
> > > > is that it might be valuable considering the report from Zhiguo:
> > > >
> > > > https://lore.kernel.org/linux-mm/20240805153639.1057-1-justinjiang@=
vivo.com/
> > > >
> > > > In fact, our recent benchmark also indicates that swap free could a=
ccount
> > > > for a significant portion in do_swap_page().
> > >
> > > As Shakeel mentioned in a reply to Usama's patch mentioned above, we
> > > would need to check the contents of the page after it's unmapped. So
> > > likely we need to allocate a swap slot, walk the rmap and unmap, chec=
k
> > > contents, walk the rmap again and update the PTEs, free the swap slot=
.
> > >
> >
> > So the issue is that we can't check the content before allocating slots=
 and
> > unmapping during reclamation? If we find the content is zero, can we sk=
ip
> > all slot operations and go directly to rmap/unmap by using a special PT=
E?
>
> We need to unmap first before checking the content, otherwise the
> content can change right after we check it.

Well, do we have a way to terminate the unmap if we find pte_dirty and ensu=
re
the folio is still mapped after try_to_unmap_one()? Then we could
activate it again
after try_to_unmap.

It might just be noise. Let me take some more time to think about it. :-)

