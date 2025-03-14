Return-Path: <linux-kernel+bounces-562128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A6A61CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFE83BDFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA432040A8;
	Fri, 14 Mar 2025 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQANX0qK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8226413F434
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741984634; cv=none; b=dN/YJghhlgD2rzg0Iua27hLNwZ9f0qSoc9qcDOC9b0kbKgDV93tVkcNmNIC16YE+cbHJHPNu/c4YDbZVy3IUNY6KD30WhHEbKBSlM5rbTLB47ZgjxPx/zaNf5QJRhnuWV+98igZbC8Wrq0wMxz8JF+7F39OOUbMUKDW4V960oEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741984634; c=relaxed/simple;
	bh=pLogKHCK6/xqcLDL69+57MQERBAH4w9RM879vblarPg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QpOFquwoedT3N6oe47ZQ3ZJmENRxfzy6IBfoIKgLt/t/BMhUl+H2hCnWWetrI3Gie1g2Y5CrFD/FU1rUW02+hIj1ZZA6b+ur+mKqvNfhWNJer/bmPVHhaK+rMpLWG5QPk0yJXQMDNh8Qt8EuWuh2KaVDh28saJKYza6y785NdeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQANX0qK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741984633; x=1773520633;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pLogKHCK6/xqcLDL69+57MQERBAH4w9RM879vblarPg=;
  b=IQANX0qK0KPGTP0r7TrvPq7R0Jm6LEA/c9Pi392C8v71fqJde2SBNnUM
   oWIFmJYJpmFTKmjSkWbjZ03xUoIh60hdJxlYK6SPgPXRR7YoW3aopxU23
   DTVRy1ilneNqNXzugCMEyOVF1WSvgXf1G93IAecHQJW3pud8H8v3p/QE7
   GZM97836wp+Z3nQz7BuA6NrPixmuUYStoSpGdw823nyZ3JikB137IU3zs
   ZXBGvueixVAhrNXKjbnuXG8GKaz/t6zoWaGj94GthIS/akqFlpHZ+EaIg
   1UnCYV1NaP68dYmiZKcboiz0g3ZdaFf3peU5AgRo5n08+YyWGXXaQf0xC
   g==;
X-CSE-ConnectionGUID: SjIVEowkSGCWfQ2YQoaUYQ==
X-CSE-MsgGUID: AQrU+rz5RZKcM9wAcxuC6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43187563"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43187563"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 13:37:12 -0700
X-CSE-ConnectionGUID: meas/1QGQ66R85WAgFb4PQ==
X-CSE-MsgGUID: O4xvvHE/SpqHWFuEd5AW2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="122325334"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.212]) ([10.125.108.212])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 13:37:11 -0700
Message-ID: <c7f9151ecdd54340f5f059f0a791cc68b5048fc4.camel@linux.intel.com>
Subject: Re: [PATCH 1/9] mm: swap: rename
 __swap_[entry/entries]_free[_locked] to swap_[entry/entries]_put[_locked]
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org
Cc: kasong@tencent.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Fri, 14 Mar 2025 13:37:11 -0700
In-Reply-To: <20250313210515.9920-2-shikemeng@huaweicloud.com>
References: <20250313210515.9920-1-shikemeng@huaweicloud.com>
	 <20250313210515.9920-2-shikemeng@huaweicloud.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-14 at 05:05 +0800, Kemeng Shi wrote:
> In __swap_entry_free[_locked] and __swap_entries_free, we decrease count
> first and only free swap entry if count drops to zero. This behavior is
> more akin to a put() operation rather than a free() operation. Therefore,
> rename these functions with "put" instead of "free".
> Additionally, add "_nr" suffix to swap_entries_put to indicate the input
> range may span swap clusters.
>=20

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/swapfile.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 628f67974a7c..5a775456e26c 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1347,9 +1347,9 @@ static struct swap_info_struct *_swap_info_get(swp_=
entry_t entry)
>  	return NULL;
>  }
> =20
> -static unsigned char __swap_entry_free_locked(struct swap_info_struct *s=
i,
> -					      unsigned long offset,
> -					      unsigned char usage)
> +static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
> +					   unsigned long offset,
> +					   unsigned char usage)
>  {
>  	unsigned char count;
>  	unsigned char has_cache;
> @@ -1453,15 +1453,15 @@ struct swap_info_struct *get_swap_device(swp_entr=
y_t entry)
>  	return NULL;
>  }
> =20
> -static unsigned char __swap_entry_free(struct swap_info_struct *si,
> -				       swp_entry_t entry)
> +static unsigned char swap_entry_put(struct swap_info_struct *si,
> +				    swp_entry_t entry)
>  {
>  	struct swap_cluster_info *ci;
>  	unsigned long offset =3D swp_offset(entry);
>  	unsigned char usage;
> =20
>  	ci =3D lock_cluster(si, offset);
> -	usage =3D __swap_entry_free_locked(si, offset, 1);
> +	usage =3D swap_entry_put_locked(si, offset, 1);
>  	if (!usage)
>  		swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
>  	unlock_cluster(ci);
> @@ -1469,8 +1469,8 @@ static unsigned char __swap_entry_free(struct swap_=
info_struct *si,
>  	return usage;
>  }
> =20
> -static bool __swap_entries_free(struct swap_info_struct *si,
> -		swp_entry_t entry, int nr)
> +static bool swap_entries_put_nr(struct swap_info_struct *si,
> +				swp_entry_t entry, int nr)
>  {
>  	unsigned long offset =3D swp_offset(entry);
>  	unsigned int type =3D swp_type(entry);
> @@ -1501,7 +1501,7 @@ static bool __swap_entries_free(struct swap_info_st=
ruct *si,
>  fallback:
>  	for (i =3D 0; i < nr; i++) {
>  		if (data_race(si->swap_map[offset + i])) {
> -			count =3D __swap_entry_free(si, swp_entry(type, offset + i));
> +			count =3D swap_entry_put(si, swp_entry(type, offset + i));
>  			if (count =3D=3D SWAP_HAS_CACHE)
>  				has_cache =3D true;
>  		} else {
> @@ -1552,7 +1552,7 @@ static void cluster_swap_free_nr(struct swap_info_s=
truct *si,
> =20
>  	ci =3D lock_cluster(si, offset);
>  	do {
> -		if (!__swap_entry_free_locked(si, offset, usage))
> +		if (!swap_entry_put_locked(si, offset, usage))
>  			swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
>  	} while (++offset < end);
>  	unlock_cluster(ci);
> @@ -1599,7 +1599,7 @@ void put_swap_folio(struct folio *folio, swp_entry_=
t entry)
>  		swap_entry_range_free(si, ci, entry, size);
>  	else {
>  		for (int i =3D 0; i < size; i++, entry.val++) {
> -			if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE))
> +			if (!swap_entry_put_locked(si, offset + i, SWAP_HAS_CACHE))
>  				swap_entry_range_free(si, ci, entry, 1);
>  		}
>  	}
> @@ -1798,7 +1798,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int =
nr)
>  	/*
>  	 * First free all entries in the range.
>  	 */
> -	any_only_cache =3D __swap_entries_free(si, entry, nr);
> +	any_only_cache =3D swap_entries_put_nr(si, entry, nr);
> =20
>  	/*
>  	 * Short-circuit the below loop if none of the entries had their
> @@ -1811,7 +1811,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int =
nr)
>  	 * Now go back over the range trying to reclaim the swap cache. This is
>  	 * more efficient for large folios because we will only try to reclaim
>  	 * the swap once per folio in the common case. If we do
> -	 * __swap_entry_free() and __try_to_reclaim_swap() in the same loop, th=
e
> +	 * swap_entry_put() and __try_to_reclaim_swap() in the same loop, the
>  	 * latter will get a reference and lock the folio for every individual
>  	 * page but will only succeed once the swap slot for every subpage is
>  	 * zero.
> @@ -3758,7 +3758,7 @@ int add_swap_count_continuation(swp_entry_t entry, =
gfp_t gfp_mask)
>   * into, carry if so, or else fail until a new continuation page is allo=
cated;
>   * when the original swap_map count is decremented from 0 with continuat=
ion,
>   * borrow from the continuation and report whether it still holds more.
> - * Called while __swap_duplicate() or caller of __swap_entry_free_locked=
()
> + * Called while __swap_duplicate() or caller of swap_entry_put_locked()
>   * holds cluster lock.
>   */
>  static bool swap_count_continued(struct swap_info_struct *si,


