Return-Path: <linux-kernel+bounces-387051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583859B4B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F0C1C226E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948C620606C;
	Tue, 29 Oct 2024 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CejwanmL"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8DD29CF4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209645; cv=none; b=qIzMtg54udOAY6tNcINoSSNiCB+ZB4Gb14H19FEJ0i+3o2CiBliVxPXd8WAWGoZDwocll6gq3fQIb1DhmxVVa4bd1cQLo5f/dSPfVFsvS2N8Qd5rik96tQU7cbmp5biDzdB+yRGk9Hb6nIFiV2JdAOM6Dvx1/02d2FKMv3NSo1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209645; c=relaxed/simple;
	bh=YltMV0Ll2B1E86hgJlgsFk9LUlCfLX+iuASgJ6Grvk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhCOekQ7khbOmFPvFDhWe0fzvBtAg/hvwmGLN9tQfIYN8fJ1cDLXsRrjhm8HgLfra+SFoCyML4PnHk9BZqdk7tjfTt4TlgVEbo1Y1F43AOWfLEM3LPErLBExgif0YO39yNJmDEGgyKpZxtVBwW4pQL51dUMcRxEutqBxf6mDuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CejwanmL; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7eb068dbf51so744350a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730209642; x=1730814442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/D7WfJDevvalVYpHoiCjOaBH12oKtVHLCOYsUvDV9HY=;
        b=CejwanmL8EwofvLyeXnUrhd/nJNLDeoNEq+A/N9LMC83llCHSRgoLBcrpgXLeFO2X1
         M2jURGh6MdunTRpfjLrTVMoc3WGNgSycoHe5zgArDyFh3zrD+/Iy9SoRLx4Qnn/tz+7c
         VB6RN0KDHPZmnvO3tFQKfiw8dC7qfAxEupHeyCi67Co0TV9JCn/g3WxhGgEPMkyQfvjb
         aqtG/rlKsE7bwTtS/tBhovJzsoBL5c+NhbluELuUZT2X1BLjvJ1ssO3tI2lCEeJkpzN5
         qMt5nXlzGh6dtE9LNm+RaiIDsjNjPvct75bWho4P0S6VqdIwGD3/hPCTXhpAq1roXx3J
         DGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730209642; x=1730814442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/D7WfJDevvalVYpHoiCjOaBH12oKtVHLCOYsUvDV9HY=;
        b=co2qUkOb1jmF0owf9OZO4MN8kSCvQZHogE5Hr/P65TqBxTXuHIOjAxPJ+Tl17jP6lz
         GX6b3TfU1gGKCZRCL5bl9kGrA32mXJyLji/CN0hTqeO5oSHU2dhFMu3qZSHo7mZV5dvR
         t6MjK4daN8ZfKdSagH0RRtAkEZ3SrX02aIZ+ySC1ICSLsrBfTJZf2QtG8VLef9GgItrP
         T0GYTF24xyRVsszRxNs3GfzuycUJFekQDGErhfPq9ijL+DWW6nC0nmTwhZ8yJD6Nxza6
         B6OUjIDhi53S+B6dNTfaGmnQR8Oh6X5eMlTNLIlWBa08jJ13q0CuIjhpoYRnI5/Utpge
         mnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+73OW5+NB/2FYvzqRcxLld4TvsCL20CK7yIYLZjyCOpZ9WVunSeeEiJr/6T7WAa9PH84j8GRvHpOILvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO2+ezFw0ngr9k+xvHvb0ShS+KSQds3t9IkEffvt6o9/yuzkxF
	eBtJo3BkX6ydIuEhLhsPBx3S26k/xNZ9nxe+H3nnVEhjNXRrSZX65Xs3ICWrIi6IOPNdDgnsKZL
	MGYSxZs2DNsXMjqRMa822aLhe2NkWgg==
X-Google-Smtp-Source: AGHT+IFq+zZ2uEaa76yV0X76vhFVcbVRtvW+9G+W15c8OXtY7NLGNXCInOVPkBeSu5C3j5eWFIbRhAvlOsTNmWAeLjQ=
X-Received: by 2002:a05:6a20:2590:b0:1cf:52f5:dc with SMTP id
 adf61e73a8af0-1d9a83a67e3mr8148565637.1.1730209642294; Tue, 29 Oct 2024
 06:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029133819.78696-2-pstanner@redhat.com>
In-Reply-To: <20241029133819.78696-2-pstanner@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 09:47:10 -0400
Message-ID: <CADnq5_NNnQvLG+dmj+RLijxAOg0jEuih+dqc3tin2EiK5jf2_g@mail.gmail.com>
Subject: Re: [PATCH] drm/sched: Document purpose of drm_sched_{start,stop}
To: Philipp Stanner <pstanner@redhat.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:39=E2=80=AFAM Philipp Stanner <pstanner@redhat.co=
m> wrote:
>
> drm_sched_start()'s and drm_sched_stop()'s names suggest that those
> functions might be intended for actively starting and stopping the
> scheduler on initialization and teardown.
>
> They are, however, only used on timeout handling (reset recovery). The
> docstrings should reflect that to prevent confusion.
>
> Document those functions' purpose.
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index eaef20f41786..59fd49fc790e 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -601,6 +601,9 @@ static void drm_sched_job_timedout(struct work_struct=
 *work)
>   * callers responsibility to release it manually if it's not part of the
>   * pending list any more.
>   *
> + * This function is typically used for reset recovery (see the docu of
> + * drm_sched_backend_ops.timedout_job() for details). Do not call it for
> + * scheduler teardown, i.e., before calling drm_sched_fini().
>   */
>  void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_jo=
b *bad)
>  {
> @@ -673,7 +676,6 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, =
struct drm_sched_job *bad)
>          */
>         cancel_delayed_work(&sched->work_tdr);
>  }
> -
>  EXPORT_SYMBOL(drm_sched_stop);
>
>  /**
> @@ -681,6 +683,10 @@ EXPORT_SYMBOL(drm_sched_stop);
>   *
>   * @sched: scheduler instance
>   *
> + * This function is typically used for reset recovery (see the docu of
> + * drm_sched_backend_ops.timedout_job() for details). Do not call it for
> + * scheduler startup. The scheduler itself is fully operational after
> + * drm_sched_init() succeeded.
>   */
>  void drm_sched_start(struct drm_gpu_scheduler *sched)
>  {
> --
> 2.47.0
>

