Return-Path: <linux-kernel+bounces-354158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FE399387F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A214928676A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F9218B49C;
	Mon,  7 Oct 2024 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j5HrxydV"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF3618A933;
	Mon,  7 Oct 2024 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333925; cv=none; b=J0RKUJvkxEI9FODdqIKJ13tUZny3ZKSHm7CEiS1fLpJs52nOCgdusVvdLtLQgUxA8fTz/9dVupcaUcn7cfKg5vw8YawwO64IFu2Xsrwa6r4uqRRE54F7qqCwDKQQAQg08t30Bg6ah11IFC/qbO3aNDoSzvVhpiZIBnhhXNNdSDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333925; c=relaxed/simple;
	bh=53LF6NNvOSJQlwgLWZy2ucejcFSybu58BvQ3FPN5aCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hPwTHTUdWre30uYTC7tD4SwB5o+dcmOKsgrTMeV5D2zRw83Yx8sbF1EcX4C5prgv5eluWbF9a0FPtKOQLYI873nxFX7uHWF2Q630QTlQOEnaHZVHZkWWscJUQUtLpPLeUZ8XLYX4O/m6n/TeiPW//jNPklg+C/JlDKQ4qfQqjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=j5HrxydV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1728333912;
	bh=QsuTXkh5lGRrAADAk9U8T+sLLDlVKKundwfx8cebRAk=;
	h=Date:From:To:Cc:Subject:From;
	b=j5HrxydV8YiQRAGkvxAFdvutwkfNfWkFdugYriIwIF+/oYWfzdVaScfVVw5VfsPII
	 CBjHrjRE6feoMtFn5pvfkxKdAuZgawtSGyPsXKz0Q7e5Y5RRndMSHAysgHX0su3heZ
	 ISFCRrUDxmLfQIUJdUaPniux0q9rBvkLfI/FTJBELKyK/to4P0euV8jnu9Vk+GeRKl
	 hWn41BoHCpZpz4qkPab+rEUPTxS+40HhEGuCXS6K5WyIKIW6t53RFXZnIO/8WRI+a4
	 ghwBBtK+NfG1gr/h1IMVSYn/e05EZX5s8yRn+TNW/QT/fG6l148VOnvqYAJ85wAJeo
	 GrcMhdCi6XLHw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XMrkc1RZDz4wnw;
	Tue,  8 Oct 2024 07:45:12 +1100 (AEDT)
Date: Tue, 8 Oct 2024 07:44:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Edward Liaw <edliaw@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm-hotfixes tree
Message-ID: <20241008074446.02e21933@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/csNfziXxC6Pa7KAovV/r17Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/csNfziXxC6Pa7KAovV/r17Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4bb3dd34459b ("selftests/mm: replace atomic_bool with pthread_barrier_t")

Fixes tag

  Fixes: 8c864371b2a1 ("selftests/mm: fix ARM related issue with fork after

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/csNfziXxC6Pa7KAovV/r17Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcESD4ACgkQAVBC80lX
0GwT2QgAor2aNuD4T06mfmrOOvbiQX0vcVqj2jO0XsnAKpiZX4idQCLpCI7ik1+5
KWmW7VMwYvbC7MsBkah95QHKs/JdSdLVNFeN3uJvO/Nm8+RMcObehq0qSNJyCuYJ
RCL2LdU1D3Rn5wfqjib226FrHoJhlsK6MINyCf3r36bgUTGtbcU7yY2zNgl0hQ+k
IG/NyrCFyjY0HDVIk9X7b56ZDtSdaBPpuzd2drScEc4/pkUaMAHOcAfQKyxw3Swv
ssk+hypYi1E5uUNalRYfrDyARZTj3GQLuWASBPWygPIi8vq9A4aUMJpCpTzBTm++
3ieyX2WXmNp8OlEKpg/pPCoLytaW8A==
=4i8C
-----END PGP SIGNATURE-----

--Sig_/csNfziXxC6Pa7KAovV/r17Y--

