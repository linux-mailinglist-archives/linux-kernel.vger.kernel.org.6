Return-Path: <linux-kernel+bounces-233699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B6791BBB2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3281A2816EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6785715278D;
	Fri, 28 Jun 2024 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Du8J/8I0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9A1459EF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567668; cv=none; b=ir2lK+d5mwU54K7/gjTExKs7q3iZkDqAThpsXbB64J30b6lvry4UvzU0Ep6ptEOyBn9vUKBwnz3FoQGAuNpbY+Ry2LI1TMuXkcM/KNl73+fqGWfJbD7KPJPHZsvya2lKe6QnwNxbOz4gPHKPvx3chvKqXXVO1YpG/UbTMxZMVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567668; c=relaxed/simple;
	bh=EmVv0o7XnJ6zrKCJAw7/ujVU9Z/vdlgxMgbPffJ/fwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoF3oD+Bb59tcmsGAGEZ0qfr6228fxXUkiMPE1ptFX8iuz+CKFA+82tFFHjtuH23DQmqHO1lOUz0TLwIQoRkgLDBF7BKOB32ttLc5oNNKFcgiLSqiKWuv02cSI95IGAmWI79NouCoZSHvQ6CNDtmfDyZ61aIFz20OMhCTTw7DMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Du8J/8I0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 02EF040E0027;
	Fri, 28 Jun 2024 09:41:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DD5alQo-NxgM; Fri, 28 Jun 2024 09:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719567657; bh=PxPDLt5L2GmiM1p4XdkLTC0sqbxFh3n9anORYSneX7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Du8J/8I0Lq3UhJgeYRP+Tr15hyIIBtlHTcSGLVCMZ9VNtYuTSwGoeOs0bwTRTMXWF
	 osbnthh/RvLcKobniuXT3RRT29ozMVRj1XsiUn4tizkjPryNtDaXSdxNel7V0LtdXJ
	 2SWVT4KG5OynXrsP+NR7muHGIK9+YcvH7v2T77M4HSrNK2xGaSiueZHYtboFXnIGEG
	 4ScfCzAOFrBEOGfPjgm1JRFOuC95gRVGaczIjaM6PHbqTuwR7PGpAYGKWdyT7zeePA
	 17dBq0EMpp/v9RXiLMtwen7U8hue4K5lyPnKgAhtsbcTDSb86ocWVPiOqJfnzv+cwF
	 rpU5PDfMJdfEGdVm3c7UBRg3EpGt0/xUTnMDm4zcsxV32FFe87BlVhlXCvTDqYExLq
	 bfiQyZkLynKUN5p57TihU37Uv12Efr/Fh4mTG+lpWJLpcMbNtMyVyVmxAFHFdF6hez
	 7veKpK/2HqidKKz+07yWRkieX34WKW6+ovoJODPQzQbAoiOw5jDZwtShWgMlkgmZ1n
	 hD//OMLFMKVONlsYkzTZonIGkZYcIZJPAGulvITB+mwn5Mx3ml08to70DYN/RU9CQr
	 jVSl0DCkNd3/zaXFpkDzNQYW/iSE6ZwE1XjUb+LhMlvQ+ZOULdKX2joF3bS99vb8Ut
	 OcqIXwljCt7OBF/79UhNXT/U=
Received: from nazgul.tnic (business-24-134-159-81.pool2.vodafone-ip.de [24.134.159.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 738B440E0192;
	Fri, 28 Jun 2024 09:40:38 +0000 (UTC)
Date: Fri, 28 Jun 2024 11:40:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Maksim Davydov <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v6 3/3] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
Message-ID: <20240628094057.GGZn6FKXHtB_AsrzHl@fat_crate.local>
References: <cover.1719381528.git.jpoimboe@kernel.org>
 <2cbad706a6d5e1da2829e5e123d8d5c80330148c.1719381528.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cbad706a6d5e1da2829e5e123d8d5c80330148c.1719381528.git.jpoimboe@kernel.org>

On Tue, Jun 25, 2024 at 11:02:02PM -0700, Josh Poimboeuf wrote:
> -	/* Mitigate KVM by default */
> -	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
> -	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
> +	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
> +		pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit only\n");

"... VM exit... "

I'll touch up when applying.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

