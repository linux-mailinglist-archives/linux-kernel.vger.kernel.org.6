Return-Path: <linux-kernel+bounces-544391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B9FA4E0D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BB43AB17C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A8205E16;
	Tue,  4 Mar 2025 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E8AudygG"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA9205ABF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098065; cv=none; b=q4p8BcI+KQsU2eU0UcQ4NX2Rq0YDtsIa72N6U1R18CCgeIsBOhtSObCqniBlnBJlM63HC8S/5x6WJlIM0n+j9+ItiOH7DYYcLk5P2TPekDOSDQVsNmPROHVrpudIfmRRN7RfJ9JLOYsBb22yg1jOJZDM61/Jc1PQEp9fm56hpKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098065; c=relaxed/simple;
	bh=+A2SxfolgsDIP4h/EI1LbULSBtNo2qFsWGcuHThszaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEsQe3cr3tGRekBQYJofCfo0JAXBdm9Vr6UN0VsZwaXwmqbJ6tbH7UA1PZyH+F6Vpd/EgqGyWh+lRxEp+cDwYpPfAOVz8ME8NYJVBWoeRPPzH7r8YLk7OVKCCV1/3Z6v9iZLzuf5CdhGJZ9RCdeuiBfncghvfdwIEXuH+B+jhns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E8AudygG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390e6ac844fso5007190f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741098060; x=1741702860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ms6VvRKF2/scJw/4d4p+LMJvPrNkvNdjmSsh3E28KZE=;
        b=E8AudygGA6kl/SnAigYZxaY2awxM+/KB3t4h3QnKZ0ci5XMo5GNsRk51+Y3IoCw4h9
         Sjl2P149LjWMzsbBdmSHxRsCD3wgxDxjBlpQvaIXaJM6/Mj0HYC+/Dz5QQbCJ6P4ftnz
         VxIf14P8cOp1tQ96Wmm5re7UbMqR76TDO+BhsCFOFjnXuLBkzd5pgW2nJnCXxwmT7f5D
         5uQQtpLyyYrRefnQt42hvBZqSRPpauRsUCxGF08syADa0TGI8leWM6ugDl5Vh0zHnfjD
         TS8kXlWEO6iL4eHkeHcONGd7D2AcLiDDC4h//X+y32K3IdxHLVAWumI3Vnf+Y5sApFp+
         CQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098060; x=1741702860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms6VvRKF2/scJw/4d4p+LMJvPrNkvNdjmSsh3E28KZE=;
        b=vW6Mmidh/hUfl55q8rcWLixY6ughMg576QC0Ohj0YCojkDhYuwIgelUoekBjA5VBNG
         AP/RUZThL5fDRrQqD8CN8SqhDCjsMPQ7/m0FF5w8PmWKHVnMtJX7i7YBt1daVUJHN7cE
         4XtZ73J/Szt/cPvuPCnbUN5UmjXxmeJgRx7K1xl/zcO5Ox5yQKGn4HGrOoYcvewbNKXZ
         nmWkvQnToT5Ejr+RvwwaX3C8E3o1m12LO5wuuVBef/EEq0paHTqXpZrO6OFrBIu/NZmf
         mZBItg/GmogDuBfyeWf1CWt8lvbhPYSOqVaMcmf5QK7+7eeBhtSU8DL3UVjyfEs1J5B0
         xOMg==
X-Forwarded-Encrypted: i=1; AJvYcCV7sNuJiRqw7cm6X5tDuSHqz6KfUvM80C9a8I7o6wvmCJufAoq7cHzPFmpqK4HgqQzny4YrwdsoKJamJ3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQdtmwC15MVV2Kb6rvdbxLFVvHfIHyY63hFfNlPpGawXJk5u6o
	ivjMDMU9KjJM8/qe5WpKToQJBqFrnxq9XNymhD8gwh9OwdaO13e11IFiF11PoFk=
X-Gm-Gg: ASbGncvSAX4rrd9nIHJC74YtIkeKBDLSCJ7UTUszbKhGGw15ha8YFF5LtwO1yuOmXOW
	98YQ3cWUkp5w4XWyM2bJUrUxIK1krFlBlvoRefapdZznIowUKvaNEPcxbU7lQk+YLmxYOBrWE0S
	SIj4wQ5a347pCLjONv/nQGO1ciqj9vF3DeK9uQ6Q+5DbMVmPt5t9XarwdV3zkK1f2Ds20uKjst9
	N99EB3fGMIi6+AcoXgGOxVQQlutlPCP1hl+53UICSmgTm6OEz3eN64RvrdZi7qsp7TXOjmcsZnL
	dAQzsyOyV+pjhyjWcF3DWfYdCfnB+IQX+jmRWPPNjHHQvaM=
X-Google-Smtp-Source: AGHT+IGxVfqxe0VMsjPEv2lBj+Xq4zB28tu8D9cFC/yICb/A0zbJo5FOmgG0O+CLVTr2S/kHcSjcLw==
X-Received: by 2002:a05:6000:188c:b0:38d:e15e:17e1 with SMTP id ffacd0b85a97d-390ec7c6743mr14760832f8f.10.1741098060456;
        Tue, 04 Mar 2025 06:21:00 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc1a7429csm75810925e9.36.2025.03.04.06.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:21:00 -0800 (PST)
Date: Tue, 4 Mar 2025 15:20:58 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: selftests: cgroup: Failures =?utf-8?B?4oCTIFRpbWVvdXQ=?=
 =?utf-8?Q?s?= & OOM Issues Analysis
Message-ID: <exfgzrx7u3s77gsoxqzm4zhb6mr7aysc2vzus5ob3zeadkm7ut@3dzkywk3jfqr>
References: <CA+G9fYsrfM62=kr=q1nu_Nx9-sTHQw-6A-3OWkiqgs4JiKzvgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcfzwvt6k4h7ttan"
Content-Disposition: inline
In-Reply-To: <CA+G9fYsrfM62=kr=q1nu_Nx9-sTHQw-6A-3OWkiqgs4JiKzvgA@mail.gmail.com>


--pcfzwvt6k4h7ttan
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: selftests: cgroup: Failures =?utf-8?B?4oCTIFRpbWVvdXQ=?=
 =?utf-8?Q?s?= & OOM Issues Analysis
MIME-Version: 1.0

Hello Naresh.

On Tue, Mar 04, 2025 at 05:26:45PM +0530, Naresh Kamboju <naresh.kamboju@li=
naro.org> wrote:
> As part of LKFT=E2=80=99s re-validation of known issues, we have observed=
 that
> the selftests: cgroup suite is consistently failing across almost all
> LKFT-supported devices due to:
>  - Test timeouts (45 seconds limit reached)
>  - OOM-killer invocation

Thanks for reporting the issues with the tests.

> ## Key Questions for Discussion:
>  - Would it be beneficial to increase the test timeout to ~180 seconds
>    to allow sufficient execution time?

That depends.

test_cpu has some lenghtier checks and they can in sum surpass 45s,
it'd might be better to shorten them (withing precision margin) instead
of prolonging the limit.

test_kmem -- it shouldn't take so long, if anything I'd suspect
/proc/kpagecgroup -- are your systems larger than 100GiB of memory
(that's my rough estimate for this reads to take above the limit)?

(Are there any other timeouts?)

OOM -- some tests are supposed to trigger memcg OOM.

>  - Should we enhance logging to explicitly print failure reasons when a
>    test fails?

These tests are useful when run by developers them_selves_. In such a
case it's handy to obtain more info running them understrace (since
they're so simple).

>  - Are there any missing dependencies that could be causing these failure=
s?
>      Note: The required selftests/cgroup/config options were included in
>      LKFT's build and test plans.

The deps are rather minimal, only some coreutils (cgroup selftests
should be covered by e.g. this list [1]).



>=20
> ## Devices Affected:
> The following DUTs consistently experience these failures:
>   -  dragonboard-410c (arm64)
>   -  dragonboard-845c (arm64)
>   -  e850-96 (arm64)
>   -  juno-r2 (arm64)
>   -  qemu-arm64 (arm64)
>   -  qemu-armv7
>   -  qemu-x86_64
>   -  rk3399-rock-pi-4b (arm64)
>   -  x15 (arm)
>   -  x86_64
>=20
> Regression Analysis:
>  - New regression? No (these failures have been observed for months/years=
).

Actually, I noticed test_memcontrol failure yesterday (with ~mainline
kernel) but I remember they used to work also rather recently. I haven't
got time to look into that but at least that one may be a regression (in
code or test).

>  - Reproducibility? Yes, the failures occur consistently.

+/- as that may depend no nr_cpus or totalram.

>  - Test suite affected? selftests: cgroup (timeouts and OOM-related failu=
res).


Michal

--pcfzwvt6k4h7ttan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8cMRwAKCRAt3Wney77B
SRJxAP9P0BNVxEJoSyAW/NxnhKcTEwUAjxmtBvpDFXXGLv3UfwEA7O8iCYplvX71
vK94Co38SIprgRkg1DKFarv2l4U5OQg=
=OykF
-----END PGP SIGNATURE-----

--pcfzwvt6k4h7ttan--

