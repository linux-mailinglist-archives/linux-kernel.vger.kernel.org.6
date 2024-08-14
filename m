Return-Path: <linux-kernel+bounces-285670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA8E95110F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76654283E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677CA1FC4;
	Wed, 14 Aug 2024 00:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b="gRFugSD/"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE31197
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723595615; cv=none; b=ZE8e7wQmbAN7MMCIef0ASxk/8KxLviZlCVB0HjRSrH0Gxv4l/lU7O7wCWZUNFmqHoxkmnty8Mw6ziQuiIlcCq5ixj0VrVUM2nhl6wQzb/U7dm7Ikc42BH7qm413vnJtCMePIBB7fqwIN2hVOz3mzt28UNI7eF+IubuKGO4cidKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723595615; c=relaxed/simple;
	bh=mZxBMSBOXUjPtNMzQYsC/w4amo62xoxfgDzla/4sRKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ib/lhGs1op+SHA5lZ6S/dQo7ZefulmfYkEYluJQclz9pSVbhz0bbvpghu2omrwqqjs9qLKQXn0er4jt8k/XDEXGEF3yUqdy5DAfrvLrgqbwpq4P/bhd5ek23WTGEvlBiHX5+eP7kTRiQf5DOeCqNLQhRq3576u5EA27jR/ke++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b=gRFugSD/; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 6617 invoked by uid 990); 14 Aug 2024 00:33:29 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 14 Aug 2024 02:33:29 +0200
Message-ID: <d5c8fdfbdfa096c9c1215a2ccd1cabefc63f1ec8.camel@florommel.de>
Subject: Re: [PATCH 0/2] kgdb: x86: fix breakpoint removal problems
From: Florian Rommel <mail@florommel.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,  Lorena Kretzschmar
 <qy15sije@cip.cs.fau.de>, Stefan Saecherl <stefan.saecherl@fau.de>, Peter
 Zijlstra <peterz@infradead.org>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>,  Randy Dunlap <rdunlap@infradead.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Geert Uytterhoeven
 <geert+renesas@glider.be>,  kgdb-bugreport@lists.sourceforge.net,
 x86@kernel.org,  linux-kernel@vger.kernel.org
Date: Wed, 14 Aug 2024 02:33:29 +0200
In-Reply-To: <20240813171055.f8805c1db539dfa18e80026b@linux-foundation.org>
References: <20240811232208.234261-1-mail@florommel.de>
	 <20240813171055.f8805c1db539dfa18e80026b@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.138129) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.26187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=mZxBMSBOXUjPtNMzQYsC/w4amo62xoxfgDzla/4sRKo=;
	b=gRFugSD/tFere1sDgEeavx+9foLS7dCf39ZuQyBbk24KBMq0GPAaDRviGhNNPNOf/tmQR8NVBS
	yEPWObIrPYUHPIwSBkTG6qi7uEg9/sGe5nCNsPCg5+EMypljVKsHiLU1tExSECKFDv5DMOHVB/Gj
	xV712O5dIx1V9i86TrdMDqw+z+Fg2P0Lgib740/zYXAC/LDSquElO2jaZMaPo9xhW3WMAkkHxFUG
	3zFRVtkJxlUhUYDrv/l3Vlt+xE0TLoCZtxepeV8+wUJH/JvaM+jisIG2Hcfp26CGAatyQ2fD3KGy
	DBf951Q5cTmuh+EZKOya/Oc4WH4Vuy4RS/8VqRYFybcOY9aJWSqNn7X8lY9jdi06bwBstMDJ22Fb
	i7KKLjfHKujr6MwkTaIWSCDrDkKKsc6iJ30/wZpDtYfpmEhoHr6k/jiWdeNL06ekJ/EJwFmNkyO8
	CpVkPPYipmzVJczFD2EDfNt3VKjGFe6s27dGRsutnGMNcVaRg/iTf3FM8sqlCZsta7KZ3Am7lSzt
	AW1E6DFHBsHIL2MLCTnow+n9lH3HAB6nP0U9dAiqOZgCwO8Kb5QDMsVBbtPRPIjAJH4WmisHz4d+
	IdkBh0+P9JuJ5t/gIS/eNGUAPy5b5s1d8dzMAX7VOJUaD8Kfe6wsOhcpGmCtmvOIKw4aEieg10gZ
	o=

On Tue, 2024-08-13 at 17:10 -0700, Andrew Morton wrote:
> On Mon, 12 Aug 2024 01:22:06 +0200 Florian Rommel <mail@florommel.de> wro=
te:
>=20
> > This series fixes two problems with KGDB on x86 concerning the removal
> > of breakpoints, causing the kernel to hang.  Note that breakpoint
> > removal is not only performed when explicitly deleting a breakpoint,
> > but also happens before continuing execution or single stepping.
>=20
> Neat.  It would be nice to fix earlier kernels; for that it is
> desirable to identify a Fixes: target.  From a quick look it appears
> this issue is more than a decade old, in which case I don't believe a
> Fixes: is needed - our request becomes "please backport to everything".
>=20

Thanks. There is already a v2 (due to my negligence on the details) and
a bit of discussion:
https://lore.kernel.org/all/20240812174338.363838-1-mail@florommel.de/

Rgeards,
Florian


