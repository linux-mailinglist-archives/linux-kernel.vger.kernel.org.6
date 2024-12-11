Return-Path: <linux-kernel+bounces-441397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFBF9ECDC3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630F918842BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EBA23691B;
	Wed, 11 Dec 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YRjCGjH0"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595D2368EA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925390; cv=none; b=arzymCfQ7iSHgoEatkqp2rEPsCm1ohHAE7f5Tl/POs10ej7qd20VYdrhTJVTBKYhHFAuxhzfnXPRMG86RoK1J+75AoVnTBMCweFHCerYPXkdqQXjviyKzNxrQ2TkIFbvMMvxdvCfsq1g0axB+K/CDhVETC4rBtpCSMXfhqnUBi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925390; c=relaxed/simple;
	bh=cOZOBUKJFU3Lf4npohtP1sWNz5qJuMjZHm3Mj9pQHuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZTCcFlQLMdlbZXQXCLvVnXDvpCKKXU4DdYuwny8eu6ufecLT97bpTbpFxdWR2t3ghiBTda7KPgQTmB3sIjYLK4EOeXc8Q1XMdrx9zxOcKaWQeQDNNgHZYrSU5PjZhUVrvUfO3nimlBXBA+XAyASHeM4jtInc1qCsJCWWd3yFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YRjCGjH0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862f32a33eso2289979f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733925386; x=1734530186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqFZPLxg9uXUUbFYl64NJ+hd5kjKxlZzEdF/XByvoc8=;
        b=YRjCGjH0FDXNesp4KlYc/6BPk1QPyKv5y2laOSxyOuAvg4FRNFcgY6VYDMhgK/gBeX
         +pmlMtf7Ak97q0MfYwGDCeBPxqxkmSoJF9FTSDl1mJnYkFtv3iLgQ6OgUz0nKTQh3Rm+
         DmLzrjaHCs91GYwdzD5SqzRT05ACJjStG9SUxQV2D1Kq5IOZ7RBA3rOf0kPhdBCSyrpk
         sHBj8w9FkydJ6zoGUm0SvdHimvJ7MQwuEfJSQiitjxYRiqEanWMFOQDCiOqYWh/ooUer
         T2G5+LdJuPOT8xODEbLxFfrNxnYEsglxAt9gv2WRIsybTYwNDJky28v8iPla7pWD06mE
         wtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925386; x=1734530186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqFZPLxg9uXUUbFYl64NJ+hd5kjKxlZzEdF/XByvoc8=;
        b=P+koa8+M0OaAZC8X2mksUZws1DhVirmGocX2tT5KqMDd1SWTYjrMAxKS7ErSaeLeXA
         ds/QHkvnDXDedzpnw/yqOKZsbj+zpral4elGli2hIGltuTJCKPmAX6ATE15sxKqu7ZFn
         5oYsosWukmGubU00F4FE80e2fsuqfKg/8R0AWvrnOnGOlz9EsDeMqNubZUNStPsfw26o
         FMHO8teb50X1OS2yz7NOSxy4Qd5ZDMgpdkKklqVQGyTcL7lQwSfw6CRr3EXQLmzrR0JU
         9DmHjdPRZ2bCLzROi3sLsl1CKCZ/AIXQ4oL8fpp2nHZSgaRgW/2wIYyfqVZaMoc+p/Cw
         Znvw==
X-Forwarded-Encrypted: i=1; AJvYcCVGWtoCJk5Z9WA0W1Dgvt9u6Ukp47NaMHZ5for6C1osZWHD7QDiTTeIWcW969qnGnqHRIxyC9xDeB27xGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOwsGl0kQnZnEmDcHwRv9qLDev4QZOLOvuSdzieu9i8jRmAqH
	Ax63uPiRHdFYQ1O1df3AzE/y3bXRHF+41Pcb14l3CecfqeLjdBzC2xjIE98NFdw=
X-Gm-Gg: ASbGncv6n99OAFSTrVppV97UAZWwNS69zRbYFfW449Xxclu2sIKzeKsDi9NtnS6xhK3
	XIpctt7xU+E4iCv+g8L9yxxA+Bnln0VCD9C0xnjiYIJ621RWXgAe3pMqfsDpJzDgF4w+2/5wLdA
	S4tCI1ifp/PlpV+owwp1ULZbXqeT8yEoNcnWvcKLXM5t5slHrRMg6JOAMYZWclfMt7F2jc/PV8d
	iGskrjEkawVCU+Ae1XALjLh6KKNChfLMCul5H7kWMbx7irK9670ZBWR
X-Google-Smtp-Source: AGHT+IGN/tlBgq07nEHIVsqXdpp57QSK2WTSNBZ8RFtj64TIKDFnIwFbJhJRViM0/qs5EItfPlBiCw==
X-Received: by 2002:a05:6000:4609:b0:386:3327:bf85 with SMTP id ffacd0b85a97d-3864ced1fa5mr2757678f8f.53.1733925385737;
        Wed, 11 Dec 2024 05:56:25 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f810sm1342192f8f.22.2024.12.11.05.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:56:25 -0800 (PST)
Date: Wed, 11 Dec 2024 14:56:22 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, hannes@cmpxchg.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
Message-ID: <wvqotmnk2kad3lyigbsc5vtq4ymdtaxqcjijaj2f5mdcp6m742@ltmazfge3eu4>
References: <20241211131729.43996-1-laoar.shao@gmail.com>
 <20241211131729.43996-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2oebmfrqcf4dfbrm"
Content-Disposition: inline
In-Reply-To: <20241211131729.43996-4-laoar.shao@gmail.com>


--2oebmfrqcf4dfbrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 09:17:28PM GMT, Yafang Shao <laoar.shao@gmail.com> =
wrote:
> @@ -1286,7 +1286,7 @@ struct psi_trigger *psi_trigger_create(struct psi_g=
roup *group, char *buf,
>  	bool privileged;
>  	u32 window_us;
> =20
> -	if (static_branch_likely(&psi_disabled))
> +	if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
>  		return ERR_PTR(-EOPNOTSUPP);

Beware this jumps out for _any_ PSI metric when only irq is disabled.
I meant to add a guard to psi_show() (this is psi_trigger_create()).

Michal

--2oebmfrqcf4dfbrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ1mZ/AAKCRAt3Wney77B
SR4pAQDZtCgrhq8IrES7YK3U84zIRXuk9NSntgVE5ogCjw0juwD9ECxBZNCypCnG
VlpO2CR82SghljzRb9NsiPYRqe+KSAQ=
=/a7w
-----END PGP SIGNATURE-----

--2oebmfrqcf4dfbrm--

