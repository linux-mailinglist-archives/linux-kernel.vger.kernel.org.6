Return-Path: <linux-kernel+bounces-233088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C700391B21E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7E21F2339B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563C1A0B14;
	Thu, 27 Jun 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXUKvX11"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C12837F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526920; cv=none; b=kqNvwHNXx1t5HSLoqPcfK4Y9Mw98CVZUNfI+l9Bax3STb3bFwAU6WZXNo4OQv+eRLBMLYdK3jfsktAr5TQkWmF+RrDd3C+dllvtqpZiF63HBEqscEyW4yjLegamAtg1huLDp9T/l0p27TxVsaYGpZTUujKMS7fd88XI4MJJvAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526920; c=relaxed/simple;
	bh=zn8lfLzQJcEVfOPwFtoRRtd5nzs2IXz9qLLhKZhn3xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1mEviWpiiQDAzN0VS43kyX1r6XOEVbQhHLxshEFgzeFveSSPO2mc76lHRdt1JcQlUFyd6VWYS6KC4r+312n7y/AROSJe3zzF2hiEL378mIwyjj478G3UB1X5u9JHVCCbzD6M0Km1JW/oaSVDy8AQgVjkZqnnUDDKOqvBBWMDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXUKvX11; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719526919; x=1751062919;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zn8lfLzQJcEVfOPwFtoRRtd5nzs2IXz9qLLhKZhn3xQ=;
  b=RXUKvX115hY+Vtx7xfAMbiP+kdC1wyPWee/JfyJBue7bfcI+6izC4CaJ
   o0sW1XbVz2ku5EW8TDsgCmGi8Z9Yywqo6rtyTDUOT05YQtBOfz+8oW8ad
   JE0x7KabXKmoIrLml91Ka3UlXAFqpvS5QFYFFAEhI19YRvU2EuDOXlpCe
   eOEMJdoBfQOLcYHIGP/HPIvr/96Ea6LxKdhRDZ8a8RqtnH/OJe8CD2Xw4
   isbHmNf8ZbBDGY0vMMpJboSztGet+NoMBwqdWLtTSoPWLVEw/KcglxKgN
   RU2Sexead8gUhwBJC1AkI+hH0lxrg8FHL7vQcFqGgZva7ouG9DoYmU714
   g==;
X-CSE-ConnectionGUID: uiXdvsPdQR6mxoNHg6ZO/Q==
X-CSE-MsgGUID: DzK6iOunRQ6yRQLMuDnvrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="12289789"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="12289789"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 15:21:58 -0700
X-CSE-ConnectionGUID: fHLI4vk5Tx6+VLIMNkgHpg==
X-CSE-MsgGUID: ynAhg5cUQm2ElqTGqZVFGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44517236"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 15:21:58 -0700
Date: Thu, 27 Jun 2024 15:27:08 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2] x86/irq: Fix comment on IRQ vector layout
Message-ID: <20240627152708.3abda399@jacob-builder>
In-Reply-To: <20240626194324.110388-1-sohil.mehta@intel.com>
References: <20240626194324.110388-1-sohil.mehta@intel.com>
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


On Wed, 26 Jun 2024 19:43:24 +0000, Sohil Mehta <sohil.mehta@intel.com>
wrote:

> commit f5a3562ec9dd ("x86/irq: Reserve a per CPU IDT vector for posted
> MSIs") changed the first system vector from LOCAL_TIMER_VECTOR to
> POSTED_MSI_NOTIFICATION_VECTOR. Reflect this change in the vector layout
> comment as well.
> 
> However, instead of pointing to the specific vector, use the
> FIRST_SYSTEM_VECTOR indirection which essentially refers to the same.
> This would avoid unnecessary modifications to the same comment whenever
> additional system vectors get added.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v2: Update the table to denote the other device interrupts range. [Jacob
> Pan]
> 
> v1:
> https://lore.kernel.org/lkml/20240618201320.2066726-1-sohil.mehta@intel.com/
> 
>  arch/x86/include/asm/irq_vectors.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/irq_vectors.h
> b/arch/x86/include/asm/irq_vectors.h index 13aea8fc3d45..47051871b436
> 100644 --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -18,8 +18,8 @@
>   *  Vectors   0 ...  31 : system traps and exceptions - hardcoded events
>   *  Vectors  32 ... 127 : device interrupts
>   *  Vector  128         : legacy int80 syscall interface
> - *  Vectors 129 ... LOCAL_TIMER_VECTOR-1
> - *  Vectors LOCAL_TIMER_VECTOR ... 255 : special interrupts
> + *  Vectors 129 ... FIRST_SYSTEM_VECTOR-1 : device interrupts
> + *  Vectors FIRST_SYSTEM_VECTOR ... 255   : special interrupts
>   *
>   * 64-bit x86 has per CPU IDT tables, 32-bit has one shared IDT table.
>   *
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Thanks,

Jacob

