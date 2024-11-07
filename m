Return-Path: <linux-kernel+bounces-399574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AE29C00F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1901F22DEB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D711DC05D;
	Thu,  7 Nov 2024 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAs6bZQI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76E126C01
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971091; cv=none; b=SVXDatpXjvVan38hiCSVxS73wsUZM3wdv2UTxIzmWalfOuEewubkp4qJOxRWt/b548HI7oFfpqnIFsNfWLaVEbjjokIcAE2cJefPRMAEQAejgAsrs7Qqbl42MAI8f8CcW4tXKwXCEkKbIbilqZRfyJyHqQTP99wyoree+lkpDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971091; c=relaxed/simple;
	bh=CmVphk5HnzRr9iFL/NZcM2i71JfryJy3cZgbIgsnpNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bLNUKh21B86DJJ9cjfaeTq6a+Qwlm/X8/mdffLAvmWSTD48o22l/ZBcjgHI4WHFjReqGArO3HQ/Ca8Yp698DGIQ4zkospZSS6vCZ+018xFK8RDSANyluUuRw2SBKjCalcsWfs7cm+XxwzY9eSDjRk3/6eg+Seh9/Y6P+3zanZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAs6bZQI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730971087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmVphk5HnzRr9iFL/NZcM2i71JfryJy3cZgbIgsnpNw=;
	b=ZAs6bZQIWFOI87WhWZ7H+Ki54oKFh65AoLB+iGMMwAYq+dn+xG4wQZe1iokvtEsYYjsg3o
	yAQKWtGNqHfBgo7fDzxHdDVNELQpO01A8HLARn9Upk4vCfx19Hv9JnNQ55/kYYNs5nVtQT
	h8TRX7RtvZJ5HZ26xp4HBRZxAgl8djM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-hBplO9iOONK35XXa5FCHNQ-1; Thu, 07 Nov 2024 04:18:06 -0500
X-MC-Unique: hBplO9iOONK35XXa5FCHNQ-1
X-Mimecast-MFC-AGG-ID: hBplO9iOONK35XXa5FCHNQ
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7181ca4eca5so782364a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 01:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730971086; x=1731575886;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmVphk5HnzRr9iFL/NZcM2i71JfryJy3cZgbIgsnpNw=;
        b=oYobu4NM1k3qpXhPY3YcEmh09/MDufwfO8rL5IKxZsJRpTxaDTL+FOHTJe1MM3MqAq
         v9ZsMEbN0/3mfk2rYHKrS37tBD5VUm0o17oeap56UNEhkV8D6jdQ57sCaj75DNtqMc4a
         u7DE6QKYX27uSlE9+DalwVhGgCdrloG4M7I12ljBzL/aLQm9FQmsc9ixxbClDNIzoafb
         hYkL1RkphMX5A1ZOR0jvegqIG8ublQYx7EyWBF1XfiRIt12UkRuKaWc9szAqs1I2C+Ly
         TgxE89ui0T0pE5Rz7QQ0stlMg1zS2+qGRSnPM6/Qs4cgqk2HsEs3c7pk+z8HdqXUp0Oq
         F/fA==
X-Gm-Message-State: AOJu0YwGpHqse+9W6ys2s4jelbrB2jJnNadBtw5p3oMV83VWF6qW4yur
	0CEOJZ2NAZ6h/Py+O1xJMM4agyjEwlo0HR32DAgMLagdLA1+jx3EAUuwZgWAMS+79f9Yjxi5woh
	SfbGODAgVLk+hVcCfCkwhEFe7YAnAIg/IZaWzqlmYC1XyYO9qNpFTCJ9FoNYrpQ==
X-Received: by 2002:a05:6871:7a5:b0:270:4d48:6be2 with SMTP id 586e51a60fabf-29051c581bemr38495147fac.26.1730971085919;
        Thu, 07 Nov 2024 01:18:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxVuDCN+kUd2BLd1VEmyXUjRDGkSSx/KgtfiR0mwWkoNFmy2UU8+iWUjMXBXD7zPGbuSVtYw==
X-Received: by 2002:a05:6871:7a5:b0:270:4d48:6be2 with SMTP id 586e51a60fabf-29051c581bemr38495122fac.26.1730971085599;
        Thu, 07 Nov 2024 01:18:05 -0800 (PST)
Received: from [10.32.64.113] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546ce5938sm253621fac.20.2024.11.07.01.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:18:05 -0800 (PST)
Message-ID: <1c27295862e10dd958c01ef3ab5ef2f3757e446b.camel@redhat.com>
Subject: Re: [PATCH] drm/sched: Improve teardown documentation
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin
 <tursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date: Thu, 07 Nov 2024 10:18:01 +0100
In-Reply-To: <20241105143137.71893-2-pstanner@redhat.com>
References: <20241105143137.71893-2-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-05 at 15:31 +0100, Philipp Stanner wrote:
> If jobs are still enqueued in struct drm_gpu_scheduler.pending_list
> when drm_sched_fini() gets called, those jobs will be leaked since
> that
> function stops both job-submission and (automatic) job-cleanup. It
> is,
> thus, up to the driver to take care of preventing leaks.
>=20
> The related function drm_sched_wqueue_stop() also prevents automatic
> job
> cleanup.
>=20
> Those pitfals are not reflected in the documentation, currently.
>=20
> Explicitly inform about the leak problem in the docstring of
> drm_sched_fini().
>=20
> Additionally, detail the purpose of drm_sched_wqueue_{start,stop} and
> hint at the consequences for automatic cleanup.
>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Got an off-list (mail from dri-devel apparently got lost) RB from
Christian.

Applied to drm-misc-next.

P.

> ---
> Hi,
>=20
> in our discussion about my proposed waitque-cleanup for this problem
> Sima suggested [1] that we document the problems first and by doing
> so get
> to a consenus what the problems actually are and how we could solve
> them.
>=20
> This is my proposal for documenting the leaks on teardown. Feedback
> very
> welcome.
>=20
> P.
>=20
> [1]
> https://lore.kernel.org/dri-devel/ZtidJ8S9THvzkQ-6@phenom.ffwll.local/
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 23 +++++++++++++++++++++--
> =C2=A01 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index e97c6c60bc96..3dfa9db89484 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1333,6 +1333,19 @@ EXPORT_SYMBOL(drm_sched_init);
> =C2=A0 * @sched: scheduler instance
> =C2=A0 *
> =C2=A0 * Tears down and cleans up the scheduler.
> + *
> + * This stops submission of new jobs to the hardware through
> + * drm_sched_backend_ops.run_job(). Consequently,
> drm_sched_backend_ops.free_job()
> + * will not be called for all jobs still in
> drm_gpu_scheduler.pending_list.
> + * There is no solution for this currently. Thus, it is up to the
> driver to make
> + * sure that
> + *=C2=A0 a) drm_sched_fini() is only called after for all submitted jobs
> + *=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_backend_ops.free_job() has been cal=
led or that
> + *=C2=A0 b) the jobs for which drm_sched_backend_ops.free_job() has not
> been called
> + *=C2=A0=C2=A0=C2=A0=C2=A0 after drm_sched_fini() ran are freed manually=
.
> + *
> + * FIXME: Take care of the above problem and prevent this function
> from leaking
> + * the jobs in drm_gpu_scheduler.pending_list under any
> circumstances.
> =C2=A0 */
> =C2=A0void drm_sched_fini(struct drm_gpu_scheduler *sched)
> =C2=A0{
> @@ -1428,8 +1441,10 @@ EXPORT_SYMBOL(drm_sched_wqueue_ready);
> =C2=A0
> =C2=A0/**
> =C2=A0 * drm_sched_wqueue_stop - stop scheduler submission
> - *
> =C2=A0 * @sched: scheduler instance
> + *
> + * Stops the scheduler from pulling new jobs from entities. It also
> stops
> + * freeing jobs automatically through
> drm_sched_backend_ops.free_job().
> =C2=A0 */
> =C2=A0void drm_sched_wqueue_stop(struct drm_gpu_scheduler *sched)
> =C2=A0{
> @@ -1441,8 +1456,12 @@ EXPORT_SYMBOL(drm_sched_wqueue_stop);
> =C2=A0
> =C2=A0/**
> =C2=A0 * drm_sched_wqueue_start - start scheduler submission
> - *
> =C2=A0 * @sched: scheduler instance
> + *
> + * Restarts the scheduler after drm_sched_wqueue_stop() has stopped
> it.
> + *
> + * This function is not necessary for 'conventional' startup. The
> scheduler is
> + * fully operational after drm_sched_init() succeeded.
> =C2=A0 */
> =C2=A0void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched)
> =C2=A0{


