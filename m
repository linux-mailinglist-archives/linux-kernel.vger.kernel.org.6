Return-Path: <linux-kernel+bounces-326142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA99763A8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A4D1C20892
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B19118FDDB;
	Thu, 12 Sep 2024 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1WIYOmy"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09D189516
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127807; cv=none; b=dR4wpHXjxRMqKsXoy0wHsz5aEL5oQv3Cz2ZQhAgQ4/yjMzjHKNNlAmoONTgpJGridiAGZvAuUX07dP2iOPZIv7Y612d/g46Deoy1Llj6JDJzVu8AEbayoJxE6b7lH9zQFXvoJFL4pD4osjXUXlOa+QZgAKnLBlPHFc6L8BUkNBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127807; c=relaxed/simple;
	bh=ixO4eAmSsyxYP705i69Tpb+LkysSM4JEOUqvDo0Heu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqRTLlJ6TTEmWCy8Dp/c3q5dfmNk+7QQhhpuY0LQsJlEc2cDZwc/wJblZcb3cB/axZcHJVIMegFYcFYUVt2EF5S+qzpT+dXMKc5FP/EnrYzKZMs73+jCvV+Izv36CTLHMKaMAl/gn6Xrfq74dOqux0SlaIiTDN7nLgnbg0ktw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V1WIYOmy; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f763e9e759so7200381fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726127804; x=1726732604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzUy16PQ8SDXmHcug8jXm/7h574vKZnBpTKJTICvI5k=;
        b=V1WIYOmyvSEUhyx5B/vR/Gwh9FEp7kZBcDYs4ifdZSaiJywhDOBs08UeGXCKMkqZ+p
         rsn/5+A6eNJCtChho/5dK8kAfQoSxMSKadZr2gTi73uH1LQ2/CPw5DVGgzrCP3SHeUiY
         49aNA8MOs1XR1WElidhx8YQAe8PAVboVQp81c8fZotmoOjSBkkb8vdMd928bPrGpP49v
         b2aGxxiNrUAAIikjEn+tHb00E0LByb7Cb6Gh7ILk+NDz3GeCpyQVgU5/E2RRBdyEvtlI
         c5HkkRJmt6K2SbDk8xCc/Efke4g9zS/q+NOPi6YQcS7cqkNpVvuYBuOR/dU64eeiID0O
         nIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726127804; x=1726732604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzUy16PQ8SDXmHcug8jXm/7h574vKZnBpTKJTICvI5k=;
        b=M35lVqcqJHIjfEPrFXS7klwRAtiik3Ky0ggXiqQj4nVvJQdTg6adhhi0xfvwge2ylG
         scchXIAuGX/TUL2mN2M1ly05c+xL0BDA9u/6wHax3z4fCIIvje7ovD4FuVBw8Y3MKnuN
         AGtpFJR9HndJDze9LcMFK7KUUv3xIvDJ8K7FJehZKdqa8BKKCgBSnu0/mP2Bxvpj3IRx
         rL6OhlPbHsAmKyLxIG2bD+CqfVjTKNp9ro7pvBuPv9vpggK9DMSwCkZ8DQlt73ogmiSa
         aik0HxYKZYcayEJcX7cZHlhW7xrh01LqTntTNj9jTX9KVS2dsQ5sAfxjBd5JRd0H9yD1
         HC/A==
X-Forwarded-Encrypted: i=1; AJvYcCVjcKMfyFjI9GWGltyjcEds94M5f8p4FDm873GqECzVUlqeMTTpigyXEdphh85i9kpg/Hu+T6KPBzocFWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZiEqsirGQoEf8zVCbZJOZqHVpEhrjZxdZHuJk6IqEDZQ41v4
	920zN5rXj2GORsKYxGAWYvMcqC2zZAxjUZa9M3AMCH4K8l/1ENO/OuAL/Lls3Sk=
X-Google-Smtp-Source: AGHT+IEO+oaR2J+/C5HWt9j3Jqj2WBAglLEJ+Odvyq26KObdZCTNoi/+ljmrdSm1pK1NNmf0NzUFaQ==
X-Received: by 2002:a2e:be91:0:b0:2ef:2016:262e with SMTP id 38308e7fff4ca-2f787ca97e6mr12162111fa.0.1726127803444;
        Thu, 12 Sep 2024 00:56:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c07c897sm18188401fa.75.2024.09.12.00.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:56:43 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:56:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Mahadevan <quic_mahap@quicinc.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, swboyd@chromium.org, 
	konrad.dybcio@linaro.org, danila@jiaxyga.com, bigfoot@classfun.cn, 
	neil.armstrong@linaro.org, mailingradian@gmail.com, quic_jesszhan@quicinc.com, 
	andersson@kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_kalyant@quicinc.com, quic_jmadiset@quicinc.com, quic_vpolimer@quicinc.com
Subject: Re: [PATCH 0/5] Add display support for Qualcomm SA8775P platform
Message-ID: <7fcbvouzb7gq6lclrkgs6pxondvj5wvutyw3swg55ugvzfpvd4@2ph7x7ulxoyv>
References: <20240912071437.1708969-1-quic_mahap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912071437.1708969-1-quic_mahap@quicinc.com>

On Thu, Sep 12, 2024 at 12:44:32PM GMT, Mahadevan wrote:
> Add support for mdss and dpu driver on Qualcomm SA8775P platform.
> 
> ---
> This series depends on following series:
> https://lore.kernel.org/all/20240816-sa8775p-mm-v3-v1-0-77d53c3c0cef@quicinc.com/

As such, it probably can not be merged before 6.14 (the mentioned series
will go on 6.13, we usually don't do cross-tree merges into drm). Please
rework the bindings to drop the dependency (it is possible, use fake
nodes instead of using dispcc + ID). Then you can specify that only the
DTS patch depends on the dispcc support, allowing driver changes to go
in first.

> ---
> 
> Mahadevan (5):
>   dt-bindings: display/msm: Document MDSS on SA8775P
>   dt-bindings: display/msm: Document the DPU for SA8775P
>   drm/msm: mdss: Add SA8775P support
>   drm/msm/dpu: Add SA8775P support
>   arm64: dts: qcom: sa8775p: add display dt nodes
> 
>  .../display/msm/qcom,sa8775p-dpu.yaml         | 120 +++++
>  .../display/msm/qcom,sa8775p-mdss.yaml        | 225 ++++++++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  85 +++
>  .../msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h   | 485 ++++++++++++++++++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |   3 +-
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   3 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   3 +-
>  drivers/gpu/drm/msm/msm_mdss.c                |  10 +
>  8 files changed, 931 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sa8775p-dpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

