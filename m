Return-Path: <linux-kernel+bounces-385601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E72749B3941
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954EC1F225EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22E51DF97D;
	Mon, 28 Oct 2024 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOr06pMO"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CFB186E27
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140624; cv=none; b=ni37LYtgyjSplgmC+TzO6wnjBOECJcP2UIzu0j/tRGB0dIspsfrceuHW7wEAyJyrrr9NinAe587kN0ht/1x8y91kWlTysW9vunfg8xrgBpMLqbg8Zk4XYPie1DObes3p9yDDvQATaBt3pRaPlh/en4/lB5GLBAk8xXU1cWoJjNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140624; c=relaxed/simple;
	bh=PsNzc2OXfUCmJP2l2vN8PVR2Xt+FXaIQ1Sx8H2964UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGgnJNB+T9lhOgj8+WAICh9o34fkvlTn1N7VcqgnxF+CxSPtJBV6YHLV//rgTq938cSxm8SveEeHl3LveGsFQ3XP+5K3ItDLYTWEoOu1+xjc3O+IAMwne0Z5zkYwF1vcVbk97jYaYDnl2qNhhVTHM8PBDBDagc6MZlxqfxfeuEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOr06pMO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso9118115a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730140621; x=1730745421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsNzc2OXfUCmJP2l2vN8PVR2Xt+FXaIQ1Sx8H2964UQ=;
        b=JOr06pMOLujJbLBZXDPH5DX84XKfgR5TYxxUEkKrh1vxw+itH/MLc0x9l28p/zj5ZV
         rPDPd3WqoFq1L3q2+pKjXGzEZBQJ9dnXLYdy3wzRwlbXj1XLXlRqblm4h1075oGPDmO/
         lnRGTO/xEZ8K3y1wrr1/Oe/snpVftDi8ljn5+fij1xSOfnPXrO/btT9vigRf0ZZM30R2
         nFrwXAbpJhKqBNa7h0SzoF8USg+Cxgzi4Ko/aXptcfKXI2LzOiyDpu0qbD3VDvVzednD
         uqtA0aNU0BgZ/E4Wc+fOpY+jZKbicJa+GtWzjkvl3V5pPpflmDTthoKgosZI7L6ZxhjU
         XI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140621; x=1730745421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsNzc2OXfUCmJP2l2vN8PVR2Xt+FXaIQ1Sx8H2964UQ=;
        b=Y6if7/3wM5+pxPwTAlSxVicFTGWtS8XwTIVn31jgbsYCWncM4DPlhQbtQwp0B0d2kz
         H7h8M+CxqfKHkeSIsmEEIdNTirRaO7gZqWGwAg8C9IQaCtXUQhGY9xo+Ax7LTe0NX/KV
         tg2Y8q22AvPa27gyEGHsgpp+Gu40jDYh3Siz3uuV9W560w8U7h5hWaZd7QcNmU1A95F0
         gbPTjbEZRJgPUxrZft96lYRxMQtfBc2b/AS8mFoYLPQYhfPTdZ9FjqAdF1OBrTrE/c/I
         3aHA6V22JEWRDdWXB2psomCNc2acAuL2wmQ4y7pCooaopz0fliMwp7ODorL11dfKGfug
         sfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0SRRwbw353PcjzTtO51w7lKqjoA6atBQyYdnBXBCjBvZx1EocY46OWhi9zYDSqTBdoniU/jgrBqA4GsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0rShFc/bErdRbSz6U2QXPUtztkeT8QNC87fObvgoJ1l0bYDT
	Ct9G/2zUKx8b0rDbXx4YdgOm1C0GaQfvj7t7I5Ka/zbM/ff6dKPP01IQn2ZptbJ6D0siWhby8MZ
	31rSe7Mx6y0CkuZ7ICaUzYd4JBHU=
X-Google-Smtp-Source: AGHT+IG4WvxG8g6dvo3BHYFnBH+wdpUsZIaJXYJCg/ztAeenlQauWzMEMGpB8nzANJtwXgFCVFXBcS8Mgd23/gp+y9s=
X-Received: by 2002:a17:907:9808:b0:a9a:ca:4436 with SMTP id
 a640c23a62f3a-a9e2274cc43mr41235266b.13.1730140620413; Mon, 28 Oct 2024
 11:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
 <3A1E5353-D8C5-4D38-A3FF-BFC671FC25CE@nvidia.com> <966a4aff-f587-c4bb-1e10-2673734c2aa0@google.com>
 <E5A75697-55C7-4335-8D86-EE5CB6A99C4F@nvidia.com> <CAHbLzkqEhbw89HMh7h-r6M1xM5vw7bUZDNO7KEgPyaguO32d-Q@mail.gmail.com>
 <5d28df34-f073-dec5-730e-a3073f14d849@google.com>
In-Reply-To: <5d28df34-f073-dec5-730e-a3073f14d849@google.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 28 Oct 2024 11:36:48 -0700
Message-ID: <CAHbLzkpTgJkzCNCmPwmtnOwGEf0-pxT=_bhPw-gawgiuH21OBw@mail.gmail.com>
Subject: Re: [PATCH hotfix 1/2] mm/thp: fix deferred split queue not partially_mapped
To: Hugh Dickins <hughd@google.com>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Usama Arif <usamaarif642@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 10:08=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
>
> On Fri, 25 Oct 2024, Yang Shi wrote:
> >
> > The other subtle thing is folio->_deferred_list is reused when the
> > folio is moved to the local on-stack list. And some
>
> Yes.
>
> > list_empty(deferred_list) checks return true even though the folio is
> > actually on the local on-stack list. Some code may depend on or
>
> The code definitely depends on that behaviour: that's how folios get
> unqueued when refcount reaches 0, whether they are on the public list
> or on the local list at that time.

Yeah, folio may have 0 refcount on the local list after that
folio_put() before it is moved back to deferred list.

The main purpose for using folio_batch is to disambiguate list_empty()
so that we don't rely on this subtle behavior. But I soon realized
this may make deferred list lock contention worse when moving the
folios back to deferred list. Currently we just need to do list
splice, but we have to add every single folio back to deferred list
one by one with folio_batch. It depends on how often folio split
fails.

>
> > inadvertently depend on this behavior. Using folio_batch may break
> > some assumptions, but depending on this subtle behavior is definitely
> > not reliable IMHO.

