Return-Path: <linux-kernel+bounces-244357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A73692A315
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCDFB20B9D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA5481211;
	Mon,  8 Jul 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uJ+I4i9C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="zA9DGP8o"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67017E0F1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442601; cv=none; b=lAcse9VzXGllCdUKltVvp2+J1kbQ91uvwmZeFDXzknJiV21fB1W1445HXBThhgXjwTeVYuJ3IZljlsCa8LYaPhPGS59XuGuLCY06AkYimj0mep21InwKMkM9TrAVbv4snTu0JOn4i2L5sV+k2uhfy5ovLMqIH4Df0ngDY8PfczY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442601; c=relaxed/simple;
	bh=Sj8dq56WHnqpDW3EJuSCzyx6a/EVZChEdc13sNBYjCM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hVO5zXTiZwnnOt5SNEOxUig/rzJCQlHn8Inaxk6CrDK+UcwToJA58y+xNzmvtiEv+OFgG6Mzv0jLteCiJZunHRWc3lwXqMhofHIjyBsC+1z35FqQH1GCICTQ+4CR9bmLl/OHofIIQNdXv2M+LTJGb9o4sOlnBS38m8oBfDKXNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uJ+I4i9C; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=zA9DGP8o reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A04620341;
	Mon,  8 Jul 2024 08:43:18 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=Sj8dq56WHnqpDW3EJuSCzyx6a/EVZChEdc13sN
	BYjCM=; b=uJ+I4i9CiCJM6JrzFFu+VjTup38Uth/1im4QxiyOHhEo5iePTq1g0Q
	8bjIeHbqdHqVPhDY28qwWHDDimZeEizv00HOKfleouDyLyXmD22WKhea3l/gW+hi
	IPHvR1W6Cz11Cd7N27WM90/dvxV4dzPeVyGEn8cbDlpuStyb3TQnI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 924B820340;
	Mon,  8 Jul 2024 08:43:18 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=dWm9CSVC+GPoMmSbbveKW8Rh5xMK+1DRAgEC7oHO654=; b=zA9DGP8oJGquhFN4rL1WrkPKZwvifUQRKArsw1xN72IsD7m1QmrJt5Gqiyx81F6bVgPS+T6NSKluzB9O4DPm0AXjQh3tDrVVGnibLHC5zFJhm/9cpXJNRtvSOhZXZhp2erYyv0Cs/MwiGfZGmUoSIzPv3YEdWSjUgCKqiQt/rE0=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C80C2033F;
	Mon,  8 Jul 2024 08:43:18 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 03D9FD3D164;
	Mon,  8 Jul 2024 08:43:16 -0400 (EDT)
Date: Mon, 8 Jul 2024 08:43:16 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mul_u64_u64_div_u64: basic sanity test
In-Reply-To: <nkvmie4gedfeqw545wl27wwiw7gderp76tvjnehpd4bf5y7suu@sp7dclirn35b>
Message-ID: <nrss95p0-3s44-6q04-9onp-nq07n001075q@syhkavp.arg>
References: <20240707190648.1982714-1-nico@fluxnic.net> <20240707190648.1982714-3-nico@fluxnic.net> <nkvmie4gedfeqw545wl27wwiw7gderp76tvjnehpd4bf5y7suu@sp7dclirn35b>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463781375-783957929-1720442597=:826828"
X-Pobox-Relay-ID:
 A6B043A6-3D27-11EF-8C0A-965B910A682E-78420484!pb-smtp2.pobox.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463781375-783957929-1720442597=:826828
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024, Uwe Kleine-K=F6nig wrote:

> Hello,
>=20
> On Sun, Jul 07, 2024 at 03:05:20PM -0400, Nicolas Pitre wrote:
> > +static void __exit test_exit(void)
> > +{
> > +}
> > +
> > +module_init(test_init);
> > +module_exit(test_exit);
>=20
> Can module_exit() and test_exit() just be dropped?

I suppose. All the test modules I've looked at also have that empty exit=20
method. Maybe dropping them all separately?


Nicolas
---1463781375-783957929-1720442597=:826828--

