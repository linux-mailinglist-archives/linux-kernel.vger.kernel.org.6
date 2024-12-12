Return-Path: <linux-kernel+bounces-442525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB719EDDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 03:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83033168034
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2735913541B;
	Thu, 12 Dec 2024 02:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGDsXQD/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D961558BA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733972146; cv=none; b=LzZxCrVpJqjeFvgRbcyKTftWYfKqolutI6T6EVhliKEXPTEV/+r/yzLJDMkgfr+LTkXPVKiVKkz9kqbxmvxCKdq91LmawwkGMGw2MYCyaxSVG2pRui7Dlv048H+KDzyVge7cHkUO74opLWug8J4jHvvKv0e3XlWjwDr6UO41LaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733972146; c=relaxed/simple;
	bh=/yS8RVuAmUkGk6rlQSA1ptvbIOw5yTwHb7zh5EHfw9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab30zgaW3jrz2Vf12nij0fv+0oUhB7igyEpHMJoCO6y6HI3xBxG7SAFy5HP/h/WXcb6xM+QcPnpzv20tk1Bup1xVrXvpvVZmAJFkm6Y4mf0oqu3nrqp0+VEuXqFWkD+FPSeF4kJ/i3unSQgTrdDrSN10BdQDdLEfEBOoXvpuqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGDsXQD/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733972143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3bt3yLVk+LpBNVwqRgtTrNcwDAGMzslAPv9EpoWDR8=;
	b=WGDsXQD/MRscWNymGYcxmU32Cj4n/4uwkQ9CHVLpHqXVc+5hmWMtdeO53FvZg8tKkwkPId
	u0ODVtF4Gihg7X4poS3vP2KY9hXm6DDWEDfyfAzd7wynAi1KYg7pMoYAZlwP1I2gUHxw20
	gPd0jfu+hoDYGaJL3HugRhM72SeTusM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-G1VQ4YhcN7Wjpbb7TucKnA-1; Wed,
 11 Dec 2024 21:55:39 -0500
X-MC-Unique: G1VQ4YhcN7Wjpbb7TucKnA-1
X-Mimecast-MFC-AGG-ID: G1VQ4YhcN7Wjpbb7TucKnA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B389195608C;
	Thu, 12 Dec 2024 02:55:37 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17A191956048;
	Thu, 12 Dec 2024 02:55:34 +0000 (UTC)
Date: Thu, 12 Dec 2024 10:55:30 +0800
From: Baoquan he <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: ebiederm@xmission.com, Hari Bathini <hbathini@linux.ibm.com>,
	akpm@linux-foundation.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Initialize ELF lowest address to ULONG_MAX
Message-ID: <Z1pQoh7IwtERIWe5@MiWiFi-R3L-srv>
References: <20241210091314.185785-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210091314.185785-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 12/10/24 at 02:43pm, Sourabh Jain wrote:
> kexec_elf_load() loads an ELF executable and sets the address of the
> lowest PT_LOAD section to the address held by the lowest_load_addr
> function argument.
> 
> To determine the lowest PT_LOAD address, a local variable lowest_addr
> (type unsigned long) is initialized to UINT_MAX. After loading each
> PT_LOAD, its address is compared to lowest_addr. If a loaded PT_LOAD
> address is lower, lowest_addr is updated. However, setting lowest_addr
> to UINT_MAX won't work when the kernel image is loaded above 4G, as the
> returned lowest PT_LOAD address would be invalid. This is resolved by
> initializing lowest_addr to ULONG_MAX instead.
> 
> This issue was discovered while implementing crashkernel high/low
> reservation on the PowerPC architecture.
> 
> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> CC: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  kernel/kexec_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
> index d3689632e8b9..3a5c25b2adc9 100644
> --- a/kernel/kexec_elf.c
> +++ b/kernel/kexec_elf.c
> @@ -390,7 +390,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
>  			 struct kexec_buf *kbuf,
>  			 unsigned long *lowest_load_addr)
>  {
> -	unsigned long lowest_addr = UINT_MAX;
> +	unsigned long lowest_addr = ULONG_MAX;

Great catch.

Acked-by: Baoquan He <bhe@redhat.com>

>  	int ret;
>  	size_t i;
>  
> -- 
> 2.47.1
> 


