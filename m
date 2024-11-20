Return-Path: <linux-kernel+bounces-416235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049C9D4257
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F162831ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB11BC061;
	Wed, 20 Nov 2024 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T2VE1pDA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E60155751
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732129430; cv=none; b=VxLdhPCLMo/U+ex6MgShxRPDpdJ54fBkFDCDP2nYqVNW1eswDGp9dpXIiWSXmEr6ajf7HOqWvm+z5JlTXdM3Syr1tdXiEYB56YuzLaxb8RIHfhtdWj4xUNWlNMLhBdQHCJv2YJrO2jHbrQgt4REV0xNwmaDBxp9rii/hoeiBUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732129430; c=relaxed/simple;
	bh=SNseMcotiWfUHH5XA4Rb9g8E8LiVizl5r2o8UsKtJ+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRY2As7EUD7+kncAQ8Ns+GNKfHUEiRPVRbVvdeEQ19cNu857lHGoxwox/pY0Iwzi1nhZUW+ZuBHApnR86byzEDwJ3LS3VTWKabZRTEE6WTqKgP81Trto3Q2LZa9JmeN6nuDcPSnN644Fo7OiGEjtTJNnyCl/9UupZx1+0TqG2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T2VE1pDA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B4FAF40E0275;
	Wed, 20 Nov 2024 19:03:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vHydp66S-MWa; Wed, 20 Nov 2024 19:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732129417; bh=fazILHj+S7I8Ls1rWJXD0uAZMOhdZmULh6p3bwYIoLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2VE1pDAWxeOQoPYly0FmY+yQyMpNYaHOpKgJ6OFz9yQ/LMpfTB8z1sU8yMXmDWaR
	 7MuKmeLAk/sM9EWutR3c/FomM5FeZg9rrt3ZUWeQLBOst3jn0MuG/+I1C1fXaeSpAE
	 +a39urtZIeOOdsHgvHx8xhCGbjrose8FCWuuMBj8MofrWTjBltli/fXecMZyWk1XZG
	 EoWAnuxZvz6MptLAR3G5rLdtI6bJqtC/DFsuixzfHaok2w5DCWTw30Ys7NhEGHTfxd
	 raCXD0XdvtNa6lQs/Ge/XTZ8y4QI4PHyQ9P3/RrnUC2qEnsqMcZ65hcJwNhJZg5Wj+
	 z5Et4uPl+W3PhmlK/zPx4ZgZu9lycFGLe9oeVcKn4JglgNvSj8dm8EHb769e5RM2zM
	 9qG48kS65bbo9dJxBjc5/qtUfwLN6MXB5l4+6w1uvu24RXFe2RrRqG7d6q0A8HeMMr
	 HO5Tzqfb+2ypIPxs3GbxojQ8uCYBOcMHQOkwAJRb3qMOPLY/tSfB8U7x/5jdS+mtV4
	 AGRpwzvNGbNaJKkalo6iKh36C9w5L+uqLsWHPHmUzU6hpUTCoY9+fln/rt5Wa9fIyW
	 1JPpSCg2iwfKeLHWk6gqZyF0ZmlIrJzyc5Qohv4Pee2p9yLs1t5orwee7bbOlgg42J
	 4fc97T6+fsFj47imEE7rf5OU=
Received: from zn.tnic (p200300ea9736a1e2329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a1e2:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D8B340E015E;
	Wed, 20 Nov 2024 19:03:30 +0000 (UTC)
Date: Wed, 20 Nov 2024 20:03:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/sev: Fix dereference NULL return value
Message-ID: <20241120190318.GCZz4ydl5z5mUHrJd4@fat_crate.local>
References: <20241120-fix-dereference-null-x86-sev-v2-1-7e637851dfe2@gmail.com>
 <20241119210336.GEZzz9KMiZwf6R9hwd@fat_crate.local>
 <CAE8VWiKQ4fdeBeoWbGf55QXaqHrEdSCxo5qTJ=S2vKVd5W1scw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8VWiKQ4fdeBeoWbGf55QXaqHrEdSCxo5qTJ=S2vKVd5W1scw@mail.gmail.com>

On Wed, Nov 20, 2024 at 06:23:09PM +0530, Shresth Prasad wrote:
> lookup_address() does return NULL in some paths so I do assume that it

You assume?

Well, do you know or not? You can simply read lookup_address() and more
specifically lookup_address_in_pgd_attr() and see whether it can return NULL
or not.

As to this particular case, I don't think it would return a NULL. Otherwise
something else is very very wrong so perhaps it is better to crash'n'burn
there.

What would happen if you continue instead on a NULL ptr? Would that make sense
either?

Basically, I'm trying to make you think before you send patches. Just because
some silly tool says something is wrong, it doesn't mean you should trust it
blindly.

You analyze the situation and *then* you send a patch, only when it is really
an issue.

> can happen, unless there's a logical reason why it can't (please let me know
> if that's the case). I've also seen it be checked this way in a couple other
> places.

Kernel programming is not voodoo. You read the code and think.

> I'm not sure why you can't open the page but would it help if I was more
> descriptive in the commit message?

SYNOPSYS

Username:
Password:

is what I get.

> Really sorry about that, I completely overlooked it. I'll CC them
> when I resend the patch.

Before you do, I'd like you to turn on brain and think about the questions
above.

And I'd like you to please read

https://kernel.org/doc/html/latest/process/development-process.html

and especially

https://kernel.org/doc/html/latest/process/submitting-patches.html

before you submit more patches.

I'm not typing those to get ignored. I mean, I can ignore emails too if mine
get ignored.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

