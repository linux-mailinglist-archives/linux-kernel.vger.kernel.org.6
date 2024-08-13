Return-Path: <linux-kernel+bounces-284112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F13E94FD04
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA41228327E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7D72233A;
	Tue, 13 Aug 2024 05:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjQAvitc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAB11C68C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723525505; cv=none; b=qoGx+SyFurFBSgmRfeifJn9No3Ojnq4rnjxzW5om6oS82HcfItQwc3I5Gyxh/PzxODat6XcDEGoJawEVTXPHLOxgZTgZRHSXQ4/J4sO3Rh1hp1FfiaOp0tNX8YBT6SPgoX4Gfg393kkHMf8L2aR3xSeuBAqQx9ONjEe4FgMNPoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723525505; c=relaxed/simple;
	bh=OnYm6m35GzXOt2Z3PXU6hjfbV+l7avnaAvdmuWFn8HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gai8aqWVruY4WLeCmY+J5Szy9w7DSYtsZi7lJdBEH5hOYu7+G55S517JYXxO/zalwEKyviCcJ1oxMpr2eoy9s+6UUzJ+x5eli7rnNcdh6/RMMvOtpN4yMWR0DH9O142NRsh1+7N5NWwet37VkyqzkPTV+3hM6vp9tf0PRqrd+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjQAvitc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723525502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mQ6Iuf9HQSPpywwg6TUGGWKJbgP49L0YclpTyCUxyXs=;
	b=CjQAvitcH00iBix8UqFKo3MOxCqd6UKdLGIL+peK+DQnZRxSOwh0uEwUD6ZXoHnOBydrVc
	DQhwSZbbltrwITlMVO3DLwioTPq0d/uoX3Q4AEck+WWmd/I7hmL7IZWwBZ/rL04VX9PQEd
	YnQkM+TpwPcLais42bhByaH+dSLOmoE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-p12-A8AMMAaezDID4m6mJA-1; Tue,
 13 Aug 2024 01:04:59 -0400
X-MC-Unique: p12-A8AMMAaezDID4m6mJA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2263318EB22C;
	Tue, 13 Aug 2024 05:04:57 +0000 (UTC)
Received: from localhost (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09279196BE80;
	Tue, 13 Aug 2024 05:04:54 +0000 (UTC)
Date: Tue, 13 Aug 2024 13:04:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Petr Tesarik <petr@tesarici.cz>, Hari Bathini <hbathini@linux.ibm.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2] Document/kexec: Generalize crash hotplug description
Message-ID: <Zrrpcn7cnCigNfWd@MiWiFi-R3L-srv>
References: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/12/24 at 09:46am, Sourabh Jain wrote:
......
> ---
> 
> Changelog:
> 
> Since v1: https://lore.kernel.org/all/20240805050829.297171-1-sourabhjain@linux.ibm.com/
>   - Update crash_hotplug sysfs document as suggested by Petr T
>   - Update an error message in crash_handle_hotplug_event and
>     crash_check_hotplug_support function.
> 
> ---
......
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 63cf89393c6e..c1048893f4b6 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -505,7 +505,7 @@ int crash_check_hotplug_support(void)
>  	crash_hotplug_lock();
>  	/* Obtain lock while reading crash information */
>  	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");

Wondering why this need be updated.

>  		crash_hotplug_unlock();
>  		return 0;
>  	}
> @@ -520,18 +520,25 @@ int crash_check_hotplug_support(void)
>  }
>  
>  /*
> - * To accurately reflect hot un/plug changes of cpu and memory resources
> - * (including onling and offlining of those resources), the elfcorehdr
> - * (which is passed to the crash kernel via the elfcorehdr= parameter)
> - * must be updated with the new list of CPUs and memories.
> + * To accurately reflect hot un/plug changes of CPU and Memory resources
> + * (including onling and offlining of those resources), the relevant
> + * kexec segments must be updated with latest CPU and Memory resources.
>   *
> - * In order to make changes to elfcorehdr, two conditions are needed:
> - * First, the segment containing the elfcorehdr must be large enough
> - * to permit a growing number of resources; the elfcorehdr memory size
> - * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
> - * Second, purgatory must explicitly exclude the elfcorehdr from the
> - * list of segments it checks (since the elfcorehdr changes and thus
> - * would require an update to purgatory itself to update the digest).
> + * Architectures must ensure two things for all segments that need
> + * updating during hotplug events:
> + *
> + * 1. Segments must be large enough to accommodate a growing number of
> + *    resources.
> + * 2. Exclude the segments from SHA verification.
> + *
> + * For example, on most architectures, the elfcorehdr (which is passed
> + * to the crash kernel via the elfcorehdr= parameter) must include the
> + * new list of CPUs and memory. To make changes to the elfcorehdr, it
> + * should be large enough to permit a growing number of CPU and Memory
> + * resources. One can estimate the elfcorehdr memory size based on
> + * NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
> + * excluded from SHA verification by default if the architecture
> + * supports crash hotplug.
>   */
>  static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
>  {
> @@ -540,7 +547,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>  	crash_hotplug_lock();
>  	/* Obtain lock while changing crash information */
>  	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>  		crash_hotplug_unlock();
>  		return;
>  	}
> -- 
> 2.45.2
> 


