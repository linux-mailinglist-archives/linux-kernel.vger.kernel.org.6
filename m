Return-Path: <linux-kernel+bounces-390455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B21119B7A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D2A284826
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D0219C54F;
	Thu, 31 Oct 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwBr9xQ2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D819C547
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376030; cv=none; b=CbEI2R7cTcRpN6gHbUV4TDw2c4p2ZICcbTp5mYEbcOqPJOngXWoiUfC6p8+JFPlRNck3XsOCYYk9fPMzU2LmredkjyevxmNoek6LWoYrdoBGC+P+LRNYC7KOjprZ5DkqrFim3y6HH6ZQ334v57YJSViZn2m79oTVrbzm7S3s9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376030; c=relaxed/simple;
	bh=bZ1Wkv2y5hOyXSNMU8yMUJKCrVE3pHsisrzh1M4yBwA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n5DPyf1Peu4Z7uMB8MzDxBMwW4NZ/rWHTqMGv9lSAoOVVimXitRtgLS/UgxrRl9V6xP5TdEY7I4f745qoFXQ2+Y2bnE6XRmr//An9Fxs31I1hCVkLHcNSDHp/k+tupG+yMwA9vqNw+VdZnAwezj+hRKnGzDkAGvOMtMZNJKQMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwBr9xQ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730376026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZ1Wkv2y5hOyXSNMU8yMUJKCrVE3pHsisrzh1M4yBwA=;
	b=KwBr9xQ2XJ12oABKAntwXO74V/q9/JB485J3hocWVpABav4Bfkz7YPg8bWFePzQMPSdAzM
	skt4jkD/6QyXScC2W0XO4YYcksFXEMX+Q4hPea10pqcjGSYhEyOhQg/dtVU5nVRf7HoxJw
	LmY8pWibIi0hYl3+XHqcu4XY60BIH9I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-HhodWh9wNqmAsy9mdvEfKw-1; Thu, 31 Oct 2024 08:00:25 -0400
X-MC-Unique: HhodWh9wNqmAsy9mdvEfKw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c94273656cso635592a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730376024; x=1730980824;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZ1Wkv2y5hOyXSNMU8yMUJKCrVE3pHsisrzh1M4yBwA=;
        b=NNVbu5LccuTefh7Yw9Ldf6Xta5U0nGEhGO3yin3AclcEbdmcuy5QKp/ko5Tug0S8zC
         i226yY5x3b6McvMRhsRhqDQRbj7VWzU1z1iL12FrGFkITiAFM2Tl4+EGiIsxSekh1PJ2
         ytfceVVhSfWZ4u/fAXId1Ao1VNysA2xZVXpHhF6dRN03YX4dySDHs7V8oOe0m1zFdptT
         HoAAaYKQxKpLMXzuvvPjmgDVczvmXOgijwO5a4CiwEtcRPmDUy6e7Mmf0eXhSep1oKgN
         lxYMX99q9iYEHsbFSfAggaOGeqni+czzRoHhxUs1UjLVMi+XZq/nzQKMZdjWQA814vYI
         GhJg==
X-Forwarded-Encrypted: i=1; AJvYcCV+nHJNGyW3gHFjy1CzQKw51Ow/8cfXpivPdBXOg0dwxELF1uOFJng0AFDPWHKOcuYIN83dRh0lFgk7Kqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLaCMxA9u18zfv2jnfJPIKoGDEn0diz+NiZQDoOHscEPglFeJ
	iX2okXIJbr7OnTKqUnf4SVIL4ffkJqk1dOPhBALSjB7KxRyKgpT3jlzoJgVzdTQRCv5U+cWSxFw
	rEgChC4kqul+Jz8EZcWj/LtaP6KCAS8rqAQTi1QI8o56XdLpG2ej+TSCbZhlFow==
X-Received: by 2002:a17:907:2cc7:b0:a99:d308:926 with SMTP id a640c23a62f3a-a9de632d0a5mr1758341966b.57.1730376024116;
        Thu, 31 Oct 2024 05:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFpE9tArG9ajQFaXYehLBUGhTeOySH2DT2Xvm3yTbIxhKdxMUCsAPQCRR61XrroNr7ktVXMA==
X-Received: by 2002:a17:907:2cc7:b0:a99:d308:926 with SMTP id a640c23a62f3a-a9de632d0a5mr1758338266b.57.1730376023652;
        Thu, 31 Oct 2024 05:00:23 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56496c69sm60828766b.45.2024.10.31.05.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:00:21 -0700 (PDT)
Message-ID: <ae9291f0cad3e61531304c6cced31a967d5a70f9.camel@redhat.com>
Subject: Re: [PATCH] drm/sched: Document purpose of drm_sched_{start,stop}
From: Philipp Stanner <pstanner@redhat.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin
 <tursulin@ursulin.net>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 31 Oct 2024 13:00:19 +0100
In-Reply-To: <CADnq5_NNnQvLG+dmj+RLijxAOg0jEuih+dqc3tin2EiK5jf2_g@mail.gmail.com>
References: <20241029133819.78696-2-pstanner@redhat.com>
	 <CADnq5_NNnQvLG+dmj+RLijxAOg0jEuih+dqc3tin2EiK5jf2_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-29 at 09:47 -0400, Alex Deucher wrote:
> On Tue, Oct 29, 2024 at 9:39=E2=80=AFAM Philipp Stanner <pstanner@redhat.=
com>
> wrote:
> >=20
> > drm_sched_start()'s and drm_sched_stop()'s names suggest that those
> > functions might be intended for actively starting and stopping the
> > scheduler on initialization and teardown.
> >=20
> > They are, however, only used on timeout handling (reset recovery).
> > The
> > docstrings should reflect that to prevent confusion.
> >=20
> > Document those functions' purpose.
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>=20
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Thanks.

Applied to drm-misc-next.

P.

>=20
> > ---
> > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 8 +++++++-
> > =C2=A01 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > b/drivers/gpu/drm/scheduler/sched_main.c
> > index eaef20f41786..59fd49fc790e 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -601,6 +601,9 @@ static void drm_sched_job_timedout(struct
> > work_struct *work)
> > =C2=A0 * callers responsibility to release it manually if it's not part
> > of the
> > =C2=A0 * pending list any more.
> > =C2=A0 *
> > + * This function is typically used for reset recovery (see the
> > docu of
> > + * drm_sched_backend_ops.timedout_job() for details). Do not call
> > it for
> > + * scheduler teardown, i.e., before calling drm_sched_fini().
> > =C2=A0 */
> > =C2=A0void drm_sched_stop(struct drm_gpu_scheduler *sched, struct
> > drm_sched_job *bad)
> > =C2=A0{
> > @@ -673,7 +676,6 @@ void drm_sched_stop(struct drm_gpu_scheduler
> > *sched, struct drm_sched_job *bad)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cancel_delayed_work(&sched->=
work_tdr);
> > =C2=A0}
> > -
> > =C2=A0EXPORT_SYMBOL(drm_sched_stop);
> >=20
> > =C2=A0/**
> > @@ -681,6 +683,10 @@ EXPORT_SYMBOL(drm_sched_stop);
> > =C2=A0 *
> > =C2=A0 * @sched: scheduler instance
> > =C2=A0 *
> > + * This function is typically used for reset recovery (see the
> > docu of
> > + * drm_sched_backend_ops.timedout_job() for details). Do not call
> > it for
> > + * scheduler startup. The scheduler itself is fully operational
> > after
> > + * drm_sched_init() succeeded.
> > =C2=A0 */
> > =C2=A0void drm_sched_start(struct drm_gpu_scheduler *sched)
> > =C2=A0{
> > --
> > 2.47.0
> >=20
>=20


