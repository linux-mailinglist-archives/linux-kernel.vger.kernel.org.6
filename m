Return-Path: <linux-kernel+bounces-206516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E88C900ACE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AD428B776
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF7D19AA65;
	Fri,  7 Jun 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUJ7gdfq"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477F33CFC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717779370; cv=none; b=rpa8Kewds4D9ZtJ1LgPh4pRCN5Er6bk4Vrb5HruQrKndcTCXS/yqelu+limbYULne7x+Bc3kN7MEYxK4g10BtjtiaVUUo00ZPu4y5xMxxDlbUpi1ABHnjTGtRne9KX0k//JAdV7TcbzN0DGHQEdT1Pp7N3Z1wHae8sZpwCWKur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717779370; c=relaxed/simple;
	bh=//VRgtR0iJfllvqKbgu++TYLbcb8G0oSib5a9u4MhOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbvIkMOKTYV6QLIql9X09aa264jbQUFT19druGl7eucHMjj3QPfklOXTVHJEoXRoijlTz+6LjbfyA0fxme55PS6Yw2tZ0e8pqdqNpLdJR+RnVvRkdZLcysgoEz6kwSLDsAeKR4xLuLuoTUV7tHDo93qTP31iEZR2/zh5+q6zREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUJ7gdfq; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-48bdcecf6efso846267137.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717779367; x=1718384167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8vmPr/U3SOxUzw+yKkrbrSVi4WiBXuKae4RE7ZMD7A=;
        b=iUJ7gdfq9znnyn3tXnCKwPBQ/gdj3rwU+xR48N7y2sTkhBnYDkikWyJy2JULT/EwbM
         xco5ryJlb5NDV/i33KKSGap6Sgoa9GOpvs4lpSl5E0QAckhqpIZizsDz87dzgXw8uvB0
         TbrUjdtJyAynuu0NH55Gm+i3n0w3iHzZiELQa8G32GiVPEieIiksBjj6LxHjhKSVVS+W
         hBRv5qrIrBn4i0F8U3hEjfaehYPtXAX7mEkxE25gAcPYWJn3FSdoEXpoQ/7RwhfHD6yM
         iPUKHywHahmMyah4giO2S271fcp+Uk0fGBo3MjsYqUyNYbJXSk5y+Rzpc4YHS6aFMD6c
         OTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717779367; x=1718384167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8vmPr/U3SOxUzw+yKkrbrSVi4WiBXuKae4RE7ZMD7A=;
        b=w6YVyM30R20YxW7anIOjPwsgoN+tYVh2UQXPMXs8f9QJTfxjj0eJqpKdED6iPsC0+D
         Ju47YQXLHBBhvQJx06AeGgPRr2FXoLDD2HrysH0inpCgSxB8P1ffDeo1ZDDS5/Ej1j2z
         eqKotqy84XY/TqTjIOCIpIVjG7fdQDF5bFJcIesxFHdtFTBiMzrNoUwhrXLj5WlgMKhU
         0wAoGJ67aNtHo5L3gdYr9kh08dOZl1qATeoo5oxXVi2lwwRvT9snwvfB8H5Wpa067czp
         6Di90jPt9bh6nWpeqpj+N2mnyMk+lVvJw/jRJaxQx/ZaSoj5odRFjQbarCnn5ZwFw2+2
         WGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVoEquFSWtHpO2J3Q4FVnlJIq9ARbTsN4k6JhJLi+0CrtcTcGXIA3y6hb1aD+r0S80E4kPKHkmye9yfKZW4q7woFFCVTxJy/eGaFzg
X-Gm-Message-State: AOJu0YzKnK9pkgkH+Jn+H2/K3rD9jKXP0lh7VSCAp5oq5ChiZQb1U8xb
	c9zVTREbLpVxlyDg469t7n9vNx1Wvx2ZyBgwkH7JG4TtzpM7ApHWicTn5OnuyPIVABs10I4hPT0
	U3VmHX0RW45pfXMIhFQ5NV4aPWMSAnscylH1T
X-Google-Smtp-Source: AGHT+IHQxzVTprFPbLQ57YE1AQRfmd8LyuSfQ2VqUUO1mF+4n+YkqBqwxGBOejxvOZHd9fjgZ0tdMWBbAXNS0VMHz7U=
X-Received: by 2002:a05:6102:17cd:b0:48c:526:8ae with SMTP id
 ada2fe7eead31-48c2752821emr3455949137.2.1717779367409; Fri, 07 Jun 2024
 09:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck> <ZcNnrdlb3fe0kGHK@casper.infradead.org>
 <20240207121125.GA22234@willie-the-truck> <ZcOQ-0pzA16AEbct@casper.infradead.org>
 <908066c7-b749-4f95-b006-ce9b5bd1a909@oracle.com> <ZcT4DH7VE1XLBvVc@casper.infradead.org>
 <917FFC7F-0615-44DD-90EE-9F85F8EA9974@linux.dev> <CAOUHufYF2E-hM-u8eZc+APZAsMX3pOAmto7kB3orH5_MRgvSkA@mail.gmail.com>
 <be130a96-a27e-4240-ad78-776802f57cad@redhat.com>
In-Reply-To: <be130a96-a27e-4240-ad78-776802f57cad@redhat.com>
From: Frank van der Linden <fvdl@google.com>
Date: Fri, 7 Jun 2024 09:55:55 -0700
Message-ID: <CAPTztWb0ZMHB74=KGxqRpTejDXNVJZ+Y9LGH1KEaPy_cnUmABA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: David Hildenbrand <david@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jane Chu <jane.chu@oracle.com>, Will Deacon <will@kernel.org>, 
	Nanyong Sun <sunnanyong@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I had an offline discussion with Yu on this, and he pointed out
something I hadn't realized: the x86 cmpxchg instruction always
produces a write cycle, even if it doesn't modify the data - it just
writes back the original data in that case.

So, get_page_unless_zero will always produce a fault on RO mapped page
structures on x86.

Maybe this was obvious to other people, but I didn't see it explicitly
mentioned, so I figured I'd add the datapoint.

- Frank

On Thu, Jun 6, 2024 at 1:30=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> >> Additionally, we also should alter RO permission of those 7 tail pages
> >> to RW to avoid panic().
> >
> > We can use RCU, which IMO is a better choice, as the following:
> >
> > get_page_unless_zero()
> > {
> >    int rc =3D false;
> >
> >    rcu_read_lock();
> >
> >    if (page_is_fake_head(page) || !page_ref_count(page)) {
> >          smp_mb(); // implied by atomic_add_unless()
> >          goto unlock;
> >    }
> >
> >    rc =3D page_ref_add_unless();
> >
> > unlock:
> >    rcu_read_unlock();
> >
> >    return rc;
> > }
> >
> > And on the HVO/de-HOV sides:
> >
> >    folio_ref_unfreeze();
> >    synchronize_rcu();
> >    HVO/de-HVO;
> >
> > I think this is a lot better than making tail page metadata RW because:
> > 1. it helps debug, IMO, a lot;
> > 2. I don't think HVO is the only one that needs this.
> >
> > David (we missed you in today's THP meeting),
>
> Sorry, I had a private meeting conflict :)
>
> >
> > Please correct me if I'm wrong -- I think virtio-mem also suffers from
> > the same problem when freeing offlined struct page, since I wasn't
> > able to find anything that would prevent a **speculative** struct page
> > walker from trying to access struct pages belonging to pages being
> > concurrently offlined.
>
> virtio-mem does currently not yet optimize fake-offlined memory like HVO
> would. So the only way we really remove "struct page" metadata is by
> actually offlining+removing a complete Linux memory block, like ordinary
> memory hotunplug would.
>
> It might be an interesting project to optimize "struct page" metadata
> consumption for fake-offlined memory chunks within an online Linux
> memory block.
>
> The biggest challenge might be interaction with memory hotplug, which
> requires all "struct page" metadata to be allocated. So that would make
> cases where virtio-mem hot-plugs a Linux memory block but keeps parts of
> it fake-offline a bit more problematic to handle .
>
> In a world with memdesc this might all be nicer to handle I think :)
>
>
> There is one possible interaction between virtio-mem and speculative
> page references: all fake-offline chunks in a Linux memory block do have
> on each page a refcount of 1 and PageOffline() set. When actually
> offlining the Linux memory block to remove it, virtio-mem will drop that
> reference during MEM_GOING_OFFLINE, such that memory offlining can
> proceed (seeing refcount=3D=3D0 and PageOffline()).
>
> In virtio_mem_fake_offline_going_offline() we have:
>
> if (WARN_ON(!page_ref_dec_and_test(page)))
>         dump_page(page, "fake-offline page referenced");
>
> which would trigger on a speculative reference.
>
> We never saw that trigger so far because quite a long time must have
> passed ever since a page might have been part of the page cache / page
> tables, before virtio-mem fake-offlined it (using alloc_contig_range())
> and the Linux memory block actually gets offlined.
>
> But yes, RCU (e.g., on the memory offlining path) would likely be the
> right approach to make sure GUP-fast and the pagecache will no longer
> grab this page by accident.
>
> >
> > If this is true, we might want to map a "zero struct page" rather than
> > leave a hole in vmemmap when offlining pages. And the logic on the hot
> > removal side would be similar to that of HVO.
>
> Once virtio-mem would do something like HVO, yes. Right now virtio-mem
> only removes struct-page metadata by removing/unplugging its owned Linux
> memory blocks once they are fully "logically offline".
>
> --
> Cheers,
>
> David / dhildenb
>

