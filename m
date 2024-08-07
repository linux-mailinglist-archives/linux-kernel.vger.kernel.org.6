Return-Path: <linux-kernel+bounces-278640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3790094B2F7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F338D2834AA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663A01552E0;
	Wed,  7 Aug 2024 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MjVStxYX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s6thDodU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E244152787
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069362; cv=none; b=Vh0KAi90UKVAdfIWGNk2YMV0ngkLyvNiUaEf3nFn7JHc4CWWdrdzLhGNgC/86eWrU6hx6jgCg2hKYCkMYDr06slGRPzP0nIo95QIp2GqqusXxLV85anvME4nKvMhLWaoX8SA+YT2dSv4Dtt92AeToJlZqxoVlnKeV8dkkyU09OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069362; c=relaxed/simple;
	bh=h/nAbCMiPzHZcINAHh9yNdQIKEpUzW/Egq/0oVCY7oo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iumz+CLHf7E/zmlZ7NnszJCrfKGQFdKXJRHy+mzONcaJZp/GuAapUcQFaxZOligYyZK0Un20ldWNTLaSxFfdq/DK2SLrq0RfBGhMM5jlNx5whAFYlCIABGS/NTRnPf7pTcrnKuhXeMwupJJgIEHrSZgUOo3lApqVuFysry5xZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MjVStxYX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s6thDodU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723069359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3f6AgGXBWn26USlUGHHAP7bmp83AGplRMWVB7u+gXs=;
	b=MjVStxYXCwpkumLfhgR5p8beZFpGH2nkbtVVALx+fFHnNmmYvlk9jeWFb2Q/rJYIvBu7Yf
	QmqhkyySGxyYRAosoZO89bM199kAIarC+9Nc93FIuUE3eN99+Tkwo61xTamSAX8SS3iNBN
	iIOfqCr4ykriRm5TOq0tu9JB41vbrUgGFzwYj/6wQo82k+sDITDg/nr4x7+tjiZXPLl4U6
	ByrZvF9YgWAzEcjJn/hOUGeXT/RLW3uVgLtH+5n/Deqdx1JJpBwf45ixi5O+pKIQUNqlPh
	+oebXHH82ss0ROpqZQ7F6Euf9mWjW9YkHsMH+f61njOBq13jB7EdVgFLXZjNGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723069359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3f6AgGXBWn26USlUGHHAP7bmp83AGplRMWVB7u+gXs=;
	b=s6thDodUfmlaC+uGJBnMaZ8eZ/JEl88E+VPzE73mAN9wUMnkbyFt0RkhXmpAghR+nz/JRl
	U80X7xVZhgnZS4Dg==
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Oscar Salvador <osalvador@suse.de>, Dan Williams
 <dan.j.williams@intel.com>, James Houghton <jthoughton@google.com>,
 Matthew Wilcox <willy@infradead.org>, Nicholas Piggin <npiggin@gmail.com>,
 Rik van Riel <riel@surriel.com>, Dave Jiang <dave.jiang@intel.com>, Andrew
 Morton <akpm@linux-foundation.org>, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, "Kirill
 A . Shutemov" <kirill@shutemov.name>, peterx@redhat.com,
 linuxppc-dev@lists.ozlabs.org, Mel Gorman <mgorman@techsingularity.net>,
 Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>, David
 Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Dave
 Hansen <dave.hansen@linux.intel.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v4 4/7] mm/x86: Make pud_leaf() only care about PSE bit
In-Reply-To: <20240807194812.819412-5-peterx@redhat.com>
References: <20240807194812.819412-1-peterx@redhat.com>
 <20240807194812.819412-5-peterx@redhat.com>
Date: Thu, 08 Aug 2024 00:22:38 +0200
Message-ID: <87bk240y8h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 07 2024 at 15:48, Peter Xu wrote:
> An entry should be reported as PUD leaf even if it's PROT_NONE, in which
> case PRESENT bit isn't there. I hit bad pud without this when testing dax
> 1G on zapping a PROT_NONE PUD.

That does not qualify as a change log. What you hit is irrelevant unless
you explain the actual underlying problem. See Documentation/process/
including the TIP documentation.

> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index e39311a89bf4..a2a3bd4c1bda 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1078,8 +1078,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
>  #define pud_leaf pud_leaf
>  static inline bool pud_leaf(pud_t pud)
>  {
> -	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
> -		(_PAGE_PSE | _PAGE_PRESENT);
> +	return pud_val(pud) & _PAGE_PSE;
>  }

And the changelog does not explain why this change is not affecting any
existing user of pud_leaf().

Thanks,

        tglx



