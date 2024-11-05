Return-Path: <linux-kernel+bounces-396170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D2E9BC8E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8FE1C22857
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12081D0BAE;
	Tue,  5 Nov 2024 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy4hWgUC"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42341CF295
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798154; cv=none; b=K/ZfAH4y57Rwp16DukRyWBiL4CcOG0b9Gv+PRys2auBAk2M99fHZeUL3Ke8hDjHdyOXJjyNl4U9Z+saGGEzej1n/hO4eZh+mEUdxOe9IxTD3TQLKKI95+aAZHYmG7CtNldoPZqHzBCbFIa8eYzDFDKoBpwVEKr9NVD3zVsIJlR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798154; c=relaxed/simple;
	bh=Gxaalu3aIIQmDeCo5aMJDJV53MqHc3zUsGtecnHh3LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvQu4MTczfJQ4jPtfhcVndY8BWrYDY1D0M89lyEoBgqsikJKHWhNtwv6H6e4bvP8y2iAj33d0Udh1qBev+Mi1D8f2aVe7K57avojn2nFxb3fk1YmuLKJeztArzcRxNpqjwldOkQcjl7TOGi8tv0WAKIe97eBMu4DgvLNQyzMBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wy4hWgUC; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fd616acf0so1920224241.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730798151; x=1731402951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKulzpeoz60rUZHGWKkvRHEIspxK1xcPTRYy4usyVBk=;
        b=Wy4hWgUCW9I0KJnub1+nkRAozbLhuK1X9BBlLF8IhP4oc2r//o9TP/8YxOIMcctxwx
         LYDRoBZjIb1dlhNTgUXyX9JCAuTdHPj7Xd2ummlPhuNx/3rG9T1iIpT5jEoa1+z4iLvB
         NREBwykBawLzlvX+OskkxXGh5roeWaOWKIkYHoIY7iaZt3mspKKlvDy4eoM4azgydMfZ
         O51dP2xrNg6NrJ6mgZ6YV4mgGIWnMfy/xnkHTbZ6xh5PZjlx7iRcNDuim4ryRyEEiGq/
         VFlfXM2VIgReQujdU7UDqgEL3x8eWsWCyrXtrd8yyFL+3efQVO/VWPZZxlNUdrEyH9r3
         oCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798151; x=1731402951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKulzpeoz60rUZHGWKkvRHEIspxK1xcPTRYy4usyVBk=;
        b=iQk6mHKuYGdfZ8xzawZGvCw9hlw1Gv0lK4c6rE0C5TkN6fYadSlj2Hx7ZjDH+4Xvoq
         O033INI5/PNJyPqzMJ+qxgNm3J/ohQG9Y6/zISduhWk77BcoLmaQYyjAO7sGML9w6vAZ
         Sl3djBDNojpdRG7um6YbQ1ReVpm+j+TFFbU8HntdueK0YSUe1pH+T+gzKq9Lk59W7ppR
         KFxk1kEzKCzCo5/IClqtjrlO0XgRK2JtQz5XkIZAU+H7k/Y3F6GRbaYf8VF2REn2ik6C
         oTpg3Dpl25GAyQe7bdIUZSZrrO2+yWefnWad3BTmzZ2+MURm5hDP6L4rNxdsICEgIGR+
         ICcw==
X-Forwarded-Encrypted: i=1; AJvYcCWnDfxm6abyNjZrAfYvJzdw+kKcEDg1V1FzdBuGVF/8DFRyyhwAbY8LVSjC3iTJ0xVswqYTtKUno8eSLw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4hXdRhkGAazKlyL1ggMBeDF0KmyU38Vawpj2An7ykH4jPUWX
	R9OWf2zdtOq+wb495fBN/+hk1iE+WGLK5KJg4/GK6Eau/tdaGGIa4QaZgyB0BpNpfe2PVdtaVkl
	pdifQgrfcmqurBA/l2sWM/EDq0szbw0yw
X-Google-Smtp-Source: AGHT+IEueJnbGiwtInCCyi3lkcDcZZNl6kPDvfAubTF4J5Wy0inNePEJV5BaqMzx40PuALKVAyefwzRWoFHpcOyLDTU=
X-Received: by 2002:a05:6102:3a10:b0:4a9:49:26d2 with SMTP id
 ada2fe7eead31-4a90109fb68mr21241050137.29.1730798151459; Tue, 05 Nov 2024
 01:15:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102101240.35072-1-21cnbao@gmail.com> <6c14ab2c-7917-489b-b51e-401d208067f3@gmail.com>
 <CAGsJ_4wpdf6Fky7jj8O6OuLc0WTBjKXTfEqxE0cXiUjxxuLgZA@mail.gmail.com>
 <3f943f72-59d6-4124-96b2-e0bb8d7a5ebd@redhat.com> <20241104194024.0284288a28a71a70a3eab9b0@linux-foundation.org>
 <942f8355-4b23-4fd9-b00e-1121552d89ee@redhat.com>
In-Reply-To: <942f8355-4b23-4fd9-b00e-1121552d89ee@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Nov 2024 22:15:40 +1300
Message-ID: <CAGsJ_4yzq35ng77LjOi0jj0A6-9o+s5jKgP=S2Cx9fSsJtyzeA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Usama Arif <usamaarif642@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 9:23=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.11.24 04:40, Andrew Morton wrote:
> > On Mon, 4 Nov 2024 13:32:55 +0100 David Hildenbrand <david@redhat.com> =
wrote:
> >
> >>> As mentioned above, this isn't about fixing a bug; it's simply to ens=
ure
> >>> that swap-related metrics don't disappear.
> >>
> >> Documentation/process/submitting-patches.rst:
> >>
> >> "A Fixes: tag indicates that the patch fixes an issue in a previous
> >> commit. It is used to make it easy to determine where a bug originated=
,
> >> which can help review a bug fix."
> >>
> >> If there is no BUG, I'm afraid you are abusing that tag.
> >
> > I think the abuse is reasonable.  We have no Should-be-included-with:.
>
> A "Belongs-to:" might make sense, for this kind of stuff that is still
> only in an RFC. Or we update the doc to explicitly spell out this
> special case of using "Fixes" to sort out something into the RC.
>
> Because if this would be already in a released kernel, it would get a
> bit trickier: stable rules explicitly spell out "fix a real bug".
>
> >
> > 0ca0c24e3211 is only in 6.12-rcX so this is the time to make
> > userspace-visible tweaks, so the 6.12 interfaces are the same as the
> > 6.13+ interfaces (which is what I think is happening here?)
>  > > And including the Fixes in this patch might be useful to someone who=
 is
> > backporting 0ca0c24e3211 into some earlier kernel for their own
> > purposes.
>
> Just to be clear: adding new counters would hardly be fixing existing
> tools that perform calculations based on existing counters. So we are
> already changing the "userspace-visible" portion in some way, and I have
> no idea what in vmstat we consider "stable".
>
> But I still don't think it's all that big of a deal except in some
> handcrafted scenarios hardly anybody cares about; the cover letter is
> also pretty clear on that.

I may have been mistaken in the cover letter. According to the zswap data U=
sama
provided for servers, zero-filled pages accounted for about 1%. So
really doesn't
matter too much, but I just checked with Hailong from our team=E2=80=94he h=
as data
on same-page-filled usage in Android apps, which on average show 3-4%
same-page-filled, with over 85% being zero-filled. Some apps even reach
6-7% zero-filled pages. We previously used these counters to profile
optimizations, but with zeromap now serving as the frontend for swap files,
those counters will disappear entirely from both zRAM and pswpin/pswpout
metrics, as folios are filtered earlier.

Hailong essentially has a table that looks like the below which could be
collected from the existing counters:

com.xxx.app     5% same-page-filled.    88% zero
com.yyy.app     6% same-page-filled.     85% zero
com.zzz.map   6.7 same-page-filled.       88% zero
....

Anyone on 6.12 will be unable to track zero-filled pages unless they
backport this patch from a newer kernel version if it doesn=E2=80=99t make =
it
into 6.12.

Whether it's marked as 'Belongs-to:' or 'Fixes:', I'd prefer we aim to
land it in
6.12 :-)

>
> So I'll shut up now and let people figure out the naming first, and if a
> new counter is required at all :)
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

