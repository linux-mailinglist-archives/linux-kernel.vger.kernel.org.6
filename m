Return-Path: <linux-kernel+bounces-527587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A6BA40CEC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C453B4EE7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 06:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F35B12E7F;
	Sun, 23 Feb 2025 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCWWQgwd"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B913AA38
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740291525; cv=none; b=Nh8a/RoPxyyS3m3Bv8YXB2hyUqXCH4GDt0fQYT9Hys1WBrufk1Vw6k1+IL1ZnKmBkt1tNin/TV+HC5UcOHsXMSk+hYazWM65m1Urx87y6VU+Y6oVJXUON4O6W5+jp88MjY0/gVgAtMmuUTX/QpZbsEiKOLXWUroNBfjxqvMs/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740291525; c=relaxed/simple;
	bh=rm2WlrkuzwDGTG4ZKlQKaiuohgokRfzbvNNXUisHjo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jc81BjuFdXN4O80gFVDHvkSrRfn7QiSvWr8SxoeU4VgKgmJeAezHUfK85dkJ3oHdz76e897PphwVuK+nFHriA1F+mbedtm9hlkgEjljpYWFUtdaow2kFxusNim1g/SOhBNdr/pg9tv0Y0DlwjgAUWevSqMdzsOZwR6oDTkefkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCWWQgwd; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4be625c5365so1092247137.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 22:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740291523; x=1740896323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rm2WlrkuzwDGTG4ZKlQKaiuohgokRfzbvNNXUisHjo8=;
        b=GCWWQgwdYlRtRcxZ1G+o3BOxj5LIBHz+PweZ+U2SeROvrBo9zbK3csM0Z2wGhnUb61
         1NUjH8CFR6i3OSYLd75PAqRfih2J34aaOREtaLgeh5xHFYC3yVvZR/hTQIV5ekkKpwzN
         el6kT71sHG7qsQRrHwke+oFKL2iUApsq/5CnBQoqBBI5Mo+dbWigGErqMYvI6wQucFOG
         942e0LWvBwi5gSgKMtw3VpcRAKoa/vmsEn8e0n8op6pXBIwFAYgUi6oOfdTcUVM0uYDt
         XeJuiX3wwnoe0/+CdIgUVwVXRY6CzEBl3a5CV4Qaiwf/mVaGEZUc52SlzaRlEnLxgVTy
         vZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740291523; x=1740896323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rm2WlrkuzwDGTG4ZKlQKaiuohgokRfzbvNNXUisHjo8=;
        b=X4zE922FzC7TUxpcOReyrsHaZP7GvLncpzXsJ1+2ZgLIF13CFw6VlOB3y2wEaz6zZz
         b5SeyY1xgxwr4uGJz2VPk/Kt3fTFIGjVD0WzjmJOXK9Re3RYDVVQhYqRDMN471GvEN1e
         XWuqqVeLOQ4NciDMHyNfbny2noH6lKbl27uUfkPfXvHCYStrSJTD2FU7aAeWyGkIJkai
         Dv1730JGPvQNbKqBdYed9vm95pN2JqZcdLSWjvBNvyIxV56k9uySbRCNdcLUBeok0MKZ
         deRxOeT0rhJ0Yp14sAEGb8AQPP1cS0Ic3utfTvLwBlLkc6JYqQLFeR09Ab85wK8dx2SS
         Ossg==
X-Forwarded-Encrypted: i=1; AJvYcCXNtrgCELE+I6bs055vsKHAZSZ655K6501UN30YqbZoPCYSDqncstDnhV44CB6W8x0yqMFh5qQetqL2w2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSeA7zSajp2rMXvicG0M4t3RoVYif9onqFtD1OJmQtRGA9Lxy
	jigPgpPeXnoI2d4s7eDzqaj5ASfzoTib16bHj21l+qTYzO098ZY6Qq0njm5VuMk+9IohIBBC46x
	y+tjo23mdRe3HVEAWc9lBXcQVKBA=
X-Gm-Gg: ASbGncsEXmxT5uYsYGMHtdkQR8ZJ8nQVUg7eVYZXkLOc5KnPysM881za7J4gIj5d7i5
	jppQuvHPZaSu9eBaNGZkltkkiRJx6IZQrvIR4ZN1U9v7CJZOxSm6XLRkhy+6djXrDk9l5FH49pc
	ulGoEqgZA=
X-Google-Smtp-Source: AGHT+IHISp4xuomFdO4BHEBcxwWp1dQRt7WHd6d6ZvbiiUJHwMtqswJcVoZmnoXJsRyNiMGEwxw68l8mxgPrL2iG5Tw=
X-Received: by 2002:a05:6102:510c:b0:4bd:39a6:e98d with SMTP id
 ada2fe7eead31-4bfbfd6d8bamr5472274137.0.1740291522770; Sat, 22 Feb 2025
 22:18:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
 <Z7lIYzLSACbWxlEM@casper.infradead.org> <2c7dfa44-266a-4aa6-9401-7528368f171e@huawei.com>
 <Z7qK-NFJsqcV0rPw@casper.infradead.org>
In-Reply-To: <Z7qK-NFJsqcV0rPw@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 23 Feb 2025 19:18:31 +1300
X-Gm-Features: AWEUYZkH5_ZXOoxm3qlTrD04qCBQEWQtOpYDAg0BstFje4D6Jrr_n_ZGpJj_8V8
Message-ID: <CAGsJ_4xHaaf_DHsFZ_zEqEd3Nb9C=7JJjy5gGFo+RhEhQYX_tg@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
To: Matthew Wilcox <willy@infradead.org>
Cc: mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org, david@redhat.com, 
	kasong@tencent.com, ryan.roberts@arm.com, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, schatzberg.dan@gmail.com, hanchuanhua@oppo.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 3:42=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Feb 22, 2025 at 11:59:53AM +0800, mawupeng wrote:
> >
> >
> > On 2025/2/22 11:45, Matthew Wilcox wrote:
> > > On Sat, Feb 22, 2025 at 10:46:17AM +0800, Wupeng Ma wrote:
> > >> Digging into the source, we found that the swap entry is invalid due=
 to
> > >> unknown reason, and this lead to invalid swap_info_struct. Excessive=
 log
> > >> printing can fill up the prioritized log space, leading to the purgi=
ng of
> > >> originally valid logs and hindering problem troubleshooting. To make=
 this
> > >> more robust, kill this task.
> > >
> > > this seems like a very bad way to fix this problem
> >
> > Sure, It's a bad way to fix this. Just a proper way to make it more rob=
ust?
> > Since it will produce lots of invalid and same log?
>
> We have a mechanism to prevent flooding the log: <linux/ratelimit.h>.
> If you grep for 'ratelimit' in include, you'll see a number of
> convenience functions exist; not sure whether you'll need to use the raw
> ratelilmit stuff, or if you can just use one of the prepared ones.
>

IMHO, I really don=E2=80=99t think log flooding is the issue here; rather, =
we=E2=80=99re dealing
with an endless page fault. For servers, that might mean server is unrespon=
sive
, for phones, they could be quickly running out of battery.

It=E2=80=99s certainly better to identify the root cause, but it could be d=
ue
to a bit-flip in
DDR or memory corruption in the page table. Until we can properly fix it, t=
he
patch seems somewhat reasonable=E2=80=94the wrong application gets killed, =
it at
least has a chance to be restarted by systemd, Android init, etc. A PTE poi=
nting
to a non-existent swap file and never being enabled clearly indicates somet=
hing
has gone seriously wrong - either a hardware issue or a kernel bug.
At the very least, it warrants a WARN_ON_ONCE(), even after we identify and=
 fix
the root cause, as it still enhances the system's robustness.

Gaoxu will certainly encounter the same problem if do_swap_page() executes
earlier than swap_duplicate() where the PTE points to a non-existent swap
file [1]. That means the phone will heat up quickly.

[1] https://lore.kernel.org/linux-mm/e223b0e6ba2f4924984b1917cc717bd5@honor=
.com/

Thanks
Barry

