Return-Path: <linux-kernel+bounces-527891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3FA410ED
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0260217183D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1541155300;
	Sun, 23 Feb 2025 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GnCyrtGK"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE188C11
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740335690; cv=none; b=eNSqXJcqYrToDc9cbgJXYRBfAT2YzbsUnCg2HEiUaw1N4YBIiw+9zkiqQ9VUHK8X8FCPAGJAcuRYAvx2sbdlof3HvTZdHvogLQBi6kyPzRuC2+aSLSryTf8mw4l6G1M7tsPnfzScz/IdmiaZyTSEPJsY4cdfhDoqVYKyE2vKTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740335690; c=relaxed/simple;
	bh=Q7f0bptqboJdMiPWFy2P5hU0sfFsmUIydK6IWF+KPlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCZtkSi7BexbWZLedxTMuE7b+sCQJdGBLrSdxpR9FnqBu4Dag0T1Am4FU2tzM9NhUU6j3DDF2P/ZdjTbq1Z/o6T3BumSlhtKShT0FWokSqV+aMCmtDlVMDW/jdVUtPY3VPUYKUty8VDuEegLqqxFSZeyDlVx0BDIqj5z+G5fsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GnCyrtGK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-546267ed92fso4361686e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740335686; x=1740940486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U0C+iu1WeNs+zRFQEZ4WEKG2Hv7tO/tPX0DsKYx3e/U=;
        b=GnCyrtGKLQdBDJ+ZTZ7GwyM1IuC31aDXsOh+7E/BvpU0p8Kga33DSG0by3UdRwNp88
         gODY+6B3PR0BbIkASXcFFw52YXJ8dFTdmxmqzYLHeAuTjVRiILqg3CPcQ5xfw8VCPxZU
         EespJ5FDvfwAsDxUnxW1Mxh2OYSQX9+qlGAo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740335686; x=1740940486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0C+iu1WeNs+zRFQEZ4WEKG2Hv7tO/tPX0DsKYx3e/U=;
        b=NbVBG/kIe3WeEVVbnhJ7xG5fk+lxhMBgqJBG8pGxDpGZmzaBqxz16My8121a34y9M4
         3Q5TC6ziVPnLdfvOcrVosaTRuESYAQh5L8r1LWLXeEQgN+rdm+wE9IcVcTJ3Z/n6Ivrn
         mGhgwXCv4vVk0VZ3PrlzqCzJXuzvo+3v2bIx6R11Vrs0u4Zm21JRtjdvhGnDMxWnMWqM
         a+A/lQYL7UdvWtTFcIT0qz+MLiAv9d1qf/P45H02su+ixxPPxOGkJBisifC3CqDrXccm
         Jovcqx2K1lxX+7W1Hcf1fX2W633oL+LGVGqypu/m2Pdq7Nc8aHx+oczH5wAPYIrXKoJj
         jaIg==
X-Forwarded-Encrypted: i=1; AJvYcCWN2E/Qv8j6vxEF/xX66ZmmE+Sy8+QyadzLb1onvXJm5HsmiFAAaW7+s4Q9TJbJR/PG02iOAaW3mO11qJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVP3nY7jC4gk+aENeV3sSztpcxpEIPJ26FRU1/uh3v6W1AbtWa
	0HUHMfqMmIB2xRpyXZWRYvTs+ZsC3Ro2FA1IRDnLZnbnGgFpIsQfWjgrLXYmI8i8JY7xC/BvTtk
	=
X-Gm-Gg: ASbGnctIfda8q60oalU6toGUplrDSu0dEW8jAm3ZYYjaPDD3hshkxWODMfmpr2s6z/f
	zmMyJTApBYrz96tnHw6dLkgIwC11FEufdyexnZtXpOV2UjLV1wgT16/GUDDI6KUhXNG/DUeIRrJ
	t7oeFrG1gSxREKWYqjHw00UGR2t7tau7BYwXxIEwd058P3L+be265nyxCfmPvRIpz3/etlWc9Xe
	II3XSsJQgyBKzYyFmSVXU2lt/CtEzXOBzz/PwFFk1mCK4+upVrda4B+YmOx06zV0tCciun4O8Il
	E92VERBpEU3JHgJEPEGaEBy7QrJ5rcSqhyz0HUNxzK1FgrsaW/LzNCJDjPXuGmoJH2WI
X-Google-Smtp-Source: AGHT+IHg9yq7g7sM1gdyPAd0pNiSEfB5UdnhaI90E/GeIs3LQenRwgrCtEwv/gcywISnCnQSEG+LjA==
X-Received: by 2002:a05:6512:3f0d:b0:545:bda:f0d with SMTP id 2adb3069b0e04-54838f4e585mr4329634e87.37.1740335686140;
        Sun, 23 Feb 2025 10:34:46 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452c1bdca1sm2867484e87.110.2025.02.23.10.34.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 10:34:44 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30a317e4c27so32738291fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:34:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6M7xgE55fnoNbAIV8TpribxYTs/e5pWT2sNJH1Ci5ysNFRJIxCVRpBeYEAbL/C/QgTrvGe34gI7Jm0cg=@vger.kernel.org
X-Received: by 2002:a2e:b614:0:b0:308:f84b:6b34 with SMTP id
 38308e7fff4ca-30a5990b2ebmr35382051fa.20.1740335683340; Sun, 23 Feb 2025
 10:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-nuvoton-v1-0-1ea4f0cdbda2@chromium.org>
 <20250121-nuvoton-v1-1-1ea4f0cdbda2@chromium.org> <df5693d0-7747-4423-809e-ae081c9aae92@xs4all.nl>
 <dffc8e0b-2603-4e7e-ba64-15691c11ff7e@xs4all.nl>
In-Reply-To: <dffc8e0b-2603-4e7e-ba64-15691c11ff7e@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 19:34:30 +0100
X-Gmail-Original-Message-ID: <CANiDSCsMCSJMEsY3R=pnZ4XUTiEYuPz-N1kEX7y13yTzE6Dm5w@mail.gmail.com>
X-Gm-Features: AWEUYZkxdyzd_jgZvmXlXPTuqCYemf2QEgvVhq5WasLvpB-Xk2V4c6RpmAx6ZOg
Message-ID: <CANiDSCsMCSJMEsY3R=pnZ4XUTiEYuPz-N1kEX7y13yTzE6Dm5w@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: nuvoton: Fix reference handling of ece_pdev
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Marvin Lin <milkfafa@gmail.com>, linux-media@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 10:18, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 21/02/2025 10:04, Hans Verkuil wrote:
> > Hi Ricardo,
> >
> > On 21/01/2025 22:14, Ricardo Ribalda wrote:
> >> When we obtain a reference to of a platform_device, we need to release
> >> it via put_device.
> >>
> >> Found by cocci:
> >> ./platform/nuvoton/npcm-video.c:1677:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> >> ./platform/nuvoton/npcm-video.c:1684:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> >> ./platform/nuvoton/npcm-video.c:1690:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> >> ./platform/nuvoton/npcm-video.c:1694:1-7: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> >
> > This driver uses this construct:
> >
> >                 struct device *ece_dev __free(put_device) = &ece_pdev->dev;
> >
> > to automatically call put_device. So this patch would 'put' the device twice.
> >
> > Does cocci understand constructs like this? If I hadn't looked closely at the
> > code first, I would just have merged it.
>
> Oh wait, now that I am reading the following patches I see that it was those later
> patches that add the __free code.
>
> This is far too confusing. Please post a v2 that just combines the 'fix references'
> and 'use cleanup.h macros' in a single patch. It makes no sense to have this two-phase
> approach.

I believe this is discouraged.

cleanup.h macros does not exist in old kernel versions, so makes it
impossible to backport the fix to them.

This is an example of other series following this policy:
https://lore.kernel.org/lkml/173608125422.1253657.3732758016133408588.stgit@devnote2/

They also mention the same here:
https://hackerbikepacker.com/kernel-auto-cleanup-1 .... I am pretty
sure that I read the policy in a more official location... but I
cannot find it right now :)


>
> Regards,
>
>         Hans
>
> >
> > Regards,
> >
> >       Hans
> >
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 46c15a4ff1f4 ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
> >> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >> ---
> >>  drivers/media/platform/nuvoton/npcm-video.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
> >> index 024cd8ee1709..7b4c23dbe709 100644
> >> --- a/drivers/media/platform/nuvoton/npcm-video.c
> >> +++ b/drivers/media/platform/nuvoton/npcm-video.c
> >> @@ -1673,6 +1673,7 @@ static int npcm_video_ece_init(struct npcm_video *video)
> >>
> >>              regs = devm_platform_ioremap_resource(ece_pdev, 0);
> >>              if (IS_ERR(regs)) {
> >> +                    put_device(&ece_pdev->dev);
> >>                      dev_err(dev, "Failed to parse ECE reg in DTS\n");
> >>                      return PTR_ERR(regs);
> >>              }
> >> @@ -1680,11 +1681,13 @@ static int npcm_video_ece_init(struct npcm_video *video)
> >>              video->ece.regmap = devm_regmap_init_mmio(dev, regs,
> >>                                                        &npcm_video_ece_regmap_cfg);
> >>              if (IS_ERR(video->ece.regmap)) {
> >> +                    put_device(&ece_pdev->dev);
> >>                      dev_err(dev, "Failed to initialize ECE regmap\n");
> >>                      return PTR_ERR(video->ece.regmap);
> >>              }
> >>
> >>              video->ece.reset = devm_reset_control_get(&ece_pdev->dev, NULL);
> >> +            put_device(&ece_pdev->dev);
> >>              if (IS_ERR(video->ece.reset)) {
> >>                      dev_err(dev, "Failed to get ECE reset control in DTS\n");
> >>                      return PTR_ERR(video->ece.reset);
> >>
> >
> >
>


-- 
Ricardo Ribalda

