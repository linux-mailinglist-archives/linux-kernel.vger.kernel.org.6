Return-Path: <linux-kernel+bounces-197329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552AA8D695E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23301F27083
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90DF7FBA8;
	Fri, 31 May 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kqfWhaCO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8937C78B4E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182256; cv=none; b=o/hRWHTHYGj+/guQbWk5uiY64MHkSChgbR4000xmmewC4q7PFNtKABSIzC9G4mVzSzRAsO+9+ct4dAsHuWce0bb0GtQdRKGHAC3KbS5YUDNd2Qc8JLuTNz1xmeNuB+uQuvOLzontgpIZNLJ+delZ/hmSBoGAS+L1tDLm/f9NCh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182256; c=relaxed/simple;
	bh=j64WrxVCusVPXbcxYdi0BKTNsLqOlTUxz6KOgFj2Stg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfNwYizwNIQe502Qw2LDdWWjOOJI9AAUK99KIyYH8ulsvLNT5e4PI+cUTT1Nk9I+UdgDmPxT0QjTV/8qa4I4CU/BMELvX1G08KzgTrTnG0rV6Fp4nXK+J/EWSfND/F6jGm84mOlrEhnv8kCFKDsXkOfucBew4VHU/MHUo9tpRIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kqfWhaCO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1034840E02B9;
	Fri, 31 May 2024 19:04:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l2pttj_BtIsB; Fri, 31 May 2024 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717182248; bh=YW1GaQV5pIAH1uLSwH78leJY+IrB5jokOW7hJIKbxXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqfWhaCODgXkWjfsspGdVtLTBgaqp/loqAh7i7+IX9+30e6WMkkgycspvZNwvDyUq
	 epaXel9stfbb+BN1kG63I6flVdCfxdl37gipgcfoKDyYgW/BTp1gTr/gnXji3NqosV
	 WLf78hIYBd2D7IQtzFS6F6D/vTyuNsuxPOhMd+ni2XEJUQvQYa0zwC17O5ACP6VRph
	 8p+1mxldzI2NOHcypHop6ByPA5WmyPvNlVRREpgIrjfPLPS3qo1fLcy4T5Q3OCzReW
	 0u/wnOtASONA5l6KpxBSk0mmjqHlKmA1kNt48QgI6QfXt4EZtkmvecmkMckSLnsT88
	 3INtbNS7HpK8T8z6aUvtyelbM6PhCyrc0q/Zxe4cQdVXY3+km1NKZwkoMx44Zy7Yx6
	 RgI7OEu53i9Y4ZYNzpH+za3YmrPZq0Ohn4NvEAqPbGj2SBW3F5GdepDN6y/bx9J2m9
	 QBAjoRF03mY6kTHRvSl+KYLIvWCrNnO/Yv/LRVKMxeeS+y1Q9/tD43qUZueldll1/D
	 USLsyS8pMaob5nLMJ2dHtOA8tfrAasGn4FwkO1qTGxGPyQ+tgvEDeBMQS4fH3XBWtx
	 KeaCA7Di9pRIL/lp2Q4lOk+x3hkuMT7c2CQzyFpba6B9yfSZo8+DWDmMOerTFGomZD
	 FOr/4GAd9CNu2julsqhE7c3w=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63E3F40E02BA;
	Fri, 31 May 2024 19:03:54 +0000 (UTC)
Date: Fri, 31 May 2024 21:03:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 10/15] virt: sev-guest: Choose the VMPCK key based on
 executing VMPL
Message-ID: <20240531190348.GKZlofFDL4ESfpOQ6O@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <b8508f57712e3194484aa8695494eea26abe1b73.1713974291.git.thomas.lendacky@amd.com>
 <20240531125503.GEZlnIp7YobFu7g9iS@fat_crate.local>
 <ad55da28-e5e0-a348-3cbc-d1a80d0ab2bb@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad55da28-e5e0-a348-3cbc-d1a80d0ab2bb@amd.com>

On Fri, May 31, 2024 at 01:36:06PM -0500, Tom Lendacky wrote:
> The sev-guest driver needs to access it. Given it is a driver/module, I
> created the accessor rather than mark the variable EXPORT_SYMBOL_GPL(). Your
> call, I'm fine with either.

Yeah, if the variable doesn't change after init, then you don't really
need an accessor.

> Yes, the driver can and does figure it out. However, this module parameter
> was added in the off chance the default VMPCK gets wiped. Then you can
> reload the driver and use a different (less privileged) VMPCK.

Is that what the text over snp_disable_vmpck() is alluding to?

Or where are we documenting this intended use?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

