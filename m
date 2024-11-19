Return-Path: <linux-kernel+bounces-414387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3979D273F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6186C1F21C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE731CCB49;
	Tue, 19 Nov 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gs1I+I6i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C2F1C4A28
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024129; cv=none; b=uvIkjX693xaytQQptaK/eU+B/RsXx+vaEfP+aAxke0WDwasE/OmZBUfylEmai42kok/nlxFqreXJHqPhhBVQUEWGFCSXG0SZKeoLz4VUh2jQuCFGe+hERk4Jvhj12U52CSz0ho+sifnksxfDO15+c6z8ecPxtQBZCQwu4xt66UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024129; c=relaxed/simple;
	bh=zXILVcZ2YZ/BwyTjtgnI8ZizZzITw8blKAJD/k75VTM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JS9ZykUfATafhNwqjZRZJVUsODzVY8ImlQ+/w8M4F7Bl+m92KNdPM5qNiPNE2o5/wDZpa0G2KaDD05wxzbcWTOX8y4mmaStJgcEyElsZEn1urdCyL/BzOZHG+zH8vi0vbnimBh8xuAj9akFPznggIE4yFjwelpQoYe9JBQpa8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gs1I+I6i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732024126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65l/Cwngry4f7Io+loOISLSnM8MxOBcTPObuT/XTVCQ=;
	b=Gs1I+I6iu7Bg//dqxJ5nTsv6vmIVjuSita5peE36AHLVeRLWtwwdleqV5GziSpxjGlZ/8q
	dfr12mGudFtC12Do6cFcK9oq41n4iQKxG4mx8q8y/7Twtl0cF4orcspDQfPODULRsCCxsC
	wOtwcR0BfizNyXyqOn+6z4c8Mt5iLPY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-3vc3l3tmOK-vm47cZrFESw-1; Tue, 19 Nov 2024 08:48:45 -0500
X-MC-Unique: 3vc3l3tmOK-vm47cZrFESw-1
X-Mimecast-MFC-AGG-ID: 3vc3l3tmOK-vm47cZrFESw
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-460d76f1d7eso59949571cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732024125; x=1732628925;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65l/Cwngry4f7Io+loOISLSnM8MxOBcTPObuT/XTVCQ=;
        b=YVxBfDATdpkmKwx4nbvHn6/eFHoOBIoP3rPqB5ow9xMGWYgP+Jp6mAX3BaTeBPVsXf
         v1uINRs76AQRTbymyFaY8B/eWJ+HcJPLk5vlyWZW0otQc5D5xZJlXEaIIxSvO2ZtCp1z
         MkGPkX+Supc8sdeOxRINfXOj1HPsY0Zj++JEw/IHzqQUji3ADaSC8KUHuXU8O9lXo9Ul
         zFhizbZzMsvloULKr0jLv6+cVrAEq7QP4PAqar5fvfXC+jfTPxE9RqVdmfeTRN1S2LFJ
         9Q16hoWB8lSjCKM/lomzYv23jozIFtc1pXgUiF4d9UT5igANxwiPx85S8oO+A6hfI7TM
         Wtug==
X-Forwarded-Encrypted: i=1; AJvYcCWrRXvSVXfvhGmeOiGd8/mM/SCX/j/nPB6H18KSEhMhNzPoff/Ue6OLPFKQrNTnoBlBR5WFaldc1aOpq+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpuYliz4aRcM5tmMmV7ZmwnuqS894rqNn8TXf4p0VMiL2hkQJu
	LPrRJGuKj5YjrM3ZnhKXzWmbzFbk7mOFfDZ8er7D+9TxDi735mXV98VZGDT6+MQIeAizEJ9P4ef
	CpV3E86bBa59NBmgdoAnPeHUOXINLSeRn9b5K/UdDZz4kLaiyMU+vGUcnaE+JtA==
X-Received: by 2002:a05:622a:a0b:b0:463:9183:8515 with SMTP id d75a77b69052e-4639183880amr44999271cf.20.1732024125059;
        Tue, 19 Nov 2024 05:48:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCG17rOJNvWNSx6LG7CNfRqW04EtENIYOntwdaB6w9t1ggllxFUbNd8aNULsls51XAH3nL3g==
X-Received: by 2002:a05:622a:a0b:b0:463:9183:8515 with SMTP id d75a77b69052e-4639183880amr44999081cf.20.1732024124787;
        Tue, 19 Nov 2024 05:48:44 -0800 (PST)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46392b96cb6sm11208421cf.17.2024.11.19.05.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 05:48:44 -0800 (PST)
Message-ID: <75fffbf97ec274eb7b2727c9506d7aaa49b7d24e.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/sched: Fix drm_sched_entity_flush() return val
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Christian
 =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>
Date: Tue, 19 Nov 2024 14:48:41 +0100
In-Reply-To: <20241119134122.21950-2-pstanner@redhat.com>
References: <20241119134122.21950-2-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-19 at 14:41 +0100, Philipp Stanner wrote:
> The documentation of drm_sched_entity_flush() states that the
> function
> shall - always - return the remaining timeout time in jiffies.
>=20
> However, that is not what the function actually does; in one of its
> if
> branches it simply returns the unchanged timeout value.
>=20
> Furthermore, the used function wait_event_timeout() doesn't always
> return the remaining timeout time.
>=20
> Adjust the function so that it actually does what the documentation
> states it shall do.
>=20
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> @AMD:
> You guys are the only ones who use the function's return code, so I
> leave it completely up to you to decide what behavior you want.
>=20
> But we should at least do something, because right now function
> documentation and behavior do not match.
>=20
> P.
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 23 ++++++++++++++++-----=
-
> -
> =C2=A01 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> b/drivers/gpu/drm/scheduler/sched_entity.c
> index a75eede8bf8d..16b172aee453 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -278,7 +278,7 @@ static void drm_sched_entity_kill(struct
> drm_sched_entity *entity)
> =C2=A0 * waiting, removes the entity from the runqueue and returns an
> error when the
> =C2=A0 * process was killed.
> =C2=A0 *
> - * Returns the remaining time in jiffies left from the input timeout
> + * Returns: 0 if the timeout ellapsed, the remaining time otherwise.
> =C2=A0 */
> =C2=A0long drm_sched_entity_flush(struct drm_sched_entity *entity, long
> timeout)
> =C2=A0{
> @@ -294,15 +294,24 @@ long drm_sched_entity_flush(struct
> drm_sched_entity *entity, long timeout)
> =C2=A0	 * The client will not queue more IBs during this fini,
> consume existing
> =C2=A0	 * queued IBs or discard them on SIGKILL
> =C2=A0	 */
> -	if (current->flags & PF_EXITING) {
> -		if (timeout)
> -			ret =3D wait_event_timeout(
> -					sched->job_scheduled,
> -
> 					drm_sched_entity_is_idle(entity),
> -					timeout);
> +	if (timeout !=3D 0 && (current->flags & PF_EXITING)) {
> +		ret =3D wait_event_timeout(sched->job_scheduled,
> +				drm_sched_entity_is_idle(entity),
> +				timeout);
> +		/*
> +		 * wait_event_timeout() returns 1 if it timed out
> but the
> +		 * condition became true on timeout. We only care
> about whether
> +		 * it timed out or not.
> +		 */
> +		if (ret =3D=3D 1)
> +			ret =3D 0;
> =C2=A0	} else {
> =C2=A0		wait_event_killable(sched->job_scheduled,
> =C2=A0				=C2=A0=C2=A0=C2=A0
> drm_sched_entity_is_idle(entity));
> +
> +		ret -=3D (long)get_jiffies_64();

Ah, just recognized that this is probably nonsense =E2=80=93 anyways, let's
discuss what we shall do here. I can fix it later.

P.

> +		if (ret < 0)
> +			ret =3D 0;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* For killed process disable any more IBs enqueue right now
> */


