Return-Path: <linux-kernel+bounces-442056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FFF9ED769
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F7D1888D04
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF0F211A0E;
	Wed, 11 Dec 2024 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="t3lZNbt0"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4499115746E;
	Wed, 11 Dec 2024 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949815; cv=none; b=Qc9oMpr5soHwW223s9FVZuwk45P6P7IZJs48ujoJvVsL+zjbYF9WoCDtCe14TkUcPlfJowFosL4sVLQS7OvD3XITZgzp/k0XMcQeagobFujnXq3sJs4bMEU2u7W9gZ5anU38pLIc8hvNJciggv2ngXTXtmEKpVJ09sGtdBXRC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949815; c=relaxed/simple;
	bh=peNxnft8Rk4uOKWn1r2Cpb791kC/5zpQd4LClny23SY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mW8E0C03oIfs+LwkTDY5wduc1oldRwhwWfWVlTBM+BzL3Bt8Ds53lCoW+1IxlTNyfWPMuwlkUH2yWZRvhbhiLzxEi0lEoyb/JpVcqUGdumS++F/bzPsZR5UZz64ClfyYE1n7Ncylr2//8bfQ7Sn/yMjiqowD0/b/5/ZUWRlcWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=t3lZNbt0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1733949803;
	bh=bsDljuDBjuJYvqrYMEZIWjCshRIG0H3v1815+7ANi2A=;
	h=Date:From:To:Cc:Subject:From;
	b=t3lZNbt0HcNZwg6wM7zLvcan5aWXQ1pBBnU/QaHXuXCA5UdyCgv4QzaAFNwpMEF43
	 xxWxCvckSEfOnjL3bjjleb6kvWbhecKXOepHeBBPQRck1TSxrcctfERct1sK3c+7Xa
	 e54qpCCQLJ/U3vIoE2a94bQlrMKZrXLW8hFAQdfTlDST9DXyjf1avMn75fgfvkyYsm
	 +pEVIpepyPSot1fG+re8EmQ3szkQO39qBfXOuMu8R7XyIZrjWOxlmJHalS5PYqfD1k
	 0i8cInfrQBdSdQ3MXehK1HStO1ZuEpe4T0u1rnBZdr9hA41W3ER/D7YJlzAMDJKsA8
	 9weGNsh/tmDeg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Y7ncW5tBdz4wb1;
	Thu, 12 Dec 2024 07:43:23 +1100 (AEDT)
Date: Thu, 12 Dec 2024 07:43:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the pm tree
Message-ID: <20241212074326.207d3373@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//utZjtgztGbimUBysg4f8n9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//utZjtgztGbimUBysg4f8n9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f9320cd0fa4b ("ACPICA: events/evxfregn: don't release the ContextMutex th=
at was never acquired")

Fixes tag

  Fixes: c27f3d011b08 ("Fix race in GenericSerialBus (I2C) and GPIO OpRegio=
n parameter handling")

has these problem(s):

  - Subject does not match target commit subject
    Just use
        git log -1 --format=3D'Fixes: %h ("%s")'

i.e.

Fixes: c27f3d011b08 ("ACPICA: Fix race in generic_serial_bus (I2C) and GPIO=
 op_region parameter handling")

--=20
Cheers,
Stephen Rothwell

--Sig_//utZjtgztGbimUBysg4f8n9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmdZ+W4ACgkQAVBC80lX
0GxeYAgAkp7WRCunPY6knu1gQTAEmKVQHe0PjGFe07t3BKjNZQsxGGyVCbjWwj0w
4/LbG+xMmKhjk/Awx2GYY2pPOyeZq4ouxN0H5vVFYh3S7RuiUhXOelbcNba5VqGm
l+LoPaG8fEwgonp08/bvHYGVTZGE40JOs8Xp6Qdt+xBfbL1DFTIg2tQX9GLlx2pr
bXl/h5IW4vof63y6cgdcLy2PquPyky0QM8Hk3paIpWlAGv9uT3U+eUs3exWcZKQ2
0a+SYBTkPa0fqr2aUPTiegnJDy0q4J4RVt6BVWQXWH7I6ZlX72bUc/ZYYidD7Kxh
4JOquUSVq6jSqt0ktPtBfj/maKNuig==
=5NVR
-----END PGP SIGNATURE-----

--Sig_//utZjtgztGbimUBysg4f8n9--

