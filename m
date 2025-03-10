Return-Path: <linux-kernel+bounces-554420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DB4A5977B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE443AB886
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F84A22B8CA;
	Mon, 10 Mar 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aCBNVXNP"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9222B8B1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616536; cv=none; b=TtI6fFQqluOTD71YlfXn6GEnVu2TpHfQ/5dX3qoRUPJRmULmlk3CQxX/3AheMky2DyfKJ14CAnwsNd6dkWAwCpGfzT7ybDXf4ObIyZgcu/zwbgMblkks4hc91R3KehU3Fp7yXoHcREU6YwtHwX9bmZzVZcmIp4GYqe8VPdnXo6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616536; c=relaxed/simple;
	bh=GopVi4CFli9+2u8VyRRCUiOOhbr6gjtfX/hbJvOfiDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoW/FfqfnjD8z/ehrH1Cdlx/wcci6+A3u7tUzWI7IISpUihEbeEeru2Ts+Xin9FbiCooe5Yh4nFyRCu8LYfntP8FWtAj3pLtKQ2FL6JFJGt0rVn/uaQORUEq4D3t8jdfmA84qmP0E+UAuJV1RLdfRuhSJGeCxNRbMQ2l45E8lxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aCBNVXNP; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be8f28172dso276289485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741616534; x=1742221334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqAivX8fNZr1y5mCMqdp2/vAbFsiV7nutZcGvyFYNRs=;
        b=aCBNVXNPy5NXU+Y+aLYqID97r3sNYkcNqH/Vw+Jszu9g2ysAXpj4M9Q/51OLOTsBGO
         XnET9eGTcxgwt08T8TOqRfPyrRYDwovO4oungzj66WaIQNg1cbsgCaeg3OISR8lBrILE
         5CR0e/bn4HqPCBi21v+waF76cEDG6+dvoAu+wtuSKaz6vPRCLchuc4850PsEzTtUIx3D
         J38/ipz0fU0S4B0FvBNJM+zO2gvgpL62f1JsnMAwk5H2qtuSU6IaVNcxyEjwhCodQdRH
         gjjQ8puQsI83FBZa1z7A7N/VKwyk78jwyEuUrsMkvZoCy19sdEhjD21BptRogAg2X2yy
         SvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616534; x=1742221334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqAivX8fNZr1y5mCMqdp2/vAbFsiV7nutZcGvyFYNRs=;
        b=lIX/amEOTnMUvSd8JOEVPVkOHW/DiOjt6021c32RUTMBksJXVoWSh0xOZOc1UvSZu7
         AyWNYiBfDm2gwOitncEt+RVH34yanifbniEtlXHK1ZplFQRNqBA8SXDmxEaMCI4ya5vK
         EM+jDrIh8NnhdUCWM0ioh8tzHD3DBG4xkgAAyJDzosIvoRvz2urKceTwiCHxzSMuiLTz
         pj2B0XHRV4pLXVu2ImHEGCc4wHAlbwYfMnuFr5c6m3lFlsXv+MOkqZdaHteQ257FreDn
         hrHfas8mqayLhr8For9p8LtUoDMwZhtMHyswccowe13Pz6HuVyYCfEKP5ax98mLMe+s+
         E8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXi7yGNKn9ESrE6zvtG556xLhjEy6iiV/UaJKQ/IFGwpjpN2wEaMB4xPBBhtIdNHgD4Ner1URgV/ZOQt+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPH5u/8z6efxfHcIs/vQSHFMcOWggPl2S0WYNh5Lz5AojbBcy4
	eD6UCYqtfu/tMc4Sk8eFE+UaTl34uV7rxH9E197q5VX2uoR7vXmQvXCqnTHLC6A=
X-Gm-Gg: ASbGncu/rwL/+drOTSh0FAiERzShFuE5e+Wdda27qLnBjYm60XOB8uOd0dC1nvUQ8R0
	rAwfrQ9/ytfbdGtFk4t+iiJfkanx/INl7sbnL8cXWNGvBIwP4cRVaG8Rqjbx8b0pNHOkhufSRpF
	vfRrmhuZ/JG7rrq+ln9akG/N2SnqnIsJBk6oIf607chZ0XFcDah94G76aRUgX+X46VEEpf96nvT
	MCj9Y65IHrVKIk5YHUXgYRJZaKAZOU3VpXu145pohTZzjgWmEVoc9af6iwjzRGVcj88yp/B4gjo
	nJ2iy3skK1d6xhryXoAa82JLXEmmazSzexju+LsNBQb0HREv4UgKcUiCETMcAtjb5iwPvkoMuEG
	bBmuYz9mXkb/v4GOhkhI6mdD7a/E=
X-Google-Smtp-Source: AGHT+IGWp5c3aEnPJVivT/AhAFPuiRfwxBggFm2GJnLG9GVp+RjnZOHURcFZvyyZYlV4KH2xR6gLmw==
X-Received: by 2002:a05:620a:4397:b0:7c5:54d8:3d43 with SMTP id af79cd13be357-7c554d83f59mr522944285a.58.1741616533797;
        Mon, 10 Mar 2025 07:22:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c555478e28sm173939785a.36.2025.03.10.07.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:22:13 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:22:11 -0400
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
	harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z871k085e-Th-jTz@gourry-fedora-PF4VCD3F>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
 <Z8cqe3BCdobsV4-2@gourry-fedora-PF4VCD3F>
 <f64819e2-8dc6-4907-b8bf-faec66eecd0e@sk.com>
 <Z8ncOp2H54WE4C5s@gourry-fedora-PF4VCD3F>
 <9c0d8aa8-cac7-4679-aece-af88e8129345@sk.com>
 <Z8syE7l5H35pk9T5@gourry-fedora-PF4VCD3F>
 <9caca3a8-280a-45bd-a081-cf4a28f05f21@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9caca3a8-280a-45bd-a081-cf4a28f05f21@sk.com>

On Mon, Mar 10, 2025 at 09:26:48PM +0900, Honggyu Kim wrote:
> Yeah, the proximity domain detects the node correctly as follows in dmesg.
> 
>  [  0.009915] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
>  [  0.009917] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
>  [  0.009919] ACPI: SRAT: Node 1 PXM 1 [mem 0x60f80000000-0x64f7fffffff]
>  [  0.009924] ACPI: SRAT: Node 2 PXM 6 [mem 0x2080000000-0x807fffffff] hotplug
>  [  0.009925] ACPI: SRAT: Node 3 PXM 7 [mem 0x64f80000000-0x6cf7fffffff] hotplug
> 
> It is printed even before CXL detection.
> 

I wrote a some documentation on some example configurations last friday

https://lore.kernel.org/linux-mm/Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F/T/#m2780e47df7f0962a79182502afc99843bb046205

This isn't exhaustive, but as I said with Rakie, I think your
configuration is probably ok - if slightly confusing.

What I'm going to guess is happening is you have 1 CFMWS per device that
do not have matching SRAT entries, and then the CFMWS covering these:

>  [  0.009924] ACPI: SRAT: Node 2 PXM 6 [mem 0x2080000000-0x807fffffff] hotplug
>  [  0.009925] ACPI: SRAT: Node 3 PXM 7 [mem 0x64f80000000-0x6cf7fffffff] hotplug

have interleave set up


