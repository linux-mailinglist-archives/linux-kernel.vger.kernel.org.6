Return-Path: <linux-kernel+bounces-267673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF2194142A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DE32863DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1531AAE39;
	Tue, 30 Jul 2024 14:15:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C31AAE32
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348927; cv=none; b=YU2R6whwa8a7pMT0AzHAqYb2kuA2wTpp2iN/ervRf0kKnUOE3q00KOioKnwejUowDR3oYwOEFpD/4smMO4+25dYO7eBz4gUQW6N4pgRs+hXsjCbc0YE5Qid7Zl6U7vAnPOfe/CfgnVtniACRCJ8y1NDxBgoH7aTJcAo4fZaUrZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348927; c=relaxed/simple;
	bh=x/qwv8P+XpwLHi5ILoq4CyLpPvPRoct675sdkGxWgeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYySOR/CL89QI6y27ysOgQWFyDjTGKdsmm3GgSqmtkLdpGUKH0udw7JKg0HAD28TjCxO1XNlJKw1rc8bn647EfhpkprZxRnLnFnC487nz9XMpAGfDjW/WCY/2DhSTsOXqU/CHhNr93G1uax7xfLggqRsHrKoanJGB4Y5JF/Uivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10A0C4AF0A;
	Tue, 30 Jul 2024 14:15:22 +0000 (UTC)
Date: Tue, 30 Jul 2024 15:15:20 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
	Chen Jun <chenjun102@huawei.com>,
	Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	kernel@openvz.org
Subject: Re: [PATCH 1/2] kmemleak: enable tracking for percpu pointers
Message-ID: <Zqj1eByCCStxAKNJ@arm.com>
References: <20240725041223.872472-1-ptikhomirov@virtuozzo.com>
 <20240725041223.872472-2-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725041223.872472-2-ptikhomirov@virtuozzo.com>

Hi Pavel,

On Thu, Jul 25, 2024 at 12:12:15PM +0800, Pavel Tikhomirov wrote:
> @@ -1308,12 +1319,23 @@ static bool update_checksum(struct kmemleak_object *object)
>  {
>  	u32 old_csum = object->checksum;
>  
> -	if (WARN_ON_ONCE(object->flags & (OBJECT_PHYS | OBJECT_PERCPU)))
> +	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
>  		return false;
>  
>  	kasan_disable_current();
>  	kcsan_disable_current();
> -	object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
> +	if (object->flags & OBJECT_PERCPU) {
> +		unsigned int cpu;
> +
> +		object->checksum = 0;
> +		for_each_possible_cpu(cpu) {
> +			void *ptr = per_cpu_ptr((void __percpu *)object->pointer, cpu);
> +
> +			object->checksum ^= crc32(0, kasan_reset_tag((void *)ptr), object->size);
> +		}

Slight worry this may take too long for large-ish objects with a large
number of CPUs. But we can revisit if anyone complains.

> +	} else {
> +		object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
> +	}
>  	kasan_enable_current();
>  	kcsan_enable_current();
>  
> @@ -1365,6 +1387,64 @@ static int scan_should_stop(void)
>  	return 0;
>  }
>  
> +static void scan_pointer(struct kmemleak_object *scanned,
> +			 unsigned long pointer, unsigned int objflags)

Nitpick: I'd have called this lookup_pointer or something like that.
When I first saw it, I tried to figure out why it doesn't have a size
argument but it became clear that it's not actually scanning/reading the
location at 'pointer' but simply looking the value up in various trees.
Up to you if you want to change the name to something else. The patch
looks good.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

-- 
Catalin

