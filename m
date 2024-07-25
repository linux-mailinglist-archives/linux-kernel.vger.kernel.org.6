Return-Path: <linux-kernel+bounces-262225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D0B93C2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88D31F221E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF919AD9E;
	Thu, 25 Jul 2024 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JK9Ag9XY"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD251991D7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913331; cv=none; b=RGrgX45561yfKqlVBvx3nV/DG6Ky4fgCe+MOJblcjtX00Q+paN3GjpFun2txvUbFK6k0bg9HLkG9Ao7znj4+K4WpOSxgd1W03mdpFCDbZ06bKlBkxG9VT9BO9iUwK+tmxs/s6ds1J7ahoXL77zN0NOG7CMagOTiQh69jwrXhKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913331; c=relaxed/simple;
	bh=wBQvpVohbd2W4vplmrY5Z64LjAwjMZD6ae8o/85wxuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EurMfPJ4gOavsyYAu0hrnhcdv/8oFCMZFjh9MFKNuUF6mAfJklGq2uIbnH9HZO82uvTFaVvr5xbP6hDQTihWs6ZYbgeHWg4k7aW2bIFY6jqCE9IMi94vdiHwauC0CAcPI32GCd3xvCXWm1mEmKcxS8Nn/Ree8tlTwLIXTx+8LXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JK9Ag9XY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so58169066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721913327; x=1722518127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=efjrSpUOXuKmG3Wgod3ChlCv7XK4z1uzPlvVqgjPuBA=;
        b=JK9Ag9XYaZqA8OukqAJzzxy4jhUF8yUERMSQyfToSjG+wbQoOK0HvDiFGtHxr4GJpa
         I61DfPMfgV/syuDVSQ1zVg29Y18mZLzIa/ciRI9jBT3RhTFMV+PGDnFopyvpb6hKwiPw
         U4jZRWw60YPUFcDEEqkXCGVpH2lR2/l04poff53RpaDxaPQ2OA+ZtvAsX3Ohdo1ttfsw
         L78BOtzudFPIQu+/8BszZxBs7G4GCj39d8iSa2FKoH0pd7l6iHdSuAALnd+QhCZHMeKK
         WFM2yZ6aYafnJP3N+0mLCskF4smXCR/b5T7Rq94ojOjwtf7ae/6IxXM/I6lhrTitlgXS
         QkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721913327; x=1722518127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efjrSpUOXuKmG3Wgod3ChlCv7XK4z1uzPlvVqgjPuBA=;
        b=AdJUfA1V67gx/v4WkEJ5Oe/B/uDv4lKl1qew7tZ03iFVuTj1WCQ3S1xjTJLd+sBF5I
         YKJAqKwTZJnB0g/7wvro81ELWn/zuy5vQ3si/9b/nWJuRlKO4ponKpn1j/V3PHFkCkxC
         +O5kzslRxOPwxWSiqWpN4IAjOnPmfGvlA+KJDxlbcp4oZzmxcVeeYL3eMpKVeJlVJyr1
         ddwPPLODpUhmN4ShtlswJT/LRbuXu2AWJZHsudSKzy5badfz/htglHxwicz5eRdmt+GH
         rNnl5xzIbpwKURs1PfmVyHh38zvmLRXEvR39ZfJTpakRw2P2h9ItxQj+uNz6e8eurPzw
         bqUA==
X-Forwarded-Encrypted: i=1; AJvYcCUiDn468Aa8Vk7xmdK9Xbr4T6CObEWCLtBU01vyYlKUU22HHsgh+lO000YZ96LCegigVrD08q7NY5lalt21iS1koVKvEE1V5WeBSbmw
X-Gm-Message-State: AOJu0Yz/1N82EaH9TNHXrCD4i8ts8XiTSils0N4MWPXACEWf3QNAtXrO
	dOcDIMKndNJCo7tt7CprTLmgHghTVa/kDW7v6k1JPl2y/KQGJHHP1ioMERNZVvw=
X-Google-Smtp-Source: AGHT+IE7ycVbMTwcSDtveSbfPhTy1z6/v17KCNgRLQqdkNtT7UyXHl1UgyXUGldYyjNB28P9hbc4oA==
X-Received: by 2002:a17:907:3da7:b0:a7a:c106:3659 with SMTP id a640c23a62f3a-a7ac506f2f6mr222422866b.60.1721913327478;
        Thu, 25 Jul 2024 06:15:27 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad418f1sm71234566b.135.2024.07.25.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 06:15:26 -0700 (PDT)
Date: Thu, 25 Jul 2024 15:15:25 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kamalesh Babulal <kamalesh.babulal@oracle.com>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH-cgroup v4] cgroup: Show # of subsystem CSSes in
 cgroup.stat
Message-ID: <23hhazcy34yercbmsogrljvxatfmy6b7avtqrurcze3354defk@zpekfjpgyp6h>
References: <20240711025153.2356213-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4ikx4ra2wliee3i"
Content-Disposition: inline
In-Reply-To: <20240711025153.2356213-1-longman@redhat.com>


--p4ikx4ra2wliee3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Wed, Jul 10, 2024 at 10:51:53PM GMT, Waiman Long <longman@redhat.com> wr=
ote:
> As cgroup v2 had deprecated the use of /proc/cgroups, the hierarchical
> cgroup.stat file is now being extended to show the number of live and
> dying CSSes associated with all the non-inhibited cgroup subsystems
> that have been bound to cgroup v2 as long as it is not zero.  The number
> includes CSSes in the current cgroup as well as in all the descendants
> underneath it.  This will help us pinpoint which subsystems are
> responsible for the increasing number of dying (nr_dying_descendants)
> cgroups.

This implementation means every onlining/offlining (only additionally)
contends in root's css updates (even when stats aren't ever read).

There's also 'debug' subsys. Have you looked at (extending) that wrt
dying csses troubleshooting?
It'd be good to document here why you decided against it.

> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3669,12 +3669,36 @@ static int cgroup_events_show(struct seq_file *se=
q, void *v)
>  static int cgroup_stat_show(struct seq_file *seq, void *v)
>  {
>  	struct cgroup *cgroup =3D seq_css(seq)->cgroup;
> +	struct cgroup_subsys_state *css;
> +	int ssid;
> =20
>  	seq_printf(seq, "nr_descendants %d\n",
>  		   cgroup->nr_descendants);
>  	seq_printf(seq, "nr_dying_descendants %d\n",
>  		   cgroup->nr_dying_descendants);
> =20
> +	/*
> +	 * Show the number of live and dying csses associated with each of
> +	 * non-inhibited cgroup subsystems bound to cgroup v2 if non-zero.
> +	 *
> +	 * Without proper lock protection, racing is possible. So the
> +	 * numbers may not be consistent when that happens.
> +	 */
> +	rcu_read_lock();
> +	for_each_css(css, ssid, cgroup) {
> +		if ((BIT(ssid) & cgrp_dfl_inhibit_ss_mask) ||
> +		    (cgroup_subsys[ssid]->root !=3D  &cgrp_dfl_root))
> +			continue;

Is this taken? (Given cgroup.stat is only on the default hierarchy.)

Thanks,
Michal

--p4ikx4ra2wliee3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqJP6wAKCRAt3Wney77B
SZZcAP9TGigif3uPku2ECmJ0PKbMFe2LxRWwMcG2m30wn2EgNwD/VDV8rVWE4gVZ
ht3p54KnGh7JUfslrPNkV9B/ivtzXgU=
=Nn+B
-----END PGP SIGNATURE-----

--p4ikx4ra2wliee3i--

