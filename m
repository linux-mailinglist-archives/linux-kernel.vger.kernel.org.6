Return-Path: <linux-kernel+bounces-194561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1D68D3E37
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E77285189
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B810015CD59;
	Wed, 29 May 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="D658ylIp";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="IzmzNyB6"
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE515B575
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006647; cv=fail; b=TNEFkxhz8nZQno07TJyA6ty4U1FeEeqgEr9ZQ6/pZFmWgdysRpesZip8CUqxKQXzActVdeJTsjqCxKgALl/f1aN/Y2CsLRPZsE+GjQ3qsB/S/4IbdhkJoELWDaTjTCYv/r0ucjp4iWooVOQmWU2tY8vcIYuyUv7QQB9oVAqyKlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006647; c=relaxed/simple;
	bh=EyhckvVm2a5/R7Gd4g1kKgdM67y/GY/cspQ3Gw8Ro2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRin4estXdSnBW9TEn6ZDvVGri1CYS4BaqjcVOcz7mYj09G/G4Bn+Km8VTyMkWKrpXbI06GtZjjJqIQ/xMKJ6MdnmU2NpCZXlW6uI3TQ9lVUG+6A1UVgKBQVxbLj+hwV3STV1/eVEMSSwOqf/swVdlYKFQWD2NYNABU8yG/0E1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=D658ylIp; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=IzmzNyB6; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.sapience.com (srv8.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 8428B48099C;
	Wed, 29 May 2024 14:17:23 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1717006643;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=XUebccGL4OfbGpTIxAPqulwEmf7Yl5LLhgv/rXDB/y4=;
 b=D658ylIpT1ZPvH0l4T1Fyz6QAm3Xd4zNodOywYgISBjFmlvzktnkujpbIvr5xx65/q5RQ
 ji6Tu+c857cVexVCQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1717006643;
	cv=none; b=nXFGmq0RayC9mAnhmJkzWPSNmrih1406n+ZquhR+PA0GqChVN3BhtvVf1Qpyj6nG+ifCnckIEwHePLSyPjrFrm6aiDm/qkoQHLQaYLjj+7GRpPs0llMTD4tdAEZL/hEoqBo336jp5urUyg7QXV/OYLt3j30jlsFuR8XgbGcd7GPMepm/MhQJAMldJMP7zCm/Y6HdeNGeTYHqUohfGg6GQj1ELWA2WzGHQz3FBSK7ZgsL8YtaNFXR1XpFVTAr78ZWxvnMn6yUvolh2IZbZSHBRLLEKcgjsnNWsJz9GKIRk9WgfW8t/KrK3WNwcWhUJl9TkYBfJmmE1MuiTfV2la9ZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1717006643; c=relaxed/simple;
	bh=EyhckvVm2a5/R7Gd4g1kKgdM67y/GY/cspQ3Gw8Ro2A=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=JRh7O8DLePTmne25sJFwYVfRF9cpx55V+M0w7dlMheyTztCjUBuvOv9Pmbq5qcj/ScybJi8MglIap3o3Y8M+EcalSlq45bugC+vNZ6OlfG2VPHrbNL7X+YsAhIUtm7sr3WGInd8dGSQ5+w9ZujLvwOF6hcfhpzIYHT+RxlTtOOhfSQ2yTcPzg5vuU5P0LJ1x647kJO6qaRJIF1DzDzQPf0xNAiP/MQmcN/JnEUw5WI+88mPki1e4bbhvNXACz6MixPDq5qmkTemY8UfgyqvvX89TSwBYHjS3e2b2SGDOZzEdPzYrcSDXtIJXD2B0+Lsc6R91ffFXwKsvJ6dtEeEvKA==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1717006643;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=XUebccGL4OfbGpTIxAPqulwEmf7Yl5LLhgv/rXDB/y4=;
 b=IzmzNyB6P4ze6qHg2invxjTaX2UCR3zY4u3Oztznzi96Z/uHT2rAKU11XFX83L5kgDyYz
 NOi5G+wEQDaD53Coi+4J4M3LFom7smMYGMR8qnvBeYatJOOBW3qxeBvGm7ap5abmFit6KxY
 mEz2LE0GvLy2dki6UQ3n3N4WE/ccF1BBQ2GxbJADcUXwSwParszsiTdNSjOE/n0P0tSLWgi
 pRgzodQTVXOoC1PBVSSNZKSnHaDfDokiR7oVTMkuhaDWB5Q65wa/XihmZW8Qyt+HLNWWSE3
 QUJAtqUd8vSoNPrmYNxlCuxxhCR/tQdHLOkVy2MMXU4aF7k++gnfsPL2P2rg==
Received: from lap7.sapience.com (lap7w.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by srv8.sapience.com (Postfix) with ESMTPS id 5A374280042;
	Wed, 29 May 2024 14:17:23 -0400 (EDT)
Message-ID: <49bc946ed3f29b819e3b1b2f91f0c42f07b47769.camel@sapience.com>
Subject: Re: Intermittent inability to type in graphical Plymouth on UEFI
 VMs since kernel 6.9
From: Genes Lists <lists@sapience.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Adam
 Williamson <awilliam@redhat.com>, linux-kernel@vger.kernel.org
Cc: jforbes@redhat.com, rstrode@redhat.com
Date: Wed, 29 May 2024 14:17:23 -0400
In-Reply-To: <937e6c6b-7d98-4c9f-b3f7-47e1d6562963@leemhuis.info>
References: <75c17881-68e9-40e7-821c-5655d49d7c0f@redhat.com>
	 <8fee69cc8fdd67fd265790c0fa287cb9566c2349.camel@sapience.com>
	 <165f7cfd-41bc-4c37-b859-a418a3ccece7@leemhuis.info>
	 <c5b3d3ec7701b51dd7b163261c84fb54c778b9bb.camel@sapience.com>
	 <937e6c6b-7d98-4c9f-b3f7-47e1d6562963@leemhuis.info>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-hf2nUVxltrbbuXaIrmJK"
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-hf2nUVxltrbbuXaIrmJK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-05-29 at 16:04 +0200, Linux regression tracking (Thorsten
Leemhuis) wrote:
>=20
> np; but without a bisecting or at least locating the subsystem that
>=20

Yep. I will set up luks + plymouth on a (different) machine first
instead of my primary laptop.  If that reproduces the issue, then
bisect should be quite doable. Will take a little time but will work on
it soon.


--=20
Gene


--=-hf2nUVxltrbbuXaIrmJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCZldxMwAKCRA5BdB0L6Ze
20IoAQC54YgzwhSy7BjW5KMbvvraiUrj6e5IxAJUt6nGw8ITeQD/SRy7vlrvL6n+
ur+trD86Kzit4ylH+Ddwk9Dc8nvdOgc=
=7IHX
-----END PGP SIGNATURE-----

--=-hf2nUVxltrbbuXaIrmJK--

