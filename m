Return-Path: <linux-kernel+bounces-248509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E7B92DE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379021F22308
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6139D8489;
	Thu, 11 Jul 2024 02:05:48 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B64383
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720663548; cv=none; b=mBYUbgFWpIRvxYmRHIfRIbFRIK11pe1oGNuIbgJCx12l73ijKOZQ0KG/k1GIQiRC8HfvfybG0fVFzg8unqC2de0UqvxSB4+wSvb3xL0yS8h8mVgCsHAnNiDW46cBFQcxosKG2O+pUCZQ20FMChF8pji+lejLfv2s1qL4R2Hc9xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720663548; c=relaxed/simple;
	bh=KpAYL1kpJuq0ScK3XFCGLLIfymGyqOJh5MB8UxUXp0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvRGRB8fAuMad/dF8Ry4b2rbNYBtt3UX+RSYUEjUt2wwHPnn31QlOrtOPel6B0QMUOpTTmL0wwzZbx+BU9WCHFdURjCweBhZ/HAdGktyv5ptdgBtpvBYL0gkW4Pyg6awvHCrPVqZ38nvMtF/VzRC4DYULQ24Fsl1Ymd1xL3LkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a05b4fa525so33191685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720663545; x=1721268345;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1c5A+f4tj6JTOu3bNDV68QMq8cDZl2dtORQp78q944=;
        b=tomV3ktkiRDha+f1y7L4tNMHcPeuTTk8vK80AxR6nbkzuZOgcNo2bPE0z3IRixaJpr
         8ge1jE1EVqVLaL0fb4aGJIJjtQASShfj4NnHSJwoBM5z0fZm5kx7TR72RfIgtage1mG2
         JREHfya5b19Yy5kOtuYjhWu+GwiOWKYrbSR1GtB0ut1SzRNRJ6bMuYNbkgTC2gal86/H
         7K8Zi4Bb6k38v4ViSjeMoN/+YqS619euLSamuh+RXs9pAMNFv/NQnB3mzyhr4v79zaQM
         SyeoNsPOVQ55Zr9WMRM3mZtY3GYbkiISR4gseUO5OSWJMyw2eqcf6Y1WT+MuoftCM7Bb
         a09w==
X-Gm-Message-State: AOJu0YwqRs1eiohiNSfoETIB7a4w57nGsJNK7rcw4nHJxSt8xwGNq+i1
	Yifen0O5OuixRD72YFBjoTr0wfDM+4+xUbdsqSM7E6KQv+o3seG+
X-Google-Smtp-Source: AGHT+IHRmTbiqHl4qo9+I5lnfvRIbWDq7m9qU6EWWFyJefvWKZPpwEzC22jkATcsaWI5DmUeUh8DVg==
X-Received: by 2002:a05:620a:28d6:b0:79f:503:368d with SMTP id af79cd13be357-7a1469eb0cdmr320491185a.27.1720663545297;
        Wed, 10 Jul 2024 19:05:45 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19016cc3sm245039185a.50.2024.07.10.19.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 19:05:44 -0700 (PDT)
Date: Wed, 10 Jul 2024 21:05:41 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCH 5/6] sched_ext: Allow SCX_DSQ_LOCAL_ON for direct
 dispatches
Message-ID: <20240711020541.GH317151@maniforge>
References: <20240711011434.1421572-1-tj@kernel.org>
 <20240711011434.1421572-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+VnUwdwnmLzxiACx"
Content-Disposition: inline
In-Reply-To: <20240711011434.1421572-6-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--+VnUwdwnmLzxiACx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 03:14:02PM -1000, Tejun Heo wrote:
> In ops.dispatch(), SCX_DSQ_LOCAL_ON can be used to dispatch the task to t=
he
> local DSQ of any CPU. However, during direct dispatch from ops.select_cpu=
()
> and ops.enqueue(), this isn't allowed. This is because dispatching to the
> local DSQ of a remote CPU requires locking both the task's current and new
> rq's and such double locking can't be done directly from ops.enqueue().
>=20
> While waking up a task, as ops.select_cpu() can pick any CPU and both
> ops.select_cpu() and ops.enqueue() can use SCX_DSQ_LOCAL as the dispatch
> target to dispatch to the DSQ of the picked CPU, the BPF scheduler can st=
ill
> do whatever it wants to do. However, while a task is being enqueued for a
> different reason, e.g. after its slice expiration, only ops.enqueue() is
> called and there's no way for the BPF scheduler to directly dispatch to t=
he
> local DSQ of a remote CPU. This gap in API forces schedulers into
> work-arounds which are not straightforward or optimal such as skipping
> direct dispatches in such cases.
>=20
> Implement deferred enqueueing to allow directly dispatching to the local =
DSQ
> of a remote CPU from ops.select_cpu() and ops.enqueue(). Such tasks are
> temporarily queued on rq->scx.ddsp_deferred_locals. When the rq lock can =
be
> safely released, the tasks are taken off the list and queued on the target
> local DSQs using dispatch_to_local_dsq().
>=20
> v2: - Add missing return after queue_balance_callback() in
>       schedule_deferred(). (David).
>=20
>     - dispatch_to_local_dsq() now assumes that @rq is locked but unpinned
>       and thus no longer takes @rf. Updated accordingly.
>=20
>     - UP build warning fix.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Tested-by: Andrea Righi <righi.andrea@gmail.com>
> Cc: David Vernet <void@manifault.com>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Changwoo Min <changwoo@igalia.com>

Acked-by: David Vernet <void@manifault.com>

--+VnUwdwnmLzxiACx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZo899QAKCRBZ5LhpZcTz
ZBp+APsF9QKeO00qhIjYKWgeyk3zG6nW05SFX2smzA/DnhK9VAEAkTuPIQhDs8DT
FkBBflykDCLm75QSEowcW5za+RSEIQc=
=zhBt
-----END PGP SIGNATURE-----

--+VnUwdwnmLzxiACx--

