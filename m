Return-Path: <linux-kernel+bounces-532786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AFFA4522C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C3F7A3A86
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373AB17D346;
	Wed, 26 Feb 2025 01:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4YtLOw+S"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF9F14EC73
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740533216; cv=none; b=UHLulXxri67w2zP6cjaS+4XFMIjG+IoORdwrrqLTgkCovjl/1X+72D0ygihOhD0SMJtMITM8mVsy0Am9uonhQfzYYAD5jFDrLWH4teWOMxFje0295sEUPSb86ZMHGHNm+nn0tmQL0CNebvYUMHIS+aXeCE/eryklYHS4w+s1vI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740533216; c=relaxed/simple;
	bh=zlFEyC5JeqNAQZFtKzotM5zUfFmUiborem5NGUXLCd0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N+B+j/gfRYJniNYS2EqoRsMpMJ9VXnjTe0OLAZ+ebStAPEs7xxdim9skSt0FPslsYlUN7FsjaX9QLClEJA3f7yXSYVUdZxHf6LLhMnd7+0GYzMA6qE8F45HTchDsLFwgEYvHB7RB9d80FwJyurPOvgTHU274gUxOrgjmIcQqGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4YtLOw+S; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe86c01f5cso117809a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740533214; x=1741138014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P5aQ9/mYNTRs5PTgmLo7iB4ydZJA2zvGbKJjvdE0VlI=;
        b=4YtLOw+SrPQOhO3zYMYgKU04iCFUo8p9kFS2r1DCcMyOClYnCiLoz58fdvquj6bmFm
         osI53bhCk+k/5V1b7/H5WFKr5RQEceim7n2S6zBSnn0kJ5O7d1zNJEkhqRhPkXGKcXSC
         PqnuVkVdUi0II/rrJDVqcq31Dp7LJbNoky/9uQ7K/AWdJal/LsP+/NH/jsqlfRKBE5AC
         a2DIKhI5iIxRw6VZf4INOd/jO2RhQ9mkl+XTJWdUb4GoQQjNth/850/QrvWBGBw25+CP
         5t72W5LX/CC6W/2r5egHqKsCpTCqyk7AYEr7LLNThyptcXy8P7tw7sGzUT0H63twoP2Q
         2wjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740533214; x=1741138014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5aQ9/mYNTRs5PTgmLo7iB4ydZJA2zvGbKJjvdE0VlI=;
        b=cC0/++56XmoMFqNraOjN3Zx9DSfitTXiAG3bxIZRp/+VkT6SWa50BQDhdeeOnEyWSC
         2Wx3aLTaWNnFaye9auEH48slNysOYCiqti9+3hM9cqzJmiBix2OOLVl/SagA9ktdlvOs
         t7c2wkbE58n8lgb25hoftaS6TxnSDCvz8d8Z1oJ6amnZKj3t8fM2SyfzLCykmNNz1Tpq
         Knw7Sz7McUV9SdSurKVno46HzX6mQOTH5e9yDHGp3+l5DaCO+cp030O07b8JtQyo9UaM
         5XjvLbLEi8yFzEan9T9ZLOXYtqEpsz7pyeCPsBRds5ReaKM63bHircC9eGWHT3C651Qh
         dlHA==
X-Gm-Message-State: AOJu0YwhffXMAJis9bIVQR9BjHJH7eO1rv4d0aLlxdx4ZRuglxOmzRqg
	soKVVOOo62jAYbOFNbXYDRNihYnX5XkznRzN5fYy327tyV4APHS13RA2rB/pV5cLUjUnlYS+07o
	4IQ==
X-Google-Smtp-Source: AGHT+IHlNQ5IiZOzlAdmwX5lSgim2XgHtoN9cYmDSibC0w1TZnTWCxGEQ0ilxIU3H83+4BpiEAN/Z5oPYmg=
X-Received: from pjbsf2.prod.google.com ([2002:a17:90b:51c2:b0:2fe:7f7a:74b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f8e:b0:2ee:c9b6:c26a
 with SMTP id 98e67ed59e1d1-2fe68ada3bemr9005257a91.11.1740533214601; Tue, 25
 Feb 2025 17:26:54 -0800 (PST)
Date: Tue, 25 Feb 2025 17:26:53 -0800
In-Reply-To: <20250201000259.3289143-2-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250123002422.1632517-1-kevinloughlin@google.com>
 <20250201000259.3289143-1-kevinloughlin@google.com> <20250201000259.3289143-2-kevinloughlin@google.com>
Message-ID: <Z75t3d1EXQpmim9m@google.com>
Subject: Re: [PATCH v6 1/2] x86, lib: Add WBNOINVD helper functions
From: Sean Christopherson <seanjc@google.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	pbonzini@redhat.com, kirill.shutemov@linux.intel.com, kai.huang@intel.com, 
	ubizjak@gmail.com, jgross@suse.com, kvm@vger.kernel.org, 
	thomas.lendacky@amd.com, pgonda@google.com, sidtelang@google.com, 
	mizhang@google.com, rientjes@google.com, manalinandan@google.com, 
	szy0127@sjtu.edu.cn
Content-Type: text/plain; charset="us-ascii"

On Sat, Feb 01, 2025, Kevin Loughlin wrote:
> +static inline int wbnoinvd_on_all_cpus(void)
> +{
> +	wbnoinvd();
> +	return 0;

Returning anything is silly.  I'll prepend a patch (I'm going to send a combined
version of this and the targeted flushing series) to remove the return value
from wbinvd_on_all_cpus(), which I'm guessing is the source of the silliness.

>  static inline struct cpumask *cpu_llc_shared_mask(int cpu)
>  {
>  	return (struct cpumask *)cpumask_of(0);
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 03e7c2d49559..86a903742139 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -117,7 +117,24 @@ static inline void wrpkru(u32 pkru)
>  
>  static __always_inline void wbinvd(void)
>  {
> -	asm volatile("wbinvd": : :"memory");
> +	asm volatile("wbinvd" : : : "memory");
> +}
> +
> +/* Instruction encoding provided for binutils backwards compatibility. */
> +#define WBNOINVD ".byte 0xf3,0x0f,0x09"

Argh.  This causes problems for KVM, because KVM's newfangled CPUID macros heavily
use token pasting with X86_FEATURE_xxx, and so KVM's usage of:

	F(WBNOINVD)

causes explosions.  Somewhat amusingly, this is the second time today I ran into
this problem, as WRMSRNS as the safe issue.

Dave (and others),

Any thoughts on the best way forward?  I hacked around a similar collision in
commit 8d862c270bf1 ("KVM: x86: #undef SPEC_CTRL_SSBD in cpuid.c to avoid macro
collisions"), but (a) that scares me less because KVM should never use the
SPEC_CTRL_SSBD macro, and (b) I really, really don't want that to be the long-term
solution.  The only reason I committed the hack was because it was the only
blocking issue for a massive rework, and I couldn't get traction on renaming
the MSR macro.

For WBNOINVD, WRMSRNS, and any other instructions that come along, what about this?
Quite ugly, but it's at least descriptive.  And more importantly, the chances of
unwanted behavior are quite low.


/* Instruction encoding provided for binutils backwards compatibility. */
#define ASM_WBNOINVD ".byte 0xf3,0x0f,0x09"

/*
 * Cheaper version of wbinvd(). Call when caches need to be written back but
 * not invalidated.
 */
static __always_inline void wbnoinvd(void)
{
	/*
	 * If WBNOINVD is unavailable, fall back to the compatible but
	 * more destructive WBINVD (which still writes the caches back
	 * but also invalidates them).
	 */
	alternative("wbinvd", ASM_WBNOINVD, X86_FEATURE_WBNOINVD);
}

