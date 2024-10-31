Return-Path: <linux-kernel+bounces-391318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB9D9B851A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BDB71C21779
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976DD175D35;
	Thu, 31 Oct 2024 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ion1LLKz"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5091B1B95B;
	Thu, 31 Oct 2024 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409417; cv=none; b=krb8cHd8Wv8Jm8jG88MLQCnCceRBKtZIoacbWFdxlpa875wDSqcFtao8xRAk9f/7IX1N9QyirCmazKvOUEi4F5+Z0BexZ8DSn8OIq2OTi0S8Avv22DwcgZGTer1annOSdDLEr4Ab7XnEsO3B1J9mNepOfEqAJB7XnhAzRVJ9LYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409417; c=relaxed/simple;
	bh=0RXZwlD69MBElayrsTAuQU0gzCpEwND2Br3znzW1Ahk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PjnIt/9B1yDecWjqKFJ9FtyeRUblsJUY5CvD9ow3u43xwb3FAdQwTRMi3SUiRyY12xaOR3LQtNVlyptgdLQgNfz7jRWcBznIbCU9/kv3xH8uGFCiBNWTGB/UM3FtbxIPSXv3qMs+0LiBBkVnmvix8xouOBhd/HE9/BG1TuyCORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ion1LLKz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1730409406;
	bh=l+7EQiBOl0fXyOqmXw5/UYQ0mXPqaZ7wipfrMSKekjs=;
	h=Date:From:To:Cc:Subject:From;
	b=ion1LLKzPWiqBIVAg8tZ8NLO6DCJGN4nUUe6nD6YGxxu0TEwtLUseKj+pKdIcXS82
	 iS/Q1LvJnj4rkediHLzzmJ/s5Dq+qcNLfzDalIepOOr+f4p6gPRo19csXeBQfLfkcX
	 jt5z0I35oAjKu09NoxoryL0RmvSAQPNt3ZFLYim63QdYaNlu1Iedwuf4hcFwKJSDs1
	 X28Ee+0lWU9idqLIoqUUL3y66s7X6RL5X06dQQTitRRLw4J9u7F8QLd1gqOqouu9RZ
	 sQ0s8wzbFsPVDdwXkZwsgRsnaqsRzxO28gqxvhgNefUDhJ3a7YIrYR0wJvb4jwYdqT
	 WaXOElvsLRsCg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XfcHy2Chlz4x33;
	Fri,  1 Nov 2024 08:16:45 +1100 (AEDT)
Date: Fri, 1 Nov 2024 08:16:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Suraj Sonawane <surajsonawane0215@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the gpio-brgl-fixes tree
Message-ID: <20241101081647.16203060@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H9vk3irmlvz98rVaLW+f==k";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/H9vk3irmlvz98rVaLW+f==k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a14968aea637 ("gpio: fix uninit-value in swnode_find_gpio")

Fixes tag

  Fixes: 9e4c6c1ad ("Merge tag 'io_uring-6.12-20241011' of git://git.kernel=
.dk/linux")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/H9vk3irmlvz98rVaLW+f==k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcj878ACgkQAVBC80lX
0GyrfAf3VRbXw+1YYtRilSDcL5/Y3WwPU7FB4F8YhGDvt86wjKS2QkmnOC7yHz/C
7FQKsNv29e4A486Jg5uAVhUuljxedC6BoLRfve0X2syoHv5S4sBYU7ZN6EjTZp4i
LEw3Qhnx2AwOgdcccnBq+C7pdEe2RRIvCydU5+bjs0XgwroQhBCs6c2w+b/2o3Bj
CQNTkXSsBkCCmyTGbEbSD6eiJc+vYjBOdIv+vEbU45rEt8+3/buRe6vxeUFKwg3D
TwoOr+h5LpuiCqTYCQaPMc1uyGrtyK6Iog616rwXrQTi6QoCbqxylnCU9Q3AFGP1
bLl+/mHhmEA6kFzQRETuJrFK7xwp
=g9rV
-----END PGP SIGNATURE-----

--Sig_/H9vk3irmlvz98rVaLW+f==k--

