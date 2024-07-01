Return-Path: <linux-kernel+bounces-236441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0484091E261
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5EFB2337A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E26D161337;
	Mon,  1 Jul 2024 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R+R4IGwS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114CC5382
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844063; cv=none; b=FDGaSt/8V59HOK1dxX/tD2yGniyhPpQTu27L8wwxuTRPUI//QIwjzRDz6j5dRtUGS1awa0dnedWTfR8QWkA8YjuXhfCZYSZpRfZgTP8d9BO9HY/AyhVG65yx/ZUhXcDFq7vjumbjhccgu1B2adgu/u1AQ6KkfWI+qKeYEWG3XUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844063; c=relaxed/simple;
	bh=VH9nZ7hQRRsC98svIZdC2URLJFqE0PnV6oEzShuSWEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB5/RrPi5thbDiZGtp1cile1dyHsS4T/BUwaMz9s/Q5ZSL70JMNMtP6MbRn1ZymvTBIknXlVOfYf4BqK4o3lcc3SzKSZA1qsi6zmW710TjFmvf5eqT36rKU8or8A8a700ow9M6Bn4TobD9F0SG3aT2rZ5a8EjyUDGuNB3Eg1Dgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R+R4IGwS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 25E9B40E019D;
	Mon,  1 Jul 2024 14:27:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bDY5-49uqcXg; Mon,  1 Jul 2024 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719844056; bh=VSQjB6ex+TJQcIelpjJ2Xl+2a5w1z9t5nh7DFr06oWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+R4IGwSmqO1TjsHDbo4OTcYnHoOaEia3qkOzXZA5Ia0LrGZsTui304IupbXfDboA
	 np930WDE3wNmbeqJ/cZyIiYoX2ZZbGbUSlaTmj1HjC9i2iAaQQFDg9QfpM/FVFldgM
	 a/O3q3jntAO5Ggn+GgiqK8sSl2r8Dty8myvpq91CO21sl6oAGxy2Hy91JSbeLA6gK+
	 mnL1tbwIoQtlvf+n84bKCowL+05MtXJueqKwM5RXVViIO3cFNFjhPMZ7godbuzfgl7
	 MuNseVn5WuGYCykf4jByTe3AXRwFfbsb+ntFwRxrMVzfy+N+UOvV0ojYNqbkYyysw4
	 AresIwIjXJCrqxyAy10o+lvWHfO/oNNCVuQOhxYGCenY9BKmFqQkrg/G5IihQdzW4v
	 Zt3yCTWewOvTPqq7jC+7QT1tD4h9xzGeLt+/dESinjhSBc2yG5QvAPAKQqvgvBf1it
	 CWWrBlgK+lDJOK3Lhbmt+Upi9/2GQ0zai6r/jThPRUyMQG4DypvTHwOFJ9XQSR+b1w
	 o/D7zGIwOt79L8u4RQbxpN8dcQuSA+EW6g9eK6beA/k9v6u4Ii2SjQYSUoMpZwEO4u
	 Kl+VE9g79EGDwpRqDrBavamfj0r7KaQj+cBxmi4gnxc1xUQdrIcWpwCO2osjh3JD/M
	 y84EjG6/PnKSe2ZS/sVtnvqE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D33E40E0185;
	Mon,  1 Jul 2024 14:27:10 +0000 (UTC)
Date: Mon, 1 Jul 2024 16:27:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>,
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
Message-ID: <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
 <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>
 <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
 <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com>

On Mon, Jun 24, 2024 at 10:13:44AM -0500, Steve Wahl wrote:
> These accesses are a problem because they happen prior to establishing
> the page fault interrupt handler that would mend the identity map.  I
> know very little about the AMD SEV feature but reading the code I
> think it may be required to do this before setting up that handler.

Yeah, from looking at it, we should be able to establish a #PF handler that
early too but the devil's in the detail, especially in that early boot code.

Lemme poke some things and people...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

