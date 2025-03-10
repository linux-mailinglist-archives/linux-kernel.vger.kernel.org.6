Return-Path: <linux-kernel+bounces-554627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D9FA59AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A4116E6ED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280D122DFA5;
	Mon, 10 Mar 2025 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iz2JRshC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00641B3934
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622783; cv=none; b=Ivz3E2NSm0P5bZ69phBrJnl49d09Sqko9rSvjoidATIEAgg1Tc4of8CuPTA5tcww/QQ9vVnxodPZp/aS7KwVZB5XUIpXZJZtToi1S0EUeZl8/5DyMlMa/0eCp4Kq32sUGAKhn3zL0ncOCCxYhunNhT8oW32h+37Be0p/ANcCzys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622783; c=relaxed/simple;
	bh=APGYXs1BEnnoq8LfKJXSgxKjI3aFJoPjK9myf9kfOjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgGF/GOzp5Yhtb9MRNm1pHD0smhEtK5BeV9QX27RzirLoorKHu4n4dOcOGxZNJQIPL9UZ5HNh9U46VLEP5472eYGyz/jJADktXkHWYeyIh9zSI6QLXNIuAKmVk5l29hymNWiYdG4I/yDPV3gXrxLE26Ku+VoKvOSBgaRTHRR3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iz2JRshC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5721640E0216;
	Mon, 10 Mar 2025 16:06:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JfR_QuA7ggDF; Mon, 10 Mar 2025 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741622776; bh=9mOS1TXvg3O+j4Il+iXSQCr8OzugXCtE1ur2fPNWz2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iz2JRshCAyW7fnXxzh9Uq+D7I/rTlvUxCp+ADPB7TdMW8hfSBEaEudWo0A94f2ksn
	 HnExA4sci9ZFc6vhtYxDWdLO36xJ8lT1kKZzihv6K4WdXKYJzuUvujksW03rZdEwfv
	 SkZe5CA3x4NVcCrarS7sl+tSoLtkHdul9/Sy9vjVvTovnfe2UB4gQXWarOTgwTq9Ol
	 UGvk2prPd77sTDOXmfO1VncbNNOvzeiaWtgMBJZVfzuoVusfhxu+SF2zFSDZr9vhXL
	 lw9pGsE0S5smD6ty/9i9nkUdYqRTIb+u4+UDzxlnr/E6940E5HkWZids+kGz+xuLTM
	 hQ1k4BUfxCs5bzGIb+PV9ZQfGpBSnJO4qowJzVahi9EhwK0madi2U8UQ0+5r6nOE1R
	 9Ou5NSsPiY2QSwKg1v/PGtBC2rHejlVo7V5qDjtheFHGdQrc9oWggfCXfuFVydGbIA
	 U4okxH/ej2e8M8kdLiggHA+1CbsuuEsHwdR8kA0lgonr91zGUOPKJTHORqCq633vqE
	 oUIqlzu7chNxeEPF4nx4gXreH01JSZQEsnSQljihoRdEIHD4xrGJYdDE1Qn6a1VT1g
	 Ma3HJSmv3XEqi/32WR64rGfis/uXOfaIrU2yKgLnTSc0m+xWdviriHmhQA/Lerye8t
	 Tw8XRk+qQEBMiaTJAcMzorIM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BDA5040E0214;
	Mon, 10 Mar 2025 16:06:01 +0000 (UTC)
Date: Mon, 10 Mar 2025 17:06:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Cc: Alexey Gladkov <legion@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250310160600.GUZ88N6Pod4P8eX1xE@fat_crate.local>
References: <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <57b64adb-c7b6-445c-b01b-7b05bd7c919b@suse.com>
 <20250310155537.GSZ88LeX9PQQpeCCaU@fat_crate.local>
 <b79ee8b1-768b-4c25-a665-453c23cf9b6f@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b79ee8b1-768b-4c25-a665-453c23cf9b6f@suse.com>

On Mon, Mar 10, 2025 at 05:00:50PM +0100, Juergen Gross wrote:
> There is work in progress for SEV guests at least.

Nice.
 
> Shouldn't the coco related information be the same regardless of the
> hypervisor beneath?

Right, but...

> IOW: do you envision the coding for populating the coco related sysfs guest
> nodes to be different when running as a KVM or a Hyper-V guest?

... if you have some coco tools which need to read out HV info - for whatever
reason - then they'll have to do:

	if (HV == KVM)
		read /sys/kvm
	else if (HV == Xen)
		read /sys/xen
	else
		...

which we might save them upfront...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

