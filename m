Return-Path: <linux-kernel+bounces-527998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047CCA41247
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0537D7A2C8B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9F115666B;
	Sun, 23 Feb 2025 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jh+Jnb/z"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5617588
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740353926; cv=none; b=DbLWA9r65Sb1nN8HamNgnipcO1PFe3iWP9HL2zbW724juimz/rkunu6mevmpzolkjjAk0B4bU66N3Ek+0PLaTtDwz2ChP0mHTMYygTpqzMZ38v2iz3DplaBdiibbGOB7iJKTA780sOJzVfYMSsxWZhu38EB6eBQEzg0/YgEmAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740353926; c=relaxed/simple;
	bh=g2p/y0Qx4XB8tBPzzAldedH/N08MGTvggjXgpgomRg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFXT2CH0FZ+nBlubfD3knno1jU6p56+4u0sIS7Xe32LBWsj2B5X4s3o6JOEHsZQuaShv0PpK/eiSEhs1kYEJS+9rJxTWcEUWT/3Ca3wobIzYlKqJLjpRoI47ZGNL5hIsyazT1f/mz5tOqPy/buVmMzNNyXmhHoBIUfoBQrwFtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jh+Jnb/z; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fb3a611afdso31251917b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 15:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740353922; x=1740958722; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NorJPaAWMRgfUr5xe1GpsIw0IDjSs1x/V3X7c0koEtI=;
        b=jh+Jnb/zzOxEGBHU7XWxZV9V+LXwPC98kF4nxNpTaehdqH727EAvc6J9Ya7Y492pU2
         O5m6n+Dz6wGeTpYzhNuKjhN0jZ5a5Yhz55Qb2q0pKrWz+PggONXAO+2t3vsb5/japEnT
         4fUBP4StChdgovDqw+t8gqqXbmvluIE0EL5Pg30Fuw5Q0oDzFIKah9CZnIuaHn02zmwW
         CP6g9K3lwPXqvcR+3k5yVdYbv6IqYNCzLEhPMdY1PBXQKYr9LUdZvIU6uiEuEW0K84mY
         /7nw4Xst3lCV+nLAX4/k9zGoZQZy8RfIdL+BxXnSJ+9oiMFcHGw1EDpjgaFLBmEr6f0U
         uXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740353922; x=1740958722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NorJPaAWMRgfUr5xe1GpsIw0IDjSs1x/V3X7c0koEtI=;
        b=UF17hrjM/NpVLHE8yXrfdbiFI/H+din3BMQTTEPnmCdw2yRQOPbN9V9w2xb6CygFXe
         8cuZlUfSOFC+EOiiL8TClFp9sFKhPVSAjzw5oP1rbBKKmV/QsQviQDCsPdXcIwhXRuLU
         /XrfvF0tdhSW2Bnv4rbeKlrZSojEQzXAH8ClW1dxTChEOff6onK45oS10B5WJX/q5DYx
         tL5MiGfYviCJ4feUJfyzboFgeUSs5DxRLvTP6q/NMOzXhnLFqQiSh5wU2iu+gaz/QvAx
         nj0qQKc75W605RUzLQCzxrBSqJU7aw92Cx2WY7bOPYBobmeMK9GNODhg4UuaMtFr6q7m
         m1pg==
X-Forwarded-Encrypted: i=1; AJvYcCVySisJh2tKWZbuGjXlKnuuLU9vUfD7YoLSt36t/JW57dR9He8qxTlQQs57B/6WVdO1429OLj7XKLTd+cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFRur4jo3sqX3fKa2vz3Nmy222ViGoK+l4aImSXy1GDPEkf+I
	NiitkW5JB0zVfTVTHeSIVemSksWIGV7cT2jtgm5kI15XoZPtYQsCgBJAY6bUUKt6sHpijXQTKV4
	qlMZNOUwkSzr9x0kKFIWQE3vBRqkqRDJ6N4pEHw==
X-Gm-Gg: ASbGncu+f7ZMJ5MKcD8ZBnGRVMneBhgLXWEzz3YnKXZtqpk5rSlh2YCzLUJXT8DtryM
	b0ZhqqoCLJd0ojUgjJ+dKkK7SvlTDVzAyEDvppJixsI7rMmjOqSfcy6ZPZ5gxQaeeEx58lmtf39
	CF6peUigkeuKk+oKxNltc5w3vNWH9BYEy8AmNTfz4=
X-Google-Smtp-Source: AGHT+IGFegxU0/BAO58BmfLqgVu14539PaOFZp3Jh6MOJGQnzwNm3VyUN+k9CDauRsvVnXt6ZCaaCQFePUkkFp0b59E=
X-Received: by 2002:a05:690c:25c5:b0:6f9:7d7d:a725 with SMTP id
 00721157ae682-6fbcc3ad1abmr98769257b3.33.1740353920862; Sun, 23 Feb 2025
 15:38:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223-phy-sam-hdptx-bpc-v3-0-66a5c8e68327@collabora.com> <20250223-phy-sam-hdptx-bpc-v3-5-66a5c8e68327@collabora.com>
In-Reply-To: <20250223-phy-sam-hdptx-bpc-v3-5-66a5c8e68327@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 24 Feb 2025 01:38:30 +0200
X-Gm-Features: AWEUYZmTHJ2dAKAOg_4O6EdrI6McHGH1cJfHE45231CZ1NkDjfb9qIrmX-8DI0c
Message-ID: <CAA8EJppjRFWXXYSp=SKPKBV-ceO7gu3n37k-5eUeYG_x6rOmsg@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] phy: rockchip: samsung-hdptx: Setup TMDS char rate
 via phy_configure_opts_hdmi
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
	Sandor Yu <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Feb 2025 at 13:02, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> The current workaround to setup the TMDS character rate relies on the
> unconventional usage of phy_set_bus_width().
>
> Make use of the recently introduced HDMI PHY configuration API for this
> purpose.  The workaround will be dropped as soon as the switch has been
> completed on both ends.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 37 +++++++++++++++++------
>  1 file changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> index f9b5c96d6c789e435657e224032d35b5a6950945..dd91a7272e246b2133112effdb080a847fd15abe 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> @@ -402,6 +402,9 @@ struct rk_hdptx_phy {
>         int nr_clks;
>         struct reset_control_bulk_data rsts[RST_MAX];
>
> +       /* PHY config opts */
> +       unsigned long tmds_char_rate;

It's easier to embed struct phy_configure_opts_hdmi here, in the end
you  add bpc here in one of the next patches.

> +
>         /* clk provider */
>         struct clk_hw hw;
>         unsigned long rate;
> @@ -1413,19 +1416,21 @@ static int rk_hdptx_dp_aux_init(struct rk_hdptx_phy *hdptx)
>  static int rk_hdptx_phy_power_on(struct phy *phy)
>  {
>         struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
> -       int bus_width = phy_get_bus_width(hdptx->phy);
> +       unsigned int rate = hdptx->tmds_char_rate / 100;
>         enum phy_mode mode = phy_get_mode(phy);
>         int ret, lane;
>
> -       /*
> -        * FIXME: Temporary workaround to pass pixel_clk_rate
> -        * from the HDMI bridge driver until phy_configure_opts_hdmi
> -        * becomes available in the PHY API.
> -        */
> -       unsigned int rate = bus_width & 0xfffffff;
> +       if (rate == 0) {
> +               /*
> +                * FIXME: Temporary workaround to setup TMDS char rate
> +                * from the RK HDMI bridge driver.
> +                * Will be removed as soon the switch to the HDMI PHY
> +                * configuration API has been completed on both ends.
> +                */
> +               rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
> +       }
>
> -       dev_dbg(hdptx->dev, "%s bus_width=%x rate=%u\n",
> -               __func__, bus_width, rate);
> +       dev_dbg(hdptx->dev, "%s rate=%u\n", __func__, rate);
>
>         ret = rk_hdptx_phy_consumer_get(hdptx, rate);
>         if (ret)
> @@ -1734,8 +1739,10 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
>         enum phy_mode mode = phy_get_mode(phy);
>         int ret;
>
> -       if (mode != PHY_MODE_DP)
> +       if (mode != PHY_MODE_DP) {
> +               hdptx->tmds_char_rate = opts->hdmi.tmds_char_rate;
>                 return 0;
> +       }
>
>         ret = rk_hdptx_phy_verify_config(hdptx, &opts->dp);
>         if (ret) {
> @@ -1830,6 +1837,16 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>  {
>         struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
>
> +       /*
> +        * The TMDS char rate set via phy_configure(), if any, has
> +        * precedence over the rate provided via clk_set_rate().

I think this is not so nice. It makes CCF desync from the actual rate
programmed into the hardware. Maybe you can make the clock r/o?

> +        */
> +       if (hdptx->tmds_char_rate && hdptx->tmds_char_rate != rate) {
> +               dev_dbg(hdptx->dev, "Replaced clk_set_rate=%lu with tmds_char_rate=%lu\n",
> +                       rate, hdptx->tmds_char_rate);
> +               rate = hdptx->tmds_char_rate;
> +       }
> +
>         return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
>  }
>
>
> --
> 2.48.1
>


--
With best wishes
Dmitry

