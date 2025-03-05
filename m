Return-Path: <linux-kernel+bounces-547857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ED5A50E6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A958F188A98D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F2A266B47;
	Wed,  5 Mar 2025 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KQCET39h"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3B202C4F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213049; cv=none; b=hXchkCH49iZ/BBtW0KrMyli+017yfq/5LUxjaCCMPMXcXV34cv9nIomUUP4LVfrsw7TCp3LGajX/J3XG/e+p2942x+6j/lvC1kQr09S3z3wDqwOANEb1zMBQx8ZBfqbEL6tCPueYtyMR2+PqNys4mdvyGmCwLTFr40t3zJTQzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213049; c=relaxed/simple;
	bh=j+3dxAKvhBH/nzbfkTgZZvFDQSYnG/OD3+syzzVX1OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blw/Njzgu0lSzP5vKhDu8AXjI2sD6jYZXE7EkL1evsi80WSu9/D1UTUubPfFIdWRrlJzb/safg4MLV0R126Fq4kU0qeTLS6m2GOVWaRLg3QNbGOc566t6JDcvJu56cyPGPSYb4AEnTrnDz4T2ZSpOGej72wA8osN3p0mRUWDM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KQCET39h; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DD28C40E016E;
	Wed,  5 Mar 2025 22:17:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DsQG87M9vgFc; Wed,  5 Mar 2025 22:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741213040; bh=e+qvQZlNPXltsQntbquSO1Zp7MTamfVbnl1TwL05exI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQCET39hgf2cjFvYrP/YJcmRHbRy86OXiVL3SL0RCFmKpBORq/18F8oRYUqW7Ymai
	 igcfcnLah5Vf6mfzeh7pIO+k0/kaL0BXIywoKoDK1sQlHB6SWi+XnYlcDeTibEclck
	 PPpcnEvtYuKSuRPzjJLsAdwayy6D3t4zT90GGO9y5T4KDfy//lRAbTmvzH0hKJjDyD
	 eEPxzbYyWDNnnfzWB2TxTEDZdcvNsPyItRqaZ0I3MvzxHkX786mrgZolwjpLjjSibz
	 682YoWLMGvU2sIZbEQ/IKU+2Go9HmKJ28UipTHvmK8r7sqJCgwxRC0apSKjrn0ZeZ4
	 jviCFRF96cBwZz2ZQ9HSJFaM98iL4ZmRJ8jv8omyx7R3mnzadsG3KRcIoBw3P2y/ft
	 o4zqyxMGolEHSQgoEGTvPZLzrdKgta3ltUk9tI5KsCTsIPzD5qQqOaAQK5jvI4Hp0U
	 IONU3h3Q/FvIrcSRALzWuIO8iWrhgTBzzMj1gs9877KEL+pmq7CsGDF10v7xv0VIuF
	 lILT0+kAy+YmDyzKYGMoeEte0zRtXkEKYb3+6W7B7SdHtGh9ZWryHbbwnxaW+VaP5i
	 m1xcQI2mPA4SD1qvpu7KVkfsY38KlFnAT5LWjkXblllgsOJhkr9I7G79Yd7TSDI+33
	 wehTJYdhqvsi6Z4SNMhcNkWg=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9FE040E015E;
	Wed,  5 Mar 2025 22:17:05 +0000 (UTC)
Date: Wed, 5 Mar 2025 23:17:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: coco: mark cc_mask as __maybe_unused
Message-ID: <20250305221700.GPZ8jNXPCFR1w1NyEQ@fat_crate.local>
References: <20250304143340.928503-1-arnd@kernel.org>
 <Z8grEnsAcMrm9sCc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8grEnsAcMrm9sCc@gmail.com>

On Wed, Mar 05, 2025 at 11:44:34AM +0100, Ingo Molnar wrote:
> 
> * Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > When extra warnings are enabled, the cc_mask definition in asm/coco.h
> > causes a build failure with gcc:
> > 
> > arch/x86/include/asm/coco.h:28:18: error: 'cc_mask' defined but not used [-Werror=unused-const-variable=]
> >    28 | static const u64 cc_mask = 0;
> > 
> > Mark this one as __maybe_unused.
> > 
> > Fixes: a0a8d15a798b ("x86/tdx: Preserve shared bit on mprotect()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/x86/include/asm/coco.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
> > index aa6c8f8ca958..9e9204cfca6f 100644
> > --- a/arch/x86/include/asm/coco.h
> > +++ b/arch/x86/include/asm/coco.h
> > @@ -25,7 +25,7 @@ u64 cc_mkdec(u64 val);
> >  void cc_random_init(void);
> >  #else
> >  #define cc_vendor (CC_VENDOR_NONE)
> > -static const u64 cc_mask = 0;
> > +static const __maybe_unused u64 cc_mask = 0;
> 
> So I detest __maybe_unused with a vengeance: the 'maybe' unnecessarily 
> inserts uncertainty & probability language into the text, while there's 
> nothing uncertain about this interface or the code. Why cannot the 
> compiler figure it out?
> 
> Anyway, I'd suggest we change direct usage of cc_mask to a 
> get_cc_mask() inline function instead, this will resolve the warning, 
> plus it avoids some messy looking variable shadowing in tdx.c AFAICS:
> 
>   arch/x86/coco/tdx/tdx.c:static void tdx_setup(u64 *cc_mask)

Touch ~17 spots:

$ git grep -w cc_mask arch/x86 | wc -l
17

just because of some stupid gcc extra warning switch?

I say disable the gcc warning. Pfft.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

