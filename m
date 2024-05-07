Return-Path: <linux-kernel+bounces-170626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E329F8BD9E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C361C21FA9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9A644C9D;
	Tue,  7 May 2024 03:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJrnz/PF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844E13FB2F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053881; cv=none; b=arzpHzZD4zB7a79Jm83umtzpdnmQLdwxinMyjT2VCtu2CJ1jlON7VB6rvd3piVPQuTkzU5xmeYtejq+E5tmR6+gg9dX2uCSebB2c1QtPhKEfp3LK6GA/KRrqn7gvbT2vrMy+Seol8xrHrwC+vnNs/2HAwxJbUaaXc8RecNAUCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053881; c=relaxed/simple;
	bh=q47IA65bs4sHFJRSLYpD3ly9bWfItSnbXYvuwDSigu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D54wJr5rYHeBmMEQKpprqO1J8HoVIGvZIgRpzGWqjYasnh30ACweX/strxxJwApZqQ1jYXcvqjaVF/mJFx5qMDrJhX/97iNlGrWkyOSB9aV2NZEAFl1KAHvaV9VlRucrWNABC2tBpPNwf0qyVsn0z/L47o+7Jk8cQBns4ZInx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJrnz/PF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715053880; x=1746589880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q47IA65bs4sHFJRSLYpD3ly9bWfItSnbXYvuwDSigu8=;
  b=bJrnz/PFDxH6CPw3UUigydtG4q2jxHvmsyYm0ymtGtgH+CfvVApcuVpI
   jIUPQ0ii6cqErDSW66Ttomcj2APH5Rj6+ubr3tHQAv1TG9CEQuGyU8ZqX
   2WSi2r+O89a9I8UavvwAV2aN9d/kKlWqTICN3nn7wRfeaSgaOdkdnIvGl
   Xt39zxa+Ez62HCQOhbM092MHgUYTFPRgpWPYr1Sj04fK2Zx50lQa9XqeC
   j1FLdWGK59aRJMRzG5smq0zs6P6j0NrK7DpPapC0jDi4H/OFgbPz2Ibyt
   kUCCC2AiRe210NyLyYM4e2upCB56kWAVB+G1rFBvTV3EeKYmAq5/Bz0xu
   g==;
X-CSE-ConnectionGUID: cO3vZqrmT2aAPQVBWS5mgg==
X-CSE-MsgGUID: o5CbFornS1i/99U4aS6cIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="14608217"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="14608217"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 20:51:19 -0700
X-CSE-ConnectionGUID: D6uWiVoFQPeaWMewdJ99fg==
X-CSE-MsgGUID: djmXPHx7THmacJBEs+N9Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="33201687"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.193.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 20:51:18 -0700
Date: Mon, 6 May 2024 20:51:17 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kai.huang@linux.intel.com" <kai.huang@linux.intel.com>
Subject: Re: [PATCH 1/2] x86/cpu: Remove useless work in detect_tme_early()
Message-ID: <ZjmlNSwForEVNeOv@aschofie-mobl2>
References: <cover.1713929290.git.alison.schofield@intel.com>
 <4e159cdb00907dd7884c191acdab3a028d2f4857.1713929290.git.alison.schofield@intel.com>
 <25da8fb143b361740660bccff3973e04f1506b39.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25da8fb143b361740660bccff3973e04f1506b39.camel@intel.com>

On Mon, Apr 29, 2024 at 04:17:12AM -0700, Huang, Kai wrote:
> On Thu, 2024-04-25 at 21:24 -0700, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > TME (Total Memory Encryption) and MKTME (Multi-Key Total Memory
> > Encryption) BIOS detection were introduced together here [1] and
> > are loosely coupled in the Intel CPU init code.
> >
> > TME is a hardware only feature and its BIOS status is all that needs
> > to be shared with the kernel user: enabled or disabled. The TME
> > algorithm the BIOS is using and whether or not the kernel recognizes
> > that algorithm is useless to the kernel user.
> >
> > MKTME is a hardware feature that requires kernel support. MKTME
> > detection code was added in advance of broader kernel support for
> > MKTME that never followed. So, rather than continuing to emit
> > needless and confusing messages about BIOS MKTME status, remove
> > most of the MKTME pieces from detect_tme_early().
> >
> > Keep one important piece: when the BIOS is configured with MKTME
> > 'on' any BIOS defined KeyID bits do take away from the physaddr bits
> > available in the kernel. Add a pr_info_once() informing about the
> > enabled keyids so the user can address (by rebooting with MKTME off)
> > if the user needs to recover the MKTME consumed bits.
> 
> Nitpickings below:

Hi Kai,
Thanks for the review -

> 
> The original code checks the MSR value consistency between BSP and APs,
> but the new code removed that.

BSP? AP?

I understood the check you are referring to as being for pronouncing MKTME
as disabled. When MKTME is removed from consideration, as is done here, the
code doesn't need to remember and compare a 'state'. It examines tme_activate
of each CPU. If one is !_LOCKED or !_ENABLED, the 'not enabled by BIOS'
message is emitted and the cpu cap is cleared. If another CPU reports TME
as properly enabled before or after that failed CPU, it is still disabled
in the kernel view. So, we don't set a state, like was done for MKTME, but
the worst status is *the* TME status.

> 
> I think the changelog should mention why it is OK.
> 
> I guess perhaps we can say something like the machine shouldn't be able to
> boot if BIOS configures TME activate MSR inconsistently among CPUs, so
> don't bother to have the consistency check.

I basically understand what you are saying, but because I don't see
that explanation in the spec, I wouldn't write that this code relies
on it.

> 
> >
> > There is no functional change for the user, only this change in boot
> > messages:
> >
> > Before:
> > [] x86/tme: enabled by BIOS
> > [] x86/tme: Unknown policy is active: 0x2
> > [] x86/mktme: No known encryption algorithm is supported: 0x4
> > [] x86/mktme: enabled by BIOS
> > [] x86/mktme: 127 KeyIDs available
> >
> > After:
> > [] x86/tme: enabled by BIOS
> > [] x86/mktme: BIOS enabled 127 keyids
> 
> Regarding to what to print:
> 
> 1) IMHO, it's still better to print the algorithm here.  The user/admin
> may want to know what algorithm is enabled by the BIOS (especially there
> are more than one that can be selected in the BIOS).  E.g., the user may
> find the default AES-XTS-128 (0) isn't secure enough and wants the more
> secure algorithm using 256-bit key.
> 
> I understand we might not want to maintain a "value to name" table for
> this so the kernel can print the algorithm in name, but it would be still
> helpful if we just dump the raw value here like:
> 
>   x86/tme: policy activated: 0x2

The path that is cleaned up here never emitted the policies, either by
value or name. It only emitted a message if the policy was unknown. This
is a new (albeit little) feature request and seems it would be best
submitted as a separate patch.

> 
> 2) Given the kernel doesn't support MKTME, I think people may be more
> interested in the reduced physical address bits, instead of how MKTME
> keyIDs are activated.
> 
>   x86/tme: MKTME enabled, physical address bits reduced from <xx> to <xx>.

I added something like this in v2:
x86/mktme: BIOS enabled: x86_phys_bits reduced by %d

I chose to report just the number of bits reduced because it is not
clear to me that this code is, or always will be, the only path
mucking with the number of phys addr bits. For that reason I didn't
want to spew absolute values. User can look up their 'final' number
using lscpu or /proc/cpu, right?

snip

> > +
> > +     pr_info_once("x86/mktme: BIOS enabled %d keyids\n", nr_keyids);
> 
> If I read correctly, if you print
> 
>   physical address bits reduced from <xx> to <xx>.
> 

as I wrote above, didn't write it quite like that...

> instead of the number of KeyIDs, you can even get rid of the 'nr_keyids'
> variable.

Got rid of nr_keyids. 

-- Alison


