Return-Path: <linux-kernel+bounces-387089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144619B4BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEAD283F54
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36729206E8B;
	Tue, 29 Oct 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RYFkNE3l"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F5BA2D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211147; cv=none; b=jkAPyKuUnGcvHbitnCApHkLQ6zDizfr+u64LOh9zYD4TAAWvWgYYqgmpquYEE62/dh+E527AijRAechuGybXloj2xEgCs17F4XsNXIBN8kE2z0h/qk/VfJcJlGcyoYJ3Wb+8W3rY1TdEL/nCo7ebqqAfzKjWrpIE0W24+QfbRfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211147; c=relaxed/simple;
	bh=5GFN0m/CHVclXyrFeNFMUrp+yxUPvcjGX4zRdiM8ypY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkCUXYV0JYbsLtRF/lMBkWRb+wFm4oKeeJuSYnSFiQILm/gaGrjwHRNHm1phAZWO0fpvxTwaB0ZlmWKUGmuJTy3uFL20gt3XjSrQ6TxX9MI9vNGNu2N6m42jCGR9rWmTxqUvYEINgMkfWstrI9NQsri75b1VcN7VcBjlfpH8XFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RYFkNE3l reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3679540E01A5;
	Tue, 29 Oct 2024 14:12:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cNrWIC1oofEQ; Tue, 29 Oct 2024 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730211137; bh=hin8KyxsG5AxepDRuRW9Jbnwhkm/VWMhNCNv08LWdOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYFkNE3lh9Z7T+pe8UUhGOfkqU1tzOg20M1GE3SHeK1Z8NsHa1nolpyX7cTIHJlW1
	 9VPFIRveJZlT5PjflHbDwDx76bHn3tdcOLHv9QoKExxexhiWNuALwUkyrtVkTsGb+O
	 5yxaKmR2Vef9rgTuWt1b8HvfnbQOBHtHpX2/cr+SsIMXXqr10Yzy/0vVhHAO+F3fSE
	 BOpg7mw2CNlBQcz34hVOZ4R1C87ahLEFpsugWZS5O22esSdU4DVT3XveJbB7wPzn9n
	 rt9hCWWRNIte6wg0wi1BTBdJsqwtLAsYmVyecGuosLg0jXa+5fpFODw0bNnkxK+TbI
	 8KeIkpcrKeGYIjwgOvPT8wOJLuVjF5jHKQg5dotzf02GbOHpWTu/YqwREkgefJj9Qn
	 96LGERlSZp2hUVdRxTA5LXz92RSLEZLmoZN2ofbPX2F08aLk+E7PAyA5Yol1tw0j+D
	 t6/k7tUToi7vwWIyvabiRUnI1fqTuJ+6x7yob2BRCAJ45OSU5Esp4nWZcQhJfLDVJN
	 ZIsrdtb5UO4oPKTJPvNPQB0ttKvYZOGkg02xtURScwKNxNl/aY0TTJlxHfkCPbco8W
	 7UdjcPTnQaofnSvXs2Ft7TYSc/Da58l/YD16OHKxphZsOcIDe01xN5PymYM8cJ3GYk
	 qB3/V2YzA1Z4JnpF9KN482to=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 40AB140E0191;
	Tue, 29 Oct 2024 14:12:03 +0000 (UTC)
Date: Tue, 29 Oct 2024 15:11:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Suma Hegde <suma.hegde@amd.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/amd/hsmp: fix compile-testing without
 CONFiG_AMD_NB
Message-ID: <20241029141157.GGZyDtLf8vdjuOORGI@fat_crate.local>
References: <20241029092329.3857004-1-arnd@kernel.org>
 <20241029103316.GBZyC57KGSxyPie3Qu@fat_crate.local>
 <3a5360a4-e5c7-4c97-ab15-778d73f5b5a6@app.fastmail.com>
 <20241029110641.GFZyDBwa2o1a13Bt-T@fat_crate.local>
 <df0cb5c7-71ef-03ab-b0f5-7c95a4065ed4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df0cb5c7-71ef-03ab-b0f5-7c95a4065ed4@linux.intel.com>
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 29, 2024 at 02:40:00PM +0200, Ilpo J=C3=A4rvinen wrote:
> I'm unfortunately left a bit unsure what exactly is your suggestion her=
e,=20
> so could you please elaborate?

My suggestion is, I send it to Linus now so it appears in 6.12-rc6 and th=
us
the build error is gone in every other tree.

> (I'm assuming the big amd_nb series will go through the x86 tree.)

Yeah, eventually. Not now but see above: if the fix appears in mainline n=
ow,
no problems.

Right?

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

