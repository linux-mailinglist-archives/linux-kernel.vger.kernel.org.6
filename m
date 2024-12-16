Return-Path: <linux-kernel+bounces-447554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703039F3422
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EDA166200
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BAF13B2A4;
	Mon, 16 Dec 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dr7uRLFB"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233A13777F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361943; cv=none; b=dEZHZfv5XmJYqfobceoL6wnqzeOFKufaGP8MI+6IUbD9oaGZ/1V6Scd9Og1fe2kKUMZv5kWThprhOSCXPDO+oLszMgT/ZMQfmoSkfo+6JMia7shKm+Jup3Tpj1vPlvCx5B/fKrCgCpKzuxE92iILKm6vS+KQWMvtG8AmaPIO8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361943; c=relaxed/simple;
	bh=QLlsGNg/hObGHGvhaASJNSp8rMQKO0wxmDH9fbw5j+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6DOkapFHj0zLlbRjEg769qZt5MGFzAN4uQAvoSPMYbcPbcVcgGooHM4p+WIzUkv/fqKNZByFPUx5ZyJyVUE1ZEVThm6sQZd7BvvSIiAJ5QDdksRtvcT3idohyvlgCDaoVFVIB6x9zKDESJcE1TyVykYjzHNyvyD6y/sgxkNDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dr7uRLFB; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e460717039fso1866085276.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734361940; x=1734966740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ffQGy2TMqwM/P0ea5bqOaj/0Pbat+9jyPLZz6qR+vM=;
        b=dr7uRLFB+rEbOKg5NixnNr8sMNJXYo/5mcF4LW799+KdPBdfvW+WNxOVlw1eYru3Fa
         NTvfRC7J9SIWM1PoexNROKftPIutBOU4TCgj0amgUJjTc37pZJwWXTkeQIrlYQi7mkus
         60E7PcbEOrP9/wZq7tqz3Q56OPj79NbqJEEG9PJ376iNOJmqN+BYtY52pYeOi8zFUjRU
         Nm9zVfy/8CDjmsnohbmIVZfht3eAUND5SdyCxO9GnWwTzLE46qFSyFkJ/y9nprbVvbuu
         hWWHYmez4CzI3GQ4UEfcUVfx6QpHZgC+n+K8eruvUmqISYYMp53vKl+YKny5yL8WWnn9
         1isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734361940; x=1734966740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ffQGy2TMqwM/P0ea5bqOaj/0Pbat+9jyPLZz6qR+vM=;
        b=T0hBMfMJJfu51cSMxlYE9iVu7pC9y5QqRbvOJCZ05JCh/QBvvi7mir3+k+d8FOuF7V
         B4DQ3AJk5yuEUFvzyHOYWvC/ERXDLXDCGbx5IDJsEPAPDCJVs0n7VGzeeJxdKk+Ydg1W
         oRaY1mO7Jnvw/Zwz/AWCMH/3MtVMqCYuJmZSwbs1KEuX8pHL7s+IHyWdyfqfPhg+Mjuo
         jUKzwPCv0aZgickrpMnvY4mAKgAiAy50BCrQRSyQ2oBKvxm7gOscIj6cRU/Ij31bbO5b
         ogXCc1xIgQ4rO6mQGNCHQpxwh33vmxG4JaxiwP07TsZyI0H/XV9W8ReoZxV1PPRtHz2m
         m3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhT1Edk5u4HkFBoBsT1T4o8580KCEWWg2DRg7p/czowIsEy6ceojrv0wbjak6qN1blX32SmbaN/itJxOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRvL1NGkv6qWRl9BNkTFgbfifUG+BXHbIQ1meIIDcO2s6Lhcv
	wk3mi9jbxa98RsVw2aoyna0n0BnEf3N6CZxARF6KQpceTnUYJ+llMLnhwqPJiQFLUEj8H9vdtMA
	TSy/xlObV1KHeh819areDZI7ATkkxS/FVak+Y2Q==
X-Gm-Gg: ASbGncv09FEgCS/LpU5wu/fzpLHgXXDCRE/qVUpGGYtoVb2KeI+OPTtptvAq8qlZK9Z
	CCPnaE3QutBci+UZwaA5k9q/TkPN8g25mSIREWW8hRr0sdAyicS5H
X-Google-Smtp-Source: AGHT+IFkMt1zHDB2S3QiYdScTiiPg+ltfkwwZwvvoVehY7huEV6zK2tbYbYSsx3gC5GsnfCaH/SlaLvHa4pCCl1Vu/Q=
X-Received: by 2002:a05:6902:3301:b0:e47:f4e3:8804 with SMTP id
 3f1490d57ef6-e47f4e38da5mr5451800276.24.1734361940405; Mon, 16 Dec 2024
 07:12:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org>
 <20241206-drm-connector-eld-mutex-v2-4-c9bce1ee8bea@linaro.org>
 <pgi7p3aemxm3db2k27vi5euh6q6ppayrw6y7tcfeq4g5z23hzr@xousag2qhobp> <fc8e80dd-bcea-4515-b446-158649719569@amd.com>
In-Reply-To: <fc8e80dd-bcea-4515-b446-158649719569@amd.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 17:12:09 +0200
Message-ID: <CAA8EJpoR8HYq9ATDfmR5ksSnttBzj=DY+BKp5=OuVNF1WDJ-fg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] drm/amd/display: use eld_mutex to protect access
 to connector->eld
To: Harry Wentland <harry.wentland@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Phong LE <ple@baylibre.com>, 
	Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Alain Volmat <alain.volmat@foss.st.com>, 
	Raphael Gallais-Pou <rgallaispou@gmail.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 16:53, Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2024-12-10 16:20, Dmitry Baryshkov wrote:
> > On Fri, Dec 06, 2024 at 11:43:07AM +0200, Dmitry Baryshkov wrote:
> >> Reading access to connector->eld can happen at the same time the
> >> drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
> >> order to protect connector->eld from concurrent access.
> >>
> >> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> ---
> >>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> > Harry, Leo, Rodrigo, Alex, Christian, Xinhui, any response to this one
> > and to the radeon patches? I'd like to be able to pick the series for
> > drm-misc and these two are not reviewed by you.
> >
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 19a58630e774029767bf2a27eb4ddf17e3c21129..04c68c320252b5ce9647f0606fb86fe57f347639 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -1037,8 +1037,10 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
> >>                      continue;
> >>
> >>              *enabled = true;
> >> +            mutex_lock(&connector->eld_mutex);
> >>              ret = drm_eld_size(connector->eld);
> >>              memcpy(buf, connector->eld, min(max_bytes, ret));
> >> +            mutex_unlock(&connector->eld_mutex);
>
> All of this is wrapped by the adev->dm.audio_lock mutex. It might
> be safer to modify the audio_lock mutex so it only guards the
> aconnector->audio_inst access.
>
> But I don't see any way these mutexes would otherwise interact,
> so this change should be good as-is.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Would you ack it to merge it through drm-misc? Or would you prefer to
pick up those two patches after merging drm-misc-next once the rest of
the series lands?

>
> Harry
>
> >>
> >>              break;
> >>      }
> >>
> >> --
> >> 2.39.5
> >>
> >
>


-- 
With best wishes
Dmitry

