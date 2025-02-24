Return-Path: <linux-kernel+bounces-529043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688EBA41F37
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4592D3A56E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523952192E3;
	Mon, 24 Feb 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TM/q4xlc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F09C204C19
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400335; cv=none; b=OiRXUpHRnmarnf1pUUVaIO4DW9K7hjP48E4k++GRJ4GOth5CihLN0gguNAqWj2637iqGhuSUXaXByHIgEWpke7WJ6FtqYsCkZASx2q/tqB7Uo/LPr0EKxXam6Q8A1em4O+RdjGsViMu/QU+1E22UZOKY6p6v4m9wOvpdW96S2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400335; c=relaxed/simple;
	bh=+rGrDGhEvXQ24U2PIiAS+hQLDz5X3B6pjpBKZP6y9kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+UHcGl0wrzOMJEu+X5/smrzfF9pU1Pcb61Xum6JcyTGtgySgnJFYKzhQXG/01HsSpIhrpLGii4t0YYxJ3eTVHiAKvJ5cfKNpPuuf9jDtwLCCizxrwgjyDh1a+0ocLtjo55kliUXw8vyby8/O0SJkfqJDaz7OzFci2pIXRZel+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TM/q4xlc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AFE4D40E01A3;
	Mon, 24 Feb 2025 12:32:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OSeDC-B-B6hg; Mon, 24 Feb 2025 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740400324; bh=TcyDkc7c9gBCOEI6pzKjHHoYgUk+1szSgx0RLJQP/Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TM/q4xlc0EfzK0QLoUM4hiK4V+KfXJ3roILDlo4AJNPTNjLTOkdfZ9nHvTzd7+oSe
	 Wswe8DXNbIS9Op9V/Dna6FL2RDvbz/7u2FaY1Sg5Zma76vWDLZ4kG/lCxgkyOWkZLa
	 i+SgtNKbHSwgaIjZEdtpeBjw7TfEyYza6aCb+EsEsrcSyo3Fk84QmiQQ+fM+cjyIsq
	 ExpUyJ3MCGWHAoLG9DrsolJeet47nhtKMNwpNI/BAD/y1CCy7nyDwBkubK18jKL3oi
	 yMBS4NSbQTf3PsS+7MJiyDuxocvlg8QA0GdGNtT95sR5Fm48bLTIa3cwKuvE2Y3Bc7
	 AwuKUct8TkX9uixa32NZlZI0TherwrVIXeqrzOi/7G6j/B+H9VrXyUC3GeIk9yq1R9
	 Y7EYjkjYKKaixz/MEJ3A62MpDg7VPFXQBy2RmIl1ESHHWS8ZC7/26W/O0hOuGOZFtv
	 zZbWcFSmo2YXmJEzj8pp67JZfjSgb4b9v/+5o+rxO/5lmY1rl+ky+6u3HUwA62qCl4
	 S2/v7Gnioh9v0MC9ufAjPCLZLH9whYw1DvBe1lqf8i6jSjQRIEiJXmHrHLHo9p4JzK
	 XGKfor+r+pxdwAwKo3l4DtcY72HY0N9KIjQEvH5fBWnWkAqaREu27gJdk7hOPLapvO
	 DXM/mTwGEmUtLrYjB3idGtqU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 635FF40E015F;
	Mon, 24 Feb 2025 12:31:47 +0000 (UTC)
Date: Mon, 24 Feb 2025 13:31:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v13 04/14] x86/mm: use INVLPGB for kernel TLB flushes
Message-ID: <20250224123142.GFZ7xmruuyrc2Wy0r7@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-5-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250223194943.3518952-5-riel@surriel.com>

On Sun, Feb 23, 2025 at 02:48:54PM -0500, Rik van Riel wrote:
> Use broadcast TLB invalidation for kernel addresses when available.
> 
> Remove the need to send IPIs for kernel TLB flushes.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>

What's the point of keeping those Tested-by tags if you still keep changing
the patchset?

> ---
>  arch/x86/mm/tlb.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index dbcb5c968ff9..59396a3c6e9c 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -1077,6 +1077,20 @@ void flush_tlb_all(void)
>  	on_each_cpu(do_flush_tlb_all, NULL, 1);
>  }
>  
> +static bool invlpgb_kernel_range_flush(struct flush_tlb_info *info)
> +{
> +	unsigned long addr;
> +	unsigned long nr;

Oh, c'mon:

	unsigned long addr, nr;

> +
> +	for (addr = info->start; addr < info->end; addr += nr << PAGE_SHIFT) {
> +		nr = (info->end - addr) >> PAGE_SHIFT;
> +		nr = clamp_val(nr, 1, invlpgb_count_max);
> +		invlpgb_flush_addr_nosync(addr, nr);
> +	}
> +	__tlbsync();
> +	return true;

Unused retval - that function looks like it wants to be void.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

