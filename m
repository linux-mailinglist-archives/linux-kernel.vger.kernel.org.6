Return-Path: <linux-kernel+bounces-315199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F896BF1F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8330A1F22C3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483F41DB929;
	Wed,  4 Sep 2024 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2e0yVa3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC791DB549
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458023; cv=none; b=PlBb0e8ZNgkAOUUU3v3QsZnuVM9JlPyd267LehP6NS4sS1fLDX56YePBJ8qsFtEdNVgxsD/1jdZVXRLhNBS+hrxXedf1yEq7GXB4IPIkNeliCdpKHZUzWtAPkKlAEhqI5xP/PEnm5V+XAze/ZR55pIQG5HeqB6jXSEeEpWfh0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458023; c=relaxed/simple;
	bh=44uTRfQh3mGYP8B1H4JjOMoWTxH+BsW4ksbJZzf5lvk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKY3q0+bK30pYhTvzFCUh9IkKLnXidv0APtSFWjb1I6drZJ1jhZd1rbUZJSVuB+UF7lzYRPbAnmEg+ly4mgQRGWFroGBl9dXSg4i7ePty2Dmw/B1FLRwgcujYcoiIiSmF2Qb+8F/53hc5WdISrf10Gfbc2lfyhC1FLLJH/1SRDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2e0yVa3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725458021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6s7mSLff5Fx2lCcACgllmx5s4/lYVbOw6buFq6F9Ko=;
	b=L2e0yVa3AGikkXdtWLF0BdhjKytm1m+FevcCb6BYh8+I6t5HUt8YOPTO8AwGigqSZ2oUR1
	qe4hvOmtKSmmQfqDRhfV7rSwcoSbp3ecvMHNDKpRQlogw5nTCPEss/kKdlvEjoqwLnvV48
	FTWaGeDyuFDZ8lbewX28LkAsMiQzgtI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-bjUfhihYNjqESbidcqYzjA-1; Wed, 04 Sep 2024 09:53:39 -0400
X-MC-Unique: bjUfhihYNjqESbidcqYzjA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bb8610792so57305585e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458018; x=1726062818;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6s7mSLff5Fx2lCcACgllmx5s4/lYVbOw6buFq6F9Ko=;
        b=dPp+9rlGs9sdqa2r+aqjlWuSTEBEt8Bjc42o5rqOH5UuWcOdwSW3nbg0wbasnXcHbO
         /brwJ3HDSWxTT7PiQ2ERguDqzCRAu7MT3IzAlx99zd8F26De5ZX9xqnrDtT+wgEdEuj1
         uGHDeHeErRsDms0vYESg+Xvze7gH+6cv4RxUM7VxB6H2w/JVAc9Z84aCZGsUUsANIwyQ
         Wa+lMBKtABtUAOaAOtzdTXt2xf5a1JkxOVLvUQGQFpH8WEnpDz9o5FpteSDCeoFWSK58
         udpsEdSxdnW7BevqJEywyA0uMD6UZ4XcZU8ccQxFwBaYc24iVgpAQuidyeQHLo09K7Mz
         /vbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6nMzU7PfxzUlVIOjExQI/tmkCuO8DzGhXICwE5aWiumA2+2Mrw8vbpoKU0ilPmvyub2mNVqfme2+yzHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzriX2elCpPkbo7HJw/gzxrQCC7DSMhYpM7fqCy3DRSquG3n8+
	Di8MIzgjiNd+9gKG3AEhjGn1Tyvrd4REupTEusQr4usJoN11BzkWBjj8nBezNBjsz5BHHVrTx24
	mhfZynfg/9eodJyAGrOZBboZ4jol/1Ip4XV25kKczpUDlyr0S2qSYLvTMmc0xPA==
X-Received: by 2002:a05:600c:4f8d:b0:428:141b:ddfc with SMTP id 5b1f17b1804b1-42bb27ba52fmr157264505e9.31.1725458018353;
        Wed, 04 Sep 2024 06:53:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9ijUN8wT10YCyzoKWOwwK6w8xcew+tlWHT205xIpdmoUUr1JAfUAQERxJcuN3H2kNSxo6bQ==
X-Received: by 2002:a05:600c:4f8d:b0:428:141b:ddfc with SMTP id 5b1f17b1804b1-42bb27ba52fmr157264245e9.31.1725458017798;
        Wed, 04 Sep 2024 06:53:37 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df100csm204091135e9.20.2024.09.04.06.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:53:37 -0700 (PDT)
Message-ID: <74a7e80ea893c2b7fefbd0ae3b53881ddf789c3f.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] drm/sched: memset() 'job' in drm_sched_job_init()
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost
 <matthew.brost@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich <dakr@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Sep 2024 15:53:36 +0200
In-Reply-To: <20240828094133.17402-2-pstanner@redhat.com>
References: <20240828094133.17402-2-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Luben? Christian?

On Wed, 2024-08-28 at 11:41 +0200, Philipp Stanner wrote:
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
> No changes in v2.
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index 356c30fa24a8..b0c8ad10b419 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -806,6 +806,14 @@ int drm_sched_job_init(struct drm_sched_job
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


