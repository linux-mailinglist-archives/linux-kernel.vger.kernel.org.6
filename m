Return-Path: <linux-kernel+bounces-324689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD9A974FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BD32856EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D0D183CDC;
	Wed, 11 Sep 2024 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mvwpxDgk"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88091547CF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050907; cv=none; b=LEjEczXYtAQ7N7K/VHRl5YcndoRv9zxFV4oQwRNjtePlVOvCFYxmCXIOhPq3jLK5cIOHyfIycu0/sadpLmlRqXUUmWaVCWgXQYdeXMTK7iPFNSxVb3czK401LlmEiJvFpcLCme/yTPeN0psm9Uivbr/cgkw1rO+vadqpq+kjtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050907; c=relaxed/simple;
	bh=4WFqUAa5CvltBYPVoHBvpobWnjtHZ/LE2o9XMkPycYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4OHGUVDZcqzleoCReaEdnXuSMMl1jXBqxQO3bgIWNzBp8pT9ok2ED/3S5ktiVQ7bOhcrVBsnTkDPM7CWLYZLY7dqXroi9oD4otvopS+qKXZLvTn/RW1tWUVt8liT4irUsgsYirZkFDiKfZEgNO5Zhs9EK+oE0yqjYog5Aa8bu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mvwpxDgk; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6d5893cd721so56753557b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726050905; x=1726655705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pguXKho2iGtNY7bbPN64vthkTwD/qntrSgD7BpHG+7Y=;
        b=mvwpxDgkWSg+cB2T/7v8934NAQIvTPBi2EvrlblykI7Dfa7Vm0v4KyboZVdogsS8or
         AQevaMT7WlyxxW9Gyy64RbQfnJG0kifrBFihXei+k9blPREkUM9oCM1b50k8MLPJCLtJ
         4nBu7hIDF8Eqmi1lDwcvyoeXukV9tmlqsc4v58064Wc2RdY1d/FpbMP/l49cl6xMubg0
         /1hRb2YEmE8eT1zGjBoN/xvkU06ilNkO6ytF+JxwNfj5+CtxpvERpZK+YVaGGUw8Alld
         OzjhYSt5JZMz5U7iY8hy00E2jLbIHRTuDUsL2qo+ggR124jb+cNzWrqKYCnDzBM+yFKH
         DRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050905; x=1726655705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pguXKho2iGtNY7bbPN64vthkTwD/qntrSgD7BpHG+7Y=;
        b=ca0imEaotLJdJfSvoJU0FX0ZxJfaqe+cltr/4OLxlE7AcgOQ0IR23FBcbqIa6s+asU
         Ik9Lnv/RYHmkknqd699G1xTa/KEt8C6RBZER+1YsXEUbpeTkJv6Om1lmvCj6sNQrLN4I
         IqBu72RFC7tqPZm7hxyeyrgSTp8Rl21OynYL3HtNuXXu7tQlz4JKaN6+zEEni/ry/gMP
         YENcRs/Y4pIE72bEzji2smP9KH5awnRQmY6QI2/N3XnUmRERbGNuZK+Kza93wuQr0AUz
         Fzybb/uLDufdeO8YZAdsEQNB3p2zd/IGnoZrLuL9y2qWffF8IOpn14iMHo3eC0MoZfa5
         rnkA==
X-Forwarded-Encrypted: i=1; AJvYcCXAN2HvjY2n6yh2uQpoUctKN5VZXZH6Xa0cuFyyPUyWchTvIDPtsdJXZijczLGtVfXyjMxmA+lzbmidEDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//b3ytCRsRFh3JH+yQDo8AEBN9yYeuO8nrguqB+bU9Em/qkZr
	eBsNd01G/nS+PMr50Z2UBYMNIibCgnuxP02JjyE+MP5yL9Zb2jXZKSVIkHD/8KP3lExFf1WbzhL
	9BroE3I1/m9hHtRTyKSr4rVFDRWV7rFYPsBtN6A==
X-Google-Smtp-Source: AGHT+IEXGUo8iYr83kd7B9iECVwc8bdMpc/xy3+lDcZrAKDkVX5G5H8kLtfBabKLQx3cToAQvvvkY6Dr2nHmCs148Lw=
X-Received: by 2002:a05:690c:2889:b0:65f:8209:3ede with SMTP id
 00721157ae682-6db452740b1mr148903587b3.44.1726050904691; Wed, 11 Sep 2024
 03:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911100813.338-1-quic_mukhopad@quicinc.com> <20240911100813.338-3-quic_mukhopad@quicinc.com>
In-Reply-To: <20240911100813.338-3-quic_mukhopad@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 11 Sep 2024 13:34:53 +0300
Message-ID: <CAA8EJppLFWpf0QSmzAo5nqu=iMALyKzxEvy7sD5R0LDYSbA_7w@mail.gmail.com>
Subject: Re: [PATCH 2/5] phy: qcom: edp: Introduce aux_cfg array for version
 specific aux settings
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

On Wed, 11 Sept 2024 at 13:08, Soutrik Mukhopadhyay
<quic_mukhopad@quicinc.com> wrote:
>
> In order to support different HW versions, introduce aux_cfg array
> to move v4 specific aux configuration settings.
>
> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 34 +++++++++++++++++------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index da2b32fb5b45..0f860a807d1b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -90,6 +90,7 @@ struct phy_ver_ops {
>
>  struct qcom_edp_phy_cfg {
>         bool is_edp;
> +       u8 *aux_cfg;
>         const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
>         const struct phy_ver_ops *ver_ops;
>  };
> @@ -186,11 +187,14 @@ static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg = {
>         .pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3,
>  };
>
> +static u8 edp_phy_aux_cfg_v4[10] = {

static const u8, please.


> +       0x00, 0x13, 0x24, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03
> +};
> +
>  static int qcom_edp_phy_init(struct phy *phy)
>  {
>         struct qcom_edp *edp = phy_get_drvdata(phy);
>         int ret;
> -       u8 cfg8;
>
>         ret = regulator_bulk_enable(ARRAY_SIZE(edp->supplies), edp->supplies);
>         if (ret)
> @@ -222,22 +226,20 @@ static int qcom_edp_phy_init(struct phy *phy)
>          * even needed.
>          */
>         if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
> -               cfg8 = 0xb7;
> -       else
> -               cfg8 = 0x37;
> +               edp->cfg->aux_cfg[8] = 0xb7;
>
>         writel(0xfc, edp->edp + DP_PHY_MODE);
>
> -       writel(0x00, edp->edp + DP_PHY_AUX_CFG0);
> -       writel(0x13, edp->edp + DP_PHY_AUX_CFG1);
> -       writel(0x24, edp->edp + DP_PHY_AUX_CFG2);
> -       writel(0x00, edp->edp + DP_PHY_AUX_CFG3);
> -       writel(0x0a, edp->edp + DP_PHY_AUX_CFG4);
> -       writel(0x26, edp->edp + DP_PHY_AUX_CFG5);
> -       writel(0x0a, edp->edp + DP_PHY_AUX_CFG6);
> -       writel(0x03, edp->edp + DP_PHY_AUX_CFG7);
> -       writel(cfg8, edp->edp + DP_PHY_AUX_CFG8);
> -       writel(0x03, edp->edp + DP_PHY_AUX_CFG9);
> +       writel(edp->cfg->aux_cfg[0], edp->edp + DP_PHY_AUX_CFG0);
> +       writel(edp->cfg->aux_cfg[1], edp->edp + DP_PHY_AUX_CFG1);
> +       writel(edp->cfg->aux_cfg[2], edp->edp + DP_PHY_AUX_CFG2);
> +       writel(edp->cfg->aux_cfg[3], edp->edp + DP_PHY_AUX_CFG3);
> +       writel(edp->cfg->aux_cfg[4], edp->edp + DP_PHY_AUX_CFG4);
> +       writel(edp->cfg->aux_cfg[5], edp->edp + DP_PHY_AUX_CFG5);
> +       writel(edp->cfg->aux_cfg[6], edp->edp + DP_PHY_AUX_CFG6);
> +       writel(edp->cfg->aux_cfg[7], edp->edp + DP_PHY_AUX_CFG7);
> +       writel(edp->cfg->aux_cfg[8], edp->edp + DP_PHY_AUX_CFG8);
> +       writel(edp->cfg->aux_cfg[9], edp->edp + DP_PHY_AUX_CFG9);
>
>         writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
>                PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
> @@ -519,16 +521,19 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
>  };
>
>  static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
> +       .aux_cfg = edp_phy_aux_cfg_v4,
>         .ver_ops = &qcom_edp_phy_ops_v4,
>  };
>
>  static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
> +       .aux_cfg = edp_phy_aux_cfg_v4,
>         .swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
>         .ver_ops = &qcom_edp_phy_ops_v4,
>  };
>
>  static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
>         .is_edp = true,
> +       .aux_cfg = edp_phy_aux_cfg_v4,
>         .swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
>         .ver_ops = &qcom_edp_phy_ops_v4,
>  };
> @@ -707,6 +712,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
>  };
>
>  static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
> +       .aux_cfg = edp_phy_aux_cfg_v4,

Is this correct? Judging by ver_ops, X Elite uses v6 of the PHY, so
maybe it should also use v5 AUX tables?

>         .swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
>         .ver_ops = &qcom_edp_phy_ops_v6,
>  };
> --
> 2.17.1
>


--
With best wishes
Dmitry

