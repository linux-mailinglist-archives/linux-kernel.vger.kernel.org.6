Return-Path: <linux-kernel+bounces-372749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9819A4CAC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 11:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FA5286441
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ACF1DEFDD;
	Sat, 19 Oct 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="he4Z4e66"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCE18DF7B
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729330689; cv=none; b=ryZke6t+FpYesrNxlF44sr/A4zhEZfqgkQi30MH0nnXkFn+ea0HMOQsdo7YC3XtOnoD/3jj7Fc8FVKXBo0IhB8l4P+0PcIJw+IQv29Jgd/Ln2U4mH3LCVWUsR6gpzWRJ/X3tmwIrrKszTB+Y0KbgubhOD7ackKMv6tiDDm9FQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729330689; c=relaxed/simple;
	bh=btOIK6BW4ZSD7aZbDWOXl+acqUZcsUrPSQbX3xN77no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nypjE5+92C1YiGitZ9XLyXaA0b5qgw+5aAF+QGNg5oLNpa4mqNg2sfUo/+/ix5Rph+HsC3pFpyGC0zRQIncd1uotbd49Pw4PvpSTuuiP2m19rAoOCQttDO1xhNKhzhHlJqjDxJCaAj21ievSit0fRmzxaK8z7sv66dA+AVch/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=he4Z4e66; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A662340E0184;
	Sat, 19 Oct 2024 09:38:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0taFJ5S5lekY; Sat, 19 Oct 2024 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729330680; bh=zj5x/ZdpUa5xEw0W8A3OpnrWRP+ZZI9YL8gGOweZabk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=he4Z4e66cghDbFdurahh4t6usDZ1jxdc+BF1PlklB36TGyufJrK863Scusx7bAb9I
	 Pv9ZSYxNdyONEp5+qfB1xUnxyzezNUh2S/+QGpPPcTh6XPh5JNL2BxB95fH0tvCdLD
	 3mC34bqjUTZqDZxjTQ88VyGxafh321dXGbFXNi9j+bm84H+WtM1hJJemz+R9KXtoDy
	 VTctDJiSfPL4VQ0UDkfs4Zeh+X9mzkrQHlfIRWCNcrlczHAkiql5oIedCWLkpTpm78
	 IYVXh+RbqHfzFNRhnvo7cK5TyMW5Z6N75rdCfFz4EY1VAYGjAppI2zv8C79Eg4YScl
	 Mxy2Rm63jRliYRB4M98vjomx0xhDSAoq+4/4uDMOJ0/EZw95EYz1yV3qJHfznTqvaW
	 HHa8JKL9iBtyk8qoETY7a6XFe8LU4iwKMlEw+qH5Tw1NgC1zQoH2aJTaF4ZhxZDmeY
	 irufepTZIzuXBOTvqQ66ZqjLFV8LpfWZyiXBBUygerdYuRJz5c9TWH88vO3GHDdAYE
	 EAqNof/f2yWYMNRYmmd0YKPyq4B2taQO6Ha+nY4ZiYfB1CPAOAxeWt2e/i+xbOwr1P
	 N/iSXf5Wv4xtH/CppWKEM4uNcBokgswn3mnk2JbynHDcIEFxQAlkOpsew/4+k7GnxJ
	 sSv9MJHBPLPgamY+piMzDQp4=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A84C40E0169;
	Sat, 19 Oct 2024 09:37:55 +0000 (UTC)
Date: Sat, 19 Oct 2024 11:37:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241019093748.GAZxN97LS_dJ3DNrpd@fat_crate.local>
References: <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
 <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
 <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
 <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
 <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
 <320024ab-63af-45eb-a3ae-5486cb2015c0@kernel.dk>
 <20241018175606.GJZxKhNmW9nCLwNS6Z@fat_crate.local>
 <016ecb00-2331-472c-88e4-66b1dbecfc99@kernel.dk>
 <1bb5dd7f-15b5-4d9d-97ef-75ebdc24e7d9@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1bb5dd7f-15b5-4d9d-97ef-75ebdc24e7d9@kernel.dk>

On Fri, Oct 18, 2024 at 05:01:18PM -0600, Jens Axboe wrote:
> I took time out of "would otherwise have had a beer" time on a Friday

No worries, next time we meet at a conference, I'm buying! :-)

> which appears to be here:
> 
> (gdb) l *load_microcode_amd+0x334
> 0xffffffff810914a4 is in load_microcode_amd (arch/x86/kernel/cpu/microcode/amd.c:971).

Ok, first things first, this line 971 points to the code *without* my big
debugging patch. Is that correct?

With my patch that line should be 999 because of the debugging output and
other changes.

Because if so, please run with it because it has a fix for the patch matching
steppings too. And then send me the whole serial log because it'll have debug
info for me to stare at.

Thanks a lot!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

