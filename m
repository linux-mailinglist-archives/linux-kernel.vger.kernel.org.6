Return-Path: <linux-kernel+bounces-248350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E292DC00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABB91C21F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49C714AD25;
	Wed, 10 Jul 2024 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhiHoxeu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB2848E;
	Wed, 10 Jul 2024 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720651219; cv=none; b=ABlL/ueVJr38eo8++wHGrFQGQbk8FIAHcXHGF2RI/c2AtWvmBcnjd4/kWinNy7SdaUc3bdUJ81FE64GJc06pUjorVvm/eWBzlNQZZD7rIQRDwoidke2+bw3mZdIKf/9bY6DC0vcHmF487GmEmBGXg0a8ArG7pkPITGY8u+OqAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720651219; c=relaxed/simple;
	bh=n8Br65WDv0TBlYxPu6aUcBP9x0s1qbWYkv6MPDoPWM4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JXBmdfajrj4rTh9V6jTUj3pPpr8tF7LqQUS7x2YeHR+1nOgRSVm4uIiEeKKiCRW5XnqzROjMtAvmxBEC3PawGVUSRuaCJfzn9eoeyLis3LELdgeGUfPu2pwW7hNHD8ERnsazV1rRf3ChRTHXOq02yUhKoNX1nHTmtNlcJX0CeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhiHoxeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DD4C4AF09;
	Wed, 10 Jul 2024 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720651218;
	bh=n8Br65WDv0TBlYxPu6aUcBP9x0s1qbWYkv6MPDoPWM4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=EhiHoxeuwg0jmhdrH2kjIwU9yvphwj3ZYHPQ4+GUDGaza2oZI0dVr3epGOxPf9Nh6
	 38dmF7bkQ5GXcfsJ50wR6q5CyrarhvrWher0+cMgmzX9dX+xbFf9NeJqQqoW7sN0do
	 9XqxqaQPxYbyyXyXEX2RFhik49tjB21kL8oYODixoGRa0E3+M1lnT0jp0/UeLqH0u7
	 qVV9pkVkCYjx+BqXehcvDXsfGDzQaJfXixExzMXQUHlp4KYUpOWXy5d/vX5PPc0Vju
	 eHbBaW/6Z5/AVmJgqOLrB2xHnMVQLZOw142encANwRAz2vsAGQIt+V9HVgFTIsecPi
	 ibFQlDFROsozA==
Message-ID: <c34a2d1613da179a27123be95eaf4ddf.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710162526.2341399-6-jbrunet@baylibre.com>
References: <20240710162526.2341399-1-jbrunet@baylibre.com> <20240710162526.2341399-6-jbrunet@baylibre.com>
Subject: Re: [PATCH 5/8] reset: amlogic: add reset status support
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Jan Dakinevich <jan.dakinevich@salutedevices.com>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 10 Jul 2024 15:40:16 -0700
User-Agent: alot/0.10

Quoting Jerome Brunet (2024-07-10 09:25:14)
> Add a callback to check the status of the level reset, as done in
> the reset driver of the audio clock controller.

Why? Presumably so that this driver has equivalent functionality to the
reset code in the audio clk controller?

>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/reset/reset-meson.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 3e0447366ba6..65ba9190cb53 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -69,6 +69,23 @@ static int meson_reset_level(struct reset_controller_d=
ev *rcdev,
>                                   BIT(bit), assert ? BIT(bit) : 0);
>  }
> =20
> +static int meson_reset_status(struct reset_controller_dev *rcdev,
> +                             unsigned long id)
> +{
> +       struct meson_reset *data =3D
> +               container_of(rcdev, struct meson_reset, rcdev);

Nitpick: One line.

> +       unsigned int val, offset, bit;
> +
> +       meson_reset_offset_and_bit(data, id, &offset, &bit);
> +       offset +=3D data->param->level_offset;
> +
> +       regmap_read(data->map, offset, &val);
> +       val =3D !!(BIT(bit) & val);
> +
> +

Nitpick: Drop the extra newline?

> +       return val ^ data->param->level_low_reset;
> +}
> +
>  static int meson_reset_assert(struct reset_controller_dev *rcdev,
>                               unsigned long id)

