Return-Path: <linux-kernel+bounces-285033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70662950876
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02866B24787
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD5E19F497;
	Tue, 13 Aug 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b="xIUTiziM"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C671DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561552; cv=none; b=UX4euVofE4k2dyKyGTYNhdVTTPb6cKqqjkucpN709dNP9Wq4vPFU/HsA46dDvEil/l9npp0tsB9ywRHYz66bwQkqA0FUTWR/xTplIGPZZyypS4nj+dEtSbYCx9F7YxWDhBs+PJqOpBdGyGirq+VLilaDaOy7OD4CXan9i6KVCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561552; c=relaxed/simple;
	bh=m9Ol9Yb/7VyMaWM/asi6Gi7gvnVmClqrjV4U3r/cfqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LIhTAdPPDH92wm8JIh/VDfsrX5TsY/UD5ee2IgeZu1ORTK9eEZSijEBfbBR+umxSnApgokOTrahCgdERGUkagnHsvdR8i2EQ70l2ANLcU4Kk5w4ocY2UucVI1hDwT7aRBYsT4QcmpNjJ5PosY63sukw6IgM14s4qxLaV8QugF80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b=xIUTiziM; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 30973 invoked by uid 990); 13 Aug 2024 15:05:40 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Tue, 13 Aug 2024 17:05:40 +0200
Message-ID: <01b5b729ba11141dc6a8b67ac50ca4c63d332d18.camel@florommel.de>
Subject: Re: [PATCH v2 2/2] x86/kgdb: fix hang on failed breakpoint removal
From: Florian Rommel <mail@florommel.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson
 <daniel.thompson@linaro.org>,  Douglas Anderson <dianders@chromium.org>,
 Lorena Kretzschmar <qy15sije@cip.cs.fau.de>, Stefan Saecherl
 <stefan.saecherl@fau.de>, Peter Zijlstra <peterz@infradead.org>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>, Randy Dunlap
 <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Geert Uytterhoeven
 <geert+renesas@glider.be>,  kgdb-bugreport@lists.sourceforge.net,
 x86@kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 13 Aug 2024 17:05:40 +0200
In-Reply-To: <871q2tsbaq.ffs@tglx>
References: <20240812174338.363838-1-mail@florommel.de>
	 <20240812174338.363838-3-mail@florommel.de> <871q2tsbaq.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-1.721587) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.321587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=m9Ol9Yb/7VyMaWM/asi6Gi7gvnVmClqrjV4U3r/cfqc=;
	b=xIUTiziMd6AwHegrIz+5rqbCU6SzPNWjSR8G6Kr/I3SRgl4wxmMopIEsAx5BYvpDOV3BPWVC6Z
	peTShtIT4+dqJyqRogaqBy9O5A8V8oCznxYf2LDu5RG21qRZklQCJA0r2Lrq0vg6vWpNH08/xtNl
	tyED5grLdCSMecvMAoDvDcH5DJzT27XuzqD3ps0uArMpEZkP7CUfqXkaQjRbB/PVkmqy8KORZLCq
	xgOL1bpjs25q84eU3oOYeVybrnOGsZpbw5dfLxGegFQMo4jE1+k8+4LHPMC3sCYk+7juX4fuO+QD
	kZUS3gdn4hjSoctxhsH04ii6H+6gSaFsObje2V92E3ctu95q+tYX9oB8fVR/B0jKnOtl/odBfGvx
	DRv1wyG32WvForgosZ+u73y0NfbFRPwOQ56gae1cb37nDaXnieND55h+DW6WiUUO0XBah1vo012O
	5CciU6BhzVZUGo/UwhcOo/KDu7khn0ntjZrB64Z5DPpfgEf5GxCcsRM06dmmAWn730K2QNEat2Xc
	Ezmu8lm4CAqjlb+BZQ/G2akm/1qOfk1y+Ecs2dqsnqSEHXccLO16hVwdM5rfhQD5c5IX9EQznzo2
	AJv+X8xCklZNDWbdcov257tUw6FT1oqY/grcVjCiP5AVBkrcwqyALimlQPrf82KhBLQV1eq7h1E3
	Y=

Hi Thomas,

Thanks for the feedback.

On Mon, 2024-08-12 at 23:04 +0200, Thomas Gleixner wrote:
> Either you know it or not. Speculation is reserved for CPUs.

I have now checked it, it is always the static_key patching mechanism
when I reproduce the issue (in QEMU with a varying number of CPUs), but
we can skip this statement.


>=20
> >  {
> >  	if (exception =3D=3D 3 && kgdb_isremovedbreak(regs->ip - 1)) {
> > +		struct kgdb_bkpt *bpt;
> > +		int i, error;
> > +
> >  		regs->ip -=3D 1;
> > +
> > +		/*
> > +		 * Try to remove the spurious int3 instruction.
> > +		 * These int3s can result from failed breakpoint removals
> > +		 * in kgdb_arch_remove_breakpoint.
> > +		 */
> > +		for (bpt =3D NULL, i =3D 0; i < KGDB_MAX_BREAKPOINTS; i++) {
> > +			if (kgdb_break[i].bpt_addr =3D=3D regs->ip &&
> > +			    kgdb_break[i].state =3D=3D BP_REMOVED &&
> > +			    (kgdb_break[i].type =3D=3D BP_BREAKPOINT ||
> > +			     kgdb_break[i].type =3D=3D BP_POKE_BREAKPOINT)) {
> > +				bpt =3D &kgdb_break[i];
> > +				break;
> > +			}
> > +		}
>=20
> Seriously? The KGBD core already walked that array in
> kgdb_isremovedbreak() just so you can walk it again here.
>=20
> struct kkgdb_bkpt *kgdb_get_removed_breakpoint(unsigned long addr)
> {
>         struct kgdb_bkpt *bp =3D kgdb_break;
>       =20
> 	for (int i =3D 0; i < KGDB_MAX_BREAKPOINTS; i++, bp++) {
> 		if (bp>.state =3D=3D BP_REMOVED && bp->kgdb_bpt_addr =3D=3D addr)
> 			return bp;
> 	}
> 	return NULL;
> }
>=20
> bool kgdb_isremovedbreak(unsigned long addr)
> {
>         return !!kgdb_get_removed_breakpoint(addr);
> }
>=20
> bool kgdb_rewind_exception(int exception, struct pt_regs *regs)
> {
>         struct kgdb_bkpt *bp;
>=20
> 	if (exception !=3D 3)
>         	return false;
>=20
>         bp =3D kgdb_get_removed_breakpoint(--regs->ip);
>         if (!bp || !bp->type =3D=3D BP_BREAKPOINT)
>         	return false;
>=20
> Hmm?

Ok, ok, looks much better. My intention was to keep the changes in the
generic debug core minimal, especially since efficiency is not
important here.. but I see, it should be done right.




Best regards,
Flo


