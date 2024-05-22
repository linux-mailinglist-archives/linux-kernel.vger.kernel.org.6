Return-Path: <linux-kernel+bounces-185657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDB78CB880
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5205F1C20F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1058101EC;
	Wed, 22 May 2024 01:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="M8cJx3Gq"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F53EEAC0
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716341804; cv=none; b=WvW43peLgx60+Y1fZZWBCN3KBNTwB5KzUVq0hKBmus0+Qp+EHT8WOHTtE25rdjxZLsNmQ+0EGZcw6MMDFYn3X3JcrdaOkHzH9rHBfrM80eaBKXedKxOP1OPqtNw/c4olViboXTtjba86osa06Djy9Fc7x2ctXpmTm1D4xaJyteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716341804; c=relaxed/simple;
	bh=lCGzvtZC6bFK4/CF51o6KAe7WvbkdeY7GgHgVqwXb/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TLpxo08C5A4gws+PELOSGQDL3OwCXIPBtA4qd6i4QzN2N0gVAMFoF2SMTXuSmiqiAebqcs6WQlRIyqllRD8fBKbkC/X3P1YAMDEN6gL3CJDZ1V+k/rckrfFG4oMlQZ6/DI0DMfxkvWkUFfmpWAnes8rDEmfcDhfwsCNM3ftxVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=M8cJx3Gq; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1716341792;
	bh=lCGzvtZC6bFK4/CF51o6KAe7WvbkdeY7GgHgVqwXb/I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=M8cJx3GqSC+793rD70hYU4M+bsWzHU04GYQXb5qryLmRDy/NgJEGz3+q62UkEZutc
	 dx3W9+Nljlmysg1CWq0UGkP0gvRH7rpFOYClhdShK5ECZp38loTshNNGbFU5BzvjkF
	 Ts/biM9T8oORjxlHEHr/xV1tbP+KgOrv5lAU6/3Q=
Received: from [IPv6:240e:358:11a2:a00:dc73:854d:832e:3] (unknown [IPv6:240e:358:11a2:a00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D436866EDE;
	Tue, 21 May 2024 21:36:26 -0400 (EDT)
Message-ID: <df446936d462c70f5ced430be2815bc9171af958.camel@xry111.site>
Subject: Re: [PATCH v9 1/2] x86/mm: Don't disable PCID if "incomplete Global
 INVLPG flushes" is fixed by microcode
From: Xi Ruoyao <xry111@xry111.site>
To: Thomas Gleixner <tglx@linutronix.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Michael Kelley <mhklinux@outlook.com>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,  x86@kernel.org,
 linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>
Date: Wed, 22 May 2024 09:36:22 +0800
In-Reply-To: <87bk57kwhr.ffs@tglx>
References: <20240418205414.67735-1-xry111@xry111.site>
	 <32e53b74f382f691fb8f60d68b093901964bd1c9.camel@xry111.site>
	 <87bk57kwhr.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-15 at 15:58 +0200, Thomas Gleixner wrote:
> On Wed, May 15 2024 at 18:46, Xi Ruoyao wrote:
> >=20
> > Linux 6.9 is released.=C2=A0 Is this suitable as 6.10 material or do I =
need
> > to update something?
>=20
> If it still applies. Nothing to do.

Unfortunately it conflicts with x86 CPU vendor/family/model code rework.
I'll make v10 ASAP.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

