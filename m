Return-Path: <linux-kernel+bounces-549063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC077A54CB9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200C57A2487
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D20D1494C2;
	Thu,  6 Mar 2025 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e+wphZqm"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91B13D509
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269429; cv=none; b=oprnJg9SOJgbA7OxZmmeWnSuiSNSDbBxfeJEQa8cACjcE1+gGhbAawrAQ0E3xG9Gzc0MhTTDdQtqwXIEp0SxV8EDZ3d0N8kpcfMRBAZnApF1+RZRRaJ9i/aSkl40s8VK5j+jH92gInLbdMsKsiHOXyK3g1BFy9VBC+zPA9/lM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269429; c=relaxed/simple;
	bh=er6oZz5O/WooIXHCZyUo2jyu6lYSX/HBLqOjXE8lcj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1TwqaBAJrkINvjmERXLixZ91Y+VeIuKNyalC7cffZXoA5/d4DvmDw8KhgtBNLlWPGZS0pgwMGHq8jiUOSgAQz6ElMEqvoPwpff2JVK/Kst6JW7qm4GyAJRyckVZtu9OltwKMbn3li+Y20w8ZF3PiaBTnCBIHoOS3IBrz/xDtiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e+wphZqm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 14DB940E0216;
	Thu,  6 Mar 2025 13:57:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wu1CSu6ipVSK; Thu,  6 Mar 2025 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741269418; bh=ZDRyFO8xoL1EwvW5xjpaIXAHgZR9VNEcIZwSJDhFY5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+wphZqmoLl2jxni62URrCi/XdlQOycokgiK0lBVrOiLnXHfpT7rtS3RTfMVQ5rwt
	 NBksJyOSofzMhruc5zQzsqD0ZMhUbQCn8qz9OFzWUZVmNUSg5oOkXKAnMH6qDg2DYz
	 +ESxEPEq6KYhTY6mPqGWtE0NXPokNe25jBEi8J7yiiN/qhRYRA7xIyLRXWP+zRpvuj
	 zXI+rEgScDmqR/9CB6erExxj3rJth9HygoobY/36ORbWIck9aPpBi6w2ey9Ej0FiWM
	 Q2x34CLkQJB3cCQZ0t8R3u8tyS1IKNK/97QdekMzcL7BMi6VryyctGU4xNFdXhHTjC
	 +RGbQ9WugbcCr1sOakFko+4jT7Lj1UUi6l7Is6fi7Y5fJA3ncZDx263ZC05bhuO4Hy
	 yqaPQSClojq+OnfNZyRlUPQYpNzQoexjAWiDGqE5JIAOPLgvWUjJ4HcnlMEOtgpsnW
	 Hp/yWW3TK+8j/A1nn05efUSWB8Ciyq1fFIRk3Aznc4btp04IHEFbyBZzkN4x+egUgD
	 fNh4g8T6Wxh14rMPq3lj3vdHmlWX6ZPPd48OJzCq7SOXV6knjyBp7+ze3PlicwhngS
	 lYI1SDPbcbF/x41yb4+g/xNdTCsfIEo9rFrfscFf7yq7p9TrXMIBAKU6UIM88gO5A7
	 bndfXRNamJA2PaTmkvfSa9/Y=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5507740E016E;
	Thu,  6 Mar 2025 13:56:46 +0000 (UTC)
Date: Thu, 6 Mar 2025 14:56:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>,
	Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250306135518.GDZ8mpRoSsBt_m0K9j@fat_crate.local>
References: <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
 <20250306103119.GAZ8l5d-brstBbLDEH@fat_crate.local>
 <efbnludlccxde7bwt64faajkmadufyolcetl5at3anmvy5mi36@5q6zdzmwtvae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efbnludlccxde7bwt64faajkmadufyolcetl5at3anmvy5mi36@5q6zdzmwtvae>

On Thu, Mar 06, 2025 at 03:36:02PM +0200, Kirill A. Shutemov wrote:
> I think we should be pretty use to one-datum-per-file thing by now.
> I don't see why coco case is special.

I want to avoid all the boilerplate code for each sysfs node. And it doesn't
matter if you do:

cat /proc/coco

or

grep -r . /sys/.../coco/

And you can't format sysfs output in a human-readable fashion if you have to
dump registers like SEV_STATUS, which started that whole conversation.

But if everybody is crazy about sysfs, I ...

  [ /me goes and looks up the proverb people fancy using nowadays... ]

... I won't die on that hill.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

