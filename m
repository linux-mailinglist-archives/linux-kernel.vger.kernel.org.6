Return-Path: <linux-kernel+bounces-284039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1260B94FC43
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415CC1C223D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C17E1CD02;
	Tue, 13 Aug 2024 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQx5cs6Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D438156E4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723519928; cv=none; b=aqaPiltCiLMD+Ayu2vQOKo/imvCBae9QlQT5BwjChyu3qbTy5e8HlW0nwKf8iDWxVJ9dV2FTxS7inkSY5EIyhLCVnpVOvBGnDZsBMQ8oEgCGeJI5aJa4NZZyoCpPS/OZrQ2GSOsU1j++Y1t0Y1DZQ3d4UqiC2C+1jHKch3l0nDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723519928; c=relaxed/simple;
	bh=spn90IPx5cpLGfgUiLiG2s7cOO+gsANxV3/ZSY81rrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQiBZqcVvqqIcY7Q4VGoeKhc3TKQw3R1kaB0ta6NalsgOk7FrAQQZ4Z5gRoCyEJvbZ1l7juJ0cUho2Ii+1NsYNZOoKZOQCN6ItEsWUQWd9QWN6kbg+lT44qdUYr/H6S06e0yk+PHGvUtkb5vlYYZEY5ibQLa/woniAuyJkjJo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQx5cs6Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723519925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ImjO3P8y5HQjjz6vvHUXt04IUaXtaxVKMc6ROVHnaII=;
	b=KQx5cs6QJz1fARTrU4YcFRMnXVW6x+ovLf6IRzuP7kqHqWZhuFk5kYfStnxxYTPFg/j5Oj
	QoTp9+vmZ7rfu/ubSmWrQo3WffE3AyZwT0O2r13cKbIQvJBRQ8AhFCcofTOmJ89Ocb0LqI
	gQ2TwHt/MzVPKBjX269jLN6pWcl+evg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-9qR12zzKML6SmeAHm7fOZg-1; Mon,
 12 Aug 2024 23:32:00 -0400
X-MC-Unique: 9qR12zzKML6SmeAHm7fOZg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3657195420C;
	Tue, 13 Aug 2024 03:31:57 +0000 (UTC)
Received: from localhost (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49669196BE80;
	Tue, 13 Aug 2024 03:31:54 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, vgoyal@redhat.com, dyoung@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH -next v2] crash: Fix riscv64 crash memory reserve dead
 loop
Message-ID: <ZrrTpgvC/buAY/OV@MiWiFi-R3L-srv>
References: <20240812062017.2674441-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812062017.2674441-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/12/24 at 02:20pm, Jinjie Ruan wrote:
> On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
> will cause system stall as below:
> 
> 	 Zone ranges:
> 	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
> 	   Normal   empty
> 	 Movable zone start for each node
> 	 Early memory node ranges
> 	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
> 	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
> 	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
> 	(stall here)
> 
> commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop
> bug") fix this on 32-bit architecture. However, the problem is not
> completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
> architecture, for example, when system memory is equal to
> CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:
> 
> 	-> reserve_crashkernel_generic() and high is true
> 	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
> 	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
> 	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
> 
> As Catalin suggested, do not remove the ",high" reservation fallback to
> ",low" logic which will change arm64's kdump behavior, but fix it by
> skipping the above situation similar to commit d2f32f23190b ("crash: fix
> x86_32 crash memory reserve dead loop").
> 
> After this patch, it print:
> 	cannot allocate crashkernel (size:0x1f400000)
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> v2:
> - Fix it in another way suggested by Catalin.
> - Add Suggested-by.
> ---
>  kernel/crash_reserve.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5387269114f6..aae4a9e998d1 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -427,7 +427,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
>  			search_end = CRASH_ADDR_LOW_MAX;
>  			search_base = 0;
> -			goto retry;
> +			if (search_end != CRASH_ADDR_HIGH_MAX)
> +				goto retry;
>  		}
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
> -- 
> 2.34.1
> 


