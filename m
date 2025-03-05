Return-Path: <linux-kernel+bounces-547217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5988DA50459
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A591885A31
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9DC15C13A;
	Wed,  5 Mar 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="elU4xBBE"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CA6433AB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191360; cv=none; b=lnqxuW6zI0LKRiYRW2Ek3shmmzn8rF7NF1+X33FjWnG+y5oigKXufvD6fxfJAwzQaHFy0BLawzx6fq5p2ph5NYrBwscuwYrmGAbrXsD5TKkHUHjOtD3aqgHapj2z1aC9HTTUNFiNJ8UO3botmmJY7VHddyIz0dUli4i1vGeFna4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191360; c=relaxed/simple;
	bh=fv4YhRvlWbb2xsBRPo+vB8HbRXMqdTqTfwRar1qvmx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO485fZc6bK+uvaXRlIUacnoelZWDb2BEKAKgUfAyPCGW8zx/wv6f8lCFU9j+MJFbtdZmXA7IQCGpXBcGNTlBXsAFPZ2Rax7/hNo+TNnEMREMZ3Dq+g1/qgBEkf2SG7sPDYsEm5eBqbclyHm4Aru4JXHxR5w2bNtLp+y2lfc0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=elU4xBBE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390dd362848so5390004f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 08:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741191356; x=1741796156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNAB44QyhnX4KFdgTgmL60qRg10qylEcS57fI8BPRcw=;
        b=elU4xBBEmJhkTMqQ484vLEvFMK7m+hheKUitkLhNtXdoiIP5glSwKQPE2kOQvSDCQr
         jD7KUAHnWsxjV4UyQU/5ITcXa7/Jpans53w4omNE4c1Bs1UaOFY/9sE/bcezQUQs+FhY
         nuR8iQLKnKicUmIbLQ+ZiBxfrSFnlrwX292pSoIeKnutTy0eFNzwaDc/tpXz7Eb080fF
         RKni5sr6M//lpq+HXifkHZUvEzL7gNMii7VCX7F02s1QlqpYr3ULkTArOpGtcHMqObF0
         PKqhuQkH6XyXlYKBbw+11iBaxETGI4bvki887+ebJR+FeMnPLx96hdROq+lOV27y2Uhz
         WSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741191356; x=1741796156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNAB44QyhnX4KFdgTgmL60qRg10qylEcS57fI8BPRcw=;
        b=WFiFJQKAMB733BoQeIy23Tu58QcxpXROoVPaZZ2Xhg8DskXJEhKx8Jjd27CfpRiIjh
         XPqGsIIhu1AQD0s1u4AqMJXjJDUOt1xrk8qM8mgv+WzQegnnUbpYWQbUbT0LFAoLFezb
         lp5SlxsYzcezHrjP0Q2SPp8mbnq8HAphK23y2/6LFngDrwrUuryS3zd8cQ3drIhnp9Gd
         4v+O89MM5sRjnz+EOD3FXFjc1cms1/xMZ2FLZdNSSMKPuulTwtvqTc6525BAbBt1scZp
         GyjG5XoNl9bYweCuNjGPVdcLfjkIxeXqQ+QgzpN5/sR9lZ+EAYHOXu6Co1q713Ie06WA
         6H7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWytqZKz1GMDlelWjdNRXHkAGS1P9jtxKBSlsfdN4BGhb8zd/2wmbILHcta+HigeYUbDeK5ByyUeh/gVgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIU+WjMR+dFhcQBEecZkyZ4lzNqgGzrR41VD7oxop/zZllCr+r
	9l+1y6lOVY+tqgyNWBuKxl+PAtzwWwoFRNFdqH+LsnRHGRJ7M+AIC3ut2VKeTJk=
X-Gm-Gg: ASbGncsB0+hd1Qxn+TkR/vxXdFJKw2h3fNY9G1AATy1ZkPH+Efs0HCEx6JCZL6iWV6o
	MJSSVsroA6JtRH8L43O6k3IdIJFENjo7HODv1VE4/iM2qJ6WQOIegcLcHxUc6+PBh1jyLkrTI0u
	nA3+5zohDhn/iOXZr/I5X372QpGGk+6GtRgCjM95ui6f6UiRledAdOkSDertSH0+GMZ0cbmqctu
	9hHNIqxfNFMcBHVQhnsV4pfCKyVGu5WjRZFY2qZ8qB9q9vOviJRCtr+fkyj3/cMqwzHOd0O5a+c
	Nyxk5J8PaWKd7e8uMYjfrEAPtw06F+7l1mJFXHbJeDxZhlk=
X-Google-Smtp-Source: AGHT+IFSFHy1G7JXs9LS6Zp9vf6qrgDOnTuLsUnVpuP6RU8IBq/z8lBT5ioxtv8qoOlGoLHFx2uA7A==
X-Received: by 2002:a05:6000:4185:b0:391:5f:fa4e with SMTP id ffacd0b85a97d-3911f7476b5mr2262201f8f.29.1741191356432;
        Wed, 05 Mar 2025 08:15:56 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7ddesm21704636f8f.57.2025.03.05.08.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:15:56 -0800 (PST)
Date: Wed, 5 Mar 2025 17:15:54 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: shashank.mahadasyam@sony.com
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH 1/2] cgroup, docs: Be explicit about independence of
 RT_GROUP_SCHED and non-cpu controllers
Message-ID: <h7xbvvv3727yobsl7vx3vvcpqhdulagmogbuulp3dny4jgggym@gb3yaeuiuwa2>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-1-7b6a6f5ff43d@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mohu66pwpewgjwac"
Content-Disposition: inline
In-Reply-To: <20250305-rt-and-cpu-controller-doc-v1-1-7b6a6f5ff43d@sony.com>


--mohu66pwpewgjwac
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] cgroup, docs: Be explicit about independence of
 RT_GROUP_SCHED and non-cpu controllers
MIME-Version: 1.0

On Wed, Mar 05, 2025 at 01:12:43PM +0900, Shashank Balaji via B4 Relay <dev=
null+shashank.mahadasyam.sony.com@kernel.org> wrote:
> From: Shashank Balaji <shashank.mahadasyam@sony.com>
>=20
> The cgroup v2 cpu controller has a limitation that if
> CONFIG_RT_GROUP_SCHED is enabled, the cpu controller can be enabled only
> if all the realtime processes are in the root cgroup. The other
> controllers have no such restriction. They can be used for the resource
> control of realtime processes irrespective of whether
> CONFIG_RT_GROUP_SCHED is enabled or not.
>=20
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--mohu66pwpewgjwac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8h4twAKCRAt3Wney77B
Sa/MAQCsVpx3ngjUqnES7cUlQY3BJhxMyIKDkx8/OleeglUqqAEAxOHtAu3BJJAS
Ccs3+43hdTpTkLZ4OmOk8HTZf1FlMgA=
=478H
-----END PGP SIGNATURE-----

--mohu66pwpewgjwac--

