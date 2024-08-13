Return-Path: <linux-kernel+bounces-285036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE9295087F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828161F217FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85A1A00D0;
	Tue, 13 Aug 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b="nvbjBgxy"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B611DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561610; cv=none; b=kDmGJSttNhpR+ci7/J0HQwSGG39QINrRtFMesmqo5NnGqJPX1KQypK2gqkceOOod+4UUgJz4Myc8s6E0TRrQTCN4nQzamT9ldzdzV7saZGSoooJScus6sJZ/IHqw/2SGx2DFXvJmn1Y4HdD8whC6aLMxdn3XKxLTiyFq6SfjyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561610; c=relaxed/simple;
	bh=7oVMNAQNgViWNsPL1cgzaH4HZVMUnsvRm5s/wW0i3Lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TpTkg7nPwnLUKWUqdmEJ2oVM++GUt4yMpzM+xMnTiN7S8XQFkDzf+pBIZRvX0nWhImahSehjDrVkbM4yi1NA3StpYtewf/TfwIBJH70rLmnZsJIKd/qT4Ojm2D89utlr5U2OYaM9SnDXZ4dP0o1DH6DU4gtQvcYZolSl4lsPh1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b=nvbjBgxy; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 31801 invoked by uid 990); 13 Aug 2024 15:06:46 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Tue, 13 Aug 2024 17:06:46 +0200
Message-ID: <383e12bebba34afc3779aad14deb3a43e9cbb5d9.camel@florommel.de>
Subject: Re: [PATCH v2 2/2] x86/kgdb: fix hang on failed breakpoint removal
From: Florian Rommel <mail@florommel.de>
To: Daniel Thompson <daniel.thompson@linaro.org>, Thomas Gleixner
	 <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Jason Wessel <jason.wessel@windriver.com>, Douglas Anderson
 <dianders@chromium.org>,  Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
 Stefan Saecherl <stefan.saecherl@fau.de>, Peter Zijlstra
 <peterz@infradead.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
  Randy Dunlap <rdunlap@infradead.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,  Geert Uytterhoeven
 <geert+renesas@glider.be>, kgdb-bugreport@lists.sourceforge.net,
 x86@kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 13 Aug 2024 17:06:45 +0200
In-Reply-To: <20240813113147.GA6016@aspen.lan>
References: <20240812174338.363838-1-mail@florommel.de>
	 <20240812174338.363838-3-mail@florommel.de> <871q2tsbaq.ffs@tglx>
	 <20240813113147.GA6016@aspen.lan>
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
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-1.123945) MIME_GOOD(-0.1)
X-Rspamd-Score: 0.276054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=7oVMNAQNgViWNsPL1cgzaH4HZVMUnsvRm5s/wW0i3Lw=;
	b=nvbjBgxyMU1Ry9M+9UPzsbxAMPK/OzhU97UlQysIcbtzpuZ0R0RHbf2wPQaUtksNlUjcDjzrkL
	g23BvlbylgXcqELhITbQvEgNUcOgMyOQzzBEBOXRnXilDL7haC8xlGMLHP+luoo16vGKDiLFKFp5
	KGZyeKe5gNe8DVwVgazxipA4Wh2/26M4FqlW6SQBHr9oalPgh7/LqImhxgpG9vLCTTFOt0lrklBA
	3RBOSw39nCRTufLPQphmEebtRZ5bqHM4riTRzF5KtfT/INtsvqF27DnuDACdhobQPSLrCDvfKmkC
	qxeOPNqwv22a51rWPB3WMIxn5Mhny47j/lT8nJYxfgA14P1CwZyVprUdqjGPDqJdV6hQiW+T8xwM
	k1QLgg5Uv0b0uwASL7+crFRvWWdn7wKEmWVAtGjTx1l1cTjSUiqjdF+UuJpAAsD91OgLNRlBpEOs
	09l96SVnoMzulCO77i6gRJPV8uHWH4u/pv5TD3m23lyur6O03hUnbHmgpqvOuAAXRsMyW6y/oVHJ
	qlIoYBK89UYDTPSDUTm6UJeA2Ki0YX6+uYIuo8D+sBmXGOFBuv+3IT4JeNkz/R2VjonGMR1b5q9t
	m2NGwCNRJb2w5wFwb9/nEprAoJaaoszaj5ChaRASK0hIeuObONQ/4rVeh/gvU2622uHWcE3YPbWe
	0=

On Tue, 2024-08-13 at 12:31 +0100, Daniel Thompson wrote:
> On Mon, Aug 12, 2024 at 11:04:13PM +0200, Thomas Gleixner wrote:
>=20
> >=20
> > Btw, kgdb_skipexception() is a gross nisnomer because it rewinds the
> > instruction pointer to the exception address and does not skip anything=
,
> > but that's an orthogonal issue though it could be cleaned up along the
> > way...
>=20
> kgdb_skipexception() is not a directive from debug core to architecture.
> It is a question to the archictecture: should the debug core skip normal
> debug exception handling and resume immediately?.
>=20
> It allows an architecture to direct the debug core to ignore a spurious
> trap that, according to the comments, can occur on some
> (micro)architectures when we have already restored the original
> not-a-breakpoint instruction.
>=20
> Florian's patch changes things so that we will also skip debug exception
> handling if we can successfully poke to the text section. I don't think
> it is sufficient on its own since the text_mutex could be owned by the
> core that is stuck trapping on the int3 that we can't remove.

Yes, if the text_mutex is owned by the trapping core, that's a inherent
problem. This won't be solved by my patch. But this will probably be
difficult to be solved at all..

The patch only adds an removal attempt, without changing the result of
kgdb_skipexception(). It was thought as a best-effort solution: Better
try removing the breakpoint than getting stuck in the int3 loop for
sure. Of course, there is no guarantee for this being successful.

>=20
>=20
> > >  {
> > >  	if (exception =3D=3D 3 && kgdb_isremovedbreak(regs->ip - 1)) {
> > > +		struct kgdb_bkpt *bpt;
> > > +		int i, error;
> > > +
> > >  		regs->ip -=3D 1;
> > > +
> > > +		/*
> > > +		 * Try to remove the spurious int3 instruction.
> > > +		 * These int3s can result from failed breakpoint removals
> > > +		 * in kgdb_arch_remove_breakpoint.
> > > +		 */
> > > +		for (bpt =3D NULL, i =3D 0; i < KGDB_MAX_BREAKPOINTS; i++) {
> > > +			if (kgdb_break[i].bpt_addr =3D=3D regs->ip &&
> > > +			    kgdb_break[i].state =3D=3D BP_REMOVED &&
> > > +			    (kgdb_break[i].type =3D=3D BP_BREAKPOINT ||
> > > +			     kgdb_break[i].type =3D=3D BP_POKE_BREAKPOINT)) {
> > > +				bpt =3D &kgdb_break[i];
> > > +				break;
> > > +			}
> > > +		}
> >=20
> > Seriously? The KGBD core already walked that array in
> > kgdb_isremovedbreak() just so you can walk it again here.
> >=20
> > struct kkgdb_bkpt *kgdb_get_removed_breakpoint(unsigned long addr)
> > {
> >         struct kgdb_bkpt *bp =3D kgdb_break;
> >=20
> > 	for (int i =3D 0; i < KGDB_MAX_BREAKPOINTS; i++, bp++) {
> > 		if (bp>.state =3D=3D BP_REMOVED && bp->kgdb_bpt_addr =3D=3D addr)
> > 			return bp;
> > 	}
> > 	return NULL;
> > }
> >=20
> > bool kgdb_isremovedbreak(unsigned long addr)
> > {
> >         return !!kgdb_get_removed_breakpoint(addr);
> > }
> >=20
> > bool kgdb_rewind_exception(int exception, struct pt_regs *regs)
> > {
> >         struct kgdb_bkpt *bp;
> >=20
> > 	if (exception !=3D 3)
> >         	return false;
> >=20
> >         bp =3D kgdb_get_removed_breakpoint(--regs->ip);
> >         if (!bp || !bp->type =3D=3D BP_BREAKPOINT)
> >         	return false;
> >=20
> > Hmm?
> >=20
> > > +		error =3D kgdb_arch_remove_breakpoint(bpt);
> > > +		if (error)
> > > +			pr_err("skipexception: breakpoint remove failed: %lx\n",
> > > +			       bpt->bpt_addr);
> >=20
> > Lacks curly brackets. See Documentation.
> >=20
> > 	return !error;
> >=20
> > Aside of that the same problem exists on PowerPC.  So you can move the
> > attempt to remove the breakpoint into the generic code, no?
>=20
> Getting the debug core to track breakpoints that are stuck on would be a
> good improvement.

Do you mean tracking failed removals with an extra kgdb_bptype variant?

>=20
> We would be able to use that logic to retry the removal of stuck
> breakpoint once other SMP cores are running again. That would be great
> for architectures like arm64 that use spin-with-irqsave locking in their
> noinstr text_poke() machinery.
>=20
> However it won't solve the problem for x86 since it uses mutex locking.
>=20
> A partial solution might be to get kgdb_arch_remove_breakpoint() to
> disregard the text_mutex completely if kdb_continue_catastrophic is set
> (and adding stuck breakpoints to the reasons to inhibit a continue).
> This is a partial solution in the sense that it is not safe: we will
> simply tell the kernel dev driving the debugger that they are
> responsible for the safety of the continue and then disable the safety
> rails.
>=20
> I haven't yet come up with a full fix that doesn't require
> text_poke_kgdb() to not require text_mutex to be free. I did note that
> comment in __text_poke() that says calling get_locked_pte() "is not
> really needed, but this allows to avoid open-coding" but I got a bit lost
> trying to figure out other locks and nesting concerns.
>=20

This is a bit off-topic, but isn't setting software breakpoints in
combination with other text modifications unsafe anyway? If we remove a
breakpoint in a code location that has been modified in the meantime,
we would restore an outdated saved_instr. What am I missing here?

Best regards,
Flo


