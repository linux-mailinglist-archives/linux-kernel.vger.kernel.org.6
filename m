Return-Path: <linux-kernel+bounces-185475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9AD8CB54D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B69B21C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD6E14AD1B;
	Tue, 21 May 2024 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWFen5FH"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014D14A0A7
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716326037; cv=none; b=VSjdpncn4AzcLXMIADsWfJ61ZcqMh+zsPl3n6hweJ9l0OsK3xSqve53XOuQe7Jg/zd3eX26xY1oepVb0FX+VwnHExkvwqR5Bc7MrsvehAzIcklQOHoCLy8HaCA0FiC5skAN2J2OQmKdnCyCnIKoaOxkzhqTOA97J0rlu5aVwql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716326037; c=relaxed/simple;
	bh=XJrwOFkUKP4/z7RdZ07n0J2mQTriZj/MXU6AFRj0DLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qm3y6Q/s6nNK8m2vmUj/3scm3MdqYTFccTxUlB2/QpB1Gh1IKbH6zvCgnjZuZqKPnreNKnwWvOzUD6SirW9z8+G8lQQVQ0uPf/YpNwXbi+vS8lvPLLnrCcXdNiLMtduRpcu9/0xII5Li63ZS9dTBsT7DlymeJn/1H/kRJ43J/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWFen5FH; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df4d7e3dc94so665258276.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716326035; x=1716930835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbWbXx7vJ1i08xW/qbhmslUZ5xQZCe4YxRTC1ODguek=;
        b=RWFen5FHg054vw3nAnnRTdibg1oyb3K+OWVS4xeYDj/MfnaC3vQssYRkhsw3+8nuIl
         zKQNLLNdC3ByvldkbuOgHErOANU7eDEBj2E0UDzXHMnCr536M6LJKKy+ds/+jA7fVWfF
         EJ40nwEVgn1P5xPw4+9yzVMehVvGYrY8x258yJ5dmhp8/SDEz0BVbaRmJOnBFHkinLB/
         Z3OT27CYhwx64ObKunc1lW46pHqJ3et9wafIWaJ2aIkP0hd2rCZICcgvJgCBBbo0+v1a
         elJmEe6cBR5GZAEUY2LYX7zEr5mBq0G0liBHCCoWcCDXkqV5nIr0L2yVpXECPU0YbtQq
         oKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716326035; x=1716930835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbWbXx7vJ1i08xW/qbhmslUZ5xQZCe4YxRTC1ODguek=;
        b=eIbIljAfkBebGJmlicwzGrOaXQTwD2MtyW+l1J9ZONjZSrsBPkEKZudv8ZjXopDZbK
         aG2kWSeED6pdc4oUFPSFmatnJ7SVFBvjy+k99L2bi3jmMQB6nFeAv+CFOodnPHtK63nv
         sqfZLPDSlOJIfM7KlmoaMB40LTdgwuZvGedJi6xXucF7t8FO6uW7Ll8/U1X/7Q5m8H9K
         QJ/gujl1V4oNV2RcPsR8F1v3p5sWfr2NmLi2mw8004aghNO4XuQpGcL4GL6zNdYf5Y0t
         CCIaqnDVImh3D3nAi2n3VfS9OJxkkTYsxoBg75xGHiFdd7ZwivG6leK6AGKT7xUwwEXh
         VRKA==
X-Forwarded-Encrypted: i=1; AJvYcCWXckUHNPgbM4vpS2ViXB8mUSOlJqa9YqIjr2eyUU3D5dqZFvOgWDAEY3ZifVoTMGuuI8ci13iQVqUUK39waMCV8RxBnxk7wqDVrQT/
X-Gm-Message-State: AOJu0Yw6mCxWnbasQw5dFHgVnGEy9S5CJAbaSU8xsCyLJPyVhRM4zL20
	7NPdXxe981i4m/KHljekKhDaG0jVjfp/IGIjqJJTYCujD0di+H4oBnnyWikLEiDKPjGWhckJXoe
	hPGL4dslW8IBgzU9WkA6NsxvvkTk=
X-Google-Smtp-Source: AGHT+IGT9WMrvl1keBNANN79vgH+AZV9YNsZloQmZW5X0PV5v47+uKK+51bO41hFBUCI/6BO7T/E+/sHeYt6G8SLa+8=
X-Received: by 2002:a25:d8d1:0:b0:df4:8ed0:221a with SMTP id
 3f1490d57ef6-df4e0e3f86dmr342152276.55.1716326035516; Tue, 21 May 2024
 14:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520194749.334896-1-vishal.moola@gmail.com> <ZkvErLsj8Ngj4qM3@casper.infradead.org>
In-Reply-To: <ZkvErLsj8Ngj4qM3@casper.infradead.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Tue, 21 May 2024 14:13:44 -0700
Message-ID: <CAOzc2px9sWGUPbCM+pHuqt8eAUONrDcKnEybvM6k6ot2ftpmmg@mail.gmail.com>
Subject: Re: [PATCH] Convert __unmap_hugepage_range() to folios
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, muchun.song@linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 2:46=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, May 20, 2024 at 12:47:49PM -0700, Vishal Moola (Oracle) wrote:
> > Replaces 4 calls to compound_head() with one. Also converts
> > unmap_hugepage_range() and unmap_ref_private() to take in folios.
>
> This is great!
>
> >  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_str=
uct *vma,
> >                           unsigned long start, unsigned long end,
> > -                         struct page *ref_page, zap_flags_t zap_flags)
> > +                         struct folio *ref_folio, zap_flags_t zap_flag=
s)
> >  {
> >       struct mm_struct *mm =3D vma->vm_mm;
> >       unsigned long address;
> >       pte_t *ptep;
> >       pte_t pte;
> >       spinlock_t *ptl;
> > -     struct page *page;
> > +     struct folio *folio;
> >       struct hstate *h =3D hstate_vma(vma);
> >       unsigned long sz =3D huge_page_size(h);
>
> I would appreciate some further cleanup ...
>
>         size_t sz =3D folio_size(folio);
>
> I think there are further cleanups along those lines, eg
> pages_per_huge_page(), hugetlb_mask_last_page(), huge_page_mask().
>

Gotcha, I'll look into those and change them in v2.

