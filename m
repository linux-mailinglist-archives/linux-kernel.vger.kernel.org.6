Return-Path: <linux-kernel+bounces-382528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79B39B0F65
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D0328427A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756FC20F3E8;
	Fri, 25 Oct 2024 19:47:35 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA71B07D4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885655; cv=none; b=Gcojiq31DCway9P2Cgz4uAvYbb8uZNxKx5nlWJ6Lf8cAF04/HmY1tcR7VytdWdqrP0gHqr+MqTzSVt68yUtb73bMjxV/TTbqQceuOf019ORHB7YMw+dfYkX9X6Bt4qnOQJK6r5rLTN6uc8mjiwj5Xlx2RaUJg9UmuB6OCoVO08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885655; c=relaxed/simple;
	bh=yBvKjUZe85UWTBA6Lv36DBUy8qRwK2m1mnnJKAdP0tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaoFEomLGEoN7wh+yqLtrSI7/WcfDOZ1lF1eXrWrDDbbhdnblZvY8nE1lWGctnmuF1wcUdXraAl2HnFPI4HaV2wFOwJraAVK+1nUnsAuHP/da+5w+KOnXuK/HncozxfAHie7RE8CcRK5MST/yV/8jJC4ZZTUxnGFpTFKIzlhX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b154f71885so186894885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729885651; x=1730490451;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDG/hWPo7mQqsv9GUv/JdDj09IKahS3ZTNtOSwRCtwY=;
        b=eOceLpyGfap6qQoCrDhDwLe5OsP+/ONNUFQdIR1KYX+S7/PjsKGs0wBDBkLWYJNQuc
         CcSdUmMKOcahPsaoJx33DNlOFataqgvLJcAkuW8bYW1CJASLyi/TApuVmt+jKRgfj1i4
         /AT3dCyv9v5mN4J3xy3qhmMMfkawXZyo+KDRtyLfiIp9sx4BoJDBUIQq4sTjjrpvgYTt
         cmCdak9kRBUxzXekwIBJQ4HT4Dtc7YqT0lRgDjjf9jD2hwRgiIEyTiBQWYOEXa3XKG0h
         f9VTZYb1vVqRdnnG9AtyNh4ZQbsiNjUs0toqjhlVC9g2oJktrgorLdDxYB3HqJtETfNf
         z1PQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4BTC7YUBTOmnxrPXmC1WCyXOcSiQJqCOE0WoIgTadFiLQe8hhp4wEgfQhS7/4VXr6vyrSLRfvgPiv6NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszkeVzM14vaZWp1P7pqngJI6/Xkloz7CJeNV7WuOZaggH+RsO
	9gOS8iuGj7lglUoA5nfBsO4S3aQfl+UZDws40hG26cSmMP8pS6SKqQDfwWrm
X-Google-Smtp-Source: AGHT+IG66Ny1j0tAPIkiqfrYKTOSaQCMRhT4ZEWWmWTdWAvrfrEf//AWOhQPDSzl9STerEiK3wDLlA==
X-Received: by 2002:a05:6214:4411:b0:6cd:ec5d:169d with SMTP id 6a1803df08f44-6d185886572mr5799496d6.53.1729885651483;
        Fri, 25 Oct 2024 12:47:31 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798bd8bdsm8612126d6.54.2024.10.25.12.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 12:47:30 -0700 (PDT)
Date: Fri, 25 Oct 2024 14:47:28 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] scx: Fix raciness in scx_ops_bypass()
Message-ID: <20241025194728.GA2648@maniforge>
References: <20241025054014.66631-1-void@manifault.com>
 <20241025054014.66631-2-void@manifault.com>
 <Zxvz3mlxRm-BxuJW@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XZdQU9dgCYOW/hPu"
Content-Disposition: inline
In-Reply-To: <Zxvz3mlxRm-BxuJW@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--XZdQU9dgCYOW/hPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 09:39:10AM -1000, Tejun Heo wrote:
> On Fri, Oct 25, 2024 at 12:40:14AM -0500, David Vernet wrote:
> > scx_ops_bypass() can currently race on the ops enable / disable path as
> > follows:
> >=20
> > 1. scx_ops_bypass(true) called on enable path, bypass depth is set to 1
> > 2. An op on the init path exits, which schedules scx_ops_disable_workfn=
()
> > 3. scx_ops_bypass(false) is called on the disable path, and bypass depth
> >    is decremented to 0
> > 4. kthread is scheduled to execute scx_ops_disable_workfn()
> > 5. scx_ops_bypass(true) called, bypass depth set to 1
> > 6. scx_ops_bypass() races when iterating over CPUs
> >=20
> > Fixing this is difficult because we can't take any locks when enabling
> > bypass due to us not being able to trust the BPF scheduler. This is
>=20
> We can't use mutexes but can definitely use raw_spinlocks.

Right, fair enough, just need to use a lock where the holder can't be
preempted.

>=20
> > problematic, because what we really need to do is coordinate between
> > possible concurrent calls of scx_ops_bypass(true) and
> > scx_ops_bypass(false), but the whole point of that code is that we can't
> > use any locks to coordinate. Instead of taking a lock, however, we can
> > instead just serialize the calls to enable and disable bypass by execut=
ing
> > the calls on the scx_ops_helper kthread that's currently responsible for
> > disabling a BPF scheduler.
> >=20
> > This patch therefore adds a new schedule_scx_bypass_delta() function wh=
ich
> > schedules changes to scx_ops_bypass() to occur on the scx_ops_helper
> > kthread (where necessary).
>=20
> Can't we just add a static raw_spinlock to protect scx_ops_bypass() body =
and
> maybe turn scx_ops_bypass_depth into a regular int while at it?

Yeah that's of course a lot simpler, will send a v2.

--XZdQU9dgCYOW/hPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZxv10AAKCRBZ5LhpZcTz
ZFTyAP9rMEMvvgjB9gYStD6fMepPZrml3V2uDG2XcXKGvZnPvgD/bNSqTOPzqaZM
I3JCgbh63ob0G1x3Pe0EWLClgMONsQ0=
=+uBF
-----END PGP SIGNATURE-----

--XZdQU9dgCYOW/hPu--

