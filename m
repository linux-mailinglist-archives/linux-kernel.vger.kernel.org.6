Return-Path: <linux-kernel+bounces-328170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F23977FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA821F2220F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B9E1D9336;
	Fri, 13 Sep 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VujWChKW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3491D7998
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230628; cv=none; b=j5qgTEubAITXQ6ojDyB5M6ySEhJcHf4+0dZ3wf+ni4GepnrMMqKPstjTa2IdyoPG1sipSe1imsFMAlM3UDtw6IgdQ8636YiBk8l+gCgayL6K7mY+7CkiSAcA9zvwMPmWzQQYm022LdsPta2t2RbDGeu2ihaexaSdRC/RIhxQXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230628; c=relaxed/simple;
	bh=FK3Vht+YLn0La8Og3Jep87M44TLD5+r+6DtOW1BgfBk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R6jhVuuxxe5ikZfKkjr00bMmnvtVRJnulIc73WF28QDpRZ9FYRNUrZbY5I3udZ9m0cZH6jcmG21P0RkYnVVHXcjsHH4hA++uCwvWr5ZlyVs1V68ug8t8ADvg6Gwt0xZi3kmVzHcJkIxZZNE0I45dlJca3elH0j3v4qMiZ2Gmc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VujWChKW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726230625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0VoKMuWqnaEWqybDQCpxkWHJw8Kz2YNIn1hGCLOjlE=;
	b=VujWChKWAVticM6DkzSWCOprn+b6iQ5Wa6FFnuYqcqsRG6i6CWV4q8/jx3jTmWhiScMug3
	Z8V2hFtd2cfVwpNRrSgzUDxvkhejqyl3b2Ku4c3LddXPn8FSa7NAdkKPXJsr/QeVM/nkUe
	TP/B+LoOc15ryHabBZijbLvmzZf6oFE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-_Mv-GxxRPj6mbpi9JC5Djw-1; Fri, 13 Sep 2024 08:30:24 -0400
X-MC-Unique: _Mv-GxxRPj6mbpi9JC5Djw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374b35856aeso973374f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726230623; x=1726835423;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0VoKMuWqnaEWqybDQCpxkWHJw8Kz2YNIn1hGCLOjlE=;
        b=UctSfpG6vaZnDpgKsdrgKKESs9Q5VuvC6ufuIxPmsW5HyBXa/YNyApoM9ySQlD1jZ6
         1wSL/Qbjg2I13WG04B6mhZVC1mlOYSUwWcSWUDOYCCd1+gpQ+ZMwHJjZXvJz7HnDUoPp
         +g2Ukkqw0eaK7OrqMcL5n7cXlg0f79W9/0C8jjR9KYfxIf2yN06qKXfC4FiowjB930ke
         Jp7aCZYgHoPXbhdiWvSBYJFXuD5IA7WOaSrK+a2/p/H3WFY+5LAlrhofaAVcoM3/uO2g
         WEM/K4JprMZwrLuY/SEDcxqJWCjpEvXRWULqPf7Cd2fxS5NNmV1XrTet0zJwMMEI8hbe
         VBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn5Cq8tifu1Ww+sMXKcuhBKjJQjRN101cg/JVxN5cEwkdgafHUMmKQRBhHArShRroYIdCvg4HxOLFspuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTP8L+X8Vm+zKc3AcnQM7eR1GVF1z2l/Hq1pox1Cr/MuX4JcZh
	pU3qVs4c221tIyDUVEXQMzgUb7Ym766RAPOGQk58QSZsubX9UTAUaI+WfMDqeY1TocvymVeshkT
	lhnJWOIwX3cGfkPuuXv+dMWtJ1uJ2mNm7MwLHegS+65yVXUUBX54cWdSPvG8eVR+4hSkY/w==
X-Received: by 2002:a05:6000:184c:b0:374:c022:fa76 with SMTP id ffacd0b85a97d-378c2d5ab83mr4216135f8f.37.1726230622640;
        Fri, 13 Sep 2024 05:30:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUISq1VQj0veSF27+xlc8jHLNsZrB5BBsx5hH5wxw1335M+m80qsLu9zGMev40PhP0WosCXw==
X-Received: by 2002:a05:6000:184c:b0:374:c022:fa76 with SMTP id ffacd0b85a97d-378c2d5ab83mr4216112f8f.37.1726230622082;
        Fri, 13 Sep 2024 05:30:22 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d2a:6400:5050:48a2:62f2:4d16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b21sm16786689f8f.49.2024.09.13.05.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:30:21 -0700 (PDT)
Message-ID: <8a646b5c871fe454d6f194a54fa65d67f3ae5366.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] drm/sched: memset() 'job' in drm_sched_job_init()
From: Philipp Stanner <pstanner@redhat.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>, Luben Tuikov
 <ltuikov89@gmail.com>,  Matthew Brost <matthew.brost@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich
 <dakr@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Fri, 13 Sep 2024 14:30:20 +0200
In-Reply-To: <92a123f1-73c9-45a1-8e0a-af72dd0a70e7@ursulin.net>
References: <20240828094133.17402-2-pstanner@redhat.com>
	 <92a123f1-73c9-45a1-8e0a-af72dd0a70e7@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-13 at 12:56 +0100, Tvrtko Ursulin wrote:
>=20
> Hi,
>=20
> On 28/08/2024 10:41, Philipp Stanner wrote:
> > drm_sched_job_init() has no control over how users allocate struct
> > drm_sched_job. Unfortunately, the function can also not set some
> > struct
> > members such as job->sched.
>=20
> job->sched usage from within looks like a bug. But not related to the
> memset you add.
>=20
> For this one something like this looks easiest for a start:
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c=20
> b/drivers/gpu/drm/scheduler/sched_main.c
> index ab53ab486fe6..877113b01af2 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -788,7 +788,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * or worse--a blank screen--leave a trail in=
 the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * logs, so this can be debugged easier.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 drm_err(job->sched, "%s: entity has no rq!\n",
> __func__);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pr_err("%s: entity has no rq!\n", __func__);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to
> variable=20
> number of run-queues")
> Cc: <stable@vger.kernel.org> # v6.7+

Danilo and I already solved that:

https://lore.kernel.org/all/20240827074521.12828-2-pstanner@redhat.com/


>=20
> > This could theoretically lead to UB by users dereferencing the
> > struct's
> > pointer members too early.
>=20
> Hmm if drm_sched_job_init returned an error callers should not=20
> dereference anything. What was actually the issue you were debugging?

I was learning about the scheduler, wrote a dummy driver and had
awkward behavior. Turned out it was this pointer not being initialized.
I would have seen it immediately if it were NULL.

The actual issue was and is IMO that a function called
drm_sched_job_init() initializes the job. But it doesn't, it only
partially initializes it. Only after drm_sched_job_arm() ran you're
actually ready to go.

>=20
> Adding a memset is I think not the best solution since it is very
> likely=20
> redundant to someone doing a kzalloc in the first place.

It is redundant in most cases, but it is effectively for free. I
measured the runtime with 1e6 jobs with and without memset and there
was no difference.


P.

>=20
> Regards,
>=20
> Tvrtko
>=20
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
> > ---
> > =C2=A0 drivers/gpu/drm/scheduler/sched_main.c | 8 ++++++++
> > =C2=A0 1 file changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > b/drivers/gpu/drm/scheduler/sched_main.c
> > index 356c30fa24a8..b0c8ad10b419 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -806,6 +806,14 @@ int drm_sched_job_init(struct drm_sched_job
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
> > =C2=A0=C2=A0	job->entity =3D entity;
> > =C2=A0=C2=A0	job->credits =3D credits;
> > =C2=A0=C2=A0	job->s_fence =3D drm_sched_fence_alloc(entity, owner);
>=20


