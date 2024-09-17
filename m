Return-Path: <linux-kernel+bounces-331546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB95197AE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235A5B2AC10
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E2161B43;
	Tue, 17 Sep 2024 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIQ52aaD"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4915C125
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566092; cv=none; b=IO3r4mELvmDXAHvmm8p3I7GphS8jv78L3+csJ3/xvgVnIJbfIVl0v+3VrR+phHUTftoxVI3bHgxBspMSvnBz4ufx8371RfuOcDSWS7/fdGKSlD0ueFtfTY01DR7M3rgYoA0cDxxRxqlBKCSFB40mpWaJxIReFlgf/fX0kc5tl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566092; c=relaxed/simple;
	bh=Cqh7y5dpTkn/lbx/zt9HQjLKb+0ZpdcRdnvzAaBSoCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dl8i9/TWFIDYM00n/nZWNKZbd9tIDP1Fgy4C7UfDsEIV+gpSno/Lm3zhh8MM0RiCFXSrAvEw3m1iEviwD/l8B2VJyBuGcjmbrxkdWLoI7F1IITQaDZnnE39Dua/AjsAyfB/sGlhzbjYtACCO6DVO3PL88DQpvvJcU7HRKF4gNoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tIQ52aaD; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b5b65b1b9fso40879567b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726566089; x=1727170889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YUQo1bSSq8kX3HOSdvvfhK2hzhUvDoWKXHhQXYw0D7Q=;
        b=tIQ52aaDjyUfdFvLnNSCSdAo2jJLZiBKDBn1n1+36GqcURHgXMhVli+xqsb+TXyraG
         Mt4mvl3iApzrWcd2JZKEMyajS6ccyQm9cQjgTOevdU0sHmIqPnG1gXz3tc7ZH8MrDopr
         uIHUNCwznhpnGaTtuC+srVgu+OKv6Xl8Qr7RdKNLgrZiPmtfGIkhRD7fz0bRo0hxqCxY
         LJh+CZmZq8zUWgb15lsSGgGdpZT6vMXvQ/bDhzZdyA0248LA3oS8UqSF+SajWNy3no1P
         bFzl/J99hpf2Ok4tCsuuXt634FB7AgteQHRJi4n9PZ3p35XP85FkQksBeYlAufHBXyvd
         VFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726566089; x=1727170889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUQo1bSSq8kX3HOSdvvfhK2hzhUvDoWKXHhQXYw0D7Q=;
        b=XkkqFaKqnN+4bI8JUcXogyLNBleL9j696MyRdAC9tHdWjUagECz8iGjUbtgj3PIlxa
         A6phqIFRMPV/YjebsStAJKD/aYr3ZJAcb1ID18fZnNwTN8P41optHPSF16oSNU1E6FHu
         MkDpR2TzKMWmd2NxKAt5X6AG02HEBjrY/v8VRiinNWCtaEF+vr/+6XvDvRiBOs0pHH7E
         WcAwfMwy1Ff4DW/n+4JkP+DK3pEI6K4uFp5jsh34oOu4VFvZchB32e2c1heJdj9y4/Vt
         BXNo1BzK/+P6/GCuyEn3uO0bBzVqbhuzyNd1AO9zto1sJGIEuEpDih+cmmNVntx+gtD7
         kyKw==
X-Forwarded-Encrypted: i=1; AJvYcCVDTwKUXBjsaWVZsp+qClBKuFFc6jDpE1NStiIzXbbGr0sKFNqw/HKCt8bN4RRLATrPDaW8BYgaxKO46e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwJ7RFFewfgbsUymldwgyEaEw5wyfu54oLFe2omAn8+kgXFSU
	9eR1OtI0ly4C+BcVECnOm53iBOjmrU8ckkjhZa0PVaDf4u00T2sA9zXru6t0cB5Mo/FC5Ai+aoh
	KLFBkocRWkHuFWxVAvtktRHRIhPgzdQIMRnAePA==
X-Google-Smtp-Source: AGHT+IHT1V3PeZZNewflXjW3i9JRWZQTKzirw4DGT5uyJzF4Av2YmvMp/sQpcgwEf52Fa8aoOQlE9ZuHN9AEzEooIwQ=
X-Received: by 2002:a05:690c:3687:b0:6dd:ba9b:2ca7 with SMTP id
 00721157ae682-6ddba9b2dbemr60897387b3.46.1726566088694; Tue, 17 Sep 2024
 02:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913103755.7290-1-quic_mukhopad@quicinc.com>
 <20240913103755.7290-3-quic_mukhopad@quicinc.com> <CAA8EJppddLmzJ9WSkLLr-nwM-qe647Sm6jV8SpHdB=0vRQT-=Q@mail.gmail.com>
 <3ea1189b-8b06-45bb-9d60-178f69ee407d@quicinc.com>
In-Reply-To: <3ea1189b-8b06-45bb-9d60-178f69ee407d@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 17 Sep 2024 11:41:17 +0200
Message-ID: <CAA8EJppKrOVi3B7g9dUMXwCDWR9GKUVD2BgSnNy+PkC5fq3GGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] phy: qcom: edp: Introduce aux_cfg array for
 version specific aux settings
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

On Tue, 17 Sept 2024 at 10:40, Soutrik Mukhopadhyay
<quic_mukhopad@quicinc.com> wrote:
>
>
> On 9/13/2024 5:12 PM, Dmitry Baryshkov wrote:
> > On Fri, 13 Sept 2024 at 13:38, Soutrik Mukhopadhyay
> > <quic_mukhopad@quicinc.com> wrote:
> >> In order to support different HW versions, introduce aux_cfg array
> >> to move v4 specific aux configuration settings.
> >>
> >> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> >> ---
> >> v2: Fixed review comments from Bjorn and Dmitry
> >>          - Made aux_cfg array as const.
> >>
> >> ---
> >>   drivers/phy/qualcomm/phy-qcom-edp.c | 37 ++++++++++++++++++-----------
> >>   1 file changed, 23 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> >> index da2b32fb5b45..bcd5aced9e06 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> >> @@ -90,6 +90,7 @@ struct phy_ver_ops {
> >>
> >>   struct qcom_edp_phy_cfg {
> >>          bool is_edp;
> >> +       const u8 *aux_cfg;
> >>          const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
> >>          const struct phy_ver_ops *ver_ops;
> >>   };
> >> @@ -186,11 +187,15 @@ static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg = {
> >>          .pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3,
> >>   };
> >>
> >> +static const u8 edp_phy_aux_cfg_v4[10] = {
> >> +       0x00, 0x13, 0x24, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03
> >> +};
> >> +
> >>   static int qcom_edp_phy_init(struct phy *phy)
> >>   {
> >>          struct qcom_edp *edp = phy_get_drvdata(phy);
> >> +       u8 aux_cfg[10];
> > Please define 10, so that there are no magic numbers (and less chance
> > of damaging the stack if it gets changed in one place only.
>
>
> Sure, we will update this in the next version.
>
>
> >
> >>          int ret;
> >> -       u8 cfg8;
> >>
> >>          ret = regulator_bulk_enable(ARRAY_SIZE(edp->supplies), edp->supplies);
> >>          if (ret)
> >> @@ -200,6 +205,8 @@ static int qcom_edp_phy_init(struct phy *phy)
> >>          if (ret)
> >>                  goto out_disable_supplies;
> >>
> >> +       memcpy(aux_cfg, edp->cfg->aux_cfg, sizeof(aux_cfg));
> >> +
> >>          writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
> >>                 DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
> >>                 edp->edp + DP_PHY_PD_CTL);
> >> @@ -222,22 +229,20 @@ static int qcom_edp_phy_init(struct phy *phy)
> >>           * even needed.
> >>           */
> >>          if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
> >> -               cfg8 = 0xb7;
> >> -       else
> >> -               cfg8 = 0x37;
> >> +               aux_cfg[8] = 0xb7;
> >>
> >>          writel(0xfc, edp->edp + DP_PHY_MODE);
> >>
> >> -       writel(0x00, edp->edp + DP_PHY_AUX_CFG0);
> >> -       writel(0x13, edp->edp + DP_PHY_AUX_CFG1);
> >> -       writel(0x24, edp->edp + DP_PHY_AUX_CFG2);
> >> -       writel(0x00, edp->edp + DP_PHY_AUX_CFG3);
> >> -       writel(0x0a, edp->edp + DP_PHY_AUX_CFG4);
> >> -       writel(0x26, edp->edp + DP_PHY_AUX_CFG5);
> >> -       writel(0x0a, edp->edp + DP_PHY_AUX_CFG6);
> >> -       writel(0x03, edp->edp + DP_PHY_AUX_CFG7);
> >> -       writel(cfg8, edp->edp + DP_PHY_AUX_CFG8);
> >> -       writel(0x03, edp->edp + DP_PHY_AUX_CFG9);
> >> +       writel(aux_cfg[0], edp->edp + DP_PHY_AUX_CFG0);
> >> +       writel(aux_cfg[1], edp->edp + DP_PHY_AUX_CFG1);
> >> +       writel(aux_cfg[2], edp->edp + DP_PHY_AUX_CFG2);
> >> +       writel(aux_cfg[3], edp->edp + DP_PHY_AUX_CFG3);
> >> +       writel(aux_cfg[4], edp->edp + DP_PHY_AUX_CFG4);
> >> +       writel(aux_cfg[5], edp->edp + DP_PHY_AUX_CFG5);
> >> +       writel(aux_cfg[6], edp->edp + DP_PHY_AUX_CFG6);
> >> +       writel(aux_cfg[7], edp->edp + DP_PHY_AUX_CFG7);
> >> +       writel(aux_cfg[8], edp->edp + DP_PHY_AUX_CFG8);
> >> +       writel(aux_cfg[9], edp->edp + DP_PHY_AUX_CFG9);
> > Replace this with a loop?
>
>
> Can we use below approach for this :
>
> #define DP_PHY_AUX_CFG(n)        (0x24 + (0x04 * (n)))
>
> for (int i = 0; i < 10; i++)
>
>      writel(aux_cfg[i], edp->edp + DP_PHY_AUX_CFG(i));

That's what I meant, thank you!

>
>
> >
> >>          writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
> >>                 PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
> >> @@ -519,16 +524,19 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
> >>   };
> >>
> >>   static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
> >> +       .aux_cfg = edp_phy_aux_cfg_v4,
> >>          .ver_ops = &qcom_edp_phy_ops_v4,
> >>   };
> >>
> >>   static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
> >> +       .aux_cfg = edp_phy_aux_cfg_v4,
> >>          .swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
> >>          .ver_ops = &qcom_edp_phy_ops_v4,
> >>   };
> >>
> >>   static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
> >>          .is_edp = true,
> >> +       .aux_cfg = edp_phy_aux_cfg_v4,
> >>          .swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
> >>          .ver_ops = &qcom_edp_phy_ops_v4,
> >>   };
> >> @@ -707,6 +715,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
> >>   };
> >>
> >>   static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
> >> +       .aux_cfg = edp_phy_aux_cfg_v4,
> >>          .swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
> >>          .ver_ops = &qcom_edp_phy_ops_v6,
> >>   };
> >> --
> >> 2.17.1
> >>
> >



-- 
With best wishes
Dmitry

