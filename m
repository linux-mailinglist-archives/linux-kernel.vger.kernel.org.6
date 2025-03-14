Return-Path: <linux-kernel+bounces-562144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1748AA61D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538548835D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A51C6FFE;
	Fri, 14 Mar 2025 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwFgvqwL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215D192B65
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985955; cv=none; b=GzoBszcHC+q3OxhZX4HH7tV/gnDWLJVGS1w/LCEh+ryAKPUDE7lYu5B9Jj5nQl1qOm4CmMRO2j/XjL+TxHE9fnKtvrOuRF7BlSKAaBEt3viosGUsbuNKZz1GphqrU7RPM16GZ8EuWT4wlBcXy+aN5ifWGFI+wygn7QxeQwI1UDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985955; c=relaxed/simple;
	bh=z83EAHMFcJLgQK9VMhek2zqqvkpi2j4qagy4Ic+bQMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KpfnXD7h9Wg4D2lcFQU7cp21HTmN7mdodZ4+kccVxSilSHSnHixh0ljvTFJgYLfLvbCyrlr2iNgDkN2BCw3uYoxZAjDLjcsuaXpFOYtU3tMUW0wGHHU4hUc/hTkKQ6S9qe6o478gxD+Vo/lWYzPwhorXhOH9gTIsdYmYu69DO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwFgvqwL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741985954; x=1773521954;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=z83EAHMFcJLgQK9VMhek2zqqvkpi2j4qagy4Ic+bQMU=;
  b=cwFgvqwLzB2rNnmXOJB2PVXjyJR7azx/sq5bLOG+r9g9EX9FJTzemmup
   AVmy+qfHmhbOjqSMELkkMs+An61dqitriTZ66CXuKKDabESE/6A2kaNDg
   XItkfKF8baWwjN49o5CZcqE7gATS4UZAYzrwFXfd0O5CRVXKJwlzs/NuX
   gzO/kPnG/o8IrHSzoJMncW9TS3ElbiavAK9V6QjFGtCyi8xR3HQSX5YKL
   xA4h2LBftsHgmiR62pp/m6Fd0GHHPjtI7SL6Y50LeoY6RbT9/tTKRvg42
   VyYhnQCVtOsiz/eL+T0ojPXmshMTEXtP5fH4MI0xIO4dFdCxalA/stpib
   w==;
X-CSE-ConnectionGUID: /w63He4OToG90tGhTnK59Q==
X-CSE-MsgGUID: yTxfEpNTRGaAM/1+EiaWyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="53788814"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="53788814"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 13:59:09 -0700
X-CSE-ConnectionGUID: 1P7Ir1TFRsuYuBMXsMferg==
X-CSE-MsgGUID: Yt+lwfAkTn2T1zk115NwRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152323658"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.212]) ([10.125.108.212])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 13:59:08 -0700
Message-ID: <4edca674b2460b18748251b984b722803a9706f2.camel@linux.intel.com>
Subject: Re: [PATCH 3/9] mm: swap: use __swap_entry_free() to free swap
 entry in swap_entry_put_locked()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org
Cc: kasong@tencent.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Fri, 14 Mar 2025 13:59:07 -0700
In-Reply-To: <20250313210515.9920-4-shikemeng@huaweicloud.com>
References: <20250313210515.9920-1-shikemeng@huaweicloud.com>
	 <20250313210515.9920-4-shikemeng@huaweicloud.com>
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
> In swap_entry_put_locked(), we will set slot to SWAP_HAS_CACHE before
> using swap_entry_range_free to do actual swap entry freeing. This
> introduce an unnecessary intermediate state.
> By using __swap_entry_free() in swap_entry_put_locked(), we can eliminate
> the need to set slot to SWAP_HAS_CACHE.
> This change would make the behavior of swap_entry_put_locked() more
> consistent with other put() operations which will do actual free work
> after put last reference.
>=20
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

> ---
>  mm/swapfile.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>=20
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 7c886f9dd6f9..ba37b9bff586 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1367,9 +1367,11 @@ static inline void __swap_entries_free(struct swap=
_info_struct *si,
>  }
> =20
>  static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
> -					   unsigned long offset,
> +					   struct swap_cluster_info *ci,
> +					   swp_entry_t entry,
>  					   unsigned char usage)
>  {
> +	unsigned long offset =3D swp_offset(entry);
>  	unsigned char count;
>  	unsigned char has_cache;
> =20
> @@ -1398,10 +1400,9 @@ static unsigned char swap_entry_put_locked(struct =
swap_info_struct *si,
>  	}
> =20
>  	usage =3D count | has_cache;
> -	if (usage)
> -		WRITE_ONCE(si->swap_map[offset], usage);
> -	else
> -		WRITE_ONCE(si->swap_map[offset], SWAP_HAS_CACHE);
> +	WRITE_ONCE(si->swap_map[offset], usage);
> +	if (!usage)
> +		__swap_entries_free(si, ci, entry, 1);
> =20
>  	return usage;
>  }
> @@ -1480,9 +1481,7 @@ static unsigned char swap_entry_put(struct swap_inf=
o_struct *si,
>  	unsigned char usage;
> =20
>  	ci =3D lock_cluster(si, offset);
> -	usage =3D swap_entry_put_locked(si, offset, 1);
> -	if (!usage)
> -		swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
> +	usage =3D swap_entry_put_locked(si, ci, entry, 1);
>  	unlock_cluster(ci);
> =20
>  	return usage;
> @@ -1562,8 +1561,8 @@ static void cluster_swap_free_nr(struct swap_info_s=
truct *si,
> =20
>  	ci =3D lock_cluster(si, offset);
>  	do {
> -		if (!swap_entry_put_locked(si, offset, usage))
> -			swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
> +		swap_entry_put_locked(si, ci, swp_entry(si->type, offset),
> +				      usage);
>  	} while (++offset < end);
>  	unlock_cluster(ci);
>  }
> @@ -1607,12 +1606,9 @@ void put_swap_folio(struct folio *folio, swp_entry=
_t entry)
>  	ci =3D lock_cluster(si, offset);
>  	if (swap_only_has_cache(si, offset, size))
>  		swap_entry_range_free(si, ci, entry, size);
> -	else {
> -		for (int i =3D 0; i < size; i++, entry.val++) {
> -			if (!swap_entry_put_locked(si, offset + i, SWAP_HAS_CACHE))
> -				swap_entry_range_free(si, ci, entry, 1);
> -		}
> -	}
> +	else
> +		for (int i =3D 0; i < size; i++, entry.val++)
> +			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
>  	unlock_cluster(ci);
>  }
> =20


