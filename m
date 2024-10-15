Return-Path: <linux-kernel+bounces-365768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20999E9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0245028201C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2171EF0B8;
	Tue, 15 Oct 2024 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DghU+irJ"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB8E1EBFE0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995148; cv=none; b=RyjWFXsafoHSOgD/Zr+jtYgDI+LcSxGq9/gCM99LYF16xC/lwFuB5mG2QVdnD58/Krlzy8u4W6cu2NaulKCXnKcpnoV/2+XlZMJZL9GY9hKj75wl6TPdA9XxnPABgehxe/w+EAI9IRBTYd2wwy3q7wx1xkU0njOFi6Q21BHiPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995148; c=relaxed/simple;
	bh=cqzsFbJM/5VmtaL7Wz0DGufiR6YTrlGuXGh5B6J5Wr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNcwZZSyrrWVD2G/UqbhHBHSITbe6o+er+YKi/9CU+E5LALIlNadUHWcp1tzZqZqoWCTsF0m/R6hCfW0eKHeOeOqIDWAm8qUUcJc7SNa5OXutgp6d/xXbdUfvE49hHJuD0StpZjsJwmqbOehKKGb61P9R2xuyYtVK87dgdl5jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DghU+irJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6db20e22c85so40016957b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728995145; x=1729599945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Go8RY3f3g+YNRtfmTAreeRvEns8DfLxEuJL0kCvf+w=;
        b=DghU+irJ2lFEd/rJPR1oObIO7VjiOt5aHmpo53jGY8+udWsnnk9VW1uaAK+9N59U88
         3T6jdEKdeOckMnibCIK429LkA13+y8o28qjXNejvwpEOjG//HmDtdo80zwNHSIQlRZsM
         Ma3AIPbgpUtCqoOGX5Q8u0OD7Hru9ZCjPYHVMZGVzOX4iQlyITKNDQdyDW3FpG6+oVNn
         usTTimkmYZlo2z9HOC6tWi1dYbDfG0l2FkJuDg6b2L9zHMjiAwATmFfzd/VMfYPUQIhv
         ESGUeypg3kAZNeVNUtwKBy0Y/PWbIfBlw8nIa+X81SWciYj3ltVknAYJwMU4qiPdNVEc
         MHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728995145; x=1729599945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Go8RY3f3g+YNRtfmTAreeRvEns8DfLxEuJL0kCvf+w=;
        b=ILmGdROSnFDKftHZQJh0QOOKiIxb0rgWB3lNllUKp2CEJwLn8YmwjVGv1kydb+JF/N
         snD7Z+2YHIALYiuLz/tqW/t7zwASXdJGdKdjKDmebJSecZOEy6Vv2novHGJSYaqZ9H4o
         rW+r/fe/qrZvUo8FBCWF+YUuHCNz8wEviAtYEGcWDDnhT+Ttk77zvbGbYgaSlrSlAc9x
         SaEQJdotEA52zQ5C10LUXDZfga2lcBUujbYUcZl237k0nZWLxpez/G/rrcCPp+8OM4jc
         SRj1fOPiP4VFG8pXWhPNTDWsWACPDjWDbWaTkq77/Sh12X53ueZvk0YmcOedbKzUT9Pa
         HdeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjgazlIeIREC1tiVx3Ul4AgC86cZEy+joWRBAwRhoAZBchIfK664g0spZMHOHz7GDko5cY5H/J5B/e8TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqzd72+P3ZFO/uAG2NkgCsfo690P++iixNwA1goygbZWKqQ4d
	0r6JvuujLpDt6FyZ8hJVvtvToTnEUKIi/8gCEbfSKL3DQ08QQB62hq/0iU5a+mQ7CGJPlbigyII
	igEi8sBzZdi2Xspukd9STpurCnYnV08rhnOpXQg==
X-Google-Smtp-Source: AGHT+IHZzOhozWT/zaACpirlbBqkB9AePGlI8+Gi4sFzG1jRzDW+IwnQjZ8DWZzBKqIJX+L8fdHUbM4O+vIm2GvBe4E=
X-Received: by 2002:a05:690c:4c04:b0:6dd:b7e0:65b2 with SMTP id
 00721157ae682-6e3d40d174cmr2743727b3.24.1728995144733; Tue, 15 Oct 2024
 05:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004103046.22209-1-quic_mukhopad@quicinc.com>
 <CAA8EJprNz-Byy6T3qkkUyZnTkyb_7osyuevP8E-xYzzPSmQjUw@mail.gmail.com> <2a2b1373-6cb4-4813-8736-dd7b12c90c0a@quicinc.com>
In-Reply-To: <2a2b1373-6cb4-4813-8736-dd7b12c90c0a@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 15 Oct 2024 15:25:39 +0300
Message-ID: <CAA8EJpoM5d=NgcugVdXfSNDAWp+nfDVV+jaLAqk1pEg7RvoM4g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add support for DisplayPort on SA8775P platform
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, konradybcio@kernel.org, 
	andersson@kernel.org, simona@ffwll.ch, abel.vesa@linaro.org, 
	robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	quic_khsieh@quicinc.com, konrad.dybcio@linaro.org, quic_parellan@quicinc.com, 
	quic_bjorande@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, quic_riteshk@quicinc.com, 
	quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 10:02, Soutrik Mukhopadhyay
<quic_mukhopad@quicinc.com> wrote:
>
>
> On 10/6/2024 8:30 PM, Dmitry Baryshkov wrote:
> > On Fri, 4 Oct 2024 at 12:30, Soutrik Mukhopadhyay
> > <quic_mukhopad@quicinc.com> wrote:
> >> This series adds support for the DisplayPort controller
> >> and eDP PHY v5 found on the Qualcomm SA8775P platform.
> >>
> >> ---
> >> v2: Fixed review comments from Dmitry and Bjorn
> >>          - Made aux_cfg array as const.
> >>          - Reused edp_swing_hbr_rbr and edp_swing_hbr2_hbr3 for v5.
> >>
> >> v3: Fixed review comments from Dmitry, Konrad and Bjorn
> >>          - Used a for loop to write the dp_phy_aux_cfg registers.
> >>          - Pre-defined the aux_cfg size to prevent any magic numbers.
> >>          - Added all the necessary DPTX controllers for this platform.
> >>
> >> v4: Fixed review comments from Dmitry and Krzysztof
> >>          - Updated commit message.
> > For which patches? How?
>
>
> We have removed the "reviewed by" and kept only the "acked by" for patch
> 1. We have updated
>
> the commit message of patch 5 , to mention specifically about the
> validation of 'only' MDSS0 DPTX0 and
>
> DPTX1.

All of this must be a part of the changelog. It's not enough to say
"updated messages" or "fixed comments". At least please let the
reviewers know which patches have changed and which didn't.

>
>
> >
> >> ---
> >>
> >> Soutrik Mukhopadhyay (5):
> >>    dt-bindings: phy: Add eDP PHY compatible for sa8775p
> >>    phy: qcom: edp: Introduce aux_cfg array for version specific aux
> >>      settings
> >>    phy: qcom: edp: Add support for eDP PHY on SA8775P
> >>    dt-bindings: display: msm: dp-controller: document SA8775P compatible
> >>    drm/msm/dp: Add DisplayPort controller for SA8775P
> >>
> >>   .../bindings/display/msm/dp-controller.yaml   |  1 +
> >>   .../devicetree/bindings/phy/qcom,edp-phy.yaml |  1 +
> >>   drivers/gpu/drm/msm/dp/dp_display.c           |  9 +++
> >>   drivers/phy/qualcomm/phy-qcom-edp.c           | 74 +++++++++++++------
> >>   4 files changed, 61 insertions(+), 24 deletions(-)
> >>
> >> --
> >> 2.17.1
> >>
> >



-- 
With best wishes
Dmitry

