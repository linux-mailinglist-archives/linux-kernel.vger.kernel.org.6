Return-Path: <linux-kernel+bounces-429202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 505299E1B36
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE609B39CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4021E0DD3;
	Tue,  3 Dec 2024 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W+NKn6nr"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00D01E0B87
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220105; cv=none; b=V2/ap37IEVS61wS9UhfZDrnnwe8f28JxLOxRRu1fguyVrj/pNb1eY7BA3JDX4hX96/wWpbcW1482Jp4Uv3PuiUnY8l/C2Dom1OCXTgZHgDxBye+YSGK2llN37JjXa6DhMQDyryUgXmxDNtStun1vp0MtCRdwhzZN4/Eax69xFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220105; c=relaxed/simple;
	bh=jmyk4L0m1uD/d3yvbMqa3Zr0W6i+w63Tb+z5ZXdzQKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzZX3eP5mv4rFIo5QJyxu4luGYZOAkYVYjr6DEBT/4XRg+tMY8QJQztE9eOM6W4bS4QQjN3kMOHAqca2wK9fUP+zAut5EcFhEnH4YVpPfpz2Gcd1z/z9qV8qKbN1jKGWZb8Yz7HlHKfa5lhaVFr1iJnBnKhd+VHEgz82YulVWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W+NKn6nr; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385e06af753so2187708f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733220101; x=1733824901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoH0g6mcc/lLOBtNOVK7uWKZqQJ0zcF2m3HC5PqElU4=;
        b=W+NKn6nr4ErxTU63vJZ0WcNB206dyWDK7UhChjvDt3QsMzq0fbFhKzkkrB4zhGbgMg
         PHJiE02C+6xRCG9vtNGYRkIhhECgPLtyY8H4fZzvN7/GWrcMR1qDuiLBW+Pm0pIT/03w
         caCe7gFFFjC42SjRQcBrB+fRJXPDK0WDXkuqCHb2IQjHPcQWQzJQZXxhcbgPJgdarN3E
         IkIXgiK0cfQ7QTrruD+Aq8k6wLRKQ1ck/Se0Eoq/zqAil7+Q8MHbPnghMeY4mpaPEmbR
         cyWYm7dr+Dn0xflFOjdgwleB/3pMsVK0OuEyCEFP8WdiJpGx0tkcyplj/pMLwNgx1fHN
         c8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220101; x=1733824901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoH0g6mcc/lLOBtNOVK7uWKZqQJ0zcF2m3HC5PqElU4=;
        b=qb+9gYXS7kKWquHOGDbpsL8jZ0XauMA/6A4sgN3erBDovJe/FhX67+ylM4pI92D4gA
         wC2srSMoFDVfaudSnOzjq6VCCp5FhtnVsIzT3wWkmOI3FDLXmJQpvh4dk0EsbAU8v86R
         AkR8OtrsoZ5Auz7B/B0XGGvl3nVxg+eoHyUw/UJHUjvuM4FZp3VLzm60TuJs3YpRJegP
         vtVfKlj/nBnOcNssme0aCn3Xa+6IFO/QYe2nGgtkvmlS1D/z7UmefG5GgDZSDNjQjAnI
         eij0tS+P71zYc7y0sckGHFPAR6daQ7pghypXB/qgj5wd9xp8ZXpdtSbns8D80saoFNzD
         GCLg==
X-Forwarded-Encrypted: i=1; AJvYcCWoJBH1lm+nNjC4xaUiZk3fgNyzdMDXez3lBOHjNVfq/PTg9VJR2dSGZatjJxSWjy6E/ewfePGVzBWaia8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrDYsaVJ3eQhqJzP0mEMusoq35teRYFOZfevd1Xy/uSbJm0Jcb
	ar2stos7wDQaAOe9CS8w8BdmRjDNRs+iBkIUYhZ1Qzm8EpBpkwsi3mfWFINNekk=
X-Gm-Gg: ASbGncvCyWv6kcQteh0/6iKcDjxGdZFwXnBQPNtNbjFRNnRQ2JXOR1l2jU/o9AI6jCx
	Gcr1FiM3ckBz0/zUaUezezptJkeD13UnpAjh/vXyXFU759USxrDVsqNbwIXcQRGoicQByO+t9Y1
	oVtdY987uJ4PV+g08KAF+FdYsJNdk2robEIY4exyHlVu0jtXEWSUSKJSjcZdqhfVtcFrECwaGks
	mnmP+W70DX3iAAS+NVK3FmhsyCvhuVbht+n9AlsuuOXpSdadpSc
X-Google-Smtp-Source: AGHT+IFKtsKOx5nwraYeu49MJVp7ip+d12LFtsoXKro4umRgrI++BPEuQZ0k/TOeYwHKW5dnR/TmDw==
X-Received: by 2002:a5d:47a7:0:b0:385:e2d6:8942 with SMTP id ffacd0b85a97d-385fd429c62mr1515845f8f.54.1733220101043;
        Tue, 03 Dec 2024 02:01:41 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e391656csm9736738f8f.47.2024.12.03.02.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:01:40 -0800 (PST)
Date: Tue, 3 Dec 2024 11:01:39 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
Message-ID: <7pad3qmmmy2hgr5yqwwytj3wyjm3d5ebbqy4ix6boxkd34fc7c@ebdjg75tfgiq>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
 <20241108132904.6932-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="juoy3qq5zk2bma6x"
Content-Disposition: inline
In-Reply-To: <20241108132904.6932-4-laoar.shao@gmail.com>


--juoy3qq5zk2bma6x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 09:29:03PM GMT, Yafang Shao <laoar.shao@gmail.com> =
wrote:
> sched_clock_irqtime may be disabled due to the clock source. When disable=
d,
> irq_time_read() won't change over time, so there is nothing to account. We
> can save iterating the whole hierarchy on every tick and context switch.
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--juoy3qq5zk2bma6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ07XAQAKCRAt3Wney77B
Sf0eAP9apEDJBM5MtREkfBDzMCJWEux2oGXMiraWvAokGB47zAEAgHwiwvw5k5rg
UMlIohbr5pdL+q0G4NEdOeSIYAYQ1QQ=
=ISUS
-----END PGP SIGNATURE-----

--juoy3qq5zk2bma6x--

