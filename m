Return-Path: <linux-kernel+bounces-268911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BA7942B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9311C249B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D556F1AB51D;
	Wed, 31 Jul 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JPrtDh6y"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439F1AAE22
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418905; cv=none; b=CCpoebttLYfyTudP4wzYrDt/YTJ8jVgAYHOtzsDfZK9R2Cu8VAArl17S+MegEXUG1tYhRolllTXu/GZak5d1lh4fSQzV38ZgUkTMDT7Tgtg7bZgyENIXD0XymEfKoSxGSko0uHJnDBIkUq6EvPFznXuoXD6rjlgTghak9rbfIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418905; c=relaxed/simple;
	bh=AvnUzep953GDaigrp+HtfOD1n1aZWOTF7Av/jGpNkow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/iJIa8XWCTgbScooPovnZq5ykYuNZMf3kZtoOnCXitGXjY20V5Xgq76rQ4BejUYWo9KAXUYABGz+O6iWkFnH7LKS62KQ3rd07Fnl3upS/nVIcMMEGBz42ZlIzoSDNoMbN0PPzADqY6w3fhn66L958GIrgyWTB/gYFqXgj/Zub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JPrtDh6y; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a8caef11fso614436666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722418901; x=1723023701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVOFjzLvVY/iMwNpUInUD4B5B+BlHH/h7oSaiQtUJBg=;
        b=JPrtDh6ykW1uhsuFZg0cu1I7RcDvJCkVXdsDj5l6mQcq9tfPZmfsgi0Vg3pFM4foE3
         sT+k7wMX/d/z4FQC9EFqqnnbhytiR3h//blm7AF6dbOntdOczNaZKuM1/q/3qntYkalt
         1GnuMlLN9AinLc9p5boFD3zQkHkdqHjL+rL2ikWIEPO/xTzMadBkQuwAuHY6CRtZsjpv
         GWMft8cAhbAxU3gbpuHhhudOIDQUV7nppIXVwloFNKZgLfvo8KkHNET+JVhK+YNQo7y9
         PzpK3yygB+c3P58pqBqS1Nke2Vi9euWtysr0XqP4/gAuM4eu6tSklcXkBo2eUR7tuI3O
         uBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722418901; x=1723023701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVOFjzLvVY/iMwNpUInUD4B5B+BlHH/h7oSaiQtUJBg=;
        b=iq6O4WnDMIvcTrSEuuE2NqvVkXN09fmuBddkNjfiRl10PTa80X1sOao/rS7rdhwxUb
         D0c5CXb41R/HNXHhTZRNrsVGwOSEd7tXrotYm5im7XbZsV++saVqRRLHn4XVTSEHfL9G
         ILYfbf4bWW6JrDHFSEhx0ybzBg+du3vcbPcG4MspQQrzesWwv8ayabxtPLAUY4ndvyTB
         g9lpKcfhz2Wz9TkWuwMKF6SR0bErwkqKfGwm3QkwVc1zfIpLZ9C6mj5ZtQopadDQn5ft
         wu2abZ48bX0DhO7MQkez+hcT3L3EAj7IWuRkiJuEfal2L5w2brnc5wCkqJJ6zUaw20Zt
         UUzg==
X-Forwarded-Encrypted: i=1; AJvYcCUyGhPG56t5AcWdzz4lf8fN5b2zQb2w3kuwDh7KVavYtOk/WSGP1dyeKIc/nqsam3SNTw8WEs59+/Fyj9/I3s3KPVSBwdz/wMvHNeuN
X-Gm-Message-State: AOJu0YxuxzVDruic/kuzo0LVLZBj+CcthzrNc10QKpECEFaHLoOdmlKl
	wmDOZngyH/o550qn4TRyXL5oGovUOLLgVeLYcZF9cP420meKIdA9xwYTXdYRV6g=
X-Google-Smtp-Source: AGHT+IHQsl+P4TBsSnJ53IGLFD381o7gzHEbHHprIgmjvO6yDPPnyjTxJQm7Yti9X+jVBEYTWNKA7w==
X-Received: by 2002:a17:906:7955:b0:a7a:abd8:77ae with SMTP id a640c23a62f3a-a7d3ffae487mr1151151266b.7.1722418901397;
        Wed, 31 Jul 2024 02:41:41 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab28249sm743633966b.30.2024.07.31.02.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 02:41:40 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:41:39 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kamalesh Babulal <kamalesh.babulal@oracle.com>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH-cgroup v7] cgroup: Show # of subsystem CSSes in
 cgroup.stat
Message-ID: <4cb4bczascgy4w774k7y5z5yewvl4civpkuhl46g73ckvoubj2@ag2cfvgayfqs>
References: <20240715150034.2583772-1-longman@redhat.com>
 <ZqmDpLTm6tKhAmYv@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ovrcoj4tl77pn42"
Content-Disposition: inline
In-Reply-To: <ZqmDpLTm6tKhAmYv@slm.duckdns.org>


--3ovrcoj4tl77pn42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 02:21:56PM GMT, Tejun Heo <tj@kernel.org> wrote:
> On Mon, Jul 15, 2024 at 11:00:34AM -0400, Waiman Long wrote:
> > Cgroup subsystem state (CSS) is an abstraction in the cgroup layer to
> > help manage different structures in various cgroup subsystems by being
> > an embedded element inside a larger structure like cpuset or mem_cgroup.
> >=20
> > The /proc/cgroups file shows the number of cgroups for each of the
> > subsystems.  With cgroup v1, the number of CSSes is the same as the
> > number of cgroups.  That is not the case anymore with cgroup v2. The
> > /proc/cgroups file cannot show the actual number of CSSes for the
> > subsystems that are bound to cgroup v2.
> >=20
> > So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
> > we can't tell by looking at /proc/cgroups which cgroup subsystems may
> > be responsible.
> >=20
> > As cgroup v2 had deprecated the use of /proc/cgroups, the hierarchical
> > cgroup.stat file is now being extended to show the number of live and
> > dying CSSes associated with all the non-inhibited cgroup subsystems that
> > have been bound to cgroup v2. The number includes CSSes in the current
> > cgroup as well as in all the descendants underneath it.  This will help
> > us pinpoint which subsystems are responsible for the increasing number
> > of dying (nr_dying_descendants) cgroups.
> >=20
> > The CSSes dying counts are stored in the cgroup structure itself
> > instead of inside the CSS as suggested by Johannes. This will allow
> > us to accurately track dying counts of cgroup subsystems that have
> > recently been disabled in a cgroup. It is now possible that a zero
> > subsystem number is coupled with a non-zero dying subsystem number.
> >=20
> > The cgroup-v2.rst file is updated to discuss this new behavior.
> >=20
> > With this patch applied, a sample output from root cgroup.stat file
> > was shown below.
> ...
>=20
> Applied to cgroup/for-6.12.

I think the commit message is missing something like this:

| 'debug' controller wasn't used to provide this information because
| the controller is not recommended in productions kernels, also many of
| them won't enable CONFIG_CGROUP_DEBUG by default.
|=20
| Similar information could be retrieved with debuggers like drgn but
| that's also not always available (e.g. lockdown) and the additional
| cost of runtime tracking here is deemed marginal.

or a 'Link:' to the discussion ;-)

Thanks,
Michal

--3ovrcoj4tl77pn42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqoGpgAKCRAt3Wney77B
SUkiAQD0ptZM9ZFjf2nAr7tHZeeJlb3AZ+2j+2aaASGs8/zoagEAuXgKYrujZm+6
5xTsrFaX3y/8u2xjJKBJLExrBELyLgE=
=51to
-----END PGP SIGNATURE-----

--3ovrcoj4tl77pn42--

