Return-Path: <linux-kernel+bounces-376381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDC29AB0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB44B2844FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC971A0739;
	Tue, 22 Oct 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxgjjmNp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8CD1A0AF2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606656; cv=none; b=DAQ+5nGxKzd5ghoaz1XMWYQeCup9ljHmJV3uYdEiUgMdcylEFu3xwg2rPD9YW3JtIVztZjxmTn0GQhDLmEb0l98gJhQxj9YN1zI2TgpWA5FZHgZnwq7NdphmXfejbC7kBGsr0jHVxIo5+LnYkpa+NLoT4P4kd9QtDDkWZHauuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606656; c=relaxed/simple;
	bh=LUPVMOD4ZQ6wg1ocKwGi21gWY/lNCRUf1M0DLf1c/Ws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IWHbpVvCBAm24iJI9vdIIjT3l9Sg6mMzLWwgUNYwrdbKavRzOh3XFKJaopGpUC3QBQWy7pQtkbMA7gsoA94mf4jhxS5blbWR/AbX/siZeXPjWm3g5secxm4P9HGJO4U7E46V1pcPv/GmUGPxM42lgfsHotpCN1Nj0A7Euv73JjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxgjjmNp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729606654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOSKzau6wT6H5CR33wgPlaWELuBkpIiBFWNd8iU2Uq0=;
	b=ZxgjjmNp7FeDPbq11H9kFjJhqyBI2OXJ9ADcz+MQVfGoMVLv6lBZiU3ti3nqn8ciEkBbx7
	k0Z0JVfIykGyrJvrZXr3E28pV1nPj/Te7i0F0F1p20PfuUAqgG1ZCpH+hnzzEhh53kKlYB
	n1GXGNuqbMH1J5jKLEiAifUKVorQjow=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-x_0DypDZOE-tb2h3IYfPTw-1; Tue, 22 Oct 2024 10:17:32 -0400
X-MC-Unique: x_0DypDZOE-tb2h3IYfPTw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4316655b2f1so27916105e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729606651; x=1730211451;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOSKzau6wT6H5CR33wgPlaWELuBkpIiBFWNd8iU2Uq0=;
        b=E59ktu+AF3KBMN4cD5K6Wn9h6zHFk7wHZbfxArdinDBKHyxxm7WMXVRkwFOyyCB+yo
         t6O9LSb7vrS1hvM6UyrjdOg8qJTueXW15KhVqYp+uodeFT5PxLcqWCIHXjW+AEH1CV7u
         cesv3rbHa7ahx+SnS8q2W8pLqRExDbAl+Hi098J/osjUxiv2bLTliCSZJFq9Nn5TVRTM
         0ODkTojFKjfzxvRWGsTBJWY4t0Wse9Zq6Jso/E+dzGs45pAqcSE4SNV8GixZLtnRTrfJ
         08tQhSj6WOd1yxDDEvKvKrEMGdzsnYNHrvX6+KPEVy818Y18KW5CeN/k05sBB3fNaS0l
         bJxA==
X-Forwarded-Encrypted: i=1; AJvYcCXaXFPB06bNFpFYt7F4efu4UjvB12cljAgGIDUCxbUsd8ZetKq+9Cr967PJQX4c9cPH4/Jo7EkWnw5Uz4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW1ki1V3DyhMhBhFLHjMlsa+ZwqwvrBB7YLwknyohvFCXcOWqo
	3ttRboou2oGYarjsJJZN3DzfhF1dHrFSNof2fV915rMQW4THKGq1MdEne1CaitHtDIyjFpbJS4z
	86t+i3g4b6iTsYtGhXP60SYdVwHfcVfHzVtbK8JguB46B3tjE4zt+Pl3e7vCLsg==
X-Received: by 2002:a05:600c:4b87:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-4317caf63a8mr24446085e9.25.1729606651182;
        Tue, 22 Oct 2024 07:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+xo1gjEvuI+Ausdm7pGly7HL146lUmzfMU8cpapJtOkDb5H6qFcaWCH8lO6ZrnrTK3WSAoA==
X-Received: by 2002:a05:600c:4b87:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-4317caf63a8mr24445825e9.25.1729606650814;
        Tue, 22 Oct 2024 07:17:30 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93ea6sm6777545f8f.84.2024.10.22.07.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:17:30 -0700 (PDT)
Message-ID: <3b7b2e9f324d3a40f290392f56569154a3d6395f.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/sched: memset() 'job' in drm_sched_job_init()
From: Philipp Stanner <pstanner@redhat.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Luben
 Tuikov <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Oct 2024 16:17:29 +0200
In-Reply-To: <9c1f72ea-06d9-4615-b2f8-d98a0aa78aa1@amd.com>
References: <20241021105028.19794-2-pstanner@redhat.com>
	 <9c1f72ea-06d9-4615-b2f8-d98a0aa78aa1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-21 at 15:05 +0200, Christian K=C3=B6nig wrote:
> Am 21.10.24 um 12:50 schrieb Philipp Stanner:
> > drm_sched_job_init() has no control over how users allocate struct
> > drm_sched_job. Unfortunately, the function can also not set some
> > struct
> > members such as job->sched.
> >=20
> > This could theoretically lead to UB by users dereferencing the
> > struct's
> > pointer members too early.
> >=20
> > It is easier to debug such issues if these pointers are initialized
> > to
> > NULL, so dereferencing them causes a NULL pointer exception.
> > Accordingly, drm_sched_entity_init() does precisely that and
> > initializes
> > its struct with memset().
> >=20
> > Initialize parameter "job" to 0 in drm_sched_job_init().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > No changes in v2.
> >=20
> > +CC Christian and Tvrtko in this thread.
> > Would be cool if someone can do a review.
> > ---
> > =C2=A0 drivers/gpu/drm/scheduler/sched_main.c | 8 ++++++++
> > =C2=A0 1 file changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > b/drivers/gpu/drm/scheduler/sched_main.c
> > index dab8cca79eb7..2e0e5a9577d1 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -796,6 +796,14 @@ int drm_sched_job_init(struct drm_sched_job
> > *job,
> > =C2=A0=C2=A0		return -EINVAL;
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > +	/*
> > +	 * We don't know for sure how the user has allocated.
> > Thus, zero the
> > +	 * struct so that unallowed (i.e., too early) usage of
> > pointers that
> > +	 * this function does not set is guaranteed to lead to a
> > NULL pointer
> > +	 * exception instead of UB.
> > +	 */
> > +	memset(job, 0, sizeof(*job));
> > +
>=20
> Maybe just implicitly set the sched pointer to NULL here?
>=20
> On the other hand compilers these days are really good at optimizing=20
> that away anyway, so feel free to add Reviewed-by: Christian K=C3=B6nig=
=20
> <christian.koenig@amd.com> to the series as is as well.

(I had performance-tested it with several million jobs and couldn't
detect a performance regression that was measurable)

Applied #1 to drm-misc-next, thanks.

Regarding patch #2, I just noticed that it violates the docstring
style. I therefore hereby reject my own patch and will resubmit it in a
cleaner form ^^'

P.

>=20
> Regards,
> Christian.
>=20
> > =C2=A0=C2=A0	job->entity =3D entity;
> > =C2=A0=C2=A0	job->credits =3D credits;
> > =C2=A0=C2=A0	job->s_fence =3D drm_sched_fence_alloc(entity, owner);
>=20


