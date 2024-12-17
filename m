Return-Path: <linux-kernel+bounces-449093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF39F49B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18241188BC3E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78471E6DDD;
	Tue, 17 Dec 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bA5nD0Rn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360A23DE;
	Tue, 17 Dec 2024 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434292; cv=none; b=BQP7yEHoyY4kkWVa6lx2hXR1u4535VenfgvvUDtX/b5qphq6oTMWpyM4WLHm2hjpL4AqZjxAlrVVA7J5ptbr1rShXCOtRNJzS3aSmny+4sXoQsXMppQONoFtsIixBtYU2dZBQ+k72E69fDmm77yXrbVx0a5ildIYfGDeWKx8rRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434292; c=relaxed/simple;
	bh=zVlgGm7llyHh3iAC7Y9aQ+41J5IKUVHaEdnfYZYt0jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aASrMFpu66Aw3i9vsXotkp7iyMC4uoTFPCuIa5Xm9gcFKuJqJwlZ71m1vOZUxiRV1/OMiXdgHzwrzwKNvKPkP2cNOYDq9tAH14uJIN43LfpzWQzkgIItQWf8BSIiYPTcD+S+1Mf042x2x05zMaQgzD7hNMk93dRUa7DzXIyHpbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bA5nD0Rn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 922C640E01F9;
	Tue, 17 Dec 2024 11:18:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rQNDIJLZNdIg; Tue, 17 Dec 2024 11:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734434283; bh=Z5pyBMHWLs0LeJFECe0k4HwjZB4HaJ8rUIWKRHTqFoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bA5nD0Rnc/rr8I+Q9c0prBMBlgk5no8MJT9E7HL0haS/ELjK+xMGysmcMu2y1tSjF
	 qEmt1+KrTV0Vdkqrr7bNGJb1EBRu4SAlxaJYigDA5iQIZhA6GUeqmyCUzNkXcD2vR5
	 m4mXWvvcxKWQX+DC3XxkwcKHsx8tPTMDo6if58/O3ZvbQw0JVkoMdZXUe1t1wIFQr4
	 jcnrDr6zpDtdsvrGUae3eUGbrMOhr0PucyE1n2mxtz59RBYOEyALa4civmQL6fvaur
	 gOH32Nod4J/nJavHVooC8n9V/v59eufbvGP1YOP87e1c0+QrYTNksRZ4kINz89VGxj
	 f8Ymn+2UliBUk0oB0nbh8eqWO+cEpzVwZfyIT7wBSQQdHS6eCX+SvSoS6PKyVoTRSj
	 rwqODbKl709n9FJ2qr6fe7uzAyuPMIaboHxG3tgAU5vSMn3ZYVkJLShN3pJL6a+raA
	 GgZaGnzZyssvhMwJIUjmOM73ujTLhHMIqG7L7BtpVom7uRgnFlwp/1gl/4XE+3+DYm
	 +VHG6cgKrSB2SWXVwB/ao4sFvI9tWzYE3SStG0Tf92cBvbWX6JZG0oeQhudYNbKGl0
	 yjvjQOPI2Tv8eJUTipRKhq8Unwtwqb9gLFc99RgbE5qIEUwrjgis6GAYMjqWQZnUWL
	 sUpEaUETDb0rN9ewYQpOUVuQ=
Received: from zn.tnic (p200300eA971f937D329c23fFfeA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:937d:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4746F40E0277;
	Tue, 17 Dec 2024 11:17:53 +0000 (UTC)
Date: Tue, 17 Dec 2024 12:17:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Add force_cpu_bug= cmdline param
Message-ID: <20241217111752.GDZ2Fd4E4XX-w_t6eq@fat_crate.local>
References: <20241119-force-cpu-bug-v1-1-2aa31c6c1ccf@google.com>
 <20241216171700.GIZ2BgjPerQ8jQlq8S@fat_crate.local>
 <CA+i-1C1HeLfbGg=LdXBYuhXWVPn1O0qtEYxFRYaXPUch4goEtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+i-1C1HeLfbGg=LdXBYuhXWVPn1O0qtEYxFRYaXPUch4goEtA@mail.gmail.com>

On Mon, Dec 16, 2024 at 06:58:24PM +0100, Brendan Jackman wrote:
> OK yeah, tainting definitely makes sense, I think that goes quite a
> long way to avoid bogus bug reports?

It was my feeble attempt back then to leave enough breadcrumbs so that when
I see a bug report, I can say: "well, then don't do that then" and mark it as
invalid. :)

> I will also update the docs to sound scarier.

Right.

> So do you think we should allow setting arbitrary cpu features? That
> seems like a much bigger footgun. But then again, the difference
> between "big footgun" and "very big footgun" is not that important,
> either way it needs to be clear to users that this is a scary red
> button.

Yeah, with your patch we're half-way there. Might as well do the whole thing
but again, this is only my opinion. Probably should hear what others have to
say first...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

