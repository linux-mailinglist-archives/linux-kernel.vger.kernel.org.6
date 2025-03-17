Return-Path: <linux-kernel+bounces-565104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D5DA660EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239397A7098
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B641FDE2E;
	Mon, 17 Mar 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HMP5NcLw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891131E1E08
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247998; cv=none; b=aFpTzAgTYwJlWCAXvpcWUE78dIFifZ3XfPZteTDDI3UF1w4xk8rlQ1mSAH2VBtTWhMt5alzIGa1OUY1YYH58tbZeEIH4CS39vyYYcNoB5IE8VHKhuG8k+Ze24OT3kteyjquL8PPNetvC0iDIM7lqusobTI3IVLVBxUq+XbxQdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247998; c=relaxed/simple;
	bh=fW8tuiu0H9a/7aalPs+w8kiH5c8CEzBl9Wrfo/TnaC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cp+cBdpcghzrtHZCke/t0l985OjU2JbP9nzaZPf98cjvMNrOp0ydFamewPEKTwx6bdMSGNI+i6myiQUpAR3um9t13+t9IzUJx7C8EuiivqygWUy1EtPSWSewUzziHdvpjIiKV43pL2JVbdSkZ7XFBlKClY8jIV79c9k0f6Se/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HMP5NcLw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4C8C540E0169;
	Mon, 17 Mar 2025 21:46:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Hjy1pqhb-D4R; Mon, 17 Mar 2025 21:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742247986; bh=Ch5psyd+u1vctjnkVvsq2E+w/aIDMo5vSl7P20z9X5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMP5NcLwibFqjeRtSO7uBtHKA3TiPmkMBlyx31S55QWrjr876oJgLCBBsRw+B+J2Q
	 OsWoyp5NgSaBjq7w/YLi2Y37wEARO24iMQipQQRoE8sK/gnGa6aVwU3mvIk7Kc5xwy
	 JCqMKs8seOPmmM9Sdchlu6WLnXObShyuQ4XVbGzpcvZayLR5CbC5LLrHY1OpeSi2Ch
	 BvSogSxM21g0HPRT33lnAsgYcv3YiV6h7QLdVY9CtreEvvOe8bXScdFQLlzUwNBHmX
	 Gp0iFrkd97Fj7lW4ZE8DquQV+Ix34TIPaFbySSHKxWf3k2aKWahdbnDhYGaCvnURxO
	 lE4vJ3eD430Bdb9PDHavEq4QeqKZjOU+yqMC27tlo7WGm/2GqWzeVfNg2dH/3J0DAc
	 oAR5fV3ZpAjajQfTcATx6trKOvcM2isf4CtrO2u483XpCp7tiO8gvAu3ddSS+M04fV
	 /PAs4PfRVyo8effNYlrnibW+/zvP4GhvDIB7uf10tdhd2xjMuPGLXucrB8U1oAOlup
	 mUcL9ZU620p9oUsMipNiloLPemM0uAaKhXl6aEbXgkMbuyR/x+Y2DWLCZGiT2qaxMT
	 kqlo4tZFu3/kZx+Y3d9DEkscSYxaC7K7lqFaJgDa9lnDVHx2iA7oJiwYSNlU7mfyWh
	 wgq6lz2AyjByTqOHaqZ0D9sU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9EE4440E0214;
	Mon, 17 Mar 2025 21:46:15 +0000 (UTC)
Date: Mon, 17 Mar 2025 22:46:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/29] x86: treewide: Introduce
 x86_vendor_amd_or_hygon()
Message-ID: <20250317214609.GJZ9iYId2LhWBgqQ10@fat_crate.local>
References: <20250317164745.4754-1-darwi@linutronix.de>
 <20250317164745.4754-2-darwi@linutronix.de>
 <Z9iXMTIcz5xmqax1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9iXMTIcz5xmqax1@gmail.com>

On Mon, Mar 17, 2025 at 10:42:09PM +0100, Ingo Molnar wrote:
> 
> * Ahmed S. Darwish <darwi@linutronix.de> wrote:
> 
> > -	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
> > -	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
> > +	if (!x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
> >  		return -ENODEV;
> 
> Could we just not do this?
> 
> The above vendor check may or may not be equivalent X86_FEATURE_ZEN1, 
> which we could first assert via a single boot-time check:
> 
> 	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_ZEN1) !=
> 			((boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
> 			  boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)));

No, it's not.

Hygon is family 0x18 AFAIK and ZEN1 is not.

Just drop this patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

