Return-Path: <linux-kernel+bounces-280837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587E94CFD1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358662835BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B20319147D;
	Fri,  9 Aug 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qVaIQJt3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/79bjhG1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BCA1553A2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205311; cv=none; b=tbjt59lmQFDb9oijEqHGQONHMo2ce1ZeCWClM7TzL+aLKO4RNDbSdRTiJ5rZE/SjjBQBr72NlN1wxZUV6GI9BODeiZ5N3Eqmk3BdHPJtge1P1G0sJqbMQu4C/GqiMf/rNM2pkoQPWv5I12X1auurvwBN7mbn8QBLDs8Z2i4wgZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205311; c=relaxed/simple;
	bh=NtMVARq1a3ogAjvgoiHirIVTh4p/gMz9mfRKicaoGYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y5Wu7IW+XnPs1BnXwFacreMFzMEsQNjrlq3A2NBfg3hMaPZAhJBgzaojNv5h0onVm4MZc8b7DRDqDCfDHhymLDQjp3s9w1SftwzXaBqmsGt/x525snMhkVnicH9zez/6Ec291SRWXUiVf5iJCuMfX2Yf43MjgBUdANSHspA7jhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qVaIQJt3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/79bjhG1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723205308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdiGSFNTrBSYFwpgP8eah13N5RSzPLohIKvfJai2S0w=;
	b=qVaIQJt3ulHehi7WSoVKySGiDzelyn+pRR9wbJgnWO2lp+Qo7AVqYgugRvjWBA4m7AnI5g
	RSkAWMfsf0wMO1SxKPQ1Z9ubxGTX1QtKWxOQMjuNBog7jhsnDOnIJMSDA47fs7C6pAaD/j
	/NTaSYvqc5qqHZ352tolGC+8vN/wRq9LkuYPNfe50M73OT1tBf+zZ3qNXulCLH0w4Pb++n
	h+xPRK4/bE2McX5JcsVG10zAS5tpgG3ORG6F8SCX7pvrhPJx63VtzTIjQf6tRYd4Wv5dRL
	T1G4oa8Gskr9gSAhxvNNCPXsl7Bvwy6Y4TP8oWDZ+v/Ynvg/K49hQvJ2LEoonw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723205308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdiGSFNTrBSYFwpgP8eah13N5RSzPLohIKvfJai2S0w=;
	b=/79bjhG1R37llYQMGwou1YZqcLFThCIIXln46S8iy0NBQP/SGfyspEPmffXtpRRabZzXZH
	09nuUsMPC+J/+BCg==
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Oscar
 Salvador <osalvador@suse.de>, Dan Williams <dan.j.williams@intel.com>,
 James Houghton <jthoughton@google.com>, Matthew Wilcox
 <willy@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, Rik van Riel
 <riel@surriel.com>, Dave Jiang <dave.jiang@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, "Kirill
 A . Shutemov" <kirill@shutemov.name>, linuxppc-dev@lists.ozlabs.org, Mel
 Gorman <mgorman@techsingularity.net>, Hugh Dickins <hughd@google.com>,
 Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, Dave Hansen
 <dave.hansen@linux.intel.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v4 4/7] mm/x86: Make pud_leaf() only care about PSE bit
In-Reply-To: <ZrTcGxANpcvwp1qt@x1n>
References: <20240807194812.819412-1-peterx@redhat.com>
 <20240807194812.819412-5-peterx@redhat.com> <87bk240y8h.ffs@tglx>
 <ZrTcGxANpcvwp1qt@x1n>
Date: Fri, 09 Aug 2024 14:08:28 +0200
Message-ID: <87mslluceb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 08 2024 at 10:54, Peter Xu wrote:
> On Thu, Aug 08, 2024 at 12:22:38AM +0200, Thomas Gleixner wrote:
>> On Wed, Aug 07 2024 at 15:48, Peter Xu wrote:
>> > An entry should be reported as PUD leaf even if it's PROT_NONE, in which
>> > case PRESENT bit isn't there. I hit bad pud without this when testing dax
>> > 1G on zapping a PROT_NONE PUD.
>> 
>> That does not qualify as a change log. What you hit is irrelevant unless
>> you explain the actual underlying problem. See Documentation/process/
>> including the TIP documentation.
>
> Firstly, thanks a lot for the reviews.
>
> I thought the commit message explained exactly what is the underlying
> problem, no?
>
> The problem is even if PROT_NONE, as long as the PSE bit is set on the PUD
> it should be treated as a PUD leaf.

Sure. But why should it be treated so.

> Currently, the code will return pud_leaf()==false for those PROT_NONE
> PUD entries, and IMHO that is wrong.

Your humble opinion is fine, but hardly a technical argument.

> This patch wants to make it right.  I still think that's mostly what I put
> there in the commit message..
>
> Would you please suggest something so I can try to make it better,
> otherwise?  Or it'll be helpful too if you could point out which part of
> the two documentations I should reference.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

  A good structure is to explain the context, the problem and the
  solution in separate paragraphs and this order

>> > diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> > index e39311a89bf4..a2a3bd4c1bda 100644
>> > --- a/arch/x86/include/asm/pgtable.h
>> > +++ b/arch/x86/include/asm/pgtable.h
>> > @@ -1078,8 +1078,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
>> >  #define pud_leaf pud_leaf
>> >  static inline bool pud_leaf(pud_t pud)
>> >  {
>> > -	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
>> > -		(_PAGE_PSE | _PAGE_PRESENT);
>> > +	return pud_val(pud) & _PAGE_PSE;
>> >  }
>> 
>> And the changelog does not explain why this change is not affecting any
>> existing user of pud_leaf().
>
> That's what I want to do: I want to affect them..

Fine. Just the change log does not tell me what the actual problem is
("I hit something" does not qualify) and "should be reported" is not
helpful either as it does not explain anything

> And IMHO it's mostly fine before because mprotect() is broken with 1g
> anyway, and I guess nobody managed to populate any pud entry with PROT_NONE
> on dax 1g before, and that's what this whole series is trying to fix.

Again your humble opinion matters, but technical facts and analysis
matter way more.

Thanks,

        tglx

