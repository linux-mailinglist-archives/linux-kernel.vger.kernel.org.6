Return-Path: <linux-kernel+bounces-310876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E5F96825B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D61283580
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50AF16EB76;
	Mon,  2 Sep 2024 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="CwoD2QiL"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB16C1E48A;
	Mon,  2 Sep 2024 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266924; cv=none; b=hGDOSw0rKWag5dWOA3tINiUsqXPRHszihti+GhY99I2P/4Mc+hhwNDPaCFhs2wmsK4o4xXY9jaY0Y83AJJTO5A0QhZQSKhcxWS3YtwroYlSY5luJbadV/j/MI0T849JLeN1FgINJa2xpCtMNaQEzsXRzVZluhb6gODwnzJ+yfiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266924; c=relaxed/simple;
	bh=A19maF2oWPHkqTGx94yzNxGSBOwDzbA2rJL3LldZ67w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfZaW9TfwRcnbFiQOuv8Db3nSP+RJDVBJqJyt1X2JE/fcmr0PPKtFuWunefcVibiYKmXBtsUyD4t26E2YQBs/AgzNEJ5/CS/nMzX49K39dvNtrsWDOU0BGlvkHvGQydzp2KHVn9i/EqVwnMJXHL435UG1MyhYHnY4zg19GeAcfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=CwoD2QiL; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1725266919; x=1725871719; i=christian@heusel.eu;
	bh=A19maF2oWPHkqTGx94yzNxGSBOwDzbA2rJL3LldZ67w=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CwoD2QiLvuGYzsiK0MzKhhde9lSdvHZbbNNhXwnSywobRIM4qvhUzLJ0tdlWlITW
	 rqwvmyl1PvM6IKBmrgPc78fiUeggaAVq+EM6AuobTqoaU1gnhK8EwP1PK82bOxdsP
	 vFTtCmOw0qskXfvQGbzZhlaWRSeyDHMUl4jxuKTmSKi7ZnKw8bYky9QAftGRakKVN
	 aLo7tWGUB6BAJItM+N70XTiwbi0a6UisKkbMOHTsmV98tnepMW3uk7N2L/jwW6mt5
	 rw5TI2MGG/zasBdLaDY8dE2z/G1KBl/aGPZS4Bjsk0gDArb9dE0wjuDGWRABvULe/
	 F+zEVFa5Rzam39+auA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([109.54.30.229]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MScox-1se3au09gP-00ROGr; Mon, 02 Sep 2024 10:43:01 +0200
Date: Mon, 2 Sep 2024 10:42:57 +0200
From: Christian Heusel <christian@heusel.eu>
To: Paul Rolland <rol@witbe.net>
Cc: Zack Rusin <zack.rusin@broadcom.com>, 
	Andreas Piesk <a.piesk@mailbox.org>, bcm-kernel-feedback-list@broadcom.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, maaz.mombasawala@broadcom.com, 
	martin.krastev@broadcom.com, rdkehn@gmail.com, regressions@lists.linux.dev, 
	spender@grsecurity.net
Subject: Re: [REGRESSION][BISECTED] vmwgfx crashes with command buffer error
 after update
Message-ID: <948af4e4-6da4-4f49-82c8-ef061485e49f@heusel.eu>
References: <CABQX2QM09V=+G=9T6Ax8Ad3F85hU0Cg4WqD82hTN=yhktXNDaQ@mail.gmail.com>
 <40cf01ab-73ad-4243-b851-a02c377bdbde@mailbox.org>
 <CABQX2QM1A9yWCuOHV6kgi3YbPvPHz-zazkOXM6Up9RWrZ-CgPQ@mail.gmail.com>
 <20240902103436.5806f7ec@riri>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rupcgzgxmzcxpunk"
Content-Disposition: inline
In-Reply-To: <20240902103436.5806f7ec@riri>
X-Provags-ID: V03:K1:qccHn7M7lebkNgQVrXMfeacJegLBw7eCdvFx6uS4itYQrsMRryY
 wFNWF4NEIIrFLUTc8SPGytZtD7XIPMjGCR3A137aax3bllqdnjsJmFfX6hDe8etuhXfHM7H
 w+zn/MwnEG4w7Nd2OjQt5l2Cm+sUNIXYLsbYqP+iARI9BmSeRidp6jO0vPD6aCi2LphNYY8
 Ye7GHPc85cHBEMbZNbzPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:piftTdK7JJY=;xZ04CBxhDkmKqgA3RX5KKQNaQVn
 7OBH2UI+WrQ9ixYWqtoSKjFmhzo/CwgMK07zYmiUnrtC/++IXvvd5XXI3/0ZG/licfym5+BqX
 YBoB37Em2kndU2cGlkeDmhIpzFb87oCkE6NkQaJqcved4qsIKLGjerw69w9lpSqRrwmFWtCTC
 OE0wl7xpy8qReZT9y54PLmqVGumBgfl6q/JsJ3aYHdevVKfv3nnZg20oWJT6yuwfNZvISlwwX
 Qx69VtESbybi/SrbPEIAhlVvMfR2KU+IceaHCZD0wEFULPbFOy6JiwugOVd6QfL8tFVgZjxNP
 nrjFUK/Bmx6uB4TigIS5a+ir9KaTzux2tkY7XYe1/PG099UIRQuJUXjVSjdxMTYxZCVf+sL7p
 ojFx/vaLFNheG8zzJSQUOGBdOxAQFWMOLDixxerFfa3qrON1MYKUP4dsmSrSJwdqMQoFLsoUh
 8PDVrIm9acrhxKuXTTFBOaptQequ6E+HEAnfVD/ceUFtSs3/Ri3YvtjZiJsstHw8Y7fMMssHv
 bylyKtRG+e0l2WnmdVNQ06IeLDFLWL3OjWn35dVRhjVjgITAbMW937XlIBHvtqDqXxkkZVNLf
 GrlfadXB65UBrhgU1A9IBopBiMaFHmX3gTGTeo1/26+VCWmM4kxQZA5NvNgfFDcTKHR9Bt2tc
 JMhSKjDLXwdXTcxxGqosc6e7CbeGLCtZQPUhr83vpkmpDq7povUeDzaj+FdmKWADC23oXQxhJ
 KAZLuFX9uj/xdJY6+S+F63/TJRq9pR5+g==


--rupcgzgxmzcxpunk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/09/02 10:34AM, Paul Rolland wrote:
> Hello,

Hey Paul,

> On Fri, 16 Aug 2024 14:56:19 -0400
> Zack Rusin <zack.rusin@broadcom.com> wrote:
>=20
> > Thanks! I see. I have a patch out that fixes it, but in general I
>=20
> Any chance to see that one pushed to stable 6.10.x kernels so that we can
> have a working console ?

this is on the way as the stable team has already queued the patch for
the (to be released) 6.10.8 stable kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.10/drm-vmwgfx-disable-coherent-dumb-buffers-without-3d.patch

> Regards,
> Paul

Cheers,
Chris

--rupcgzgxmzcxpunk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmbVepEACgkQwEfU8yi1
JYW0HRAAwlqiPgELsPtSvfPFKg3xBzpLCOrYbDIPWZDJ4lj4QlUp0Ni++wN4q0h7
JKUZmXIuTyODIwIG+gDBZPYIVnlAPy1W7x0M8agJVu2tfdGvxPCQYAxuPTHg+h0Y
KV+HIGgnXoll7d78vdtGGSqDWp+aKyPDPXmggLcMDGibmsj/jSV2fY5XfuSIqLOw
DkVcC7Sd4duYORqP0fpLycJGyHyDIcwAB7Eb1UKA/njq1e1nVxQ1G1PyLvqSzvYD
EVaDAFNbqHj1GMdRlKyWoWvgjOahwIqwLyKByxQcji9LjHwsBzJVaed+RaVDyJJp
M139nd2fvzW99VICAYitDDnLBEa7p5KkCS94JnMEvL7GzYEdtz4eqkSTQP2UrsbM
k7TiNf94S/kAxf66AbO0vot7v2yspRcSZZWRA7+50VDm4Z3GyexED1Pr1HHdjZCx
Hl5LHHoGce/acRycNhZMZw4twPSww7TZb7hgQKPVCyhgAW+eCBNyLvJH5PsHLkfH
7VhERUCTN7EOP9KpQ7xI68g9WvvOZ0lk1Ps1rIZ8ZUkPEQ34MSi7c16jteMnqUq1
TPp1ssJRKepYV8nhv5w6x2zL9a9XJoo8dG6tuTK+rpYh7fj6HdNdn8KwuXrMjuz2
FvSbU+fGfpnLlgQYtAKP61FHQ3f6VGC47jlmrzb1iteXWKA/P+k=
=EDDy
-----END PGP SIGNATURE-----

--rupcgzgxmzcxpunk--

