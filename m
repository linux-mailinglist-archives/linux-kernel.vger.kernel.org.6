Return-Path: <linux-kernel+bounces-382093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1DD9B0920
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BBB1C21D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42F143C4C;
	Fri, 25 Oct 2024 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5cVmWJo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76151502BE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872275; cv=none; b=lZuk80NW+n951aK2NwbFwZehCrJ4KwszNkVF0ShyAi3fKfTIm3+QPhxSkg8sDyhh8x7ZxoIzvBfD73Xf4j8JKBCrexo2/E2iu2m2IPQnIQ4Sb7NPHvNw57HiOQTaG5Rmrw3wI4EFgZAWvh4O/6L+iQa4XZkOKLhlVdEKzUHmufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872275; c=relaxed/simple;
	bh=KY/2mM8i/Ew0DUDrKUzoXlHVsepMa5X/Jb2wz7aZ3/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E6Rv1ImgS7EyCcFKKNn72MmROrubFtE0Ye8ExtHuS1G8CFSF5Ct9K7ddp9Lzt9yszZBH1i4Bs/r3uDjBe6/OK0VdCiezqMNk80SAgmwMMzAND3zVdxW+8HkEnOIH/9Wcrh7+HN0XVOCt62WHqMCsUSPS9lBkEYZmX2NUBaNgGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5cVmWJo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729872272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mq0ZSPaaM4EdprorVscFmQk+8GBA3VtDTMlmBxyEmiI=;
	b=N5cVmWJoKLkqZoEYDv6djQ51OtMAMRzYKUOP7KXsugbDO7gF8vH0ieT4BvT/lzN4xpD2O8
	Tn7aq0Dd2UObFcdtQLdY0PVLrebi6gqwnLkcZQUHHYaySsiVlcb47PDjMLK6mS7VU/CaLG
	JAZjDaR0Wr7DSrhLOIwCwWCejeALHdU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-kJmP5MhvN_OXaQ2yUr6Txw-1; Fri, 25 Oct 2024 12:04:31 -0400
X-MC-Unique: kJmP5MhvN_OXaQ2yUr6Txw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c93572b437so1529587a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729872270; x=1730477070;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mq0ZSPaaM4EdprorVscFmQk+8GBA3VtDTMlmBxyEmiI=;
        b=efHsE+e0jRgBWbjaaKCdeIouTJIozrMwbyjPHSM0LPBErg6QkkbDzPu1+M8DOeTefz
         lcHYfQbm08Y26tDJV1g2fkiSkKUsKGk8ol6bWAjdVTsDGrctFLpClyTpIUOtYl1pEVLA
         Q38wvyAgBTFwBFHCuTFLwkmO93TPp1CXs0NmKn24UnuRxK/ZnghwUYCkthacmxk4du57
         3KKV8Zx3UtiL4wGMtyMYj34KYL1PZfkGPkMngxyj3DoD/9I/lFmS+vIUuzSWZqWE3cIw
         gogiOeNEU3b2KzYTzIc9TlBlqZHFre9nZqqWdNahbQyMfBQeTDrBMFzUabTLL5ugoJdw
         rwlw==
X-Forwarded-Encrypted: i=1; AJvYcCWziS0vchUIhBUq2632dokezXmXj4ZgTPrJX1Fass/Hu1PR7j1US/ziBExqu58sWZ+LJFhsQWWGcMk3agg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7HAiW9NUe5rC3ysUK2sf/9Pj3vEds+Fq+aZbdcWnu5nJZ4Q8j
	P6KVuUbnzjth1Dms1KyRmrI/x4I8F1jy9Ss3FmjRxl9HUrU68qlZwbpmGG64hh0gnVrXFrRIlsh
	9dT1XGEqbeSOi/ZKQ1HxnhYPfxoRVkLE8+UeVaFDVcBhHuBB9yu13NyEm6GJk9w==
X-Received: by 2002:a05:6402:5011:b0:5cb:89d0:d423 with SMTP id 4fb4d7f45d1cf-5cba2454282mr4896970a12.12.1729872270041;
        Fri, 25 Oct 2024 09:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH4gqN9URLnFTdTMFPkxRZysuH2sFVvE3nRndWn31MrN/a9M9J/HlZtU1XnwBkUGH1I+Kq5Q==
X-Received: by 2002:a05:6402:5011:b0:5cb:89d0:d423 with SMTP id 4fb4d7f45d1cf-5cba2454282mr4896933a12.12.1729872269531;
        Fri, 25 Oct 2024 09:04:29 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629c250sm761328a12.27.2024.10.25.09.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:04:28 -0700 (PDT)
Message-ID: <243743c08eca2da4882d1c5fb3b01b68f044ee4a.camel@redhat.com>
Subject: Re: [PATCH] drm/sched: warn about drm_sched_job_init()'s partial
 init
From: Philipp Stanner <pstanner@redhat.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,  Tvrtko Ursulin
 <tursulin@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Fri, 25 Oct 2024 18:04:27 +0200
In-Reply-To: <ZxsDRWxVRt2fCKpF@DUT025-TGLU.fm.intel.com>
References: <20241023141530.113370-2-pstanner@redhat.com>
	 <ZxsDRWxVRt2fCKpF@DUT025-TGLU.fm.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-25 at 02:32 +0000, Matthew Brost wrote:
> On Wed, Oct 23, 2024 at 04:15:31PM +0200, Philipp Stanner wrote:
> > drm_sched_job_init()'s name suggests that after the function
> > succeeded,
> > parameter "job" will be fully initialized. This is not the case;
> > some
> > members are only later set, notably drm_sched_job.sched by
> > drm_sched_job_arm().
> >=20
> > Document that drm_sched_job_init() does not set all struct members.
> >=20
> > Document the lifetime of drm_sched_job.sched.
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>=20
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>=20

Applied to drm-misc-next, thank you.

P.


> > ---
> > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 4 ++++
> > =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++++++
> > =C2=A02 files changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > b/drivers/gpu/drm/scheduler/sched_main.c
> > index dab8cca79eb7..8c1c4739f36d 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -771,6 +771,10 @@ EXPORT_SYMBOL(drm_sched_resubmit_jobs);
> > =C2=A0 * Drivers must make sure drm_sched_job_cleanup() if this functio=
n
> > returns
> > =C2=A0 * successfully, even when @job is aborted before
> > drm_sched_job_arm() is called.
> > =C2=A0 *
> > + * Note that this function does not assign a valid value to each
> > struct member
> > + * of struct drm_sched_job. Take a look at that struct's
> > documentation to see
> > + * who sets which struct member with what lifetime.
> > + *
> > =C2=A0 * WARNING: amdgpu abuses &drm_sched.ready to signal when the
> > hardware
> > =C2=A0 * has died, which can mean that there's no valid runqueue for a
> > @entity.
> > =C2=A0 * This function returns -ENOENT in this case (which probably
> > should be -EIO as
> > diff --git a/include/drm/gpu_scheduler.h
> > b/include/drm/gpu_scheduler.h
> > index ab161289d1bf..95e17504e46a 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -340,6 +340,14 @@ struct drm_sched_fence
> > *to_drm_sched_fence(struct dma_fence *f);
> > =C2=A0struct drm_sched_job {
> > =C2=A0	struct spsc_node		queue_node;
> > =C2=A0	struct list_head		list;
> > +
> > +	/**
> > +	 * @sched:
> > +	 *
> > +	 * The scheduler this job is or will be scheduled on. Gets
> > set by
> > +	 * drm_sched_job_arm(). Valid until
> > drm_sched_backend_ops.free_job()
> > +	 * has finished.
> > +	 */
> > =C2=A0	struct drm_gpu_scheduler	*sched;
> > =C2=A0	struct drm_sched_fence		*s_fence;
> > =C2=A0
> > --=20
> > 2.47.0
> >=20
>=20


