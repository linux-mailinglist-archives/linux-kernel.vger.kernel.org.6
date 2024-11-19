Return-Path: <linux-kernel+bounces-414201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DDA9D24A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721B21F219A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36A71C07F9;
	Tue, 19 Nov 2024 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BB00A0Jj"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D81459F6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015069; cv=none; b=GoY7JEfXtrn26LEBoaMyDIEI1OHej/tYeh8FM1Tk/EDt74DKT3LgmhzrpzK0rrXdiYE5rkwn/Pr0TdSmm9aHnwTATE7gcVkr7wyW8Il4rwy7zkpRibyMCu3Eem3AVpenR2E0Un27NGsmCAB2ZOOf7GgY6qIf/5aLfkz4+gCFo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015069; c=relaxed/simple;
	bh=ReCJNVW+VP6ESUiWczUJS3Vmbti7NVrQ67wMlSiW1Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkqU0uRvlmMf2Ri28KUEFrj+BkLNRGw/bvn5Zn+aMC1stwfa67bR5oB5jfsBrfW67a5KHp/2tUaKU/mJy+HPFHBVs7D8Ihk5clVsz11uKvT6ZtVDUASLRXzBzyrZHYcqqj/BLJCtrBPZiePtBDA5KdHiB73IFf23LiP4JWSHqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BB00A0Jj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C4C440E0269;
	Tue, 19 Nov 2024 11:17:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MliB_GPxp5Jz; Tue, 19 Nov 2024 11:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732015058; bh=WXRJU0gMVsKPKdu1MVjEwd7DZEg12zO/OqiOm3Fk6Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BB00A0Jjh+tmogpklpAGOYTX3sgVKXKz1TSHmBdn59TYCMwkDRmJAHij1x0Xo8MaQ
	 FGLcQXqfUS/FLUTS77AjbvDZZNt1OtXRgvICqccBPe77JRTi/uWs1V9bEhn1eche5J
	 ENHHfrsExowVYGQ/4XlNUk7MeqrKHFptzWxmD8yDdUu/ahLGqMA/fevx2xiTkoAAWJ
	 LcQOU3wqSwwwTFIgCGYcRlg9BXOh9Q5OlGXP+Sq5gvln1c+Y6K0GSYgCzubjrQKtpn
	 c/cdenqQZc3lR8unasg0fMrlHesKaO7tllj6nSJe9zki31Nk1wo+UDvY6yOfCaXl+e
	 E20l+E0YfmIJ7akj9QR1gw6c0uUKFfaJqdKxdRs2qXcvQTBGSF2GXDjJYBX7r5AaRY
	 tACWxEzo3qUB8Rvhht8SCJFtdqvUPHXBzQus1s0R3fjzhKhHmGeQpeFJHA4U8g9nX+
	 8FXJQoeRgbBiULTpv8XPPcp/Eb6/baNqU5z9dN++flXSLa8AMVCSWVWaimwlq9ODBH
	 cJQqw7a6wNRiO05dFQRjL1ssgEZRrtYrCRk+FWl/yw6RW055eNet9ahh4wfvZCW7Y2
	 nZNwm+UMLsJaSAUa4MbLY+1t6jW9sPDakzVKKm+Lez7APEzOi7oivZO5usUxCt7B9Q
	 Cc9SjLezyURj93DNchsaHdf4=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB16740E0261;
	Tue, 19 Nov 2024 11:17:34 +0000 (UTC)
Date: Tue, 19 Nov 2024 12:17:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: x86/amd late microcode thread loading slows down boot
Message-ID: <20241119111728.GAZzxzyHj8U99cEHQ8@fat_crate.local>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
 <Zy0p5DT0SOWsCDn7@antipodes>
 <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
 <3f6a84bd-af4a-4ffa-8205-25b2c9084893@citrix.com>
 <20241115205114.GCZze0QtUKbeXdFEHe@fat_crate.local>
 <ZztZsCgX45rrMOVD@antipodes>
 <20241118152859.GDZztdOyjUvVe17Ua5@fat_crate.local>
 <ZzxsciUu2EL5y13W@antipodes>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzxsciUu2EL5y13W@antipodes>

On Tue, Nov 19, 2024 at 11:46:10AM +0100, Thomas De Schampheleire wrote:
> Note that neither 6.11.x nor 6.6.x already have the global bsp_cpuid_1_eax which
> your patch currently relies on.

That's fine - stable folks usually know what to pick up. If not, I'll provide
backports.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

