Return-Path: <linux-kernel+bounces-268224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716A19421E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1B8B25561
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A53618DF8F;
	Tue, 30 Jul 2024 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKqMCpOa"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287D18CBFA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373115; cv=none; b=h+srXGVsRPb+11ipKZLbSvabGfSB8ZG8w0fGOaHCB1vZB2S0ld7v9Z5Vvbo4zJu6tGjXiOiWpLA3wzB+jRze5vsFB1pabC5FJTvo39BgMmUWPoTriVmBZ8G/+DQ6UECbsJvdhFQXl+/SRfKSXKyL/S2CuMVHswlmlT0Dzwsbsew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373115; c=relaxed/simple;
	bh=3/SEiqWdCXWfREAnZZZGxVcrWr3ChW5LVTuGfVetJZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2gitfYkSA0eRgjqe22Sh3m+dD3EcHbhrfX9skZyDVOM0vw8J0H3Hzs4lONKw67J6bvSRN+qJfUqRrwpIwlUlVS250tML7EYcRYlbS0al9QbuW4mpGNa0gQrmtbJOg5d/ou6kYF5iP1dUSXNrmfSg8FMfL7uRib6erCrskD8aTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VKqMCpOa; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66108213e88so36226277b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722373110; x=1722977910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XGUaTjGQRuAuPX6hVxi1800E+WAYIuykUFeGcako8TA=;
        b=VKqMCpOaFkGGZuE1P6zpodPULKnheFEAS8EoepJJwDfClBX2EGOLmvMR+e+ceccFq3
         vjd43xHVWRongpjK8PAG/hpOCLFaDvHHX41JJrLl89LgK2t42SSCoN+YKep7jRGE3GmO
         a7i6AyNoBk+9oPthSQXApNV8yTEmFgxmS+dBZwDPJkiSd94K3AoR/1hONi7b6UM3SAbj
         wXHjOWgLfqdohFueMJF6y6mS/LDKUtiHlz4HmnQRQQicTT0ZGM+Z+FGcXfP0q8ptlX8P
         S2LOHgUKdVVmPSCoexJBVMnOdtU8eEmi8NdPq0UaNFr6O0IYzdVZjRU8l2SHb3SLo6AL
         30eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722373110; x=1722977910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGUaTjGQRuAuPX6hVxi1800E+WAYIuykUFeGcako8TA=;
        b=jhJFoOHWiFch0j9+L/9h5tZ9brAHUEAVeG08WArau0VxMIU5hXl858bEOUzSxHxtTy
         oKlnSzOBtmCD2uKTaulanEaUmr7rS77IEWV+dW9aDDlgdNrzGiS/OU8meCukfwQwhnLA
         IY5JrLb6kI7f6sJ1Ncx41me1pXPAhe2GHp3Y9s/6ul2lwOKdQ5BCYJ73wdpeJf3a+AHg
         U/ILEnV9E7Dv0bsgw/Xg9dbyHt62+U4Y6JWMU7Q3Wzb/49I/KtmYMwTabhfSAhp8AnPt
         1TvY7tdFq47pduuq2XpLVNpj2FSMNmSHrzy4duhoMPOIc74sIjB7S3t93o9SPVPOOVPa
         7K+A==
X-Forwarded-Encrypted: i=1; AJvYcCXUEZ4GKMRTWtxxKhJj6nIm4jplV94OYcQ4dA8qSFWUwbhknkxjaMNprcVIzkUydJEHp1EqTxjy8dUfCwG3+BgzC0e2IdnAOu4O4h51
X-Gm-Message-State: AOJu0Yy3AUl3A0ws8VtmYW8IhADlLbrCygwNLtl1I+oOF2CUG4wqRfI/
	1+oDpwqDf7wVbIM1WXRuJs6ChA9xGuXXBveVPsUMe8qGppD8vYzVbRqZMSENJSU9mo6BZ7N2i8G
	m7xDGCcL7PjcQNX8FfJLnCdD+uK602R1pTHe52A==
X-Google-Smtp-Source: AGHT+IEFdstUV3s569N4xmNZPfLmtLOuBbMPT23NlFXs8kvp1e28N7b4BtDXg7e18g/cEAZfmGMoiN3PiWKUt0ViFDg=
X-Received: by 2002:a05:690c:f05:b0:650:859b:ec8d with SMTP id
 00721157ae682-67a0625250cmr156264557b3.10.1722373110344; Tue, 30 Jul 2024
 13:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730195012.2595980-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240730195012.2595980-1-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Jul 2024 23:58:19 +0300
Message-ID: <CAA8EJpp0pQ9j6qQbQajUj=qHdYWeiB2nedT0oQhxsGjs3t53CA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: enable widebus on all relevant chipsets
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Abel Vesa <abel.vesa@linaro.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com, 
	swboyd@chromium.org, dianders@chromium.org, andersson@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Abhinav,

On Tue, 30 Jul 2024 at 22:50, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Hardware document indicates that widebus is recommended on DP on all
> MDSS chipsets starting version 5.x.x and above.
>
> Follow the guideline and mark widebus support on all relevant
> chipsets for DP.
>
> Fixes: 766f705204a0 ("drm/msm/dp: Remove now unused connector_type from desc")
> Fixes: 1b2d98bdd7b7 ("drm/msm/dp: Add DisplayPort controller for SM8650")

The issues are present in the following commits. Please consider using
them instead:

Fixes: 757a2f36ab09 ("drm/msm/dp: enable widebus feature for display port")
Fixes: 1b2d98bdd7b7 ("drm/msm/dp: Add DisplayPort controller for SM8650")


> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

-- 
With best wishes
Dmitry

