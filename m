Return-Path: <linux-kernel+bounces-204542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68408FF048
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2D01F25F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0009C1990D7;
	Thu,  6 Jun 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ItvtGbXz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF11974F3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686072; cv=none; b=CgWR2O4P8ecpwG8KL+K3ExZFTqyc6R9OikxNjdS8BxnRrwi3WC4pwjg6iXANNQL79BElhasnNsW40BTtvCXAxn2bFNoQNreHS6GJFyQkQMsH8FqMCgNzqJW7/d4TnXlDdb3Oe4F8KbnOmvi8HziDJh/ojTgf2cfV5iLJB1W8siw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686072; c=relaxed/simple;
	bh=DLfwn+tz3KuK69aZia+f28M9frKP4CLherTnnBT3+K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/R+mBzENmaOe/NYO1eacigLLKrazCIiO8aCi2pzTmIE9+/xqy/3SBRm8gHdmJ0TDI0z5lzSm38Qtq/0CkKghjsRPCZU8xg3fwhq72+mVlpxFVQ69hQd+VjEgtZQzF8H1fv6NtdgUFRzlWZzs8wL3ChAEd1shvuGAUKeC2JdWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ItvtGbXz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D4C9E40E0177;
	Thu,  6 Jun 2024 15:01:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3sUdZ6rGlRDf; Thu,  6 Jun 2024 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717686062; bh=WgrSS/ED+LAZpW09vzWpeNutxX7CMV63x973GaxMinw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItvtGbXzKKdlYJeC6bWkoHgIqTWjWdCok+CZlnv7HIO7x8mKuxVUt+5XEUGbeW08J
	 rWhkIqLidwPUPkKQBcXddzfHQ0O5B8UVuJYtIY634seUkisWTbByd7ueQU3JUzeYYf
	 hyrZZYVa4KT1Pg7k6DCrTElSQxCH3Uo+QlOc2w11Z4JDnMsNFf/M16/Q6QAal3IcjB
	 RVSfPYpPFXJYAmY5fQY+6LJbgxtgdRBxEnkb0wz/TzwJQ4bs/XBk2mnkenhbIzuQEg
	 USJGlRz547n9WAI/Sst2NofGNqh8Ly6yD+7RHPZhfilcL9yY1r/KhX7AaJ55IVkg8b
	 8rKFNds4wI9deoOymTq5X2gus6Lvzjy0QWFmJsNgbMyo6mtr+3GPviKXXVFYZlID4P
	 XKs3aEpxERVS/C3CAIfS73jU09u05wLQxIEGmtvxbIVEeWjTzBVcrtNIPcxzqqZcjq
	 yowMXUhfQvFqcStf1XBdsIZKAgkSbvqmtex7lxO+NTchDIHtb+gvtpiidp3zhdf/XU
	 MzMh7U7BXoltuyXEY3CaI+w4JysHRzMfRhEbv3hGosf5Z0aW4TiH6PEYnFXhH6Frni
	 llAE6w/pWZH4ky9cfCoLsiQxO5aCh+esZX59EMTlYOvMt6aRDZntT/aGosjpyTW9A8
	 tmmr2+yNd4HFJxSgYf4mDuqM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30D8040E016C;
	Thu,  6 Jun 2024 15:00:59 +0000 (UTC)
Date: Thu, 6 Jun 2024 17:00:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Christian Heusel <christian@heusel.eu>
Cc: x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] tools/x86/kcpuid: Add missing dir via Makefile
Message-ID: <20240606150058.GCZmHPKrokYdMuRLL7@fat_crate.local>
References: <20240531111757.719528-2-christian@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531111757.719528-2-christian@heusel.eu>

Lemme fix CC addresses too. :-\

On Fri, May 31, 2024 at 01:17:58PM +0200, Christian Heusel wrote:
> So far the Makefile just installed the csv into $(HWDATADIR)/cpuid.csv,
> which made it unaware about $DESTDIR. Add $DESTDIR to the install
> command and while we are at it also create the directory, should it not
> exist already. This eases the packaging of kcpuid and allows i.e. for
> the install on arch to look like this:
> 
>     make BINDIR=/usr/bin DESTDIR="$pkgdir" -C tools/arch/x86/kcpuid install

Stupid question: is DESTDIR something that distro packaging machinery
uses? Dunno, some Linux packaging standards thing or so?

I.e., I wanna make sure this as generic and as easy for packaging as
possible.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

