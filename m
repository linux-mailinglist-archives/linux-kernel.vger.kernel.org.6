Return-Path: <linux-kernel+bounces-402620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB419C29BC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B0FB21E73
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B684313AA4C;
	Sat,  9 Nov 2024 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdKZ6QSA"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039228F3;
	Sat,  9 Nov 2024 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731123218; cv=none; b=jQnKQmMJBzTaUyXrzMWSixDaV4P4z6+KLjawRASKFRSK/F34ygnSm0W/qqQiIWIUkwzu6jMORv0aSmzW9yEjtP55IiJ8EONNFx1z1ly9/ZpaEXoBcwJr9eub1xO4q9R4qR1JzmrTY3mxvUJARtr8L4a9EC03U3ya4I45FId+0zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731123218; c=relaxed/simple;
	bh=wA0wE4w/aUT1d8yvxyUM3d2Qbj4VPucQ8flcD+zM7rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrIWKT73scfxWrpjIog+4Ry+yA/9l2vM5lpv8tJEgK98jSlXFGwpOsIOdTNglZcV3VrGGWW/YSEa3GdHJ0noTTHAuIjzVlzFL1RHxlgc87mvS/9Rl2Jxf/7JBy4M/GzalDVHx1pgixVx7K0V+0R2y17nWME2+P36p/rDFuTh21g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdKZ6QSA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7240fa50694so1856032b3a.1;
        Fri, 08 Nov 2024 19:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731123216; x=1731728016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wA0wE4w/aUT1d8yvxyUM3d2Qbj4VPucQ8flcD+zM7rw=;
        b=hdKZ6QSAt/zp20cbGR0dysXXJhNVGvYqk3whJMTdR9pmz5jzyr12/GeJg4yXc/dY1C
         fkEsRLhradZYS8kb8SlOyTWdWa81RZoZBdV/FkN8gnhHI7vE9PIpAw8kP5r7E3jQLMj6
         3vOEvzoJHhPKMKVS+CJxswY1YGsuXjr5nJt6C607PT8WkmHk3UP0xEcQcGt3LEGxa5Qz
         Pn0Qei/pfF5v34rq5gq1IfeBWR97hpY7n1BACY/sKWCjZO+kIxN1omxeTFhYAypUEkBN
         Jp9H3eqV8uNJ0c0UsNoMHjxxIq+dgDzOgd4FD21gX7mlukcuLS9Mt3Y57gq83ZFXGCIO
         C3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731123216; x=1731728016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA0wE4w/aUT1d8yvxyUM3d2Qbj4VPucQ8flcD+zM7rw=;
        b=Vp9PdmPRT5tS/uFZ32gppqclCNem074q53BppklOGLIMJdfEY3mJflLo5ABm3nIyt8
         RYIMf8iRFQwE+sl1dqUoSCdbTUWk+M2Ke5xDb+mVJevz8Q+OBZj1Rrku0G3CPE47znqv
         N5Skeq15AId0XLwv0JZzOXgz1zpWDjg3dYOINuYhwTWTRHnCg817wjsHYteNCKKbtvA3
         jYadqvZ31SbIn389ToJQQA2tk7hh5aFRIUQ5H/2UEBAml9ZtTNxveykP7FrcUt8IuVpv
         i+0g9Jh3gUAvX5FOipzncroFZdPyy7X75oei4fqyZgfOz2jmhWoytcD6hNzCJFaFX3V4
         JOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoJKdET//edzcc6GBdl3iAC1CdhtETkmeXgfp+v6tF6d8hXCUODNxEXRFGENumF6UY5jVVyMAQFt0=@vger.kernel.org, AJvYcCXnBtXBv0UfBU7WC0m2NclcOLUIM5/BqSYdfG87OtpKwtllIwkU95plgrFibXs4iwpGMozr8a2M5nEM1Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmADEvBsupP+XfdnlcqiOg3YzwbvVLvoyjL1WpYQrN+CBxXf1
	mUP9VKpNgWcErRjdaE3ay4p0t8aeVJ0KFPH+OFwVGq3IEQyeKZLe
X-Google-Smtp-Source: AGHT+IEldiCHWfdNjIMTcttEq0+8o84WzwIJ2y+isakuL77iVVb26ijiJ8TLH/JIqe9bzxhEKWKCag==
X-Received: by 2002:a05:6a00:a1d:b0:71e:693c:107c with SMTP id d2e1a72fcca58-724132c15a3mr6967818b3a.11.1731123215798;
        Fri, 08 Nov 2024 19:33:35 -0800 (PST)
Received: from archie.me ([103.124.138.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa8e2sm4619164b3a.92.2024.11.08.19.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 19:33:34 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 00F8441F52F8; Sat, 09 Nov 2024 10:33:32 +0700 (WIB)
Date: Sat, 9 Nov 2024 10:33:32 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: anish kumar <yesanishhere@gmail.com>, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH V2] ALSA: machine: update documentation
Message-ID: <Zy7YDKamcrkSg197@archie.me>
References: <20241108192413.10751-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rdFZBe1zu0bozSAW"
Content-Disposition: inline
In-Reply-To: <20241108192413.10751-1-yesanishhere@gmail.com>


--rdFZBe1zu0bozSAW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 11:24:13AM -0800, anish kumar wrote:
> +Clocking Controls
> +=E2=80=94----------------

I see in my htmldocs build output that above section heading is still
normal paragraph instead...

--=20
An old man doll... just what I always wanted! - Clara

--rdFZBe1zu0bozSAW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZy7YDAAKCRD2uYlJVVFO
o9L8AP4oMOqpEQuxMwhhSkemYhjgwBXZKCn51kZZr1du30kLIwEA2EMxVG3BsEdI
VguTsZluAlJ4CYxzU5VUtFpvpgrnDwk=
=D8fX
-----END PGP SIGNATURE-----

--rdFZBe1zu0bozSAW--

