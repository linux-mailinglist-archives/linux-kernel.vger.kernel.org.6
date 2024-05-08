Return-Path: <linux-kernel+bounces-173195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 559588BFCD2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8BD1F25EFC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2E7839E3;
	Wed,  8 May 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hdzkpQuz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34F45024
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169903; cv=none; b=AZ1YSTjswAm18ZECmEEqEtHRaRLfnLMMzU3NRSJZILl0i54lOfhO7uuRNx4PfrPJu2uo/CMeMCN5OYeA6NjwjYEODPwCCpu+cS8LWAfC7nbyWDy/ujnf2BO4fmXfG8bh2H7O51dh8GUkqHoU3NnntT9kTUZx5iTUsC3963or5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169903; c=relaxed/simple;
	bh=GATzjlivhq8fKMFczIL/3RPrPffvid/SU8NTqPLJYPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZArFwz0mWJTHKf/6ScB5lo8jQmzzdgQij1kfzYlpttFkYZgCSavlMISLwv475or4JQFueorxc+kEOdjzwoBaUmj9vvJc/mzMkZmhDvLsgMrnIUwH7ilJX55vQ700nDs5L8ko2i5mc3LruOyGkC2LiDEw5RCQNEpTo8ultGOfhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hdzkpQuz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9B7D940E0177;
	Wed,  8 May 2024 12:04:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id idHYIoNC5YuF; Wed,  8 May 2024 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715169890; bh=f3BmmZ/ZrWMxvMKQEh/hpc9YGyn7kI0w2PJrN/PFOAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdzkpQuzF7KWDDuh6lP0sSlhQpJKKXN3IRFkvo17PIvT/MaZa5CIYLCcbCmQNH2B/
	 w6uMqdIKGEonCdlxDqRXPPPHrxr4/7kTyZ2rJKALlhosuxv0/h7o6S39sYblJTHkbt
	 pE8cA4tIPM9ED6TNmrMnaeZzDlkd3edEHLOwcviv/BzO+vp9TW5cNA8B2KQoWdH23X
	 xuEp0e4MWeap7ltCIrBK4Tf8ztkbfwnv5FJKZqEBwUwCY82cg4cc9a/Iw1zFToV8Ft
	 zd9ghbBhd5rPasz2Bv+mL+qfcf92gy2IDGr3KvsZwOXK7K3Yf7ShaCP7M1ojDwlulf
	 9p7JpwI2RKdPv5Hi3pxxKAXOJikaPT1xP5pfkgfkaTS2ms8/+ofTyTzKC4wUDY3C4r
	 Es7IXT2SRD5U6wJ7A5Gfi5dsZykIsNIHmoaIbd6xkK7gMzXaFqcfi/E1cD1zW8HH2h
	 dAqE1Y38sBwMabDEJmQN8wZwVq4y1iWxRDRkx2vpYrtZW9nZ4QPy7Fhw8ZNCQiUrzp
	 LhezVj24J5rO9MqhBdGp8eYVrtLGsRtcr3aub4FeBoD7f/sHPXWyMY7Oi/xfMe1wsw
	 ++b3IRKbcipZ4cfD4r0dVOHzep8SSqnRLNpAJZUU0aGVNnq/87f12Y8GK3N4yZHiOo
	 SxlSJ1Y8dzrhiyQ7DXWLbvWg=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0CEA40E024C;
	Wed,  8 May 2024 12:04:28 +0000 (UTC)
Date: Wed, 8 May 2024 14:04:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 10/18] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20240508120422.GCZjtqRrSuJeUyByEM@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-11-kirill.shutemov@linux.intel.com>
 <20240505121319.GAZjd337gHC0uhk6aM@fat_crate.local>
 <bpmagk7v6swftzjjpchplzjwgx3pbdqzklcxybrmrhprqizk45@lxmvva42z36g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bpmagk7v6swftzjjpchplzjwgx3pbdqzklcxybrmrhprqizk45@lxmvva42z36g>

On Mon, May 06, 2024 at 06:37:19PM +0300, Kirill A. Shutemov wrote:
> "second kernel" is nomenclature kexec folks are using, but okay.

And the "third kernel" is the one which got kexec-ed the second time?

You can make it: "The second, kexec-ed kernel" and then it is perfectly
clear.

> > > +	/*
> > > +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> > > +	 * conversions to finish.
> > > +	 *
> > > +	 * If race happened, just report and proceed.
> > > +	 */
> > > +	bool wait_for_lock = !crash;
> > 
> > You don't need that bool - use crash.
> 
> Dave suggested the variable for documentation purposes.
> 
> https://lore.kernel.org/all/0b70ee1e-4bb5-4867-9378-f5723ca091d5@intel.com
> 
> I'm fine either way.

But you have the comment above it which already explains what's going
on...

> > Why are we printing something here if we're not really acting up on it?
> > 
> > Who should care here?
> 
> The only thing we can do at this point on failure is panic. It think
> it is reasonable to proceed, especially for crash case.
> 
> The print leaves a trace in the log to give a clue for debug.

Sure but you'll leave a trace if you panic right then and there, on the
first failure. Why noodle through the pages if the first failure is
already fatal?

> One possible reason for the failure is if kdump raced with memory
> conversion. In this case shared bit in page table got set (or not cleared
> form shared->private conversion), but the page is actually private. So
> this failure is not going to affect the kexec'ed kernel.

Lemme make sure I understand what you're saying here:

1. This is a fatal failure and we should panic

However,

2. the kexec-ed kernel is using a different page table so there won't be
   a mismatch between shared/private marking of the page so it doesn't
   matter

Close?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

