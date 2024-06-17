Return-Path: <linux-kernel+bounces-216633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAEB90A26C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6654B1C21AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B563176AB7;
	Mon, 17 Jun 2024 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="YedPxTmO"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1B23A9;
	Mon, 17 Jun 2024 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591209; cv=none; b=FNp+YIEO44svK6VrugW13zpj+9asAKoi4spiNjKk3VN3x6BuwoFCAR3+xo4hfL/XafXQA99F/I/K8DxXfQPfzFUfr6tS1LDj7i7u5y7/nKvr7+/F1PYgsZU6H7CJOzqy6QDPZXyftvAVQJ/0FrHPlxiALRBvVAokHvuZSx3EY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591209; c=relaxed/simple;
	bh=44Ip4MpDpvbbELazKfCtpt8hUnGs0ULGPPnP59pS5AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqUEWs0PUvxiR6yrn4KFNmkH+N1ihZfUOe/02RqCdcS915CfvSUC+uPOn1PXeDDiTs+qcE4XYQq6PzoJF67364Q1rsbfXZiWjnlG2QHDrX4D2ehmwC309+8deZqDNx32tEOHdWaUN3ZM27CC/dxBvqJHsiYoF8nX9vAYYf9OHU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=YedPxTmO; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=UzRS40U5/LPPmxXbUV5UdyzySjYYlr6Ws3i6/OCKy5w=;
	b=YedPxTmONWBUG3jg8Fa85RpOdjBRHELvJNkIcKO6HV7zFcyPodFd9iTXzRBdZr
	q3yjw7r0GSNceXWKNvlqTW3J/y0BfpkZshwn0qpCfdifBXyiCFjuP4Sd+u9KBWzc
	ajJhXuE1iuF6yT/T6TZX2REjFPbIcIczTdNw6mjy+eBLQ=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrADnr0G9nm9mU0AMCA--.39214S3;
	Mon, 17 Jun 2024 10:26:06 +0800 (CST)
Date: Mon, 17 Jun 2024 10:26:05 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-mediatek@lists.infradead.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] soc: add missing MODULE_DESCRIPTION() macros
Message-ID: <Zm+evaRZ6/6BOvAw@dragon>
References: <20240611-md-drivers-soc-v1-1-8f0fc9fff234@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611-md-drivers-soc-v1-1-8f0fc9fff234@quicinc.com>
X-CM-TRANSID:ClUQrADnr0G9nm9mU0AMCA--.39214S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWkur13tw1UJFyrtryxKrg_yoWkXrcEkr
	Wkt3yxuw17Jry8Cay5CF1kZF9F9Fn7X3ySqw1jgryrXrW7Zw1UJF4kur43Ga4UZw4xAF1D
	Ars7Xr1rJFWUZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8E1v3UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDx4BZVnxc0yUrgAAsY

On Tue, Jun 11, 2024 at 10:50:58PM -0700, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/imx/soc-imx8m.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/ixp4xx/ixp4xx-qmgr.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/ixp4xx/ixp4xx-npe.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/mediatek/mtk-cmdq-helper.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/amlogic/meson-clk-measure.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> This is the last of the issues that I see in the soc directory
> ---
>  drivers/soc/amlogic/meson-clk-measure.c | 1 +
>  drivers/soc/imx/soc-imx8m.c             | 1 +

Acked-by: Shawn Guo <shawnguo@kernel.org>

>  drivers/soc/ixp4xx/ixp4xx-npe.c         | 1 +
>  drivers/soc/ixp4xx/ixp4xx-qmgr.c        | 1 +
>  drivers/soc/mediatek/mtk-cmdq-helper.c  | 1 +
>  5 files changed, 5 insertions(+)


