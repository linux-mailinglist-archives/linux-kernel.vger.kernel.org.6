Return-Path: <linux-kernel+bounces-524082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD97A3DF0D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A277A1D18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEFA1FECAD;
	Thu, 20 Feb 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaJh0gSh"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7821DE3D9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066018; cv=none; b=hlIzBcG1Yj/fFEszzjXkV3cJOnM9zEzaV5edWmhKVqx356sLzYvNgg9EA+KalpsUiaaxbLsK+5aeEZXvU0bDF4lsoofMvHnetA81/wn0bgTYbq08jwgSozVGpysrLd1jvM4Pjz5SJgMAonyI/tWV6AXyagCNBZw2QevlLx5QEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066018; c=relaxed/simple;
	bh=QzUct+KndAjVKXbG8XpNZWnNqhY8tjjZDMXHiF5+5/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/9BFw5jpvxq3URECCOYldsLeParmS89U/KZqdhaEv2eggKOEu+a4kE6NLCVCJByxMP/iKmZVTFfI0jNdXwdRgtG8y78tnWtPd/aD7lhnbugUvYZxrJTdU8cGKBX8zWrraWU/PjUh1D2NDcDD7m+5bhYu6bhjvmQnUsMxYHY5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IaJh0gSh; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f7031ea11cso9224697b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740066015; x=1740670815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuoPq2e93XPbKnAaHkR9ErZM40sqwUWhuIwAQ7Wv18c=;
        b=IaJh0gShCWhMBWSZPiL4GMMZQrXIm6kmfSHwjbWiAL3xe/xmaoCPYiEcAXTirpbwoU
         UJGsAWPpHOgPM3VA9Sor8tmqLHUjk+4cMmP2r79NcY+99VAGdDh8qpHM/e+eKt5340Eq
         O4yNPRoZU4m1avLXrjyXhIP9dBAj6bQuOkqIiYyN2jbXXOUhoC97nDA0VYPPdWUJdGW3
         yUQvsSyn/NcCHWFrYTrYcebKv/gesx3JgUaHvmFySyl5y7vQp7Opz+IXvp9Fo2+HMtss
         U3zr3hedZtdF5hRCiMouiSRNkGmBpgzpkTbD3s1p5cnASTiamV5nhddPFbDUMtMpSDaC
         9kYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066015; x=1740670815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuoPq2e93XPbKnAaHkR9ErZM40sqwUWhuIwAQ7Wv18c=;
        b=jYFB4GPl2b5XyZi0Nn6cOYVIg5YXzjfWQv2vIxqWtN1VPLvLsScCVQIkGFJ5t3rcNa
         V5O3QTCJi0OwQ+AEcZ8/moPpBA1/XM2PJCsDIvy+hGm8q4A+AlBU4+Os+7yhCLpvfxRh
         o3CXZknWFWu6A6ldH0Srjo5qqbFo2uAETlHih/9gyRq8Iv0HaIK9heQAZhvIrTqCgJLL
         L50xLX6QEk/VqysyUrtzOEAKDfFtmrX5wXK93FXFRBUxeQAOakZJjPV5bh/otpeuA+kU
         aUmsUBvDNULcBFi3Oe5HwsKyP/nL+kjnft3bvPcdxXoiAkM4iLAMrBAVP5SbtE2rmvVW
         dMzw==
X-Forwarded-Encrypted: i=1; AJvYcCVfw8iTocZ+zwrJrnTCnHDLiNSskDQKN6R0syFBs35n2Y8ZX8SudpM3kvHuQf0j44TdM7iZI5aWgQguCPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3F/JthaoBZmAWCVrEzzP/hf88Z+KkjfylJpFZm65bLQi+es6i
	P9N/gjnxoqxi7UjVnm41NoKnATdJ8Ey7zjX/S1UkH5bPwUL5TeLt1NtS72+UsE3WjIhw1pB24Xy
	mX5qQUFquvuqm7lF8KRhpd+p2AiYDMR6hf4ECZA==
X-Gm-Gg: ASbGncsbZUwAhv5UY1/jrDZLvsfVPt4WYqOFKbWdbtPZcqti38KKT84wcQ7K0TedJWV
	bmG3C9zIVGewXFYxLgGDqlAxFWwEjjPnN5b9Hym16GIew2f7G9yPYpsLYC5ZOvHokopZFCs6Ut/
	MA
X-Google-Smtp-Source: AGHT+IHtHZhFj6w8a+w7dVjeZYWKiittrIVs8CqnEw31ZTbZ6uSF2vKph0PXxTGqAHFiH+3dzNT93tQlYHmsEeOEsb4=
X-Received: by 2002:a05:690c:fcc:b0:6f9:82a8:e5dd with SMTP id
 00721157ae682-6fba579f34dmr76095757b3.29.1740066013981; Thu, 20 Feb 2025
 07:40:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-dual-dsi-v2-0-6c0038d5a2ef@linaro.org>
 <20250220-dual-dsi-v2-4-6c0038d5a2ef@linaro.org> <grdadzunaabzg5jxpsiasgzbioy24tctlhhyxg6zwdkpv5vjwe@7k2di2myu4k6>
In-Reply-To: <grdadzunaabzg5jxpsiasgzbioy24tctlhhyxg6zwdkpv5vjwe@7k2di2myu4k6>
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 20 Feb 2025 23:40:03 +0800
X-Gm-Features: AWEUYZnHnOuixko96mQ2117kijVCx6xdBgICQdXQ3HuBcopAGGxNVlm-TLHVG9A
Message-ID: <CABymUCMn+USbm21agBZbe=JmV-FzLdVD4s0xgg0CPU=M9jvC9w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: display/msm: dsi-controller-main:
 Document dual panel property
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2025=E5=B9=B42=E6=
=9C=8820=E6=97=A5=E5=91=A8=E5=9B=9B 18:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Feb 20, 2025 at 06:07:55PM +0800, Jun Nie wrote:
> > The DSI interface can be connected to a panel that has a dual DSI chann=
el,
> > or to two separate panels, each equipped with a single DSI channel. To
> > prevent the DSC configuration for the dual panel setup from disrupting =
the
> > current configuration of a single panel with a dual DSI channel, add a =
dual
> > panel property to support the use of two panels.
>
> Please use the terms from the standard. The "channel" is mostly used for
> the "Virtual Channel" or the "logical channel".

OK, will use DSI link for all later description.
>
> Also I don't follow how DSC configuration for a dual panel setup can
> disrupt current (?) configuration of a single panel.

For the disruption, Marijn mentioned it in the last post.
https://gitlab.freedesktop.org/drm/msm/-/issues/41#note_2411541

>
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  .../devicetree/bindings/display/msm/dsi-controller-main.yaml      | 8 =
+++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controll=
er-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller=
-main.yaml
> > index ffbd1dc9470e2091b477b0c88392d81802119f48..e3f2eabde27609a66d6d81f=
afcb14e1bc014613c 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main=
.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main=
.yaml
> > @@ -88,9 +88,15 @@ properties:
> >    qcom,dual-dsi-mode:
> >      type: boolean
> >      description: |
> > -      Indicates if the DSI controller is driving a panel which needs
> > +      Indicates if the DSI controller is driving display device which =
needs
>
> Unrelated change
>
> >        2 DSI links.
> >
> > +  qcom,dual-panel:
> > +    type: boolean
> > +    description: |
> > +      Indicates if the DSI controller is driving display device that c=
omposed
> > +      with 2 independent panels and needs 2 DSI links.
>
> How is tht different from qcom,dual-dsi-mode?

Your questioning is right. The dual panel case is a subset of
dual-dsi-mode, not parallel with
dual-dsi-mode. It is single panel with 2 DSI link by default, and 2
panel with 1 DSI link in
each panel if property dual-panel is present.
>
> > +
> >    qcom,master-dsi:
> >      type: boolean
> >      description: |
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry

