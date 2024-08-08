Return-Path: <linux-kernel+bounces-279993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3758994C445
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CD42834A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE91482F3;
	Thu,  8 Aug 2024 18:26:04 +0000 (UTC)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012B913BACE
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141564; cv=none; b=r2lR/OULO95tjG6XmFZsniRn1dT0XQznbMAfrDE2LId/LoY9sba4uja9C/UuaKr931RDdDqFmi38mMv1+k2ppJLhfRmdvDatVqnDlOerT8GUdZKl9GLxnsPQg3sdUe+GCjadvy1sW/gE/Vxw3urwSEjlpWYhS9iNqQOUdLMJpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141564; c=relaxed/simple;
	bh=PIkjUSNDg0zyK/ATGuviT5qAI6FYMWWKq+QUkJPp9jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU8rMzB8g4AiOCjkXpdpws+uc0AEeQyjYlr6LAI3iWwNWYAmksUWNlQtQJQpedL9OteTWneIqkWmNMoWY/7PV8URgBfCbLKKr+uRnxT3Ny8TPrwLt4f9GEBNfmtwkTfomn1jx1Usp60SQ9jg1t22cZkZ97YBrmRPmnuwfb+GYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-492a76c0cfbso412061137.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141562; x=1723746362;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhUPel+WCjLnGJ2IBYMunOT0UvIvEhE75Fzsa4eiTFw=;
        b=eKVUsoVyN4wLefhLOkiNiSG23p0QowQ3WHTeXtP7kdwtA4jO14O88z92MgdswDaZok
         vvKw9rUzH1LMtbXJEZUBnw6TiEHla6lk4iNehWqhk51w6Zvi7r10wKhAKyQNn5u0ENmf
         rZDRJdgrncUO106lvEsCpItdWGpFe8+gzqt8Vcd6Lv7fkHXR5l5AOdAAmbJ7zIiGB0Kd
         e5qIjm2JWt0tLQhF9QFEYRCPqmM2Nt9k9/1gVj1N8tuksbCbaRtacIyrhoXFYXASn14q
         BmD7J1SZx5537qL1ouq9w5lC8ej9CnnJkbMF8SitHBQngaLp7l2OBm8kMME6eorwLr+6
         FqWg==
X-Gm-Message-State: AOJu0YyDLbaKRGTIM/fleoLgZ+Y6cuq1ffVD1bX6dtnqMOJCCbiMh+75
	QMqzFIZ0jrE5Ye0LnJjI7d60tx/d6kTjceDgDSVUOdN1UtA/xwox
X-Google-Smtp-Source: AGHT+IFMNyXthYsAF6tt0SSICsU32TWbUtv5Nm93OAemghi1H68OeD2Up4YDOFdu8pJ/W4CgkczQ4A==
X-Received: by 2002:a05:6102:50a7:b0:493:dee7:9b8e with SMTP id ada2fe7eead31-495c5b57444mr3456520137.7.1723141561885;
        Thu, 08 Aug 2024 11:26:01 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c8733e56sm15306591cf.47.2024.08.08.11.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 11:26:01 -0700 (PDT)
Date: Thu, 8 Aug 2024 13:25:59 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RESEND sched_ext/for-6.12] sched_ext: Don't use double
 locking to migrate tasks across CPUs
Message-ID: <20240808182559.GG6223@maniforge>
References: <ZrP_zUjrTcrfdHDe@slm.duckdns.org>
 <ZrQAB_d1WSqgYQmB@slm.duckdns.org>
 <20240808181927.GE6223@maniforge>
 <ZrUNdy-oQFd3TgJj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7kraiUyc9MvGpKVs"
Content-Disposition: inline
In-Reply-To: <ZrUNdy-oQFd3TgJj@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--7kraiUyc9MvGpKVs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 08:24:55AM -1000, Tejun Heo wrote:
> Hello,
>=20
> On Thu, Aug 08, 2024 at 01:19:27PM -0500, David Vernet wrote:
> ...
> > > +	deactivate_task(src_rq, p, 0);
> > > +	set_task_cpu(p, cpu_of(dst_rq));
> > > +	p->scx.sticky_cpu =3D cpu_of(dst_rq);
> > > +
> > > +	raw_spin_rq_unlock(src_rq);
> > > +	raw_spin_rq_lock(dst_rq);
> > > =20
> > >  	/*
> > >  	 * We want to pass scx-specific enq_flags but activate_task() will
> > >  	 * truncate the upper 32 bit. As we own @rq, we can pass them throu=
gh
> > >  	 * @rq->scx.extra_enq_flags instead.
> > >  	 */
> > > -	WARN_ON_ONCE(rq->scx.extra_enq_flags);
> > > -	rq->scx.extra_enq_flags =3D enq_flags;
> > > -	activate_task(rq, p, 0);
> > > -	rq->scx.extra_enq_flags =3D 0;
> > > +	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr));
> >=20
> > Hmmm, what's to stop someone from issuing a call to
> > set_cpus_allowed_ptr() after we drop the src_rq lock above?  Before we
> > held any relevant rq lock so everything should have been protected, but
> > I'm not following how we prevent racing with the cpus_allowed logic in
> > core.c here.
>=20
> deactivate_task(src_rq, p, 0) sets p->on_rq to TASK_ON_RQ_MIGRATING and
> task_rq_lock() can't lock p until it's cleared, so set_cpus_allowed_ptr()
> is blocked till the migration is complete.

Ahh I see, thanks. This LGTM then.

Acked-by: David Vernet <void@manifault.com>

>=20
> Thanks.
>=20
> --=20
> tejun

--7kraiUyc9MvGpKVs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZrUNtwAKCRBZ5LhpZcTz
ZCvzAP9BzekzykmSJwU0lmS4L7kIQ6WijuaWgky0Ay2muAFgjAD/Tu8tbjXBcZ/a
fEyTHgNkzqm03m1QnxDmTAMjrYVrTwI=
=3MvT
-----END PGP SIGNATURE-----

--7kraiUyc9MvGpKVs--

