Return-Path: <linux-kernel+bounces-270819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE29445B4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C901C22343
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C3116D9DA;
	Thu,  1 Aug 2024 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MatGiVwW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4013C8F6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498252; cv=none; b=es4VlIe6ST+gz+fYqSQrIImOHizg3Wy7peFNmz4tPVyit8af/FX9+tsfE/XP0Kn1nDthXH5dDoLHtu36aM0JIQHkiB9jIctRyg3+jiZD3jAEiQYY7UZ7DjUAG23GRDLDspBIw/Ugx455TeZuN9JqphcDW+PVGgLAJPewT3onXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498252; c=relaxed/simple;
	bh=A5okpnXySOnw/P2+9LILLhHcbtXsXRvRk3sQMgfpUb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGUjfIMhEijvE5SjiJom/fLLZ/hz4+2PiW2cJFSJwaqszd+6lBFd78JxvpQmRA/b0Ite+XxbFGrY5sYjdPM4Q1jyN+4DeT863Lo+cVSzTSZX2EV/EX4xm7R6BLneTCtCTbOQRdPOA0E625waGnu4xQEHQOBi6+Wcw/1oxvV2Nyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MatGiVwW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722498250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aLqIFQo3+YskQXU1q1/o1FuHxtOKeaCtnjOaWo5ax7o=;
	b=MatGiVwWF7zzwVnn+Zv4oit/NsFSyovehKfbFX3ddosB3cBmFrz7kZgYbhN6RZoSb+o6+S
	GYPns7e6r3ovXmwdtxUkX9cMbi/TzNh2oPSXW3ruOVeQu5K8cc+zGh7xeLsvalwAVc3lcX
	A7hqF1/k7SOWU9qdph7prTvHOWF2cWE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-xDoMx_joMCmj2w8WRsGSAQ-1; Thu,
 01 Aug 2024 03:44:07 -0400
X-MC-Unique: xDoMx_joMCmj2w8WRsGSAQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB9CD1955D4A;
	Thu,  1 Aug 2024 07:44:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.91])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2525A1955E80;
	Thu,  1 Aug 2024 07:44:01 +0000 (UTC)
Date: Thu, 1 Aug 2024 15:43:57 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
Message-ID: <Zqs8veRya7v/pXEt@MiWiFi-R3L-srv>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/31/24 at 08:57pm, Sourabh Jain wrote:
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
> During kexec, the offline CPUs are brought online, which triggers the

Is this a generic action or specific on ppc about the offline CPUs being
brought line during kexec? 

> crash hotplug handler `crash_handle_hotplug_event()` to update the kdump
> image. Given that the system is on the kexec path and the kexec lock is
> taken, the `crash_handle_hotplug_event()` function fails to take the
> same lock to update the kdump image, resulting in the above error
> messages.
> 
> To fix this, let's return from `crash_handle_hotplug_event()` if kexec
> is in progress.
> 
> The same applies to the `crash_check_hotplug_support()` function.
> Return 0 if kexec is in progress.
> 
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linuxppc-dev@ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Reported-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  kernel/crash_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 63cf89393c6e..d37a16d5c3a1 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -502,6 +502,9 @@ int crash_check_hotplug_support(void)
>  {
>  	int rc = 0;
>  
> +	if (kexec_in_progress)
> +		return 0;
> +
>  	crash_hotplug_lock();
>  	/* Obtain lock while reading crash information */
>  	if (!kexec_trylock()) {
> @@ -537,6 +540,9 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>  {
>  	struct kimage *image;
>  
> +	if (kexec_in_progress)
> +		return;
> +
>  	crash_hotplug_lock();
>  	/* Obtain lock while changing crash information */
>  	if (!kexec_trylock()) {
> -- 
> 2.45.2
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


