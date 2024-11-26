Return-Path: <linux-kernel+bounces-422350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0939D9881
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87894164FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9742C1D5140;
	Tue, 26 Nov 2024 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="c5tppiRr"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A358522F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627642; cv=none; b=QAYpiDmf+QO+laYsG/cSkT3NsFG+v6WYJy3+9s1Ijej5vk/2DHhJaQs24v6CzKxvtmNTTCPqBShETv0MMDRAZ1CBaKQ58JnG105zUwCQcjtkc3rw+MIiXdnLzA7Xbvy/l++XAp+S1g1jY8cibnvYxlt9czu5E550TxGpxxOORn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627642; c=relaxed/simple;
	bh=Y7lKJoNHmIeclml5dMftpGEKrOWFHjqsEI1mt8d2OJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ez20kD+Y/2Acig/ZUa6x80C326vvApY9sBaN1kqKlQcJL0airq9Ro+KP43+fO354tGTLKi8QCAj9IQmiFl+ySTXu5Ve8ut+MeZ27arU/Ir/EBpZp5sV+n3hRSGylr7zWtR7Vta19hDcKYqDdnaff+1x7vTMEE9xLuLpFPKEOz0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=c5tppiRr; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PCYjy73HuYFntkPiDGBkHEccdajNYD1R0CFtq8zFieg=; t=1732627638; x=1733232438; 
	b=c5tppiRrQ5rg69B8UHiuJYGhvQekqamJiOjs4j3m6VYV61UvPNNsXsn8UhimmY5PPvY5GR2ICWo
	7x0OA4DisIufO9GPjetUlWIOtkSYAP3I25vnR0UNI7ur6GqlR/RrplwYoJuIYLUaAdscU18SD5lMJ
	fjfywq0qSh5sj6LBS97SEZs4fbgHURD4tPgcrZx6NBRBa0E/R+9xEuHm7PY85gAPgBzwD2j/JsmeT
	YzpcbKtaefVLtFD+SwnojYVJS8iozOj6O/9ThXYNcSu3uzS/DJNCXc+guu1+bkfd+bOBRA9NL/x42
	igmkfesUuuXjEmTSO6w/gacuC2HuDH7hVTfQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tFvau-000000046Jp-1nCv; Tue, 26 Nov 2024 14:27:08 +0100
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tFvau-00000000PFp-0rGA; Tue, 26 Nov 2024 14:27:08 +0100
Message-ID: <a981939be1ad279ef11014d93446762cdaa93823.camel@physik.fu-berlin.de>
Subject: Re: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: arnd@arndb.de, geert@linux-m68k.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Date: Tue, 26 Nov 2024 14:27:07 +0100
In-Reply-To: <87sere7jyc.fsf@mpe.ellerman.id.au>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
	 <20241121083846.3648473-1-glaubitz@physik.fu-berlin.de>
	 <87sere7jyc.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Tue, 2024-11-26 at 14:27 +1100, Michael Ellerman wrote:
> > > The Linux CHRP code only supports a handful of machines, all 32-bit, =
eg.
> > > IBM B50, bplan/Genesi Pegasos/Pegasos2, Total Impact briQ, and possib=
ly
> > > some from Motorola? No Apple machines should be affected.
> >=20
> > I have a Pegasos 2 and I planned on keeping it.
>=20
> OK great. You're the first user we've heard from in quite a while :)

Well, as I said, you won't find the people using that hardware on the LKML
as most of these people aren't developers but just users.

> Any idea what is the latest kernel version you have run on it?

I don't remember. But I'm planning to test a current kernel in the near fut=
ure.

There is just so much other stuff on my plate, including that debian-instal=
ler
regression on all PowerPC targets introduced by a recent change.

> > Have you asked among the Amiga community whether they plan on discardin=
g
> > your hardware? I think it's always ill-fated to ask for popularity of
> > hardware on just the LKML. Most users are not on the LKML.
>=20
> I haven't because I don't really know anything about the Amiga
> community, who they are, where they hang out, etc.
>=20
> Please cross post this to any Amiga folks you know, or tell me where I
> should post it.

I will.

> We've maintained this code for over 20 years, at some point if there's
> no one in the *Linux community* who cares about it then it's hard to
> justify keeping it.

The problem is that you don't reach the whole Linux community over the
Linux PPC kernel development mailing list ;-).

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

