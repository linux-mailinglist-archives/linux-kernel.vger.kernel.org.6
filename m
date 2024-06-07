Return-Path: <linux-kernel+bounces-205452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E818FFC38
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107E1283F29
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283A614F9FC;
	Fri,  7 Jun 2024 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXlYbMGv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06714F9CC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741596; cv=none; b=jdbgeOptoldWzt9v5aYwdLSGC5dSJtUh70FBHiwzR1M6Pz7nM4ayBEJ2XUGE5rohJ9Izn5H/FJT5ZILWHqZH/J8qZAR0sjjP7jbVQpkyKCkf2Ou5hqj0fgjedbv6FuzE3tvpuEQ1pXFSHnF31yd+UNAlR9TWcoLvjI/dM2dA0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741596; c=relaxed/simple;
	bh=3ZTsHxW/IbapW9/uqLmzADDO9OOBIGtvwKgmTaxJ004=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDShoQycl4i+I+g7clhw04fc27f/pkLZ/zC9nap/SZPfP391MgdpoaGLZyTkP7LAL+5uv7twRcH9oO/ZTsL0fDCP3wt7QvQ7femkt3kg4jpHOEm+uCUkszLGSVd5dtr9SeUKDPMoiGDM+iwEpwVd2mqnXsy1xFB3SVn+Fs8z1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXlYbMGv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717741594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vLp0abxWPWeq0NDH61AYo4VII9n5wY1ynbuZau1muFU=;
	b=LXlYbMGvZW0l15JcvKkH+AppPozYsfEMCOISkEl4YLZu1cTrue7MwPRCo1uZoSZgCCEH4d
	tLt/S37LZ7BHa6VcsVPkVoLnfLEJgabYelKMa6py/1ffSmjviyJgjstf+g4IwREA05Ch2K
	ePuWdb/myOX//wqJuoW/N+lLqKFh64E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-cLVMIi1uP1mjK4jHSN8bWQ-1; Fri,
 07 Jun 2024 02:26:27 -0400
X-MC-Unique: cLVMIi1uP1mjK4jHSN8bWQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECE371953949;
	Fri,  7 Jun 2024 06:26:25 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5F871955F4B;
	Fri,  7 Jun 2024 06:26:23 +0000 (UTC)
Date: Fri, 7 Jun 2024 14:26:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Wenchao Hao <haowenchao22@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash: Remove header files which are included more than
 once
Message-ID: <ZmKoCreQLlXdKR7V@MiWiFi-R3L-srv>
References: <20240606091427.3512314-1-haowenchao22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606091427.3512314-1-haowenchao22@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/06/24 at 05:14pm, Wenchao Hao wrote:
> Following warning is reported, so remove these duplicated header
> including:
> 
> ./kernel/crash_reserve.c: linux/kexec.h is included more than once.
> 
> This is just a clean code, no logic changed.
> 
> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> ---
>  kernel/crash_reserve.c | 1 -
>  1 file changed, 1 deletion(-)

I remember someone posted patch to clean this up. Anyway,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5b2722a93a48..d3b4cd12bdd1 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -13,7 +13,6 @@
>  #include <linux/memory.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/memblock.h>
> -#include <linux/kexec.h>
>  #include <linux/kmemleak.h>
>  
>  #include <asm/page.h>
> -- 
> 2.38.1
> 


