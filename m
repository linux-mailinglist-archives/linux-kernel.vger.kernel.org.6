Return-Path: <linux-kernel+bounces-168656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7968BBB92
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4D1CB2168D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56FF225DA;
	Sat,  4 May 2024 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FGtRPxnW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A5557CAE
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714826931; cv=none; b=NQj8B5DFftD/1uZ3t9ZvJdupbTdQf6bgqslSXylWE2NAQ8/6sj07/afkb66sKNzOAWH84bLnLJy1007gs1AHCH6IkjxzsHvOqh8bXmeoK+VDXYWSZgjnx70Rdf+j80hfS5GNnJhPBC3O1BTSjbDSed6R/9SILM/gyKBLTW3RfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714826931; c=relaxed/simple;
	bh=8syyJolbHZMzXr+DXHqN9dTmmG+jbo+LIYyEd/NYkzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0aKqXIJWzniJjIMzNfqm6TTRTBrKgYTvCpUxUC8u7XcRfKzxxz3pVVODRTyPoU79DSC75cy9VCyBszrRwj0uBEgN/8ipzhmk7LtJDenozzvgtFp12mvnFcw2V9RFWEemdnjxV4WdtTUQxPbIDSnq4rnWQ+D+7fqBzhlzFGZrEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FGtRPxnW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5D65340E0205;
	Sat,  4 May 2024 12:48:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3LN0uWBaxltV; Sat,  4 May 2024 12:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714826917; bh=LrJj8vSWMKfbuqba2mvrvHrZRUWSesuObjuOZBfOpQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGtRPxnWV4Yeqv6tiPbhTodrWaB3Kumy7jXfT61O9CtR6CMrbzCslIPq7rjHaHHbb
	 DD2ntL3N4tcV4owRIH4Vdu4t1+F1UChKgOdznpsIEP30eLT9kTY/fDTU3I4ChgeW6R
	 mT4Fsg2WFTKb/BVWrVvGwAyJKThlUVigEDxTcIhrTF+j2dctHPxpI4Ao1tTbYLklni
	 Rd9bB+/Gr+tHKX1IRCALzdEeQFhrR+JNaNyxGnFkflI/hf0qOgIkozPrhDqndBVxiH
	 2LdteTNhX+fVcu7+Uk3I1icf7IfUgHcIrrUXOkGDKF0xy0DwG8tVnVOpiTgimx8pPJ
	 GUIf79sBHZPqumz/l7VyLgARIQCQKpeofAYNvqJkhHbvQRslek02kER2iy7b/Z9FUS
	 jXdy7h3UhwiqJLDRXFL2AjNVja4xRejl5Re5UL0VVwLi/05xlnlsvt2Fq0YfxPY7Kc
	 HM/YL9R5lH6IfGU9RttpG+LSwrp8ZGquwbMD5KAdQ/mQA94ImQ6EpHoAM92pytqwwL
	 BLvFIHjC3PpvPSRSjoyUj4mW2BAPNEMPNMat+U2zD26mBAIxjcnEBz3XPNEGFOqkvr
	 ACL+XEg0RUr5e76nLykkkoK+TxvKt1+MrT/oKsUN41Nxw3hegf/1KMCubXQRUWT6lz
	 xBaBn+ZOQk4dzhnqBDU6xmpQ=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1632040E01A1;
	Sat,  4 May 2024 12:48:29 +0000 (UTC)
Date: Sat, 4 May 2024 14:48:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>,
	kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
	Srikanth Aithal <sraithal@amd.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
References: <202404302233.f27f91b2-oliver.sang@intel.com>
 <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com>
 <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>

On Wed, May 01, 2024 at 12:33:05AM +0200, Borislav Petkov wrote:
> On Tue, Apr 30, 2024 at 12:51:02PM -0700, Sean Christopherson wrote:
> > But that would just mask the underlying problem, it wouldn't actually fix anything
> > other than making the WARN go away.  Unless I'm misreading the splat+code, the
> > issue isn't that init_ia32_feat_ctl() clears VMX late, it's that the BSP sees
> > VMX as fully enabled, but at least one AP sees VMX as disabled.
> > 
> > I don't see how the kernel can expect to function correctly with divergent feature
> > support across CPUs, i.e. the WARN is a _good_ thing in this case, because it
> > alerts the user that their system is messed up, e.g. has a bad BIOS or something.
> 
> Yes, and yes.
> 
> There are two issues. Clearing feature flags after alternatives have
> been applied should not happen, and this particular issue with that box.
> 
> Lemme cook up something in the coming days for the former.

Two simple patches as a reply to this.

Oliver, can you run them on your box pls?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

