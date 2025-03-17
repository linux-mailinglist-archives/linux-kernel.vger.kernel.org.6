Return-Path: <linux-kernel+bounces-565092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E73A660B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142AC178935
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C6C20487F;
	Mon, 17 Mar 2025 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJXp3Iwk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991E204685;
	Mon, 17 Mar 2025 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247376; cv=none; b=qvRii2RkZlUfVqGXRzZrEpR1EQGpotUSV4CJzkHyeyKTCgFrFa+kzrmY02uEtdOmErvW0wl7QAg6m3HQuKxZM11inZU7vQd3vCn7nQsAxp0PwTerUXzqaf/1ZnHu+7t4Bzq3nXAI//X3KoaUCj5jEk5HXtllROLF4/QOBlCa/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247376; c=relaxed/simple;
	bh=1uEGj+4Rp5UkbcSQgR2YjyqfZ4caIz+BRkDaDrSGCHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lf3aaHKDVtbH0KYxX+SSBXPrWYNyrvLhYzB3efEi22Bty4IcwYT8l33Knq5whTUAORP/zOF23AHY7Er91kfWtjmvDVaKgrj2NRx6TjH7VAuNnkx5C2F7hKQN9oSYxnP6wbTZjZAK0Pk65rRUeukggP5xm93jrobnCHY0J5XSKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJXp3Iwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11CDC4CEE3;
	Mon, 17 Mar 2025 21:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742247376;
	bh=1uEGj+4Rp5UkbcSQgR2YjyqfZ4caIz+BRkDaDrSGCHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJXp3Iwk7rU712ier++VoLxePGCSP6SWRdt0HPUGH4q1VikhbevjryVTOQJW7/T9s
	 tbTjX/Tf2DAQG1exGkhrs7cx2mwXIVE9FcVkKoVCyZQMc4EXfWoNX3JSCtKy8mMqtz
	 TZRSeYpDLUTYS1eHXYC8pXyKKjGVW3k9thHdMpV4zOxvSZxK71QC8MJzinwWDe6yuo
	 IrWK8+V5wzIrG1Y871EJlYJPVjiIwn8DpH6WoNf/kIku1TpOFGl+A3fqDko1ZlNcCU
	 /YFEngJlZfD1/X3TvARi0bF43xEte2uunC8O0g7PqSRBwdU3DorUE9fU42BwunAE/f
	 7NO7gUu0HlYdg==
Date: Mon, 17 Mar 2025 22:36:10 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/29] x86/cpu: Remove leaf 0x2 parsing loop and add
 helpers
Message-ID: <Z9iVyrlDbFyI9Rqi@gmail.com>
References: <20250317164745.4754-1-darwi@linutronix.de>
 <20250317164745.4754-4-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317164745.4754-4-darwi@linutronix.de>


* Ahmed S. Darwish <darwi@linutronix.de> wrote:

> Leaf 0x2 output includes a "query count" byte where it was supposed to
> specify the number of repeated CPUID leaf 0x2 subleaf 0 queries needed
> to extract all of the hardware's cache and TLB descriptors.
> 
> Per current Intel manuals, all CPUs supporting this leaf "will always"
> return an iteration count of 1.
> 
> Remove the leaf 0x2 query count loop and just query the hardware once.
> Parse the output with C99 bitfields instead of ugly bitwise operations.
> 
> Provide leaf 0x2 parsing helpers with all the above.  Use such helpers
> at x86/cpu intel.c.  Further commits will use them for x86/cacheinfo.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  arch/x86/include/asm/cpuid.h              |  1 +
>  arch/x86/include/asm/cpuid/leaf_0x2_api.h | 65 +++++++++++++++++++++++
>  arch/x86/include/asm/cpuid/types.h        | 16 ++++++
>  arch/x86/kernel/cpu/intel.c               | 24 +++------
>  4 files changed, 88 insertions(+), 18 deletions(-)
>  create mode 100644 arch/x86/include/asm/cpuid/leaf_0x2_api.h

Could you please turn this into at least two patches:

  - One does the functional change - this patch should be as small as 
    possible. This patch turns a piece of 'Intel documents' property 
    into 'actual code' that differs from the previous code, which may 
    or may not regress in practice.

  - The other does the factoring out and the introduction of 
    <asm/cpuid/leaf_0x2_api.h>.

Thanks,

	Ingo

