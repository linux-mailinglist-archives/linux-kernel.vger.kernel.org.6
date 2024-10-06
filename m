Return-Path: <linux-kernel+bounces-352440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FD5991F3C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E310DB219B1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 15:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B391465A9;
	Sun,  6 Oct 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BG7p6yPP"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F85143C41
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226868; cv=none; b=HeB41NQ1TzgciPutTcRb2jK7eXFVKkPHddjSV6k6QpinRh6iFQ+JcJHe1KXHnvy+EgP4vuyziyxsaRGgqfFGl8Kb4iruyrWEIUOxo3McCN4OtPN/9ImNlvKmBu50e5t9rAK5tsdJwba2Ly096nhFHhcu1be65ElGmozEYloHHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226868; c=relaxed/simple;
	bh=3Jox7XDbaksL3rWHMjU19bnxw0/FsWSY+Vx94uMawHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXkpwYEiiMOFeTYhpmyBPPTGwdU/ajyB/ed9xHGF7Hc1vjGVvY6l0I0RqJFnS2GN/yv9jzqN45ALcSoslvdxyN9yxIcSjiHqdiPeXPltaMQ18azBCl1OQ6tQ2fCH3Hus7a7j8fe+YbvCr5i8EMJ9ZU6F2aiox9awXZWhEqmu5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BG7p6yPP; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e214c3d045so27067227b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728226866; x=1728831666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sr7kBmgWEcI5rnWGX+RCamDzTizwOpc6au1fxKMuuS4=;
        b=BG7p6yPPrCaRuC+CVEmOsKToR3szaMm/J0UDvq0hMCM3X9xGFCNwQF4sK7w/uhyWbD
         g/62NLP8hMIAEJ+4CIxgv2tEOE0UhzaBFqx4pcKKZrHv20imtZK+jQhqvpmFvaZ0bgXD
         4jvEzDnIgRy2wjlNpJogsmCO2DNHB3p0v9+c8Sw6UhFOLULbhxpUJzrrV1JsVh9AxyfQ
         V+w+SiAEKiX27EORDnXZ3lpy11qzheBiiGYS5/mTXyt4KIfvlBwlb9QkZAMAv+EbDhW2
         jXt9Rja0NuE0QQZVb8mdBOlv35O6mr40oOs7IpUDG32PpO90QwWVLrqT1Nf/I+7wLJHR
         TSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728226866; x=1728831666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sr7kBmgWEcI5rnWGX+RCamDzTizwOpc6au1fxKMuuS4=;
        b=mlg8yCrnyrk15ojtUQTnLLyAHsuyfkNwlVAPLgYdoSkueTBuKeg+QWqUD/ai8XRK1k
         sCuIspZlTEilJXq9at76KhtmSQ+XpPPEtRac3Njhe2mXsEx5kla/uB2+sViFslaBG+MN
         EnQ7PKCMSsFpLEolr2ABXha1/3kqVHccpDkY/mVSiPWxyZhs5bKuWnqcnGj5mdtvmcCU
         gtb7hCGPMh5qwRjdH7I2r61vqUECn7AyZJ3+dB+4ULHyeCDOS7AC4JRuCFeZs8xxBUEj
         DFlSJLiID/x4UZc5bMLlxMWZH3mgPVGqyIqkta6syeYgVC3si/d1VzM5giXjoUxNifBS
         LFpA==
X-Forwarded-Encrypted: i=1; AJvYcCULu3moMfxGTUlNmvXNtGQsYmsBn3QgowKW5VyLAKr4agFwU4KC0+4ZjOaqcFFmVR90F0Q7YNWEs0bbGpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBOR2D3tkd8rYhU4kstuRD64F7vFW8/004H3Lv7ouXbRMlnLpW
	hAp4HkzR75KZg1CEjl2goLWFIFufOARxx/PhQp9ahEz006q92GW+6enRK1AaUf8Mm8zaZHS5xFo
	q3JID/nLWAThNpNwbLyU2A+DV7xPBj0bIu1e0og==
X-Google-Smtp-Source: AGHT+IEJycb4R4aw3ReSCNgChwzrEXysCheiplWAjzc1sd3W64fhBUYqqbDLQsAk4nGd84s5GZgRtnV6rDxt3bUR/NM=
X-Received: by 2002:a05:690c:101:b0:6b1:735c:a2fc with SMTP id
 00721157ae682-6e2c72466ccmr69109727b3.27.1728226866169; Sun, 06 Oct 2024
 08:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004103046.22209-1-quic_mukhopad@quicinc.com>
In-Reply-To: <20241004103046.22209-1-quic_mukhopad@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 6 Oct 2024 17:00:55 +0200
Message-ID: <CAA8EJprNz-Byy6T3qkkUyZnTkyb_7osyuevP8E-xYzzPSmQjUw@mail.gmail.com>
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

On Fri, 4 Oct 2024 at 12:30, Soutrik Mukhopadhyay
<quic_mukhopad@quicinc.com> wrote:
>
> This series adds support for the DisplayPort controller
> and eDP PHY v5 found on the Qualcomm SA8775P platform.
>
> ---
> v2: Fixed review comments from Dmitry and Bjorn
>         - Made aux_cfg array as const.
>         - Reused edp_swing_hbr_rbr and edp_swing_hbr2_hbr3 for v5.
>
> v3: Fixed review comments from Dmitry, Konrad and Bjorn
>         - Used a for loop to write the dp_phy_aux_cfg registers.
>         - Pre-defined the aux_cfg size to prevent any magic numbers.
>         - Added all the necessary DPTX controllers for this platform.
>
> v4: Fixed review comments from Dmitry and Krzysztof
>         - Updated commit message.

For which patches? How?

>
> ---
>
> Soutrik Mukhopadhyay (5):
>   dt-bindings: phy: Add eDP PHY compatible for sa8775p
>   phy: qcom: edp: Introduce aux_cfg array for version specific aux
>     settings
>   phy: qcom: edp: Add support for eDP PHY on SA8775P
>   dt-bindings: display: msm: dp-controller: document SA8775P compatible
>   drm/msm/dp: Add DisplayPort controller for SA8775P
>
>  .../bindings/display/msm/dp-controller.yaml   |  1 +
>  .../devicetree/bindings/phy/qcom,edp-phy.yaml |  1 +
>  drivers/gpu/drm/msm/dp/dp_display.c           |  9 +++
>  drivers/phy/qualcomm/phy-qcom-edp.c           | 74 +++++++++++++------
>  4 files changed, 61 insertions(+), 24 deletions(-)
>
> --
> 2.17.1
>


-- 
With best wishes
Dmitry

