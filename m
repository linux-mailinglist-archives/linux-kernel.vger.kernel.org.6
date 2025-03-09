Return-Path: <linux-kernel+bounces-553063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9007A582F3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2408F188EAF5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C51A4F22;
	Sun,  9 Mar 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUleh/4o"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26A347B4
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515454; cv=none; b=b+aubM5K0/RVCXPIVE6Pb6ECQ9FXtH8Z83kA6CK0PItp8S4x5612rCHGl+Qiz5A10A6og8erh8JAQEH5TMANaBQYSuCc6n9+Jc/yWt7NjbdLMw7+LYZLTmCiZHfmZBsSHhi8mvMtAJTjVNtwThPsX2OWFQrl7KGZ6hln3sQZ7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515454; c=relaxed/simple;
	bh=hVa1fVod1eEv6D9lS1Q6fCBysw9wOcj64xwpNaODkGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daWOBqSrMcLU+3CJbJt7i9OA3do5JjryabvL2nSOJeqokPqEL7oURqZvL0ZmagoTlurgRo+iHvYRBlrryJbCv/HIcFoP+Tdr/dm2SxeKLrZDU3ntLno/bfbzFSwHGFqVL/G1JDEbtiplXngOjbMIMZpGaVgIGYhbknYH+RvUh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PUleh/4o; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e60aef2711fso2311013276.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741515452; x=1742120252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8JaDvPEYA7TsBoq4Mvy5LHxwsmJqm2nsItn8pPo4zA4=;
        b=PUleh/4olosU7Zvajo037VW4Y/edvmrOgXYj7KZg5Zfetfmj63WpXqhYq36kWYv0L8
         0AYNR9aEa7uF6U28z9L0LwEgZ5IBHB9+8394ig9aTTgKFwCMtKvUwp3DdTKPx2Fao5Xm
         dqhgdIJbSlAueiGrdTrbEt3LRJkp3wwiAVgcZ9gMsg4dZtxCFzRXDT/UcLlb7oONxJCY
         CHhS/mHzlSr+Zm4YKvPDtO7+ajpUJYN2o9hKvhCwsCJgQNWm2UfckWHS7CZIUKnmCsyo
         EcluLjjkt/cjU6BsttvIc4XYhdIFlwaeVOc4H+O6g+mOyDL2pI/8L21XuQZD61C/hEDn
         DIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741515452; x=1742120252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JaDvPEYA7TsBoq4Mvy5LHxwsmJqm2nsItn8pPo4zA4=;
        b=wGJgY6C+teQW0Dm1ZN0ujECXanAxswLmZwm8VC26zaDmtodarsr4/QrIwZ9sCuB4yZ
         Mhk81SSCW3ozGSbWRCbjH9EmSyjbO6QfhwSUyIRQ5eym4qfgeX3k/xLNWSmvK8WjfcF7
         YlSWMY0CKjoz1Q2Xk+bN3CblB9PyjOjvOfyyNfFTByQrdukDkRAsFOdXUsdf42Vv8WOK
         UWxYM0M8FKa27PZ+YCJvXnLqfy/P1w7xgAL3U41LmHKRyTbx8sKb6YVan947CGOmL/w7
         PBjstPw9feqggsuMt3JVli/XXw/WAPd+M4c8AyfHA2KAyCjyTIqMhSJueOkvW7jscEhW
         V6lA==
X-Forwarded-Encrypted: i=1; AJvYcCUKS4CN5gsYURYqGCisdvxWJeRd9Be1JZbuOMdpxRaSTxVRCsJr5B0cesS57kiYxJ7CQ5OGEQoNPkIvOxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1v8NWwLz3+C6e5+3m1PRbGuhwc5mXQCs8Erf6q0mEx6LTZO6O
	Mt7M4dGWiM9LHuelzQt75M4Eo5bSKo2nHYdr/bGAXw9AncKCSV2iqhziYV6VEWp9H1zUCjfUCmC
	aQA11fc0+euyNAc1o1JKTjcJN/CXbodRgMwFyKXK2IfwzCn+o
X-Gm-Gg: ASbGncvVSPQMBsN55DM3QrgxwHuaj9olirjlEz2I0BGfHRUz1i/+ZVjCCBgfTqIWSL9
	9sJPsgfBQvkOgKDZ/meTb322q1zbis0Zjqfne0oc1qkVgPXmLsivXJOnBOpLPUTZIn/tqOho5s9
	QcC8pZrVp/0Y3jUy3CzD70xP/UmGpduMbV+tdVaOJl
X-Google-Smtp-Source: AGHT+IHe7by2CtDo/zYM/bVl9N1w6brZFhEu1GZHMwI4eVFbfmB5bsavCuak/ilh158w600F1u3l9qq49HjU7FT//ug=
X-Received: by 2002:a05:6902:3307:b0:e5a:e604:78df with SMTP id
 3f1490d57ef6-e635c163099mr10795936276.17.1741515451706; Sun, 09 Mar 2025
 03:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com> <20250308-phy-sam-hdptx-bpc-v5-11-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-11-35087287f9d1@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 12:17:20 +0200
X-Gm-Features: AQ5f1JqGJhorT77dlo7Va-OtaHUZt5CEPT4HFc2cqRMt2nt7DncmKSCeyefi4a8
Message-ID: <CAA8EJpqzZaRoQ5mDeKUHpNhYsegC=V6c2SQpKaQn4FYhozQn1A@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] phy: rockchip: samsung-hdptx: Optimize internal
 rate handling
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
	Sandor Yu <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> Drop the rate parameter from a bunch of internal helpers and, instead,
> make better use of the newly introduced ->hdmi_cfg.tmds_char_rate driver
> data.
>
> Additionally, rename the rather ambiguous ->rate member of struct
> rk_hdptx_phy to ->hw_rate and ensure rk_hdptx_ropll_tmds_cmn_config()

Would it be better to name it tmds_char_rate?

> updates it only after all the other operations have been successful.

Please don't mix refactoring / renames and the actual code changes.

>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 59 ++++++++++++-----------
>  1 file changed, 30 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> index a62c634f5254e742088515c3b21c05f95acbaded..98f831c3704f5cd65dcf29a4f0a12862a4aa0482 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> @@ -401,7 +401,7 @@ struct rk_hdptx_phy {
>
>         /* clk provider */
>         struct clk_hw hw;
> -       unsigned long rate;
> +       unsigned long hw_rate;
>         bool restrict_rate_change;
>
>         atomic_t usage_count;
> @@ -968,33 +968,34 @@ static bool rk_hdptx_phy_clk_pll_calc(unsigned long rate,
>         return true;
>  }
>
> -static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
> -                                         unsigned long rate)
> +static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx)
>  {
>         const struct ropll_config *cfg = NULL;
>         struct ropll_config rc = {0};
> -       int i;
> +       int ret, i;
>
> -       hdptx->rate = rate;
> +       if (!hdptx->hdmi_cfg.tmds_char_rate)
> +               return 0;
>
>         for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
> -               if (rate == ropll_tmds_cfg[i].rate) {
> +               if (hdptx->hdmi_cfg.tmds_char_rate == ropll_tmds_cfg[i].rate) {
>                         cfg = &ropll_tmds_cfg[i];
>                         break;
>                 }
>
>         if (!cfg) {
> -               if (rk_hdptx_phy_clk_pll_calc(rate, &rc)) {
> -                       cfg = &rc;
> -               } else {
> -                       dev_err(hdptx->dev, "%s cannot find pll cfg\n", __func__);
> +               if (!rk_hdptx_phy_clk_pll_calc(hdptx->hdmi_cfg.tmds_char_rate, &rc)) {
> +                       dev_err(hdptx->dev, "%s cannot find pll cfg for rate=%llu\n",
> +                               __func__, hdptx->hdmi_cfg.tmds_char_rate);
>                         return -EINVAL;
>                 }
> +
> +               cfg = &rc;
>         }
>
> -       dev_dbg(hdptx->dev, "%s rate=%lu mdiv=%u sdiv=%u sdm_en=%u k_sign=%u k=%u lc=%u\n",
> -               __func__, rate, cfg->pms_mdiv, cfg->pms_sdiv + 1, cfg->sdm_en,
> -               cfg->sdm_num_sign, cfg->sdm_num, cfg->sdm_deno);
> +       dev_dbg(hdptx->dev, "%s rate=%llu mdiv=%u sdiv=%u sdm_en=%u k_sign=%u k=%u lc=%u\n",
> +               __func__, hdptx->hdmi_cfg.tmds_char_rate, cfg->pms_mdiv, cfg->pms_sdiv + 1,
> +               cfg->sdm_en, cfg->sdm_num_sign, cfg->sdm_num, cfg->sdm_deno);
>
>         rk_hdptx_pre_power_up(hdptx);
>
> @@ -1030,17 +1031,20 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
>         regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_EN_MASK,
>                            FIELD_PREP(PLL_PCG_CLK_EN_MASK, 0x1));
>
> -       return rk_hdptx_post_enable_pll(hdptx);
> +       ret = rk_hdptx_post_enable_pll(hdptx);
> +       if (!ret)
> +               hdptx->hw_rate = hdptx->hdmi_cfg.tmds_char_rate;
> +
> +       return ret;
>  }
>
> -static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
> -                                          unsigned long rate)
> +static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx)
>  {
>         rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_common_sb_init_seq);
>
>         regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
>
> -       if (rate > HDMI14_MAX_RATE) {
> +       if (hdptx->hdmi_cfg.tmds_char_rate > HDMI14_MAX_RATE) {
>                 /* For 1/40 bitrate clk */
>                 rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_tmds_lntop_highbr_seq);
>         } else {
> @@ -1092,8 +1096,7 @@ static void rk_hdptx_dp_reset(struct rk_hdptx_phy *hdptx)
>                      HDPTX_I_BGR_EN << 16 | FIELD_PREP(HDPTX_I_BGR_EN, 0x0));
>  }
>
> -static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx,
> -                                    unsigned long rate)
> +static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx)
>  {
>         enum phy_mode mode = phy_get_mode(hdptx->phy);
>         u32 status;
> @@ -1112,11 +1115,9 @@ static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx,
>         if (mode == PHY_MODE_DP) {
>                 rk_hdptx_dp_reset(hdptx);
>         } else {
> -               if (rate) {
> -                       ret = rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
> -                       if (ret)
> -                               goto dec_usage;
> -               }
> +               ret = rk_hdptx_ropll_tmds_cmn_config(hdptx);
> +               if (ret)
> +                       goto dec_usage;
>         }
>
>         return 0;
> @@ -1429,7 +1430,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
>                 dev_dbg(hdptx->dev, "%s rate=%llu\n", __func__, hdptx->hdmi_cfg.tmds_char_rate);
>         }
>
> -       ret = rk_hdptx_phy_consumer_get(hdptx, hdptx->hdmi_cfg.tmds_char_rate);
> +       ret = rk_hdptx_phy_consumer_get(hdptx);
>         if (ret)
>                 return ret;
>
> @@ -1460,7 +1461,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
>                 regmap_write(hdptx->grf, GRF_HDPTX_CON0,
>                              HDPTX_MODE_SEL << 16 | FIELD_PREP(HDPTX_MODE_SEL, 0x0));
>
> -               ret = rk_hdptx_ropll_tmds_mode_config(hdptx, hdptx->hdmi_cfg.tmds_char_rate);
> +               ret = rk_hdptx_ropll_tmds_mode_config(hdptx);
>                 if (ret)
>                         rk_hdptx_phy_consumer_put(hdptx, true);
>         }
> @@ -1828,7 +1829,7 @@ static int rk_hdptx_phy_clk_prepare(struct clk_hw *hw)
>  {
>         struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
>
> -       return rk_hdptx_phy_consumer_get(hdptx, hdptx->rate);
> +       return rk_hdptx_phy_consumer_get(hdptx);
>  }
>
>  static void rk_hdptx_phy_clk_unprepare(struct clk_hw *hw)
> @@ -1843,7 +1844,7 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
>  {
>         struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
>
> -       return hdptx->rate;
> +       return hdptx->hw_rate;
>  }
>
>  static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> @@ -1895,7 +1896,7 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>          * while the latter being executed only once, i.e. when clock remains
>          * in the prepared state during rate changes.
>          */
> -       return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
> +       return rk_hdptx_ropll_tmds_cmn_config(hdptx);
>  }
>
>  static const struct clk_ops hdptx_phy_clk_ops = {
>
> --
> 2.48.1
>


-- 
With best wishes
Dmitry

