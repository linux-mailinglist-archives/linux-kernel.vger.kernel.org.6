Return-Path: <linux-kernel+bounces-339892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D3A986BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619CD1F241CD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9691531D5;
	Thu, 26 Sep 2024 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egqNe98W"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5D1D5AA2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727326387; cv=none; b=mn4itj/Crkw+pft3vYdHyaT0MDi72cV8ez8QFu60qJDSUCgpu/N5YrogW47qd+yVGnVs46oZbcgnvRsKsEn5IJhjhxxntf3b+K1Q+xmsdcUGO6ZhCJMkTChBR9aBMSmVIdGILDhBO/C0siDwLcC5J3ED/2/hpTBevxO0nKRHp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727326387; c=relaxed/simple;
	bh=OzAwXt3+XYTRpXj/nMUoiqw05kWB/QI07PxByMHf5YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGk3l3Ba6ZJZSacpe7QfX/ZW1Z/zBOnGcC0v/kHloxOk2MYH5HKeUK9+tC8x1Uwj6cHSdGJEb16zPgK/tb4aRVEa/hqY2ntKD6KQJVP+hSjLGXg6TlXkaZWd1wyG2vXzou66V+dUkGAc4ZbDIJ7nXY8CTKSqZwQ2rKw3tnfGbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=egqNe98W; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d2daa2262so60732466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727326384; x=1727931184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OzAwXt3+XYTRpXj/nMUoiqw05kWB/QI07PxByMHf5YA=;
        b=egqNe98WNVaSOD4plph1aA8WILMxHl8pHq9v99nPFfBC5Nz94r88ghFqpHJ4aZqjMq
         Mhp5y4f00xlsTlKULNS61itA/tiwUAhuXzWx0rxek9hU2/GiIkJzxDYT1K3TqW9sCPvD
         GGZp/4diHj5jRLFpY20zsee5M4La+UnKGuzg2QzpoO//ysdTS/NuIBSyKCr+JMskRqhk
         36AWm+TKRiQbLtJ4HX/iBfH/3UgPCYwmOFTBWE+f2wxduQ6oX7dL7F4RkmD1htMjdXDG
         UutAaUAwqN/DcjAEqr3aZoNs9y/cyao25N1S08RSXAjKaKOq68OhnKi/VIY6dIDJtsNY
         Sndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727326384; x=1727931184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzAwXt3+XYTRpXj/nMUoiqw05kWB/QI07PxByMHf5YA=;
        b=MUeVyqIcm0YAGfzGWwjyfnfSheW/XMC7EOBp9hdJTdcgkgRuvfUVFhnmhOSJnKPjTh
         xxn5SCPGmzwpG4Tup0bK4JGyvIJIIA02qlC7bl6QCoJx4pZgZE9gfS3j8pcRxIhYa5LX
         9KHS1DqhkPrhu79RbKlkWNDU1TOCct3hvmO2SyGIneWJpqcqsYdFlSVT3OtOrmSwN+2u
         8KMBgu7OoLyXSFK30SPJRNdlCR/EJlmCUcOYiOlzlxw7Xitk2vADFrAlIXIBeWfRchbt
         KbRk7nZDUQWBSAjKEqc5Imr/69fC6vXb/rDFP+/D15nzOfa1E5VZxd8kH4IIPbefKxq5
         GE+A==
X-Forwarded-Encrypted: i=1; AJvYcCU8U3/3ARyKp4g0/3sv9dwfN2vkAP3OVUOXd/qtWroojwqs19fyGWDiaWdOuqym9Nx4PtpLXPxAwqzd5k8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCVW2Bn0ycOY8QOlFAbiluI3u+ie5T8AjWwFiZS4yDyYAWDAt
	2HHbflsEIUI88DjNojtGbTtX1uYcB4A9YQR/eYud5Y3jap2zZQE8IFdVJ4qvHHVaZ+vQjongqGR
	Yfewt2AvzM/B+Z0ttvLf3evPtscWNvx5YFWcy
X-Google-Smtp-Source: AGHT+IHCHXVLdCNZ8Sf0Vu+1p/yVxOb4mcQIWFL0H0w6C94Y2GUT62Ur3fgL2Gj+zXOsVBuARUxc1eGZHNbR9LWlEmg=
X-Received: by 2002:a17:907:3daa:b0:a91:158f:6692 with SMTP id
 a640c23a62f3a-a93a0664dcemr563350066b.62.1727326383630; Wed, 25 Sep 2024
 21:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org> <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
 <20240925192006.GB876370@cmpxchg.org> <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
 <20240925201323.GA880690@cmpxchg.org> <CAJD7tkbCDe1Y__0vUKt9q0dz_sXM74fKGQo2Zgq9CJ8=FEjH3w@mail.gmail.com>
 <SJ0PR11MB5678EC9681960F39427EABFFC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB56781A134838ADDD04731AA3C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56781A134838ADDD04731AA3C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 25 Sep 2024 21:52:26 -0700
Message-ID: <CAJD7tkYtVR6fi1R2O+jAxVfj7BJ2EKWbXHke9fkv_m=mf5pkFQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"

[..]
>
> One thing I realized while reworking the patches for the batched checks is:
> within zswap_store_page(), we set the entry->objcg and entry->pool before
> adding it to the xarray. Given this, wouldn't it be safer to get the objcg
> and pool reference per sub-page, locally in zswap_store_page(), rather than
> obtaining batched references at the end if the store is successful? If we want
> zswap_store_page() to be self-contained and correct as far as the entry
> being created and added to the xarray, it seems like the right thing to do?
> I am a bit apprehensive about the entry being added to the xarray without
> a reference obtained on the objcg and pool, because any page-faults/writeback
> that occur on sub-pages added to the xarray before the entire folio has been
> stored, would run into issues.

We definitely should not obtain references to the pool and objcg after
initializing the entries with them. We can obtain all references in
zswap_store() before zswap_store_page(). IOW, the batching in this
case should be done before the per-page operations, not after.

>
> Just wanted to run this by you. The rest of the batched charging, atomic
> and stat updates should be Ok.
>
> Thanks,
> Kanchana
>
> >
> > Thanks,
> > Kanchana

