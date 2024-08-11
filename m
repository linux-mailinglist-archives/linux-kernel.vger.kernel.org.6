Return-Path: <linux-kernel+bounces-282172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F4A94E073
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE5D1F21538
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 08:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E6A200DE;
	Sun, 11 Aug 2024 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpWSpDy+"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FF15AF6
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723364045; cv=none; b=V8ZE+0PWS8r3xil2SlGMYKzinLbepq6aOMIsyLgmRJ4Nn8r0x3I53fQVwP+W4uywjrMdn52CD1dxk0m0VsMSwr74OkyTfz8oy0DfpS/4r5CsueAQYn7vTIqc/rUwiMx9eDm1BQ0I0DH0W9yuQSFp7LAjz28zEMVyBKS1eN28Qps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723364045; c=relaxed/simple;
	bh=IW8D8ky6VmDxd30J5JsudFbHqq4Ga6YraHQcz2FJiIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPim0uJlzKXCUGZ4e0B4VOpS3o5rSWxLUfNPDI3+levNxi+DzgZKRTaHWnFIhLOO64YP3/IoyFBMhvnu3FQglqq5hYziusgz6/z3t8GBVDBdv7jXjbuWeq3FpdOYSxms+MOr3rdPQZuiUx5IXyKkoZhaYvSAX/A8IhvvgK2gG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpWSpDy+; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f6c136a947so1648325e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 01:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723364042; x=1723968842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IW8D8ky6VmDxd30J5JsudFbHqq4Ga6YraHQcz2FJiIs=;
        b=lpWSpDy+vFPbm5DSvRkLQgsYsbyHfTkmDhxLqgtEMF86rCDp2m1yvvtOtNNzKTPlT2
         ZiKOO9GBGpMGSEutF0n2GvIbD46ttPVO8IMdHST30E7jSSFeSuW93qVHse1ZLy9AotQ3
         rX5NNYY0rpOJs35tF0BfE8xznfK1vMfcfeG3aBRZ+Ac2T3uuaq8VWIina37iKydOnDp9
         gq5zv02gGUa6eJd2l5TbT7Bn7+5VXaLIeBAfD+kZwCQAua+wi1LBjCqwl+wo6C1u15MU
         qJn+X3/Dlwt51lqhAa/UWcguM04yQNAI1sFxE6jGDR8DFylMNxNTb0zD0gHVU2EmQqO1
         4Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723364042; x=1723968842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IW8D8ky6VmDxd30J5JsudFbHqq4Ga6YraHQcz2FJiIs=;
        b=qGXMQS5eA2ltF/yBpix/OWdJSUAFoIILTJvTU6VIvwbo4wzf/xg4BgO4KTsqU18J1G
         lIqVP0G0wYsVvz/LjeupLUFiH87Y8iN2RWujarjeYImcPn2CUybgHTitJXz8aSddSr+b
         g9a4bG2Oq0cB2Yy3z1/WBozpk9257fZBxT7rBYGHwuiwtyrt2za6Cc0kEOKudV2+0NwO
         EX4nAzTrDqDQRHl2Dg/eWVfMu4S0c5J6wbR/zOI7Wq3PBT1KljTnb5z8u+VsQKDNGUSe
         10hWRF1J8SU3Gw3XqRAZL9Q/DSB4ROJNLZ2pQsaTkkfP4uZ2rQzNBxHVjWKZpbBxNbSZ
         9umg==
X-Forwarded-Encrypted: i=1; AJvYcCVV7yMG5cxZA5m6L3GKYzsibPP7pwzccZ5sV3k53r0ECc8N2H+Tq9S/htqOvCN6VwQcOR4WkInYYMKXEReMJ+lqlrhQQauG1F9xeb8H
X-Gm-Message-State: AOJu0Yxb4izqxEDFMJgKivZG+gZDnO1kVkaGPweluGUymbJTIyaViM5I
	s0GtYOfom1wBlVCPoht963SaFaV+g4lS1/Uh17CwxdFBXdfzGieWnytD8yG5bkRRkL2ZGy7AU83
	BZveesSHattzMqm5aqsCE1UECEoA=
X-Google-Smtp-Source: AGHT+IGstJESyRPUBiJVn6xiheFxwi4sK2Krx9epzULVscTdmL+n5CMPQ2jMSBdoSQrYii0fuUohFmb+NBq+GBerOU0=
X-Received: by 2002:a05:6122:2919:b0:4f6:adb5:aee1 with SMTP id
 71dfb90a1353d-4f912ed2b4amr7148974e0c.13.1723364042364; Sun, 11 Aug 2024
 01:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808010457.228753-1-21cnbao@gmail.com> <20240808010457.228753-2-21cnbao@gmail.com>
 <e9f82fd8-e1da-49ea-a735-b174575c02bc@arm.com> <1222cd76-e732-4238-9413-61843249c1e8@arm.com>
 <4465afdc-23e9-4844-a0a0-519f49b1229c@redhat.com> <616401ea-289d-4ae2-acde-6704b0fa9c46@redhat.com>
 <9f8ba5c8-5bc3-4af2-96d2-2f52ee923ef5@arm.com> <c063335f-a29e-433e-9192-39c7b3e5d06e@redhat.com>
In-Reply-To: <c063335f-a29e-433e-9192-39c7b3e5d06e@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 11 Aug 2024 20:13:51 +1200
Message-ID: <CAGsJ_4xgT=E7XFiGnzwYm_26f3xSUFeD3Aiyvewge=KZjxzjow@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	chrisl@kernel.org, kaleshsingh@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, ioworker0@gmail.com, 
	baolin.wang@linux.alibaba.com, ziy@nvidia.com, hanchuanhua@oppo.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 9:22=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 09.08.24 11:05, Ryan Roberts wrote:
> > On 09/08/2024 09:58, David Hildenbrand wrote:
> >> On 09.08.24 10:42, David Hildenbrand wrote:
> >>>>> Not sure I fully understand why David prefers to do the unaccountin=
g at
> >>>>> free-time though? It feels unbalanced to me to increment when first=
 mapped but
> >>>>> decrement when freed. Surely its safer to either use alloc/free or =
use first
> >>>>> map/last map?
> >>>>>
> >>>>> If using alloc/free isn't there a THP constructor/destructor that p=
repares the
> >>>>> deferred list? (My memory may be failing me). Could we use that?
> >>>>
> >>>> Additionally, if we wanted to extend (eventually) to track the numbe=
r of shmem
> >>>> and file mthps in additional counters, could we also account using s=
imilar folio
> >>>> free-time hooks? If not, it might be an argument to account in rmap_=
unmap to be
> >>>> consistent for all?
> >>>
> >>> Again, see NR_FILE_THPS handling. No rmap over-complication please.
> >>
> >> ... not to mention that it is non-sensical to only count pageache foli=
os that
> >> are mapped to user space ;)
> >
> > Yes, good point. I'll get back in my box. :)
>
> Well, it was a valuable discussion!
>
> anon folios in the swapcache are interesting: they are only "anon" after
> we first mapped them (harder to change, but would be possible by using a
> NULL mapping maybe, if really worth it; with memdesc that might turn out
> interesting). But once they are anon, they will stay anon until actually
> reclaimed -> freed.

I assume we don=E2=80=99t need to worry about this, as even AnonPages (NR_A=
NON_MAPPED)
in /proc/meminfo also entirely depends on anon pages becoming anon mappings=
.

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

