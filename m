Return-Path: <linux-kernel+bounces-246514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 232F592C2F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9D21F2320F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A1017B056;
	Tue,  9 Jul 2024 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YuArT+4K"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5D1B86EF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547936; cv=none; b=qpEH/y9unuN/8VAYPitDDWNk+e3g1t+VQYUozOHqCigpIIJypu9kzjIID63Vl1aYLYTBfHPWaAi5n71tvfTCyYiusweCnC0YbKl0qK+Hp/HAw1LuKnQwXsTvRpYFZBteiMxRFMDCHYn/Nk1pV/YwogHNLuXb/dlEWzGe1BEaOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547936; c=relaxed/simple;
	bh=2eNvl/xWYC9VJQO1x96HbE1syVqzoNUs6zdb3Bvj1l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyjUd7y9KYYn8Lhl70VZKekQHCBSe0m8PZii79me9+Z+1bNZPM1EL2YCKLpPPfXIP1WPmxHjvGjsT6ZkCVvX0N3yFAKgWvHy574O/XRjutz/e7SJeGIFA7K9QYzOnKZYM7lMVp1J7SDu6f2pXDOUw+hH2EWbzLltt7wGhpDYI40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YuArT+4K; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DE50840E0206;
	Tue,  9 Jul 2024 17:58:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id R07gthiQZLLz; Tue,  9 Jul 2024 17:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720547926; bh=CMuzcB6A5nCwmsPwkbVvuQjkT54LvjYCZJ9okC0yd10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuArT+4K8BjlTY8Eonwi6P0K6WbS2e3Fe3cddAJ8Gp6B+sHTmeE+koGWvYAttRJO7
	 toB1ROB0dxoGmVvh0N0cDeNVY8is7Q+3VjvOelBbZVE1zebac0/A5alnBK67RzRa8t
	 U9hStsYDFvnFuc27g7xhukpNFZMjfcBbijzAIFjYMGEjn6y5m0x1XUIQFcKmogP8hr
	 r8NLMstNwLA/kDWTPpA+7/d77B7SvaupTNyIIS/ykJJiLqJdbKsTu2ZrTIJEeVTsa4
	 UwVEAcqMf4W57GF3wYUJS/ttyjzbryMRBCpkdr4yze5erqUYVunazZM6JVuHPsoXNC
	 jhsU4ojqBDYkoFWv6Y97PaOf7Qh7ooftgPJY7vTJyNgVA9olO72TJggZMI7WkOR/IX
	 NBZH50JIxRS6IZyKvCVTYnN5ibeTxRqxnYTCQvhy7YUwRSi/h10QwlHn/21iaHlLBa
	 Hqzhl2ygf5jfVvb7DzylL5WoTTMFtSZcAFV3UnKVu19EpL7h5FZidlf2qOuAC/8HmP
	 KFfhdnLBypugQH+6toyK4mjKiuyKmq64CZaFZyW2FrAYD0Qqfc5IE18jqFSpaXwVPq
	 +89D5piVp9HxlKTu6x1k1sGi5LaaGLS8TRse0WE1Uunf/UjykWXLCxtjc5Tv88KDIt
	 V7A6barVy/OCfuRVZ2FJmeQI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C7A140E0185;
	Tue,  9 Jul 2024 17:58:20 +0000 (UTC)
Date: Tue, 9 Jul 2024 19:58:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Pavin Joseph <me@pavinjoseph.com>,
	Eric Hagberg <ehagberg@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Message-ID: <20240709175819.GNZo16OxP7VuZLTKFx@fat_crate.local>
References: <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
 <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local>
 <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
 <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>
 <ZoxX9mckeu046zed@swahl-home.5wahls.com>
 <CAMj1kXE5OYTxxBEO38dRyYt_J1FNpU-tdkaU8rxvrMLd_k_beg@mail.gmail.com>
 <20240709103742.GCZo0S9md7YyeevRN-@fat_crate.local>
 <Zo1SRIZEhveMwSPX@swahl-home.5wahls.com>
 <20240709164620.GLZo1pXPiG42JH4ylN@fat_crate.local>
 <Zo1rugBl5WWy-1LJ@swahl-home.5wahls.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zo1rugBl5WWy-1LJ@swahl-home.5wahls.com>

On Tue, Jul 09, 2024 at 11:56:26AM -0500, Steve Wahl wrote:
> I will add it.

No, don't add it. This needs to be tested properly first. I'll do a separate
patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

