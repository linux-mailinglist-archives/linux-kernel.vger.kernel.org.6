Return-Path: <linux-kernel+bounces-406542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D015A9C6096
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F431F2153F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87B1217476;
	Tue, 12 Nov 2024 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DAqNZsQl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45B215024
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436886; cv=none; b=ElyQM5Zhp4eg/qmJGkvcg7fUhC0CmN5Cc5c5gq6ZMdInmMRd0s4q1el6cLdLbEFVMTgvQEd1k8N9UIslU7L1KvfEW/T6c5OekUPVnn0fI8u6semZAX79YkO9pkD0Dgm3fzUe3lX+rSq8IoUHyK6GjkNU541nnJIvP3CaWnPmixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436886; c=relaxed/simple;
	bh=YTb1qLrHmHMsGEAxNRo6tLQjnP2TcI98NcLr9gSGJV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONEd8fCukECvs8Y8dk7C3zlaH7F0EE2sE48LOvd9g0U4SUxecfC+15VZO/MLTUWAfEvYlO9K0mjbrAAeMRzbu8RtQJMC3CVevrMpJtjTKEIY5zKXPJtOPr9bMSTi7EAUVvtvNL0hm27CVAiyCcFW02q1a8jUXYbMl6kooElk4fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DAqNZsQl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 55AE340E0274;
	Tue, 12 Nov 2024 18:41:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zDOWT_nimmiv; Tue, 12 Nov 2024 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731436866; bh=CoKLNNwTXIyAolx+5AeEZA4EdXUOdxr99uqs9vW6ZYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAqNZsQlHsheLTfXm9eF2a3ySiR81Ms2tXWpVe5djTVOB8VrXaJgQZUvZmY6oUUXI
	 2EqXT3BStDf+dxOdUuvldFm7IldP+4NHC8HtNHiqwy65APip9zeoF59cc0DUGxW8op
	 DSSIK6pXIsLt93ljDHEVVd3IP/tBQ9ZF9Kq4R58/8A0JCSQCeLPuhLus+N/mQLTwcA
	 gYyeEDP59IcqBIpAytDfYwLMCrBKuUPYE7mh67XZsrz4eWh0hnw2QkHIMylZ5sot3m
	 jAEsBPb/cPfOnZe9COdG0E7J/Op/LIEC+er9/Q7iw8sBF8XA95NDPw0fUTvl9A44u/
	 cN/VCgXRnzmYVmGDfy4giFC71RQ2nS6pRN+NIBAz9G5Ldbgqv94BqBLjdLjQ0MkPTl
	 AQ3lJHM/49vGNWMJ6APF1cGLcqkIcs0eX0/cSBO2LUbLIOE98yIJS4AgIHesycTVsV
	 W1wk0VZlU8u39CIY1PT+2s+vDZDjHxLfJj6eylPvWqSmcU0vc/uhPzhuaDfwWB39xo
	 EEG0xJ2YHAhUYIhYiSeJM+UUSafgC2SvbxCtHWzyNMD6H2sTic4Rt8TKEOYZnipLPG
	 4bO7elAcBgt0l8KYNHitcBDYIldPx21OPMRkph14diWX6mlIyvJ5JbzIueNYlUX7L6
	 Ib9yhSf0W1rK79ImLtJq6Pe4=
Received: from zn.tnic (p200300ea973a3157329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:3157:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D8BB40E019C;
	Tue, 12 Nov 2024 18:40:56 +0000 (UTC)
Date: Tue, 12 Nov 2024 19:40:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v5 2/8] x86/sev: Add support for the RMPREAD instruction
Message-ID: <20241112184046.GBZzOhLrqFxSfdZ968@fat_crate.local>
References: <cover.1730143962.git.thomas.lendacky@amd.com>
 <e228f4264930bc830a7bd514c14ab1c378b69fea.1730143962.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e228f4264930bc830a7bd514c14ab1c378b69fea.1730143962.git.thomas.lendacky@amd.com>

On Mon, Oct 28, 2024 at 02:32:37PM -0500, Tom Lendacky wrote:
> +	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
> +		int ret;
> +
> +		/* RMPREAD */

Now that we know:

		/* Supported in binutils version 2.44 */

> +		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
> +			     : "=a" (ret)
> +			     : "a" (pfn << PAGE_SHIFT), "c" (e)
> +			     : "memory", "cc");
> +

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

