Return-Path: <linux-kernel+bounces-438117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5ED9E9D14
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E912164112
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0149A154BE2;
	Mon,  9 Dec 2024 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="rbVJR35w"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D614B97E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765331; cv=none; b=ZDu/kZ7QWk5sKjn9c4Xc2HgYHyoXj7GgFzA/ZxfbRh7+YSWrh7k2UvWlb5wbi6YHaiAhtLI1nJB51OdvtweA6oYU1V6gJXwIMW0zwiI83pvXxLki3Xy7DLyP4uHoeRUWsrbw7L7uDKo1QcYq8WvyupiMBXrONJIcKHRiZywNXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765331; c=relaxed/simple;
	bh=NOQvmRjMxuixDwXhq0ZtvQv1134vT7qqg7jES3HNwME=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dpnBS0xQnNQyRSI1WFKDyUt+tDGpx4P2UUPCI+uEjk6NIAkPjSv659aKttFm9vLQfodRgp/AxTZ72KC2scihRlZtlQLlIaV5k//upZAJu1i+nlTIfVmucne9Rt9AmKI1Q6W5i71BIVULBxY7fbygSr9MA5WTAOUv+lGMaL/xOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=rbVJR35w; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1733763904;
	bh=NOQvmRjMxuixDwXhq0ZtvQv1134vT7qqg7jES3HNwME=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=rbVJR35wrs+kQ237ujRbc5WO8rAh1S++7Ll7LqO0QvG4J9kx30dlHYLCWlZ9l8Ko0
	 ZU41JJrqsNP6C6YduE8yz18uNEwLp3+zD+ylA9UnkKNgO/jLPBw6Vr6DCXQU2/MAW+
	 mgDEYqiYbFZDyuPrMAOsJo0qxIM3O/9PHevDVczc=
Received: by gentwo.org (Postfix, from userid 1003)
	id 4EF3140737; Mon,  9 Dec 2024 09:05:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 4D5E54018F;
	Mon,  9 Dec 2024 09:05:04 -0800 (PST)
Date: Mon, 9 Dec 2024 09:05:04 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Huang Shijie <shijie@os.amperecomputing.com>
cc: catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com, 
    corbet@lwn.net, patches@amperecomputing.com, akpm@linux-foundation.org, 
    thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com, 
    ardb@kernel.org, inux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] arm64: refactor the rodata=xxx
In-Reply-To: <20241209072020.4743-2-shijie@os.amperecomputing.com>
Message-ID: <83d01335-c6be-d17b-511a-378ce3ad0663@gentwo.org>
References: <20241209072020.4743-1-shijie@os.amperecomputing.com> <20241209072020.4743-2-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 9 Dec 2024, Huang Shijie wrote:

> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5901,7 +5901,7 @@
>  	rodata=		[KNL,EARLY]
>  		on	Mark read-only kernel memory as read-only (default).
>  		off	Leave read-only kernel memory writable for debugging.
> -		full	Mark read-only kernel memory and aliases as read-only
> +		noalias	Use more block mappings,may have better performance.
>  		        [arm64]

Maybe use
		noalias Do not check aliases in order to allow larger kernel page
                        sizes on a platforms without FEAT_BBM2 support[arm64])

instead?

>
>  	rockchip.usb_uart
> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
> index ba269a7a3201..b3063326b79a 100644
> --- a/arch/arm64/include/asm/setup.h
> +++ b/arch/arm64/include/asm/setup.h
> @@ -13,6 +13,27 @@
>  extern phys_addr_t __fdt_pointer __initdata;
>  extern u64 __cacheline_aligned boot_args[4];
>
> +/*
> + * rodata=on (default):
> + *    Apply read-only attributes of VM areas to the linear alias of
> + *    the backing pages as well. This prevents code or read-only data
> + *    from being modified (inadvertently or intentionally) via another
> + *    mapping of the same memory page.
> + *
> + *    This requires the linear region to be mapped down to pages,
> + *    which may adversely affect performance in some cases.
> + *
> + * rodata=off:
> + *    It provides us more block mappings and contiguous hits
> + *    to map the linear region which minimize the TLB footprint.
> + *    Leave read-only kernel memory writable for debugging.
> + *
> + * rodata=noalias:
> + *    It provides us more block mappings and contiguous hits
> + *    to map the linear region which minimize the TLB footprint.
> + *    And the linear aliases of pages belonging to read-only mappings
> + *    in vmalloc region are also marked as read-only.
> + */
>  static inline bool arch_parse_debug_rodata(char *arg)
>  {
>  	extern bool rodata_enabled;
> @@ -21,7 +42,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
>  	if (!arg)
>  		return false;
>
> -	if (!strcmp(arg, "full")) {
> +	if (!strcmp(arg, "on")) {
>  		rodata_enabled = rodata_full = true;
>  		return true;
>  	}
> @@ -31,7 +52,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
>  		return true;
>  	}
>
> -	if (!strcmp(arg, "on")) {
> +	if (!strcmp(arg, "noalias")) {
>  		rodata_enabled = true;
>  		rodata_full = false;
>  		return true;
>

