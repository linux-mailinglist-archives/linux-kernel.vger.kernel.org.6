Return-Path: <linux-kernel+bounces-428645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36CA9E11BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A98164C72
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A8C16BE17;
	Tue,  3 Dec 2024 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LAT8xmvO"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143AA15B0FE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196601; cv=none; b=iS91I3THTMEwxs/hobSfjCOusxNyVOTqYHSqSfcDxuJtKp7VGnA8vxF1LcmknOzjwBhDICunnL7OUmWeUMaIXiqddo3xRpJC8iKWkvevydCz6cv8GH575JJXo1lxRrFtZ/YI/CKJYr7HMB2UjLSQx1C9LjD4oXAAXgzP5CGmDG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196601; c=relaxed/simple;
	bh=m57D73ksIeQHhZd6mW5dGC5oBwnwWtii0I+5F84Bgkg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LC3y73ftuKH1S//ZQsSwKW7hjA9xbvPY9l71+mOwjdXRs05ENr1Kesblo506NW+0YXM1ham1weBonQaEt120huqojBfFt1RAPt36w8/gtUFiQ4R+4I0EIL7IYD4d4lMlSDLhiK7QTuvXjAb5TfqzshfTvxAFQfqsubarFyXgYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LAT8xmvO; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733196597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMgSJ91ORzybZ/bsKAB2UtN/3yvFAjfo18ipsdZKQm8=;
	b=LAT8xmvOwCkGv14e2zGAcT75jRE4HmVN8ge+5NwURYf6iEk1qlZlyQaGvN3+qkxFQjS2nK
	k2MqM8LGkEFb5K76tirZCHOhcv1gMaFoivHWTVjSlUcFuOI+wl4ZVnXUaAWWuxmZyiLs4d
	O0GtW+f0wxRtG9aBjsZMLUrWhjr8Fqc=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH V2] mm/hugetlb: Make __NR_USED_SUBPAGE check conditional
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20241203023207.123416-1-anshuman.khandual@arm.com>
Date: Tue, 3 Dec 2024 11:29:18 +0800
Cc: linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9973D39-9840-40F2-91DA-1CA8ADC06AA1@linux.dev>
References: <20241203023207.123416-1-anshuman.khandual@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
X-Migadu-Flow: FLOW_OUT



> On Dec 3, 2024, at 10:32, Anshuman Khandual =
<anshuman.khandual@arm.com> wrote:
>=20
> The HugeTLB order check against __NR_USED_SUBPAGE is required only =
when
> HUGETLB_PAGE_OPTIMIZE_VMEMMAP is enabled. Hence BUG_ON() trigger =
should
> happen only when applicable.
>=20
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.13-rc1
>=20
> Changes in V2:
>=20
> - Fixed #ifdef with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP per Oscar
>=20
> Changes in V1:
>=20
> =
https://lore.kernel.org/all/20241202090728.78935-1-anshuman.khandual@arm.c=
om/
>=20
> mm/hugetlb.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ea2ed8e301ef..e6a5b21e3578 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4513,11 +4513,13 @@ void __init hugetlb_add_hstate(unsigned int =
order)
> 	struct hstate *h;
> 	unsigned long i;
>=20
> - 	if (size_to_hstate(PAGE_SIZE << order)) {
> + 	if (size_to_hstate(PAGE_SIZE << order))
> 		return;
> - 	}
> +
> 	BUG_ON(hugetlb_max_hstate >=3D HUGE_MAX_HSTATE);
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));

Hi Anshuman,

__NR_USED_SUBPAGE indicates how many struct pages are used to store
extra metadata for a HugeTLB page. So we need to make sure the order
of a HugeTLB page should be bigger than or equal to =
order_base_2(__NR_USED_SUBPAGE).
So It is not related to HVO. I don't think the changes make sense.

Thanks.

> +#endif
> 	h =3D &hstates[hugetlb_max_hstate++];
> 	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
> 	h->order =3D order;
> --=20
> 2.30.2
>=20


