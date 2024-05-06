Return-Path: <linux-kernel+bounces-170233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58CD8BD3DC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543A01F223A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B29157494;
	Mon,  6 May 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKBUXY8o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000341C77
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016839; cv=none; b=B6z2Zd/iWpws7O13cYW/XSjZgdz5anyyWRNEs/kgirgre/Xfk+MJ3NgkvILE6tXRyVfib7rVLQUTrl+OJaI5xVVhAGkUt/V4QBviFOXbLGPGwqQajMxgz1G59XmDQZYF0vz4JHcAwJOus4F1riuaSSgwPbmvBnrfh12bt6MIjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016839; c=relaxed/simple;
	bh=HWPYB78h9OxvGxxz+M/MgrBuGBHcB5iAMPXg/jZFXhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7rtSRDUhO53J4CsC/Bt359pmC+iIJfzWA5XNRbclhOxudosC3X95iwatY5OVmeMvFuP7uJ+znU2VgTx6mLBayuxAmofBe/DOqCbjX+azCoXrR9H2gsNNRl1KE/59dc251nG52FUTJE2/zcKDlVH+lctYnMmci+ezz/+zWrOR4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKBUXY8o; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715016838; x=1746552838;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HWPYB78h9OxvGxxz+M/MgrBuGBHcB5iAMPXg/jZFXhc=;
  b=JKBUXY8o7ScAKhfgo+zhJAXI13M/TlZ56w6xDcrHnASGoj2YXrUkNiT3
   CfnMhfDN3fj7Zo4916zMx9OXvbxA5wzgwMRWBoSleY97j06JmZn8uuONp
   zrdXoz7CT0EYNHsAYM9X8oYw9lAC7jQe3uAbKZUY6s9K1h+WL8wUYZ9As
   Wi60I0lPpsF2sQxHRmZcLZglWgO6tKF5Uudn0ad1Pw6MnIAjy4nXGM7ep
   lfMokP6Oi86tTei8ie5uCvSLk3SFAw95vUXjPVjywgd8jIRc+UzhUB9YI
   mlJF17/F2on/Q50rwkmN6RqibWl3CfxXkavx02X2SnvjUsafYlwqw/FJI
   A==;
X-CSE-ConnectionGUID: Q41o53nsSo2AhyyLT1Yf9A==
X-CSE-MsgGUID: 8tewF2rHSVijbbORYUoUiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21933060"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="21933060"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:33:58 -0700
X-CSE-ConnectionGUID: 4piSjYOET7GjgOk7hwS6wQ==
X-CSE-MsgGUID: tFfgysrKTdCAbrpVFMpSCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="28625668"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:33:58 -0700
Date: Mon, 6 May 2024 10:38:41 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Imran Khan <imran.f.khan@oracle.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] x86/irq: use lapic_vector_set_in_irr to check for
 pending vectors in fixup_irqs.
Message-ID: <20240506103841.4d838866@jacob-builder>
In-Reply-To: <20240506111634.121460-1-imran.f.khan@oracle.com>
References: <20240506111634.121460-1-imran.f.khan@oracle.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Imran,

On Mon,  6 May 2024 21:16:34 +1000, Imran Khan <imran.f.khan@oracle.com>
wrote:

> No functional change, just using readily available helper which
> uses the same logic, that has been used here.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> ---
>  arch/x86/kernel/irq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 35fde0107901d..71432e42275c4 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -339,7 +339,7 @@
> DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_nested_ipi) /* A cpu
> has been removed from cpu_online_mask.  Reset irq affinities. */ void
> fixup_irqs(void) {
> -	unsigned int irr, vector;
> +	unsigned int vector;
>  	struct irq_desc *desc;
>  	struct irq_data *data;
>  	struct irq_chip *chip;
> @@ -366,8 +366,7 @@ void fixup_irqs(void)
>  		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
>  			continue;
>  
> -		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
> -		if (irr  & (1 << (vector % 32))) {
> +		if (lapic_vector_set_in_irr(vector)) {
>  			desc = __this_cpu_read(vector_irq[vector]);
>  
>  			raw_spin_lock(&desc->lock);
I have a similar refactoring as part of the posted MSI series, but I
totally missed the existing helper lapic_vector_set_in_irr().

https://lore.kernel.org/lkml/171448372145.10875.6906928487300074547.tip-bot2@tip-bot2/

Let me send out a fix patch against tip tree.

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -505,13 +505,7 @@ static inline bool lapic_vector_set_in_irr(unsigned int vector)

 static inline bool is_vector_pending(unsigned int vector)
 {
-       unsigned int irr;
-
-       irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
-       if (irr  & (1 << (vector % 32)))
-               return true;
-
-       return pi_pending_this_cpu(vector);
+       return lapic_vector_set_in_irr(vector) || pi_pending_this_cpu(vector);
 }

Thanks,

Jacob

