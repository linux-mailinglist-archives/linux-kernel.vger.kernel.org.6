Return-Path: <linux-kernel+bounces-387332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF049B4F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4441B1F23276
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4879919882F;
	Tue, 29 Oct 2024 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jgMt3+iq"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C71D54C1;
	Tue, 29 Oct 2024 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219861; cv=none; b=BjJ4c04RyTUmib0HmJUWva2USQm8JAQjo5qa9zexCgO//1KDhsL+hU9y4K8jQEwXzPY2y87UJzNlfbq3oHwLXgvMDN7HvZXQxo+xlmUYmDfFho/ZuejaBNfJBsjcrtGwFvBy//J9nwQV5QYBoPaWI/MRfkhx5bpORe0y8nSAxU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219861; c=relaxed/simple;
	bh=2+yuEOAu+LKdCQN/WPcdYLPl9+hL60E4DMBXAPj/Yuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajTx/0SHgSnhhX6ItrgTP6CWApmpq7vYAp4J33yDrOHxsQ0KgyugnHLDsmUPsAVi9//MqNCcL/jAW2Ja1Wuh6rzgp/1Xc+evEtTaGZJ0SHcGkn2DsQ6yHNvz6GL+6+D2qRTWv3XkAkXNtjRoqhSOohMOTlbsN+8yaKkyJSOmHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jgMt3+iq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 399C040E01A5;
	Tue, 29 Oct 2024 16:37:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fBsKO53u-NG9; Tue, 29 Oct 2024 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730219853; bh=SBGRSxQxOQX14icLwHc1Ecq1o0+9MmKdNtoO11XZbxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgMt3+iqUIagaZPDreDe4umtg8VcuCSbfebXf/+eLhTL+2P8bWMDegJ2yMdbJkYa+
	 Zp6BVPBG26lUlan1KX24DbPoXICAmtq4Rw4Ju/k7dPq9ulDSG2Vllhv8Yg7SYZISuQ
	 ukx0FW1lvoCO5/jXoi7TnSRIK1kV6F4VZqzAPlWlgabOMdv8mdaQwWZczxnmn3cTxq
	 93401n2jxL+lctzTsxOb4G2aFojfDMIwFGEYJdiPUHEgr/eF04Ynu3MxQ20LXKFV4A
	 nGTNGd3T6nNQFWNa/b37chU4kVP3wMdQELbFPm1B6jLYXE4McCr4mSRmfijdrSGKK/
	 uL0rPHKUmpW+5aGky8rBlYk09o6gUOnAXpFoCGtXjarZNOp6yu9nHw9eCGmQ43NJe2
	 /KmifnHXgXCZCAWUiAJwTDS1cYpseKQoDOMTZFs4/wzKjZidoSiKk1ba2cug+E+mgJ
	 Q+Ge9+ZIZgKQKss97XjEzSZmtO0pLMOa8VTZryjBKUJk23G6hDPmCLVFxowa0NjwcD
	 4fIxmuontNtYWs65EjAHa5UXNc8uZOVTIsoQaANwx2WtwLVDKTaNUwek9lFHaFeF07
	 SBn9fY88nhggsEkyUNuv0jf/LWszieoP2cmN4Tcv+VvfE/Nc4UHWiVKI6FgkQtxAT0
	 +MA99Y1WBZOJbbxMAWB0kze0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0F1540E0192;
	Tue, 29 Oct 2024 16:37:19 +0000 (UTC)
Date: Tue, 29 Oct 2024 17:37:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: David Kaplan <David.Kaplan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	hpa@zytor.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH 2/2] x86/bugs: Clean-up verw mitigations
Message-ID: <20241029163712.GPZyEPOHFklQ1d1lMV@fat_crate.local>
References: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
 <20992658d2c79f27de91a474a7b122782be5f04b.1730158506.git.daniel.sneddon@linux.intel.com>
 <20241029113702.GUZyDI3u_6IxiCWOBJ@fat_crate.local>
 <c5fa82d7-e5e9-4612-a238-3c58152c40d0@linux.intel.com>
 <20241029150022.GJZyD4ht9wYcVetdDS@fat_crate.local>
 <f82878e8-fdf7-4a73-93a1-2edf52fc0145@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f82878e8-fdf7-4a73-93a1-2edf52fc0145@linux.intel.com>

On Tue, Oct 29, 2024 at 08:33:51AM -0700, Daniel Sneddon wrote:
> I really like the attack vector idea David is using. I suspect people really
> care about "protect my kernel from bad users" or "protect my host vm from
> guests" more than "protect me from mds and rfds." 

Yeah, exactly!

> I was trying to get rid of the need to do a call to any kind of update
> function where he took the existing function and split it into one for each
> mitigation that needs it. Like you said, different approach same end result
> really.

Right.

Ok, let's concentrate on David's set, then, so that we don't do
unnecessary/doubled work. I'd appreciate it if you took a look at the Intel's
side of things there but please wait until he sends a new version next week.

I guess if all agree with the final result, we could look into taking it for
6.14 or so...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

