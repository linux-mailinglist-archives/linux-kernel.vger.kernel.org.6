Return-Path: <linux-kernel+bounces-421675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1889D8E61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49BC168584
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175F1CACF7;
	Mon, 25 Nov 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4aZm9p1"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AB190059
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572729; cv=none; b=lLJ7JVyNnjJb6tb7aEejyx6gG96DWFNOqRYNd4Tv7L8ojmHEZ8EQVia28l5RU4bMAUOTxcwCI3q8u4r9GgNZqdeTEa58zh80vUSHErDdOTPwob2ZhhwSLrXJZ/vt3FmiWvR2skhgYWkRV0XWLYS21M/QJDHFtrvnQ3I3m50fom4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572729; c=relaxed/simple;
	bh=McZwplkugwELgpEP4OeOZtACZ23ZVvR2HDi8q9M2F54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gq9r5vecbVAfl0339vK7svg1YtQHLQhVsvque88WLaoX7dLci8maYJ5Vg0o+TYaj/3eyFejEyZ2JKDv8TXCWxAb3xr0RyOA1PHYyh8Na+soywMvPz5MwnAL4PzOR8+sIagd76MaAkGoF4DyFh6cFS3/IzSa71gl8Fo+9Nio9IZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N4aZm9p1; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ee7a400647so52437467b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732572726; x=1733177526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RGr05iKNJHbtHhaz6iDKZMDzd6vC++UBaPJYjmD+AfE=;
        b=N4aZm9p15LS1rHKKmnoO+9OST7EZwKrPMHokhiUKIbYX9MDvk8zsK60JRQGRD3BSgQ
         iK92/4Do+CJ9RyWgPREWjKWz6MyFbhMeW4jZ2UBV1M7QBq5HAbH3GV2rzOMRgDZ3IrSs
         Xi+EjK36Y+lQ7tIYQ/eNYilOcMk1l8erUW9SyZKkS3cwmyxkPtqUEK/X7mCqDedvqUaz
         YM9Rb6TycXObSnVYAWT3KHdTBlIOTP4ysiZt8ZP2wHZpRp6KiHvoQjVQWPCrvKgGya22
         Ppfnfh7yLPGY1Akv8RRcD0cKy6UQTq6DnKk2VDM8a8aeRCers8t7qwqIWhH679d4jkI6
         eB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572726; x=1733177526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGr05iKNJHbtHhaz6iDKZMDzd6vC++UBaPJYjmD+AfE=;
        b=d22a0aKY0IWLUTmj8Ulc/Ohg3aUZd2oboYVPM9x/F+ILlI9uhfZE8oRwZJfVkKe6j8
         mGP+f2d9gpPHUPSPUJ1iUeC9EGNS5RHcW6tKSgiNSivw5jHVKlB7LtIQ15Q7tNtuBL+/
         h45cYQFNUtNL5fDwnt3Si+QoytUf2lbSVe5z9po1Jg/rsBHyZVwx6AKAgRueY4GlPNjv
         kMfCVUbtDJ9Oc/ZKd0kNLZ890PvZsDJtv6tUrXg39nU0ziSvBXtrWAalBvysW+iuJJ7C
         /TxwWL1z6EZ4T0cU0hrjzpiQbkH6uvMLmoqaGPasWx62QGFIZZkyCMSg7vf7YkOiF6d1
         FYEw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Hteu6Te86KMjcRdmkZpmcqH+3K6Mgtpag/KvhCevmiWk17QA1D2bhWO2j78XSdAl7wRtLKgjHPw/S5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtWYwGbHCK5mFycEI+WH0xreWyzKEv0Xf9FfNyr1KgEUeTZ2GQ
	BINkKR64+0tI/KJ0ycHtPl9UlXOB5+eRUH5pZtAjYZk14HU3V0REsJT3+yev2G4TClOhvkkGnxW
	mdDpQJJJ+LLNbeCap+VctAOa82TV/uDRfSqF9WA==
X-Gm-Gg: ASbGncuxkKCyp8PW/dQcYtB9ve4VGWITT2EqtJrnT6cMXR7VO569ZgTrylh4ZKschHJ
	fCqQXZZMDGCKIKlRH8ot8n12gPFCaCOxncI7IpjbQbqfMhA==
X-Google-Smtp-Source: AGHT+IHMeE1tMJvjhY7YlnbsGtnbHrVf2fxw1EomN6QywO8Yk7cLfG7wt01HeO53/ICqUTeaxSuJYhsdBLq9CwzcufI=
X-Received: by 2002:a05:690c:600e:b0:6ee:5068:74f7 with SMTP id
 00721157ae682-6eee08ba0c6mr132245527b3.23.1732572726501; Mon, 25 Nov 2024
 14:12:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-add-display-support-for-qcs615-platform-v3-0-35252e3a51fe@quicinc.com>
 <20241122-add-display-support-for-qcs615-platform-v3-7-35252e3a51fe@quicinc.com>
 <mcvhfkh3ycrx2ganumsxlc7lx53ed55yk4syh5qev3jqqgkeqj@h5vnfpgjwtj5> <bfc87132-a63e-4f3f-99b7-1a1bd7eb60ce@quicinc.com>
In-Reply-To: <bfc87132-a63e-4f3f-99b7-1a1bd7eb60ce@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 26 Nov 2024 00:11:55 +0200
Message-ID: <CAA8EJpoYwGHenThgxaKcapjTng3BchpbVBfzXqBvTDGBzv2J-w@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] drm/msm/dsi: Add support for SM6150
To: fange zhang <quic_fangez@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Li Liu <quic_lliu6@quicinc.com>, 
	Xiangxu Yin <quic_xiangxuy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 04:31, fange zhang <quic_fangez@quicinc.com> wrote:
>
>
>
> On 2024/11/22 18:10, Dmitry Baryshkov wrote:
> > On Fri, Nov 22, 2024 at 05:56:50PM +0800, Fange Zhang wrote:
> >> From: Li Liu <quic_lliu6@quicinc.com>
> >>
> >> Add support for DSI 2.3.1 (block used on SM6150).
> >>
> >> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> >> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/dsi/dsi_cfg.c | 4 +++-
> >>   drivers/gpu/drm/msm/dsi/dsi_cfg.h | 1 +
> >>   2 files changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> >> index 10ba7d153d1cfc9015f527c911c4658558f6e29e..fe02724bddf69c2e8d6816589f4ea410fa666e5b 100644
> >> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> >> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> >> @@ -171,7 +171,7 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
> >>      .num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
> >>      .io_start = {
> >>              { 0xae94000, 0xae96000 }, /* SDM845 / SDM670 */
> >> -            { 0x5e94000 }, /* QCM2290 / SM6115 / SM6125 / SM6375 */
> >> +            { 0x5e94000 }, /* QCM2290 / SM6115 / SM6125 / SM6150 / SM6375 */
> >
> > Not true
> Should I remove it or add it behind the SDM670?

You should not be sending patches which provide false information. Why
did you add it to the wrong line in the first place?

> >
> >>      },
> >>   };
> >>
> >> @@ -286,6 +286,8 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
> >>              &sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
> >>      {MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_3_0,
> >>              &sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
> >> +    {MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_3_1,
> >> +            &sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
> >>      {MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_4_0,
> >>              &sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
> >>      {MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_4_1,
> >> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> >> index 4c9b4b37681b066dbbc34876c38d99deee24fc82..120cb65164c1ba1deb9acb513e5f073bd560c496 100644
> >> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> >> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> >> @@ -23,6 +23,7 @@
> >>   #define MSM_DSI_6G_VER_MINOR_V2_2_0        0x20000000
> >>   #define MSM_DSI_6G_VER_MINOR_V2_2_1        0x20020001
> >>   #define MSM_DSI_6G_VER_MINOR_V2_3_0        0x20030000
> >> +#define MSM_DSI_6G_VER_MINOR_V2_3_1 0x20030001
> >>   #define MSM_DSI_6G_VER_MINOR_V2_4_0        0x20040000
> >>   #define MSM_DSI_6G_VER_MINOR_V2_4_1        0x20040001
> >>   #define MSM_DSI_6G_VER_MINOR_V2_5_0        0x20050000
> >>
> >> --
> >> 2.34.1
> >>
> >
>


-- 
With best wishes
Dmitry

