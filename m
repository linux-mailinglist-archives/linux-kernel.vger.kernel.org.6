Return-Path: <linux-kernel+bounces-183643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE4D8C9BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4128D1C21DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA925339E;
	Mon, 20 May 2024 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlyDRv3E"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87834DA09
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716203154; cv=none; b=Za5/w2vPvm2g7a+kTQ0X31xgCKjQ15xYh5HN8zdINkhvsQH40LKw2j7n8fURyNrD+zVh0hhbhQgX8zRhjC6U8MKtAobcGS6XCShTtu9rwqUqD9hXrNxs96zLzgnYaKzxwkCSJa/INxaVoY6KBz7ARMDucXWCPH7vwdPM0iFNDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716203154; c=relaxed/simple;
	bh=GBt4mPPIJDyTxqyToR3FNdTwxv/CDEX8rTMDKHIH0Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtj+csbUnunzooQLQ1L1oo6PgiaeOqj9qu6niS7ASBYExR0PXWD6boOQj/tS2ubCMkq9QbSfHkBSc42MMMwmv7u1Jt1vcRdl+jcnjA7rF2WTqaSyVJuOsmBFB60HiYpc4/Pp/X1QSp5MN38f1Q2N68L9wtdZn1ieM8rHRxjdfaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlyDRv3E; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f71e4970bso4758584e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716203149; x=1716807949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nsnKmHuBmN6J2mWJ2RFHNEE84aeXrDEHjd3h7k4ZwUU=;
        b=SlyDRv3EgCpj6tzXJi58127oSeEEHYk9K9H4tECQf4+E2dbkCT4/2CxzXuXMPUjkGx
         uXdo9MI418aE4x+F7cUQtomCyQtzaLqUqhwmJkF+McBWZu5FoH6Ji1tmjPCBk8h4EuZS
         3L7DC1ciRabTg4Apj9hS1gklZaicsMrya/YbwoyfrLohVmYvTQ7yJZjvG4EUL/46vPXI
         4f45jHARmaOj6lsNmSjUYGXt9bt7btgl2OkEli1K95VSn8c9iJ4TfP2MkWccvlxp++5g
         /F4HyHjpo7DfFqLZ9dxXKcd4kQSQNscW4O3n15EfsQ7y358JrY/j/uscrfWt+7Tp3fmO
         yRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716203149; x=1716807949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsnKmHuBmN6J2mWJ2RFHNEE84aeXrDEHjd3h7k4ZwUU=;
        b=ZmJxC5XpiZSHcG5Ure0ThqX+naQ0t25O7shcrFINca+JTN0MNw3TpWe5pyME73FndK
         PRDoMexxiULjTBkhsNE91pT1+tQGQvwnfP0w/o5/bCKN+phLms14QNswzuNihbVxCzUm
         pkTj6yGcKUZil9XO/DvUx0DQtz8srFOKaR7MXeUQYY7DAyrF+Zj9WPTNpcYM98OENftC
         wnsjbXo9rIXeHmF53mPJBNcV2tSy6fsd8rzhUq7igDLlda+xUKJ71+yXlDrVi1OTzG8h
         DWxSbWT8Pta4v/ZBfS0rCJqqTnspr9rIgJCoLqAhdf60a/D9s7WiNrWfgzsErkKfE++Q
         M1pg==
X-Forwarded-Encrypted: i=1; AJvYcCWxyLw6rpRWcvY73YkfrqSXR9XLFl0++HGwtfXUTtNaiDxeJXu0ICy8m8h66BzXL5Mm2WE0JLG/ogYDOo1iaG5pVpYYkFy8c34XJcYT
X-Gm-Message-State: AOJu0YwYs/QRHBPWadSO67daI1L8ZQbaTSkPnM9YpPFjdxiKgYwWAlby
	Z8EsDsaPe3yst+UJOA9yxziRR+VykCpzQ7VFX4Dg4pN80TSNUC22q29jbSk0Wts=
X-Google-Smtp-Source: AGHT+IECc0/QGytciTsg1Ow4YOo2yweKq3yn/cTZEcTK3KUAdVVZMShgvpI1frMYPXAmC2Lq22cwUA==
X-Received: by 2002:a19:2d09:0:b0:523:919d:302e with SMTP id 2adb3069b0e04-523919d325dmr15436572e87.7.1716203149103;
        Mon, 20 May 2024 04:05:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba912sm4180788e87.75.2024.05.20.04.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 04:05:48 -0700 (PDT)
Date: Mon, 20 May 2024 14:05:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] drm/ci: update xfails for the new testlist
Message-ID: <fbfo4juetokyhe6xsvxbfr3fakdushntnhlrpgbfttc22kvrc3@p3qr6qh4w3rc>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-7-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517092502.647420-7-vignesh.raman@collabora.com>

On Fri, May 17, 2024 at 02:55:02PM +0530, Vignesh Raman wrote:
> Now the testlist is used from IGT build, so update
> xfails with the new testlist.
> 
> Set the timeout of all i915 jobs to 1h30m since some jobs
> takes more than 1 hour to complete.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Set the timeout of all i915 jobs to 1h30m and updated expectations file.
> 
> ---
>  drivers/gpu/drm/ci/test.yml                   |   6 +-
>  .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |  41 ++--
>  .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |   6 +
>  .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt |  18 ++
>  drivers/gpu/drm/ci/xfails/i915-amly-fails.txt |  31 ++++
>  .../gpu/drm/ci/xfails/i915-amly-flakes.txt    |   8 +
>  drivers/gpu/drm/ci/xfails/i915-amly-skips.txt |  11 ++
>  drivers/gpu/drm/ci/xfails/i915-apl-fails.txt  |  46 +++--
>  drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt |   5 +
>  drivers/gpu/drm/ci/xfails/i915-apl-skips.txt  |  15 ++
>  drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  |  38 ++++
>  drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |   5 +
>  drivers/gpu/drm/ci/xfails/i915-cml-skips.txt  |  14 ++
>  drivers/gpu/drm/ci/xfails/i915-glk-fails.txt  |  41 +++-
>  drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt |   6 +
>  drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  |  15 ++
>  drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt  |  42 ++---
>  drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt |   6 +-
>  drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt  |  25 +++
>  drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt  |  77 ++++----
>  drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt  |  16 ++
>  drivers/gpu/drm/ci/xfails/i915-whl-fails.txt  |  63 ++++---
>  drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt |   5 +
>  drivers/gpu/drm/ci/xfails/i915-whl-skips.txt  |  11 ++
>  .../drm/ci/xfails/mediatek-mt8173-fails.txt   |  30 ++-
>  .../drm/ci/xfails/mediatek-mt8173-flakes.txt  |  10 +
>  .../drm/ci/xfails/mediatek-mt8173-skips.txt   |   4 +
>  .../drm/ci/xfails/mediatek-mt8183-fails.txt   |  21 +--
>  .../drm/ci/xfails/mediatek-mt8183-skips.txt   |   4 +
>  .../gpu/drm/ci/xfails/meson-g12b-fails.txt    |  24 +--
>  .../gpu/drm/ci/xfails/meson-g12b-skips.txt    |   4 +
>  .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |  12 +-
>  .../gpu/drm/ci/xfails/msm-apq8016-skips.txt   |   4 +
>  .../gpu/drm/ci/xfails/msm-apq8096-fails.txt   |   7 +
>  .../gpu/drm/ci/xfails/msm-apq8096-flakes.txt  |   5 +
>  .../gpu/drm/ci/xfails/msm-apq8096-skips.txt   |  12 ++
>  .../msm-sc7180-trogdor-kingoftown-fails.txt   | 175 +++++++++++++++++-
>  .../msm-sc7180-trogdor-kingoftown-flakes.txt  |   7 +
>  .../msm-sc7180-trogdor-kingoftown-skips.txt   |   7 +
>  ...sm-sc7180-trogdor-lazor-limozeen-fails.txt | 175 +++++++++++++++++-
>  ...m-sc7180-trogdor-lazor-limozeen-flakes.txt |   5 +
>  ...sm-sc7180-trogdor-lazor-limozeen-skips.txt |   4 +
>  .../gpu/drm/ci/xfails/msm-sdm845-fails.txt    |  38 +---
>  .../gpu/drm/ci/xfails/msm-sdm845-flakes.txt   |  26 ++-
>  .../gpu/drm/ci/xfails/msm-sdm845-skips.txt    |   7 +

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # msm testlists

We'd need to triage why the tests are failing, but at least it looks
logical from my POV, no more full-test skips, etc.

>  .../drm/ci/xfails/rockchip-rk3288-fails.txt   |  62 +------
>  .../drm/ci/xfails/rockchip-rk3288-skips.txt   |   4 +
>  .../drm/ci/xfails/rockchip-rk3399-fails.txt   |  83 +--------
>  .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |  12 +-
>  .../drm/ci/xfails/rockchip-rk3399-skips.txt   |   4 +
>  drivers/gpu/drm/ci/xfails/update-xfails.py    |   4 +-
>  .../drm/ci/xfails/virtio_gpu-none-fails.txt   |  94 +++++++---
>  .../drm/ci/xfails/virtio_gpu-none-skips.txt   |   4 +
>  53 files changed, 1010 insertions(+), 389 deletions(-)
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt

-- 
With best wishes
Dmitry

