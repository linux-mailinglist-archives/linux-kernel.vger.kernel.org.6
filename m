Return-Path: <linux-kernel+bounces-400432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFD59C0D75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C92E1C2202C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3D72161E6;
	Thu,  7 Nov 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WrylWrsn"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F024212194
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002752; cv=none; b=F2mL7u2FRd/FQRe2KMB+HmBR3ncOwXAfnSW5AkeGVCj9Be9ub2zRFZ/ydBJi3lt6bNWbojVghNrVss4DYFiPnoXgl89hwAwQ0FC9kXtYX4/kYYKZg5qVhkGLju8dXMT0JZfjp9HE7ayBw6C1IylJgFhOzD8hyXyu1LygGi/NN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002752; c=relaxed/simple;
	bh=KUxyXwz3ijMwI9yruBeARGSaKdWcNDBaCOKWP0VGGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOvaQsVfZjBhau9/OsiOlAcGhbyy+4y6/mM4KPteMdgCQJEw6Ik0l9Vp7NF0YYf7EPst9WMgyiBsL1ojXJSyhP1RB3a8ytQZfS4kLBf5vUucozGdxy9XWtn5eBGdF56RCbq1XaDPoMjuX+sEbBd6KJAqbnPk2VS8e/ev/AklvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WrylWrsn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a68480164so184560966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 10:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731002748; x=1731607548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSbrYYBrI/p/5x0d2n3UNYuWW/+v5ncY+edUOAUibFk=;
        b=WrylWrsn+dmnKPImq81fa+6sZpwIF5WozWtdbebYEyjW8lBhqZSrovghVy0jKE44IY
         OZPyFwz6+wfGa6tPmfRdRyiujvOUh5lU+JSHGxf3FBAkIb3UKbw4w4co8KxldlngJtuP
         JsJuMOxFDQKSshcxzTzERdisOcrUUkmhhSwQw/f/YM9nj6Hh/c7aKUFAFFkixz6Im6YE
         3x/pwwoypVA22RzxQgx7tXgtqSLuVBnruWVnUB7ahY5EkCpfuLPQJDhSnEE2iyMFd8Xl
         MVT5iwepusXCviU9k0Ggr8GCVEu+xyUOBn0zjxU+kgEWFy7++YrO0VNV0i3om5QPNTTz
         EDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731002748; x=1731607548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSbrYYBrI/p/5x0d2n3UNYuWW/+v5ncY+edUOAUibFk=;
        b=IegdtvJNr56563EUENeVpcObJkI+8sAMD+CDvpfaL/UOfF8PewIRYPy51HxahY/lx5
         eltH6E+vJPqnq0XZqBao/1IDG2aj6+ldr9JRTV2jQtrUsZNav/5+hZjq+FyEp0JaClmg
         vd+Y/+fCCTJH8S80Yf4+3s3OzqqFyciYieTlo7N6WDQ5ECIaeeNpksT7vBaceJTWbPuZ
         3w6XfOXW2Fgcu+hj0Xtu1kyRiaAO8UtShxGGgSvTnmEqwM9t6rtBro4sTiiNHknqc3J4
         MNkvxWe6RLvmna0kMy4MuUAmEQZvlQjYAbhpVToQcqueuR3Yx75dwAEOr/bzA9YYQEOU
         i5xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTx8X063scokVE4ioM+mBd5Pvsl10mhN9OXgIQLfxpylt/Rtz767VfLALxiKoLeipCowriA8RyYcsr4lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyeollYFOHS5G41Y6i2MAwBt04AsxyO718zUolPzMzTQJZ52Ey
	t29qh6eyDvRvGbCDMOCYQTDH3PGNrADxQrMh64t/34OWMEeeYvUi8Aqbt27D/B4=
X-Google-Smtp-Source: AGHT+IH/KWT01CAzD8ky5ouYbcYfN5C3FED8l6ogIpQP/5B/enmGcQM4WkUVsaO/f92hCV5EgwfPEA==
X-Received: by 2002:a17:907:3f02:b0:a9a:e0b8:5b7c with SMTP id a640c23a62f3a-a9de5c91d25mr4463270266b.7.1731002748381;
        Thu, 07 Nov 2024 10:05:48 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0abf305sm126140866b.86.2024.11.07.10.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:05:47 -0800 (PST)
Date: Thu, 7 Nov 2024 19:05:46 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Luca Boccassi <bluca@debian.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, kvm@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: cgroup2 freezer and kvm_vm_worker_thread()
Message-ID: <nlcen6mwyduof423wzfyf3gmvt77uqywzikby2gionpu4mz6za@635i633henks>
References: <ZyAnSAw34jwWicJl@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2flxw46ilch26h54"
Content-Disposition: inline
In-Reply-To: <ZyAnSAw34jwWicJl@slm.duckdns.org>


--2flxw46ilch26h54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 02:07:36PM GMT, Tejun Heo <tj@kernel.org> wrote:
> There are two paths that we can take:
>=20
> 1. Make kvm_vm_worker_thread() call into signal delivery path.
>    io_wq_worker() is in a similar boat and handles signal delivery and can
>    be frozen and trapped like regular threads.
>=20
> 2. Keep the count of threads which can't be frozen per cgroup so that cgr=
oup
>    freezer can ignore these threads.
>=20
> #1 is better in that the cgroup will actually be frozen when reported
> frozen. However, the rather ambiguous criterion we've been using for cgro=
up
> freezer is whether the cgroup can be safely snapshotted whil frozen and as
> long as the workers not being frozen doesn't break that, we can go for #2
> too.
>=20
> What do you guys think?

I'd first ask why the kvm_vm_worker_thread needs to be in the KVM task's
cgroup (and copy its priority at creation time but no later adjustments)?

If it can remain inside root cgroup (like any other good kthread) its
job may be even chunked into periodic/deferred workqueue pieces with no
kthread per KVM at all.

If there are resource control/charging concerns, I was thinking about
the approach of cloning from the KVM task and never returning to
userspace, which I see you already discussed with PF_USER_WORKER (based
on #1). All context would be regularly inherited and no migration would
be needed.

(I remember issues with the kvm_vm_worker_thread surviving lifespan of
KVM task and preventing removal of the cgroup. Not sure if that was only
a race or there's real need for doing some cleanups on an exited task.)

As for #2, I'm not sure there's a good criterion for what to ignore.
Here it could possibly be PF_KTHREAD or PF_NOFREEZE (I get the latter
has purpose for system-wide (or v1) freezer). Generally, we can't tell
what's the effect of thread's liveliness so it seems better to
conservatively treat the cgroup as unfrozen.


HTH,
Michal

--2flxw46ilch26h54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZy0BdwAKCRAt3Wney77B
SYLIAQCuNDE3wTgZN3p9SAWDtSNXhwYcoK26f77RKTJcTmBEUwD8Cs/j4rnKyut3
wTfnUQ9EoseHo9YzGHkO2Hhuq3vjTgY=
=An9+
-----END PGP SIGNATURE-----

--2flxw46ilch26h54--

