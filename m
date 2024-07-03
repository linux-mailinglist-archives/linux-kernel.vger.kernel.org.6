Return-Path: <linux-kernel+bounces-239779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2C6926537
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC5AB278C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB11B17DA2E;
	Wed,  3 Jul 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DQ+TqpKz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0201DA313
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021568; cv=none; b=YbqWqrErsgzXa5gz7tH2UQ7t0lxbSeXGU848gWc/GOdMA1S2Kckw6X7Y7ETp9sOnkhx9l3jmGnKZscEVFLDobXjy0cM2QhTXZGXtlbMo3RD+L9uhe/H/UNC995rhKQjm5lb1cGm4SUcPvfOceEnDoe6qormu6XjrRQxLOIP/PMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021568; c=relaxed/simple;
	bh=rby6cMYX9h9HE3RYZ5fbbMR6VNsM8xy3EgH2Q9E2mew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWP/f8NvPdLnoj/F+7BXqvnBO5L5SaST/DYORtMx8hxASB2BkOGr8xCiLiPe2BLKmmM3whr7lEGSdK5CeZocUftFHvhhy72JZyCPD1/kXIcKyhdIzUi7RZba1UccC1jAwP7gPwAt9tpUVyTPTH6zEE148lgo6Nq1DbRz+x88hSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DQ+TqpKz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720021560;
	bh=rby6cMYX9h9HE3RYZ5fbbMR6VNsM8xy3EgH2Q9E2mew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DQ+TqpKz2ADxSXkJmHHiavyyDGAw/1wrZEkgaGYnU/O690nfcO1jrMBcEYigXtKF+
	 R6W1XLXnVow8Rp1LazP3YgKyeOLzpvq/cg3CIamxpTmQpZVfmAWF5AD10vVcA/RMfU
	 5+/mR5dmmOlwr2xE9J6E2u2XF5lTLGDHY/i0YPPwtWrv+2BUhG9VmMz1NWoeCagq6r
	 +GtJwiCFPw+jzQ0F1w9WWZdpq93j/wyVtAJWOIbh/V82P90rFiG/414/Wy59OHxddH
	 Xlg8Gh8foMSDOq4o8DJAemZADRa99dSPMRBeVgmO/wixFM8faEZ8D+AH4B35Y41RiY
	 +ujL6+KDDqCDA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F37113782039;
	Wed,  3 Jul 2024 15:45:59 +0000 (UTC)
Date: Wed, 3 Jul 2024 17:45:58 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>, Liviu
 Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Support fdinfo runtime and memory stats on
 Panthor
Message-ID: <20240703174558.36387dc8@collabora.com>
In-Reply-To: <157b20fa-078a-479c-bb40-017d16d55c21@arm.com>
References: <20240606005416.1172431-1-adrian.larumbe@collabora.com>
	<ae1ec268-fd76-48b5-94f9-761565153e12@arm.com>
	<uzsqh2b3j7hp6z3zcjcsxxudt2sucgutzwof5bhsvjjaeusigy@wvfhibqtyz4y>
	<157b20fa-078a-479c-bb40-017d16d55c21@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 16:29:00 +0100
Steven Price <steven.price@arm.com> wrote:

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 79ffcbc41d78..42929e147107 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2926,6 +2926,7 @@ queue_run_job(struct drm_sched_job *sched_job)
>                         pm_runtime_get(ptdev->base.dev);
>                         sched->pm.has_ref = true;
>                 }
> +               panthor_devfreq_record_busy(sched->ptdev);

Oops, we're definitely lacking a busy event if all groups were idle but
still assigned a FW slot. Mind sending this as separate fix?

>         }
>  
>         done_fence = dma_fence_get(job->done_fence);

