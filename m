Return-Path: <linux-kernel+bounces-381810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF919B04C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB03B24713
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325041FB892;
	Fri, 25 Oct 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Mx76r0k8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418781F757F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864547; cv=none; b=uUCcz9/XFqN+KM9lG0XX95V8l0qQbai2PPP3M7vN3e5RWhofHI4SDNv3hTswgV7aGpe3dcQPA8947upUrQDfhXulFHdAtgF34DOwWH8notpKLAiVol5TZnLt8FCzvnsHxv0i+i7m+1U1vaDghFaIg/5rvnzmxNhP9mM9K70jV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864547; c=relaxed/simple;
	bh=DQ0/rg+z88VnXrSyhIgvv/dMo9+SdSDvVHxRSwOgnAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc8Lz2bkjjom8dxfYSZh2xqDwtwzeXJZzWi9g4spxFe7fcTWQFe16lGjj8fB43v72onkMHy+RpifUDRGFPVlakNiIMgfyaFJMGoFZ2iWbc/+2mXy4C6nxb8n4I3FNtytafB0/bDXp+6mCnhds6158JvRzhoo2zBcYnm2I+uyfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Mx76r0k8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4F45640E0285;
	Fri, 25 Oct 2024 13:55:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ucfMFbuy8608; Fri, 25 Oct 2024 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729864538; bh=HX2tfoUSd7iSJcyM/gXK/ISog2SXydCMlP2hRgi1wow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mx76r0k8yi+ykg0QPzjFQJSyQtP9ZHRq3xm1A1klfMvcY+3+a3mCGv+I+duyRLwSx
	 KyEZxn7sGSziJ8uV/W4PbIQ3LYLrbPvISQ9rKtPhtjx/vxBzJDqtkc6OWNozMW8sVo
	 /CVKd/v2V1Ab1Xr+zHRnPnzeiHQSu7zp4z5AFFCRpWnk7Yf/CK15czadp9/gdvK4Qu
	 DlJlAQOc2fZ5jXYUEDUdTy/EF9WJEmosuCw9Kwi+CyyoyIUj03D9EawHzX4JdA6heJ
	 NJ+UMQk+RQ3ICuxAXLcO14U+hnoL0kiv8YQJPrYUyHk1aGKutz/BZmwINF5Wzjre+H
	 Tkl09LPRACi7qSRgHfe3NRJBi4uP5hH5LKCWm2zgStLXN4R2NRfhnjVNUiG8dCROD2
	 pdLAJeQNkb9NaejotsmxmHSQ5370pHKB8lt/1709zPBc3tTFCG/LmzlFPAkgvUXEFL
	 cCXx0/risKRNXifT3XPOqLQ440uNVWBdSlNdpWEtP6O+5eM4g1K+q4FW3mTuq4Ghml
	 OyulwrQQDX6x93yh+dCQ4K9Lz9v9UDfzysI6+FLKs8rnlT2ZWsxRfgf2s9MZmqAFYA
	 8i90FtBECzXYzAGGB/iQfLKdsa512vecLYM88MOJKX4JZugKHagavnEldN9O+kndRL
	 soXIWP1uTRX9wA6T4nGXYfOM=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ADDA740E0284;
	Fri, 25 Oct 2024 13:55:28 +0000 (UTC)
Date: Fri, 25 Oct 2024 15:55:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v4 1/8] x86/sev: Prepare for using the RMPREAD
 instruction to access the RMP
Message-ID: <20241025135527.GCZxujT_ffqa2fHoAa@fat_crate.local>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <5e8bbb786f0579b615a5b32bddbf552e0b2c29c8.1729708922.git.thomas.lendacky@amd.com>
 <20241025120920.GNZxuKcBsMvYTd0ki-@fat_crate.local>
 <2dcb1db1-fc1b-0fd0-f878-470cfd22e8e8@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2dcb1db1-fc1b-0fd0-f878-470cfd22e8e8@amd.com>

On Fri, Oct 25, 2024 at 08:47:06AM -0500, Tom Lendacky wrote:
> Just wanted to show you what it looks like. There still is a lot of change
> because of the new argument and using a structure now instead of the
> direct entry.

Ah ok.

> I can change back and maybe add some more detail above the struct names if
> that suffices.

Yeah, I think "struct rmpread" is simply a strange thing to have when there is
an instruction of that name. I think the naming of the structs should aim at
being descriptive as to what they are. Hypothetical example:

struct rmpentry_as_found_in_the_rmptable ...

struct rmpentry_as_returned_by_rmpread

Now make the above shorter by keeping the information. :-)

IOW, on the one hand, "rmpentry_raw" or "rmpentry_direct" or
"rmpentry_<something>", and, OTOH, just "struct rmpentry" kinda makes sense
and it is short enough.

At least how I see it rn...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

