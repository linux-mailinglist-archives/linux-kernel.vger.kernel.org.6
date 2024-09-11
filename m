Return-Path: <linux-kernel+bounces-324699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA1F974FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716161F2327E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D73215DBB3;
	Wed, 11 Sep 2024 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="im7aiyM3"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A78A15C13F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051215; cv=none; b=u/XZotMpoT8PGX7ZsURr5Rhjl1kGQ+3LIShB0BEDmTEPdMm0BjsWNKgk4JWsPIz9Uv4MqCkInOLlbhsJhMRW8LaXTrCez+LvJFjniZrS+i8V05uWB0t8711Dp3OmUwkyhCJPBWG3QL9hxCoSVDZBmMms0yhcj7g6OkP4MjAsNIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051215; c=relaxed/simple;
	bh=ACqmaWkvoJ+Yg46mKlFoEKUQQ4W0bPcPgkKYG+6tEiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4hkm4SGY78NuYBSN9uOIg27EFXtVimz5p8x/MeijIQdAx0WMBY5TePjbrA0soKbpv7PcgARrfLP2IlGDophNR5olMON/GcvZpyYrDjzdKzlk4JompP49caBl0uejgC5Pq+1jXx8kbqE6lCEiVS5U7KC365DBRtNMXGB+//b+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=im7aiyM3; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6d3f017f80eso57203197b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726051213; x=1726656013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=quaLdCg89/Q3ErVCYpGz/S7qzPrQHkWX+pHMVVZKZIc=;
        b=im7aiyM3n+XFZzAUfgVWhj2s+l8tdgTxtI0Yxc8ArewJhvfYYSbWzwSU8c15aX1zMI
         1eNAzHMGNqU0Sd+nHkhQLFOlW4413WJSmgE/plLTwCBfF4fA6Y2VJ0bZRhejT3Z4WPYC
         UoLuo7McovI/QEUAy7X8SgGh+VmRDMRrFP6AYnqFM21sUrezJHndxTt7J8GLkkXWHbOl
         eOOnPaqePR8A7wGkujoUsYupIw72RxS1aliHLm0xLNzmNiiRV6goH+4osrsZNLexI3zN
         zoGM65T0uTCs/gso5UkvCDFKD+7OaHN372tPuTtvhiNHv9XvhLAanyCEq/bNWvrDo/D9
         fliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051213; x=1726656013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quaLdCg89/Q3ErVCYpGz/S7qzPrQHkWX+pHMVVZKZIc=;
        b=N/z4zEaDaLv9xuFa+tGJw3r9J8VbPaXrPesNTK7Lqqz+73pTrVvJ8Z93ronUalLv7F
         vXgWY5jwXOy/Tt2BsTljgsTnGxNl5Ghk6dnHrN2i58gG8iV++5sA10xk54S5jb4EyK1j
         hXYArsqz/ojVJieXvsnZ42ZBM+j++AjLE6tY/3G0JXi4+hPPpnKm/vjrotdjkqb92UiG
         +V/Fc4u/62yEnZGlUCXRgZuBCOKZ+6YaeIBNYc/Y2pjJy99VGOdGmcpATfkSfrGRu8V4
         o8UxJi9LKtgmFi1AKLlFwd4kEbi6Gc86MhX32KN/FlsIqeFm4s9Y/3f2XwmKew8pV2fQ
         dKXw==
X-Forwarded-Encrypted: i=1; AJvYcCXEZjmkSZsMrkyWx731xlJBnfombsCeQUDvd1QZPkXDol1wZEdA3vMm4GPKFvdNZHuhqjbR6cfQYM2539o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGYD2wjI3L6CmqEX88sS0GdESlZ6kJ7yM6F2ezT57CPdRvXhM6
	3WQAtxMXMfwDRy6E1RYcNaAVPXD+ufV8EelVp/SzFZ1+BW1l+IbECamsSUH1Rq3JIBCAUP7HjLK
	nha3qlVY0CKrnRKnVxCKC5MSlbO/F3ef5Bzje5w==
X-Google-Smtp-Source: AGHT+IFBbb4wmETvjaXqgLn/MDWKCHL6pj57SkqVhM0/cPEdnbQlphBpHqZfas0PwZIxjI6E5z9qO73trRYEsWxee9I=
X-Received: by 2002:a05:690c:660e:b0:6b3:a6ff:768e with SMTP id
 00721157ae682-6db44a63f29mr197379867b3.0.1726051212892; Wed, 11 Sep 2024
 03:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911100813.338-1-quic_mukhopad@quicinc.com> <20240911100813.338-4-quic_mukhopad@quicinc.com>
In-Reply-To: <20240911100813.338-4-quic_mukhopad@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 11 Sep 2024 13:40:02 +0300
Message-ID: <CAA8EJpqurbPKjmRH8zdqPkMuze4zwJVu+=W0nP=Ldc6o_4Tu4w@mail.gmail.com>
Subject: Re: [PATCH 3/5] phy: qcom: edp: Add support for eDP PHY on SA8775P
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
> Add support for eDP PHY v5 found on the Qualcomm SA8775P platform.
>
> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 47 +++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index 0f860a807d1b..34a47cd2919d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -191,6 +191,45 @@ static u8 edp_phy_aux_cfg_v4[10] = {
>         0x00, 0x13, 0x24, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03
>  };
>
> +static const u8 edp_swing_hbr_rbr_v5[4][4] = {
> +       { 0x07, 0x0f, 0x16, 0x1f },
> +       { 0x0d, 0x16, 0x1e, 0xff },
> +       { 0x11, 0x1b, 0xff, 0xff },
> +       { 0x16, 0xff, 0xff, 0xff }
> +};

Same as v4

> +
> +static const u8 edp_pre_emp_hbr_rbr_v5[4][4] = {
> +       { 0x05, 0x11, 0x17, 0x1d },
> +       { 0x05, 0x11, 0x18, 0xff },
> +       { 0x06, 0x11, 0xff, 0xff },
> +       { 0x00, 0xff, 0xff, 0xff }
> +};

Could you please confirm that there is a single value difference?

> +
> +static const u8 edp_swing_hbr2_hbr3_v5[4][4] = {
> +       { 0x0b, 0x11, 0x17, 0x1c },
> +       { 0x10, 0x19, 0x1f, 0xff },
> +       { 0x19, 0x1f, 0xff, 0xff },
> +       { 0x1f, 0xff, 0xff, 0xff }
> +};

Same as v4

> +
> +static const u8 edp_pre_emp_hbr2_hbr3_v5[4][4] = {
> +       { 0x0c, 0x15, 0x19, 0x1e },
> +       { 0x0b, 0x15, 0x19, 0xff },
> +       { 0x0e, 0x14, 0xff, 0xff },
> +       { 0x0d, 0xff, 0xff, 0xff }
> +};

This one looks fine

> +
> +static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg_v5 = {
> +       .swing_hbr_rbr = &edp_swing_hbr_rbr_v5,
> +       .swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3_v5,
> +       .pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr_v5,
> +       .pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3_v5,
> +};
> +
> +static u8 edp_phy_aux_cfg_v5[10] = {
> +       0x00, 0x13, 0xa4, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03
> +};
> +
>  static int qcom_edp_phy_init(struct phy *phy)
>  {
>         struct qcom_edp *edp = phy_get_drvdata(phy);
> @@ -520,6 +559,13 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
>         .com_configure_ssc      = qcom_edp_com_configure_ssc_v4,
>  };
>
> +static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
> +       .is_edp = false,
> +       .aux_cfg = edp_phy_aux_cfg_v5,
> +       .swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
> +       .ver_ops = &qcom_edp_phy_ops_v4,
> +};
> +
>  static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
>         .aux_cfg = edp_phy_aux_cfg_v4,
>         .ver_ops = &qcom_edp_phy_ops_v4,
> @@ -1114,6 +1160,7 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id qcom_edp_phy_match_table[] = {
> +       { .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },
>         { .compatible = "qcom,sc7280-edp-phy", .data = &sc7280_dp_phy_cfg, },
>         { .compatible = "qcom,sc8180x-edp-phy", .data = &sc7280_dp_phy_cfg, },
>         { .compatible = "qcom,sc8280xp-dp-phy", .data = &sc8280xp_dp_phy_cfg, },
> --
> 2.17.1
>


-- 
With best wishes
Dmitry

