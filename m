Return-Path: <linux-kernel+bounces-214619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D9B90872A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22751F2410D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26A1922C2;
	Fri, 14 Jun 2024 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vRzcoLMC"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA21487E9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356559; cv=none; b=A0TsiHPBhvR/4DOfUBB67LrHhC1nF96JZRUkKVtphUUKXzr6ZBfxwNR6OlcEadQPohMJV+A/UAK5vLNSagCmzwwfGI0sFGDFB5nxeWtRJVNzaeLqmcudbTvR576aOKdV0p7j43FqWTsFl7n/qhXyYn4wV9jH66gORDZIZ9GFBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356559; c=relaxed/simple;
	bh=Kvo8XmnLOV0RyW7GwDo2jYs+NZHWYKq5zZtobiKNCdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=An5mTGx+5E0VwcO2zd12HS5XNKfvJGusQnxV1k6V7T4vHvRWxuC4JbIqCVupCaEk8TW/KRTI/KMiDO59s724/A50kMa0u06EKhO+GgKoiv+NcwqkAmmxrbBZVnV6HVlNHIiy6FmJfbrjk2mjDA16Ni6Ny1yO4J0PyyFEwV4nqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vRzcoLMC; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so4945231fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718356554; x=1718961354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jycOXWjXEWtQJiVy/XcReEB5uLL67Qz1KSKptRrEWuE=;
        b=vRzcoLMCoGml3Ztu9sZPeJ+0O469KJddjc4ZUTUYe7LO/VgTqc4/6XlFHh3HKvo6d4
         +oHm1NlPu5fs/rShVADdJUSgToFdn2m3h3a2UtDwro/O+ms1E1gxfhnu86t/MBq8WeV1
         mngMzm48RduP1DCcYSfpxoJJ4jepUNZaKK5tsLV0MbcjG3SHl2STOtjujSFelXkNou1q
         8J4LBhnvyeNtqa2B5ITdmu0PakoMnMHjxseuErk4Bjgg0JDqBLC74LsMktp7OHnXVTrH
         2HpRDQFBL7NUlfJM0o1MtsQYGkeKM9P1azr/u+AFZ1JC4O4JDmX4yroawYsY89CkIZ6H
         E5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718356554; x=1718961354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jycOXWjXEWtQJiVy/XcReEB5uLL67Qz1KSKptRrEWuE=;
        b=foQo1ybyas5OvzZXrRRXSXLxxI70sV7ZG+DkBvQnwWtm2TgZEqYNlhqnsjwWfe66Ln
         ac6A1JNQOEEQsKz2vPzL8X7eyU6pHNHEsyKAAwQsN5K9Vn1NYLZqooTRfG7sMb3kTRXL
         t5UMn2zD88vs/ZgFmfeo/B5uIwIGAf0ddXt+kJLRERQMMqsnwoRf/vfli6tmQKR2vBag
         rcVQS1wpfXUgJKXnCdzq2KbGIEI78uKQw8hCjlEWyAP5V68FfAN75Q9dn1RtA2cEbHf7
         nfQC0FYoS64jGtKbhpFBmTm4iB6lwEw1O1+nHF3GJFyzjbMuycl7XZl3+GUzTJ91sZ+u
         ZcjA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9myNlqW6ZV7Rr7TWGFk9B1U3MTRbmuQPB6EHOlbh/pYrd6H12sWoOw+O++pstFn0QIkc1MRQvKexTDUfwOZBFXL9+zsTAHrapaIy
X-Gm-Message-State: AOJu0Yz9WJYYCgrIHRlM32/VQoljAqg8cr+TZVI0APd67BVRLAsEn7NR
	nNmq0ba/B3xMRfktmL+kPAslHkxs0lep1Sx0InRMafSMlr7H3aJhJsB10esFmqw=
X-Google-Smtp-Source: AGHT+IHQFJSw7GrgrgJ8TysvKcfNQQGA7NNQ8WIbCyRm/XZoe4L8ME22a7fk6vZRMopg7lTBLxcVoQ==
X-Received: by 2002:a05:6512:3f27:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-52ca6e92a3cmr2004158e87.52.1718356554543;
        Fri, 14 Jun 2024 02:15:54 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f431besm162296466b.187.2024.06.14.02.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:15:54 -0700 (PDT)
Date: Fri, 14 Jun 2024 11:15:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Xiubo Li <xiubli@redhat.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] driver core: Don't allow passing a -ENOMEM to
 dev_err_probe()
Message-ID: <7xnzx6dlim2r5oujon3csocrljcvtvwz46yvmik62hpn4a2rlj@tiqrzlol7l5u>
References: <cover.1718311756.git.u.kleine-koenig@baylibre.com>
 <85a3d444f2943ebe9d64e722b1717a5f7d06ed48.1718311756.git.u.kleine-koenig@baylibre.com>
 <CAMuHMdUHi0Yu2Giccp7pHqpjLWG2CjkGFWehLV0iWBHB_V4oGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7y5r7ee3ph6dfrbr"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUHi0Yu2Giccp7pHqpjLWG2CjkGFWehLV0iWBHB_V4oGw@mail.gmail.com>


--7y5r7ee3ph6dfrbr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Geert,

On Fri, Jun 14, 2024 at 09:26:52AM +0200, Geert Uytterhoeven wrote:
> On Thu, Jun 13, 2024 at 11:24=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@=
kernel.org> wrote:
> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> >
> > If a function returns the error code -ENOMEM, there should be no error
> > output, because a failing allocation is already quite talkative and
> > adding another indication only makes it harder to determine the actual
> > problem.
> >
> > So the construct:
> >
> >         ret =3D some_function(...);
> >         if (ret)
> >                 return dev_err_probe(dev, ret, ...);
> >
> > is questionable if some_function() can only succeed or return -ENODEV.
> >
> > Catch some of these failures during compile time.
> >
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>=20
> Thanks for your patch!
>=20
> > I have some concerns about this patch, I only implemented it because in
> > reply to the first submission of patch #1 Andy wrote that he thinks this
> > should be done, too. So the idea of this patch is only to keep the
> > discussion about handling a constant -ENOMEM to dev_err_probe() away
> > from patch 1, in the hope to make application of patch 1 more likely :-)
> >
> > So, I think this patch 2/2 is a bad idea, because:
> >
> >  - Let's assume there are functions, that return either success or
> >    -ENOMEM. (I'm not aware of such a function, but I didn't search for
> >    one and probably something like that exists.) Probably the compiler
> >    won't be able to know that, and so doesn't catch that "problem".
>=20
> You can find several in public header files:
>=20
>     git grep -W "return\s*-ENOMEM\>" -- include/
>=20
> I expect there are more in static code all over the place.
>=20
> >  - Using dev_err_probe() to handle the return code of some_function() is
> >    convenient. First to make error handling in the calling function
> >    uniform, and second, to not create a patch opportunity for all
> >    callers when some_function() might return another error code in the
> >    future. So dev_err_probe() can just be used without caring for the
> >    details of the handled error.
>=20
> IMHO this is the only drawback.
> And things may change: a static (inline) function that can only return
> zero or -ENOMEM now, can return other error codes tomorrow.
> Also, some dummies (e.g. dma_mapping_error()) return -ENOMEM, so it
> depends on kernel configuration too.

Huh, I didn't spot the dependency on kernel configuration. That makes it
quite bad.

> >  - In the presence of patch #1, there is no real problem with calling
> >    dev_err_probe(dev, -ENOMEM, ...), because this is an error path and
> >    so not performance critical, and no error message is emitted.
>=20
> There's still the issue of increased kernel size, mainly due to the
> presence of the error message string.
>=20
> > Given these, the more complicated implementation for dev_err_probe()
> > isn't really justified IMHO.
>=20
> My initial reaction was quite positive, until I discovered the dummies...
>=20
> > --- a/include/linux/dev_printk.h
> > +++ b/include/linux/dev_printk.h
> > @@ -275,6 +275,12 @@ do {                                              =
                         \
> >         WARN_ONCE(condition, "%s %s: " format, \
> >                         dev_driver_string(dev), dev_name(dev), ## arg)
> >
> > -__printf(3, 4) int dev_err_probe(const struct device *dev, int err, co=
nst char *fmt, ...);
> > +__printf(3, 4) int __dev_err_probe(const struct device *dev, int err, =
const char *fmt, ...);
> > +#define dev_err_probe(dev, err, ...)                                  =
         \
> > +       ({                                                             =
         \
> > +               int __err =3D (err);                                   =
           \
> > +               BUILD_BUG_ON(__builtin_constant_p(__err) && __err =3D=
=3D -ENOMEM);  \
> > +               __dev_err_probe((dev), __err, __VA_ARGS__);            =
         \
> > +        })
> >
> >  #endif /* _DEVICE_PRINTK_H_ */
>=20
> Looks like dev_err_probe() does not have a dummy for the !CONFIG_PRINTK
> case yet, while it could definitely use one.

Would you want to drop

	device_set_deferred_probe_reason(dev, &vaf);

=66rom dev_err_probe() for !CONFIG_PRINTK, too? If not, you can throw away
the string only if __builtin_constant_p(__err !=3D -EPROBE_DEFER) && __err
!=3D -EPROBE_DEFER. I agree such an improvement would be nice, but that's
orthogonal to this series.

Best regards
Uwe

--7y5r7ee3ph6dfrbr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZsCkUACgkQj4D7WH0S
/k7Qbgf9EV+28gU+jqlvkMzclGlUr7rW6QNrb9JQGrRrKvb31TFgjBN93XjNA1AO
gZP1hX4ObkhdmE8r6PYNsEtNyqpzIijNJu0LT3rFMUpXZLuGWxXLbfCJpGgdv9BN
BwSEk5Fxw1iZyHk8Wmv2Jv9vFb78n8Gv48DyjY3Rue4V0xtkJrqXjEq1CeRO9ErJ
0AB8AyPpYcRXmZQRccS97m8P6MWTZDz3SURYv8bvyRC2mOYRPTIZUKKIzKpglWnC
mgnXLdaq67Yw/HnnLsWoUSihzdez0ENhL21ZTMN4DiSjSbl8gM+Jt3rrZhMzG9Fi
5Sw1sgmMb5Gb4hx1BohzdtICvhBWEw==
=ZWF0
-----END PGP SIGNATURE-----

--7y5r7ee3ph6dfrbr--

