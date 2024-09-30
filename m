Return-Path: <linux-kernel+bounces-344618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2E498ABE5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC8F1C22DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9768B19992D;
	Mon, 30 Sep 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ic9mEMus"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C7199395
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720242; cv=none; b=ubGlUYbAwuk7MeC9gzkvyBt29wjL8bF4C2+RH2BjXMlFq0SewQMGx0+VrXkuYU16ET+a0ZhpFFG6qqIf6KIbu6r1Tw577QI6yNaHe6gJbSs1itJQFJktoC5D2l/l+fHWe5GcftztpfMZu4nT63XX4WZNZhSPTz+mlioMcI2wrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720242; c=relaxed/simple;
	bh=nfQd0bLiaUlxjdjv1luu0OR+X+NeK49g/G6jTC7Y+9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzlYDVk3GBXBMR6xz0hDmZp9ny5IGPusc5sHIyMzwjyOOYYtadaJHbOBFq7ZtFldxXwLXl19gfE66x70htfFgScvfgZLUt9m4OgsUC1ImlATs2hZGLYs2xM7iMaSoztRTOusBOcLZMLUDJwKZ+Bqt3FAT5cwGYqvs3W3INjirPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ic9mEMus; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d4093722bso709128566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727720238; x=1728325038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nfQd0bLiaUlxjdjv1luu0OR+X+NeK49g/G6jTC7Y+9U=;
        b=Ic9mEMusv/oR0BROuAxQNgOOXge+ez6qBfv3LOYtxseiJbnWzcyeBEC/65rQ2+91Es
         OdbjvP+MqEauzefTH7WlERW7aNkZzWwLxAizRUJUlMhBWmNxYmiseFeVQZzOaTBbMm0c
         XGz5+c9+AreuRW+PIGODFPRXsIekVSzeAXxtbiAEvGD00qgQFqvmKM/X7fBL/a4NeDNl
         3vcsQEGy6QVqoEea2z34nZ+jPV2EpsQ4JeZy2KBgIJva5RkjsCpf4qHfdGzvAt0YQylp
         O7AhN8TsIKpVrXK2YSiKYuhw//Yhx4UcHAm2iTuv0acCUFed/Yha9wXsLvbYORSyru4t
         ocew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720238; x=1728325038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfQd0bLiaUlxjdjv1luu0OR+X+NeK49g/G6jTC7Y+9U=;
        b=rPzCHGWWuFrnRgGgYGrXXYMOwA3McrTHPIjlyBuiTD2AiZ5KAIjpPzP35t0owftB18
         vwEhMd4NENu15Rt1ZERCzebJunSHuFC6JtToo2XvpAZk1CVEqBNTlHIfp8RCxOZZU97A
         XRznk1dqlRiSBep55idLRRpzGqZApa9N3pYmsXfgGR5ThHRvoddWsWZ67bA+EsY7AMfp
         3coSGWn62D6ln1adyNjRt63Ssz0tLv9ZR0AzZpkSmlEWtYPfl3TtXYQbaYOc6PHslgD2
         44IhRNw9wd7Vvyw+TQonMBpqKaECiNI07U83uSAMGcAWgTW+r5i5I28N8LQFUIesH7No
         N4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWnn+IylL03zBh57oh5iOjSoOFu8QsebZ/71TcPbBfK4w7X8gqejV7UL9edlUDbsUtcIsQARtuEArnMqXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz30GzG0o8U1jiwWToE68p0Ra6QpWyziVKgJMPF0p19aO9AsVRw
	eLVMdAfmrkCgm3fiMHeV9p5Wfi9hlEhEwh1xKEm/iXa6qacucfYlwGTrRbE6+vY=
X-Google-Smtp-Source: AGHT+IFvgTv7zaXuZdsCtp9p/WZr8AMN5GrVwogvGfgdskOA13RRiAT8sCZf9Wue4mXfFxpjJXhbMA==
X-Received: by 2002:a17:906:c10a:b0:a90:c411:24f8 with SMTP id a640c23a62f3a-a93c48e7ff6mr1368451466b.2.1727720238070;
        Mon, 30 Sep 2024 11:17:18 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27776efsm566448666b.30.2024.09.30.11.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:17:17 -0700 (PDT)
Date: Mon, 30 Sep 2024 20:17:16 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jesse Zhang <Jesse.Zhang@amd.com>, Tim Huang <Tim.Huang@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: CVE-2024-46805: drm/amdgpu: fix the waring dereferencing hive
Message-ID: <fwxfulgwpt3f6hijwg6vh4ujrfq2lj3wvp4kq4sm2hbptmp6f7@7nybfmvb7ihr>
References: <2024092709-CVE-2024-46805-b06a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mxilw45w4otwzocs"
Content-Disposition: inline
In-Reply-To: <2024092709-CVE-2024-46805-b06a@gregkh>


--mxilw45w4otwzocs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, Sep 27, 2024 at 02:36:10PM GMT, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:
> In the Linux kernel, the following vulnerability has been resolved:
>=20
> drm/amdgpu: fix the waring dereferencing hive
>=20
> Check the amdgpu_hive_info *hive that maybe is NULL.

This "fix" introduces (or transforms) a CVE for panic_on_warn=3D1 users
(if the NULL is reachable by unprivileged users).

The NULL ptr dereference thus needs a better fix (I checked in
v6.12-rc1).

Michal

--mxilw45w4otwzocs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvrrKQAKCRAt3Wney77B
SV+wAQD7OvDV97MZDWFQTjSlW/KvQ2uH83Te007khmwkxNz3+wD9Gqra+XEybFmf
jKyMbGo0HLcq1Aomwy8HTsisWPVAego=
=sMBm
-----END PGP SIGNATURE-----

--mxilw45w4otwzocs--

