Return-Path: <linux-kernel+bounces-553858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D5BA58FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDC816B518
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF662253EA;
	Mon, 10 Mar 2025 09:40:06 +0000 (UTC)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CF2253E1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599606; cv=none; b=PLwEZScaNKrlRZ/RFD30vwSUMGroRn4PcsZ4zsBLzsQDxY3A5yOxUnI9FUQoVOBSpqXBwn6wZqaLJHSQgLh8Oxs4DcV1hHtqCW2pKTEmLtjuRBoo6u+rj5NIq+Fm4whszkFNvGT99BdmTcqVF9pNEPK/LK5YcQtw0qjfRGFIpaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599606; c=relaxed/simple;
	bh=lrKKy6iJTd7PtMPMxt+oRp4h6Gm522VIIykkjiREHJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNplmrxBFRHzPvUqe0E5ZoiIBY90TVseQynpVwR20qdi2B7ItUo6D3k+IktSeYuAFACdHdtVLLlsO8eWDBkKDV/AMy+qShx/gfdMt7xI8ANev/n53W+m256YuKBUHzRbbMeoONvaUq6I9TlG8MjawFAXrh3H8rBlUPM/ltJZ3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86b68e51af4so1474615241.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599602; x=1742204402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRVZXJ7ITN09cgJCDITkGHp6SwXTBoKbvNkGuQsiUF0=;
        b=bfZTzu24hh1NwCPFyX9ePvnwE8UuS4ZJV1neo+Ufryf8jdVAwOEdskPpWeZhFq3nIm
         pNds/tdscTEjN0KNqub8hNd6Qt5O6f3czNhkSeRiZR4D9zk8slC+oDAgKgFrYKyvootm
         yu0h1fe6mLwMwjEY6hO5B/TZKG0fDFyOCsHteEIZh1qAFZ8W40z+oqAHEgPmaf8exd3W
         W0snPtWAClb/QaMwkQg+/9i9/23/Dts6ycu6d/Sjfoqd+g+CyCJt75OGPky74f2S0Bfv
         9MIwf2Oghr5LDeq/sJZgSaZhI7allVxaKB1mTInfWq1JMsQZ7Xg8LTk4noIAHli8tI5Z
         Gl1g==
X-Gm-Message-State: AOJu0YwKoK0GE3dlx20K+fBVDgo20YC/BK3+Dcdo41MOH6Odx2d9wAYJ
	bXtaF25fZeKaj8KBz4t/7NiJLNGPiNrUeQ6nVqAMxm4SwouEM/D8/OutiaWY
X-Gm-Gg: ASbGncsq32u4xrP1VpGwfRMD/wGxIdxrpEUrTyEr07DtYqAabTzq1p14H5iM+d85Ifq
	ZXCjnJk8i4I8Kn2yxvytwiHwVUMRByiqJfOf+16MdAhCXKmMz5J4lOZmkJ0ix/3lnnp5YOPRrVN
	6aYOBv+OfrO7mUdYAwMaYD6yKLK3XPvpvhUZ0NIE2+/CFKM3bEB7KpEbkpmSZ4yCwoLGDcxzah5
	GCI5bg57dcDK+rDWyYnNFFtI6pmV1DAU8OYZ6iyyX6/bXnWZlYUZP8qdusggrLvLbd3cm4tfnCd
	5Ry9cL55SwgxovZFCFbgdYFlk+Kj87ktIpaAreaQgvktNWUO834eiYoHlbTGYM1Cz5LnuNPp5WY
	tH9xePEA=
X-Google-Smtp-Source: AGHT+IGrlDX6vjkEG3MXAroVgTKsKpGiWAU5V3K9plrZOYV7jpk83mkPxfXmKfzMPAb7rRpKOqG4kA==
X-Received: by 2002:a05:6102:809c:b0:4bb:cf25:c5a7 with SMTP id ada2fe7eead31-4c30a53c3d2mr7924295137.7.1741599602229;
        Mon, 10 Mar 2025 02:40:02 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb424282sm1819694137.2.2025.03.10.02.40.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:40:01 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86718c2c3b9so1522583241.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:40:00 -0700 (PDT)
X-Received: by 2002:a05:6102:809c:b0:4bb:c490:7d6c with SMTP id
 ada2fe7eead31-4c30a5482b3mr8132640137.9.1741599600659; Mon, 10 Mar 2025
 02:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWBGb5AXv8Ch3XhPPHc0CVYHf31tx1Feh87OU5MDUCdPQ@mail.gmail.com>
 <Z8slexKyo7VFkSKW@smile.fi.intel.com> <CAMuHMdVmg=kuPWCN6rRTxP1LSZFtK=gagd0x092kxzif8Tav2Q@mail.gmail.com>
 <Z8tBnq-j7gKrzlpk@smile.fi.intel.com> <CAMuHMdWeFhqf-A-71pCZ+eFMh+ibGudMwiE5hPrdkfCYwVXHCA@mail.gmail.com>
 <Z86e3t8YVoaGsRlF@smile.fi.intel.com>
In-Reply-To: <Z86e3t8YVoaGsRlF@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Mar 2025 10:39:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVA5pAWKXjYDZrLczgzmhvHVOAdpK3kBQC8UGY_TzEW3A@mail.gmail.com>
X-Gm-Features: AQ5f1JoGTsQfRYjGWxpkoE4Cmdf4cXMGfahLTxTGPXkbs9y3LGwmcxJf1c9DU94
Message-ID: <CAMuHMdVA5pAWKXjYDZrLczgzmhvHVOAdpK3kBQC8UGY_TzEW3A@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] auxdisplay: charlcd: Partially revert "Move hwidth
 and bwidth to struct hd44780_common"
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>, 
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Mon, 10 Mar 2025 at 09:12, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Mar 07, 2025 at 08:05:56PM +0100, Geert Uytterhoeven wrote:
> > On Fri, 7 Mar 2025 at 19:57, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Mar 07, 2025 at 07:14:02PM +0100, Geert Uytterhoeven wrote:
> > > > On Fri, 7 Mar 2025 at 17:57, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Mar 07, 2025 at 10:03:31AM +0100, Geert Uytterhoeven wrote:
> > > > > > On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > The commit 2545c1c948a6 ("auxdisplay: Move hwidth and bwidth to struct
> > > > > >
> > > > > > s/The commit/Commit/
> > > > >
> > > > > Why? We know that we are talking about the very specific commit.
> > > >
> > > > You can have a noun with or without an article:
> > >
> > > This is not so simple :-), esp. if a noun is a weekday or a toponym.
> > >
> > > >   - "a commit": an unspecified commit,
> > > >   - "the commit": a specific commit, specified by context.
> > > >   - "commit 1234abcd": a specific commit, specified by what follows.
> > > >
> > > > > My English is not native I would appreciate a link to a material to study
> > > > > the case you pointed out.
> > > >
> > > > Neither is mine, but the use of articles is similar in English and Dutch.
> > > > (I am aware your mother tongue does not have articles ;-)
> > > >
> > > > I found plenty of articles explaining cases 1 and 2.
> > > > Case 3 can be considered equivalent to "Mount Everest" in
> > > > https://learnenglish.britishcouncil.org/grammar/a1-a2-grammar/articles-the-or-no-article
> > >
> > > Okay, so you actually think that the hash and the title can be considered as
> > > "name of a place". Hmm... I don't think it applies here. It's not a place.
> > > Moreover some places require "the" article.
> >
> > Only if they are a region, not if they are a country (yes, that's
> > unrelated here).
> >
> > > Here https://www.butte.edu/departments/cas/tipsheets/grammar/articles.html,
> > > for example, the sentence "The 2003 federal budget" sounds to me closer to
> > > our case. Every year there is a federal budget, but we explicitly point out
> > > to one and reader knows what is this. The same with the commit.
> > >
> > > Sorry, but I am still not convinced.
> >
> > In "The 2003 federal budget", both "2003" and "federal" are adjectives.
> > In "commit 1234abcd", "1234abcd" is a name.
> >
> > Cfr. "King Charles".  "The King Charles" would be used only when
> > putting a very special emphasis on "king".
>
> I have talked to the language teacher (okay, her native is not English),
> and she told me that no article is for the cases of location, person, or
> character. None of that category the commit falls into.
>
> So, still not convinced.

I have a hard time finding the official rule (git commits did not
exist when English grammar was written ;-)... Examples are easier to
find.  E.g. the first sentence on [1] does not start with an article:

   European route E40 is the longest European route.

[1] https://en.wikipedia.org/wiki/European_route_E40

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

