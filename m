Return-Path: <linux-kernel+bounces-554206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8005BA594A6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3532F3A9D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511162253E6;
	Mon, 10 Mar 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YIiKwph8"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6711C07D9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610285; cv=none; b=bbC8WtVsvaw9ZAtf4zAG8SKbbPOMFNGDafa3746VrtuBfV18YUBJ8BllLgc7Lith1f/OPeJkJbgKL9GPy3aJ7xoIfLJ2lZv343ZLhg4Bcq/Z0/7N53QLIP/g72t2RWJCwCgJRl7P+YDD4E7lTZPViEiNMF1fErHORGARDfq7MvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610285; c=relaxed/simple;
	bh=Nagh/5TlyKX2aQYN5BbQE07pr5TFCFn2jCmUJFYiWTU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mMAb+7pe6yNiR/54Od3e8H3VnU5YVw0+ub/j1GdWM8FK3lMhvbFt9BB0HbdgUtUn0RsXM/I7sWFAk0yU2/lANAnpgil8ne3fLRZitIVRazp3dWge8BGGGUYGkk2YTr4vhhUIifKU8jnxIK1EhHFcY3S9KnRpP2uptK6ELRscxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YIiKwph8; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZBGdG4c8fz9ss0;
	Mon, 10 Mar 2025 13:37:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741610274; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4Q2+Zz4aPz+PBPNZqysqjDenVpdOzlAYx4ww6BzQo4=;
	b=YIiKwph8lnDvc8xzpJULkDrrGUJFVJys2OWJUuH4wZ7Z8cNIwL0WofYCiM28BtS+alqJSB
	xw59xsNsjuG63BcKsnWdzJaxoOkQA6mZo4Yjb2oxIM3+lnQhBKnl0s8D/Tf0jVCwKZ+KAS
	zoxsfW/aXA9R5k0N7QgQcyoZwcKLIGwvAjGN1qjAGB411SMqqJDjTvU14o4F06aV02Ix+5
	gkKMhR4/unbHJEyx2T6jtIZFUTZI0Vpdo4P2A0TnVeY6VME3Gt07OXUnYz34rapLCenkVM
	/L+tQ2A2lvehqt+EpGHvURxXFTe3uwj/+lRG2140tRoeVigxJ3WTGFRRo2Vfpw==
Message-ID: <95f663076b59fc85818d14a1a14416b88aae1c73.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: revert "drm_sched_job_cleanup(): correct
 false doc"
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, matthew.brost@intel.com,
 dakr@kernel.org,  tvrtko.ursulin@igalia.com,
 dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org
Date: Mon, 10 Mar 2025 13:37:52 +0100
In-Reply-To: <4269639b-56e0-4f44-8485-6120eeaf28e5@amd.com>
References: <20250310074414.2129157-1-christian.koenig@amd.com>
	 <564be70f7d64c04c1ad77499522d99c64ea4d4d3.camel@mailbox.org>
	 <4269639b-56e0-4f44-8485-6120eeaf28e5@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: a6khkh5hoafds3zsfej451zfbp68wwtj
X-MBO-RS-ID: 6bac97aba1c6295e0e0

On Mon, 2025-03-10 at 13:25 +0100, Christian K=C3=B6nig wrote:
> Am 10.03.25 um 13:11 schrieb Philipp Stanner:
> > On Mon, 2025-03-10 at 08:44 +0100, Christian K=C3=B6nig wrote:
> > > This reverts commit 44d2f310f008613c1dbe5e234c2cf2be90cbbfab.
> > OK, your arguments with fence ordering are strong. Please update
> > the
> > commit message according to our discussion:
> >=20
> > > Sorry for the delayed response, I only stumbled over this now
> > > while
> > > going
> > > over old mails and then re-thinking my reviewed by for this
> > > change.
> > Your RB hadn't even been applied (I merged before you gave it), so
> > you
> > can remove this first paragraph from the commit message
> >=20
> > > The function drm_sched_job_arm() is indeed the point of no
> > > return.
> > > The
> > > background is that it is nearly impossible for the driver to
> > > correctly
> > > retract the fence and signal it in the order enforced by the
> > > dma_fence
> > > framework.
> > >=20
> > > The code in drm_sched_job_cleanup() is for the purpose to cleanup
> > > after
> > > the job was armed through drm_sched_job_arm() *and* processed by
> > > the
> > > scheduler.
> > >=20
> > > The correct approach for error handling in this situation is to
> > > set
> > > the
> > > error on the fences and then push to the entity anyway. We can
> > > certainly
> > > improve the documentation, but removing the warning is clearly
> > > not a
> > > good
> > > idea.
> > This last paragraph, as per our discussion, seems invalid. We
> > shouldn't
> > have that in the commit log, so that it won't give later hackers
> > browsing it wrong ideas and we end up with someone actually
> > mengling
> > with those fences.
>=20
> Sure, going to make those updates. I just wanted to give people a
> possible direction to look into when they really run into a situation
> where they need to abort some submission very late.
>=20
> Should I also clarify the comment in drm_sched_job_cleanup()?

Shouldn't be done in a revert-commit I think.

I'd say we revert for now (it's not a big loss, just a bit of docu) and
then you (or maybe I) submit a new patch where we discuss Tvrtko's
questions and then write down the rules and issues precisely in both
commit message and the function's comments.


P.

>=20
> Regards,
> Christian.
>=20
> >=20
> > Thx
> > P.
> >=20
> > > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > ---
> > > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 12 +++++-------
> > > =C2=A01 file changed, 5 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > index 53e6aec37b46..4d4219fbe49d 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > @@ -1015,13 +1015,11 @@
> > > EXPORT_SYMBOL(drm_sched_job_has_dependency);
> > > =C2=A0 * Cleans up the resources allocated with drm_sched_job_init().
> > > =C2=A0 *
> > > =C2=A0 * Drivers should call this from their error unwind code if @jo=
b
> > > is
> > > aborted
> > > - * before it was submitted to an entity with
> > > drm_sched_entity_push_job().
> > > + * before drm_sched_job_arm() is called.
> > > =C2=A0 *
> > > - * Since calling drm_sched_job_arm() causes the job's fences to
> > > be
> > > initialized,
> > > - * it is up to the driver to ensure that fences that were
> > > exposed to
> > > external
> > > - * parties get signaled. drm_sched_job_cleanup() does not ensure
> > > this.
> > > - *
> > > - * This function must also be called in &struct
> > > drm_sched_backend_ops.free_job
> > > + * After that point of no return @job is committed to be
> > > executed by
> > > the
> > > + * scheduler, and this function should be called from the
> > > + * &drm_sched_backend_ops.free_job callback.
> > > =C2=A0 */
> > > =C2=A0void drm_sched_job_cleanup(struct drm_sched_job *job)
> > > =C2=A0{
> > > @@ -1032,7 +1030,7 @@ void drm_sched_job_cleanup(struct
> > > drm_sched_job
> > > *job)
> > > =C2=A0		/* drm_sched_job_arm() has been called */
> > > =C2=A0		dma_fence_put(&job->s_fence->finished);
> > > =C2=A0	} else {
> > > -		/* aborted job before arming */
> > > +		/* aborted job before committing to run it */
> > > =C2=A0		drm_sched_fence_free(job->s_fence);
> > > =C2=A0	}
> > > =C2=A0
>=20


