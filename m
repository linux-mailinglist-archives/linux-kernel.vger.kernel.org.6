Return-Path: <linux-kernel+bounces-169466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E536A8BC90C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5DF1C216A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749571419BC;
	Mon,  6 May 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="N9aIPZr3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC6C1419B1
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982539; cv=none; b=EqX1zquzySN7wt8457jjqZ91MNcN/a9LcV31nV3+Jz5lPSutQRehhjinB8dsVXOPj2dyJKSoGGRlN30DxEK5O7Eaj81+FP8HTY905xOMDIHGjcPUI8rargmdhabSR+EhnkIcEjR1qIxdxwhZaf0HLhtuFGKPaRRuItXaLMp9jFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982539; c=relaxed/simple;
	bh=Uf4paWgOIqvMSE0fNiE5UNBkS47qJqVrHGJHlBjOH/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/9Ezv/eAefEBhNm1Gff+iHtHC4sCJZKPXpQcuNJ8FvApH4u0gCI3IB2ImZ420/dk9Oi82p+nDpg2KEDBr51CcDzJzLaaNf/jZcuQJiLtSRRXgb0UrCs0DZ4XEviFGQ+E/38pfuHegonaYuZdngz6+DbGfHIXb+zXjlKTlvFkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=N9aIPZr3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6E7FE40E0187;
	Mon,  6 May 2024 08:02:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i2Kbl3yc4FJt; Mon,  6 May 2024 08:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714982531; bh=GaT3oEVvy69fU4t49JMQnb0cOcFbN8DHi1q4ekjahE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9aIPZr3alfJuI8mXjLutjVbfRm5qigRQMmwzBNOqs/tuQEIJV+gUYAwifK6r0ZOb
	 AEqWGcmFfBG252F5lk4gtabdjCcKpQiYSEUEhtjT7zxfMoOykoY1EjCYn2ojYHrdGI
	 73MbjycrY+5IpiUCutw9uW5ooaOZrdO2TdNQz3POskxvPupJUYRrWGJ9hBktEzMP52
	 5wbAYjzusoj6hRh7B84nIHLqoTCzYMWb09YbgINpB9pyRka6O/kq4MsLgFtcHKENJN
	 hvB6+AuJ/cSm6/JWeWbSfoUTWCSrkWv/yaGWKhA7FghUOP0zhHLlQTk9Iz08XHu7qO
	 lNW6v/sWOmo+8X/sqaqhOdOz4GN3yGfTXEeDokDQa1o7S4VofGF2DdRGL551SN+p9s
	 C2c+MwI8jkwDH2M5egjzDOjgGsnPXkNu0vuowhj7DbJ7gfWTTq70tgVpZU5Rc9lEBG
	 +VQVMl2bYNtHssFtOCXBf2iefau/Ho6bPQldxohIHSXlXf0TDXXHK0W3Hsua+sV6A3
	 XDqkXGxK4cZtjW6DU+1VgSn5Aa99pVPKlhPGwaFYatdFrwwxKMRMMWMXAKylAMYq2o
	 i3G/u6v5yiu3Pt9CUbd7DtQn6eas4QMTSgpQMkj55GCa3urZt2oxdPPeFdNlLGaamt
	 N3K7bWBH7/wW1FnZmlyEK2GA=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3960640E024C;
	Mon,  6 May 2024 08:02:03 +0000 (UTC)
Date: Mon, 6 May 2024 10:01:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <20240506080156.GBZjiOdHjn-NdmbnTw@fat_crate.local>
References: <202404302233.f27f91b2-oliver.sang@intel.com>
 <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com>
 <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
 <ZjiCJz4myN2DLnZ5@xsang-OptiPlex-9020>
 <20240506073903.GAZjiJF7BQyjYJQLYx@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240506073903.GAZjiJF7BQyjYJQLYx@fat_crate.local>

On Mon, May 06, 2024 at 09:39:03AM +0200, Borislav Petkov wrote:
> On Mon, May 06, 2024 at 03:09:27PM +0800, Oliver Sang wrote:
> > we confirmed after applying them upon ee8962082a, the WARNING which was reported
> > in our original report cannot be reproduced any longer.
> > 
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> 
> Thanks a lot for testing - much appreciated.

Hm, ok, after looking at this more, I think I'm going to go with patch
2 only.

And patch 1 is wrong. At least for now, lemme explain:

So before it, we'd do

	if (boot_cpu_has(feature))
		WARN_ON(alternatives_patched);

when clearing feature flags, meaning: if the flag is set on the BSP,
that means, alternatives have patched already and we're clearing
potentially on another CPU and it'll warn because it will be wrong.

If we do:

	if (c && cpu_has(c, feature))
 		WARN_ON(alternatives_patched);

then it would warn on *every* CPU but it doesn't need to *BECAUSE* the
alternatives patching is controlled by the boot_cpu_data checks for the
BSP - not the AP ones.

So if the BSP doesn't have the feature, we can just as well clear it on
the APs as it wouldn't have any effect on conditionals further on.

Otherwise, we'll have to go and move every clear_cpu_cap() call after
alternatives have patched to before that, which would be insane.

I mean, we'll do that eventually but can't now.

Lemme write that as a comment in the function so that we don't forget.

Oh boy, I love our feature flags infra. :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

