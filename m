Return-Path: <linux-kernel+bounces-553029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2CA582AC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ED016AAAE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5021A08B1;
	Sun,  9 Mar 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEDNglcP"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769ABECF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741512406; cv=none; b=e+/DnGdvrN5JLpMWqWpnCyJKdGv+/YFqEjQrSKZtAR15VA9zEZFw7DjV8bqKMOhzuQHpUPgtTRUsCtzKuU0JgwHpOpaPD6Mjjl8FBT0luDTLizbW/TnwkId44aIdSdQPGUfGoF8iRgBE8mlIdt0dK14LzgregqTUBBkFC3i5MCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741512406; c=relaxed/simple;
	bh=ik8X4IEQqDHG4yAjGI+QpJp8re+baTrHsLFeLL7+3Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaGeJD9zZojJzDDdkTm2rvIapsMswwXz8vU101UGdi2AtqOa4feEqaKHbGKYX+AJpuHbk1YhrU6cdQE1DwWNFd2JYutmTziDuSjzm5tDel4zb356HumZtydLRXy1+klUUavRbAxm9t4Ss6ort3XKhY0ZfVil/kS3lp3cyqlo440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vEDNglcP; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e636585c375so1351094276.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741512403; x=1742117203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y+UfwYvKoniH4ediByf7+QM/x5ez72G5r941EDLOy/s=;
        b=vEDNglcPMlZJKyeRwmdYJLaLyHYG57ezjXrzV9DPNeSOFoEQmdo48ogYdjki63b49R
         E8WqEcEpGi+0NvTZcVxZfAC5IACb59aih/ATZJsk7WIAz6VO+oRaIg9a285YFAHtWZE+
         39+cdk+Slzp1H4HT0HTs5D/INfxZJMlaVSQk0R062ztW2ap8Yf9SMdvWI8HHaC/DVinS
         Rwa4wJ+82/pCpAN/AZPDGSNOlaesEz7SHoO8tWVCDsx04DMhJRQ5pdAnitalxku3E+9N
         WNsXCFPgSwQMDGbzyxq0uDLE1o3jXo52VP94kuV4NgsyEu4JlvcINqB4hE3uqEXtUEUW
         qhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741512403; x=1742117203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+UfwYvKoniH4ediByf7+QM/x5ez72G5r941EDLOy/s=;
        b=ft1RHCi6JezHFNkFnJdEewXv+amlhdoWu9K9xWbmfeYXQUW+Iq8osuMdxsztAKns9P
         E1LVOOHv4qsjsaDm2IrSQJhb8zV0Q6f77481Z9NoTxRCIEpYn+BGF5fIW1NHrWC53rgC
         TTdFP/ButaCN97o9hM/V7fiY9/2+xYKM+23QDNrKEblIZHR86Q4GTTW7jrqyf8gpVRRi
         xEuRgu//3vlbHZPwb0esa3h3CszPTFxj0fpllKbYj/JYbHlQAT1B0guNSc8cI+eqh0KV
         qh5ycCBlQnACMTqQ0bwt1gRI7uQ0dlx/AbjNkU6X83kCALQl/uvtjcGx6GPmm/X01Mgj
         QVYA==
X-Forwarded-Encrypted: i=1; AJvYcCWaajvS/akmKL8bpPOblkECeTi3UoIUbLFwfwndSRyWVY4ibulEuEMWkXVae9qVx1l5emOCDj5Oot4sOBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vWlMLO75F9qopAlsVugU1TKbU0D/BQMePIdgDJl+IME3ZmMV
	yYtu3B19prGQV++hheQGaj79xLu82Nz106IlgQbrM96PRQgKkms1A3puVmQwVC05SNX7tYoPw1x
	Ef4jEvXquLNnUSbbovV3cLScEdrIPiqGUlWcA0A==
X-Gm-Gg: ASbGncvKaJGk3KDwJIYQ0L6uagBcJhVU/2yAR/GmMw0Ow+r4LIIRCLjSHM9nYtNFpfl
	xjG87n/e1XWdyvvNmvzcxqsqYqy4ZyzICM2UdksHgfc0w13P5m6m03kfRjlH0jJapF8q/1JxuIc
	z9en8wOe8Mn6rzbtVdyxxiZpn6gX5PtS4kbgT+0kvf
X-Google-Smtp-Source: AGHT+IEN3V2OLC8hZDOELnAVWI6ww13m5GBnJ8YaCGEl0AbmzOskx9R9Se1xuJeZm/tmBc9JT8v5uFIi9nlaU4PorAA=
X-Received: by 2002:a05:6902:2683:b0:e60:b17c:423f with SMTP id
 3f1490d57ef6-e635c17bdb5mr13660886276.28.1741512403353; Sun, 09 Mar 2025
 01:26:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com> <20250308-phy-sam-hdptx-bpc-v5-8-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-8-35087287f9d1@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 11:26:32 +0200
X-Gm-Features: AQ5f1JqfxNZ22KnfkCh9BmlsU97_eUwp8gZfAiDHoYY-EuyqHBEuJ0Y2Zcaf2N0
Message-ID: <CAA8EJpoGu4Tq-wt09Jj+b+=eJ3dNXhPWVOg4DyCQxrJbFNFfYw@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] phy: rockchip: samsung-hdptx: Setup TMDS char
 rate via phy_configure_opts_hdmi
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
> The current workaround to setup the TMDS character rate relies on the
> unconventional usage of phy_set_bus_width().
>
> Make use of the recently introduced HDMI PHY configuration API to
> properly handle the setup.  The workaround will be dropped as soon as
> the switch has been completed on both ends.
>
> Rename rk_hdptx_phy_verify_config() to rk_hdptx_phy_verify_dp_config()
> and introduce the rk_hdptx_phy_verify_hdmi_config() helper to check the
> HDMI parameters during phy_configure().
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 64 +++++++++++++++++------
>  1 file changed, 47 insertions(+), 17 deletions(-)
>

> @@ -1469,8 +1474,27 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
>         return rk_hdptx_phy_consumer_put(hdptx, false);
>  }
>
> -static int rk_hdptx_phy_verify_config(struct rk_hdptx_phy *hdptx,
> -                                     struct phy_configure_opts_dp *dp)
> +static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
> +                                          struct phy_configure_opts_hdmi *hdmi)
> +{
> +       int i;
> +
> +       if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
> +               return -EINVAL;
> +
> +       for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
> +               if (hdmi->tmds_char_rate == ropll_tmds_cfg[i].rate)
> +                       break;

return 0;

> +
> +       if (i == ARRAY_SIZE(ropll_tmds_cfg) &&

Then you can drop the first clause in the if

> +           !rk_hdptx_phy_clk_pll_calc(hdmi->tmds_char_rate, NULL))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int rk_hdptx_phy_verify_dp_config(struct rk_hdptx_phy *hdptx,
> +                                        struct phy_configure_opts_dp *dp)
>  {
>         int i;
>



-- 
With best wishes
Dmitry

