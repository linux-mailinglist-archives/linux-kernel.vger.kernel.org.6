Return-Path: <linux-kernel+bounces-554925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C88BA5A374
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDFE188B6FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B68017A2E8;
	Mon, 10 Mar 2025 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C833toJ6"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303223314B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632869; cv=none; b=vDotXbGhgmL0TkQS4maRaPgFrQplEq19zhPWrtsFDcT1nMsKBItdX6GJSJxeX44Rp9OZMzBH4Ex14/AfsGtdR36wQpPPlg4B+bUzm9emS2LgfH4FeXFqimTJ4IHrj18JT20ScKz7u5jgAx/KK4XByS1GRK51qhFIubbv2SxIeXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632869; c=relaxed/simple;
	bh=9YY7WCDPRbeVZmOKCaAdUf0A/gvNnLZ2PmTd0otC8+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTMVIupF7cYQyv3Aqwr0il45BOm15YhT/2cQbrnWdVP2MITKLH4ynWyHxvCelbXz8PJBtBIo2yeK+bD2AD2Of9cM+pJhqsgVoEUio1wv0CG6mshcPTuUc3outY3gsZzLJEuEaxhcXrwWCaM9vgeZmLrHWaI7S+KDjToz55ag+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C833toJ6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so1169687a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741632867; x=1742237667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxGVCl+Faues7cvxc95q/41RjYYvmImGBSS+GmyZKh0=;
        b=C833toJ6nsEvqS+vwAIe0C7sFdqcWONxzZ1rgTWQBLiopLaDRyYnIGWplmG89JjAUH
         +SX8rYAsFGA+N7aar1Z0UgzNL9kq0VbhkxiOpqnfN4FoPDv+8V+Q105NaJ1DB7/IiGb+
         LyI4l6OIZWb42qeK16GJsZdQSwIqYNHNVKRUVBhFUIo+IHE3f+4+8B3jpbqw5rjUft+9
         lkLrIPYRufQYBCpBzJR06ukgQl5gfCtyw7gTxjceuVGS5hMG6ELAB3nersxWXI2t8vWQ
         cJi5y4k1xgWSiOPM7UCB7vSJ6dDY3az62Fy8qLCCSrKPZXXn9wBu7wzOvcsuREjzTpZU
         t+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741632867; x=1742237667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxGVCl+Faues7cvxc95q/41RjYYvmImGBSS+GmyZKh0=;
        b=feTVfncdh82H/troO2UYT7sx6GWp3pdzIGrbW6xAAys3adXb+ltQf2ayNI4C5QmY4Z
         HtfHUotg0+J97REC9FTbfTfEHExm7xFvMOuroRsExOsbrqKdLOM6MOWJK0BDha+RU6oR
         EpHKzWL9vGepDL0xKaildz46764wK4hWzaVhJwVwDTB+S6CRysE3KJChrmLfxUIhFKqn
         bsI5WE1SsOZYWhux6NYBGEmoISFVNcPhZlJh0h+7movi6KurgL+zZ1C9/VK/CvvnhRbf
         BpvClfY9x9ulgvLLIhiMVeTIHn0+HYJLnxPBN0ZIPm2mq2Y7LrFkPZvotcxwc4tTID9r
         PtTg==
X-Forwarded-Encrypted: i=1; AJvYcCU8H/4FaAyuVjyQVgZjnsF5z+NR0mq4TiAncvPFytoG5RTX63P+bBsa02OzvGSrJ50JvSg7TEkWvndtfxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDdrlmpSrZ2uc778GCNRuUrr9OxqWhZr0tww2LHZ+xPtWuE84
	QljUCJCVOtQaZeti9AXeSo3rblcaSNgz/klgZMbtNsCIaL4dELUhacr/Zjo/dzuBi7Sp00oYJbh
	LNHCUKinmarlm1dPHncBCPpNlRYA=
X-Gm-Gg: ASbGnctGFI2COOdYgNWDxOdEHOZIg37c6TslgHRK2Tba2nF8ZoK+rBKS60526EfrUTZ
	FOcjl4JBAZl43XI1cEkt7+vy0wncvY65soT6/B4b52jB2d5b7NLa5NpSSynjqkYiWH8UEHa1+Cv
	yHFNnbuM5DmN/q5ZalUcDTePAJWQ==
X-Google-Smtp-Source: AGHT+IGMG6tNffXX/ec7iRvcQJXp2a6gFwyUvHgDcQJa2LTBWDElhXw8oi+8O7IN2mjhGprkF5y7dERbY0ZX3zUBdgA=
X-Received: by 2002:a17:90b:1d84:b0:2ff:4be6:c5bd with SMTP id
 98e67ed59e1d1-300a57a7d5emr5888384a91.8.1741632866983; Mon, 10 Mar 2025
 11:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225010221.537059-1-andrealmeid@igalia.com> <334ebbe1-6897-4946-b64c-d7d85cae765f@amd.com>
In-Reply-To: <334ebbe1-6897-4946-b64c-d7d85cae765f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Mar 2025 14:54:14 -0400
X-Gm-Features: AQ5f1JoPVqOBfA9hLjv2sfz1bgOjEfAMoGJVkI3NKzv8T93iZQ1Y115X0mIXh4Q
Message-ID: <CADnq5_OVg50R6fSMNPWf=8OT7fsiZDQZcwkiwcmJ36v0nZ6yBw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Trigger a wedged event for ring reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, siqueira@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks


On Tue, Mar 4, 2025 at 4:29=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 25.02.25 um 02:02 schrieb Andr=C3=A9 Almeida:
> > Instead of only triggering a wedged event for complete GPU resets,
> > trigger for ring resets. Regardless of the reset, it's useful for
> > userspace to know that it happened because the kernel will reject
> > further submissions from that app.
> >
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Sorry for the delay, have been on sick leave for nearly two weeks.
>
> Regards,
> Christian.
>
> > ---
> > v3: do only for ring resets, no soft recoveries
> > v2: Keep the wedge event in amdgpu_device_gpu_recover() and add and
> >     extra check to avoid triggering two events.
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index 698e5799e542..760a720c842e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -150,6 +150,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(=
struct drm_sched_job *s_job)
> >                       if (amdgpu_ring_sched_ready(ring))
> >                               drm_sched_start(&ring->sched, 0);
> >                       dev_err(adev->dev, "Ring %s reset succeeded\n", r=
ing->sched.name);
> > +                     drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE=
_RECOVERY_NONE);
> >                       goto exit;
> >               }
> >               dev_err(adev->dev, "Ring %s reset failure\n", ring->sched=
.name);
>

