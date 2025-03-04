Return-Path: <linux-kernel+bounces-543375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BB4A4D4D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3213AC9E7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544721F5851;
	Tue,  4 Mar 2025 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CmszyjBo"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440041F561D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073272; cv=none; b=c6XvmYpUQY/fg1EOLUkRI4FV8lVlk7Eqv2GG0YV5S2MWxkacs9LOeRos6reICb/Gu8jUgdzvL404rGmZ1E7XiMsNVu7Mu7Mzz3d2+S9DGtXrFv4qAYZPJ+zf+cNMfpjY3Go6gzjNs8rTS3t8bGxTrflEjF9CLBw3cCKV3s+kKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073272; c=relaxed/simple;
	bh=9fg2yALjZUc9Rtuccj4eaqmyTTAro6/0t/vAndOlVUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gu6RR1dtxy/sSNqdb4SrjxcUzNTMfGzF88IUJrF/99kBlkxQcflrAer/b5nan9emsbtt81sX/zkUFC00ExzUPllauDec+lEtPbZKJ0Q/o6gmwhF6ByNfoAbUtu9+qZiDniAm83YXswlUrhmiPRca3MIJQy8yERdQ9g6/HcDVAIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CmszyjBo; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z6S2B36p0z9sbt;
	Tue,  4 Mar 2025 08:27:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741073266; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1fWGBEOXoTgtHTDeD8byH8a9L2+0Ns9nMiatwCQZjI=;
	b=CmszyjBo2giNfjs1DNkNfuRSsi+fZGl9C/cms97eukWFjLoYfoON/XdYr6RPxr64VdsnZh
	L2gg6pnOzxPN4P8Rlcl84egTpMS9DI5QdFufIC7FsOPR9+mHu5uNCfCbHkw5WFhSvqd2Qi
	qgdV1kq8ikSg5PGrac8EgqIlhp+fxLXgBktEMjFaCTRrMLD46cgwWPpHfakD7+0dQaB4VZ
	HFpkYCx32jwhpayfZNHRYSx2wV05lz9tx8SR1u+1u5/10Or+wq2S27c270YK382a05sUQB
	ExYDumzD4ZvrsZG/3OIrtM1HPVQ4kwWjis4GRdFUXVEuVLsuujpOpB6FCp8bdA==
Message-ID: <6405f50e3c78d0a06c5dd1b82d4a0a84bdf9d24f.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: drm_sched_job_cleanup(): correct false doc
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Philipp Stanner
 <phasta@kernel.org>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Mar 2025 08:27:42 +0100
In-Reply-To: <d0de7ff5-0c48-4ad9-9a4f-2b7b4925a4e3@igalia.com>
References: <20250303143251.43793-2-phasta@kernel.org>
	 <d0de7ff5-0c48-4ad9-9a4f-2b7b4925a4e3@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 3df82b19cd94c645a5b
X-MBO-RS-META: 8tpu3f1d15r9ft3rgbicwtzjd5gyw4ud

On Mon, 2025-03-03 at 17:13 +0000, Tvrtko Ursulin wrote:
>=20
> On 03/03/2025 14:32, Philipp Stanner wrote:
> > drm_sched_job_cleanup()'s documentation claims that calling
> > drm_sched_job_arm() is a "point of no return", implying that
> > afterwards
> > a job cannot be cancelled anymore.
> >=20
> > This is not correct, as proven by the function's code itself, which
> > takes a previous call to drm_sched_job_arm() into account. In
> > truth, the
> > decisive factors are whether fences have been shared (e.g., with
> > other
> > processes) and if the job has been submitted to an entity already.
> >=20
> > Correct the wrong docstring.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0 drivers/gpu/drm/scheduler/sched_main.c | 10 ++++++----
> > =C2=A0 1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > b/drivers/gpu/drm/scheduler/sched_main.c
> > index c634993f1346..db9e08e6e455 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -1013,11 +1013,13 @@
> > EXPORT_SYMBOL(drm_sched_job_has_dependency);
> > =C2=A0=C2=A0 * Cleans up the resources allocated with drm_sched_job_ini=
t().
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 * Drivers should call this from their error unwind code if=
 @job
> > is aborted
> > - * before drm_sched_job_arm() is called.
> > + * before it was submitted to an entity with
> > drm_sched_entity_push_job().
> > =C2=A0=C2=A0 *
> > - * After that point of no return @job is committed to be executed
> > by the
> > - * scheduler, and this function should be called from the
> > - * &drm_sched_backend_ops.free_job callback.
> > + * Since calling drm_sched_job_arm() causes the job's fences to be
> > initialized,
> > + * it is up to the driver to ensure that fences that were exposed
> > to external
> > + * parties get signaled. drm_sched_job_cleanup() does not ensure
> > this.
> > + *
> > + * This function must also be called in &struct
> > drm_sched_backend_ops.free_job
> > =C2=A0=C2=A0 */
> > =C2=A0 void drm_sched_job_cleanup(struct drm_sched_job *job)
> > =C2=A0 {
>=20
> I also do not see anything so special in the flows which would
> disallow=20
> "aborting" jobs after arming. And it definitely can happen in the=20
> practice. It was probably just unclear kerneldoc.

I thought about why they wrote that for a few months and the only
reason I can imagine was that they were worried about the initialized
fences being shared.

>=20
> What I would suggest to add to the patch is to change the comment in=20
> drm_sched_job_cleanup() implementation:
>=20
> This one:
>=20
> 		/* aborted job before committing to run it */
>=20
> Probably just change to:
>=20
> 		/* aborted before arming */

Yes, good catch. Will do.

P.

>=20
> With that you can add my r-b.
>=20
> Regards,
>=20
> Tvrtko
>=20


