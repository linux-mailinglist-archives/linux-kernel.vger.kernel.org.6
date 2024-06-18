Return-Path: <linux-kernel+bounces-220187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B24E90DDDE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9273F282614
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D944C1741FC;
	Tue, 18 Jun 2024 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QlMBFEaP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A436AEF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744239; cv=none; b=mfE8ljvj5LwsneNcMZq2kPTRmUQloZA391a7rYvvq7a4A9yUK1S/mT6veMRxJtn/qIg7e5ATVfL+4AhktYIJpy4izBAlo3ZUDZO4Cvxlf0ixPdzz3P+npbUpu2Pp4TFAxx9Ik+GwVJD3f9CRsxU9wveX+QYF2dyVDXv/1fYeum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744239; c=relaxed/simple;
	bh=gP5S8+T89IutLznPSZIbG6xZFxcSA1v6woREFaxuiSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8c82zKmu5ZXLcW/5wQQoMUqT3s11xlmEJInJ8Wm1q0o8RcDwY+meFNQp6IKXxIR8M7dI9kwd+Z1pHTjrnnkOnf7JjCg0xbaAT/4klUUZ2RQz3Wo7F69SaP8zc3Yh7aaE1XUB6XtDaLkotn//No1wJsZodgOUVGFX8xZYC11MDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QlMBFEaP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718744238; x=1750280238;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gP5S8+T89IutLznPSZIbG6xZFxcSA1v6woREFaxuiSY=;
  b=QlMBFEaP4qF4qsLNCj3c83LtpHfDv82yd3Srt4UruM5ZXK65l2aLQsqy
   QtHWMu99I+0JFCDdXu8V+szZwXoIBpdhLcCuVWBE0K+kO2O7XQGgrOpPJ
   bOcovEz6DCzwlqqNnHp4oBrqU6xaCi7W6SBiR5ap+eLq6MxHZ0SqdLBox
   g3HgVS1IWhB/nejpDvIXUpJfuqyJGoWw5JOgyiiNUjxzMxu77R8rKYLSY
   OCeqze8OShB+AQb1kCq1MfeYuqfAfRor0BsQ/+K2/yp4YXrkau2PELs95
   Ko0DZDKaLWh656QUmv9RoVTdBGfgLPffic/xvaeSU2SW35I7SikHEFu4i
   g==;
X-CSE-ConnectionGUID: mwLE/AzaS22/40brZOn8Qg==
X-CSE-MsgGUID: GWDVweQyQTyg9xYX4daeLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="27071003"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="27071003"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 13:57:17 -0700
X-CSE-ConnectionGUID: lfEKpDG0RkakbKnHFVTaww==
X-CSE-MsgGUID: sivuB8YdQHqTRWA3Pgl50w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46060513"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 13:57:16 -0700
Date: Tue, 18 Jun 2024 14:02:22 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] x86/irq: Fix comment on IRQ vector layout
Message-ID: <20240618140222.13086b0c@jacob-builder>
In-Reply-To: <20240618201320.2066726-1-sohil.mehta@intel.com>
References: <20240618201320.2066726-1-sohil.mehta@intel.com>
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


On Tue, 18 Jun 2024 20:13:20 +0000, Sohil Mehta <sohil.mehta@intel.com>
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
>  arch/x86/include/asm/irq_vectors.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/irq_vectors.h
> b/arch/x86/include/asm/irq_vectors.h index 13aea8fc3d45..970a89e7c6b7
> 100644 --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -18,8 +18,8 @@
>   *  Vectors   0 ...  31 : system traps and exceptions - hardcoded events
>   *  Vectors  32 ... 127 : device interrupts
>   *  Vector  128         : legacy int80 syscall interface
> - *  Vectors 129 ... LOCAL_TIMER_VECTOR-1
> - *  Vectors LOCAL_TIMER_VECTOR ... 255 : special interrupts
> + *  Vectors 129 ... FIRST_SYSTEM_VECTOR-1
Should this range be explicitly labeled as "device interrupts"?

Thanks,

Jacob

