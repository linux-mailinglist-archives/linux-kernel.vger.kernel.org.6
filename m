Return-Path: <linux-kernel+bounces-564900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A759A65C78
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AB61898874
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8731B4240;
	Mon, 17 Mar 2025 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bl92vVTI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F419048F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235832; cv=none; b=qF95w7pRXpcfjLASbISs6+Otlxp8cbkyQXuNa0TuOVEa44FdcbV2HCzPdM6Ud3KLeqlpa8rGWq/ED8p+8pv/q8Ofq/9Qo4qlpvw4fxRHnHTtNhoRYItCDArcHrq8tbdEGYPep3UmG+zg8M09OdS3MDub6XoDETsbAgBALgR/rAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235832; c=relaxed/simple;
	bh=Jk/K6zIn9osKO3C+0ens+03myrUFYSybl0/ovakDeFI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ys3BXICyDY6lzEBnLv1zKZxmWuEUIIEDJGzByARc9i/y5P8ubrxaxTx1+2s3a3fmq+vL9R2b6VWKpJ4SzhtgGleY6Eq3TDdZXZe2BymqiBwQ0aSVf52YLAL3zKtMp9Fa6vjfRAm2sv+wqquZR4YOLlvNid1/bi4py62pgXTxI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bl92vVTI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742235830; x=1773771830;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Jk/K6zIn9osKO3C+0ens+03myrUFYSybl0/ovakDeFI=;
  b=bl92vVTISDRGtSF+mseJZs2jUXd5KKtg4YWlpZTeesPEig8Hb0CDAFHd
   TXw0MZmElfqq2+Or2jzw+I89r2D3bD1JhSwHGCpgT+dW9WZuCAebfYrw2
   vySKrrTaXkfwMHgAZVpcKpaF3t5UIR9OZWuz+H3CyeDNfEJE3TBVcQWwT
   rMO/SKL7xCd+LB7cBnmSDPTP6vy7edAOh3BuB8QKry6D4MqJ/4kJZ8W+p
   bE0yUivDreI+8fghyU/tFz91Ze66wzhQgY1mVkLgnZWennwwavcwG9wGw
   QEWYbf+ti8bMHi4silVljQotMNpsbPGYU1cqg3JOoqmRQDsWT4XrIiHBW
   Q==;
X-CSE-ConnectionGUID: QcVchqkZQ+i2t7fTg1VcJQ==
X-CSE-MsgGUID: yf8HmCvvQWWYRJqVkvja4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54723352"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="54723352"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:23:49 -0700
X-CSE-ConnectionGUID: UokWbO1ySKKkZTwpyn9/KQ==
X-CSE-MsgGUID: u5JgGuMDSKW0GNrBjc3p/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="121752137"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.110]) ([10.125.109.110])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:23:50 -0700
Message-ID: <754b55926794f41f0c064be98c74b89abff1172c.camel@linux.intel.com>
Subject: Re: [PATCH 9/9] mm: swap: replace cluster_swap_free_nr() with
 swap_entries_put_[map/cache]()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org
Cc: kasong@tencent.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Mar 2025 11:23:49 -0700
In-Reply-To: <20250313210515.9920-10-shikemeng@huaweicloud.com>
References: <20250313210515.9920-1-shikemeng@huaweicloud.com>
	 <20250313210515.9920-10-shikemeng@huaweicloud.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBE6N6zwBCADFoM9QBP6fLqfYine5oPRtaUK2xQavcYT34CBnjTlhbvEVMTPlNNzE5v04Kagcvg5wYcGwr3gO8PcEKieftO+XrzAmR1t3PKxlMT1bsQdTOhKeziZxh23N+kmA7sO/jnu/X2AnfSBBw89VGLN5fw9DpjvU4681lTCjcMgY9KuqaC/6sMbAp8uzdlue7KEl3/D3mzsSl85S9Mk8KTLMLb01ILVisM6z4Ns/X0BajqdD0IEQ8vLdHODHuDMwV3veAfnK5G7zPYbQUsK4+te32ruooQFWd/iqRf815j6/sFXNVP/GY4EWT08UB129Kzcxgj2TEixe675Nr/hKTUVKM/NrABEBAAGJAS4EIAECABgFAk6ONYoRHQFLZXkgaXMgcmVwbGFjZWQACgkQHH3vaoxLv2UmbAgAsqa+EKk2yrDc1dEXbZBBGeCiVPXkP7iajI/FiMVZHFQpme4vpntWhg0BIKnF0OSyv0wgn3wzBWx0Zh3cve/PICIj268QvXkb0ykVcIoRnWwBeavO4dd304Mzhz5fBzJwjYx06oabgUmeGawVCEq7UfXy+PsdQdoTabsuD1jq0MbOL/4sB6CZc4V2mQbW4+Js670/sAZSMj0SQzK9CQyQdg6Wivz8GgTBjWwWsfMt4g2u0s6rtBo8NUZG/yw6fNdaoDaT/OCHuBopGmsmFXInigwOXsjyp15Yqs/de3S2Nu5NdjJUwmN1Qd1bXEc/ItvnrFB0RgoNt2gzf25aPifLabQlVGltIENoZW4gPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPokBOAQTAQIAIgUCTo3rPAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQHH3vaoxLv2XYdAf8DgRO4eIAtWZy4zLv0EZHWiJ35GYAQ5fPFWBoNURE0+vICrvLyfCKTlUTFxFxTiAWHUO7JM+uBHQSJVsE+ERmTPsiU
	O1m7SxZakGy9U2WOEiWMZMRp7HZE8vPUY5AM1OD0b38WBeUD3FPx5WRlQ0z6izF9aIHxoQhci0/WtmGLOPw3HUlCy1c4DDl6cInpy/JqUPcYlvsp+bWbdm7R5b33WW2CNVVr1eLj+1UP0Iow4jlLzNLW+jOpivLDs3G/bNC1Uu/SAzTvbaDBRRO9ToX5rlg3Zi8PmOUXWzEfO6N+L1gFCAdYEB4oSOghSbk2xCC4DRlUTlYoTJCRsjusXEy4bkBDQROjes8AQgAzuAQ5rF4/ZYaklzSXjXERiX0y1zBYmcYd2xVOKf50gh8IYv8allShkQ8mAalwIwyxTY+1k72GNCZIRVILSsuQY6fLmPUciuCk/X1y4oLNsF/Np8M9xxwYwqUibUwRdWwpSG2V0bcqjtUH1akaoY758wLONUmXrlfVonCfENd0aiP+ZLxYE1d1CRPv4KbAZ6z6seQCEQrappE4YXIC9yJUqT076DD1RhPmwNbNTTAauuwG+vX+jWsc5hUaHbKsAf/Rsw13+RA3dzWekbeIxO9qvQoQ26oqKEA31mxWhwNDnkTeo07+e2EGC2BV6s+sU1/m/lup5Bj34JLP7qYtd6EswARAQABiQEeBBgBAgAJBQJOjes8AhsMAAoJEBx972qMS79lYmQH+I4qdFm8wlkh/ZVWNJMSpfUfupuLPZ0g0hxNr3l2ZltEskVl5w+wJV+hBZ7zMmSxMYvMjJ+5aBDSZOfzhnK6+ETl4e/heDYiBLPYCtvU88cMRFb3jKcVxSfSzbBawEr7OFfCny3UtmYQ0PJmHFT6p+wlEHSyKxtyDDlLS/uPPR/llK94fOhvQlX8dir9b8r7JGuFTjtG2YbsTuapi3sFDmBhFZwYcNMt80FSIXGQjJzrsl1ZVSIwmqlF2191+F/Gr0Ld92dz1oEOjwKH1oRb/0MTsNU7udZv7L8iGKWCjHnA0dIoXKilf8EJyXGQ0wjQE3WBAdMecbvSKDRA7k
	9a75kCDQROjjboARAAtXPJWkNkK3s22BXrcK8w9L/Kzqmp4+V9Y5MkkK94Zv66lXAybnXH3UjL9ATQgo7dnaHxcVX0S9BvHkEeKqEoMwxg86Bb2tzY0yf9+E5SvTDKLi2O1+cd7F3Wba1eM4Shr90bdqLHwEXR90A6E1B7o4UMZXD5O3MI013uKN2hyBW3CAVJsYaj2s9wDH3Qqm4Xe7lnvTAGV+zPb5Oj26MjuD4GUQLOZVkaA+GX0TrUlYl+PShJDuwQwpWnFbDgyE6YmlrWVQ8ZGFF/w/TsRgJMZqqwsWccWRw0KLNUp0tPGig9ECE5vy1kLcMdctD+BhjF0ZSAEBOKyuvQQ780miweOaaTsADu5MPGkd3rv7FvKdNencd+G1BRU8GyCyRb2s6b0SJnY5mRnE3L0XfEIJoTVeSDchsLXwPLJy+Fdd2mTWQPXlnforgfKmX6BYsgHhzVsy1/zKIvIQey8RbhBp728WAckUvN47MYx9gXePW04lzrAGP2Mho+oJfCpI0myjpI9CEctvJy4rBXRgb4HkK72i2gNOlXsabZqy46dULcnrMOsyCXj6B1CJiZbYz4xb8n5LiD31SAfO5LpKQe/G4UkQOZgt+uS7C0Zfp61+0mrhKPG+zF9Km1vaYNH8LIsggitIqE05uCFi9sIgwez3oiUrFYgTkTSqMQNPdweNgVhSUAEQEAAbQ0VGltIENoZW4gKHdvcmsgcmVsYXRlZCkgPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPokCVQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQTRofI2lb24ozcpAhyiZ7WKota4SQUCYjOVvwUJF2fF1wAKCRCiZ7WKota4SeetD/4hztE+L/Z6oqIYlJJGgS9gjV7c08YH/jOsiX99yEmZC/BApyEpqCIs+RUYl12hwVUJc++sOm/p3d31iXvgddXGYxim00+DIhIu6sJ
	aDzohXRm8vuB/+M/Hulv+hTjSTLreAZ9w9eYyqffre5AlEk/hczLIsAsYRsqyYZgjfXLk5JN0L7ixsoDRQ5syZaY11zvo3LZJX9lTw0VPWlGeCxbjpoQK91CRXe9dx/xH/F/9F203ww3Ggt4VlV6ZNdl14YWGfhsiJU2rbeJ930sUDbMPJqV60aitI93LickNG8TOLG5QbN9FzrOkMyWcWW7FoXwTzxRYNcMqNVQbWjRMqUnN6PXCIvutFLjLF6FBe1jpk7ITlkS1FvA2rcDroRTU/FZRnM1k0K4GYYYPj11Zt3ZBcPoI0J3Jz6P5h6fJioqlhvZiaNhYneMmfvZAWJ0yv+2c5tp2aBmKsjmnWecqvHL5r/bXeziKRdcWyXqrEEj6OaJr3S4C0MIgGLteARvbMH+3tNTDIqFuyqdzHLKwEHuvKxHzYFyV7I5ZEQ2HGH5ZRZ2lRpVjSIlnD4L1PS6Bes+ALDrWqksbEuuk+ixFKKFyIsntIM+qsjkXseuMSIG5ADYfTla9Pc5fVpWBKX/j0MXxdQsxT6tiwE7P+osbOMwQ6Ja5Qi57hj8jBRF1znDjDZkBDQRcCwpgAQgAl12VXmQ1X9VBCMC+eTaB0EYZlzDFrW0GVmi1ii4UWLzPo0LqIMYksB23v5EHjPvLvW/su4HRqgSXgJmNwJbD4bm1olBeecIxXp6/S6VhD7jOfi4HACih6lnswXXwatzl13OrmK6i82bufaXFFIPmd7x7oz5Fuf9OQlLOnhbKXB/bBSHXRrMCzKUJKRia7XQx4gGe+AT6JxEj6YSvRT6Ik/RHpS/QpuOXcziNHhcRPD/ZfHqJSEa851yA1J3Qvx1KQK6t5I4hgp7zi3IRE0eiObycHJgT7nf/lrdAEs7wrSOqIx5/mZ5eoKlcaFXiKJ3E0Wox6bwiBQXrAQ/2yxBxVwARAQABtCVUaW0gQ2hlbiA8dGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb20+
	iQFUBBMBCAA+FiEEEsKdz9s94XWwiuG96lQbuGeTCYsFAlwLCmACGwMFCQHhM4AFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQ6lQbuGeTCYuQiQf9G2lkrkRdLjXehwCl+k5zBkn8MfUPi2ItU2QDcBit/YyaZpNlSuh8h30gihp5Dlb9BnqBVKxooeIVKSKC1HFeG0AE28TvgCgEK8qP/LXaSzGvnudek2zxWtcsomqUftUWKvoDRi1AAWrPQmviNGZ4caMd4itKWf1sxzuH1qF5+me6eFaqhbIg4k+6C5fk3oDBhg0zr0gLm5GRxK/lJtTNGpwsSwIJLtTI3zEdmNjW8bb/XKszf1ufy19maGXB3h6tA9TTHOFnktmDoWJCq9/OgQS0s2D7W7f/Pw3sKQghazRy9NqeMbRfHrLq27+Eb3Nt5PyiQuTE8JeAima7w98quQ==
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
> Replace cluster_swap_free_nr() with swap_entries_put_[map/cache]() to
> remove repeat code and leverage batch-remove for entries with last flag.
>=20
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/swapfile.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
>=20
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 343b34eb2a81..c27cf09d84a6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1570,21 +1570,6 @@ static void swap_entries_free(struct swap_info_str=
uct *si,
>  	__swap_entries_free(si, ci, entry, nr_pages);
>  }
> =20
> -static void cluster_swap_free_nr(struct swap_info_struct *si,
> -		unsigned long offset, int nr_pages,
> -		unsigned char usage)
> -{
> -	struct swap_cluster_info *ci;
> -	unsigned long end =3D offset + nr_pages;
> -
> -	ci =3D lock_cluster(si, offset);
> -	do {
> -		swap_entry_put_locked(si, ci, swp_entry(si->type, offset),
> -				      usage);
> -	} while (++offset < end);
> -	unlock_cluster(ci);
> -}
> -
>  /*
>   * Caller has made sure that the swap device corresponding to entry
>   * is still around or has not been recycled.
> @@ -1601,7 +1586,7 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
> =20
>  	while (nr_pages) {
>  		nr =3D min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUST=
ER);
> -		cluster_swap_free_nr(sis, offset, nr, 1);
> +		swap_entries_put_map(sis, swp_entry(sis->type, offset), nr);
>  		offset +=3D nr;
>  		nr_pages -=3D nr;
>  	}
> @@ -3632,9 +3617,7 @@ int swapcache_prepare(swp_entry_t entry, int nr)
> =20
>  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int=
 nr)
>  {
> -	unsigned long offset =3D swp_offset(entry);
> -
> -	cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
> +	swap_entries_put_cache(si, entry, nr);


swap_entries_put_cache() assumes nr does not cross cluster boundary
as we only lock the cluster associated with the beginning entry.

Current callers to swapcache_clear() like
do_swap_page() and shmem_swapin_folio, call swapcache_clear()
only for pages within a folio so we do fall in a cluster so
we are okay.

Perhaps we should document with a comment that
caller to swapcache_clear() should use the function only for pages in
a folio so the pages don't cross clusters for future users
of swapcache_clear().

Otherwise the patch looks good.

Tim

>  }
> =20
>  struct swap_info_struct *swp_swap_info(swp_entry_t entry)


