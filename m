Return-Path: <linux-kernel+bounces-328088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB11977EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7819C1C21036
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17601BE872;
	Fri, 13 Sep 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btETFu/e"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A31D86E9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227860; cv=none; b=UUVlIMwhblpPyq6DY0IJOPrQDmGVL+G+51kRabOhhRc4OHrISQJ4upvN2KnPx1jxLrYonQQEL39abCl5nG7Lbbgd7jtQJt0Bc2Xb83fkG/CgEwJ6mvo0FtDbbn9/sGYsLeQZP4RfN14NvA43h2h1XVXLIo6n7BFPhvBg+GaKh6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227860; c=relaxed/simple;
	bh=WVlZCBI9rR2tjRj8gt8fXMMXF7h6R8iX/uuUUMIMVB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alMk059qlAikQecO7RwOagfOTmriOYaDGLb+rD4esHw2B+AY7TvXM/EgIRfZ+gK0d88lQoUI6gJrorFveDXgp16b6+lOSOiOeLHSi6U191DMwIuB7XgkazM+fbAypISA7PG3Usa47pgMamGS6XbmtMzEcVv1uLiNRaPUuo8sTPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=btETFu/e; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6daf46ee332so6712397b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726227857; x=1726832657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bpGVAz7F68gq4K0wsGbVi84hQs0Zw4wJBgelJinUR+M=;
        b=btETFu/eJkaWeaPR4uNkeJRV3qiNNP2xq8PaYYDqHkY1Moy2uAaYuVyB9F+XRXX6bs
         RbOdB/Yvyj4CVE1GMyWmbHANPUnpsy1Z0d5tBtNHqclHvaYofO7t7wb118hgGfkvipQp
         /OtNq04hLtp4P5oZ2xNU8/QiSn8vS57lIB8mBaBFMg1ZNGC8/lGg+6UA2bi9z/lACDrK
         IfT0AS0WXLbilyN44jO/vnV9tl3pg3gge//J07idEmv1ecMqPSXBtQKSm+39/XXIw5Ou
         axC9lgFoUphFrImX0rsLcaGB7my3oQpET+7mztrehV7E8QQvkEFuntzobZBZaaUvFMQC
         nf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726227857; x=1726832657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpGVAz7F68gq4K0wsGbVi84hQs0Zw4wJBgelJinUR+M=;
        b=EednYozYadaiCp7gQgzpd7WaKoBopdLSjEmBH4ZQKKMkuKQ+nTXZuuWkeEKkiVD8q/
         3IPQwadZpM0Pt/dN7KzjksuJ7UplSx8tgGN96yrlfMg1ypn5DU73gADViHTvh1Y/+tjy
         u16YuGqY+9IFM9xrH69R/MhBCwudT9Y3s6yIxEMStF2cLynJf738qQpk7Z+MNYCTLVmt
         LWt9SCgPO9YRIv/fRGyf9SFher+IkLHaAX1spBS8pNe3cQgsFfE0nmUJsSMaW/CgKR3P
         8McIVxeFG1Qp8DIoPIN3Na/BAUWh2Nh/E5WeTf6xe2+tsHE382QojTqQCnS50m8R2D28
         q9lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxVATvFp6YNdudfTd0DROxhOlcQSPjQNQbKOdqJ6w6/2v4vyhIbkGg4iZljwPWWF2Kr+vZxkGW+na5784=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSG4UiVB246SRhvVp5yMpJHN11RHiZIxfhQB79P0XzopGftQSb
	6yj0Rr0o2K2q2iZrm20CjmRo9HyQTVtODGLmpKzIHvvf311HxHvQykcQ6CDJv7mNsDGFW1x2+up
	wMViUhwHd/99XuMMZ1+1aA07SIeZzho/wDZ+Ctw==
X-Google-Smtp-Source: AGHT+IE+HCTz9/Hpne7uiESMruAIZ8sOYY9ablamvHhKXDnIFQMaJZtzXwjRu+Y8yXtv+wftvk256sWwlMRwxMdIsno=
X-Received: by 2002:a05:690c:3708:b0:62f:aaaa:187a with SMTP id
 00721157ae682-6dbcc26265bmr21823667b3.14.1726227857290; Fri, 13 Sep 2024
 04:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913103755.7290-1-quic_mukhopad@quicinc.com> <20240913103755.7290-6-quic_mukhopad@quicinc.com>
In-Reply-To: <20240913103755.7290-6-quic_mukhopad@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 13 Sep 2024 14:44:06 +0300
Message-ID: <CAA8EJpqyr0b4zUZ3h+bTASru74fm1U9LGJkpqcQhEChH2EexXQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] drm/msm/dp: Add DisplayPort controller for SA8775P
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

On Fri, 13 Sept 2024 at 13:38, Soutrik Mukhopadhyay
<quic_mukhopad@quicinc.com> wrote:
>
> The Qualcomm SA8775P platform comes with a DisplayPort controller
> with a different base offset than the previous SoCs,
> add support for this in the DisplayPort driver.
>
> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> ---
> v2: No change
>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index e1228fb093ee..e4954fd99eb0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -118,6 +118,12 @@ struct msm_dp_desc {
>         bool wide_bus_supported;
>  };
>
> +static const struct msm_dp_desc sa8775p_dp_descs[] = {
> +       { .io_start = 0xaf54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +       { .io_start = 0xaf5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },

Please wait for the discussion to end before posting new iterations.
In this case Bjorn pointed out that this is not the full
configuration. Please add a comment, describing that there is a second
MDSS, which isn't declared here as it wasn't validated.

> +       {}
> +};
> +
>  static const struct msm_dp_desc sc7180_dp_descs[] = {
>         { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
>         {}
> @@ -162,6 +168,7 @@ static const struct msm_dp_desc x1e80100_dp_descs[] = {
>  };
>
>  static const struct of_device_id dp_dt_match[] = {
> +       { .compatible = "qcom,sa8775p-dp", .data = &sa8775p_dp_descs },
>         { .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_descs },
>         { .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_descs },
>         { .compatible = "qcom,sc7280-edp", .data = &sc7280_dp_descs },
> --
> 2.17.1
>


-- 
With best wishes
Dmitry

