Return-Path: <linux-kernel+bounces-244353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D8392A30C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A451C20F88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E4881AA3;
	Mon,  8 Jul 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZQuA/dwn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="e/y1lhI+"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EAE7EEFD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442516; cv=none; b=uBzcLM6nJfDzvF8NQy9xfCMVOz3TZPlkMn3FN8o4d3wQeaaEtS3WiXGNzEt06NXABxOiNquVJ8ZmBx6nN64zWMBup7ZwIFlE40ZINRO3cSVFnc3RZ6ojoyTQd65s3YgqDSt/e7PmrGpfGlOxVbnV7YqhYvE6IB7KsMjCWkI6EDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442516; c=relaxed/simple;
	bh=FqTTslULwBlm55Alz0M6QszPqBmJLX+fbyQcAlIdD5g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qdW1KoxjDK90eQHiWNOAdjL7gzuzk3mtxbYBvm0L/zC4fk9bKFsm67jP8BraEGf/UJgdGk9McNdz0epiIVAEMqgetDBBIhw5QnfGu5sqOZ7gPw6Dwae2YunVdlMBH99iV0mb9jzQepZKGIde5OEOE+9s7/uKY7KGaVFa1sEOTWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZQuA/dwn; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=e/y1lhI+ reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 15ED720333;
	Mon,  8 Jul 2024 08:41:53 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=FqTTslULwBlm55Alz0M6QszPqBmJLX+fbyQcAl
	IdD5g=; b=ZQuA/dwnfFByVaHcFHZoGan5B9ek0I0EW3xnOBS8C9Gp1YWAycIoXF
	e39sYkF6amU+3byzsNpSbwltLnm761QGp1jNCZmxRs1YoBus9Bw1HR5HxA0o5g9G
	RkmElaUOZg31m7tGWrQca9vLfVEAVd1UOyfyGvMDs4gnMtn55gMqw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E61F20332;
	Mon,  8 Jul 2024 08:41:53 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=94Yf4tyFfSPVMAH+z80cozWVvd1fXNUiaNip32emnbQ=; b=e/y1lhI+tcrbdwgswHDYB/Mr2YYnMHlPVhOxmRjcNqcgfhg1X4xM9rCdNNLE5oGnSxMpmPfKYfYOUswq1LSo5SnhVP9UOVSaGdUBEhi4pw2vqQrN6MSWLn8XTLjgd1W3bP8NJ1CySMtPKd8otiWihUv68Q30SN9Iw9XoD6ejHIY=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7EA9320331;
	Mon,  8 Jul 2024 08:41:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 6CD65D3D148;
	Mon,  8 Jul 2024 08:41:51 -0400 (EDT)
Date: Mon, 8 Jul 2024 08:41:51 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mul_u64_u64_div_u64: make it precise always
In-Reply-To: <fxqlcqxvcmfuviqtlkcd4qrhxf7xmcpuokkj4ebua2q4h36bkv@vgy53gbeqrdt>
Message-ID: <so2o9n6n-2955-p5o0-9r79-nr113snsnqp5@syhkavp.arg>
References: <20240707190648.1982714-1-nico@fluxnic.net> <20240707190648.1982714-2-nico@fluxnic.net> <fxqlcqxvcmfuviqtlkcd4qrhxf7xmcpuokkj4ebua2q4h36bkv@vgy53gbeqrdt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463781375-1807158697-1720442511=:826828"
X-Pobox-Relay-ID:
 73AA4C7C-3D27-11EF-B05C-965B910A682E-78420484!pb-smtp2.pobox.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463781375-1807158697-1720442511=:826828
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024, Uwe Kleine-K=F6nig wrote:

> On Sun, Jul 07, 2024 at 03:05:19PM -0400, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> >=20
> > Library facilities must always return exact results. If the caller ma=
y
> > be contented with approximations then it should do the approximation =
on
> > its own.
> >=20
> > In this particular case the comment in the code says "the algorithm
> > ... below might lose some precision". Well, if you try it with e.g.:
> >=20
> > 	a =3D 18446462598732840960
> > 	b =3D 18446462598732840960
> > 	c =3D 18446462598732840961
> >=20
> > then the produced answer is 0 whereas the exact answer should be
> > 18446462598732840959. This is _some_ precision lost indeed!
> >=20
> > Let's reimplement this function so it always produces the exact resul=
t
> > regardless of its inputs while preserving existing fast paths
> > when possible.
> >=20
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> I would have wished that parts of the conversation about v2 made it int=
o
> code comments. Anyhow, *I* have understood the code, so:

More comments coming soon in a follow-up patch. I still don't know=20
exactly how to convey=20
them though. Suggestions welcome from someone!  ;-)


Nicolas
---1463781375-1807158697-1720442511=:826828--

