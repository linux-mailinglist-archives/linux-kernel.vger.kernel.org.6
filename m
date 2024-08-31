Return-Path: <linux-kernel+bounces-309905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C29671B1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BC828395A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139A9461;
	Sat, 31 Aug 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="KZGpWoYn"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513D37494;
	Sat, 31 Aug 2024 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725109797; cv=none; b=ah13OJdIST5yGAzendlDncxxw6nmJjFwTpNZU4csl805EG5oU36C7ykbE/lQkzjBJd+MZTNvzVFPiqDzqQQrBidwe7mlDRWRLckL+GbAKADfMcBm5fnoroTjhfILvnrBZPEWBZDXj4dOXcvZDH26T+zxxBm/GajkZCbQYxbKRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725109797; c=relaxed/simple;
	bh=JhbA8SLC7PqTOJM4EjydUp66srUh+KBL2NPDw8VnI+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA/cqAxo/O1CIUoBbjkij/lEUF/PnFPPdQ+86adbXd7w9mOGEIDv7n4n1PnjpSyzvo0pUcngnKtVitQSRKEYSrp3d/Nu0ZQXRLCai2TghShvDw7mA4vXApmc5pzJ9PCbdb24HcvK4mUkD86e+p0ZidmFgB8ZABKi3EGeoMewMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=KZGpWoYn; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=hBxY1wW+vCTmGRcQG2NrNyjhBF4l614KDLIpuKsQrS4=;
	b=KZGpWoYnBnxUI9tXJzTbd1KZVZDPR3pqI9QC4nSUmkNoa01s+BCekOiZWobjfC
	HfRMcMJ7SGvFt3I/6vsmjhVeMf1iVP8z1F7dkW79BbUbCdwGdDnT2RvnCBHWVwnr
	lpl70qEeXE6cQ+0nwGkAdLmEZLa0Tk9YWj/Scm9Px8u+A=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3X_LAFdNmMzI6AA--.19966S3;
	Sat, 31 Aug 2024 21:08:18 +0800 (CST)
Date: Sat, 31 Aug 2024 21:08:16 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Fabio Estevam <festevam@denx.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v5 0/2] Add support for Kontron OSM-S i.MX93 SoM and
 carrier board
Message-ID: <ZtMVwKT5NbTywXtQ@dragon>
References: <20240813084934.46004-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813084934.46004-1-frieder@fris.de>
X-CM-TRANSID:M88vCgD3X_LAFdNmMzI6AA--.19966S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DKr47Ar4UCry8KFyDZFb_yoWfJrbE9a
	4UWa4DK3W8G3WIkF1Fyr1kX3ZxKay0kryq9wn0gw4fXFW7JrW5tFZ5Kry3Wa4rWFWrCa4v
	ya1kXa9rAw429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbD5r5UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxBMZWbS-Ekw8QAAsy

On Tue, Aug 13, 2024 at 10:49:03AM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Patch 1: board DT bindings
> Patch 2: add devicetrees
> 
> Changes for v5:
> * Address Shawn's review comments (thanks!)
> 
> Changes for v4:
> * Reorder enable-active-high property
> * Add dedicated pinctrl settings for different SDHC speed modes
> * Add SION bit for SDHC pinctrls as workaround for SoC erratum
> 
> Changes for v3:
> * remove applied patches
> * rebase onto v6.11-rc1
> 
> Changes for v2:
> * remove applied patches 1 and 2
> * add tags
> * improvements suggested by Krzysztof (thanks!)
> * add missing Makefile entry for DT
> 
> Frieder Schrempf (2):
>   dt-bindings: arm: fsl: Add Kontron i.MX93 OSM-S based boards
>   arm64: dts: Add support for Kontron i.MX93 OSM-S SoM and BL carrier
>     board

Applied both, thanks!


