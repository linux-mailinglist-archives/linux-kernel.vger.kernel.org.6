Return-Path: <linux-kernel+bounces-447811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5659F3749
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BF057A645B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD312066DB;
	Mon, 16 Dec 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cnZ0QLDQ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702225634;
	Mon, 16 Dec 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369448; cv=none; b=mRjpLs74fHChjmQeFxCxyjNdHy1JW/WgHeIMeyTGv3qUHO346DujATndMvWkbdm/zQYyuIEixVJsGsJoTfuiY5leOe4ZTa8PKvqfyAyZ78MOTkvRqvpySBRU7CIqRApOw4dpdCuvkvu5uEOKEb9kxfE1QtwQt0zhTlpVnEY14SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369448; c=relaxed/simple;
	bh=r/QqRRCnIE15QgckST2cLkl7rB8ppKDt8toYRMStmLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDG+ZADAUt3Sa1WLP7HUaULPjX2WxkX97bg6X0ilCdO+UKC+BWyU5bhoabg3z5UVG8hJbHgN5xRRDCu70lEQ9lsGOWMnOy90OE0YnHPTv6E+gEd7UHsgSbwcdZwrVzn39PKcsYhzJEIpCFGqRFfEB9b0D/Lw38MfJEBHAsMwP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cnZ0QLDQ reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C5C0140E0289;
	Mon, 16 Dec 2024 17:17:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NsDxXoZpXKQP; Mon, 16 Dec 2024 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734369438; bh=obVPl1Kx2LtXcxiFHkbhephe6RTItDCls1lwtax1Wdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnZ0QLDQZ06xKKuLe1RDKA0x4LWyQq2AGki97VTaV9e3cmsZhAtXuPuh8ubKwmKJ6
	 X6CvWoGHm/uhv6H+924q9/vFMOl03LPhWgkXh2g/L0vV7JBT3dCbsyrvlTfSBnAa1T
	 4E11HrX+bIBb/AD2r17iYc45us6HChfHgtoQly79KC5O5dxIacmtwGZBZKdzbxjfxR
	 59T4xXmSCfFPVI2kpFORKvqd2ab/JjafAhQ34ThXsyhf2cL9MS84l3z/aka8zwyyHS
	 tXv7pSwPsVfGXklUXMqqeUOUB617xo8B3uRTL7gLjc7DV6AKxsUzT+x+4FFzyyg/Oq
	 UoIRUSrZMtjcErhMiInube6w6lqmIFPKYfZEs/qp+o7u2LoWJDvypxCqVX6zRmkntN
	 f4v/rSuSDxEzHbyhPEdCbTGLPygwn7JQA9ycU6D0BCG940r7Ih7BL/D8ArKuz8fkt+
	 Kc1Bw4EEDDf3MSeOUioc2aYlMb+JhCUtCMtEU3a0yaAsicxVrQyVX3HCPEbOrJU/3k
	 GmO/oLSM6PvyHkJ2Zu9PFnX2tgZDBkpuA/G/yLFl7FAdhat3wJXcaXosDoiYPeGwjs
	 7dqyvGWLT+QEEdG3meDjOypm1+atliVavtYTKbhbg0yMi/99rr2FGFpdalxG0it4EG
	 vQxHdjunrNmEKdcKBDV5OIQE=
Received: from zn.tnic (p200300ea971f937d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:937d:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FA3B40E0269;
	Mon, 16 Dec 2024 17:17:08 +0000 (UTC)
Date: Mon, 16 Dec 2024 18:17:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Add force_cpu_bug= cmdline param
Message-ID: <20241216171700.GIZ2BgjPerQ8jQlq8S@fat_crate.local>
References: <20241119-force-cpu-bug-v1-1-2aa31c6c1ccf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119-force-cpu-bug-v1-1-2aa31c6c1ccf@google.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 06:43:57PM +0000, Brendan Jackman wrote:
> Sometimes it can be very useful to run CPU vulnerability mitigations on
> systems where they aren't known to mitigate any real-world
> vulnerabilities. This can be handy for mundane reasons like "I wanna
> debug this on the machine that quickly", but also for research reasons:
> while some mitigations are focussed on individual vulns and uarches,

Unknown word [focussed] in commit message.
Suggestions: ['focused', 'focuses', 'cussed', 'fussed', 'foxed', "focus's=
", 'flossed', 'coursed', 'focus', 'fused', 'cursed', 'fessed', 'refocused=
', "ficus's"]

Spellchecker pls.

> others are fairly general, and it's strategically useful to have an ide=
a
> how they'd perform on systems where we don't currently need them.

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Also, see section "Changelog" in
Documentation/process/maintainer-tip.rst

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

Also check your comments in the code pls.

> As evidence for this being useful, a flag specifically for Retbleed was
> added in commit 5c9a92dec323 ("x86/bugs: Add retbleed=3Dforce").
>=20
> It's a bit unfortunate that we have to do this by bug instead of by
> mitigation. However, we don't have clear identifiers for the mitigation=
s
> that we do, so I don't think it's practical to do better here than "you
> can pretend you're on a vulnerable CPU - now go and read the docs for
> the per-vuln cmdline params to figure out how to run the mitigation you
> want".
>=20
> Being an early_param() means we get to do this before identify_cpu() an=
d
> cpu_select_mitigations(). But it's possible there's still other types o=
f
> bugs that get setup earlier and might miss this override...
>=20
> I've only tested this by booting a QEMU guest and checking /proc/cpuinf=
o.

Right, I don't mind this - question is, how do we make it such that peopl=
e do
not use it in production and then come complaining to us why their CPU is
affected.

Yeah, sure, they better know what they're doing but I've seen pretty evil
perversions so far and us giving them enough rope just to shoot themselve=
s is
fine.

What I don't think is fine is for *us* to shoot ourselves in the foot
by giving the users such a thing.

Btw, there's a clearcpuid=3D cmdline option which has the same potential =
and
that thing taints the kernel. Yours should probably do the same.

And it probably should be called "setcpuid=3D" as a counterpart to what w=
e have
now...

Dunno, this is just my 2=C2=A2 opinion, don't have a clear idea yet what =
we wanna
do here...

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

