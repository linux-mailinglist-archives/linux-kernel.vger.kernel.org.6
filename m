Return-Path: <linux-kernel+bounces-546904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD4A50066
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64DC1899A62
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7D2459C0;
	Wed,  5 Mar 2025 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fS4XQQaj"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77D24886E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180651; cv=none; b=t2OtY2Lxo13+JTr2xmuoBpHqtT3by8IsVGMviZI4jDv2BGwjy17y1BusuptzsYzPJHQbAchkQJ7t5pPzzmpo4M60p2fTmtqB0Vrt4nCga29Kg3wVEekKDzcGgWwhO8KVnqAaX7PKDszKok5/zHf1XXK5Zi/EZB5P0vmoay486QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180651; c=relaxed/simple;
	bh=WdD2fE2doVPjaQz9GJUZJaK7tAEw7PihudDpfYH+olQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZqdRaYvB/DyLjBIq1Q30NmmmLPBOZQzq5yUFsRx3U5CJw/soVsF8R1PFCyKH+DbZy+OciVDF0/hG3nOecWK/5ZQ1EouVkkp8x1SbrfpmJa8vr9RQ2wvFoReWhz1nH1V8B36sYqwLWUSpsiA+u8S3E/1VfujIs1wihdrRBbh4NCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fS4XQQaj; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z7Cl44XZDz9snt;
	Wed,  5 Mar 2025 14:17:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741180640; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUzKOWOCIhPnb+TETbrLF5OWTM2YthK9kRDKkAN5Rvc=;
	b=fS4XQQajnG1J3xe+bh4mdgY/H1BNgZf+UWH2R/iyRZTio1jo4jwko/6pYSZ9ESXL3lpEvN
	YBt64pZInW6ZVxKJ3xK5rxHNvefaSfsfgKQDDphddOC/w9gYlCFlVSEtItGJLvAB+zuyBo
	TzdRPQs2dmjQoAlPe6YDk74tKnPM2c26oRQ7l9W0lWAVB35vSy7E/yuFPcQmQEyqzA35ZP
	ZO28tbMWFxuaQn5wUPa3tz/UZgvDiEQiZz/BSRwhxLVFb1r0+S19LmiSRwmBks7sXEMyS7
	iuUHwyYav6rdNDa58gWRDWAzN1fZq+xW+xWCzf9MRh6zBmvJ5YNGN89QRgJfgg==
Message-ID: <5d645ef9fa26c0de82135755d4fa573ec409e3ef.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: drm_sched_job_cleanup(): correct false doc
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Philipp Stanner <phasta@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich <dakr@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Mar 2025 14:17:15 +0100
In-Reply-To: <20250304141346.102683-2-phasta@kernel.org>
References: <20250304141346.102683-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: a47c344584a60e8564b
X-MBO-RS-META: km497d9y37qnoo9aj9huetitu4zpkfgd

On Tue, 2025-03-04 at 15:13 +0100, Philipp Stanner wrote:
> drm_sched_job_cleanup()'s documentation claims that calling
> drm_sched_job_arm() is a "point of no return", implying that
> afterwards
> a job cannot be cancelled anymore.
>=20
> This is not correct, as proven by the function's code itself, which
> takes a previous call to drm_sched_job_arm() into account. In truth,
> the
> decisive factors are whether fences have been shared (e.g., with
> other
> processes) and if the job has been submitted to an entity already.
>=20
> Correct the wrong docstring.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Applied to drm-misc-next.

P.

> ---
> Changes in v2:
> =C2=A0 - Also adjust comment about arm inside function's body. (Tvrtko)
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 12 +++++++-----
> =C2=A01 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index c634993f1346..7e71e89cea89 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1013,11 +1013,13 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
> =C2=A0 * Cleans up the resources allocated with drm_sched_job_init().
> =C2=A0 *
> =C2=A0 * Drivers should call this from their error unwind code if @job is
> aborted
> - * before drm_sched_job_arm() is called.
> + * before it was submitted to an entity with
> drm_sched_entity_push_job().
> =C2=A0 *
> - * After that point of no return @job is committed to be executed by
> the
> - * scheduler, and this function should be called from the
> - * &drm_sched_backend_ops.free_job callback.
> + * Since calling drm_sched_job_arm() causes the job's fences to be
> initialized,
> + * it is up to the driver to ensure that fences that were exposed to
> external
> + * parties get signaled. drm_sched_job_cleanup() does not ensure
> this.
> + *
> + * This function must also be called in &struct
> drm_sched_backend_ops.free_job
> =C2=A0 */
> =C2=A0void drm_sched_job_cleanup(struct drm_sched_job *job)
> =C2=A0{
> @@ -1028,7 +1030,7 @@ void drm_sched_job_cleanup(struct drm_sched_job
> *job)
> =C2=A0		/* drm_sched_job_arm() has been called */
> =C2=A0		dma_fence_put(&job->s_fence->finished);
> =C2=A0	} else {
> -		/* aborted job before committing to run it */
> +		/* aborted job before arming */
> =C2=A0		drm_sched_fence_free(job->s_fence);
> =C2=A0	}
> =C2=A0


