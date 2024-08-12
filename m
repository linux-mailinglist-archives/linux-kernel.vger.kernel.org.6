Return-Path: <linux-kernel+bounces-282889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CAD94EA1B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173901F22056
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2D716E873;
	Mon, 12 Aug 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="folFWAZg"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8F16D9DC
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455647; cv=none; b=Dx7Jy55pbYXirn+W2NgI42RAASZRCdFtv5si+y9UbShEc5L263uBrcVhUy9n54acFKghmmp0AKf50IUr9+cB4LGucxww4Qc026FIwBLaqirapcnR/kQLI6zVJQXMzCeonCkCX8GZysfTWMhS+veadoD+9n3ydPz0gUFm5LBIOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455647; c=relaxed/simple;
	bh=rbUjW6lfk55WE8VYWNjigc5magfUgQmqIyRrK0h+cYI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iLJMRzG9AFYAwDJhGMUn74lAiMFueFjT6Yny8WFTiRjh2pB14YvbAwXkzcfRuRw8trbytnXaajHifg9FEeIlEbWnYCK0AcKsbXjAJzchmRLNZjVudKG0H9tQDa/1XbHrg9VcOP75Q39tdbW7mMM55fUufhm+AcKaByhjJeK1QZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=folFWAZg; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723455642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rduprgBSIee4d5b5yYCJc0UYqXaYrohaT8GPx1gGph8=;
	b=folFWAZghelTqknVmC7q+srlY79ynMWX+5BWYoO8tvRCihniH7E2MOOB2fkhqlupH+na3G
	TB0tbAwB0qgOHS6sxVB5N77RuAyjK5qRnu7qgvt7E1VpveM000Y7+p1Wx9GZEaDfDaNQKL
	ZvIIZ6BbMVz7nlo5rkHkDQ08LpO06nQ=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH mm-unstable v1] mm/hugetlb_vmemmap: batch HVO work when
 demoting
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240811041703.2775153-1-yuzhao@google.com>
Date: Mon, 12 Aug 2024 17:40:02 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C5E8EB48-1B4F-4C40-A580-8C99C128ACCD@linux.dev>
References: <20240811041703.2775153-1-yuzhao@google.com>
To: Yu Zhao <yuzhao@google.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 11, 2024, at 12:17, Yu Zhao <yuzhao@google.com> wrote:
>=20
> Batch the HVO work, including de-HVO of the source and HVO of the
> destination hugeTLB folios, to speed up demotion.
>=20
> After commit bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with
> speculative PFN walkers"), each request of HVO or de-HVO, batched or
> not, invokes synchronize_rcu() once. For example, when not batched,
> demoting one 1GB hugeTLB folio to 512 2MB hugeTLB folios invokes
> synchronize_rcu() 513 times (1 de-HVO plus 512 HVO requests), whereas
> when batched, only twice (1 de-HVO plus 1 HVO request). And
> performance between the two cases are significantly different, e.g.,
>  echo 2048kB >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote_size
>  time echo 100 >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote
>=20
> Before this patch:
>  real     8m58.158s
>  user     0m0.009s
>  sys      0m5.900s
>=20
> After this patch:
>  real     0m0.900s
>  user     0m0.000s
>  sys      0m0.851s
>=20
> Fixes: bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative =
PFN walkers")
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


