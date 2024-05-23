Return-Path: <linux-kernel+bounces-187391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4428CD122
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A471C2162F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126011474B1;
	Thu, 23 May 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LPTyNLCv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DEE145B33;
	Thu, 23 May 2024 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716463275; cv=none; b=nMxsg+TZm7Hp6jtp1yZXYruJl6fNOeU9CGkUjPckco7jDQLJjQc9A6FL6cRPfQysXH8QZL3hGxCmcipLUKVe//kNHI0ZkziiSHTBAmBwwxPt1fPgUcBDumc8ik8m0Js/CyQGsk+udaOpk8rtvZMnbIae3NB9AklaSt0IdnqqLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716463275; c=relaxed/simple;
	bh=+ufxBA931R+9/+mWjq15kbP9r+F/Bytauh3yDryr+P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTp7/TqAkbJWqk8G9fad5dm6HYrKUEMT3Pf8nXcydt0eOaP7nXFa63PJPLfzg2WCKdHi+sEP6KN853EhmvDaGzTesz6uXCshpSTz6fcUCSl/Faowrd0k+fQhM9fqRim5e+Pz1oJkmcvMTv6QjuaskJGmN2iHivhswgsT+XMcaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LPTyNLCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7326C2BD10;
	Thu, 23 May 2024 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716463275;
	bh=+ufxBA931R+9/+mWjq15kbP9r+F/Bytauh3yDryr+P8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPTyNLCvh3BXn9nne8Byz/D9+HbuUenFTOmirI0dVuh+vj89a6yiSmLQMZxuyA49g
	 2KLSKpJbc7V7cdNvnsE1LwEsQF4A7s1obJpyQcsgQMUMW97zkFpKkw/FS3a3OUeRG2
	 gHht4E/RfoVUo5OdoIKPxIfqGussu2Gef4SaPBuU=
Date: Thu, 23 May 2024 13:21:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35802: x86/sev: Fix position dependent variable
 references in startup code
Message-ID: <2024052334-cable-serotonin-fa2b@gregkh>
References: <2024051738-CVE-2024-35802-959d@gregkh>
 <b3a6ea47-8628-4edc-aee5-e5051955124a@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3a6ea47-8628-4edc-aee5-e5051955124a@suse.com>

On Thu, May 23, 2024 at 02:14:57PM +0300, Nikolay Borisov wrote:
> 
> 
> On 17.05.24 г. 16:23 ч., Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > x86/sev: Fix position dependent variable references in startup code
> > 
> > The early startup code executes from a 1:1 mapping of memory, which
> > differs from the mapping that the code was linked and/or relocated to
> > run at. The latter mapping is not active yet at this point, and so
> > symbol references that rely on it will fault.
> > 
> > Given that the core kernel is built without -fPIC, symbol references are
> > typically emitted as absolute, and so any such references occuring in
> > the early startup code will therefore crash the kernel.
> > 
> > While an attempt was made to work around this for the early SEV/SME
> > startup code, by forcing RIP-relative addressing for certain global
> > SEV/SME variables via inline assembly (see snp_cpuid_get_table() for
> > example), RIP-relative addressing must be pervasively enforced for
> > SEV/SME global variables when accessed prior to page table fixups.
> > 
> > __startup_64() already handles this issue for select non-SEV/SME global
> > variables using fixup_pointer(), which adjusts the pointer relative to a
> > `physaddr` argument. To avoid having to pass around this `physaddr`
> > argument across all functions needing to apply pointer fixups, introduce
> > a macro RIP_RELATIVE_REF() which generates a RIP-relative reference to
> > a given global variable. It is used where necessary to force
> > RIP-relative accesses to global variables.
> > 
> > For backporting purposes, this patch makes no attempt at cleaning up
> > other occurrences of this pattern, involving either inline asm or
> > fixup_pointer(). Those will be addressed later.
> > 
> >    [ bp: Call it "rip_rel_ref" everywhere like other code shortens
> >      "rIP-relative reference" and make the asm wrapper __always_inline. ]
> > 
> > The Linux kernel CVE team has assigned CVE-2024-35802 to this issue.
> 
> 
> I'd like to dispute this CVE since it doesn't constitute a security related
> bug. Sure, it might crash a SEV guest during boot but it doesn't constitute
> a security issue per-se.

Isn't crashing SEV guests a problem with "availability"?  That term
comes from the CVE definition of what we need to mark as a CVE, which is
why this one was picked.

thanks,

greg k-h

