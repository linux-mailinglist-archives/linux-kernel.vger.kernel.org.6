Return-Path: <linux-kernel+bounces-187297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1903C8CCFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889EE1F2375E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6F213D8AF;
	Thu, 23 May 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0nP5/Lv"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18813D538
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458390; cv=none; b=IZlTynoot7jj2n9bX33yEAMxhX+Yf87QuywGa1flp3Pt13/lNNEHymcOvo4NBWwXx1LCnwsD0ljefJu8Xu5V9Bf/bQ9CjPrj7X7CS9VxQ4iI7+vf0vM1O6cgm+1fVfLTRAN82v8ReEZmCFhXMBBanX3JHKfyBKbA7xJPLeTsBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458390; c=relaxed/simple;
	bh=+59I1LMHz5513L5Tt9Gn+0+i8+g532fE4EtvdMuItaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fy0j6UcD+t8YCSRg3u+ck3Qy3aSIvIYR4tDby8iBRrVSVE3RoZxp0m9cYJMIKkFOAz60/eDA367GaLbg3sel8OLIzJ822lOOag8tmwzhJvTsPHAdJvaPYNs4aaSGc95vo9YHpwE2JdC5qer8vnRcre7ibfWzNlCFOBFUa5bLQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z0nP5/Lv; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de462979e00so2141340276.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716458387; x=1717063187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4eLg5W63v6nyWYGdaPlQGL+64DpELLePyMxWT5qrNUU=;
        b=z0nP5/LvIxvVLOMeNooQdvUytMDrVgTnDiIhr83FXLgKBp3m4dE7VGLZwXZNLGEEDc
         KuWYQZyeYZ/NRsYOHtxZ4ud/6VOy65ygkLfS7jR1zCZM7EA+17oaKnnlSTVfaeLhXWaM
         f7kNzbmEQTvftoT8F9YLLqifFrBA6rIUWhFq5JE424JbDSVv9pa+oVAUZhYAv8VRNuAf
         Vm1bpR8yz6vIelJ9s/4cSM9OeyMVNVz35hZfNgU4uo4cgCesa/CA+k8X6I7NrTyvbOPe
         /0xQOGV5vM8JaS3Q9Za/Jg2zn3O4wmYv6WwdCJgC6o6PwEzMZzawrH6Gnt7g5xK2D2Z0
         IzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716458387; x=1717063187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eLg5W63v6nyWYGdaPlQGL+64DpELLePyMxWT5qrNUU=;
        b=plk9dRv+IZtV065ORAzhbunuNX/MAmwtKKTCJExgk+hiEA+V1tN8iehrLa7hJ2Erpg
         rdJp/v2CNHbxlEwmqqkdcqbKMWFtCVarXCPHwhK8EM4jMvoMWHahVZIgTxJsOSaVq/sQ
         zgP9KIMQa5NUJpWRENUQTdyprXlBjSEXrP8GSiXz2qfTpPfT4R7HEW3uIhka8/epDCKg
         pmbQHad2r7iUi1JGwf5W2tSDrGg7OcAUqudUWn0Ks5tdw608lfgREsn52u6dqmSmSUj/
         8hHNo5+pZPxMVAC7mOh2Wr6ZVRFqa16mWzS1Eb+zaxRIQOHXuz3jywc6ntvIFa7pZ7CV
         uxwA==
X-Forwarded-Encrypted: i=1; AJvYcCXzsO3a+6kwik9TN0MmzwJl1W7UShGlKLFylLEWgm1Eo5+lrPMqyGyiGLZNtRes5Fk2EQb2nZm6BPNAu2RVNg7wCoLobVj/vdv+vYYP
X-Gm-Message-State: AOJu0Yxy35cjGO6Rece/z6oIu+Kt1QSC9mDZXCr6MspDxdOwi66jHlcr
	yQxjhoepjSJolZBQIlVJt3q4/K2vxf/6MA4GePvheMFcKFewt2uvn7FzQjIacTh3tLMEESPd4hM
	UCg56Pb1qzZ7krZ8Yzg+L4M6cY0saBJmLJHVtOnDA+/Yrm4pD
X-Google-Smtp-Source: AGHT+IEH2bet0vxbyQkGUI55R017CbgvtHVbrVup5m0zjkPeCkh3N7ZUjMndzd5BhJJAs4TMZp+oQ52G6r3Sss4urHM=
X-Received: by 2002:a25:b181:0:b0:dee:607c:3528 with SMTP id
 3f1490d57ef6-df4e0a9cfa9mr4821493276.3.1716458387642; Thu, 23 May 2024
 02:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-2-vignesh.raman@collabora.com> <2qzmfv3oc6feihwxu3tl37rg6w3qsj2vddu5olvqk6vhqr26cc@bxu5y6ijvtfa>
 <9cd0667a-12ee-4d45-80e8-dc34259bf01d@collabora.com>
In-Reply-To: <9cd0667a-12ee-4d45-80e8-dc34259bf01d@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 23 May 2024 12:59:36 +0300
Message-ID: <CAA8EJprVVkQO7aPkehwL2zhYkGRkm4Foc13ErfuY6ikBA_4nLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drm/ci: uprev mesa version
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	robdclark@gmail.com, david.heidelberg@collabora.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 09:07, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>
> Hi Dmitry,
>
> On 20/05/24 16:13, Dmitry Baryshkov wrote:
> > On Fri, May 17, 2024 at 02:54:57PM +0530, Vignesh Raman wrote:
> >> zlib.net is not allowing tarball download anymore and results
> >> in below error in kernel+rootfs_arm32 container build,
> >> urllib.error.HTTPError: HTTP Error 403: Forbidden
> >> urllib.error.HTTPError: HTTP Error 415: Unsupported Media Type
> >>
> >> Uprev mesa to latest version which includes a fix for this issue.
> >> https://gitlab.freedesktop.org/mesa/mesa/-/commit/908f444e
> >>
> >> Use id_tokens for JWT authentication. Since s3 bucket is migrated to
> >> mesa-rootfs, update the variables accordingly. Also copy helper scripts
> >> to install, so that the ci jobs can use these scripts for logging.
> >>
> >> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> >> ---
> >>
> >> v2:
> >>    - Uprev to recent version and use id_tokens for JWT authentication
> >>
> >> ---
> >>   drivers/gpu/drm/ci/build-igt.sh   |  2 +-
> >>   drivers/gpu/drm/ci/build.sh       |  6 +++--
> >>   drivers/gpu/drm/ci/container.yml  | 12 +++------
> >>   drivers/gpu/drm/ci/gitlab-ci.yml  | 44 +++++++++++++++++++++----------
> >>   drivers/gpu/drm/ci/image-tags.yml |  2 +-
> >>   drivers/gpu/drm/ci/lava-submit.sh |  4 +--
> >>   drivers/gpu/drm/ci/test.yml       |  2 ++
> >>   7 files changed, 44 insertions(+), 28 deletions(-)
> >>
> >
> > [skipped]
> >
> >> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> >> index 8bc63912fddb..612c9ede3507 100644
> >> --- a/drivers/gpu/drm/ci/test.yml
> >> +++ b/drivers/gpu/drm/ci/test.yml
> >> @@ -150,6 +150,8 @@ msm:sdm845:
> >>       BM_KERNEL: https://${PIPELINE_ARTIFACTS_BASE}/arm64/cheza-kernel
> >>       GPU_VERSION: sdm845
> >>       RUNNER_TAG: google-freedreno-cheza
> >> +    DEVICE_TYPE: sdm845-cheza-r3
> >> +    FARM: google
> >
> > I see that this is the only user of the FARM: tag. Is it correct?
>
> No, we need to add FARM variable for other jobs as well.

Why? Even if we have to, we don't have them now and the change doesn't
seem to be related to the uprev'ing of mesa. So this probably should
go to a separate commit.

>
> > Also we miss DEVICE_TYPE for several other boards. Should we be adding
> > them?
>
> Yes, device type needs to be added for msm:apq8016, msm:apq8096, virtio_gpu.
>
> I will add this. Thanks.

I'd guess, separate commit too.

>
> Regards,
> Vignesh
>
> >
> >>     script:
> >>       - ./install/bare-metal/cros-servo.sh
> >>
> >> --
> >> 2.40.1
> >>
> >



-- 
With best wishes
Dmitry

