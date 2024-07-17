Return-Path: <linux-kernel+bounces-255230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783CD933DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FDB283B20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB2E180A6C;
	Wed, 17 Jul 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lu3BMKxy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7EE1802D7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223537; cv=none; b=jxBMDjCm4vp3FVuoe+HkUO/J/nD3bMvIp2Cn1Y+AwmX8PuEtOea2rVs2NKmGlDHKXYjIbEQezrfzmgA7H/YiGDfEjxPNMDt0v0Q6HOEuCpLVcAdoZjbsPSeJSDRATHIeph1EId7ombaZyrLXN9UqjIE7ej/7nI7e5XV4vPmyY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223537; c=relaxed/simple;
	bh=UrG9HhLoZttwlCzlipmfOBclufn9SoIbsK6OOwLuBg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVlEPjpD8M8yk7M8UrPdIlLYTKoRFp4ngme+WJ7v7wTrBiYasIKHvX9cNBEWEPr06A12u0UfpEfMWZCqVqffNq6eZf7JHYf6UPa9YEoQBaMw1/ka6jEJdacg37JS+ocrX8wD7df4nrS5T/G5i/DXiJXRHcb6+2Vscsb4Dgqu6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lu3BMKxy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721223534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhY47IaT+xpjtEKrUmqTs+3xE4CAdxaNkPoUu1I3NaY=;
	b=Lu3BMKxyqKemF0soOcF+0aXT2rtgRtU0w4dQQI2WaKhCYVE1sdWIOWd/Z73EtY0Oi1Rjea
	0GMN0H/XFBYZ5OTkeJ0HklwJQOlqdwLrokakbkRc8fXaMhvgeFhMOU9NsIyJHMGjp1zNEu
	KZqwWWV4aEwj6DI8IUsb0Ge52EQGjGE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-MIIcWOCHNZ6I6qR8600WxQ-1; Wed,
 17 Jul 2024 09:38:51 -0400
X-MC-Unique: MIIcWOCHNZ6I6qR8600WxQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02D2B1955EA7;
	Wed, 17 Jul 2024 13:38:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.209])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1210C1955F3B;
	Wed, 17 Jul 2024 13:38:47 +0000 (UTC)
Date: Wed, 17 Jul 2024 21:38:41 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, akpm@linux-foundation.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crash: fix x86_32 memory reserve dead loop retry
 bug at "high"
Message-ID: <ZpfJYcjZ0QmFUpPf@MiWiFi-R3L-srv>
References: <20240717070904.2671147-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717070904.2671147-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/17/24 at 03:09pm, Jinjie Ruan wrote:
> Similar to commit 8f9dade5906a ("crash: fix x86_32 memory reserve dead loop
> retry bug") and in the symmetry case, on x86_32 Qemu machine with
> 1GB memory, the cmdline "crashkernel=512M" will also cause system stall
> as below:
> 
> 	ACPI: Reserving FACP table memory at [mem 0x3ffe18b8-0x3ffe192b]
> 	ACPI: Reserving DSDT table memory at [mem 0x3ffe0040-0x3ffe18b7]
> 	ACPI: Reserving FACS table memory at [mem 0x3ffe0000-0x3ffe003f]
> 	ACPI: Reserving APIC table memory at [mem 0x3ffe192c-0x3ffe19bb]
> 	ACPI: Reserving HPET table memory at [mem 0x3ffe19bc-0x3ffe19f3]
> 	ACPI: Reserving WAET table memory at [mem 0x3ffe19f4-0x3ffe1a1b]
> 	143MB HIGHMEM available.
> 	879MB LOWMEM available.
> 	  mapped low ram: 0 - 36ffe000
> 	  low ram: 0 - 36ffe000
> 	  (stall here)
> 
> The reason is that the CRASH_ADDR_LOW_MAX is equal to CRASH_ADDR_HIGH_MAX
> on x86_32, the first "low" crash kernel memory reservation for 512M fails,
> then it go into the "retry" loop and never came out as below (consider
> CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX = 512M):
> 
> -> reserve_crashkernel_generic() and high is false
>    -> alloc at [0, 0x20000000] fail
>       -> alloc at [0x20000000, 0x20000000] fail and repeatedly
>       (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
> 
> Fix it by also changing the another out check condition, the fixed base
> situation has no problem because it warn out if it fail to alloc.
> 
> After this patch, it prints:
> 	cannot allocate crashkernel (size:0x20000000)
> 
> Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/crash_reserve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 03e455738e75..36c13cf942f4 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -409,7 +409,7 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  		 * low memory, fall back to high memory, the minimum required
>  		 * low memory will be reserved later.
>  		 */
> -		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
> +		if (!high && !search_base) {

Hmm, this may not be good. We can't guarantee that CRASH_ADDR_LOW_MAX must
not be 0. I still suggest you testing below draft patch to see if it works
well. And we should revert the patch in Andrew's tree since it's not good.
Posting like these mess will confuse people and add difficulty when
backporting.

You haven't responded to my earlier request to test those two draft
patches. When you tested below code and it's good, you can post this as
a formal patch. So my suggestion to the whole work is:

1) revert commit 8f9dade5906a in Andrew's tree;

2) post two patches I suggested to prevert crashkernel=,high for 32bit
system, and fix the issue you found;

3) post patchset to make arm32 use generic crashkernel reservation.

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..ac087ba442cd 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -414,7 +414,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 			search_end = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-			goto retry;
+			if (search_base != search_end)
+				goto retry;
 		}
 
 		/*


