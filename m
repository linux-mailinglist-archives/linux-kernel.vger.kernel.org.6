Return-Path: <linux-kernel+bounces-242354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171DF928709
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F4BB21BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D866B145FF5;
	Fri,  5 Jul 2024 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdJMbm+n"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095414430B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176497; cv=none; b=JMSfM7jueLjfPX+l/t1ZWCItOKDJ7nUfTzIVLxpgPNGaRLYd84ubYkRFY8nBk0R+5dBwBs4vSkoqQORrh25LnX3IW0oeGT6x6rDxGgltHEc/Hj46xMkJDa3VeYETLjIosAwjffNwkYykzHFhInD8zUaVGawJ3dgktrZ6otyq3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176497; c=relaxed/simple;
	bh=aTdSfDOcEDj/09gyQFhS0f2JdqTr7AhvE2N/D2WJR+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuUd9JJx9b621sUb06i/1sPQix3B0WnH7rDl6J/290QC64/2ajbORpyb0+8zw/pkAEMc0kHTpHz5vcHjQsHpp4YcJdpdySoFb9gNUD5hICIJR7gQDQxG7H1the52NTbC8dy7sQhEvetJJkLoSOsmPxu7KfrYlJ1MKdtfjURPBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdJMbm+n; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58bac81f419so2152078a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176494; x=1720781294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGZf3oMRjehNO2BE/DWNFgwDKRxGAZLkBTWw8ufFXHM=;
        b=kdJMbm+nfp5yz1PMEtzmVg8DXIYIWw2kS/LrmCvtibO3q4WvAj+L8ASG/qzQLRg85n
         RkkPuuHrs3tp6Mr7j7wjnGRFpUiVXhtM+7Nv05XFacH4YHW3wbAUVKUTYBkjQ4+UfSS4
         N+NktsyHtaBwjYcjl5MZf8Xujl5dmwKTgiEGa4n50M3K+J4HoPdesqrjTRdoV2uiKXHk
         CQsOEdF767k46aVYHgTuPys1IzqmhACd6kv+haXuo9XcjIAbyz5zI8ArbBvPWz3c4EUC
         aKVcr4WAc4lgkQYE5JfmHD1sYYFu6W4k7u2I968IYm3IFQq0UPNyC1shSermn8IyCzbF
         SFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176494; x=1720781294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGZf3oMRjehNO2BE/DWNFgwDKRxGAZLkBTWw8ufFXHM=;
        b=CEDvQ9VLRRCH+YeqATBs3alC8uo2JlOa5Phs9yZEyuxMw8OsdgLMxDWLwcDNM89h/J
         hKEceVLsBeyVZspT6SLctVH/ctdFJrgCuQAnMcWXdOgGfEYyxg/RcOtINkBc4gMb9xhS
         SqvXzHtyb9q7OtmsDTAx9dWvtpKDuSk7B1spRCaJ7B7KnhOO/7QhTIiWw4u05GBlBgs2
         YWnTstq6sG8p5kOv4faihAUEccX5MMwCJCGPbH1azbMXVhpXzohvwiw/QjgCME2w/jn9
         x+fh0LH5noz7sIBhH6yohDxcf3rVwE96gpb/dJI7yptZXvGpUlZgtc7aA5OKU+dZeSoO
         K6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWzYn6c1wS9vvFbSm0wOM4+H3UGACBIicnU2KlrgF1ot0kgarbq5EmHtXo90euBoNLCjloBxpQAuTPe824wJFPFa8Yw70Zz4RrdQHA
X-Gm-Message-State: AOJu0Yxo4l2YcCgGCCSsD035kMHz1IbclqkftuQyv/BmhZatV+FsH6Qh
	c6h9S77kXHmwIQJYVKN2Vf+NPLoO55UVCBrxqFkpt8aH6GTI4p4wQFcomF5pLJ7H5sNiMI4P6Xj
	SKmDy2X5qlMxl12ObAj0oNZ/HIeY=
X-Google-Smtp-Source: AGHT+IFUt05pEViwXK0y5svdhOT5z8s/1i61eTFLRCLW5ypmyknB/oB+aCe+XWTcWfYhWkjCVg7imBjlascAdNbz0pA=
X-Received: by 2002:a05:6402:524e:b0:586:12f6:c0fe with SMTP id
 4fb4d7f45d1cf-58e5916fafbmr2908734a12.5.1720176493840; Fri, 05 Jul 2024
 03:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704012905.42971-1-ioworker0@gmail.com> <20240704012905.42971-2-ioworker0@gmail.com>
 <677fc803-0bb9-48dc-a1ff-3ca1fb0dea15@redhat.com> <CAGsJ_4xX1cqKHU0eEsT=k0YDYKPs2m82bCkggdJyA1iwG4vXrg@mail.gmail.com>
 <3aef2bc6-c889-4a9a-b35d-f10ca8a5796a@redhat.com>
In-Reply-To: <3aef2bc6-c889-4a9a-b35d-f10ca8a5796a@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 5 Jul 2024 18:48:02 +0800
Message-ID: <CAK1f24=M0i_Wisf9NHGcyo4wJ90a5QYefm=+rck5XAXMg1QNJQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: add per-order mTHP split counters
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, dj456119@gmail.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	libang.li@antgroup.com, baolin.wang@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David and Barry,

Thanks a lot for paying attention!

On Fri, Jul 5, 2024 at 6:14=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.07.24 12:12, Barry Song wrote:
> > On Fri, Jul 5, 2024 at 9:08=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >>> @@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct pag=
e *page, struct list_head *list,
> >>>                i_mmap_unlock_read(mapping);
> >>>    out:
> >>>        xas_destroy(&xas);
> >>> -     if (is_thp)
> >>> +     if (order >=3D HPAGE_PMD_ORDER)
> >>
> >> We likely should be using "=3D=3D HPAGE_PMD_ORDER" here, to be safe fo=
r the
> >> future.
> >
> > I feel this might need to be separate since all other places are using
> > folio_test_pmd_mappable() ?
>
> Likely, but as you are moving away from this ... this counter here does
> and will always only care about HPAGE_PMD_ORDER.

I appreciate the different opinions on whether we should use
">=3D HPAGE_PMD_ORDER" or "=3D=3D" for this check.

In this context, let's leave it as is and stay consistent with
folio_test_pmd_mappable() by using ">=3D HPAGE_PMD_ORDER",
what do you think?

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

