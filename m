Return-Path: <linux-kernel+bounces-211184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19A3904E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6901F274C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67716C86D;
	Wed, 12 Jun 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMFmiVIB"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD4BA31
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181075; cv=none; b=lZtQu01Szy6lA0mcjCSMjtxWGsg3j0xVmyWwNz8oJBb77dl/YJG/mLwmG2GhMz6Jf7UtDPRBbrhZ6zzkoNa8IQeFkfWDDUISDU1/iZyqRBgg/wZCiM+d29KRj1cDTqVF5UMlBZYmrCi2YJZ9YBJsaPkJSUcVL4ipkepVU/igU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181075; c=relaxed/simple;
	bh=/V7B8lXPBLD7ihkJBxr0bE2ZWrLoc2cPQlARYg71IXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eABlgRWe+jWRCg/rlG7XjMANTMqnyo5U5eQUiRJ3fAUBr3eTPVM2ipZlGThhOcZFq7PfiHD0uj2hKcqShp7tEES8nVCE/RYR2C+aYL+s90bm3spjKVpk0alKOBJWTIBOL/TeAYqLOKQGX/XGiVQj0W3ORF/6gstA2JlwsFeT/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMFmiVIB; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-627ebbe7720so67779617b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718181073; x=1718785873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AK4TGqSjjB40y8fmZJ44IyeI64N3R1XfTvfluZXkmSM=;
        b=wMFmiVIBXFYBu93vt+C0ffKbxz97tus0r8UzuiOpq8guo1LtVHKRw/NE2GPrFEUkUT
         aj2/zWKM2JpUOTTuG60rIDMl6k8D6fKHGhEdNvpKA4ebcEYb1lkA+Wfb1etvW7zNRVgj
         DhAnpQ1gaGUXvMcIh/nSlM7SWpfZeyNTxcjp7d308+N07Ni1oFPyJxdveU2XFkF5BDp9
         0Uk2n4UduEYle11LB5g3497EUyodZKmjwJjyOXWyz4kotzFrRQEe9l+Id2LO6UB9XF4/
         4FttiSzFuTNUgoQt0cYb6vJQgUOzWYEoAxRuzo8vz8KPAaJa4CgsupWQv93O0RlnS/Lv
         fsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718181073; x=1718785873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AK4TGqSjjB40y8fmZJ44IyeI64N3R1XfTvfluZXkmSM=;
        b=P5nNlLntu3n9cm9gHtX8/luwvFbYz1/ED8G10q6BZ4wVvbd8GGfOIgcas4F/BbOPGv
         aGAErX28cmjdc8LxCutooofuihPtf4ArTdgvgDXWoBgGceZBMK7teFu8ItIusV0Ep1Ge
         yVW6cccmU+Hriire2oecO1MHwNIMLthITtus58VpqQlTpqSxyl7GCeMj4el284YZdigT
         g55yNaL0Xi7OAENr+F1zZncvCchji4rk/WZFXJIgvJQpHFaxG4MBLYWHSj4UmDUWvC7n
         fYdq/U8G8H3dUbuySU1BFvU8W+dqhxbX5P+bA48BEB1th5BUh9x3pKICNF3DD4IUzJp1
         U72Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvudgTcg0Az8hl4wpyttR1BL3NAqwfgJOcnhpMmTCdZ+q7DE+wnd7BKUUkzP0Sv3R6nJFpZsUVYPZJXBVO8ZPfZ0HzPGn4siqYuMmB
X-Gm-Message-State: AOJu0YweJvt1C/bh+z+m1vgmGh1tK2qV/LtiSQTe2TwKUV62fUgXwCAQ
	6oSC+8oR22p/Dd8+pE8YUWQl8a6lJ/jsftnqPFr1lR+za3pf1EFma/cI6X7RpbsCDRDzCLw0Snr
	6kmA1fQ5lj5mlJ2Uyw/B6+ptf8OJ3FHLzkITxiw==
X-Google-Smtp-Source: AGHT+IFdVgVihf4MmaN1XEn9h9Ixbp9+ZsNMJGGhiEpC13jkv5QfaF4bLHL7sZmWC4CawHllZ8xWU5fU04nZMosDPgU=
X-Received: by 2002:a25:ad60:0:b0:dfb:9e6:5894 with SMTP id
 3f1490d57ef6-dfe68920559mr1030557276.43.1718181072766; Wed, 12 Jun 2024
 01:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522-fd-hdmi-hpd-v2-0-c30bdb7c5c7e@linaro.org>
 <20240522-fd-hdmi-hpd-v2-4-c30bdb7c5c7e@linaro.org> <6f51224a-a7cd-4774-827a-967a4f4b38ee@quicinc.com>
In-Reply-To: <6f51224a-a7cd-4774-827a-967a4f4b38ee@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 12 Jun 2024 11:31:01 +0300
Message-ID: <CAA8EJpr6v6vToYGc0MBU=SXHEoFOhLTLgs2QAS4JD_c23+8hDg@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] drm/msm/hdmi: set infoframes on all pre_enable calls
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 03:04, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
>
>
> On 5/22/2024 3:50 AM, Dmitry Baryshkov wrote:
> > In consequent modeset calls, the atomic_pre_enable() will be called
> > several times without calling atomic_post_disable() inbetween. Thus
>
> Hi Dmitry,
>
> Just wondering, where are you seeing multiple pre_enable() calls without
> a post_disable() happening?

I think that was with me hacking around, so the commit is indeed incorrect.

>
> IIRC, the msm commit_tail always calls commit_modeset_disables() before
> the commit_modeset_enables(). Also, doesn't the pre_enable() and
> post_disable() only happen once for bringing up/down the bridge?

I don't know if you mean it, but they are called each time the output
gets disabled and then enabled again, e.g. during modeswitch.

Last, but not least, I'm planning to land the HDMI rework ([1]) once
the drm-misc-next is merged into msm-next ([2]). This makes this
commit obsolete.

[1] https://lore.kernel.org/dri-devel/20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org/
[2] https://gitlab.freedesktop.org/drm/msm/-/merge_requests/118


>
> Thanks,
>
> Jessica Zhang
>
> > iframes will not be updated for the next mode. Fix this by setting the
> > iframe outside of the !power_on check.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> > index 3c6121c57b01..fb99328107dd 100644
> > --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> > +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> > @@ -133,10 +133,11 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> >               msm_hdmi_phy_resource_enable(phy);
> >               msm_hdmi_power_on(bridge);
> >               hdmi->power_on = true;
> > -             if (hdmi->hdmi_mode) {
> > -                     msm_hdmi_config_avi_infoframe(hdmi);
> > -                     msm_hdmi_audio_update(hdmi);
> > -             }
> > +     }
> > +
> > +     if (hdmi->hdmi_mode) {
> > +             msm_hdmi_config_avi_infoframe(hdmi);
> > +             msm_hdmi_audio_update(hdmi);
> >       }
> >
> >       msm_hdmi_phy_powerup(phy, hdmi->pixclock);
> >
> > --
> > 2.39.2
> >



-- 
With best wishes
Dmitry

