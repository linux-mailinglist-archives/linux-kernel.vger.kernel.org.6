Return-Path: <linux-kernel+bounces-538610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED44FA49AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102703A2ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EABB33E7;
	Fri, 28 Feb 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Oo07lBHj"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8413F9D5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750374; cv=none; b=bxgdBAfjCESxOmlh0iqTCXKs5Ll0J+vKeAHDlwwCMUq20AJe+2Ri58Q5AHGRjy6Kuh2lTbVUdBgQ4fP6JVGhZgVes+SP34wYww4NtjkyrkK5fg3YZxLHybjKVQuMzBFGps8q3SHJcS188cRrQ26BlvyqtCWWP0kLWWRZLVIsyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750374; c=relaxed/simple;
	bh=AjIMmvZQxa/CQLmrIYduJkQy9l6vTA2LmL1t95Cf+ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9ZxIN7QFW8y2I7zgvte/cfgqJr6Z3bAn+Q51Bs24FqYrhSWnxrSFjmvGdbUoV6Hw6AyZVAdlL+VYXgtE3B2fuf9UbnEjfIWwf0s9HYkhW5oy+I9p1LSAzbVYoq0FnAGPAZEk5aqwn2zKCQZvT6Hokzi1uS/YpET/duyDVAFyBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oo07lBHj; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-abbdc4a0b5aso406432466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740750371; x=1741355171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aV7o1W4VwE0oVZL2kkrDtiQc0Vk0TBhJcOtu6AAVAH4=;
        b=Oo07lBHjss6lPLy0OnyI3hcSUt/FPQFxw/2F9iT0v+8X65yzmrGlwoShlVIM+/q7JE
         7WTbHv1Yvya/FQe0ITfTvJOamqh5F8SRCrvbByUk5sXTicto/0kJpLFYgDRuU0kOrviN
         HAxJRuxf/JQxFtQMa5OcVKL/JjFAqhBnDLAoVISvHNcAzDFdvhycRnY/FaUuLklDUlGK
         AlGALzbtfSC/KVpvPP9fResyig8ju0AttMGfeg8Bs2r/OdVzTKx8MenVgiPXg+4uhMkn
         RNs0BQGjtSgBwdCm53fSz0QxL12O6js1Xaksps9LDikRcQEbwsDcjqmwKPCbXLllROzh
         7O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750371; x=1741355171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV7o1W4VwE0oVZL2kkrDtiQc0Vk0TBhJcOtu6AAVAH4=;
        b=S/pfD22siiIHpY4V9K1JDsSzvCMGTNXE6pNk5o6xd1nItwzcTrkiaLYY0ckr7bZWUP
         CtNIRt+tETdzYGbVoJz0pIrxArlr+Sqq1jMADnn6XGskdObdIoqxpbdr8yxetli78tRG
         I7+ieEjQpDrFNZRLAAd7F2rhGQzpa+2g17iXRMaGA8w/QUZPSfX/i3EA5UtnCFGMO3H7
         PaSIWxQ/ZVC25kKVXPV8Xfq3rCR8TERMzZ9Q06iAR2cA0E8P3w7mW6fV7jXapVtg1m0x
         760xDsvDl2Tj7kDy1wTQF3lQG3OVFrCP9PkVMHzsbOiwkqZjZW+iXmSeEDd3+Tj8zP6s
         gf6w==
X-Forwarded-Encrypted: i=1; AJvYcCX3PeKdT7VVgvl2wyy5f/3aVxk5BEPprLVy0/bLIyXmJkxjvX39zb6DtTtw+DQBwdAweZDx5lRikJTh5Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2836aZ9OvYTgpOXn+69oHzPZppJtDrhvXor+L6/tBMKW6mkZg
	UrvEIrSMxbetySw3TMoFLgtdpUQvLFavs83EldYx19aSOWzhrIGEN09fbqRDEd8=
X-Gm-Gg: ASbGncuduVBeNU/zBw2az9FaKdC3381VvCW+BC+qyvnTLGnRzJtaohrnxWaDCBjvxjT
	swB3H/e/c1S0MnExlUelAJiJ8mrW0FixuPMkTLkwtAXRNPqDR0nKSIAzdYMgbLU77eqxZ8yqe/F
	9o+4wzGgTuP6N/r2ZzcLPNfDHmW0D9mQHcMBlLBO35gaXLGwal4HAlt+4ZOaYRK+9dSHuUuHFCg
	4oy+HaTo9EuPVjnlIvpfyQ/vZ6GgFnzxMaZ+h1qwZWzvt27OhhFa9CZ+4NBW0FmTETTtgHwaVFh
	9YMCTqZ8/cLGpA79epzesBdu2C7O
X-Google-Smtp-Source: AGHT+IEHw5y0udm3dHkze859QjWczyj8e/IKXXCrz2/r9sAWwzCqImFlyl0yIr48nNED4DBFN0oG+A==
X-Received: by 2002:a17:907:7f86:b0:ab7:d44b:355f with SMTP id a640c23a62f3a-abf26883059mr283958666b.25.1740750371012;
        Fri, 28 Feb 2025 05:46:11 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf1d1a84b7sm217516566b.19.2025.02.28.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:46:10 -0800 (PST)
Date: Fri, 28 Feb 2025 14:46:08 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: brauner@kernel.org, stgraber@stgraber.org, tycho@tycho.pizza, 
	cyphar@cyphar.com, yun.zhou@windriver.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] pid_namespace: namespacify sysctl kernel.pid_max
Message-ID: <ad4mel7m2tfybp54vqfl5c6sownjr5kq3xa5ytucfkqecfakga@aw65fx3rziyj>
References: <20241122132459.135120-1-aleksandr.mikhalitsyn@canonical.com>
 <bnxhqrq7tip6jl2hu6jsvxxogdfii7ugmafbhgsogovrchxfyp@kagotkztqurt>
 <CAEivzxdPDC+sgRDYuv+RG57_RX0+RAdRDJTy8L4Bi=MffHmCuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="egykfm2vqhuvfco3"
Content-Disposition: inline
In-Reply-To: <CAEivzxdPDC+sgRDYuv+RG57_RX0+RAdRDJTy8L4Bi=MffHmCuA@mail.gmail.com>


--egykfm2vqhuvfco3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/2] pid_namespace: namespacify sysctl kernel.pid_max
MIME-Version: 1.0

Hello Aleksandr.

On Tue, Feb 25, 2025 at 07:01:21PM +0100, Aleksandr Mikhalitsyn <aleksandr.=
mikhalitsyn@canonical.com> wrote:
> We see some kernel global limit or setting and consider if it's safe
> to be namespaced in some way
> and if it is safe and if it makes sense then we do it.

I know there are ucounts for various per-userns limits (NB RLIMIT_NPROC
among them).
Do you have any other precedents in mind?

In my thinking (biased towards raw resources, not ucounts) it's composed
like one global limit + cgroup limits for non-root groups, hence the
surprise with pid_max granularity.

> Second reason for having this is that we have a real use case scenario
> with 32-bit Android Bionic libc
> where we need to set a limit for PID *value*. And here, unfortunately,
> pids controller does not help either.

(I think if there were no pids controller, namespaced pid_max would be
very good approach how to implement this. But it sounds a little bit
redundant after pids controller was conceived.)

pid namespaces are definitely good place to tackle this since they do
pid numbers virtualization afterall. The challenge is how to limit the
number (amount) and number (pid) of tasks.
Note that besides the pids controller, pid_max and RLIMIT_NPROC, there's
also threads-max limit. Namespacing pid_max makes configuration space
even more complex :-/ In contrast with pids.max, there's no external
visibility of the namespace's pid_max (you must nsenter it) and pid_max
failures are more difficult to troubleshoot (mere failed fork(2)).

Admiteddly, I'm slightly hesitant to pursue the pids controller based
approach due to ns_last_pid. (Also how is that with starting those 32b
apps?  Do they themselves adjust the limits inside the pidns or is this
done by some launcher (who may need privileges to set pids.max)?)


One more idea I have, would be to rebase my original pid_max default
value elimination [1] on top of the namespaced pid_max and not to copy
=66rom parent but start unlimited in the ns too. (Or keep global default
value and unlimit only descednants so that's similar semantics to
ucounts.)


> I hope I explained above why I believe that this does not duplicate an
> existing mechanism.

The 32b scenario is certainly a sensible thing to resolve. But I'm still
worried people would start adjusting both of those and (presumably
different) people would run into unexpected fork failures.

Thanks,
Michal

[1] https://lore.kernel.org/all/20240408145819.8787-1-mkoutny@suse.com/

--egykfm2vqhuvfco3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8G+HgAKCRAt3Wney77B
SZSrAP0SVaFeiGeagzIuaIrgbleNbjVTGtiQuCTXnT0mqs1uDQEAguMqb/b4m7Qv
O9DZUVB6ExyCSLYNqTtuAlykziN0gA8=
=SEuY
-----END PGP SIGNATURE-----

--egykfm2vqhuvfco3--

