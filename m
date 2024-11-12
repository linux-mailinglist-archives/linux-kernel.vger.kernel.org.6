Return-Path: <linux-kernel+bounces-406792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459209C640A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00D11F22E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC8021A4D0;
	Tue, 12 Nov 2024 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x9m8e/k9"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141A2D53C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449304; cv=none; b=liMn+4dmRNz5YwR7yUmE9PpAHs8P35yVepg68mxLOHVf9aSMFRygtVBPnWwG+q224/2E6yFWwQQSs5r1umzyv+0J53o8sqh04ToKPM0GS+zyyowsSTt5Ficp8dahwxmpM6unO47ZWu92KHtd+nnm0OUzu3UbZxGG7Ya8zQfEubk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449304; c=relaxed/simple;
	bh=XqOz8FVgipoACEhIp6ggdhQeZg8XyBDA6VVHbKBHcZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsmRfzGXEj/mw9cS0Ty83ux8Xj/FWlSU+oObnHZl2tjrikaDpqxk0H3TVs/uFLjRsin4nWRzzh8KKP+R6kHju6Wl8sgCwa51ZK98SggWAphWd5PyZWbFI34OB8soz14y7Al56v5Z0KqWjlZ3YrFjD/SoD73aEuqvngiNVWLag7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=x9m8e/k9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d5689eea8so3654507f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731449299; x=1732054099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJylpJUgo/iG/Eh0WelGCKTS0ThyvTDob0Ubb72pSBI=;
        b=x9m8e/k95j8jxMfIpXa3R+/9CLM06MGsGnOg7Sado4b/kX/avj2YJMOVCXUORot0if
         ErMm9MPTnessG0BAPtMag5UmnBvN0S1uN1D3NAh883obNEWPQEWbmttBgyWN3w6ovq5T
         cdtk5JupGhBgIxVEj8sUgbvnc4UIu/YXkUrjslu7dDVbxP2jm4KeEY/fkbA/IqmnvL1r
         HJ2rqH7/Ihz/8fK06RrEEqfcce7ZXWP+geqEWpyISFS+Uecn4xk3l+lhVCOfC4fh/kEB
         539frwKwsleqTNuPfR/UYz16x1izY7dmMCFHSoTfy0zo2xIpbCNV45Hdm+leyjoPqO1L
         lSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731449299; x=1732054099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJylpJUgo/iG/Eh0WelGCKTS0ThyvTDob0Ubb72pSBI=;
        b=TN1wP1homkFlgKF/5rMNdQQDfWPBT8B63eUfWima0iz/OpdB5hx+wQKQi5067bZpUj
         OlbK4x1eUh3iwVcfn08x7KVQLSr1xqEP85v0kFBNDTzzVFuLB6TnYA4eK6R1dNFOj8wq
         4Tz5bDbfqyX+DN4kT1EgYPKn9VEpOmexAxJKffL/WztXg0pr2dm4Rgh+q52AvZbWsYnd
         i8Vr8oMwpQ2I8hs2dFhUodcg0KPe/wm3QJz+Uzf8sjkMP+UiCci55SNyJMhUJBCKlm5u
         hE7SfQfH+TmnVymOO8BRXtcrTB7/w1pSYYRmKa4CZEgcuBQ/e22sybupAEL/HsTRaKG3
         eavw==
X-Gm-Message-State: AOJu0YzH1d3NKJr2OmeDtrb8yNqbSQ4Z7qEZ9w/n44afWJwqNMicbQvM
	R7Sf+wlRicDHCeBfwg2Gwd1KJ1KUCI7p7uqCUwuYXwMAABHhL7z6eY/xCgFnZgo=
X-Google-Smtp-Source: AGHT+IG7QZ3fRMgbfhgQ2wS4P7OIUBdKu5UAYeOXix9MiGwFFYV5DBnnL8+/P4wACSJCnkUy6NKUvg==
X-Received: by 2002:a5d:6d85:0:b0:37d:4e9d:233f with SMTP id ffacd0b85a97d-381f186b5eemr16755743f8f.24.1731449299276;
        Tue, 12 Nov 2024 14:08:19 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda03e42sm16725287f8f.89.2024.11.12.14.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 14:08:18 -0800 (PST)
Date: Tue, 12 Nov 2024 23:08:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, 
	Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: can/should a disabled irq become pending?
Message-ID: <nlzd7endwgf46czretmoqlck3fjp5vnvnkv2tsyql632ym5bfo@phr3ggjyx633>
References: <io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc>
 <87r07gmej2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zzadathp6w3a4jkv"
Content-Disposition: inline
In-Reply-To: <87r07gmej2.ffs@tglx>


--zzadathp6w3a4jkv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: can/should a disabled irq become pending?
MIME-Version: 1.0

Hello Thomas,

On Tue, Nov 12, 2024 at 08:35:13PM +0100, Thomas Gleixner wrote:
> On Mon, Nov 11 2024 at 14:03, Uwe Kleine-K=F6nig wrote:
> > The ad7124 ADC and a few cousins of it have the peculiarity to report
> > their interrupt on the SPI MISO line. So while the SPI clock is toggling
> > it behaves as MISO and after a transfer it's a falling edge irq
> > signal.
>=20
> Saves a pin and the fallout can be handled in software, or not :)
>=20
> > So the driver masks the irq during SPI transfers (using irq_disable()).
> > It also uses irq_set_status_flags(sigma_delta->irq_line,
> > IRQ_DISABLE_UNLAZY);
> >
> > Now on some irq controllers (e.g. the rpi GPIO controller) the detection
> > logic is off between calls to irq_disable() and irq_enable() and so on
> > that platform calling irq_enable() makes the irq handler called only on
> > a real irq, while for other irq controllers (e.g. the Altera GPIO
> > controller) the SPI transfers make the irq pending and irq_enable()
> > results in a call of the handler immediately (but very likely before the
> > device actually asserted the interrupt).
> >
> > I think (but please correct me) that the latter behaviour has to be
> > expected and the former is even broken as it might miss irq events.
>=20
> The default lazy disabling of interrupts has two reasons:
>=20
>     1) Avoid the potentially expensive mask/unmask operations for the
>        common case where no interrupt comes in between mask() and
>        unmask()
>=20
>     2) Addressing the problem of edge interrupt controllers, which
>        disable the edge detection logic when masked, which in turn
>        causes interrupts to be lost.

Ack, so far I understood.

> IRQ_DISABLE_UNLAZY solves a different problem. See commit e9849777d0e2
> ("genirq: Add flag to force mask in disable_irq[_nosync]()") See the
> full discussion at:
>=20
>   https://lore.kernel.org/all/alpine.DEB.2.11.1510092348370.6097@nanos/T/=
#m08531ad84aa9a53c26f91fd55be60fad6b5607b9

I found that thread already before. I didn't understand the
motivation/problem fixed there though as the thread start is missing on
lore. I guess the problem was "taking each interrupt twice" as mentioned
in the commit log, but I don't grokk that either. What means "taken"?
The controller's irq routine called; or the driver's handler? Or
something in hardware? I don't see something being done twice.

If I understand correctly, IRQ_DISABLE_UNLAZY is only an optimisation,
but isn't supposed to affect correctness.

> > My conclusions from this are:
>=20
> >  - the rpi GPIO controller should be fixed not to honor
> >    IRQ_DISABLE_UNLAZY.
>=20
> I don't think that there is something to fix which is specific to the
> RPI GPIO controller. IRQ_DISABLE_UNLAZY is clearly defined and of course
> it will cause the problem #2 for edge type interrupts on such chips.

So a driver making use of IRQ_DISABLE_UNLAZY must know itself if the
irq is provided by such a problematic controller? IMHO that sounds
wrong and the controller (or the irq subsystem) should stick to the lazy
disable approach in that case even though the driver requested to
disable it because not doing the optimisation is better than possibly
missing interrupts.

> Ignoring IRQ_DISABLE_UNLAZY might be the right thing to do for this
> AD7*** use case, but is it universially correct?

If the device driver is agnostic to which irq controller is used (which
it should be) it must be prepared to handle an irq that triggered while
it was masked. So with my understanding (which might be a relevant
restriction) ignoring IRQ_DISABLE_UNLAZY is correct. However that
doesn't mean that drivers (as for example the current ad7124) would
break by such a change as it currently depends on that #2 brokeness.

> It's probably correct to do so for edge type interrupts. For level type,
> not so much.

I'm missing a few details here to follow. E.g. is a level irq supposed
to become pending when the irq line gets only shortly active while the
irq is masked or while irqs are disabled globally?

> >  - the ad7124 driver needs some additional logic to check the actual
> >    line state in the irq handler to differentiate between "real" irqs
> >    and spurious ones triggered by SPI transfers[1];

Do you agree that this is necessary? I created a patch for that and
Jonathan had some doubts this is a valid approach.

> > [1] it can only check the level, not a passed edge, but that seems to
> >     work in practise
>=20
> Right, because once the pin is in /RDY mode again it stays low until the
> next update happens.
>=20
> But this requires that the chip is connected to a GPIO based interrupt
> line. Non GPIO based interrupt controllers are not providing a line
> state readback.

Ack. If there is no way to read back the line state and it's unknown if
the irq controller suffers from problem #2, the only way to still
benefit from the irq is to not use IRQ_DISABLE_UNLAZY and only act on
each 2nd irq; or ignore irqs based on timing. That doesn't sound very
robust though, so maybe the driver has to fall back on polling the
status register and not use irqs at all in that case.

It's even unknown to me if all GPIO controller support reading the line
if they operate in irq mode.

Best regards
Uwe

--zzadathp6w3a4jkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcz0c0ACgkQj4D7WH0S
/k6Etwf+JjXJfwzKL1s3k2hU0JXZegXfISlaJJMNqmU1apQ/dXLO8YorhkG+siuX
miWuqKxhGtPV+XrEmuD1HCpNLog/ZXxfASmwOQCVpvVvthIrPUI90wMGbILZcGDp
zG1PqS8MG2TbZLgAMCVFdSP9YWw11fiXBJeuzIOH6NhFANHbp/K67aCbjLX5IHgR
vwq0iDJuc0twER7cgnS0COJCu/wen9yq/U4y/qiyuUpjRmzUyABzpTaSxFpDDlb9
UABoRSTzQbgA6raGZrQD8Q4YIQiUXwo4zLhYAj7Jp48KL+H9txD/3eLfWIOSD+Ml
R3mlSZ3QFu2yfgYhY/1gaHXf9ed2jQ==
=TVUd
-----END PGP SIGNATURE-----

--zzadathp6w3a4jkv--

