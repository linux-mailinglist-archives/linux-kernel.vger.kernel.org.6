Return-Path: <linux-kernel+bounces-565843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A6CA66FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3C588147E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6501E5B77;
	Tue, 18 Mar 2025 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EDobSb3W"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE91EF365
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290684; cv=none; b=bcJL2k40mrN7PnhVru8qPAm6T2GU5/cMeLK2/n2OrFXX92YMLwo6R1l+CP3Xs31qVDvDnsZZNx1n0c9TtUX92KIH5Xx65IC2ZwlD962lAcATwAhsEGf4bUPF3ObkoPy2odmF6uEWT+CIJXaGVGdSyqbz6sAm1jS9i3qnjH/qV6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290684; c=relaxed/simple;
	bh=Rbg+ojlRqO/nHfcpa4/9P0fv4/bKdu4hEzmTwe+n5Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFrpOwdp+EmSraJ2Ze3HR34lJ+Nn4xYgCHp+qXtII1On5GAHrOA2yUsR1p/h1BeX9laBRloso1jxqormTwvvBgsmFgbUx6uhCXCwMCFB8PAHZ1MKAIhtiEjREULuTVDm1C/9ahA7zhvSgOHtZDvBAogWzPh2hXOfqSw2+c1kjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EDobSb3W; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4062140E01D1;
	Tue, 18 Mar 2025 09:37:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0mXVTzEWhNJZ; Tue, 18 Mar 2025 09:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742290669; bh=MHwhiXkMKDlkMVwh66Gzjy0rB5tKGs6VIFBFZDmhtwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDobSb3WnrZt94eLWWy11XpPhv/glaSL2QUGvofdY2HrHG2k2tWFiZaIZc6w2Am2X
	 O6GC4yAv8bC0hAF8PxvhTlHi87EGasPdviWSVhX5G1nDWba3GPYLMSXphK9ThtOfF7
	 907BvjfMGkor1HkdAZbSwNwgguCg9QbDks4nXQq/lxtVsJxkyIYi5e6/xHMspVCFJE
	 60KU9+mvZCfmWt01j1yDNkZAKVZtRMJx6K7wyUdNImhrHkR5jd0G/c3055ckUTZQrJ
	 ILSRLWBAH3UOnHeDh1foRCz7mSqdPfnlNRmjhkb8WOy6irXNF5VrE0r+22V3DZXD0s
	 x5Z9615N2sGHCdTVOi7jorfEJ7cHpBRogJnvjSO6KtbIwSelkPWn6TP+Z9oh5Ecw9F
	 3x2S0edq1zSTCAIpv7PA4G2nZq5RjoGFz0yqiqa4ltB97kTBbPnYhu2IFlat8ASaaE
	 a/+9ARNDwDY6TnHY86OOm4s2E2/yxKYgDt4vPs4/29lcqM/1SYtcaLnKhr+tFwoTTm
	 rACQliOApJBuVUtygSauHmGU22ue+N15j/VnhnJoP3TWyuSl7npxjn9XJHkbBERGDE
	 evvwxQigqfMfTillO3o/iQ0YDmWHoKUuXMSW1vhObLjz55SZSpxwxODj7OYs5ooSFI
	 X4NFlHiA4FZMXxbJZMucLo/E=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4FE0B40E0215;
	Tue, 18 Mar 2025 09:37:37 +0000 (UTC)
Date: Tue, 18 Mar 2025 10:37:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] x86/cpuid: Use u32 in instead of uint32_t in
 <asm/cpuid/api.h>
Message-ID: <20250318093736.GBZ9k-4Fu_CqwhgYt1@fat_crate.local>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <20250317221824.3738853-6-mingo@kernel.org>
 <b7920c2c-1051-4674-994c-d1b681cf7988@zytor.com>
 <Z9kwIYrOwO8nOpAE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9kwIYrOwO8nOpAE@gmail.com>

On Tue, Mar 18, 2025 at 09:34:41AM +0100, Ingo Molnar wrote:
> That's a stupid rule, I don't know where it came from, and I never 
> enforced it. It's not in Documentation/process/coding-style.rst.

I believe tglx came up with it - section "Changelog" in

Documentation/process/maintainer-tip.rst

Read the examples there.

And you and I have had this conversation already on IRC. I happen to agree
with him that "we" is ambiguous - with all those companies submitting patches
you don't know who's "we" interests are being taken care of.

And if you formulate your commit message in impersonal tone, it reads a lot
clearer. It is simply a lot better this way.

Is it a hard rule? Ofc not - there are exceptions to that rule depending on
the context. But most if the time and IMNSVHO, impersonal formulations read
a lot better and clearer.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

