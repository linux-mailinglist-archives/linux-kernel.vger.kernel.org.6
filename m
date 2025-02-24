Return-Path: <linux-kernel+bounces-528603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489CEA41995
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FEF53ABA4B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB442475DD;
	Mon, 24 Feb 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R2vsewlS"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8F2451F1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390791; cv=none; b=czi0FKcDPuAj831n4DrhxlclUmgU4fn0MjheNMB9CP+whFvgg2IzKNfrpmTKlBryLQGf4yQIAhBdJJtom+24/TxwMvl0m9ih5+sW+jZB02mjvOFjiZrPhxi+iUVx4hG76bpJ0/2u/TECnD2Slm0mykHsh6KvFz7vQwZmYd25rsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390791; c=relaxed/simple;
	bh=Og9RtG7GpaYMWovVmA699lsFaaCKSYqXRTt157pq6WY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ec63EX5iWuyxEebwMWZTHATEqjZu/En9UyrxN4svUG4hu/tLUSHEwQY5mEs9u7hrUWF98Wblr+f0Rvioo9lZL03dF5L9pxfxxvHD/PIgc+uvirKGOS9K/LlfQz4tEB4C9Jvw2GrX2PbGQkr+pVXeFSEwUtfURpSn0z/sqnzH5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=R2vsewlS; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z1bdS51RDz9sp7;
	Mon, 24 Feb 2025 10:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1740390780; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boC3bouyoaSvBm6PU/jvOFqOLo282xREKBk3M94rwD0=;
	b=R2vsewlSUvVw6M21xKZNLmYLlmbf7fi/rdOTdWUyzZCQMkcjA7gb8+DhGWUmZ5TbQ7XYdx
	rqqTGqICbXcIPSMW8VRsR1PLYlI3fp6/h7X9vPgHTQttBHwDLefdaC3m3OBk/pcTC/qvOy
	ALCYhxvE6nMIhMMzkQijbwC78h+UNKltfnRS3VP0OQw0osBv8yKO2iBRm6zBxBwERCNwV+
	jFhROFb5itWpAVUa2ebvMeD2kCgOoLGco7spzoyqWUur8dwD1mXtuBLK/pRbs4grB6rkSa
	m2QdI40qIadd6BrX6Xr9YyPq6gGtOKHO1NkEhN9B18bCal4322JTgQZVaKzf5g==
Message-ID: <3b369e1a49b354852f361b103999673e4f7906a9.camel@mailbox.org>
Subject: Re: [PATCH] drm/scheduler: Fix mem leak when last_scheduled signaled
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: qianyi liu <liuqianyi125@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
  Matthew Brost <matthew.brost@intel.com>, Philipp Stanner
 <phasta@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 24 Feb 2025 10:52:56 +0100
In-Reply-To: <20250221062702.1293754-1-liuqianyi125@gmail.com>
References: <20250221062702.1293754-1-liuqianyi125@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 977615c1c76e705c497
X-MBO-RS-META: je8iqfkdcauxx1gactnrgz41ok6gim6q

Hello,

subject line: please write "drm/sched" instead of "drm/scheduler". It
has become the norm

On Fri, 2025-02-21 at 14:27 +0800, qianyi liu wrote:
> Problem: If prev(last_scheduled) was already signaled I encountred a

prev(last_scheduled) almost reads like a function call. Maybe write
"prev / last_scheduled"?

> memory leak in drm_sched_entity_fini. This is because the
> prev(last_scheduled) fence is not free properly.

s/free/freed

>=20
> Fix: Balance the prev(last_scheduled) fence refcnt when
> dma_fence_add_callback failed.
>=20
> Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 7 +++++--
> =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> b/drivers/gpu/drm/scheduler/sched_entity.c
> index 69bcf0e99d57..1c0c14bcf726 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -259,9 +259,12 @@ static void drm_sched_entity_kill(struct
> drm_sched_entity *entity)
> =C2=A0		struct drm_sched_fence *s_fence =3D job->s_fence;
> =C2=A0
> =C2=A0		dma_fence_get(&s_fence->finished);
> -		if (!prev || dma_fence_add_callback(prev, &job-
> >finish_cb,
> -					=C2=A0=C2=A0
> drm_sched_entity_kill_jobs_cb))
> +		if (!prev ||
> +		=C2=A0=C2=A0=C2=A0 dma_fence_add_callback(prev, &job->finish_cb,
> +					=C2=A0=C2=A0
> drm_sched_entity_kill_jobs_cb)) {
> +			dma_fence_put(prev);

But now the fence will also be put when prev =3D=3D NULL. Is that
intentional? It doesn't seem correct to me from looking at the commit
message, which states "Balance [=E2=80=A6] refcnt when dma_fence_add_callba=
ck
failed"

It didn't get clear to me immediately which dma_fence_get() your new
dma_fence_put() balances. Can you ellaborate on that or maybe write a
comment?

But also be handy of could share the kmemleak trace.


Thanks
P.

> =C2=A0			drm_sched_entity_kill_jobs_cb(NULL, &job-
> >finish_cb);
> +		}
> =C2=A0
> =C2=A0		prev =3D &s_fence->finished;
> =C2=A0	}


