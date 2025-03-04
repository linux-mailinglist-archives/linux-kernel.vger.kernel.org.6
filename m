Return-Path: <linux-kernel+bounces-545136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DAAA4E959
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB457A2449
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C650294EFA;
	Tue,  4 Mar 2025 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VMKvqcil"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC727FE89
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108264; cv=none; b=uPNwKcHVgqJKjjO/EZiWZ78NkA5AQ7Uq7ZLaROZPYNvjTV7tAPgwKTmrymiPrzoBuQ5RAvaMIT1TXkpePaM4ZowjbED6D5FQuKPyNhCFhJk1oxnrycPcy/Sp9IxuDMvT8EFVOoDCvNx7MEzqjf22JyRxP6Yky8LEMNvS0B22n4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108264; c=relaxed/simple;
	bh=BNIsmV/M1wFMJoJxKUmeED+xm/DpApiloOyzGvi1rhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAw3PmKBDldcGQqZsXM0hA3HVfLTohS9mslt7+0OnSgzuRTW+vFDMWX4HLSw7W+Ovqih33v3HHGdTKx1Y37p+K6OBYOYZCMfXiZd7Kc64fqYDOWvHO6HxbTk9PWaS4a+W1XT1fNamxh5ldyOCmj0HXbqtbGZCD5bIZ5sTuYpB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VMKvqcil; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso40490475e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741108259; x=1741713059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNIsmV/M1wFMJoJxKUmeED+xm/DpApiloOyzGvi1rhA=;
        b=VMKvqcilJiWN/SLu2HWRC79C4z1jJNs3KpF+X74a/+lxGVA5ClH8dTWLmHTdgzM/74
         ohjOn25aXY8DdqXo+gWgbKaFLeTlzR1r0xO6O9NUWca0LoqWMZP9fX8GBzrP3PDjjmOT
         MtMAM7pXYRgOpUcjoEBOnL1cfOLqFLcITMD8t2eBaYrm5AhbGSpw49facyYz1yacS+85
         Ekb/EuU7t0BS61ob2OHx6dIA5lFV02kE9684RU+5u0CxMHHXIoOJ99vuLN9jnpH0xa5/
         NQnbaA6LQTPbFzb+s1I4iFbk98THCg94xPnEGJ2FhmRns4sWCPmUU6B1dsjxYUW+foMq
         RZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108259; x=1741713059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNIsmV/M1wFMJoJxKUmeED+xm/DpApiloOyzGvi1rhA=;
        b=wJycrtjnku9oN8fTajubYjtBwtmJc9hSWeZtjHOWpAXEDUKQ+Nk8Zk+9a2Yh3zKaaV
         bRZoHRX8KX4ln8JtHqtT5C1av/FAnZ033wmg4L3q+8EPAwIait9woheZQKeSy73e/iFH
         a5nWa0mjrC4ISHTWHw6wAhmD/oDg/deaduZQ+dPYedIUqKz8BvUGmB+JO7syIWzV1Wr6
         MG1R/iPkv7YT2D6KN5O6X9rqz2wkQtWLhkVow91uiPXMPhHSm5VhvrjX8SCbsdwBKaFh
         u2nCJT1y9V+4JF8N8AscFK0lDnyoMJ+Zm29NbfgE1wEGvP0TohpBRKzwxOcCuvfmhPnO
         tvXw==
X-Forwarded-Encrypted: i=1; AJvYcCV3KleQX7sybmVNl+gBhTPvr8abwN8On9wvtt0QoRf201yTcK1kwPg00hrbHrnVnn2XN+lFPm9luAS+mxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUET3et6P0cjHGePh+c+fzNpY+U5GBFc4V2shqaq3rp37Of+q
	Ej/NthgeHrqzuN446sGfA6OOt436NsX0BdttsbqJNsx2ZUMyVwe/KqjyubcBC6N7sqghjag1yzb
	CGOQ=
X-Gm-Gg: ASbGncvMxgsMmBMXWSldfun9FnthhMG/8lP+V3Gk7kNDVNXlj3xS5+9CneAwhH2EIJQ
	6sIVxabE0CK1y9/gV9rOmXqA/QRNw5dRTNw8/4XlKAdwVuhm2xg6trCYbq2KKYp5cOnUZEsO8+e
	n00e7G1x2xPeFzlvwP8Rap6xk6gJgwloxagjfH/3bYvgEHnl7f9N69U/JhkUX6bIiU7xjnLci+w
	kYIPU5LxxuvhXVvzGSWUS4VMhSol0icJDLxf02P6qqqPydGNrr3Ep9c6Got4UC5W5iXFqylZKd3
	W9Aj0dgqwXZgB/OOKWNfOrEy0uOEuTaiOTOtaw==
X-Google-Smtp-Source: AGHT+IHwyTmNw7GkziQGU/grcke+J8YWNXy2qyeoEeNcQkNtnZMfPor87Z8qPAtdVAi/1sBgMwZwBQ==
X-Received: by 2002:a05:600c:4693:b0:439:8523:36cc with SMTP id 5b1f17b1804b1-43ba66e66d7mr174859195e9.11.1741108259007;
        Tue, 04 Mar 2025 09:10:59 -0800 (PST)
Received: from blackbook2 ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcc8cb8c9sm25012195e9.35.2025.03.04.09.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:10:58 -0800 (PST)
Date: Tue, 4 Mar 2025 18:10:56 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
Message-ID: <n2ygi7m53y5y4dx5tjxhqgzqtgs5sisdi27sk7x2xjngpxenod@7behfsvlzhxi>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-2-mkoutny@suse.com>
 <8b8f0f99-6d42-4c6f-9c43-d0224bdedf9e@redhat.com>
 <Z8cv2akQ_RY4uKQa@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m7t5ylg5sh4ub3qc"
Content-Disposition: inline
In-Reply-To: <Z8cv2akQ_RY4uKQa@slm.duckdns.org>


--m7t5ylg5sh4ub3qc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 06:52:41AM -1000, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Mar 04, 2025 at 11:19:00AM -0500, Waiman Long wrote:
> ...
> > I do have some concern with the use of pr_warn*() because some users may
> > attempt to use the panic_on_warn command line option.
>=20
> Yeah, let's print these as info.

The intention is _not_ to cause panic by any of this this.
Note the difference between WARN() and pr_warn() (only the former
panics).
Warn level has precedent in mm/memcontrol-v1.c already.

Michal

--m7t5ylg5sh4ub3qc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8c0HgAKCRAt3Wney77B
SbexAQDwJlCeZoumG/jlue6Kzy4cUn1Ow4uQgOGmkE/7VYcugQEA0MuK4dJSSgbL
rcAd7YdHp7o0baFNH7DpxWvcmSi0Zgo=
=VnWp
-----END PGP SIGNATURE-----

--m7t5ylg5sh4ub3qc--

