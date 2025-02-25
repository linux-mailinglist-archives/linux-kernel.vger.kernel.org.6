Return-Path: <linux-kernel+bounces-531457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D300CA440BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5263A9108
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F0226980F;
	Tue, 25 Feb 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azOl+RGa"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57134199931;
	Tue, 25 Feb 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489827; cv=none; b=JlH0GrJdJ5XfYN4k/V3IpdB3mJ4TwNmNDw0t6a6TnrYxYXpY2HE1HlLq4J5R1UJ5/YsqKqizzU3r77n8Lj12okc4cjpHqdwsLcwVdfKg7nGphscTM9JerpaP7TqVbuENqvmDxccoTSpMkDGTFi/Mt/1ebhhdFem/Ei3OJQ/N4so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489827; c=relaxed/simple;
	bh=eYQLyPcfZ+OwSEdHs4rtzsqq/imMglzI8Xe60lKHac4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dob++n6NO7HP3EY3YpyGSVBkT1zFncOvi3rzVk8Z37hFsLc7C7z2OUGyXIfh0bCIhEXmtNcS125vpDDGrrlsBaOITQ/C+OB/Ub4A4BoR1vku5zfxYkD+t0SFR4dFFwUFshrR/PpNba7KmLYObMOZ32l2AA+eBHYzf7AsNnibFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azOl+RGa; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86718541914so3568571241.1;
        Tue, 25 Feb 2025 05:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489825; x=1741094625; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckOtxyjtIW2AH2r69vdE9B1FOmdVAD+zQUQJS1G5lBE=;
        b=azOl+RGa1UpKr0IQXnFDx5rc8dE97+UPbxGHQ3nBi3b0IRHc8WWxMB9yjpNRIi21aI
         z3lXALZAv62bD+vmFUHTE72pbrZfRqxrhdA57XLUH/KsYiI7S2Z7olbCubvZCFldvwaS
         SdsLVXr/vcQDrjqVXdj9Rd+q8Bi2jsHh0VWXtGgmvSXcw2OuL5+7Aenl6rwxY6eRyvTE
         Hq3w38hFahIAEdBxdHi00W3YZGcuQl+yKi5s61xWWSdh/UicMmeOUYC9C9xbIlKv7jU/
         YIwI4XlBSHzuVwij5+Uu0BW8nzr+iucpfgkOuHixkEs0RdEC/GTX4WoHWhck7H7T2C2y
         vdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489825; x=1741094625;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ckOtxyjtIW2AH2r69vdE9B1FOmdVAD+zQUQJS1G5lBE=;
        b=tM6hiONyKIZZcfKUmOlG9l6W1RR5cw0P/tmQ3T32WTRIl0rAqB3LKUohik80BbEMO9
         KKoGG86gXV9byPClBzuYouYqIAro43p2DvdFJxlC3nEcvOmrRGA/P/jhJC4XdyOQD+WB
         5vhm4PC+eGqjrpROywi1zBeg4KxLzcc1Xvf8lRJA/0z6UuGaNrT64nY1nfi60Vm5Qgll
         nJSNbrh/yOfowRkf9l8q50fnPswr/yl+ClFPiU71+9gWCkYqbBImdypuFa5tRjlIfZ4r
         f8KAoPoSaM/IYkTmTL1f0xhgnsYTWqu8iOUx7IKhcHGmg5fpmgORRpjqbeACZ++NBcSH
         T80w==
X-Forwarded-Encrypted: i=1; AJvYcCW6L4UQ80dpUiNExaPEcu6OvoffQjjWtdX5TvwAfUvF85GSGV/kT9zfgOrNR6eR8zOQBn7o95bck1qGLGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxye7m72vJANMYixkthGKVy2Qu3i3TOGkQYRT4e8EsCVTZwaCMS
	bYhmZF/HWnq70WYjDHsYx1BzZb/Y5uGBCbiXS5I3SSKbijNnWGUJ
X-Gm-Gg: ASbGnctWwjRlMnnlNDZQcMsWsH9zNO22DVM0oRGgWamEldorhVF5f46nq1xx8nxvmJ0
	6KpZNolMtRyKg152VBoiKT0ZY/PorxIuGbFTGsEyUcJzLtQ/ewtMHQSlAJ4PFeaqze1QIicpNqm
	CD156Qo5SsVqbVdosN+6w/I9BeZ6YInB7up9iA7BkMf38DlpflX2MhjwkFx9dikTt4lcBkU90ti
	xQlGvghYG9I1o1WVBF9KM7mFNMQSLhEdHCB7KBy08TkYknBJhCZIMiJzC5N33kRBa0BXLgqRAOI
	i3YbO0USL2322y//sw==
X-Google-Smtp-Source: AGHT+IGIkyuEYA2zbEotMtn1x7kyHb4VfD7RmJvAePSwAeTPjgAeh3Ae626awicRdjpQYfudjVyJfg==
X-Received: by 2002:a05:6122:3783:b0:520:b76d:f3c9 with SMTP id 71dfb90a1353d-521dcd709b4mr12321983e0c.1.1740489825146;
        Tue, 25 Feb 2025 05:23:45 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b1ed2cfd4sm310606241.3.2025.02.25.05.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Feb 2025 08:23:42 -0500
Message-Id: <D81K5EDVAF9B.1MY63B8DYC7PE@gmail.com>
Subject: Re: [PATCH] driver core: faux: only create the device if probe()
 succeeds
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <linux-kernel@vger.kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <2025022545-unroasted-common-fa0e@gregkh>
In-Reply-To: <2025022545-unroasted-common-fa0e@gregkh>

On Tue Feb 25, 2025 at 1:35 AM -05, Greg Kroah-Hartman wrote:
> It's really hard to know if a faux device properly passes the callback
> to probe() without having to poke around in the faux_device structure
> and then clean up.  Instead of having to have every user of the api do
> this logic, just do it in the faux device core itself.
>
> This makes the use of a custom probe() callback for a faux device much
> simpler overall.
>
> Suggested-by: Kurt Borja <kuurtb@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for considering this!

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

> ---
>  drivers/base/faux.c |   15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> index 531e9d789ee0..407c1d1aad50 100644
> --- a/drivers/base/faux.c
> +++ b/drivers/base/faux.c
> @@ -102,7 +102,9 @@ static void faux_device_release(struct device *dev)
>   *
>   * Note, when this function is called, the functions specified in struct
>   * faux_ops can be called before the function returns, so be prepared fo=
r
> - * everything to be properly initialized before that point in time.
> + * everything to be properly initialized before that point in time.  If =
the
> + * probe callback (if one is present) does NOT succeed, the creation of =
the
> + * device will fail and NULL will be returned.
>   *
>   * Return:
>   * * NULL if an error happened with creating the device
> @@ -147,6 +149,17 @@ struct faux_device *faux_device_create_with_groups(c=
onst char *name,
>  		return NULL;
>  	}
> =20
> +	/*
> +	 * Verify that we did bind the driver to the device (i.e. probe worked)=
,
> +	 * if not, let's fail the creation as trying to guess if probe was
> +	 * successful is almost impossible to determine by the caller.
> +	 */
> +	if (!dev->driver) {
> +		dev_err(dev, "probe did not succeed, tearing down the device\n");
> +		faux_device_destroy(faux_dev);
> +		faux_dev =3D NULL;
> +	}
> +
>  	return faux_dev;
>  }
>  EXPORT_SYMBOL_GPL(faux_device_create_with_groups);
--=20
 ~ Kurt

