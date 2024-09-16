Return-Path: <linux-kernel+bounces-330330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00520979CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328E21C22A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB80113D24E;
	Mon, 16 Sep 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVoe4TcT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB013B584
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474890; cv=none; b=Pfv1bqAdEwYYoXhQFnKrbcV16lRwgWZpDHAoUhTYJze7QZXdSX9KDHeEG16mYGtiDxw4X30RL93AmOza13Jbog8atBH6Tfg6unieusuRydUKMW4jUW/PSq63qU5ngI1PbJ8y3G1yFZjQri83pA+zFfPZm0h1bvsmP658mVfv7Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474890; c=relaxed/simple;
	bh=G6mRcFwaW7TB9sC9h12lV3DL1z5V3N4hqtnc/y3dPGo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uV52j5PLztKvdBWz0cEgayiCUM7K/gAsDVrd4Jn3c4URO8FQ1aBYloBIXfkqjDXRw9BQ7QilEppB5d8EA2UNhoh7jsr5pDIfrDgM3+M0FyTSiz0djmObqBZKSTfjJN+m9IlpBhbtF0yZDZS/UPRoc8EDZGC/jXkq656QjDlCkq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVoe4TcT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726474887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3/FsoUNpdbZvFxXTUHch0otbiSCpqZ5CsjrSqVtRX0=;
	b=aVoe4TcTQKkacgkK+gLrsZ1tJFRa5w2+2iZHz+5p5NUKKRCfleR0f7/BrSwHKojE//9IAs
	BoOu8vlyw8rKpArE8UkK5P3z7tAVwg1Rud6VnwdlgkjS1ncCoaYXxW5/kLj8WjBpg966F6
	QFoITfXxsR0aV4o6s0LgUuBvDoXRRWg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-h1GwHAQsM3SmQfQp_2n0RA-1; Mon, 16 Sep 2024 04:21:25 -0400
X-MC-Unique: h1GwHAQsM3SmQfQp_2n0RA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8d13a9cc7aso240518366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474884; x=1727079684;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3/FsoUNpdbZvFxXTUHch0otbiSCpqZ5CsjrSqVtRX0=;
        b=rasZeXeY2z/U81wsGKxjOFmauHyn+rAWsldAi3k++xIy192uexjuJHr5FFt4MoWULQ
         VZgRIwwimHJAI42lGsc9/o0FAMMzcos1xWKuPjjmFWukSJQYSuhZOKEN7GeyYGsrPtaV
         tGcdE9Cheir7IP5/sCCBJos3kB9nwfP0RX+K4PoKj1AJxhld23mYI8s+bl8lPsJrcI2R
         w5joGvlU4XL3m168S7lKQG0L+HZd4Wj7DkSbmFlyfQXZjtg9W8CsaV3RlL5RBUParr8O
         Gc6EndSJQSkw6OG57Y9i7X0j952bqSVFp+4pxWH96D0+5KA1lM+9xO2Tf5DwHmIAUPXi
         S5xQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0pyGuzfPJrCCmQkn9nuozzYiiM3B0N2BO1WI1MJE/W+nBZv2ulVy6Cs2iyMbca+jgJVYtiCBK9qDbxOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl5pNaLRfwe1mk/diEt/h0HvdR/xPjyKlnLJB49nfrFKv5gyFu
	I0v0WN7jdkB7215TSZO29bXmI70ORzL/x8DHzT9+ybb7vyp+Nj7DdRZJgjEGAOQli2rAXBUCbyw
	c/pXd5fQwG2jv7ocqDzM2L/07PRpKhYKhOdMAzSEAOQ4PtmKXJvff062oyzfLtA==
X-Received: by 2002:a17:907:f702:b0:a86:a1cd:5a8c with SMTP id a640c23a62f3a-a902947e862mr1415375366b.22.1726474883669;
        Mon, 16 Sep 2024 01:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwjkLAzoObUW4c3mc0WAeK/bTDd43w0S2eUYRtFPS1IZ8mDF/cS75L0ifmjNwkV04cwgfICA==
X-Received: by 2002:a17:907:f702:b0:a86:a1cd:5a8c with SMTP id a640c23a62f3a-a902947e862mr1415371766b.22.1726474883086;
        Mon, 16 Sep 2024 01:21:23 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d97:9600:c4de:e8e2:392:1c61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90613316c2sm276557766b.211.2024.09.16.01.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:21:22 -0700 (PDT)
Message-ID: <2cdde083ae0c3a84eee435968155d9b2b8f91f91.camel@redhat.com>
Subject: Re: [PATCH] drm/sched: Fix dynamic job-flow control race
From: Philipp Stanner <pstanner@redhat.com>
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Rob Clark <robdclark@chromium.org>, Asahi Lina <lina@asahilina.net>, 
 Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost
 <matthew.brost@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich <dakr@redhat.com>, open
 list <linux-kernel@vger.kernel.org>
Date: Mon, 16 Sep 2024 10:21:21 +0200
In-Reply-To: <20240913165326.8856-1-robdclark@gmail.com>
References: <20240913165326.8856-1-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-13 at 09:53 -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>=20
> Fixes a race condition reported here:
> https://github.com/AsahiLinux/linux/issues/309#issuecomment-2238968609

As Danilo suggested before, I'd put this in a Fixes: section at the
bottom and instead have a sentence here detailing what the race
consists of, i.e., who is racing with whom.

P.

>=20
> The whole premise of lockless access to a single-producer-single-
> consumer queue is that there is just a single producer and single
> consumer.=C2=A0 That means we can't call drm_sched_can_queue() (which is
> about queueing more work to the hw, not to the spsc queue) from
> anywhere other than the consumer (wq).
>=20
> This call in the producer is just an optimization to avoid scheduling
> the consuming worker if it cannot yet queue more work to the hw.=C2=A0 It
> is safe to drop this optimization to avoid the race condition.
>=20
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Fixes: a78422e9dff3 ("drm/sched: implement dynamic job-flow control")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index ab53ab486fe6..1af1dbe757d5 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1020,8 +1020,7 @@ EXPORT_SYMBOL(drm_sched_job_cleanup);
> =C2=A0void drm_sched_wakeup(struct drm_gpu_scheduler *sched,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_entity *entity)
> =C2=A0{
> -	if (drm_sched_can_queue(sched, entity))
> -		drm_sched_run_job_queue(sched);
> +	drm_sched_run_job_queue(sched);
> =C2=A0}
> =C2=A0
> =C2=A0/**


