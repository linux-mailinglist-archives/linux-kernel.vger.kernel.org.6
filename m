Return-Path: <linux-kernel+bounces-414574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A389D2A65
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F38AFB2BDDA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2821D0BA6;
	Tue, 19 Nov 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hgj8BNGO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF111CF2A6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031403; cv=none; b=Q/EfKje7LJvl9TyFtuekDsPVPkgj7jVip6ZIYD6DNCVcbXqoUn5ZmgsURgwEWBNnCtaaJnhgYXcOO4Px1DAgxZ/yqLACEwyBCVJvXDLDbKriVcm7fL4CWtHxqISU7psQxCPpFA1cYKKazyVZFB43/tURS8ZqV//zhzroTjg4Its=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031403; c=relaxed/simple;
	bh=47ygFDeYgVKpY8pR6AOA0KJLPNp9Ts4bGrlHmU5U/lA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ma0eilRjacqSf/aAdcj5jjMDBrUYKrrNDpJtY160aDN920UkPjHr8gVknmfxYXjJR0B72ZBHzy2WiheTmN+kEDF/BfUwAn+9YQqF33Ayo0bFapnp3ST2hzkEYrXcf3r7dt3Nb6/yTeMNToKj2r6GBufrhTJYBcgjOeMTp9F0Yco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hgj8BNGO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732031400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j48pMYCI1mAgBjsBkzo4REwKeKZ158VhK38QDgL6Yds=;
	b=Hgj8BNGOEV85AP4g4e7A/wLeEFFyrahm7YoF2IC7vJPoRP9LMyVc78GpKMAfDLt/7Ld8M7
	ntKhKxikMzIuncPfhIxIJZlY+wpmQIv4zB6VFEtNeOj75zcMweu6PwBVPrC1HUcYkkH1gc
	qNlZAJnGSipKwYfc6YSTRUD2UB0WUZM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-YYAx5ebIMrKBpUfO3NWlyg-1; Tue, 19 Nov 2024 10:49:59 -0500
X-MC-Unique: YYAx5ebIMrKBpUfO3NWlyg-1
X-Mimecast-MFC-AGG-ID: YYAx5ebIMrKBpUfO3NWlyg
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a1af73615so74472266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732031398; x=1732636198;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j48pMYCI1mAgBjsBkzo4REwKeKZ158VhK38QDgL6Yds=;
        b=HjOH0TGs2UVaDfDLR5kpxyibL/uogK9qekRBRLfuND/iZHm6xDuJDCNJRZgK+RxSy8
         4OvWlSBK+Mdee8oaFHcOFae55UFhsQ8K7RydraPKCkuA7BJNlD8/gvB0e3lwYIvq5Uyy
         9d4C33EWL9udvQdPXxeNyIXHdujZYFjuMFprAbBUD/N7lK2O6GMCA9viHiqU14FNShwS
         XUKl35MF+tkFIU2y0jT69GKakD/Jf8EF5xqPPb4pBmDx2qgGf2jRC929nKc2Ue9L0ob7
         tcKO9TJY2OtJi14eKHO9ZGSvOgpPjpf1YinIskdYr4fXIiPeOUfkkfoRMcxAJB6ePbsJ
         azbA==
X-Forwarded-Encrypted: i=1; AJvYcCXBz3J58FQWhBKCBBoYbKLeR91mRwC5DqZe36Gf9IhaRY6LFig0qg8V3PPNyojQGfULO1Zx1fbg0aVcJs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhwBqfqtWct8N1OCPgxDyOsy6dHEmFOlDCoEdJPmVuQ+BiEIwp
	2cXkBukJqN5KQFd+/tgdT0XunTbXi5qi/+npb3r2y1+wimSdRVmYtdJLnZgN35nEmig7lBJJeGe
	8h58dd+lI3HZv7Sdics7vzZ0LybBvr7TtdzBZVCvZnFXDi5WHtFig+2oQIifOXvXTrO03yA==
X-Received: by 2002:a17:907:a4b:b0:a8d:6648:813f with SMTP id a640c23a62f3a-aa4833f6cc2mr1597488466b.3.1732031398004;
        Tue, 19 Nov 2024 07:49:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkY/oVtStM9buWZieA+FdS2d36EO4hAO6J0OH+roK8jLGYtod6akj9TI2LnWb9dg8cGqlkHg==
X-Received: by 2002:a17:907:a4b:b0:a8d:6648:813f with SMTP id a640c23a62f3a-aa4833f6cc2mr1597485866b.3.1732031397662;
        Tue, 19 Nov 2024 07:49:57 -0800 (PST)
Received: from ?IPv6:2001:16b8:3d72:6400:a5d7:d54:865f:255e? ([2001:16b8:3d72:6400:a5d7:d54:865f:255e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4fc07sm662314866b.44.2024.11.19.07.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:49:57 -0800 (PST)
Message-ID: <0ba134e8a902da1b916469e760c36c3588f8bc71.camel@redhat.com>
Subject: Re: [PATCH 2/2] drm/sched: Fix docu of drm_sched_entity_flush()
From: Philipp Stanner <pstanner@redhat.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Luben
 Tuikov <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 19 Nov 2024 16:49:56 +0100
In-Reply-To: <919d1a3b-6757-4902-ac1a-b056c9fdad06@amd.com>
References: <20241119134122.21950-2-pstanner@redhat.com>
	 <20241119134122.21950-3-pstanner@redhat.com>
	 <919d1a3b-6757-4902-ac1a-b056c9fdad06@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-19 at 15:27 +0100, Christian K=C3=B6nig wrote:
> Am 19.11.24 um 14:41 schrieb Philipp Stanner:
> > drm_sched_entity_flush()'s documentation states that an error is
> > being
> > returned when "the process was killed". That is not what the
> > function
> > actually does.
> >=20
> > Furthermore, it contains an inprecise statement about how the
> > function
> > is part of a convenience wrapper.
> >=20
> > Move that statement to drm_sched_entity_destroy().
> >=20
> > Correct drm_sched_entity_flush()'s documentation.
> >=20
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0 drivers/gpu/drm/scheduler/sched_entity.c | 18 +++++++++---------
> > =C2=A0 1 file changed, 9 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> > b/drivers/gpu/drm/scheduler/sched_entity.c
> > index 16b172aee453..7af7b448ad06 100644
> > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > @@ -270,15 +270,12 @@ static void drm_sched_entity_kill(struct
> > drm_sched_entity *entity)
> > =C2=A0=20
> > =C2=A0 /**
> > =C2=A0=C2=A0 * drm_sched_entity_flush - Flush a context entity
> > - *
> > =C2=A0=C2=A0 * @entity: scheduler entity
> > - * @timeout: time to wait in for Q to become empty in jiffies.
> > - *
> > - * Splitting drm_sched_entity_fini() into two functions, The first
> > one does the
> > - * waiting, removes the entity from the runqueue and returns an
> > error when the
> > - * process was killed.
> > + * @timeout: time to wait in jiffies
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 * Returns: 0 if the timeout ellapsed, the remaining time
> > otherwise.
> > +
> > + * Waits at most @timeout jiffies for the entity's job queue to
> > become empty.
> > =C2=A0=C2=A0 */
> > =C2=A0 long drm_sched_entity_flush(struct drm_sched_entity *entity, lon=
g
> > timeout)
> > =C2=A0 {
> > @@ -290,7 +287,7 @@ long drm_sched_entity_flush(struct
> > drm_sched_entity *entity, long timeout)
> > =C2=A0=C2=A0		return 0;
> > =C2=A0=20
> > =C2=A0=C2=A0	sched =3D entity->rq->sched;
> > -	/**
> > +	/*
> > =C2=A0=C2=A0	 * The client will not queue more IBs during this fini,
> > consume existing
> > =C2=A0=C2=A0	 * queued IBs or discard them on SIGKILL
>=20
> That comment is actually not correct either.
>=20
> drm_sched_entity_flush() should be used from the file_operations-
> >flush=20
> function and that one can be used even without destroying the entity.
>=20
> So it is perfectly possible that more and more IBs are pumped into
> the=20
> entity while we wait for it to become idle.

Which would just result in drm_sched_entity_flush() timing out and
effectively not having done anything, right?

I guess we could touch that topic again when writing some docu for
scheduler teardown.

Would it be the best to just remove the comment, what do you think?

P.

>=20
> Regards,
> Christian.
>=20
> > =C2=A0=C2=A0	 */
> > @@ -359,8 +356,11 @@ EXPORT_SYMBOL(drm_sched_entity_fini);
> > =C2=A0=C2=A0 * drm_sched_entity_destroy - Destroy a context entity
> > =C2=A0=C2=A0 * @entity: scheduler entity
> > =C2=A0=C2=A0 *
> > - * Calls drm_sched_entity_flush() and drm_sched_entity_fini() as a
> > - * convenience wrapper.
> > + * Convenience wrapper for entity teardown.
> > + *
> > + * Teardown of entities is split into two functions. The first
> > one,
> > + * drm_sched_entity_flush(), waits for the entity to become empty.
> > The second
> > + * one, drm_sched_entity_fini(), does the actual cleanup of the
> > entity object.
> > =C2=A0=C2=A0 */
> > =C2=A0 void drm_sched_entity_destroy(struct drm_sched_entity *entity)
> > =C2=A0 {
>=20


