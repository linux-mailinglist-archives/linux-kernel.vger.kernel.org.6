Return-Path: <linux-kernel+bounces-270546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5D994413D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B711C202CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EE51849;
	Thu,  1 Aug 2024 02:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FVItAq7M"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57263F50F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722479655; cv=none; b=HeBW88FVVU9f9YvbmqCVKWCHp1gisn96GzIwUNZEabAJ6qnWT7BOrgzvuCrOgdbfU2thOkV/CuXl4B/n6C8obBUUCmUDrcd/5ao9N1RxS55M9Ar0AahWHYcSv48/M0OA6jV5ro3PClwBb8SKIP9HB/rzXuYiEzgnMAH2sQmOKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722479655; c=relaxed/simple;
	bh=i3lFGt9HIu2kCNSU5TswVW9Fb89qstU1DaWWX98FTc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mw9b6vzH8EpKOfrJt6tgjOHZGmqyw6rIwLUTqtE4apCq/LCPDEeBOz1w00dzCwTbBLpVoTJM3ZpQbM29QmVCroMZzlitrde/PO7JMHjJemGY5rS/sg0sL0pF4DyRYHAKJJqBYRA3snTFLwmu9wfDSbkjaKMogDxw4TYmPMpKMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=FVItAq7M; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1722479650;
	bh=Gu2oyGDEAOsWLaCjYmOjBBoAxVuypoP0T7mtfNUrOe0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FVItAq7My3D+6l6w5F3oHYc0k/3sDN59MWvfcvkBTPwR3I7RuQEHaarKI6eeQi6BU
	 VNgqhNcym8wNRNd+j+ELofxI5vnpmW2pKeizWjBFbsfeUP+BnA3tFNV3eV2O50QgJb
	 sJCABPs3XXemxvf13dvkurBg7v+bRc2Rsl5cbEAVbOKSnlf3E0N26IoLkcJJLyuTsR
	 le81sMw7Boden5CLaQwdCc/Z0zbRoArk69fLqP5YH420VQyngkAi6BgoTHE6Io31/g
	 iTE6qiEV+almyOg7vxWGzOudUSS1u33Kt+KlLnlz3YU9V9qNAi6VmiQaee+bNcowiG
	 ym2XE9POb+QIg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WZChf4Bkyz4x6r;
	Thu,  1 Aug 2024 12:34:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, bhe@redhat.com
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini
 <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
In-Reply-To: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
Date: Thu, 01 Aug 2024 12:34:10 +1000
Message-ID: <87v80lnf8d.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sourabh Jain <sourabhjain@linux.ibm.com> writes:
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

Are they actually errors though? Do they block the actual kexec from
happening? Or are they just warnings in dmesg?

Because the fix looks like it could be racy.

cheers

> During kexec, the offline CPUs are brought online, which triggers the
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

