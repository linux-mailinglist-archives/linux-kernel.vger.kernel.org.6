Return-Path: <linux-kernel+bounces-199382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBE08D8653
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2709A1C212DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5053D1304BA;
	Mon,  3 Jun 2024 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bttmlFF6"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02344320D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429610; cv=none; b=ViYtFftZDBKPA5YS27RZd6tWKZEv/9JBhnw5gvkh16X54+kOPTqlzbGDVwYx7Mmd60TVjBiG19hHGUOuSf5X3b0icvAdlRIQ5xONv4IuI7nkrijSM9AHJajdHDRt6dRf2NYRTbn29EwV2duHHWv9A0pqVElCirr9snMhH6UPTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429610; c=relaxed/simple;
	bh=czOunkFwxpzhRZywTXKrhdWC3r8jsQu3KnoGO6j0mPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAHFnIcmL72oRa7vyuP0Rghhk3bRSLlZZmnBIC91TPVm9nK0xcSD4Wwu5/H6lQF342ptV8XOln+OzA5fy5jqo9KX6wPJ1ywlCOVHVHPPPxvz2KxNgO7fEYKreK9InK1hF0WBWPhOym6MEkFNgaZWZHdnpGXuMmPFrVyOK/c3iYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bttmlFF6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a3d21299aso3424449a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717429607; x=1718034407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnfJd+lacSEBp37hacsO6bP3SrPCDbi68n4xf8Hh4fw=;
        b=bttmlFF6zZYfsVTlLn9g9Wezn5XlYZ/P4c0HAykXBVx/T6OG48IQAxW+AgBJIJolzh
         QbXCyyFbs7/K2RC5GlmuGY1R4LqK5vNRGAIofuDwQ5nJ739JmVGMkQoxO1iwyFMOFqR0
         4aYN9peYPhcTGI2rE2/E2YcO3OObPRN45qSC+rfxV807Uz7RWyvgDMbSp6zNAarVnVl3
         H1HkUt5gFfe+Y6sJwjt2nW4kMST+bHUnDsVQ8/HQXGTnmVzYhjNnv/tWp5hJmBWgHtYd
         0SNMrVE1JzXpAP6MOO36MN7SH17FpEo3Wf6gcGhzZtLKF3z1JtzpMlnaXBjrS86tE/nJ
         NBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717429607; x=1718034407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnfJd+lacSEBp37hacsO6bP3SrPCDbi68n4xf8Hh4fw=;
        b=dK/cBJ40Ew5HwGhECvHeMR3jSrCwPm4UKBb5yf7AvOhAItnsVMO7Ox9upzwO1/sucS
         92POyCoUD9WIhC40fhza0XxiM3dDY2+h2Hd8k879WcAjGh0TkTBI82qwDKBM0QtZ2UMQ
         QqLhvN6NyABvlC1WK4sTcQPOTx6CQfB5eTgp3bFtAomzTvUypdVyzEMdPMdMT6p9ktci
         QaL/9tvD9lwJZYqUZs/tQo8xd4e+dQ4IjLkSPj9Y0eR8sir781FvFVUzgDGvC740TT0k
         C7XR5pgNjTW+CchAm+j1uapkURIc6M+pRzGFdZQXVuwOjn6Tul/eb2PGdyiE4OcVpZmd
         7ppw==
X-Forwarded-Encrypted: i=1; AJvYcCUXCu9DmsjpnX9QHNxGJ6NJvoJHxTfV3SsYzJpVr9H3AFY9hIxseVe0775XPPL4tJqBaApdXwRtuW+Mr4DT95apraZ/vVvVG9ipuBVf
X-Gm-Message-State: AOJu0YwzjzFHXreasnlgLMVnNNrVm+twB3FofQcFGUT08aW7qvntoS6k
	WKrghBpdwtoxQtm0GOuMDVqFhJUpan0WhiYi7nZlf07eXbqO78Tk/XgPtR0rdsTWX3Hls5wzTCU
	FWxzEe4AOrulj5ahFi34bHmyByck=
X-Google-Smtp-Source: AGHT+IH5lMgmQGkOya9kL/O3tdhpGKBIaAMuCKPUcjlzlO7HWIBEj6o9klkQSNbuUx2CcQ6Q73Lfn1wbQhv7v/mo6n0=
X-Received: by 2002:a50:d6d4:0:b0:57a:23d9:9ef6 with SMTP id
 4fb4d7f45d1cf-57a5b7ac3c7mr2973799a12.25.1717429607199; Mon, 03 Jun 2024
 08:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603140745.83880-1-ioworker0@gmail.com> <Zl3Wjh9_aGY8Xxm7@casper.infradead.org>
 <c0309ab6-8bae-42b7-8d27-1df895689fb8@redhat.com> <Zl3axbhcljTg_X0C@casper.infradead.org>
 <db8d4d78-a519-4642-a882-2a84f7a1366b@redhat.com>
In-Reply-To: <db8d4d78-a519-4642-a882-2a84f7a1366b@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 3 Jun 2024 23:46:35 +0800
Message-ID: <CAK1f24=Xa-n2J4_sYL161PMB3hhJ8tcQtJ0qdV7ChPtjMTrPQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/mlock: implement folio_mlock_step() using folio_pte_batch()
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, ryan.roberts@arm.com, 
	21cnbao@gmail.com, baolin.wang@linux.alibaba.com, ziy@nvidia.com, 
	fengwei.yin@intel.com, ying.huang@intel.com, libang.li@antgroup.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 11:26=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 03.06.24 17:01, Matthew Wilcox wrote:
> > On Mon, Jun 03, 2024 at 04:56:05PM +0200, David Hildenbrand wrote:
> >> On 03.06.24 16:43, Matthew Wilcox wrote:
> >>> On Mon, Jun 03, 2024 at 10:07:45PM +0800, Lance Yang wrote:
> >>>> +++ b/mm/mlock.c
> >>>> @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
> >>>>    static inline unsigned int folio_mlock_step(struct folio *folio,
> >>>>                    pte_t *pte, unsigned long addr, unsigned long end=
)
> >>>>    {
> >>>> -  unsigned int count, i, nr =3D folio_nr_pages(folio);
> >>>> -  unsigned long pfn =3D folio_pfn(folio);
> >>>> +  const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRT=
Y;
> >>>> +  unsigned int count =3D (end - addr) >> PAGE_SHIFT;
> >>>
> >>> This is a pre-existing bug, but ... what happens if you're on a 64-bi=
t
> >>> system and you mlock() a range that is exactly 2^44 bytes?  Seems to =
me
> >>> that count becomes 0.  Why not use an unsigned long here and avoid th=
e
> >>> problem entirely?
> >>>
> >>> folio_pte_batch() also needs to take an unsigned long max_nr in that
> >>> case, because you aren't restricting it to folio_nr_pages().
> >>
> >> Yeah, likely we should also take a look at other folio_pte_batch() use=
rs
> >> like copy_present_ptes() that pass the count as an int. Nothing should
> >> really be broken, but we might not batch as much as we could, which is
> >> unfortunate.
> >
> > You did include:
> >
> >          VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio=
);
> >
> > so at the least we have a userspace-triggerable warning.
>
> Yes, and max_nr =3D=3D 0 would likely not be healthy to the system.
>
> But
>
> For copy_pte_range(), zap_pte_range() and the madvise users, we should
> always have:
>         next =3D pmd_addr_end(addr, end);
>
> and use "next" as the actual "end" -- not the VMA end. So "end - addr" =
=3D
> "next - addr" should never exceed a single PMD size.
>
>
> mlock_pte_range() is also called from walk_page_range(), which uses
>         next =3D pmd_addr_end(addr, end);
>
> So likely exceeding PMD size is not possible here and all is working as
> expected.

Thanks for clarifying!

I agree that currently all is fine, so perhaps we don't worry about that :)

>
> Will double check later.

I did a double-check and you're correct.

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

