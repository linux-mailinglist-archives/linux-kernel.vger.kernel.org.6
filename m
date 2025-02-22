Return-Path: <linux-kernel+bounces-527480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A285A40BB1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 22:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB4A3AEEBA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7510202C31;
	Sat, 22 Feb 2025 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="LqCmz8Zx"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3E1D7E42
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740259371; cv=none; b=ATqp0nXdxg2kmjFiAfqNJS6DAfm/6K6yejxH/fltuvFF82m5NyWQu44+CrwNadpxhcO1DBDueYVDuGnLirlGBmctuURoQY4NN9KZSgBvVZL3HUj/pR0BjdeVcg66/3xcbkS7IHLOl/q4wa3vZ3BwrXDy1nzjwFyQm88YtWnrwgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740259371; c=relaxed/simple;
	bh=MVndxyD0kf/5RvQbIRkl5SOWhB/ClBFu5loU6sCRPiY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CC3+YNd+JOQyt+1UODgfYcIYUYZ6ojPpzrHvSp8ytV9p/L6f6K324dx77zSb6S015esD2ZkYF8ergJatxPKFlHpeVyh0O8Mp+tyJOiD+V5onw995YbUyfn225KyH7pvMydCrXyzVbmGDbPdgH7ofh87YKZbDPgL8Ig/kWq6ynTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=LqCmz8Zx; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1740259355; x=1740864155; i=christian@heusel.eu;
	bh=fUNKVKNN1H1WJwbh8to7Zf6G0zFRMAx0ceGiI+DiZ+8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LqCmz8Zx2k6nCjhHpIqy1KLTuV9yovpvTKgnDCJhqVBYNUAAX9bCJ4yG67pS0Zep
	 rjRZ4lOLnvZh0ZbvAfL3mKB2TsW0fAVRHh7i+C2Is+kQ7k0gdfGJiOWSXnZuC9ov+
	 PKL+l/m50czCcoStUBUSpY30R7V+/PoKYOmYR7bbyE0o8y6qkVVRTPGRo9MxD3V1c
	 yLLvRg9LhPHF3mP4QRQ7uoAz9QldFG97Or9/PnxISMf0r+2FgPs9rfgf1nz2tkggJ
	 h0/g5wsgMydSgZI/0kwXwiTsyUI6uaYld/AxtmG2jje54IWtf5ipWSnPMI3iAWHI8
	 ahqlnclylG5DcPsE/Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N17cq-1tIusz2Q6U-010i1m; Sat, 22
 Feb 2025 22:22:35 +0100
Date: Sat, 22 Feb 2025 22:22:34 +0100
From: Christian Heusel <christian@heusel.eu>
To: Sean Rhodes <sean@starlabs.systems>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: quintafeira@tutanota.com, Arnd Bergmann <arnd@arndb.de>, 
	Desnes Nunes <desnesn@redhat.com>, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [REGRESSION][BISECTED] SD Cards detection broken leading to boot
 failures
Message-ID: <1de87dfa-1e81-45b7-8dcb-ad86c21d5352@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sqmpxjdcfyvwzhzk"
Content-Disposition: inline
X-Provags-ID: V03:K1:e6aXLlSmuX/qM2CQlhVxfLbdOfhdo4lca7XhdfD+htBrLakwy9W
 /S1vdjXVmEQ0MRwiPaVDFhrTAKLDyxj3vrkOuoIg/uliwr0h5cxSZ3qvQD10+vE0JNQQcxv
 1Q0Zk6vx3SbVgmvvZTsmWkTyUTPDQEXM88E60BOFYoZCW+Bq/12e3EJAe3Btdk91xkAas10
 PlRn3cFUl2TsX6P9JRhgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e20n591MmYo=;zv74+gyWTkI6vY1GjCaHQVpMQMJ
 gZ1DNwC8CQzgUlH62avoaoA8E6icHNZZgOq23CSyvgHPl53tUt3BYRu0I6ynJOQLAJaajBdd/
 eBgUfNHxJ5SQDCU10IX3LhNp5hKnDrBM3L35MeiNvINx6zfMuLWwOh9RxBYZNtYO3y/B/O1fe
 LKQX7ytlWx77EPsH9mJYRkn2ScPqE2Gs7nvTZHcHoB5z8ThjaPY3IspJi3QGOyR/G3RbFXumQ
 I6mGl5bQ3MEGGtIu2JPxlNYfW1ykpL1NwLANEsqRxmxDRqFJfcdYeOhaRkPWjrDOYEIwsVuNB
 LMwMH9oXUiIuTvQnKDBAIfYsFwNw5bEnUMl73yT5kLVl2Gj1ccKK3WKCWTQyE4Y/DhW+mB4Ng
 oTHhVFwvA1oJOJFtClsn3UBGwZ/jPGMC+LF9u6ep1/VR/Ay4t50FeJ3Cr25aDsEkEH/H3X68S
 qyRMfzq/jLRdxTx5rN0xMe2DRiqdLiK+pTUMvDpzulofm+3bqnJUF+KVc5/48n4tbj+GxhmYc
 rRGnT+t9LIXPz801Xp1R3l2pxpjjiBFeKLoj3zDSy+M+6MQYFbWyl8EVHy/NiLbvF3Ss6eJyc
 U8GoE+LqnwuYJ4UQE/yRtiWsk5sqTkPHIQHU1xIP6mBBk8RBROI8TxLj6SvGNS6JP8/c54xj7
 2LNhfiAF7nfn0q66b2ibCzWHpukhMzFB/3OGxnkunDmHQVYKl2WsQ2l06kzx6j9Nl/DLuZpxm
 cVltxOdtSW1D7vpA0wcGubikQXPSk8HnvoWJhyf0g3iklAlpyNjDz9JbP8+dEY/SahzbfLNPa
 NoFZLMcZCoWCn6uh/s/NwrIPB/KLB7UbgykxTyN9zKp1m8FvHhwpa91Tb5cc1/h+3xWFyTDv7
 wsQx+MNNb3ULD5sHqGK3Qu9J/1icuJCbiFdtppD43CeBUJO/ycc1ghGe5euf6gfg4NKcoD4I2
 uMc7tw/Scl81MoxVpvmvhCmsBJxXXcEuCjtUOIRKkSThxgJh6Nu2ZkQCVXTfYkXfY6shChl8M
 BCKb+6OuHgxVcRskB/zhdnJ50rrxfD3B+7PA8GQCViMdci9tdR/RBdBs+CPl/Nr2Rba3zWHUR
 yWyuxHqvW0dZAfMyXmq5t+hP1e9cFPlSo07eYBG3lz/khv6bqo1Ncj1fnSK+TIZItasevmVvV
 viW+HJ6MkVzZw1qAG/UwUmlVbJEfAhcQ8vuTQEitKh6dhZy9nPIrcpwXpcKdM8VNMoRL1Ijw8
 h7XARX/x0QJup+wO7oqlT1lSiVcquRg4LKkTOs6PaDFuW/jjfEaoAnUayK5Cni8JV5kKaWhjo
 UAHoAK/DhX65R6Bgv9EvI16+MjuAxny6OTBK8CUFQd3Ei+gCnWYIE6By8wSm/D1QOTBais2o7
 K2SBnzEIudZN44tw==


--sqmpxjdcfyvwzhzk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [REGRESSION][BISECTED] SD Cards detection broken leading to boot
 failures
MIME-Version: 1.0

Hello everyone,

on the Arch Linux Forums[1] multiple users reported issues with their SD
cards not being recognized during boot or that they needed to re-plug
them in order for them to be recognized.

One user tracked this down to the following commit:

    235b630eda07 ("drivers/card_reader/rtsx_usb: Restore interrupt based detection")

They have also created a report on the kernel bugzilla[1], therefore I
cc'ed them to this thread. We found that reverting the above commit on
top of v6.14-rc3 fixes the issue.

Cheers,
Christian

[0]: https://bbs.archlinux.org/viewtopic.php?id=303321
[1]: https://bugzilla.kernel.org/show_bug.cgi?id=219781

---

#regzbot link: https://bbs.archlinux.org/viewtopic.php?id=303321
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=219781
#regzbot introduced: 235b630eda07
#regzbot title: card_reader/rtsx_usb: Detection of SD cards broken

--sqmpxjdcfyvwzhzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAme6QBoACgkQwEfU8yi1
JYWokhAAmj+O2o2YK7VBEY52ItcHAocRrZmRczFHhRx8eB4IjmpSHLnqFSbkhS6Z
EbOqOSDkrw62uSEeM4x9ZLKHgS1kK3/wcC6iYu6KJbMfpjUK1r8jww6rASx14Jrh
r2RuySPGiswYkERzsw2o5X+Ilx53Y/MqYlVEel4v5bW151o5/0HYBo4aRIwv+AYQ
d2AOmWFLEbmRqgdWDXn2jjoE0xGvXYPdJ+PaXL+jFj2OpSu+P/9jTW73tpE7dBkC
EZKY9l9l9sOnfd69eu1GnYyGCRWltdalcEcNtLxVbyBq8td01jm4srOXoj8gOYyX
BSpVuypa02euG9onBd8KVGIvHJrBBd4vN3gAEgDOZDQBtjHYjPxjgllOnUcLhxQG
/8AZaDXZWoQ2qxQBBuq+17vKrLcBSw85WbEFTT1z/fXyT7SpuyZTZQ5qW4Z+ShN3
uDslBds0QfOiJ887dAYy7gm0rKxloydyMxhTDZhIXyaY081U3DuVF4doZElYvOCW
cckpb9enJEoR3SNcQM7n+raV1k0HxEdOBCawUx7zFm0TZ73JgIc8TzvmtQCoJtHO
qMQroKZ7zAGNDCM6DcteRWwvN5qS/j3Z02Xmvl+asV0qC28p35YDOi8WO+/9JNWS
BL2luyqliu32Ov4u4kI9/FlYX/+Es8lL42RGkR9xEoiMWPsqlys=
=CI6X
-----END PGP SIGNATURE-----

--sqmpxjdcfyvwzhzk--

