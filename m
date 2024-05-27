Return-Path: <linux-kernel+bounces-191250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CC08D08D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF46FB25D89
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663061FF3;
	Mon, 27 May 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="3c7ttSC4";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="F5dDtNqN"
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328317D2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827610; cv=fail; b=jbSGPPj17aoTYpEZsxdvNZ9F/n8jXRdm0I7QpxnrPyX5zS0MBVdC9XXLfc6fGqoRRlnr3pVs6bOWknE6VWzGYTgSlpeM9vOk1NkYHXPSliStHOSvUnNld96oz0YgfFjE2KvP3yVB99btrN5VSBDDsJbdyKkssYlZqmIdB3F+q30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827610; c=relaxed/simple;
	bh=b5EgHURAKNQ3zZcjswUkVvJeg3U23SQhv5RY+uC5MIA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KBxu4c8zv+58GgZppTuKp90ErPl6zM/wDV73RpB5TvJOyp3zf5nHabxiBt3PFJy0+kQs+slD5jIVMOy+Qa03i6VdcLDGZLsEt6vt+G1cIhlb/O6/bBbVRFl5F+2/M4uyWyU4Nb5hV1bz74JD+HnS1T8l5p7t+WmxWe2YSnoPOLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=3c7ttSC4; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=F5dDtNqN; arc=fail smtp.client-ip=72.84.236.66
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
	by s1.sapience.com (Postfix) with ESMTPS id 1BD6D4809ED;
	Mon, 27 May 2024 12:33:27 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1716827606;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=t3y2PU2kYeZJ8qqKHUbebK5uM1AJRB+Prp270Qk9zrg=;
 b=3c7ttSC43J5rWD6gkPhkEG53b0ILWgoBmThdC842SruIjqo5yOGMOBtNHaQXnxaFNRXvt
 10k9nT9N8lMbDhuAQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1716827606;
	cv=none; b=CKt4/ZWnYwypkkLaAhQisDGzT0Up5St22EplEihzk3NgCJoVRh49Im9GaAxD/G5vi77lmD18goaUTO720sT3wNC5MTrMxaJrJYystKxls0MqJ0nWO3VCxq3/Mt19n9yPjgeT7v7NJ4kcbxsnPSSmSCDJtps0MJ8JIOUcmdJ8tMTTQQoSJJhXdST+WkXIkSa9HAoxl6s182rRCnVTbGOKGWRgSVBAZQ99sOSn/qFSwp1Mw2X2uEpKoFaaQiKWSEynsMJDcKae/fF/JvELWsX0aKSy28jXjSV0R+ZbHw7bEQE7eCM7jOQwsiQVdWRY/Nmx3xDGgwaOZv2+hs+DCB+5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1716827606; c=relaxed/simple;
	bh=b5EgHURAKNQ3zZcjswUkVvJeg3U23SQhv5RY+uC5MIA=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=ccnMnY5LQJPR+7mGrV5CWOlzPMLCh4bxmFQXZnHqNEwM8G+tAOnl/JUkzclJD/rez7LA/6/fx503guKz8yzv4oBteU+jgZe+GSDCxF1XdIr3IrdktfAC1ewxLsGfrR3AcUdVtLlFTXhc1Uia0vhK8QB4rxz51Go5HBmMQ+0EfaDtLeYXHj445nARIYNqn+9JDuEKdMwIgFuDkniTT/qwVtbwz6R4TdYcD9x6gwkBFLyXS/CQYWjkM6520B/wUXgKF8xtIRA6woQmYR+QKHbDYKCVpE4uq8PWOlLyCFOJzh8Xd4tGCR8j4zhzgbC4w6ZPKWsNJtr8Dyw6m3SX+A4T8Q==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1716827606;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=t3y2PU2kYeZJ8qqKHUbebK5uM1AJRB+Prp270Qk9zrg=;
 b=F5dDtNqNKB8xRNeSjsO7C04vY8ImW81dN8aIS0jubquif5P0+iQNrawrF3mwlZEPKFLJB
 zhA/ejDFTfdbSBcyzqp10MwlYqvBatLu/ZwdqaS2m2bGVaUBJgkWc073KsXFy+6wpXhPK5m
 CCpqeWZ1ntRbgsztnP45pKZDIqG/znjqpDUYYvA9FWK6ptsrc/aIXx+8eMod4tdBQgapRTu
 dN4i4qeXyM/kJzmcpt7qE8ZwCBdzADwmzcOEO7739up/hWKE/EyaSqYE/d98U0v2C3Z5V/w
 xQcjyH9TyW2y1Hlb6KuEnLloeAO+IzL3JalAqMG8ZfU6XmUVblD8DkNQBc1g==
Received: from lap7.sapience.com (lap7w.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by srv8.sapience.com (Postfix) with ESMTPS id 055FB28001B;
	Mon, 27 May 2024 12:33:26 -0400 (EDT)
Message-ID: <2ae2083a9b41b240530d44050e38d49064347db8.camel@sapience.com>
Subject: Re: Intermittent inability to type in graphical Plymouth on UEFI
 VMs since kernel 6.9
From: Genes Lists <lists@sapience.com>
To: Adam Williamson <awilliam@redhat.com>, linux-kernel@vger.kernel.org
Cc: jforbes@redhat.com, rstrode@redhat.com
Date: Mon, 27 May 2024 12:33:25 -0400
In-Reply-To: <8fee69cc8fdd67fd265790c0fa287cb9566c2349.camel@sapience.com>
References: <75c17881-68e9-40e7-821c-5655d49d7c0f@redhat.com>
	 <8fee69cc8fdd67fd265790c0fa287cb9566c2349.camel@sapience.com>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-K/CGUUB6kGMKPojlXgYt"
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-K/CGUUB6kGMKPojlXgYt
Content-Type: multipart/alternative; boundary="=-QX8IVvAd8Ep7yuYuwSk+"

--=-QX8IVvAd8Ep7yuYuwSk+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-05-27 at 11:18 -0400, Genes Lists wrote:
>=20
> =C2=A0 =C2=A0 cpu i9-12900K =C2=A0/ Raptor Lake-P [Iris Xe Graphics]
>=20
Sorry - wrong cpu - the correct cpu is:

=C2=A0 =C2=A0 13th Gen Intel(R) Core(TM) i7-1360P
=C2=A0 =C2=A0 Raptor Lake-P [Iris Xe Graphics] (rev 04)

--=20
Gene


--=-QX8IVvAd8Ep7yuYuwSk+
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><body><div>On Mon, 2024-05-27 at 11:18 -0400, Genes Lists wr=
ote:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left=
:2px #729fcf solid;padding-left:1ex"><div><br></div><div>&nbsp; &nbsp; cpu =
i9-12900K &nbsp;/ Raptor Lake-P [Iris Xe Graphics]</div><div><br></div></bl=
ockquote><div>Sorry - wrong cpu - the correct cpu is:</div><div><br></div><=
div>&nbsp; &nbsp; 13th Gen Intel(R) Core(TM) i7-1360P</div><div>&nbsp; &nbs=
p; Raptor Lake-P [Iris Xe Graphics] (rev 04)</div><div><br></div><div><span=
><pre>-- <br></pre><div><span style=3D"background-color: inherit;">Gene</sp=
an></div><div><br></div></span></div></body></html>

--=-QX8IVvAd8Ep7yuYuwSk+--

--=-K/CGUUB6kGMKPojlXgYt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCZlS11QAKCRA5BdB0L6Ze
27fOAQCPTsn5CvPWbUuRb8Y8OfkbTl99Z85zIFANQMEMZw5YlAD/X9bG7kceKmzH
PDVZIPOAtlIUH+ZMG5TPEsrKQAkACgw=
=3aeI
-----END PGP SIGNATURE-----

--=-K/CGUUB6kGMKPojlXgYt--

