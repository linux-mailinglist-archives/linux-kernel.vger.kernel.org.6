Return-Path: <linux-kernel+bounces-562159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B873A61DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C0917C06E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA0D1C54AA;
	Fri, 14 Mar 2025 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjg8+95j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830C1957E4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986591; cv=none; b=XAT3DiwFXOvfM2tW0MxKU3qQ0F9pww2YNtoS98UCD/DnwZMeNGqjus6rPzUhVtn9SNNz1+Fbl5X7W9bOPmZGdx7/h4vB/zm5tr08baVtD196Cx6S4SxABPLt9hiHbOcXyxlpnXwmQc6YiDUDswelxsV6JA8BY1GYKYL7yxDJxXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986591; c=relaxed/simple;
	bh=XXQKZzpeQsVPULgRa91+jVxZbesblCs2/OJYhz+jCr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJaRAcAd/cSgWFV8oRVuTEOQcALOfh/NMe1fhRfOHIMwgqOAOxHMUZJlrV1EeZ35ZPu8CyzRMuUsuYbY/ajwsMLGoMB4aodxSKHyCBe5dBqMzfCRM8UWCVwlE+/5R/vJticPlXhjufkAs2klcBgRLGthg0vs5GguqKoo2YqjR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjg8+95j; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741986589; x=1773522589;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XXQKZzpeQsVPULgRa91+jVxZbesblCs2/OJYhz+jCr0=;
  b=fjg8+95jIPArD0b0c9ZgvsW41f0+AjWdw1LGJVd7bAYm04qzus6DQmHs
   /15b+E30l0zgvyeYy7JJ5e6R3Q/N/Ml6jGPVeyWLYiO9TE2ALLMFA1F3P
   6L4VZbANKiXzpcdb3HguTHiI+1njmTj1znVfHM8smRWzvGByz1xXE6K6W
   MTTgludqjwkhKuw5UNFoPEwpR1DVKpPmiWAw16ncW5d7S5RRee7zcsUU5
   PTFoNny9AdPdi+4MeaWc4fxr5tNxF+Nqt6kX4VtkVM3JHKkVVN1ADZnPu
   Hm2a0V+/3gC4Zfm7r3vWLSvpjDxsSpItHMpEkp7wlW1lDbzT7p1zDLna0
   Q==;
X-CSE-ConnectionGUID: HpzeCSxcQFmtOc+PPZFJTA==
X-CSE-MsgGUID: esiTMmjBR9+HXt+40kLQRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43358416"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43358416"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 14:09:49 -0700
X-CSE-ConnectionGUID: 3wpcDs1oTOeE+KZV1DRGnw==
X-CSE-MsgGUID: 8qPtg8DqQaadwOsnzF3rSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="122332839"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.212]) ([10.125.108.212])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 14:09:49 -0700
Message-ID: <8624268dd3a211e656b3fb179c46c1742fe80790.camel@linux.intel.com>
Subject: Re: [PATCH 4/9] mm: swap: remove unneeded VM_BUG_ON(*map !=
 SWAP_HAS_CACHE) in swap_entry_range_free()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org
Cc: kasong@tencent.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Fri, 14 Mar 2025 14:09:48 -0700
In-Reply-To: <20250313210515.9920-5-shikemeng@huaweicloud.com>
References: <20250313210515.9920-1-shikemeng@huaweicloud.com>
	 <20250313210515.9920-5-shikemeng@huaweicloud.com>
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
> As all callers of swap_entry_range_free() have already ensured slots to
> be freed are marked as SWAP_HAS_CACHE while holding the cluster lock,
> the BUG_ON check can be safely removed. After this, the function
> swap_entry_range_free() could drop any kind of last flag, rename it to
> swap_entries_free() and update it's comment accordingly.
>=20
> This is a preparation to use swap_entries_free() to drop last 1 and

Probably clearer to say=20
drop last ref count=20
instead or drop last 1

> SWAP_MAP_SHMEM flag.
>=20
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/swapfile.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index ba37b9bff586..14b7b37996ff 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -52,9 +52,9 @@
>  static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
>  				 unsigned char);
>  static void free_swap_count_continuations(struct swap_info_struct *);
> -static void swap_entry_range_free(struct swap_info_struct *si,
> -				  struct swap_cluster_info *ci,
> -				  swp_entry_t entry, unsigned int nr_pages);
> +static void swap_entries_free(struct swap_info_struct *si,
> +			      struct swap_cluster_info *ci,
> +			      swp_entry_t entry, unsigned int nr_pages);
>  static void swap_range_alloc(struct swap_info_struct *si,
>  			     unsigned int nr_entries);
>  static bool folio_swapcache_freeable(struct folio *folio);
> @@ -1511,7 +1511,7 @@ static bool swap_entries_put_nr(struct swap_info_st=
ruct *si,
>  	for (i =3D 0; i < nr; i++)
>  		WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
>  	if (!has_cache)
> -		swap_entry_range_free(si, ci, entry, nr);
> +		swap_entries_free(si, ci, entry, nr);
>  	unlock_cluster(ci);
> =20
>  	return has_cache;
> @@ -1530,12 +1530,12 @@ static bool swap_entries_put_nr(struct swap_info_=
struct *si,
>  }
> =20
>  /*
> - * Drop the last HAS_CACHE flag of swap entries, caller have to
> - * ensure all entries belong to the same cgroup.
> + * Drop the last flag(1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM) of swap entri=
es,
> + * caller have to ensure all entries belong to the same cgroup.

Will be nice to modify the above comment:=C2=A0
	all entries belong to the same cgroup and cluster.

Otherwise

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
=20
> =20
> -static void swap_entry_range_free(struct swap_info_struct *si,
> -				  struct swap_cluster_info *ci,
> -				  swp_entry_t entry, unsigned int nr_pages)
> +static void swap_entries_free(struct swap_info_struct *si,
> +			      struct swap_cluster_info *ci,
> +			      swp_entry_t entry, unsigned int nr_pages)
>  {
>  	unsigned long offset =3D swp_offset(entry);
>  	unsigned char *map =3D si->swap_map + offset;
> @@ -1545,7 +1545,6 @@ static void swap_entry_range_free(struct swap_info_=
struct *si,
>  	VM_BUG_ON(ci !=3D offset_to_cluster(si, offset + nr_pages - 1));
> =20
>  	do {
> -		VM_BUG_ON(*map !=3D SWAP_HAS_CACHE);
>  		*map =3D 0;
>  	} while (++map < map_end);
> =20
> @@ -1605,7 +1604,7 @@ void put_swap_folio(struct folio *folio, swp_entry_=
t entry)
> =20
>  	ci =3D lock_cluster(si, offset);
>  	if (swap_only_has_cache(si, offset, size))
> -		swap_entry_range_free(si, ci, entry, size);
> +		swap_entries_free(si, ci, entry, size);
>  	else
>  		for (int i =3D 0; i < size; i++, entry.val++)
>  			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);


