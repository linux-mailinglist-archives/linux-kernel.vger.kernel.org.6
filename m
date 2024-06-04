Return-Path: <linux-kernel+bounces-200918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F38FB687
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686FE1F2202E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5302813D533;
	Tue,  4 Jun 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq0s2MUg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6A13D24C;
	Tue,  4 Jun 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513490; cv=none; b=SipsX+i4Ot1QyNdHD8ZzhJ18lIiks8KTpAGJ59B+Rj3YZGuP3ObQRrANU5q9lUSdgH7Lj4h+zYulD+xoA12u2o+Akn6fteneJno9UePfRomVv756ZUATzaXcl+OxmHL3i3zL+qiUoj+8gjL1frlVA9zaPXEmwVaIET5Mvj0mlYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513490; c=relaxed/simple;
	bh=2mZOWMrgvpBKUIzmZNepZyOLeeZ25GOr2IADJGaiR6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5Bv5eHCMtNEC3ZdV82wbQv6jzyyV5mmY3aw4SsThUeFSiCEee9WYRRFi7bFFBfX5rVoJJaMa5dV6xO05kkpjetzQOwyC+xVv/kBysn6ugimpRmRA0p0fPI0r+UEX4KmSFyppHoxOHLkk/TgoSw7QSNBq3RmmNyqj8RgpuDcdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq0s2MUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB7BC4AF08;
	Tue,  4 Jun 2024 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717513490;
	bh=2mZOWMrgvpBKUIzmZNepZyOLeeZ25GOr2IADJGaiR6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eq0s2MUg0+tnl/PPjeqrm8pvFM6wxqla1fNBg8+7pRLhLPg/HH1KbaUc15VtDCJPZ
	 7qD7/dCR7q+eiINty2+45Im6dnHfUqXT4l1VCZOlfF0/FiOqosfbbo9SSRm9jB2ubO
	 rwh6v1UjRH8/0v8vgDGmHrlsXicAg+AtbcsSJz8xtxMVchIq2lXY7kx9/hlqDWozS4
	 qMTnbAHbMepxcKXFMNUcQJf1STZZV86SLVARXYExkiNke40IOVLoSXIvRx/lYKNatv
	 lp/WQ/tcaeHGJn0LuSHHVrujrsxQ5k8TsZk1r2mD7txtZCYQIqvTryITPTmBvBBtXw
	 tLgL5uZvFd37A==
Date: Tue, 4 Jun 2024 10:04:47 -0500
From: Rob Herring <robh@kernel.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, abelvesa@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	ping.bai@nxp.com, ye.li@nxp.com, peng.fan@nxp.com,
	aisheng.dong@nxp.com, frank.li@nxp.com, tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com, gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com, joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com, Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de, m.othacehe@gmail.com, bhelgaas@google.com,
	leoyang.li@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] dt-bindings: clock: Add i.MX91 clock definition
Message-ID: <20240604150447.GA604729-robh@kernel.org>
References: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
 <20240530022634.2062084-3-pengfei.li_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530022634.2062084-3-pengfei.li_1@nxp.com>

On Wed, May 29, 2024 at 07:26:31PM -0700, Pengfei Li wrote:
> i.MX91 is similar with i.MX93, only add few new clock compared to i.MX93.
> Add i.MX91 related clock definition.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  include/dt-bindings/clock/imx93-clock.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
> index 787c9e74dc96..ca0785f35a46 100644
> --- a/include/dt-bindings/clock/imx93-clock.h
> +++ b/include/dt-bindings/clock/imx93-clock.h
> @@ -204,6 +204,11 @@
>  #define IMX93_CLK_A55_SEL		199
>  #define IMX93_CLK_A55_CORE		200
>  #define IMX93_CLK_PDM_IPG		201
> -#define IMX93_CLK_END			202
> +#define IMX91_CLK_ENET1_QOS_TSN     202
> +#define IMX91_CLK_ENET_TIMER        203
> +#define IMX91_CLK_ENET2_REGULAR     204
> +#define IMX91_CLK_ENET2_REGULAR_GATE		205
> +#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
> +#define IMX93_CLK_END			207

Drop the END define. If it can change, it's not part of the ABI.

Rob

