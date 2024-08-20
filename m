Return-Path: <linux-kernel+bounces-293773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81286958458
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987751C2484A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC3018E751;
	Tue, 20 Aug 2024 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzOFhktJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D846618E05D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149437; cv=none; b=r6/w2oAbV1JWBgHhOGF6/KjLFNk2Ms45x5V0xtgARsQaK2afoHZcd/VRFErrvQ1tOTLLSjvXUhQ+lXk02Pkwp/O2F3/tSfKFKuznWZKj5NJEFxnciT2ApMs4TgwI3jX9hIovp7vzoDVatLoCCKn9j/hwlcgNnoM7I5936vI80hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149437; c=relaxed/simple;
	bh=sgjoWme/lDn+Q/8TVo3OKeWkzEm1yKNOHyGkJneQNEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lxXc0Ji8tmb2QvrtUOws8cHu7CPosrIZFH1StWi4KLv+YTiMl53Y1P2zwISbhbIbEJnPxqxHQl0L0ppGSNhpHWy9QCULHzNsODnlcTQxBKxhsQ6gVoZl4aRSNx2wfSiQXpimRpbi5EO+ULk7QA6NAJEnnbMPboPEDsF/JF7dnOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzOFhktJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724149434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4c+7fu/VdEpjhH3XMlyk8gLAqXF7DZDZmgZbuAUUV0=;
	b=RzOFhktJ/g8V7cn/1TNtPxqd4k+fuWMik8M4+6rjYUmJJI99kdmgp9aabjKzE4tON7rUKn
	+WzNuX35ZmW/TwdcFhQc5m4WNWYbyyI5/8y5l6g9S0c88tZ+JRBMqx+G5N3rd8RUFPrbfy
	GEOrddjvwJpLDx8Ld3mRw3kMrfV4ZPc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-E2QJQRyxOZShXRfY5yGHYg-1; Tue, 20 Aug 2024 06:23:53 -0400
X-MC-Unique: E2QJQRyxOZShXRfY5yGHYg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f3f2bf2738so288331fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149432; x=1724754232;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4c+7fu/VdEpjhH3XMlyk8gLAqXF7DZDZmgZbuAUUV0=;
        b=Ch19W7vk0t25vKg1FzkHcxF3Io97WwdzYo4WeDI+8IxqQ33OC9yL2amHpwgs958OQO
         NCg5PNFj+6OxAVafJ35YuhP8PBPqV0+dKgjJwvVUPrvbJqCEjfqQ+OxO0Wq9zV+icLYe
         u7XUq1tzGun36aVszghFT9t6UHZhsK0l9c9HThk2Td6Ms/+bIwHquENXYO7xSI+EKl3z
         /Adbkq4gIBOKyKVc/HLj3UF/ZtYkW6fJ2jHRXF7B/jjzxb0HRMdQCQb2RxvAuNbd2xaJ
         FFb3wBwzLZI5unSTdvfJuIWPsBrEon+rtcraopBTFxup+SItNysdEM3cfmuq5Vp/XZuM
         Klkg==
X-Forwarded-Encrypted: i=1; AJvYcCUBKjC9SUo8D7gmHpCzAN8MjOwvw6QkQ0S49QMfSyrOrBc2OqF0x3oeWoNufqSYyMmqyKEtKL0Pq+NNFrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWsdK37nxkgXbxpgP4Aqaw5UpckOUF9D8N3M+m49eMAHLAyCdY
	HV6JYdlwcftz4Gi4ZAYj6Rb8ySUYkyw09RN31p+1cU2KbtSbTX8UN464kBIRKN/Bb9xlPrvb/sv
	2GKFpCU4auC/CjXVnGvDQynXurM70a4q8dca8/c1Bgw6JHoJvR0l1gDxoI1hIMg==
X-Received: by 2002:a2e:bc20:0:b0:2f1:929b:af00 with SMTP id 38308e7fff4ca-2f3be5eaebbmr55822171fa.5.1724149431659;
        Tue, 20 Aug 2024 03:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKOBhR4ojLfA+j+V5ryjxkELVaKf/dDRfbA6pDJgghg5Ap7oA8FDtLoCFdCUzkszAjQ4sRng==
X-Received: by 2002:a2e:bc20:0:b0:2f1:929b:af00 with SMTP id 38308e7fff4ca-2f3be5eaebbmr55822061fa.5.1724149431052;
        Tue, 20 Aug 2024 03:23:51 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c69easm747601766b.40.2024.08.20.03.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:23:50 -0700 (PDT)
Message-ID: <46046055be8fcf29949d36778bdb4ee7a7b6ed67.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/sched: memset() 'job' in drm_sched_job_init()
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost
 <matthew.brost@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich <dakr@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Aug 2024 12:23:49 +0200
In-Reply-To: <20240806143855.29789-2-pstanner@redhat.com>
References: <20240806143855.29789-2-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

*PING*


On Tue, 2024-08-06 at 16:38 +0200, Philipp Stanner wrote:
> drm_sched_job_init() has no control over how users allocate struct
> drm_sched_job. Unfortunately, the function can also not set some
> struct
> members such as job->sched.
>=20
> This could theoretically lead to UB by users dereferencing the
> struct's
> pointer members too early.
>=20
> It is easier to debug such issues if these pointers are initialized
> to
> NULL, so dereferencing them causes a NULL pointer exception.
> Accordingly, drm_sched_entity_init() does precisely that and
> initializes
> its struct with memset().
>=20
> Initialize parameter "job" to 0 in drm_sched_job_init().
>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> Hi all,
> I did some experiments with the scheduler recently and am trying to
> make
> the documentation and bits of the code more bullet proof.
>=20
> I tested the performance of v6.11-rc2 with and without this memset()
> by
> creating 1e6 jobs and found no performance regression.
>=20
> Cheers,
> P.
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index 76969f9c59c2..1498ee3cbf39 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -936,6 +936,14 @@ int drm_sched_job_init(struct drm_sched_job
> *job,
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> +	/*
> +	 * We don't know for sure how the user has allocated. Thus,
> zero the
> +	 * struct so that unallowed (i.e., too early) usage of
> pointers that
> +	 * this function does not set is guaranteed to lead to a
> NULL pointer
> +	 * exception instead of UB.
> +	 */
> +	memset(job, 0, sizeof(*job));
> +
> =C2=A0	job->entity =3D entity;
> =C2=A0	job->credits =3D credits;
> =C2=A0	job->s_fence =3D drm_sched_fence_alloc(entity, owner);


