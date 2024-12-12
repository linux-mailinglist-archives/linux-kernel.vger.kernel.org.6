Return-Path: <linux-kernel+bounces-443700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 951839EFAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABE2188E9F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6D5217F34;
	Thu, 12 Dec 2024 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+vW24Tv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9F1EEE6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027750; cv=none; b=YlzAIvemvq5UHa9OIVpnuF9k58hs5/WddNqAWjBinR+PigszSOBxCbDNVd4hUFRl46bI80Bn3cSVY/HrdYI/oWnzm8v5V8DoYvcfIMu9+aC40Fx2lbQJIwwp7xENpoywpy0mB72WDKaD+Yr1Zo9GVEbb+Hsj0Uo1jtMal4UVnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027750; c=relaxed/simple;
	bh=W32/9EAQGesfr3QL3U21E1evRxdxDgPi+y0FD7GYNg0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t9NKbA8f9DaGF99JXGvsah2X1K0XpF2DsD78ElwC6lKnq3uLJ8DHznmv0sYTqveFHmpkjHnSv9/akdlxLpz+jwznGfLXJwYobubZJs45MchiJ8zV2bOvpUF0tHBrgaG7M/V5gurQhf4woe2FHuEt2JHNUyNhjbr9naS6l3LDDck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+vW24Tv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734027749; x=1765563749;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=W32/9EAQGesfr3QL3U21E1evRxdxDgPi+y0FD7GYNg0=;
  b=S+vW24TvjqzkugEUcfCFgNwCfafmxEQAn1lYPaZEeGlqXmyTUIPG8FMK
   WwrwiryVBt91FwM5mDlppGIUqURX1v0BZiGsUuFjPTjNmKQOjX9sSYyOa
   ABdwuLxLSCeSs0+UGl/nuRnzWGwGG2Pef3Qqp+VX/bC2xx9o7lh/+SABK
   zh6oJTLoeYfRmzTGB4Qcn9qKOPbDyvbGhX6VckPau0LenIlg62HEIMMvo
   KM0EBcGPsdDlqkIuJCqZW2msNfi6f2gQfPV88Z+rsUyhiZi0pKruX4ZOq
   cMey7bT23lp3Pg/Ktmgn+ArWvU5/I/Jjk4J270buffP67tfb6quvenhwT
   g==;
X-CSE-ConnectionGUID: vzjmxaA7RWWse7w1Kzvlzg==
X-CSE-MsgGUID: 8VpwHlyNR0aZl2o/Z86BsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34337650"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="34337650"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 10:22:26 -0800
X-CSE-ConnectionGUID: a7ykPv8sSO+/kpMrU0MCFw==
X-CSE-MsgGUID: lfW4Ha90SCy0mLTLP3KFLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="101402157"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO [10.125.110.139]) ([10.125.110.139])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 10:22:25 -0800
Message-ID: <aec6094baa036188c4af0d13d5a3a61cbdb7d976.camel@linux.intel.com>
Subject: Re: [PATCH 2/8] x86/itmt: Use guard() for itmt_update_mutex
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>,  Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Mario Limonciello
 <mario.limonciello@amd.com>,  Meng Li <li.meng@amd.com>, Huang Rui
 <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Date: Thu, 12 Dec 2024 10:22:25 -0800
In-Reply-To: <20241211185552.4553-3-kprateek.nayak@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
	 <20241211185552.4553-3-kprateek.nayak@amd.com>
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

On Wed, 2024-12-11 at 18:55 +0000, K Prateek Nayak wrote:
> Use guard() for itmt_update_mutex which avoids the extra mutex_unlock()
> in the bailout and return paths.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

Tim

>=20
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  arch/x86/kernel/itmt.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
> index 28f449123d68..ee43d1bd41d0 100644
> --- a/arch/x86/kernel/itmt.c
> +++ b/arch/x86/kernel/itmt.c
> @@ -44,12 +44,10 @@ static int sched_itmt_update_handler(const struct ctl=
_table *table, int write,
>  	unsigned int old_sysctl;
>  	int ret;
> =20
> -	mutex_lock(&itmt_update_mutex);
> +	guard(mutex)(&itmt_update_mutex);
> =20
> -	if (!sched_itmt_capable) {
> -		mutex_unlock(&itmt_update_mutex);
> +	if (!sched_itmt_capable)
>  		return -EINVAL;
> -	}
> =20
>  	old_sysctl =3D sysctl_sched_itmt_enabled;
>  	ret =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> @@ -59,8 +57,6 @@ static int sched_itmt_update_handler(const struct ctl_t=
able *table, int write,
>  		rebuild_sched_domains();
>  	}
> =20
> -	mutex_unlock(&itmt_update_mutex);
> -
>  	return ret;
>  }
> =20
> @@ -97,18 +93,14 @@ static struct ctl_table_header *itmt_sysctl_header;
>   */
>  int sched_set_itmt_support(void)
>  {
> -	mutex_lock(&itmt_update_mutex);
> +	guard(mutex)(&itmt_update_mutex);
> =20
> -	if (sched_itmt_capable) {
> -		mutex_unlock(&itmt_update_mutex);
> +	if (sched_itmt_capable)
>  		return 0;
> -	}
> =20
>  	itmt_sysctl_header =3D register_sysctl("kernel", itmt_kern_table);
> -	if (!itmt_sysctl_header) {
> -		mutex_unlock(&itmt_update_mutex);
> +	if (!itmt_sysctl_header)
>  		return -ENOMEM;
> -	}
> =20
>  	sched_itmt_capable =3D true;
> =20
> @@ -117,8 +109,6 @@ int sched_set_itmt_support(void)
>  	x86_topology_update =3D true;
>  	rebuild_sched_domains();
> =20
> -	mutex_unlock(&itmt_update_mutex);
> -
>  	return 0;
>  }
> =20
> @@ -134,12 +124,11 @@ int sched_set_itmt_support(void)
>   */
>  void sched_clear_itmt_support(void)
>  {
> -	mutex_lock(&itmt_update_mutex);
> +	guard(mutex)(&itmt_update_mutex);
> =20
> -	if (!sched_itmt_capable) {
> -		mutex_unlock(&itmt_update_mutex);
> +	if (!sched_itmt_capable)
>  		return;
> -	}
> +
>  	sched_itmt_capable =3D false;
> =20
>  	if (itmt_sysctl_header) {
> @@ -153,8 +142,6 @@ void sched_clear_itmt_support(void)
>  		x86_topology_update =3D true;
>  		rebuild_sched_domains();
>  	}
> -
> -	mutex_unlock(&itmt_update_mutex);
>  }
> =20
>  int arch_asym_cpu_priority(int cpu)


