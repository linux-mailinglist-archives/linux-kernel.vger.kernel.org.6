Return-Path: <linux-kernel+bounces-442944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 934CC9EE460
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1D11888A59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000BB211273;
	Thu, 12 Dec 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gu4Su+l8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FEC10F2
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000128; cv=none; b=hZyCsEYxY0ETSRgspEqzpJL7eeI9mSjHgjxpczhgrmQj66MeH1JnDicakiBj4N+tsazjkSaVnaw2oZMfUNwShKU3JZ0/Lgraq3cjOcZ/lf2ctc81U0uXSJhOpIwq99Fp8b3K+1zYa2bIx+SMoKHWd34av+/PuDw/QpXy+xCEVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000128; c=relaxed/simple;
	bh=gv1Fm8Ouv/HCwT45oPjIs6p3Ag/Zg57NJsRNVma7Tw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnUBgCWBv0nu+KjbLc7qs1eVWptpMQFaD6YscWO2ichsJ9ZzRC5MUjBnikPYWdhoJKXPBosOscJgYf29pV7KXLz8Nr8fOAh7XDrFfCbDTjJyti0kEiVcWGtFod+BE5A/VS5pxdURq/KNZMLDPiL1EulHYKAX9DADqj5SIQQO3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gu4Su+l8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 64A9440E02BA;
	Thu, 12 Dec 2024 10:42:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hwshfdfoRq-F; Thu, 12 Dec 2024 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734000119; bh=/iRvr1QEfKcq7AaYI6rQz2llgJwnhnXTb0AvUQMtk14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gu4Su+l8KuVVj2/598vXscyXyI4OUguzjM24oaD9rbj8FGWppLXEcZ3QQ/1zybH3i
	 R7IOoBQDvD/AOH//nZoeQ9plMm5AurE/GvJwdheGlB9h72dwL6JS1/E+OIs1GStWXA
	 z24MUSeec02LrYZZY4gezVHgzbjVkmxIA8Oeq5lzAhBCcazPftkgw5gebvNkMExvJo
	 TdLHfyb+9F0+M8iM7bKVrrQVcLhLA7fGGSqnvXd6FBQ5vINSZQHIc4LkjkNB+cO7k6
	 LQKDnFJLtM7J8mWipwDdVPq5bv1P8+WwTriNrF+zXgAT73tZdS3fDM3mPYNXyL8Poc
	 W+VsBmbcYMRdbABJJenWZaOr6Tt/9HsVe1kgqzWfCNsEi0wNwJxJmeAv7Yy1axJPyg
	 g3AHfCvrYJU1oO8Pnw2GbXZUJBxZjzbDuOocd+i/K2Kv/+/CB4je0teJANvlAWRTPg
	 4CucBPDzdvvWyWBoQ0+t4E5DGpfYhOrtkhdXs/JRvp/KKB6Z4OyQVn7dj6JPzFET/f
	 dne5vizDszrCZB30r+DEFeJx7445OspiMvHGGuOl5vyZGH8qMhxCjTWd/0xQZ7botZ
	 rbN1PFPqCn8r1A21RnsaPBAXa+13WQfBhQa362rB6H+UE3XvEwKPikHmp6fpoHZErV
	 X4dh78xG1XL/tkNRjWD1wGGI=
Received: from zn.tnic (p200300Ea971F93ce329C23FFfeA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93ce:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 486FB40E0163;
	Thu, 12 Dec 2024 10:41:49 +0000 (UTC)
Date: Thu, 12 Dec 2024 11:41:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Message-ID: <20241212104142.GFZ1q95s5J62bjZdq_@fat_crate.local>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-12-david.kaplan@amd.com>
 <20241114064001.v6ogsiaptrh6oixc@desk>
 <LV3PR12MB9265747DB95F1F54E826A971945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB92654B44C7BDB16BA140D342945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20241114161958.GIZzYjLgooyYCECCl0@fat_crate.local>
 <LV3PR12MB92653BF71C474E72CB2C81DB945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20241114233339.ouzvp7pjvlgrnezs@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114233339.ouzvp7pjvlgrnezs@jpoimboe>

On Thu, Nov 14, 2024 at 03:33:39PM -0800, Josh Poimboeuf wrote:
> On Thu, Nov 14, 2024 at 04:45:37PM +0000, Kaplan, David wrote:
> > 1) the CPU is not vulnerable (it doesn't have the bug)
> > 2) the CPU is vulnerable but mitigations=off was passed
> > 3) the CPU is vulnerable but the bug-specific mitigation was disabled (e.g., retbleed=off)
> > 4) the CPU is vulnerable, mitigations were not disabled, but no mitigation is available (perhaps it wasn't compiled in)
> > 
> > We absolutely should not print a message in case #1, because the CPU isn't vulnerable.  And we should probably always print a message in case 4 to warn the user.  Question is really about cases 2 and 3.
> > 
> > Today, some bugs print a message saying the CPU is vulnerable in case 2 and 3 (e.g., gds)
> > Some bugs don't print a message in case 2, but do in case 3 (e.g., spectre_v1)
> > Some don't print a message in case 2 or 3 (e.g., retbleed)
> > 
> > Case 4 is things like where you need SRSO mitigation but CONFIG_MITIGATION_SRSO was disabled.
> > 
> > So which do we want?  It would be nice to be consistent and I can do that while reworking these functions.
> > 
> > If we're going to argue that command line options mean the user knows
> > what they're doing, that's probably an argument for saying do not
> > print anything in cases 2 and 3 (since both relate to explicit command
> > line options).  I'm not sure if it really makes sense to differentiate
> > these cases.
> 
> IMO, mitigations=off shouldn't show any bug-specific messages, as user
> doesn't care about the specifics, they just want everything off.
> 
> That said, they still might want to see some kind of "all mitigations
> disabled" message to indicate the option actually worked.
> 
> For similar reasons I'd argue the bug-specific toggle should show a
> bug-specific vulnerable message.

I guess that makes sense, and the bikeshed is already painted. :)

I mean, there's always

$ grep -r . /sys/devices/system/cpu/vulnerabilities/

so it's not like we don't have that info anywhere...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

