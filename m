Return-Path: <linux-kernel+bounces-199061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6998D8172
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361351F25CB5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEB684D07;
	Mon,  3 Jun 2024 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="QjS7K5y1"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5BD84A58;
	Mon,  3 Jun 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414868; cv=none; b=iCyEpm+y2nVhMTbR3he8HRktTr99x3ui9x9BxXZOthXo8AahFiJ2iArOS4pE3p1mjtEe/97ta/McHlyK7a6GkmXBQby/jqBi2IKu9UJ0wJk3WUPLokwxwLVSx+DXhad+zLxO4dP6Y3jnD4peL0EindN30vG6GpDAjk47BGKBr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414868; c=relaxed/simple;
	bh=NvJwpxgM+A3vRQjH6kJCJstSMvsWw3Ln7YVQYKZAyHk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MlCCsBLHuL8F1/KvsUK0gWBYYnvJVJu8WwWYaf9m26o8KYn0Go1igEI4VZ8c3uMAl4PrDWUpo1ou8/oN4CaaplbYh8whA4zGDKCHrhe7U1aHI5O1+0/Q0VR8z9pcwsC2OjmciUCFjty4gath36OdxD1hId6xAGcDPPNiTdaEkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=QjS7K5y1; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BkjlszsnJOcjOnwmTLpVxgc/BqFI39QeF4SVAWs2h/E=; t=1717414862; x=1718019662; 
	b=QjS7K5y1Z9rxLui4TGxW2ZQNliDMeoRQu8wflb+OEK2oa9Gq/bW6g6+kR13PS9d9LgDnQ6iwnz3
	fODN+68wy6U0GFagH3OKT3snbaJc1reTYDgtlZ2uPZUq5IqmM9wRB4qmRhLRXaC9G20ae4koJBqaH
	mLekYjKFs9ZnMIErQRWpioaInPtAP7VB5IW6q/7s6gfk+APz7vWMp6zKgskgGwO2U+xaSd6XJAVFX
	jkGfEy7Dc5qMlwAAb8Fyp01a9FMAVwq3Qg+yesp017EoOXmveM9/FzyRTDKK1C7UN8PsqwO2v1jwL
	KP8B4qP4pQqqPdb9DtVIRqrpoFM6J/vD7iAA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sE5zV-00000002rYI-1aCb; Mon, 03 Jun 2024 13:36:41 +0200
Received: from dynamic-089-012-009-156.89.12.pool.telefonica.de ([89.12.9.156] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sE5zV-00000002oi4-0eeX; Mon, 03 Jun 2024 13:36:41 +0200
Message-ID: <34c519412fbaca9d5f08990ff96c4c928869bf84.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Arnd Bergmann
 <arnd@kernel.org>,  linux-alpha@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>, Richard Henderson <richard.henderson@linaro.org>, Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>,  Matt Turner <mattst88@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Marc Zyngier <maz@kernel.org>, 
 linux-kernel@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>, Frank
 Scheiner <frank.scheiner@web.de>
Date: Mon, 03 Jun 2024 13:36:40 +0200
In-Reply-To: <alpine.DEB.2.21.2405310457060.23854@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org>
	 <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
	 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk>
	 <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
	 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk>
	 <CAHk-=wi7WfDSfunEXmCqDnH+55gumjhDar-KO_=66ziuP33piw@mail.gmail.com>
	 <alpine.DEB.2.21.2405302115130.23854@angie.orcam.me.uk>
	 <CAHk-=whiH6g+T7+YWSYgAhJ9HsJ2bUUDJfLLo_Yhbi8CVgkHDg@mail.gmail.com>
	 <alpine.DEB.2.21.2405310457060.23854@angie.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Maciej,

On Mon, 2024-06-03 at 12:09 +0100, Maciej W. Rozycki wrote:
>  Anyway, back to my point.  A feasible solution non-intrusive for Linux=
=20
> and low-overhead for GCC has been found.  I can expedite implementation=
=20
> and I'll see if I can regression-test it too, but I may have to rely on=
=20
> other people to complete it after all, as I haven't been prepared for thi=
s=20
> effort in the light of certain issues I have recently suffered from in my=
=20
> lab.

That's really great to hear! Please let me know if you have something to te=
st,
I would love to help with this effort.

>  Is that going to be enough to bring the platform bits back?

That would be awesome. Would love to be able to keep running a current kern=
el
on my AlphaStation 233 which is pre-EV56.

>  FAOD, with all the hacks so eagerly being removed now happily left in th=
e=20
> dust bin where they belong, and which I wholeheartedly agree with: we=20
> shouldn't be suffering from design mistakes of systems that are no longer=
=20
> relevant, but I fail to see the reason why we should disallow their use=
=20
> where the burden is confined or plain elsewhere.

Agreed.

>  For example we continue supporting old UP MIPS platforms that predate=
=20
> LL/SC, by just trapping and emulating these instructions.  Surely it suck=
s=20
> performance-wise and it's possibly hundreds of cycles too, but it works=
=20
> and the burden is confined to the exception handler, so not a big deal.

Fully agreed.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

