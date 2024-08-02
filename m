Return-Path: <linux-kernel+bounces-272573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE47945E2A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE832823A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571B41E4847;
	Fri,  2 Aug 2024 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dZcUWZSG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LcS0nrfl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437231E4A6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603422; cv=none; b=GXbaETFeG5zz0HWgGtuurpreGhkwrNkeiUGhGesbgyaLGkUr1XAcTnNfR4KRc+gFNlVR62Iw0JkrH/A4I5bl46/F67WpQeVOFNlLy5cNPHt0lsfH9WJ+ojiL8QxH2fZ0Hrp5bPGGolLP3CL+VDIRIbE1TAWnHH3SxwWtRfEojOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603422; c=relaxed/simple;
	bh=+1LtDl+VSvgy9lp4d2en/bBSY6aj0yTlbcC+J3huB1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ljDIGC9mwsjJK53NHrPaap1+PloWENjFZ2QXqpEjuoSgewhSC3x9TM9fKGIXN0W/ew6IF4D2GHI1phE1LUg/3Z5Jy+m5sWDKtu8MmWzTKE8ZSLIRVFKhNbrdKDDfzqCZbvT3GaYv/ayIP+mikmhKvDnm4+SHSRdXKPr6RKD84vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dZcUWZSG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LcS0nrfl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722603419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lD3D+R0O0Em71mRsMfaOIka63qjKDA7WWE2rtnMjgEU=;
	b=dZcUWZSGh9bGff4aCRomiWr1icF2Wg4bv0lRE9aRsL5FKsB8Q6pWnBY+f7tuYRIditgxTE
	7yvT7OEA1TVi9/w25Fjg4GbFzDfDlu4dl8AbarCh5bEB9fNsZzoi+5VBQsKK1kXdopM3SP
	KPexSQqTua7F3MXymturY2rwzgw/PIUhEQ5yeaSSqtGXn6EbTBi+JyzsPMpQeWXRIniH/Z
	o5oFfx+pMrUt92cANNTgUwKDsxx/3S3eXxWp/9vpR3ZbSTUiPkVflvXw1dS2ieI1F2v7Mw
	UCu+2AjwQREJxDSlfyydp/JUYekKS8C6hXDUKZQR4BOev8Lrz+oPsfTvcaAggA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722603419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lD3D+R0O0Em71mRsMfaOIka63qjKDA7WWE2rtnMjgEU=;
	b=LcS0nrflXj5N91hTteiaGk7vViHLu1+T9de/uWLDfB8oqgfeg2UYqnKEj7WaMjtHcxEwy/
	ocCi8Am6lrFvfPCg==
To: Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross
 <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 2/3] x86/cpu: fix unbootable VMs by inlining memcmp in
 hypervisor_cpuid_base
In-Reply-To: <304592cf-e4a7-4ba1-baa6-4941c60f0e3c@p183>
References: <a9f505a6-fd31-4cfa-a193-d21638bb14f1@p183>
 <304592cf-e4a7-4ba1-baa6-4941c60f0e3c@p183>
Date: Fri, 02 Aug 2024 14:56:58 +0200
Message-ID: <87frrn13s5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 02 2024 at 11:50, Alexey Dobriyan wrote:

Please amend functions with '()' in the subject line and the change log
consistently.

> diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
> index 6b122a31da06..3eca7824430e 100644
> --- a/arch/x86/include/asm/cpuid.h
> +++ b/arch/x86/include/asm/cpuid.h
> @@ -196,7 +196,20 @@ static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
>  	for_each_possible_hypervisor_cpuid_base(base) {
>  		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
>  
> -		if (!memcmp(sig, signature, 12) &&
> +		/*
> +		 * FIXME rewrite cpuid comparators to accept uint32_t[3].

Which comparators?

Thanks,

        tglx

