Return-Path: <linux-kernel+bounces-396298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB29BCB1A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7569B1F23B64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1241D3184;
	Tue,  5 Nov 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8ADDP/N"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C771D27AF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804277; cv=none; b=NipcoJEbXt68xze0xD9xbkhKOwK5L+DziEyOAMursFtWRvL8W6TPhVrhGu3oAmAoUVMpaS1yRGl24T11DpTpOqczorJMojBXSIVKP1YuK2DacCbftx7tq2sNHGKez1xsAhKkz6kDuVmzu29x+1heUXvzhlSKHA6TWASxQDWzNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804277; c=relaxed/simple;
	bh=eV2viirJ5WHpPDhI85QO4dxhMP7y7UjkxdAMVF5QhM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpKgt6AV9vo1pLXTb6740J180yZyIVC85MR7yxxjlqU5ELYGn6tQKxlosT2h6iqyZk2u1w98MxGFRxcWSl+Q89OMxQdLw4OB7+h1i+OfJoJe08M1nmI8/NMXtJiVluDmyMCx8Wnu7ht5PpqZYEMA2+66Gh2wgG0mf5C2tX38c7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8ADDP/N; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85019a60523so1744635241.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730804274; x=1731409074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7XM9/dVatJ/H1vTPPYlueifW2nkKAEOY6leLXkNvBU=;
        b=i8ADDP/N0uDBBiZXwJiFqp01FwO90aHrefyKXPcp2snglb/A4v8TgCfOCXEtVVrWHT
         iNu7EcjazRrLOgWtpPfeOG9jQ+X+A53vjDVif4+SRKM6i4YjgLDyMZlrbsKzt0Z0Y7F/
         feB42AojSLIQ74grubkslbXo8KBJGbd3z1WEkkGRK2D0aMROxYfhPbwX3FBP00bakAwr
         oNKhA4xmpFV4xnoXifOXhKLHZE741s6Zx2AhOzILn8fQhViMwXMMgt5WE5yf6sYynDWb
         W85sFBH6cj2p2u6f1XrhWUF6hD5+aNVDiOEH0lkkWIG/Y+tlkLj7W4iT1QyRfAL9IYte
         tb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730804274; x=1731409074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7XM9/dVatJ/H1vTPPYlueifW2nkKAEOY6leLXkNvBU=;
        b=j3vJXcSVpMz1DkupVSM6EGl90tHhw3IKlIiaSl2LPpPiKqx3MGL7PWavTAsAZX3Y2h
         Ccb7Un/c+pzP5/ued7VtyXWr6I06omb54U7TubvglUgpbM8htixO+8kjKp0PevCaea33
         k6duNykYF8xLzhZSloGqaGM6JP7EiBRZ1v0mPbkeii9kZyEazp9NA/7I6ohQ4Q+f1lUg
         iuPRZrQsqFoHuUA0X4tpT4zhP9NsFBmuAWjXcUfiZA1VdpLxg2aCrBgVCV29Ch3dxK1/
         T2TcskICjeZbbOsy/VFdAgxtZHpFW8sFhyKKnARbIO8Tw5XQ0r7iH9qcL2IrJ0ViR2GA
         ldkA==
X-Forwarded-Encrypted: i=1; AJvYcCWL0P8223Bd8qy2qvzdCXD7iDfv3hNCblqqlynRchGvaAhTVXB37gfZ/QerLNA3b4TIb99fpWZUinLGbrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrTOtrmt7tuGrOCT2Hotg/N/9gUr9lZBR5U2wqKTMBzkE0VBj
	5g05wcaPg7vCvF5VcCUi99LuDiz7yfScsmcfAjTBTR1t7G+k+P1oX1F0M0MSylwpUABfn73/4u/
	tvs3aN52XVIaDUHJtaADT72n5Qnc=
X-Google-Smtp-Source: AGHT+IEEqhV2ShZtO63Bqg7YDE/NcvOL2RLWyDoJEGuu374QlVHH7YDRCwWJsuRQ4mqAdBvZcUYvoSEw30nNm6286K8=
X-Received: by 2002:a05:6102:2aca:b0:4a7:4829:8c93 with SMTP id
 ada2fe7eead31-4a8cfb4b9d9mr33019569137.12.1730804274145; Tue, 05 Nov 2024
 02:57:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102101240.35072-1-21cnbao@gmail.com> <6c14ab2c-7917-489b-b51e-401d208067f3@gmail.com>
 <CAGsJ_4wpdf6Fky7jj8O6OuLc0WTBjKXTfEqxE0cXiUjxxuLgZA@mail.gmail.com>
 <3f943f72-59d6-4124-96b2-e0bb8d7a5ebd@redhat.com> <20241104194024.0284288a28a71a70a3eab9b0@linux-foundation.org>
 <942f8355-4b23-4fd9-b00e-1121552d89ee@redhat.com> <CAGsJ_4yzq35ng77LjOi0jj0A6-9o+s5jKgP=S2Cx9fSsJtyzeA@mail.gmail.com>
 <11bd51b2-fa2d-4d99-912a-563521aaa6da@gmail.com>
In-Reply-To: <11bd51b2-fa2d-4d99-912a-563521aaa6da@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Nov 2024 23:57:42 +1300
Message-ID: <CAGsJ_4xBx2WJHxEJSaJ0t=sAtXOGS7i1ZMa-xMuxerAUaXq0Eg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
To: Usama Arif <usamaarif642@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:44=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 05/11/2024 09:15, Barry Song wrote:
> > On Tue, Nov 5, 2024 at 9:23=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 05.11.24 04:40, Andrew Morton wrote:
> >>> On Mon, 4 Nov 2024 13:32:55 +0100 David Hildenbrand <david@redhat.com=
> wrote:
> >>>
> >>>>> As mentioned above, this isn't about fixing a bug; it's simply to e=
nsure
> >>>>> that swap-related metrics don't disappear.
> >>>>
> >>>> Documentation/process/submitting-patches.rst:
> >>>>
> >>>> "A Fixes: tag indicates that the patch fixes an issue in a previous
> >>>> commit. It is used to make it easy to determine where a bug originat=
ed,
> >>>> which can help review a bug fix."
> >>>>
> >>>> If there is no BUG, I'm afraid you are abusing that tag.
> >>>
> >>> I think the abuse is reasonable.  We have no Should-be-included-with:=
.
> >>
> >> A "Belongs-to:" might make sense, for this kind of stuff that is still
> >> only in an RFC. Or we update the doc to explicitly spell out this
> >> special case of using "Fixes" to sort out something into the RC.
> >>
> >> Because if this would be already in a released kernel, it would get a
> >> bit trickier: stable rules explicitly spell out "fix a real bug".
> >>
> >>>
> >>> 0ca0c24e3211 is only in 6.12-rcX so this is the time to make
> >>> userspace-visible tweaks, so the 6.12 interfaces are the same as the
> >>> 6.13+ interfaces (which is what I think is happening here?)
> >>  > > And including the Fixes in this patch might be useful to someone =
who is
> >>> backporting 0ca0c24e3211 into some earlier kernel for their own
> >>> purposes.
> >>
> >> Just to be clear: adding new counters would hardly be fixing existing
> >> tools that perform calculations based on existing counters. So we are
> >> already changing the "userspace-visible" portion in some way, and I ha=
ve
> >> no idea what in vmstat we consider "stable".
> >>
> >> But I still don't think it's all that big of a deal except in some
> >> handcrafted scenarios hardly anybody cares about; the cover letter is
> >> also pretty clear on that.
> >
> > I may have been mistaken in the cover letter. According to the zswap da=
ta Usama
> > provided for servers, zero-filled pages accounted for about 1%.
>
> 10% not 1% (https://lore.kernel.org/all/20240612124750.2220726-1-usamaari=
f642@gmail.com/).
>

Sorry. My memory must have faded; my mind is confused by the 1% non-zero
same-page data and the 10% same-page data. Getting old :-)

> > So
> > really doesn't
> > matter too much, but I just checked with Hailong from our team=E2=80=94=
he has data
> > on same-page-filled usage in Android apps, which on average show 3-4%
> > same-page-filled, with over 85% being zero-filled. Some apps even reach
> > 6-7% zero-filled pages. We previously used these counters to profile
> > optimizations, but with zeromap now serving as the frontend for swap fi=
les,
> > those counters will disappear entirely from both zRAM and pswpin/pswpou=
t
> > metrics, as folios are filtered earlier.
> >
> This is what I meant in https://lore.kernel.org/all/79deed1a-9b0e-42e0-be=
2f-f0c3ef5fee11@gmail.com/
> when I said it affects zram as well!
>
> I am happy with the current version of the patch, just need the change
> in Documentation/admin-guide/cgroup-v2.rst.

I will update the document and send version 3 tomorrow, incorporating both
your comments on "zero-filled" and David's suggestion regarding "move out o=
f
memory".

>
> Thanks,
> Usama
>
> > Hailong essentially has a table that looks like the below which could b=
e
> > collected from the existing counters:
> >
> > com.xxx.app     5% same-page-filled.    88% zero
> > com.yyy.app     6% same-page-filled.     85% zero
> > com.zzz.map   6.7 same-page-filled.       88% zero
> > ....
> >
> > Anyone on 6.12 will be unable to track zero-filled pages unless they
> > backport this patch from a newer kernel version if it doesn=E2=80=99t m=
ake it
> > into 6.12.
> >
> > Whether it's marked as 'Belongs-to:' or 'Fixes:', I'd prefer we aim to
> > land it in
> > 6.12 :-)
> >
> >>
> >> So I'll shut up now and let people figure out the naming first, and if=
 a
> >> new counter is required at all :)
> >>
> >> --
> >> Cheers,
> >>
> >> David / dhildenb
> >>
> >

Thanks
Barry

