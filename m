Return-Path: <linux-kernel+bounces-293901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED3958651
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F881C2457A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288E18F2E9;
	Tue, 20 Aug 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q3Hw2uYM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NZgfua+t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD218E74B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155058; cv=none; b=bbVVAnKY48yZLu7lt0IpL1CgUamUrRFcyLtn7X1oPV6QnztZ8y95uEaAroxg3xBjvazgwBczb+4txA0VGNfj96UF76dwH4UYErQUBxQqFUknKds7lm5+qByLWs9FVGCyAdmQk/X6Giwzx4hR4TkcH5pmW5FocGLuksA+kOtxeUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155058; c=relaxed/simple;
	bh=2WkGAgxXLfQ7jRRP5u18SkAjHkeqUxiY7XAzhk0w5Fg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tdu0FRmfEhpPxyfivEN+8xSWEsBRAXjJKdcfm9Ijtq734vl8ZjKirBj68mZJOHML3dgceVvoxq4taCht73Mk8ZtI/gj6ONMq1siYAphjZNCVVlbCvfYkTovWPRmf07kNZ1kI+gyDmlJADNCGBNXcS5MuQb0SZ8Gd6eCI1WYnOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q3Hw2uYM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NZgfua+t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724155055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pO1a18E6F09njbFdSQ5xNkVGv9dmU6QzgLJ8X2t+ljk=;
	b=Q3Hw2uYMeYhrLcGo7umkEmm845iQ87d3/HYsen4+E2boc4bKvywZP8YKWR5UmJ/OPCD5Ci
	wQAcyN8eHx9OUnQ8Ugpb3zTcahEN7MIbVrj1ohRgdKval9c48dYTAASnEks1M69yrAn6Lp
	aqmwbc0TaeG+LPeWZTlcVxa09bGHEdixz4/iA6ZI1ApEndHxVuJHpFs+yTMUsmpqllC6iW
	OOEGHWZCaEHs+wYoo+dawxnsKVm/uxA2FWT9XXbaVbZ2SgmkZDDpo2zWYWP7KF1Hu1bbgC
	XZhRwrBzWbDrW8RtULHgPeCXZtF12ruL3TkdjYcJ9fGiX5WHgREAdUyNaWMR5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724155055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pO1a18E6F09njbFdSQ5xNkVGv9dmU6QzgLJ8X2t+ljk=;
	b=NZgfua+tGqYUXKPAgV3xbQQE9kTLm2JtDPNj0cCDgPzutR2Qk9cFoaXk2h20v7njeDZUnC
	0k1aiGbzu2HGFtDA==
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, Max Ramanouski <max8rr8@gmail.com>, Alistair Popple
 <apopple@nvidia.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook
 <kees@kernel.org>, linux-mm@kvack.org, oliver.sang@intel.com
Subject: Re: [tip:x86/urgent] [x86/kaslr]  dfb3911c36:
 kernel_BUG_at_arch/x86/mm/physaddr.c
In-Reply-To: <202408201529.498d4d4d-lkp@intel.com>
References: <202408201529.498d4d4d-lkp@intel.com>
Date: Tue, 20 Aug 2024 13:57:35 +0200
Message-ID: <877ccbl840.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 20 2024 at 15:16, kernel test robot wrote:
> commit: dfb3911c3692e45b027f13c7dca3230921533953 ("x86/kaslr: Expose and use the end of the physical memory address space")
>
> [    0.010309][    T0] ------------[ cut here ]------------
> [    0.011020][    T0] kernel BUG at arch/x86/mm/physaddr.c:28!
> [ 0.026951][ T0] ? __phys_addr (ld-temp.o:?) 
> [ 0.027298][ T0] ? kernel_randomize_memory (ld-temp.o:?)

Sigh. I'm a moron. This obviously needs the fix below.

The end of the region is start + size - 1. So there are two bugs:

    1) It needs to be done before jumping forward to the next PUD.

    2) If the direct map covers the full address space, then
       __pa(vaddr) is wrong because that's the next PUD already.

I'll amend the commit and force push it. Thankfully I did not have time
on sunday to send it to Linus :)

Thanks,

        tglx
---
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 0f2a3a4a1078..230f1dee4f09 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -141,19 +141,19 @@ void __init kernel_randomize_memory(void)
 		vaddr += entropy;
 		*kaslr_regions[i].base = vaddr;
 
-		/*
-		 * Jump the region and add a minimum padding based on
-		 * randomization alignment.
-		 */
+		/* Calculate the end of the region */
 		vaddr += get_padding(&kaslr_regions[i]);
-		vaddr = round_up(vaddr + 1, PUD_SIZE);
-
 		/*
 		 * KASLR trims the maximum possible size of the
 		 * direct-map. Update the physmem_end boundary.
+		 * No rounding required as the region starts
+		 * PUD aligned and size is in units of TB.
 		 */
 		if (kaslr_regions[i].end)
-			*kaslr_regions[i].end = __pa(vaddr) - 1;
+			*kaslr_regions[i].end = __pa_nodebug(vaddr - 1);
+
+		/* Add a minimum padding based on randomization alignment. */
+		vaddr = round_up(vaddr + 1, PUD_SIZE);
 		remain_entropy -= entropy;
 	}
 }



