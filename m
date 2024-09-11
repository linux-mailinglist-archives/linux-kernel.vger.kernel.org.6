Return-Path: <linux-kernel+bounces-325112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDD8975526
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D613B21AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8E719E80F;
	Wed, 11 Sep 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BT/bN14w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DEC1E51D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064435; cv=none; b=DtZZfNEVqNWIsxVoEK2gRlMPEOvNS3Url1m6lEFOABEJNl4V/YwZBFVlQaq4t4g0zaQltuywVlvn2qVDfwBr1WdE1fUwmj8Z3c7VjQFM1sEGB/1m7D3D+V0KLTnXCtEly00ufcHU3v5VuksT1XAGUvvOMh9YY4YlkBOWnvQO9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064435; c=relaxed/simple;
	bh=sBmk84jzVBjRSQKjf/IvZsWTiVJYQJl2RpuLHPmrarY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCWcdBiS4ABY0HZAyG3Qrl2nnq1yVgJZHlRceNQexKA4MQgZ/VvhUrAlbmPkQ9R7FKOMfUtO/LlMVA8ozoO2XV1pNSFJiqGObaDPQJeBAZQ3rBgaS5/5vIEoyzAa/2JkBM1UGQUeTAC47VuEWILAaTxW7vVhmXQvDMLzmvjI/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BT/bN14w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726064430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9UKjQHKbbUWDKvrveJtrSaJsbUem/1dqSveBkM7kg2E=;
	b=BT/bN14wEFJoH9UHULkx7W1X1ghlqxw9Cb/EuSAGr/OOfIXBADIRSeJ1HNLinS2oa9C9bG
	tNMdBLpVc9pkoE+51S9KOvMlJh5nhbDlZipcqYG55QjNT6C0lqj3fA2b47/zJqr4qACGkI
	HHL3+HhjJqOrX6aqWcDye0qNDxI8Grs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-lXe3ob0CMI-wwPAWC2bJCA-1; Wed,
 11 Sep 2024 10:20:26 -0400
X-MC-Unique: lXe3ob0CMI-wwPAWC2bJCA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53DF01955E8C;
	Wed, 11 Sep 2024 14:20:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA5FA30001A1;
	Wed, 11 Sep 2024 14:20:20 +0000 (UTC)
Date: Wed, 11 Sep 2024 22:20:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: akpm@linux-foundation.org, Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND v2] kexec/crash: no crash update when kexec in
 progress
Message-ID: <ZuGnH5R+FOC481V3@MiWiFi-R3L-srv>
References: <20240911112111.108056-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911112111.108056-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/11/24 at 04:51pm, Sourabh Jain wrote:
> The following errors are observed when kexec is done with SMT=off on
> powerpc.
> 
> [  358.458385] Removing IBM Power 842 compression device
> [  374.795734] kexec_core: Starting new kernel
> [  374.795748] kexec: Waking offline cpu 1.
> [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [  374.935833] kexec: Waking offline cpu 2.
> [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> snip..
> [  375.515823] kexec: Waking offline cpu 6.
> [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [  375.695836] kexec: Waking offline cpu 7.
> 
> To avoid kexec kernel boot failure on PowerPC, all the present CPUs that
> are offline are brought online during kexec. For more information, refer
> to commit e8e5c2155b00 ("powerpc/kexec: Fix orphaned offline CPUs across
> kexec"). Bringing the CPUs online triggers the crash hotplug handler,
> crash_handle_hotplug_event(), to update the kdump image. Since the
> system is on the kexec kernel boot path and the kexec lock is held, the
> crash_handle_hotplug_event() function fails to acquire the same lock to
> update the kdump image, resulting in the error messages mentioned above.
> 
> To fix this, return from crash_handle_hotplug_event() without printing
> the error message if kexec is in progress.
> 
> The same applies to the crash_check_hotplug_support() function. Return
> 0 if kexec is in progress because kernel is not in a position to update
> the kdump image.

LGTM, thanks.

Acked-by: Baoquan he <bhe@redhat.com>

> 
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Reported-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> Changelog:
> 
> Since v1:
>  - Keep the kexec_in_progress check within kexec_trylock() - Baoquan He
>  - Include the reason why PowerPC brings offline CPUs online
>    during the kexec kernel boot path - Baoquan He
>  - Rebased on top of #next-20240910 to avoid conflict with the patch below
>    https://lore.kernel.org/all/20240812041651.703156-1-sourabhjain@linux.ibm.com/T/#u
> 
> V2 RESEND:
>  - Update linuxppc-dev mailing list address
> ---
>  kernel/crash_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index c1048893f4b6..078fe5bc5a74 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -505,7 +505,8 @@ int crash_check_hotplug_support(void)
>  	crash_hotplug_lock();
>  	/* Obtain lock while reading crash information */
>  	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
> +		if (!kexec_in_progress)
> +			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>  		crash_hotplug_unlock();
>  		return 0;
>  	}
> @@ -547,7 +548,8 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>  	crash_hotplug_lock();
>  	/* Obtain lock while changing crash information */
>  	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
> +		if (!kexec_in_progress)
> +			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>  		crash_hotplug_unlock();
>  		return;
>  	}
> -- 
> 2.46.0
> 


