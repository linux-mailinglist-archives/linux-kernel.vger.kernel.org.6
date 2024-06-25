Return-Path: <linux-kernel+bounces-228336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B336915E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C145A1C22521
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8252D1DFF8;
	Tue, 25 Jun 2024 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EWe1fDYS"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5661DA22
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294521; cv=none; b=OObHE9Fj4pUrIeI91zzBJ7xdxob6JL4F9NO5v4rAtWjSi1lLgP1MYqdLeksb4/VNVprSdv7VqlWD78Z48E4Lr3dwbsE5iH0v1VnD7cRZFj3F/YBfah1OlAX3RM0Cc2b2DJyFzphbiwUhSVUw9594OTyB9LuyJbw5VBEC7PfMnsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294521; c=relaxed/simple;
	bh=xppm1IlJiR0IQb3avLdxzMXwKw8ZgE4wqgotWbJ92BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDBtprD+1vGElX69NSBWV7FN3XKi0AJyKcCPKiOwMKjsrVYsoleZ0/LyBXZCR93MhSUpEY9YDZIBp7vkH/ySbOXmQ18mvs7ASiNV0MdYtG5TiATMKHokpgYrdUf2xjzlIvsvf2gay+fxQAaYHx1pEKDkbA1UChyZKllgJ1iz2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EWe1fDYS; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4ef66183024so98249e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719294518; x=1719899318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNdi7aqLPaDq7mcCmj8ltEqqTcHmeKwm+6qNaCHj4kw=;
        b=EWe1fDYSo5w1cxqR5ykkopRifQgwC2n6RyvunvGZ1C06EfCn8SVzkdiEACNvfDoNFd
         LjuC4u6bMSInoQ1apdOmrs9Hqhocawa5YgAkya4xrbWqe2Xxr5lribhUW3kLAD/oXMvT
         uVoU/IkduMkho9Z+0tOePD1SLkfaYnb/p83fMImgbyoxKcZEoQOvt7s/hFssdVaUqtU7
         F/r0sozYF+dUc89GWRy5n78z9vBrkjFe/Yorfg5Z3ys7y9boghxdjR3EZxzhDA80uKHu
         bBj1SC1Y7mHPyZcyOFcY+pTwL1jz8/keiXEZYuEV2QQ0D5dNnmFgMkWw38R7zcqQFZ9T
         t0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719294518; x=1719899318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNdi7aqLPaDq7mcCmj8ltEqqTcHmeKwm+6qNaCHj4kw=;
        b=uqxiYsE3sz0Pg6cBuaoOMLFhnP8j8dLX6INTdDdHLO7fIe77zteccXOk0MMrPCCKvP
         Ley5rw910ugldswAzDfSAGsJVYLR9S04z//0W3fb3RAdhFM1PmlwCbaLEd0jSwaFT1Ch
         IBTG9+sgdnyqH3q2OZDHAzbKawRpayhUqxzMQnx4kysrqW6k8X4SxnM/9ErZAgwoJ792
         /Utf3JJix00THen8ML0D0Lga2MaK5UJo0a4mZlUykpW4OgWzBAWk/v4RJ16fqH1I52P0
         MF+K2CzyBDdAn6TWcZ+QScs1NLyKS71FaLm9rjkSOiuiCTjFYNdD409s7Z1h4MUJgBOJ
         ZfYg==
X-Forwarded-Encrypted: i=1; AJvYcCXQyaaqxOnPQHfrEYqTclIOjxALsmUyBuvE7y7e7TlrfjTvAfifQnCOAHdxOhdX7E7DPcx1p8wZTI0OdnqlaQv6Q5goeoNRzH5rDj3L
X-Gm-Message-State: AOJu0Yw+zvhaVUP0K2n9GO51+Ot43vgNUXcqWjT9E/LMuwCMt+LeYxfH
	Gst+j8Bqn9aJCg5vl1kPHnEJj0QyK3/E8JPPqw/3dX7m16EdVu1YY4WnLUW/qNvtBBQX/JJhJe+
	3QB3xT2Tl91CWkVTWQ6l2hF+dQ44Oyr8BPrBYoA==
X-Google-Smtp-Source: AGHT+IFKwEk98CWPI13i8+UFNMNJSNvpOC7aR/wyV/ooeLBJqqZgrEl0oorrEdQDYcopzfyLeyNKh0H0AicGfqcpk8w=
X-Received: by 2002:a05:6102:50a2:b0:48d:aced:abff with SMTP id
 ada2fe7eead31-48f46c146c1mr7490671137.1.1719294518060; Mon, 24 Jun 2024
 22:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624124941.113010-1-alisa.roman@analog.com> <20240624124941.113010-6-alisa.roman@analog.com>
In-Reply-To: <20240624124941.113010-6-alisa.roman@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 25 Jun 2024 08:48:26 +0300
Message-ID: <CA+GgBR8r_W9X0hROUEw-xePyKAhOTBjJtf=cHbfWfvUUfk5j_g@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] iio: adc: ad7192: Add clock provider
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 3:51=E2=80=AFPM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> Internal clock of AD719X devices can be made available on MCLK2 pin. Add
> clock provider to support this functionality.
>

Just a question that should be addressed by the failing of the
clock-provider registration.
With that addressed:

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  drivers/iio/adc/ad7192.c | 89 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 940517df5429..90763c14679d 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -8,6 +8,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -201,6 +202,7 @@ struct ad7192_chip_info {
>  struct ad7192_state {
>         const struct ad7192_chip_info   *chip_info;
>         struct clk                      *mclk;
> +       struct clk_hw                   int_clk_hw;
>         u16                             int_vref_mv;
>         u32                             aincom_mv;
>         u32                             fclk;
> @@ -401,6 +403,88 @@ static const char *const ad7192_clock_names[] =3D {
>         "mclk"
>  };
>
> +static struct ad7192_state *clk_hw_to_ad7192(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct ad7192_state, int_clk_hw);
> +}
> +
> +static unsigned long ad7192_clk_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       return AD7192_INT_FREQ_MHZ;
> +}
> +
> +static int ad7192_clk_output_is_enabled(struct clk_hw *hw)
> +{
> +       struct ad7192_state *st =3D clk_hw_to_ad7192(hw);
> +
> +       return st->clock_sel =3D=3D AD7192_CLK_INT_CO;
> +}
> +
> +static int ad7192_clk_prepare(struct clk_hw *hw)
> +{
> +       struct ad7192_state *st =3D clk_hw_to_ad7192(hw);
> +       int ret;
> +
> +       st->mode &=3D ~AD7192_MODE_CLKSRC_MASK;
> +       st->mode |=3D AD7192_CLK_INT_CO;
> +
> +       ret =3D ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +       if (ret)
> +               return ret;
> +
> +       st->clock_sel =3D AD7192_CLK_INT_CO;
> +
> +       return 0;
> +}
> +
> +static void ad7192_clk_unprepare(struct clk_hw *hw)
> +{
> +       struct ad7192_state *st =3D clk_hw_to_ad7192(hw);
> +       int ret;
> +
> +       st->mode &=3D ~AD7192_MODE_CLKSRC_MASK;
> +       st->mode |=3D AD7192_CLK_INT;
> +
> +       ret =3D ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +       if (ret)
> +               return;
> +
> +       st->clock_sel =3D AD7192_CLK_INT;
> +}
> +
> +static const struct clk_ops ad7192_int_clk_ops =3D {
> +       .recalc_rate =3D ad7192_clk_recalc_rate,
> +       .is_enabled =3D ad7192_clk_output_is_enabled,
> +       .prepare =3D ad7192_clk_prepare,
> +       .unprepare =3D ad7192_clk_unprepare,
> +};
> +
> +static int ad7192_register_clk_provider(struct ad7192_state *st)
> +{
> +       struct device *dev =3D &st->sd.spi->dev;
> +       struct clk_init_data init =3D {};
> +       int ret;
> +
> +       if (!IS_ENABLED(CONFIG_COMMON_CLK))
> +               return 0;
> +
> +       init.name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-clk",
> +                                  fwnode_get_name(dev_fwnode(dev)));
> +       if (!init.name)
> +               return -ENOMEM;
> +
> +       init.ops =3D &ad7192_int_clk_ops;
> +
> +       st->int_clk_hw.init =3D &init;
> +       ret =3D devm_clk_hw_register(dev, &st->int_clk_hw);
> +       if (ret)
> +               return ret;
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +                                          &st->int_clk_hw);
> +}
> +
>  static int ad7192_clock_setup(struct ad7192_state *st)
>  {
>         struct device *dev =3D &st->sd.spi->dev;
> @@ -412,6 +496,11 @@ static int ad7192_clock_setup(struct ad7192_state *s=
t)
>         if (ret < 0) {
>                 st->clock_sel =3D AD7192_CLK_INT;
>                 st->fclk =3D AD7192_INT_FREQ_MHZ;
> +
> +               ret =3D ad7192_register_clk_provider(st);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to register clock pr=
ovider\n");

A question here: do we want to fail the probe of this driver when it
cannot register a clock provider?
Or should we ignore it?
No preference from my side.

>         } else {
>                 st->clock_sel =3D AD7192_CLK_EXT_MCLK1_2 + ret;
>
> --
> 2.34.1
>
>

