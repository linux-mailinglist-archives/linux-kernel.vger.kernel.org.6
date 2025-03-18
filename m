Return-Path: <linux-kernel+bounces-566306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA774A67646
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE93719A753F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991A820CCEA;
	Tue, 18 Mar 2025 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b8UJYrLf"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF091C5F32
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307447; cv=none; b=F41OwGLcbZ71atePLPWI24Q5ykPfN7RP5PS4Qkf/AkWwa4rfQLGVv+S0LJs7B83Q/ECEZCj8YrBxEdlb/7ZhjREsAuiR4TROeEG2LZPKLgwr2QoznRF90tSpmxlZEpYI0u0aQQZAUvlpiwdJfGzw7E9LyDXjE0K8wfXLjkc22Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307447; c=relaxed/simple;
	bh=btDWBaRd0DIT72H6GMrYNOZOGiPjsNf8mksdb0R4LBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiFjaLBEOB/Re8ZGcChjvnFAV0jgvip9M5mSemM2NL131ERdjzCeiK+mBw/+L754Y5haJiyxp/m3nsVWpNtNWUaoTAgbSsnt3kAQAYKkvw0GlOCHKH1ZGsrligXAXzyApXnwB3dA5RjWoNR5XOPGBx5mnXamDTAfLzdF1Trnst4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b8UJYrLf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3B48740E0215;
	Tue, 18 Mar 2025 14:17:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AdyBWF-zrsw7; Tue, 18 Mar 2025 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742307437; bh=IoD9/L+0oGhzZx4Fdha4LEK+hy9DbkXrCwItBqmOsgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8UJYrLf2lqaSxsOL6eaU6NisdovwQk2zBgxoIh3ScEmMOWa6za2tV/nP+RzTevIF
	 xsHKq3PIB858GvhVU12NEJkqwwAuDJG78elRfR0h35m0weYc0aj4VLwzdijczq8fF7
	 edMM8dGwB1/y90ayxmfvMunKJCbLleZXQZm+tvYIcIt1nd6hXAkqvDxnlTejOjIJLT
	 ILkBCy5n51mGsLz7E4fOOyb1lhry/txR8VgOMjj67ZR80hr2+0/VaZx1hDn5nFDlLY
	 qF/QBclXoojpe20MtIZZTT6V78ZIHDBe2SgtV5rd4wn5ih9PILxr98/WrV/0Wez/Os
	 qM9/981Am5Dd/QvI5cSgomhZ4mh4oFbk2DPXPk8j2YW7u3o8HuPxvPDte6MPH+r2v2
	 eovQ0hie3lz8ZT4cropWy1M9UYfriVGCw1EAokGfktyw5JBgwvNPZATBew5PrJDi33
	 SlHdT7NE7CO9DpZG1MaekOV2d2dy8BShl28YVdnVjdRxR0QthUVorA/XmV2Vw79F+V
	 EduJ7VXQHn+IGpseUXGAqVN1zgfWFA179FPe88GMuFRLdHjOktVs6J4Vv19Unp3LWi
	 WR+BtvlK+u8A5HzwuAKDtyGk23tC8loRDz9o0H47Xjx7Guf7JLIqrmYW7gRnwqPpfz
	 O55akOHHkbk5f8ow0ls8wxog=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C007B40E0214;
	Tue, 18 Mar 2025 14:17:04 +0000 (UTC)
Date: Tue, 18 Mar 2025 15:16:59 +0100
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
Subject: MMIO and VERW
Message-ID: <20250318141659.GDZ9mAWwa3dkQDHkCk@fat_crate.local>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <20250310164023.779191-4-david.kaplan@amd.com>
 <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>
 <20250313192606.iijythngqtpx4tyy@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313192606.iijythngqtpx4tyy@desk>

Carving this thing out into a separate thread:

On Thu, Mar 13, 2025 at 12:26:06PM -0700, Pawan Gupta wrote:
> On Thu, Mar 13, 2025 at 10:36:17AM +0100, Borislav Petkov wrote:
> > I'd expect to see:
> > 
> > 	if (mmio_mitigation == MMIO_MITIGATION_AUTO) {
> >                 mmio_mitigation = MMIO_MITIGATION_VERW;
> > 		verw_mitigation_selected = true;
> > 	}
> > 
> >         if (boot_cpu_has_bug(X86_BUG_MDS) || taa_vulnerable())
> >                 verw_mitigation_selected = true;
> > 
> > because the above branch already selected MMIO_MITIGATION_VERW so we might as
> > well set verw_mitigation_selected, right?
> 
> There is a subtle difference between setting verw_mitigation_selected and
> MMIO_MITIGATION_VERW. The former is a system-wide switch that indicates
> VERW is needed at both kernel-exit and VMenter. MMIO Stale Data is
> different from other VERW based mitigations because it only requires VERW
> at VMenter, when not affected by MDS/TAA. So, turning the system-wide knob
> here would be wrong.

Realistically speaking, do we have a machine where you *only* enable VERW on
VMENTER?

I'm not talking about some experimentation scenario where one measures which
mitigations cost how much.

Do we have a real-life hw configuration where the *only* VERW mitigation
needed is at VMENTER because that machine is affected *only* by MMIO and no
other VERW-based mitigation is needed?

Because if not, we might as well drop that too-special distinction and
simplify that maze of nasty conditional spaghetti...

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

