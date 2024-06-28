Return-Path: <linux-kernel+bounces-233690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2C991BB93
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2101F22A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333C1527A0;
	Fri, 28 Jun 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="rVPPdSHJ"
Received: from out0-193.mail.aliyun.com (out0-193.mail.aliyun.com [140.205.0.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52071CD32
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567429; cv=none; b=sNO9oCpQ02rQlnFn/BRe4oKMDOJ3xekFfR0gOceGqNRm/XDMWzDn831FA2cvVJ5wJ8m3m3TDIRTaRGypZegSFAoIVqn2KsgrL28Wzdyl5n+mBssPSe7uazyeUx+D+G8FQW8Fa1bGfp3II9lc6l+y35b8O0N4++xiYGh9eVgUOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567429; c=relaxed/simple;
	bh=t3UL8J/O+o4c7pBzKx74njRp5r1qLFjEJjSHUU2CA5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHp8QaLjgvyUJGZAOdNbhcpom6sSZq7V9lqjLzb9VB10l3ezBrqqFvQiWVH/46gEOv9TqmAwt6iXRsAFDa1+dE2UxNrZF2AdcWco/53gx5WNi8KALysXufgxaVSoR8DZoFkVSLrS4bW8B+o9GeKBCNbnGGjaHVkcxRu1Bz0+iOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=rVPPdSHJ; arc=none smtp.client-ip=140.205.0.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1719567417; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=1D+1NUOBPHywlhTO4OCjOr2oX4V4Y1BZUKPeeO0NK/s=;
	b=rVPPdSHJeJzFzkhGuZmQjPgVoe0FB0JOLW8Q0EaYcuFze+vj51AP1EqceEpYR3DFLxO3tMjBIAr+DPJaN3DNGlboAjwpYpsEyMW4eRyEnOgFP2y9I6gk4n+A/GPncOaCZ8m3HD1HInFqT16s7C8dpLTsQ3utuJkVZBROk/zkUd4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023108233;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.YCMkH59_1719567416;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.YCMkH59_1719567416)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 17:36:57 +0800
Date: Fri, 28 Jun 2024 17:36:56 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: Xin Li <xin@zytor.com>
Cc:  <linux-kernel@vger.kernel.org>,
  "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
  "Thomas Gleixner" <tglx@linutronix.de>,
  "Ingo Molnar" <mingo@redhat.com>,
  "Borislav Petkov" <bp@alien8.de>,
  "Dave Hansen" <dave.hansen@linux.intel.com>,
   <x86@kernel.org>,
  "H. Peter Anvin" <hpa@zytor.com>,
  "Xin Li" <xin3.li@intel.com>,
  "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
  "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
  "Paolo Bonzini" <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] x86/fred: Always install system interrupt handler
 into IDT
Message-ID: <20240628093656.GA103025@k08j02272.eu95sqa>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
 <2f632ef59c8c9cc27c3702bc2d286496ed298d65.1718972598.git.houwenlong.hwl@antgroup.com>
 <dca1635b-1e08-4dbb-9dbb-335cbdcf9b9d@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dca1635b-1e08-4dbb-9dbb-335cbdcf9b9d@zytor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jun 25, 2024 at 05:19:20PM +0800, Xin Li wrote:
> On 6/21/2024 6:12 AM, Hou Wenlong wrote:
> >In sysvec_install(), the system interrupt handler is not installed into
> >the IDT when the FRED feature is present, but FRED can be disabled
> >in trap_init(). However, sysvec_install() can be used
> >before trap_init(), e.g., the HYPERVISOR_CALLBACK_VECTOR handler is
> >registered in kvm_guest_init(), which is called by setup_arch() before
> >trap_init(). If FRED is disabled later, then the spurious_interrupt()
> >handler will be used due to the handler not being installed into the
> >IDT. Therefore, always install system interrupt handler into IDT.
> >
> >Fixes: 3810da12710a ("x86/fred: Add a fred= cmdline param")
> >Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> >---
> >  arch/x86/include/asm/idtentry.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> >index d4f24499b256..daee9f7765bc 100644
> >--- a/arch/x86/include/asm/idtentry.h
> >+++ b/arch/x86/include/asm/idtentry.h
> >@@ -470,8 +470,7 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
> >  #define sysvec_install(vector, function) {				\
> >  	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
> >  		fred_install_sysvec(vector, function);			\
> >-	else								\
> >-		idt_install_sysvec(vector, asm_##function);		\
> 
> empty line, it improves readability.
> 
> And please put a comment here to explain why this is unconditionally
> done for IDT.
> 
Hi Xin,

It seems preferable to parse the FRED command line and disable FRED
early instead of using this method. As mentioned in my cover letter, I
initially attempted to fix the problem this way (by parsing the command
line in cpu_parse_early_param()). Should I send a new patch for it, or
will you be covering it in your work to enable FRED early?

Thanks!

> >+	idt_install_sysvec(vector, asm_##function);			\
> >  }
> >  #else /* !__ASSEMBLY__ */
> 
> Thanks!
>     Xin

