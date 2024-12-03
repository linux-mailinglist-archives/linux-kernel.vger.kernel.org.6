Return-Path: <linux-kernel+bounces-429619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0655B9E1EA5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6F9283D53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B361F427E;
	Tue,  3 Dec 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ueArWRrB"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400F1F12E3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234861; cv=none; b=rRhfGS67f8CHNEuJ/Rgw9qJqkTXFUBNJdcGvvQFhnLbDnQQpsdP/fu4s1gv2OXuT1xtFZud25SKi5AJSTrEEQq/RsCWN8G/uM/Sr36sXtC32sDNIMLFQOuFvJQG7P6kpRM0k8t/XaN7bQLMyo8t4BY59f2RSDFO3Mg04fS44SXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234861; c=relaxed/simple;
	bh=8oFkiMvC+CSj7nvMpm/gEdf0IkyXTLTgDlt6meawxdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIi1O0xo/rKypJRg0gTL/TvtVFdeZ1u0XkVdyuX3rYtUvZCa3rF+ERbMrdhVeEf/ikRL1fy9NAJZyf4Afgo0EQoIvgrxSgbUmgqSiBdNKN4diuHq6p5pVPUAeQsGFfVmndWh8Ifj4JIDlpqKXrE7BtDiuh+jOEK8hgXWWHSvkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ueArWRrB; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffc81cee68so57170291fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733234857; x=1733839657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=alsc9vr73lToVKNbHqTqZ3F3g1arQk5UqwKIUtPE6Ps=;
        b=ueArWRrB/0J89auGOzYm/ud1AdVww/DDQaM9I7Yx791XEY6LZyORVkhl+LUsNPmOw2
         QiTurQmbHjQ4/vE3p/xORudPEuy3mVt33VqMj51zpPCoaao/ra8HajRCWKMXv+VqUHYy
         Cy0z5JVZGhldGRQLnfaDhRjknQUo5gUihK3UXGYsHNfGJ4VQfVMGeAD+p41ts05C9icE
         6BTI6t0//mA21tKq7AFFemvDuKVhT/8OO4CCtK+5jcTRhThfdnigXYzppaa9LIWniCe0
         9rOX1uiDkUQK6sd/AqJGXhQvssnsQ/Otan74bu4jotEvYbraAqEuIc7wR0Cp1h5hnUaB
         MypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234857; x=1733839657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alsc9vr73lToVKNbHqTqZ3F3g1arQk5UqwKIUtPE6Ps=;
        b=rYFsGGh0icwZtj3XgZ2M1c/IfqWB5QVAqMmMP5+lmqiuj5sdgXD0xARj6mqO06Kj9p
         UzHoYlmCSBWC+PSA35l6pYU4fRJCSi3jzJ6oxj+cQdY05Ef0ZD+gD9u0VTlpOu5rlAJ4
         89uw8n8goSBLBA/absw8/yYqhbVvvFSpVOJzTIQiDJF9MJ8fomZtf3aISrrSNG3f0dDS
         pfV9fLKXRuDrLLFgUlvU9amwbLquKo5SJyOHyDECoRjw4XoPs3tJXWPmaCGi65l6RU5b
         VNflGT9SKBfovM9EciOZO9LdHTkjZVIGbAKdPKMtaJxTyirNnHsyoU6aeUwrET0c/sk9
         xVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKhhlk5g5dsL+/WJTIyGV6mC/sIQ58B4oAQilezDwIqo3ZH4uOvFqIZNpQCyiVBA93JrUGPFbUitgE7wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIyFA49KbfXmMfB9kGvxBqeZ/5KtpmEc0/jT4vMURChkjtvtcp
	KkrAwo83WbW0XTLy84XA7vOfxHkntBY6DLk16scM9l3rYFMJBt/hORQyXUpSbqI=
X-Gm-Gg: ASbGnct4HK5cQ3oqp5eBykyCGMjDzv8vJwqmpvYdDYkM/SjdHvyWu02rd3vRjojXpRY
	ZA2jW5fkkD5QoLz4QQrHwxsm5NcsFspnvFgU7nTnHUkPJIsVgwXVc30d6BEwgJxkyoR9hkzzVkg
	7/v/qrjziqo2eU5ip3GgSam96K0BZxY4dwgB6HDx9Z9TVwOGUaXhXNfoNVt+a++X8DbVfZwWbSa
	cVQNk/saMPq3c9vI9pOtHyzxBuCQEJn0MIxjOC+pBV/B7JqodBHoucWoBaRE+Oem4SQBoFsoSqd
	/vC3vo0vMbZACT1+VUnlIkh+GDEgkg==
X-Google-Smtp-Source: AGHT+IGzMeET4siJUKFgW4BnmqUwqvzwcdd9B9sOmlcJgCBnOeScvQxwQ4zyH6t4AC935j3xTebwFQ==
X-Received: by 2002:a2e:bd82:0:b0:2fb:5ebe:ed40 with SMTP id 38308e7fff4ca-30009c3443dmr15745541fa.15.1733234855610;
        Tue, 03 Dec 2024 06:07:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfc74a1csm16403761fa.69.2024.12.03.06.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:07:33 -0800 (PST)
Date: Tue, 3 Dec 2024 16:07:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xiangxu Yin <quic_xiangxuy@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_lliu6@quicinc.com, quic_fangez@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 7/8] drm/msm/dp: Retry Link Training 2 with lower pattern
Message-ID: <xlmgdysjah3ueypdrdu5b6botvidb2wn4rfm4qpeysclscmuwy@vpfv2ymprblj>
References: <20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com>
 <20241129-add-displayport-support-for-qcs615-platform-v1-7-09a4338d93ef@quicinc.com>
 <CAA8EJpoN1qBHyZrQJT_=e_26+tcaKRnSrhtxrK6zBP4BwpL=Hg@mail.gmail.com>
 <b4345b9e-62c6-470d-b1b0-4758cef7f175@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4345b9e-62c6-470d-b1b0-4758cef7f175@quicinc.com>

On Tue, Dec 03, 2024 at 04:13:22PM +0800, Xiangxu Yin wrote:
> 
> 
> On 11/29/2024 9:53 PM, Dmitry Baryshkov wrote:
> > On Fri, 29 Nov 2024 at 09:59, Xiangxu Yin <quic_xiangxuy@quicinc.com> wrote:
> >>
> >> Add a mechanism to retry Link Training 2 by lowering the pattern level
> >> when the link training #2 first attempt fails. This approach enhances
> >> compatibility, particularly addressing issues caused by certain hub
> >> configurations.
> > 
> > Please reference corresponding part of the standard, describing this lowering.
> > 
> Per DisplayPort 1.4a specification Section 3.5.1.2 and Table 3-10, while the standard doesn't explicitly define a TPS downgrade mechanism, it does specify:

Anything in DP 2.1?

> - All devices shall support TPS1 and TPS2
> - HDR2-capable devices shall support TPS3
> - HDR3-capable devices shall support TPS4
> While these capabilities are explicitly defined DPCD for sink devices, source device capabilities are less strictly defined, with the minimum requirement being support for TPS1 and TPS2.
> In QCS615 DP phy is only supporting to HBR2, we observed a critical interoperability scenario with a DP->HDMI bridge. When link training at TPS4 consistently failed, downgrading to the next lower training pattern successfully established the link and display output successfully.

Any other driver doing such TPS lowering? Or maybe we should be
selecting TPS3 for HBR2-only devices?

> 
> This experience suggests that implementing a flexible link training pattern downgrade mechanism can significantly improve compatibility with third-party, non-standard hubs and displays,
> especially in scenarios where strict adherence to the highest training pattern might prevent successful connection.
> >>
> >> Signed-off-by: Xiangxu Yin <quic_xiangxuy@quicinc.com>
> >> ---
> >>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 34 ++++++++++++++++++++++++++++++----
> >>  1 file changed, 30 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> >> index 49c8ce9b2d0e57a613e50865be3fe98e814d425a..b1862294cb98c9f756b0108b7670cb42de37bae4 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> >> @@ -1220,7 +1220,7 @@ static void msm_dp_ctrl_clear_training_pattern(struct msm_dp_ctrl_private *ctrl)
> >>  }
> >>
> >>  static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
> >> -                       int *training_step)
> >> +                       int *training_step, bool downgrade)
> >>  {
> >>         int tries = 0, ret = 0;
> >>         u8 pattern;
> >> @@ -1243,6 +1243,28 @@ static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
> >>                 state_ctrl_bit = 2;
> >>         }
> >>
> >> +       /*
> >> +        * DP link training uses the highest allowed pattern by default.
> >> +        * If it fails, the pattern is downgraded to improve cable and monitor compatibility.
> >> +        */
> >> +       if (downgrade) {
> >> +               switch (pattern) {
> >> +               case DP_TRAINING_PATTERN_4:
> >> +                       pattern = DP_TRAINING_PATTERN_3;
> >> +                       state_ctrl_bit = 3;
> >> +                       break;
> >> +               case DP_TRAINING_PATTERN_3:
> >> +                       pattern = DP_TRAINING_PATTERN_2;
> >> +                       state_ctrl_bit = 2;
> >> +                       break;
> >> +               default:
> >> +                       break;
> >> +               }
> >> +       }
> >> +
> >> +       drm_dbg_dp(ctrl->drm_dev, "pattern(%d) state_ctrl_bit(%d) downgrade(%d)\n",
> >> +               pattern, state_ctrl_bit, downgrade);
> >> +
> >>         ret = msm_dp_catalog_ctrl_set_pattern_state_bit(ctrl->catalog, state_ctrl_bit);
> >>         if (ret)
> >>                 return ret;
> >> @@ -1311,10 +1333,14 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
> >>         /* print success info as this is a result of user initiated action */
> >>         drm_dbg_dp(ctrl->drm_dev, "link training #1 successful\n");
> >>
> >> -       ret = msm_dp_ctrl_link_train_2(ctrl, training_step);
> >> +       ret = msm_dp_ctrl_link_train_2(ctrl, training_step, false);
> >>         if (ret) {
> >> -               DRM_ERROR("link training #2 failed. ret=%d\n", ret);
> >> -               goto end;
> >> +               drm_dbg_dp(ctrl->drm_dev, "link training #2 failed, retry downgrade.\n");
> >> +               ret = msm_dp_ctrl_link_train_2(ctrl, training_step, true);
> >> +               if (ret) {
> >> +                       DRM_ERROR("link training #2 failed. ret=%d\n", ret);
> >> +                       goto end;
> >> +               }
> >>         }
> >>
> >>         /* print success info as this is a result of user initiated action */
> >>
> >> --
> >> 2.25.1
> >>
> > 
> > 
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

