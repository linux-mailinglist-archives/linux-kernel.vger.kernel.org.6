Return-Path: <linux-kernel+bounces-528623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F16A419E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23EF1188F28E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45142505C1;
	Mon, 24 Feb 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bPP8dfzG"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFC24292F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391055; cv=none; b=bau74A7vvnTiCem+QbGauITGdPvrWDHj6O8Rruoed6LBmfzjMdK+Q79HCUQousm0rEIFL3lxhKFNKUntOLGTqE8pofzWsrzuPqTFZfmkt10vazcFKCyi7QCvnoNfHJP3ME6OMOPQ7/yYeupg60CbqvHSbUgrtXAFpwnT3aZCTVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391055; c=relaxed/simple;
	bh=zZ4LSD0pf5gem00PnlfjoiKkJZOWfQSUlOEEwXRRwAo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J/6ZpSUKxKM1lYleXtxfN8xcW0h7vK/Ca9mm5XpGX2Ek8EiRoMLN5REjgx4t7YWhHiaTRafzULkSy3WPQfAbxXlDcI0BBHlpV70f9vNYXlRvLG+M1R81KJqLJYVGRvH5Cg70/FjeSa0RLVZ443ZVojYoKE6kcnizZYWfYOYYvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bPP8dfzG; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z1bkf0DrSz9spX;
	Mon, 24 Feb 2025 10:57:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1740391050; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVke/a1muIuPPw9tqzQVhkbMsCi2gU1HQNx6O8LlpO0=;
	b=bPP8dfzG1KdKoo4XbbnX0Egqkj/tZSMiFQtHy0HvtRoDc1AE3cT7JliMii9B6hAOhVOblf
	dM7uLyZnW/0Q/zmfi3RhUY5+XHeCFuCfNRpTwnnk+rCzBHW4JTB5CcAv74yZkt9ZVWI6dJ
	BMCH5t719k17DKhmW5PQJl7ec77gcQdbfka5T4+QJDdY2gIqODr1uWlXA5I2ZQ2zeze2GI
	S2GTSWjkvKDG8RQAGVqsvyyIr+evhi7laaLgrGdDr1FhaxKfJnnkEcVVZhw9PI6DgHPE46
	95+Kpar4PR98oI4e9W9SlPpTO+IwujfdjeSmSzWZkadPJyIc8PTjD3UtKOLgwA==
Message-ID: <21a944a054790c0a5b542183b7d5fa54483232be.camel@mailbox.org>
Subject: Re: [PATCH] drm/scheduler: Fix mem leak when last_scheduled signaled
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: phasta@kernel.org, qianyi liu <liuqianyi125@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 24 Feb 2025 10:57:26 +0100
In-Reply-To: <3b369e1a49b354852f361b103999673e4f7906a9.camel@mailbox.org>
References: <20250221062702.1293754-1-liuqianyi125@gmail.com>
	 <3b369e1a49b354852f361b103999673e4f7906a9.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: o6us1zn17yc464ke5wp6ap13n3xd8wwq
X-MBO-RS-ID: 181b0d227478099764b

On Mon, 2025-02-24 at 10:52 +0100, Philipp Stanner wrote:
> Hello,
>=20
> subject line: please write "drm/sched" instead of "drm/scheduler". It
> has become the norm
>=20
> On Fri, 2025-02-21 at 14:27 +0800, qianyi liu wrote:
> > Problem: If prev(last_scheduled) was already signaled I encountred
> > a
>=20
> prev(last_scheduled) almost reads like a function call. Maybe write
> "prev / last_scheduled"?
>=20
> > memory leak in drm_sched_entity_fini. This is because the
> > prev(last_scheduled) fence is not free properly.
>=20
> s/free/freed
>=20
> >=20
> > Fix: Balance the prev(last_scheduled) fence refcnt when
> > dma_fence_add_callback failed.
> >=20
> > Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 7 +++++--
> > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> > b/drivers/gpu/drm/scheduler/sched_entity.c
> > index 69bcf0e99d57..1c0c14bcf726 100644
> > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > @@ -259,9 +259,12 @@ static void drm_sched_entity_kill(struct
> > drm_sched_entity *entity)
> > =C2=A0		struct drm_sched_fence *s_fence =3D job->s_fence;
> > =C2=A0
> > =C2=A0		dma_fence_get(&s_fence->finished);
> > -		if (!prev || dma_fence_add_callback(prev, &job-
> > > finish_cb,
> > -					=C2=A0=C2=A0
> > drm_sched_entity_kill_jobs_cb))
> > +		if (!prev ||
> > +		=C2=A0=C2=A0=C2=A0 dma_fence_add_callback(prev, &job->finish_cb,
> > +					=C2=A0=C2=A0
> > drm_sched_entity_kill_jobs_cb)) {
> > +			dma_fence_put(prev);
>=20
> But now the fence will also be put when prev =3D=3D NULL. Is that
> intentional? It doesn't seem correct to me from looking at the commit
> message, which states "Balance [=E2=80=A6] refcnt when dma_fence_add_call=
back
> failed"
>=20
> It didn't get clear to me immediately which dma_fence_get() your new
> dma_fence_put() balances. Can you ellaborate on that or maybe write a
> comment?
>=20
> But also be handy of could share the kmemleak trace.

Argh.

-> "It would also be handy if you could share the kmemleak trace"

I should drink less=E2=80=A6

P.


>=20
>=20
> Thanks
> P.
>=20
> > =C2=A0			drm_sched_entity_kill_jobs_cb(NULL, &job-
> > > finish_cb);
> > +		}
> > =C2=A0
> > =C2=A0		prev =3D &s_fence->finished;
> > =C2=A0	}
>=20


