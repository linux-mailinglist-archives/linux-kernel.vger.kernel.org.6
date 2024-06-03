Return-Path: <linux-kernel+bounces-199340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6362B8D85C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB311C21B73
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EA712E1FF;
	Mon,  3 Jun 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr7uACHN"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E958AC4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427338; cv=none; b=mKZVe3sl7pK9TmB7nqMLKkJVZhd81o4YiWJDoAzBQ6w5wu8jVbIamRUu5Ux4rK5hvNcFfXklad1SpdPr1VqJ0z3a/h2EOUaTVn43kqVo6gHURxj/9G2VlmoKOKrzLYQG0AV6uq9Ek9pgHNpg72qmvcAcSzrVKVg6FEIaGYZVXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427338; c=relaxed/simple;
	bh=Qo5kgwS+W6CLmjgs0EOM5zbkem1ei0cHrbH71MnEQU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLM+T9LvE/2KGE5QfgOSSNa6vOjECbW/0xbzCiDZ4K5666rsE63yKODEEgRcut/FSUKBx8RV+w5OTB95IeIIQGasDXRMloKnVuMK6Z/ey8tGenrCJFJspdR3WuEYHPbAA2ChabsfjcFXCJJQcL4wGqT4Q46KtrpDB3QskqJUWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nr7uACHN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a3d21299aso3363517a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717427335; x=1718032135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6n52ORb0XfDC9vZKE5fhnlo8sj5tcBG5wByYNQUJIY=;
        b=Nr7uACHNwAF/pkjG1fgIRd/kRlDSJaotMSjYzX70lPbWI7VAIkvIMwJMm+SmWuLNcf
         arkgccTzQ2C5CWVi01CxL1VAsZpWJQhbA3EByQro+EDo6ZR699YtNoz2LIjlHJwqAOvn
         HoSNr81npFPjn+NqnkkR7WR15uRlVoBt1v4s/vjEO1N8T5tXBCWdpguwKB621De7WuFl
         aSc5yBHDI64QTF0dhhHhtk27OO4HKdfq9msxvQmLR7WUwcyF+YGcuFMbi6EMmX/QGnHO
         9u7SaIlTYj8MJxiyfKUgniIseJUpA4rJAX5xyVemo1LvphxUozPRxQ3MjqizvwjoNjFh
         qZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717427335; x=1718032135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6n52ORb0XfDC9vZKE5fhnlo8sj5tcBG5wByYNQUJIY=;
        b=sijlpUM2M1FBNl2yGf2vvSHoEvWbyTa3kTRSyyO5BcCHUQC/tDl3vwXTjQ/z+h94jc
         YRJFm97a7nXP4dudMNURukzcFNzM/KsHY4411yH10fmnTrJx82Nfl2GAb1SvoLqxMcxZ
         Bre/hfxEdi02rjAI3iLGlTb5SN5Omv782DagFXKNTax9iIk3N2ksUBjsnFJdMIvma2mk
         cwfs3Om6gY6OBJxF7e7jG3U99oc4/a07SK9ukG3kVG2GdjBs44qNr5uR4l68dWWGPh2Q
         sN4DxZ/rpbOXbM5o6uC26KnJ93XHpPkHhKiFaU+yXzXlZV+RxRtBnHXpgqVoXSOOmI6v
         iYqA==
X-Forwarded-Encrypted: i=1; AJvYcCXmmkGZ1yrppdvAW63NSkcUDSGyWTHnILjbOm1IMxZI/W1CQkqa+6KlMkfIkJ/XLABR08SAYmzPGQUWrwZN0N2N0BKRdoSirpxLxqvg
X-Gm-Message-State: AOJu0YyUgVOVJE+hmOcG02dE84LaJxxQdzxeDYv/P607cVTXY6Pp4w72
	XWKJA3KiehTS2EAbt8zHhINQxlGO/+HZFhcK7xFU3RWK1YVAKQhv4u8JvcTx9qU9tmYZYwL7UY1
	gtTt3+5JDJ8xcNznPN1CPRFW9vtI=
X-Google-Smtp-Source: AGHT+IEh6yYoOWL9lLBs0PfAJHZqgmYwjPFL0nu0vGzq1MMSQvlyHB81YbmMy0KP1lJB/ckdNFeoF3doIoTY6bBmlZk=
X-Received: by 2002:a50:99db:0:b0:579:c015:5377 with SMTP id
 4fb4d7f45d1cf-57a363823c2mr5623222a12.8.1717427335184; Mon, 03 Jun 2024
 08:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603140745.83880-1-ioworker0@gmail.com> <Zl3Wjh9_aGY8Xxm7@casper.infradead.org>
 <c0309ab6-8bae-42b7-8d27-1df895689fb8@redhat.com>
In-Reply-To: <c0309ab6-8bae-42b7-8d27-1df895689fb8@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 3 Jun 2024 23:08:42 +0800
Message-ID: <CAK1f24n9UB=Xqj23vLG7fYKUfvZgLqFVF-tsyc_nDrwAKC98CQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/mlock: implement folio_mlock_step() using folio_pte_batch()
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, ryan.roberts@arm.com, 
	21cnbao@gmail.com, baolin.wang@linux.alibaba.com, ziy@nvidia.com, 
	fengwei.yin@intel.com, ying.huang@intel.com, libang.li@antgroup.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 10:56=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 03.06.24 16:43, Matthew Wilcox wrote:
> > On Mon, Jun 03, 2024 at 10:07:45PM +0800, Lance Yang wrote:
> >> +++ b/mm/mlock.c
> >> @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
> >>   static inline unsigned int folio_mlock_step(struct folio *folio,
> >>              pte_t *pte, unsigned long addr, unsigned long end)
> >>   {
> >> -    unsigned int count, i, nr =3D folio_nr_pages(folio);
> >> -    unsigned long pfn =3D folio_pfn(folio);
> >> +    const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRT=
Y;
> >> +    unsigned int count =3D (end - addr) >> PAGE_SHIFT;
> >
> > This is a pre-existing bug, but ... what happens if you're on a 64-bit
> > system and you mlock() a range that is exactly 2^44 bytes?  Seems to me
> > that count becomes 0.  Why not use an unsigned long here and avoid the
> > problem entirely?
> >
> > folio_pte_batch() also needs to take an unsigned long max_nr in that
> > case, because you aren't restricting it to folio_nr_pages().
>
> Yeah, likely we should also take a look at other folio_pte_batch() users
> like copy_present_ptes() that pass the count as an int. Nothing should
> really be broken, but we might not batch as much as we could, which is
> unfortunate.

Could I change folio_pte_batch() to take an unsigned long max_nr?

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

