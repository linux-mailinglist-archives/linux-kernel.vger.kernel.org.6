Return-Path: <linux-kernel+bounces-348618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D499198E9BA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAD82877D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 06:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33ED77111;
	Thu,  3 Oct 2024 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NMB2nFEB"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C78B67A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727936899; cv=none; b=DrxRDAr9oIa7H2cWzAfyrf2kA7lZgKRqKHGfHzlfuPp2+nN4fDICzIgKzCoubAlakbvtL40WAAEO0Ll9H3m2xj+gZypu9I+fXHv2QJPBousd/4LxUABhI+Bt8ir7LKK2MssozjhMk3vSVWRloYgdjMoidV4yQqKNksCk/iDMqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727936899; c=relaxed/simple;
	bh=hauqjraMjXiCWoMaZeyAnHUzz7UH0gA0+SSty5AqSZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxpJOYAmAWzBLT/1lfCwO/TEFxAEdtgnF3gM4ocyLq7jyB7u1Xc8pCgj0mmAoV0b93PTU045peHWGEB/1zvigdytFjz3/IQkjIiKx8KnpWwF3XzZy6CitEhnJF9TsPohlJFlKzLcSsuheiydU6U3WAn/1Kk3qZPLA80oW8jbhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NMB2nFEB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a90188ae58eso65747766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 23:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727936895; x=1728541695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7dIdfGhFcR0QP4oFeLfKB/XZgoA5JHUPlHax+TvOs8Y=;
        b=NMB2nFEBwxQG2BGKG30bcRQ829qSWKRmwuHlTvUhEXLC30qqiavTWPGoZ+zpMRDbfI
         U004UEglJmZ1pKc0uYfSocfJ0YulhUMPFxufCnaOIru+g9022SolvRqzQiHikJB8Hv4s
         MFZ+AJbojBQdROKkNvDr0EdbLILI4nEGlfbl1hNW1OWpcjGVYj2RWzCauUbfF4FTEWOu
         jX5nKpwHRgjOuWTKC5eW1o1x6rjfirRvmPFCcuq0IdApASSMmVeJPVZQQLVdWsRL3TC0
         c9gyqh77WheY+XF90GZiDcEeeBYiAzdbWvIfUs8pyydZkObahbI+u6yBQSySBvm02Rpz
         2G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727936895; x=1728541695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dIdfGhFcR0QP4oFeLfKB/XZgoA5JHUPlHax+TvOs8Y=;
        b=KnP7RzA2UgLpPvYQn4KeBMHWBe6A9DKieLw0gIN8SshkO8QtjQras66KmRA+2oqoIE
         tbZwHAZREqAMXyEM9BNBoma5XpmoDMXincasipNbQcg99RNLxnYgri6NVEzVqu95fn/k
         ZYxUnT2IEil6czfxdCzRbeT1GkEuBL1IR24RWYi3ob5JXKGcdQ58yP1E+XPhS+JLlgDU
         mE3/qnWWVBiqvDH/Oik12R8L+AI3CGmQn9Ol4xs4jgrmuodomvII8OfZY68sFOuYWXqo
         hLNcsawMhqkIsewBWhn3bpwA6QjYzsYPXtm/lCAwIlxSQJhbPn/cIaDi2VBfW6mruvUH
         SnzA==
X-Forwarded-Encrypted: i=1; AJvYcCXon6Bwn2xEYBZ5vyuKn/jhlk2KtbgMKTNcz50Sz+5bA/dY8jGTR3YYxw0Knq0q7lXmXfFDIuhKfQQV21Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx42r57sxrDbv5oxRbVlurRCHGFos54kL5qFh1UXzlw+DBkaCpI
	x2orp9IBY2Y2/pmHSsnr8xBX34ibnlusn1+mm0pCpZ9VqZBW8cwm4I7cHKRIdbk=
X-Google-Smtp-Source: AGHT+IFNw6Rc579jYq7nxjpfKByRO7LAMh0yEMBKjKkwSwfORvDMx+sQRLvVuMELHAOjfCooWwqUPA==
X-Received: by 2002:a17:907:7b9f:b0:a86:aee7:9736 with SMTP id a640c23a62f3a-a98f834d28emr499620866b.46.1727936895223;
        Wed, 02 Oct 2024 23:28:15 -0700 (PDT)
Received: from localhost ([2001:4091:a245:8155:c84f:5b4a:8d3f:75b2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99103b376csm37429766b.104.2024.10.02.23.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 23:28:14 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:28:12 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Vishal Mahaveer <vishalm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: QoS: Export dev_pm_qos_read_value
Message-ID: <tqsrnsvciupbovlalqsnrp5whst2mrpqntjblvymcunpesvake@o3gxa7vik7he>
References: <20241002194446.269775-1-msp@baylibre.com>
 <2024100333-maternity-equity-c7fa@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ukbbecnozvuhxgvt"
Content-Disposition: inline
In-Reply-To: <2024100333-maternity-equity-c7fa@gregkh>


--ukbbecnozvuhxgvt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 08:02:04AM GMT, Greg Kroah-Hartman wrote:
> On Wed, Oct 02, 2024 at 09:44:46PM +0200, Markus Schneider-Pargmann wrote:
> > Export the function dev_pm_qos_read_value(). Most other functions
> > mentioned in Documentation/power/pm_qos_interface.rst are already
> > exported, so export this one as well.
> >=20
> > This function will be used to read the resume latency in a driver that
> > can also be compiled as a module.
>=20
> We don't add exports for no in-kernel users, sorry.  Send this as part
> of a series that requires it.

Sorry if this was unclear, it is for an in-kernel driver (ti_sci.c) that
can be built as a module. When built as a module it can't use this
function if it is not exported.

>=20
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> > Tested-by: Kevin Hilman <khilman@baylibre.com>
> > ---
> >=20
> > Notes:
> >     Changes in v2:
> >      - Rephrase the commit message
> >      - Move the patch out of the series
> >        'firmware: ti_sci: Introduce system suspend support'
>=20
> Odd, why did you do that?

It was suggested to me off-list that it may be better or easier to send
this separately.

Best
Markus

--ukbbecnozvuhxgvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZv45dgAKCRAkjLTi1BWu
P/evAQDJHvKOghbUZuRPqirGhzohsnWhQ3v2DDfMNC5RpJ8HmgEAhFi4Rci9fLen
X6x6tB7Rw/pQCmJOEED9N9t5ljlKnAo=
=feh9
-----END PGP SIGNATURE-----

--ukbbecnozvuhxgvt--

