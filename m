Return-Path: <linux-kernel+bounces-242577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D785B928A11
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03461C23ECA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A566E149E13;
	Fri,  5 Jul 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f+Y/vTZN"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C3146000
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187146; cv=none; b=dXZlbh+KoQ5BdoF0X4JU62lRwtEezM9XXLH6P0UV761/rGi9KVI61Xg0m2rhJT74rXKL4dPX4Vr8TolD8k7mavYTE7RYvfQFFuTwQhBxt7rLlpPz8Bd4k8UDKxDdcglCfwh0WvLoFFPcRabrFHo+1HjuLvMx1Iu0KYSRG6peoHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187146; c=relaxed/simple;
	bh=7A1k1EfHL/jocMPKw9kKnbTXg1KbbhvRYYVQMx5RpkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgKQDyugJPXHodGHtZ1sDjW5Z7d2xKxor/qV+AP3pc+dRhEFr5lXx3Icexu5JcFSj5Ii9dbke9VG4ZU1/CZwqM1oELuQOI40OufEsPXEzvVSTbn78lg9q0RJDbH7YFff9KctPiuiZjsPT+6CxxWoT9IFnOvnF/HT7odwWGeJvD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f+Y/vTZN reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DB80940E0219;
	Fri,  5 Jul 2024 13:45:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iWQfI35M3fgp; Fri,  5 Jul 2024 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720187136; bh=ETa9ojvzSrCJIdF91NsPivt4AXrAVEFmWH8RJlMijgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+Y/vTZNI1War0i3fFMn7RN0oLEOYL2CdN5qmfEKmJlft2qcHwLrmqAwyni8OY8De
	 HYDsVhq00XBtv48dlM2uL9jxhCXr5eSdQd4FtnCDv1XvIlkDkKaTyVTBnjDPniSPT0
	 BJ9ypo1f6VfyAqb8iG9Wwb0EWpxYtXYkrWwVT1iDHgBi4KPlDEOmDgi/6bQk0WOWtg
	 ypqBvWC53s5Ev4Zo9jTmWRngPV8T4bo3WWagVWEoKWsz+WxeovVRAXVfyLvbmMPxbX
	 k+XpWCtaZaBjrv55mUcqHJ27Jp7eqzHmrBTpvpzabRAAB+X8fHr5SBdJChOCP30fNw
	 vbOg+NpXRjCBsV0x7nmDOLOSws73s6rQrx1Yls7cJnNTblaYqUM04mbzlFRAbhbSU0
	 sjRCiz58164Zk+MOLfDe0kyHlRMgHuu5u6JgyUxhS/KHJfgjq1xdnplTJiH6w96E4A
	 jP8cOecUGAx+61FqMoOSZXo6VBPkEvJZun1jWsadfYkN99pzEpcvh25eCgzE9uECdg
	 FVtiUVcxO5Aj8s+xEiTTQhrqKOj9qi8ghkA/YiqbJMh3Ly5g/AGM6phAXCeqw4GZRB
	 SkQvrLZs5cNollDJ2n896SBkwRkJnQEhYKBLoiMLrf4tu1u+Ue5KPH8yZH83Dxyc1A
	 /J1cn+Csapd9OQzpFhXcQhaQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0EA4B40E0185;
	Fri,  5 Jul 2024 13:45:23 +0000 (UTC)
Date: Fri, 5 Jul 2024 15:45:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, dave.hansen@intel.com, xin@zytor.com,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
	nik.borisov@suse.com, houwenlong.hwl@antgroup.com,
	Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
Message-ID: <20240705134517.GAZof47bcaL5i2b4ju@fat_crate.local>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com>
 <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base>
 <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com>
 <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com>
 <20240703161705.GAZoV5gQIgtORQeHdQ@fat_crate.local>
 <DE8FD8AA-35C6-4E51-B1E0-CE9586892CB3@zytor.com>
 <20240705094418.GAZofAcvelmnRzbkoG@fat_crate.local>
 <cda57e5f-acf5-414c-8faa-d2496c02ced9@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cda57e5f-acf5-414c-8faa-d2496c02ced9@citrix.com>
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 11:30:16AM +0100, Andrew Cooper wrote:
> You cite perf.=C2=A0 Look at the disassembly of the two approaches...
>=20
> cpu_feature_enabled() might give you warm fuzzy feelings that you've
> eekd out every ounce of performance, but it's an absolute disaster at a
> code generation level by forcing the compiler to lay out both side and
> preventing any kind of CSE.=C2=A0 As I've reported before, count the nu=
mber
> of RDPKRU instructions in trivial-looking xsave handling functions for =
a
> glimpse of the practical consequences.

Yes, I do cite perf because what you have above is not saying: "yes, this=
 is
a fast path and doing an alternative is warranted." If that is the case, =
sure,
by all means. If not, make the C readable and ignore code generation. Who
cares.

> Anyway, none of this is the complicated aspect.=C2=A0 The complicated i=
ssue
> is the paravirt wrmsr().
>=20
> TGLX's complaint is that everyone turns on CONFIG_PARAVIRT, and the
> paravirt hook for wmsr() is a code generation disaster WRT parameter
> handling.=C2=A0 I agree that it's not great, although it's got nothing =
on the
> damage done by cpu_feature_enabled().
>=20
>=20
> But, seeing as I've got everyone's attention, I'll repeat my proposal
> for fixing this nicely, in the hope of any feedback on the 3rd posting.=
..
>=20
> The underlying problem is that parameter setup for the paravirt wrmsr()
> follows a C calling convention, so the index/data are manifested into
> %rdi/%rsi.=C2=A0 Then, the out-line "native" hook shuffles the index/da=
ta
> back into %ecx/%edx/%eax, and this cost is borne in all kernels.

A handful of reg ops per a WRMSRNS? Meh, same argument as above. But...

> Instead, the better way would be to have a hook with a non-standard
> calling convention which happens to match the WRMSR instruction.
>=20
> That way, the native, and simple paravirt paths inline to a single
> instruction with no extraneous parameter shuffling, and the shuffling
> cost is borne by PARAVIRT_XXL only, where a reg/reg move is nothing
> compared to the hypercall involved.
>=20
> The only complication is the extable #GP hook, but that's fine to place
> at the paravirt site as long as the extable handler confirms the #GP
> came from a WRMSR{NS,} and not a branch.

... yes, I'd gladly review patches which address that and make the whole =
deal
cleaner. I'm still sceptical those handful of regs shuffling ops would ma=
tter
in any benchmark but sure, if it can be done in a cleaner way, why not...

Unless I'm missing some use case where that overhead really matters. Then=
 by
all means...

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

