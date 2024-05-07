Return-Path: <linux-kernel+bounces-172239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C26758BEF9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077E31C232A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0570A14B978;
	Tue,  7 May 2024 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAgk5W1e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2A77658;
	Tue,  7 May 2024 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715119370; cv=none; b=OQhxKOwUQa8QfZtAEwi3EM5xfnMI1Qq6cxe2a0s9h1kKIyDQX8kpMa/cUifr0A30djz1NGbo73euhliH49m37YODiKVt8EVYHEIC33umUVSwrTBep6tAb27WUGPG+bJ99o0axXhfeUgIBjubL4FRV2PYYl+pyfAi4E3UQP67peE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715119370; c=relaxed/simple;
	bh=ECDBXpA/C+eVvh+6xfhTbhth3yLG8cu9XKxgvKvqxOo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=iUi3Yq4Fsp5OePfSz6JAdwEgjXbWw1uk0l/OznoSyK8CVhGNDmXzHIGttXWfLcAuP3c2TQmFID1sy6A1/CJNkOflvU2avGcRxEXv0EI+/blSq+k9Uxn9//HhyBr3E7XhIzd0QpVXqU+qSp723TIBml1wdhT4CYUcF1OLMRbc84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAgk5W1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3235C2BBFC;
	Tue,  7 May 2024 22:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715119369;
	bh=ECDBXpA/C+eVvh+6xfhTbhth3yLG8cu9XKxgvKvqxOo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gAgk5W1e0tOEO9WlYzPLOCZ+9mCwBDvfyQTxMT4LvrHCji5I0WgltgrclRalG72pj
	 WMuOyg0CXOXsp067YM5S7JkutAgSs0kD5O+0zBa6RNx/+/VMwNGExSAJgHSDpM4Gwj
	 PHQcfg+MJpIDPACHsBAFqUYI0HGwYAefjvlNLRiMSCkziG7qCo7OPEZFdY4TOGyhAq
	 JY9it3DU1wkY2LPQ6lujypdORiS/snyOk7+BvnYuSYbxptlSdUj/JJ6eZ+kgazNaVq
	 todH6nHNaskpq3Em4qBytUT3yIm4I6rfL5/ZjY8cnr0N6hZVvtbIrnM9L0oKWsVT50
	 dqson14uMhgZg==
Message-ID: <332c845c17e24e2eb660e18680f2626f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240419152723.570159-3-gabriel.fernandez@foss.st.com>
References: <20240419152723.570159-1-gabriel.fernandez@foss.st.com> <20240419152723.570159-3-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH 2/4] clk: stm32mp2: use of STM32 access controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Tue, 07 May 2024 15:02:47 -0700
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2024-04-19 08:27:21)
> diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk-st=
m32mp25.c
> index 210b75b39e50..a37ee9f707e3 100644
> --- a/drivers/clk/stm32/clk-stm32mp25.c
> +++ b/drivers/clk/stm32/clk-stm32mp25.c
> @@ -4,7 +4,9 @@
>   * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicro=
electronics.
>   */
> =20
> +#include <linux/bus/stm32_firewall_device.h>

I don't have this include. I either need a signed tag or this needs to
wait until next merge window.

>  #include <linux/clk-provider.h>
> +#include <linux/of_address.h>

What is this include for?

