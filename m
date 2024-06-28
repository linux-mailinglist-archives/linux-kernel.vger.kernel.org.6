Return-Path: <linux-kernel+bounces-234246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6968A91C437
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5F01F22926
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF041CB307;
	Fri, 28 Jun 2024 16:54:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978E1C9ED9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593699; cv=none; b=LeYj8UwrG4OeyAJ4zbfBdALma7EBQ6MdOuXtgdu9OX68bgBTWsSY4jvsqTvidFtCnNGAXX/CAZjyXXdHEqjlfkweVawMO2BfcnTuUH54T8y4fitIpIgipZfuH6UtYhApr2ixKJ4tbJuBVqFiJNadodcLFcOT0YotYpvvoXCxQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593699; c=relaxed/simple;
	bh=xpN1RtShbaagkW48F5gdrFANRJk+tsIyoVaEvLDJEc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPODT+JHZ7cUuGDDgJr4sSj0pR0rbW0Wa/RGJMLjUuArJXInIHJDHH8XLefuBhtpPBesiKz59LMlAE6u7uy7UiMPFxO+kGfF4vxnpqw/PFTJWL/sSpY7vOjGPpmsLE7XPEhp/4m75eQxvigouu8VC1M073kIrtXvJm3IgZado4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD81BC116B1;
	Fri, 28 Jun 2024 16:54:56 +0000 (UTC)
Date: Fri, 28 Jun 2024 17:54:54 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, david@redhat.com,
	scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <Zn7q3oL1AE8jdM-g@arm.com>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626191830.3819324-1-yang@os.amperecomputing.com>

On Wed, Jun 26, 2024 at 12:18:30PM -0700, Yang Shi wrote:
> @@ -568,6 +596,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	if (!vma)
>  		goto lock_mmap;
>  
> +	if ((vm_flags & VM_READ) && (vma->vm_flags & VM_WRITE) &&
> +	    is_el0_atomic_instr(regs)) {
> +		vm_flags = VM_WRITE;
> +		mm_flags |= FAULT_FLAG_WRITE;
> +	}

The patch looks fine now and AFAICT there's no ABI change.

However, before deciding whether to merge this patch, I'd like to
understand why OpenJDK cannot use madvise(MADV_POPULATE_WRITE). This
would be the portable (Linux) solution that works better on
architectures without such atomic instructions (e.g. arm64 without LSE
atomics). So fixing user-space would be my preferred solution.

(I poked some people in Arm working in the area, hopefully I'll get some
more information)

-- 
Catalin

