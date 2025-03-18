Return-Path: <linux-kernel+bounces-566675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC22A67B15
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43AE420A79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0612821129C;
	Tue, 18 Mar 2025 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HqRAMYph"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8702B20C481
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319455; cv=none; b=RsjeGo8nNyT56XfwBPuLzXRfN6CpLoCyhaUdcz+vIpHxo2T9f6sXp+rt5IDCj7jK9GSIcJrvXrGU0XeSuSuxHbc/c+swtTVmFAumhq+qd077A9XwJX7bF7Xd/52I+e+pzDcw+C2M9JSQ5kQv/rF4Ps5asH9tH1exqg5G3spMtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319455; c=relaxed/simple;
	bh=H3SNT4l8PbID9nXdkH8k4oai8XsPST939f9Wk7Zx6Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/kFXoC/akUxLGXI3CARAHCWNpfZH70h43I/8H5t08AJ86PjyP+cVKOuAEfvW/im4Dyp1RdLV0l4OpQGDrd2O3tCazz6fe0m+y+pU+W9wkB0o93FUFRSuOi4imz9CbPCwC6ibg+ad50uxFPe8WHihShQ0YLxXLZfpIPDmQjTcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HqRAMYph; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3ADF940E0215;
	Tue, 18 Mar 2025 17:37:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WdBm2-B9m5Zv; Tue, 18 Mar 2025 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742319445; bh=+BBPLIr1XMZO3qk9zM//f2BCEEsTAr4pREmWIM+6Sdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HqRAMYphe5DYOgh9E/1EhHSvVQnRiNo2F0b+iJ/kc5xeTaTzTup8VNMUAHMhKr/qT
	 XS2CKUmZ5GnTIdwMIsXMNg0iMz5ooOc/ZO3sIJS7gyAONoarvTEk9ZmPrW+y+O86gO
	 RRyPtJZOf5jT4Is0VsjsPxYXKqNWWot25cDP3KIP1duMoW9ZaFJH0tt354b1ssIwPB
	 r3urlLmQBqy57dc7UNsgtxd+UqCYuRhkyMpB0+Idv9MiiAy93TTlGQDEcEwYp7eLK2
	 Do89Ec2UiG9wj7JFcqLVFO/nnxk4jWHBpTs/X4zE2Xgj9iwYBdD5lKbq+zHTPnGMH1
	 Jau3+P9CyTPHxNLkAlQ5FMe++ucljMBbFh5LvYFCcQPxLznDj0BVqIWJEdLtSuZd26
	 2FdsTF0+YrTrKUZ7AumWeTyc3V3ORvzyl4HHG8tEDdR5D7IF/RGGTloSbRN4j+wiNC
	 +dpQSxihIdg6o5pdTGcY6/gJjePXayH29bTRImvJJhLpksWWbJHUONGIgR9AF6js1k
	 IRbuENpITufBoBfj9PRVtvJ6MLjolEgTEETUDYId+z5xje9N16R1Sn0RKERfcPwB0j
	 TscJ0/cYZLfz2GCtJPhk97rZQkzWspvXNVGvXWfXiMO5L22PD9DPMRWWuv/UUMwDZF
	 DDNruk0GOGcduMoEbmcBMqEo=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5EB7540E015D;
	Tue, 18 Mar 2025 17:37:13 +0000 (UTC)
Date: Tue, 18 Mar 2025 18:37:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: Re: MMIO and VERW
Message-ID: <20250318173708.GFZ9mvROyNagmhawEV@fat_crate.local>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <20250310164023.779191-4-david.kaplan@amd.com>
 <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>
 <20250313192606.iijythngqtpx4tyy@desk>
 <20250318141659.GDZ9mAWwa3dkQDHkCk@fat_crate.local>
 <20250318162505.3ptnegnjz46hchep@desk>
 <20250318163451.GEZ9mgq7XsE1kIyiSy@fat_crate.local>
 <20250318165645.lnutevfmtld3vu4d@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318165645.lnutevfmtld3vu4d@desk>

On Tue, Mar 18, 2025 at 09:56:45AM -0700, Pawan Gupta wrote:
> On Tue, Mar 18, 2025 at 05:34:51PM +0100, Borislav Petkov wrote:
> > On Tue, Mar 18, 2025 at 09:25:05AM -0700, Pawan Gupta wrote:
> > > Rocket Lake, Comet Lake, Ice Lake with tsx=off only require VERW at
> > > VMENTER. There are other MMIO affected CPUs that are not affected by MDS
> > > and do not support TSX or disable it by default.
> > 
> > So all those CPUs are only affected by MMIO and not affected by neither of
> > those:
> > 
> > TAA, RFDS, MDS
> 
> That is correct, they are not affected by MDS, TAA and RFDS.
> 
> > Or is that the case only when TSX is not enabled/not present there?
> 
> As per the affected CPU table [1], Ice Lake is not affected by TAA even if
> TSX is enabled.

That table is insane - I need at least 4 monitors to stare at it properly. :-P

Anyway, so I'm wondering if we special-case those CPUs and have them select
a special

MMIO_MITIGATION_VERW_VM

case and keep them separate from that whole
CPUs-can-be-affected-by-multiple-vulns and the mitigation for all of them is
VERW.

They will enable mmio_stale_data_clear and will be out of the equation.

Which will make this other logic simpler.

Hmm...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

