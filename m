Return-Path: <linux-kernel+bounces-412669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61B09D0D91
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B04B2100F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122731925AA;
	Mon, 18 Nov 2024 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuyHMDTx"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72617C98
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923760; cv=none; b=srzTHAOpruClD/Bx22fkcA59HnD92C3aFNIfi61yrTl7JlGJ9R89Uld7oi4fFjiKLsPQX5EeV+kQRxSbvHUfYLV7742v7nPw+9OR0flva1Dug/4dIaDmiWWXQm+bEdTJeQe+9wymnlVP9Qi8NOmE2QfE8WBL2uGSe6osBhpRAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923760; c=relaxed/simple;
	bh=Z2Ay6hNDDPBCuA4PRisSjTsou7F81WXizBC8cFebniY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msaNv1DFQHc8z+rOz7qYp9NRyKKE/brNR1e8FGsvWufZM/CDRS3RB9haNwCDO222EaGc2+PUC2BgkcWFaMryRmLLSej9cPytxi8YNiyugmGZTEXfAMYw8zo+CmcGdzjvEWamcT7qMV+jP/x+RkO+adwYYgBwoxFhsDnnf8nwZzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuyHMDTx; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50d4a333a87so699169e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731923758; x=1732528558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XBn3eltmgdPbS9blb6pj2zhebO55+mcn//WKceu2aI=;
        b=DuyHMDTxy4Le7Lyzeq2GOSWIu9vEGTUZCA+v4LE3dRcusx8z5eIu6eJDtSFM645nt5
         tVBc/hnBQG7VcZ98GODuuWzbQsYDBwhNLFCMArBeHAh5/og/ZEdISmytfg4VQ6Ilvkf5
         n8Ek81r3hdrAuRuNeKagRHwKuaE7yJCSUbaK7KvO7tEfzlI9gVv087onY/xkcsRPkOqB
         oCKHJhGpnu2nEQltIUs84dE2xO/e07jbaMC8hlSBqbCOZwMLn9UbkoLDjXErgQo0q9EP
         8fKKeikoVCTBWHiMRAEkYu6eWb2/sQVMFBii/dYPiktyKh00fNKpodFQ/7EqtwZ6ajwX
         gfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731923758; x=1732528558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XBn3eltmgdPbS9blb6pj2zhebO55+mcn//WKceu2aI=;
        b=jxPZgmaWY03t9dCjmu1zXYMQnXmfl/fAx8caGQHFwzpfs9LTCoQEOzisMaI4U5pRSA
         O7kxN7bhgcgcf5LoO3tFj5vqlyWE3E1q2iJ/EWrs4gXBBQ+zQwIkDF3FKcmM2Arvz9wb
         VhQcsbgW25sggrqrIZd9kntwGiy0cbx4qHR6h1MYDw2Nb6dV53ueki7/bbfwX2rJLOVn
         2gsR9O+ygbAlpqNbsaD1iEJZMc1Xbffl9fJGXi3dK81cwUfVtvkso4e8Jd1RMqWgU3zL
         IgO6oyrU4QHQ4/1yICTts2sf/MZT/FQc36fYjuF7jfgE87E8TF5kZR7nvrgm0QJAfUsH
         W55w==
X-Forwarded-Encrypted: i=1; AJvYcCX+w2WaMNHh/nBhDNbwvCKv1rQctPIZGI1qF++YUX432Pcy8h9l+5vFIyx9+G2wphwiyWMvDG3p7tY0qRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xn4p4FW9SRaG4pgYLt9yhNVcDRS8BhRNudMaegWBGv7W8IZ0
	M8qGKIk9lR9vmB+UZhiYMiABTUnh/4ECTIJhjWdGUti87bOvgJ8KxOEt2za3LWEOofML1O86MOM
	gXQVWNyeWjXdYrRTH9Ti8j2hfZwg=
X-Google-Smtp-Source: AGHT+IEYb+dQBWlXZysNIhX4ZVXX5//5CKenDruGCDE5lV/Io1VJmSrNOwP2DlJsm8+ewh5qt4HrslfVaGttD4wEhsU=
X-Received: by 2002:a05:6122:1689:b0:50c:4eb7:90fa with SMTP id
 71dfb90a1353d-51477eedcf0mr10191771e0c.5.1731923757802; Mon, 18 Nov 2024
 01:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
 <20241116091658.1983491-2-chenridong@huaweicloud.com> <Zzq8jsAQNYgDKSGN@casper.infradead.org>
 <CAGsJ_4x0OrdhorQdz8PyLD84GOYVZJ7kLfGV_5yupLG_ZQ_B3w@mail.gmail.com> <03c18a7b-24fa-4ee6-8682-63f1a81363e5@huawei.com>
In-Reply-To: <03c18a7b-24fa-4ee6-8682-63f1a81363e5@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 18 Nov 2024 22:55:46 +1300
Message-ID: <CAGsJ_4w5Tna1c0xO7w4=c+SRw1jQgHCCzNELkBURbCiAgxZ-cg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to the
 tail of LRU after shrinking
To: chenridong <chenridong@huawei.com>, Chris Li <chrisl@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Chen Ridong <chenridong@huaweicloud.com>, 
	akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org, 
	yosryahmed@google.com, yuzhao@google.com, david@redhat.com, 
	ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	wangweiyang2@huawei.com, xieym_ict@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 10:41=E2=80=AFPM chenridong <chenridong@huawei.com>=
 wrote:
>
>
>
> On 2024/11/18 12:14, Barry Song wrote:
> > On Mon, Nov 18, 2024 at 5:03=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> >>
> >> On Sat, Nov 16, 2024 at 09:16:58AM +0000, Chen Ridong wrote:
> >>> 2. In shrink_page_list function, if folioN is THP(2M), it may be spli=
ted
> >>>    and added to swap cache folio by folio. After adding to swap cache=
,
> >>>    it will submit io to writeback folio to swap, which is asynchronou=
s.
> >>>    When shrink_page_list is finished, the isolated folios list will b=
e
> >>>    moved back to the head of inactive lru. The inactive lru may just =
look
> >>>    like this, with 512 filioes have been move to the head of inactive=
 lru.
> >>
> >> I was hoping that we'd be able to stop splitting the folio when adding
> >> to the swap cache.  Ideally. we'd add the whole 2MB and write it back
> >> as a single unit.
> >
> > This is already the case: adding to the swapcache doesn=E2=80=99t requi=
re splitting
> > THPs, but failing to allocate 2MB of contiguous swap slots will.
> >
> >>
> >> This is going to become much more important with memdescs.  We'd have =
to
> >> allocate 512 struct folios to do this, which would be about 10 4kB pag=
es,
> >> and if we're trying to swap out memory, we're probably low on memory.
> >>
> >> So I don't like this solution you have at all because it doesn't help =
us
> >> get to the solution we're going to need in about a year's time.
> >>
> >
> > Ridong might need to clarify why this splitting is occurring. If it=E2=
=80=99s due to the
> > failure to allocate swap slots, we still need a solution to address it.
> >
> > Thanks
> > Barry
>
> shrink_folio_list
>   add_to_swap
>     folio_alloc_swap
>       get_swap_pages
>         scan_swap_map_slots
>         /*
>         * Swapfile is not block device or not using clusters so unable
>         * to allocate large entries.
>         */
>         if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
>           return 0;
>
> In my test, I use a file as swap, which is not 'SWP_BLKDEV'. So it
> failed to get get_swap_pages.

Alright, a proper non-rotating swap block device would be much
better. In your case, though, cluster allocation isn=E2=80=99t supported.

>
> I think this is a race issue between 'shrink_folio_list' executing and
> writing back asynchronously. In my test, 512 folios(THP split) were
> added to swap, only about 60 folios had not been written back when
> 'move_folios_to_lru' was invoked after 'shrink_folio_list'. What if
> writing back faster? Maybe this will happen even 32 folios(without THP)
> are in the 'folio_list' of shrink_folio_list's inputs.

On a real non-rotate swap device, the race condition would occur only when
contiguous 2MB swap slots are unavailable.

Hi Chris,
I recall you mentioned unifying the code for swap devices and swap files, o=
r
for non-rotating and rotating devices. I assume a swap file (not a block de=
vice)
would also be a practical user case?

>
> Best regards,
> Ridong

Thanks
Barry

