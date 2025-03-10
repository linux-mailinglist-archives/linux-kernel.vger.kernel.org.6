Return-Path: <linux-kernel+bounces-554171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEAFA593FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF7A1893229
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7322C221711;
	Mon, 10 Mar 2025 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sRsn1XEo"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1C226883
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608717; cv=none; b=P6Z/2Wa6iNSj+kjha/81QfjYZthxbSG+F3qI22ZQnzcvAIGYYOo8R+qodRG+QPdS/lXH2mDqdVKzlmvW7ekxzJf/8Za+dxaSWq5edichZbgu1h+ztPVAQxHy04gR09mJWiuyAfnNTgqiOvQP17xEz8KFH1M/I6unHTrV53hz5+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608717; c=relaxed/simple;
	bh=lRyHXz+LuENfiDMmXLMZdZ86UvemQwdeC11FX1GNOvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TYoK/vWGMkWlIJkgbq3I+4z34/NDextrvEwfJTGu0Y25tRlAxczYT5Y5KuokPQI/ZUYvIRLY0PNAMXmkWKfy4olfMG5dO+dil2cOX7BngorV1+TuC0nyyJTH8po6oBVGvuVatmBHM+NessRZVIuvBCwnLKHPgcOuvCi/TfdFi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sRsn1XEo; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZBG362TqBz9t2Y;
	Mon, 10 Mar 2025 13:11:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741608706; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0KQeJP11TRsGnnF9TEWR0bRSiGYKMMWItDUAR+7anCI=;
	b=sRsn1XEoXCcyYaP7paUfvZOOVPklB8u+QbTvZOsREmB8E/dsUaKSgPucRPf9fYCAT1hR0J
	rtzdV8frPEwiRXvf2POHaB3F3uNHEkVmpajY1tyF06itefQZCcVRbK4QA2NlUdwmHCtnzN
	Re9tkzM745VUEMnTgEn5iZCglwLCF4S5M1ypzTekXVB2iiox0AnTNATuQuhfEy5uz6updC
	2AR3Uvob8LFkwPV9zSfmZB0JOwpmr52krmSXMFBpsBrYYBXk1xH++JWa4lTRoAEeUfAXav
	W222yx8MJmIG2kGS5B5d01IytzH82gP2Av3ZtBzO8tKNjmnGqNo6KwQUns+AcQ==
Message-ID: <564be70f7d64c04c1ad77499522d99c64ea4d4d3.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: revert "drm_sched_job_cleanup(): correct
 false doc"
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	matthew.brost@intel.com, dakr@kernel.org, phasta@kernel.org, 
	tvrtko.ursulin@igalia.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Date: Mon, 10 Mar 2025 13:11:42 +0100
In-Reply-To: <20250310074414.2129157-1-christian.koenig@amd.com>
References: <20250310074414.2129157-1-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 740eeb2eb4d9f368cbb
X-MBO-RS-META: ti7n3cbhidtzec16mz4bdwaqw3ficnr7

On Mon, 2025-03-10 at 08:44 +0100, Christian K=C3=B6nig wrote:
> This reverts commit 44d2f310f008613c1dbe5e234c2cf2be90cbbfab.

OK, your arguments with fence ordering are strong. Please update the
commit message according to our discussion:

>=20
> Sorry for the delayed response, I only stumbled over this now while
> going
> over old mails and then re-thinking my reviewed by for this change.

Your RB hadn't even been applied (I merged before you gave it), so you
can remove this first paragraph from the commit message

>=20
> The function drm_sched_job_arm() is indeed the point of no return.
> The
> background is that it is nearly impossible for the driver to
> correctly
> retract the fence and signal it in the order enforced by the
> dma_fence
> framework.
>=20
> The code in drm_sched_job_cleanup() is for the purpose to cleanup
> after
> the job was armed through drm_sched_job_arm() *and* processed by the
> scheduler.
>=20
> The correct approach for error handling in this situation is to set
> the
> error on the fences and then push to the entity anyway. We can
> certainly
> improve the documentation, but removing the warning is clearly not a
> good
> idea.

This last paragraph, as per our discussion, seems invalid. We shouldn't
have that in the commit log, so that it won't give later hackers
browsing it wrong ideas and we end up with someone actually mengling
with those fences.

Thx
P.

>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 12 +++++-------
> =C2=A01 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index 53e6aec37b46..4d4219fbe49d 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1015,13 +1015,11 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
> =C2=A0 * Cleans up the resources allocated with drm_sched_job_init().
> =C2=A0 *
> =C2=A0 * Drivers should call this from their error unwind code if @job is
> aborted
> - * before it was submitted to an entity with
> drm_sched_entity_push_job().
> + * before drm_sched_job_arm() is called.
> =C2=A0 *
> - * Since calling drm_sched_job_arm() causes the job's fences to be
> initialized,
> - * it is up to the driver to ensure that fences that were exposed to
> external
> - * parties get signaled. drm_sched_job_cleanup() does not ensure
> this.
> - *
> - * This function must also be called in &struct
> drm_sched_backend_ops.free_job
> + * After that point of no return @job is committed to be executed by
> the
> + * scheduler, and this function should be called from the
> + * &drm_sched_backend_ops.free_job callback.
> =C2=A0 */
> =C2=A0void drm_sched_job_cleanup(struct drm_sched_job *job)
> =C2=A0{
> @@ -1032,7 +1030,7 @@ void drm_sched_job_cleanup(struct drm_sched_job
> *job)
> =C2=A0		/* drm_sched_job_arm() has been called */
> =C2=A0		dma_fence_put(&job->s_fence->finished);
> =C2=A0	} else {
> -		/* aborted job before arming */
> +		/* aborted job before committing to run it */
> =C2=A0		drm_sched_fence_free(job->s_fence);
> =C2=A0	}
> =C2=A0


