Return-Path: <linux-kernel+bounces-170882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661648BDD3D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CED1284E2A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AC514D2BA;
	Tue,  7 May 2024 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPn3VOro"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CFF13C9CF
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071102; cv=none; b=R9ewpYpU62IUHsDelz8sheArjYpJBhm7YY7lZKaMItWXFkB80Vj/PF1RP449C0uAdMWy/bNmElEYEqwduancl8t54ZDbPI8ibZ4/OvMbO3neIx3GqzixCR4j7+SMnwQsipYpadYyTYTwA6yfooif8hjXi09bgAOwkWfbs60vyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071102; c=relaxed/simple;
	bh=ayJdpi2spmyDJ1bR7l+EpEo/WH4lkWBiUiptZi1GjnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDhcD2STNHYJZt15jzxCuCoWItDeFJGNwdRfrvIsToz+d6HZC00hZULGvH6OWpqlo9WipgEywii0S1WkOU3swTj/3hVjaYOp6shPGR3Yf3HcE8RjTILtDO4SF793GYuug6ARwqY/EB8n7KOUAGnmoon/gfOswNvLBS6x9urEj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPn3VOro; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5200afe39eso733864466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715071099; x=1715675899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8d/lEWlCZJQYX2qha3kS5f99rv+hpjz1wOoh2/05Gk=;
        b=LPn3VOrold0UXhAr9bHCKtS1b4jCPT+xylRgb2pXzQ2M8VfL/cIUTZ07E1/EoWAuJy
         iWOE+Kg7acjJEFGUVsNf5xNpFZ9wkrGDXvyb0vpq78/UEfER/w9USgTmWsTKwTzn+E4l
         1cfxt5C3p7FwZP+Vv+EHBQgURMj30RuipmB5b8Y0ou5oqgFXZl+Gxei3Amt7M5DfeA4K
         QBboGye5g4AOCSlrr8EIt4c4jbOMoghZS5pHHFgtsk97/V47GXw6vk5YClF40xUiKUcB
         KHE771JOcVVH5ifCuIvWS99l+RwKhVPZPrL8+QvwiOsG7+uAgETMdx2IUraxQT4tOWKq
         X8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715071099; x=1715675899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8d/lEWlCZJQYX2qha3kS5f99rv+hpjz1wOoh2/05Gk=;
        b=U4hTTTnIFcl60SZxkFt9Btalgkzm6FGK4SUVNXtcsVBKgEMcjaAYDq6/sym994/3eZ
         Vc+74sILeWIi9DfsF3vIhQKuwfqasKyIlbRXSm/ukx5wqLcHkZCShN0pHqNcbX1lgCq7
         jpYc74kefUDo026m9x/WmwbZjt69dBxEA29moSLT0h6ArVQjVJiR2cRj3DpLFGGBgUeK
         bR0gbrONo8+2/nRJcej0q4wbfxe4d8s2ucwtrbNeZKSVKBbFKH35bWTBlajgEDj4yzgW
         Yxjx+1kIVZ4pUfc1/XTlhPiO9QKMKUYLU2N9av451XiMbECTGdspSRNigCX2qy7bHEHo
         AHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhyF/R9+TUnpothcrjcVkpNOoy9hnhjd3SGSZ35yEUHIkj/gCXiG9VbBjsoR8lzxRZjp+QbGAYPA9yZl8UORY6iMWycxqELr5GmxT5
X-Gm-Message-State: AOJu0YzaPJyZ25jI4+c2ksvy4bOU83j3L4eTsSWDH0Io2lEJCOO30KvF
	J1OWq+VBWAv6xi7BlUqFJQc9HYoTokXFvLWgjM9V9eVdr2EI2FkdzinfN9T2otd6mcnY1RU9dhc
	+AXSbivf1ZFl21/cwpzbp0A/A/d8=
X-Google-Smtp-Source: AGHT+IFnaj3FxuvdLHi80OAEbz1pTKKCCrJXhtWCA3W0lzkbNcQqyw1zs3q4GVr1QUEyYKfAE9GIk8ukRJNyFtk8Osw=
X-Received: by 2002:a50:c319:0:b0:56f:e7b9:e67d with SMTP id
 a25-20020a50c319000000b0056fe7b9e67dmr12607642edb.12.1715071098814; Tue, 07
 May 2024 01:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501042700.83974-3-ioworker0@gmail.com>
 <cc9fd23f-7d87-48a7-a737-acbea8e95fb7@linux.alibaba.com> <CAK1f24kyCj2Svguuu07wDuVEWYYbcmRc_18ihgVAzSjoJ9ox2A@mail.gmail.com>
 <a8f7a8da-c2e1-443c-9220-a224d97b1c81@redhat.com>
In-Reply-To: <a8f7a8da-c2e1-443c-9220-a224d97b1c81@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 7 May 2024 16:38:07 +0800
Message-ID: <CAK1f24=rWdgscbDa6pMqOmTEDOHVLo5NQ=7jOo9TdyJRXahHZg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, 
	willy@infradead.org, sj@kernel.org, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey David,

Thanks for reaching out!

On Tue, May 7, 2024 at 4:17=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> >>>
> >>> +             if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> >>> +                     /*
> >>> +                      * We temporarily have to drop the PTL and star=
t once
> >>> +                      * again from that now-PTE-mapped page table.
> >>> +                      */
> >>> +                     split_huge_pmd_locked(vma, range.start, pvmw.pm=
d, false,
> >>> +                                           folio);
> >>> +                     pvmw.pmd =3D NULL;
> >>> +                     spin_unlock(pvmw.ptl);
> >>
> >> IMO, you should also make the 'pvmw.ptl =3D NULL;' after unlocking as
> >> page_vma_mapped_walk() did, in case some corner case met.
> >
> > Yep, I'll also set pvmw.ptl to NULL here if any corner cases arise.
> >
>
> This series already resides in mm-stable. I asked Andrew to remove it
> for now. If that doesn't work, we'll need fixup patches to address any
> review feedback.

I'll patiently wait Andrew's response, and then submit the next version or
fixup patches accordingly.

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

