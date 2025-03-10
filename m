Return-Path: <linux-kernel+bounces-553748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9322A58E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9213AD5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E49223706;
	Mon, 10 Mar 2025 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UMrrEjwe"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60302223707
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596107; cv=none; b=imfZiI2w6197q0uC/OOoft0rR1FTZ/8u9Rjm+VybRqMzAEBna6Yb9rURDX4sdx9YLcx7/CxvCY3YXYHpDa5/MOTXEvjGIwDnd8YuaKiqXC7Ul+6cMpFhEjM8Dx+pXoSBYauRfGZxBy2y49JBverbBqXrfKzM+XUMgHYG7cQAYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596107; c=relaxed/simple;
	bh=wmsWoo1T7fXqCrRMW1jcusfF9vXrXAXPPBSmfAt/4tA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I287UDFx/HBnW/l3QF7wrCC3XbyGYofho2vivedeuwdsrJ/E5Xj6vjyP7qG4DNGqZiYXVAL04epudLJwRhuilu4zxyhwRgZ3sW5DZYq6VTq71dNv+S4yA54uny5uG/9PK38zb7IqjncOkwnOC7WEPedQ3sBtalUgA8+HXrF0Yd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UMrrEjwe; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZB9Ng3pGkz9t6M;
	Mon, 10 Mar 2025 09:41:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741596099; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj9YyUHtB58au90L2cXLcwO3crRUYeD3IqPgZ3hNa2k=;
	b=UMrrEjweewmLhOB+wBNZzyJ0r8FomabYHLl6JbsdsT939y3SVt5zv0sjUGdtnGZWBPG2Tm
	n5ZxrNy2Y6ed+0OX9gM5XCr1pMHZxP1YiOf5NhK75nMgAGdbvI/98X6OGyDupK5ezJ3I7R
	ZfiPBzvlnIRKGpQMsF+SAG5lpHZSJsadKCgf5G7kuHpXCcrHQTicCMB/KsqwxukhzosXae
	GnJeR0IxN7AZdrL+oQIzkcJazWmpvdzLal/9MT0A0NX0kWMiACGDY/hwVND0G7Yuf4knc4
	R3uHD+JfJ7meEsLWHaBblQ5RkCz+BP03XLWthVohjfz2EYFdjv8HeNDO5bT5qw==
Message-ID: <cb3745c15e5e2c3a2b03e47a56d2e4db555664b5.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: revert "drm_sched_job_cleanup(): correct
 false doc"
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	matthew.brost@intel.com, dakr@kernel.org, phasta@kernel.org, 
	tvrtko.ursulin@igalia.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Date: Mon, 10 Mar 2025 09:41:36 +0100
In-Reply-To: <20250310074414.2129157-1-christian.koenig@amd.com>
References: <20250310074414.2129157-1-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: pb36k69c177kywtrmnw4x9z65u6rje4z
X-MBO-RS-ID: 835e40521a2dc2c37e0

On Mon, 2025-03-10 at 08:44 +0100, Christian K=C3=B6nig wrote:
> This reverts commit 44d2f310f008613c1dbe5e234c2cf2be90cbbfab.
>=20
> Sorry for the delayed response, I only stumbled over this now while
> going
> over old mails and then re-thinking my reviewed by for this change.
>=20
> The function drm_sched_job_arm() is indeed the point of no return.

So would you say that the comment in the function's body,
"drm_sched_job_arm() has been called" actually means / should mean "job
had been submitted with drm_sched_entity_push_job()"?

> The
> background is that it is nearly impossible for the driver to
> correctly
> retract the fence and signal it in the order enforced by the
> dma_fence
> framework.
>=20
> The code in drm_sched_job_cleanup() is for the purpose to cleanup
> after
> the job was armed through drm_sched_job_arm() *and* processed by the
> scheduler.
>=20
> The correct approach for error handling in this situation is to set
> the
> error on the fences and then push to the entity anyway.

You expect the driver to set an error on scheduled and finished fence?
I think this would be very likely to explode. AFAICS the scheduler code
has no awareness for anyone else having touched those fences.

If at all, if this is really a problem, we should tell the driver that
it must enforce that there will be no failure between
drm_sched_job_arm() and drm_sched_job_entity_push_job(). That's how
Nouveau does it.

Let's set our understanding straight before reverting. What
drm_sched_job_arm() does is:

   1. Pick scheduler, rq and priority for the job
   2. Atomically increment the job_id_count and assign to job
   3. Call drm_sched_fence_init() and therefore:
   4. Set the fence's scheduler
   5. Set the fences seq nr atomically
   6. Initialize scheduled and finished fence

What of the above precisely is the problem?

You say the driver cannot "correctly retract the fence and signal it in
the order enforced by the dma_fence framework". You mean that the
finished_fences have to be signalled in an order only the scheduler
knows? I assume you're referring to set dependencies?

P.

> We can certainly
> improve the documentation, but removing the warning is clearly not a
> good
> idea.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 12 +++++-------
> =C2=A01 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index 53e6aec37b46..4d4219fbe49d 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1015,13 +1015,11 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
> =C2=A0 * Cleans up the resources allocated with drm_sched_job_init().
> =C2=A0 *
> =C2=A0 * Drivers should call this from their error unwind code if @job is
> aborted
> - * before it was submitted to an entity with
> drm_sched_entity_push_job().
> + * before drm_sched_job_arm() is called.
> =C2=A0 *
> - * Since calling drm_sched_job_arm() causes the job's fences to be
> initialized,
> - * it is up to the driver to ensure that fences that were exposed to
> external
> - * parties get signaled. drm_sched_job_cleanup() does not ensure
> this.
> - *
> - * This function must also be called in &struct
> drm_sched_backend_ops.free_job
> + * After that point of no return @job is committed to be executed by
> the
> + * scheduler, and this function should be called from the
> + * &drm_sched_backend_ops.free_job callback.
> =C2=A0 */
> =C2=A0void drm_sched_job_cleanup(struct drm_sched_job *job)
> =C2=A0{
> @@ -1032,7 +1030,7 @@ void drm_sched_job_cleanup(struct drm_sched_job
> *job)
> =C2=A0 /* drm_sched_job_arm() has been called */
> =C2=A0 dma_fence_put(&job->s_fence->finished);
> =C2=A0 } else {
> - /* aborted job before arming */
> + /* aborted job before committing to run it */
> =C2=A0 drm_sched_fence_free(job->s_fence);
> =C2=A0 }
> =C2=A0


