Return-Path: <linux-kernel+bounces-555381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8E4A5B6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A21317086D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CF81E5702;
	Tue, 11 Mar 2025 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="QJz17dUO"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2671DF26B;
	Tue, 11 Mar 2025 02:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660082; cv=none; b=hwVTeUUFN9sVNjPbz0h0Ut9XjpVK5CoL0ASK0N26bN7YSpRdj70v7gHL5Akd8ZcKGT05ZIEcxIVKz8xNTMR/Hb0NYVbTqTpmT88okFRzcy8lydDh3RliOYstwyRk7KB4jv+yPKfjAGap7Z5ngxkdhS4QFbEdZhnWB8tcPxXed/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660082; c=relaxed/simple;
	bh=KWatzy3ps/ft2pAnIO0ksgwLKinSyjdTbP0ffkXQcwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLeSdSflA1BJeUPHE7zj+iHbun8Ln/N5xkDrcYmTEGWyZYwVHxAfOJqbL0ryv077mtvzr2eYNFIU2tAMcVJ3Mzgrxa6h5sAteVbwSPCtcKrpxcyAKCc+lDPt+cjKln+0GM4ZpCHxl2c4TNQep3ApZLvUKGwZuyIRYt4A3daclk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=QJz17dUO; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ICnWS1cvR/lqvpW3gZSBK0qzpmW+rKkDV9mICgOyRUw=;
	b=QJz17dUOuRqwYZ4lw1SFnNr1/JueywpcOnyinBhnk7Mj3pbNGLgnEkb878/6qI
	USJVuEPEyLp93fUX2fC+aEJf5yxBTLRDVJqpT084uww3n1eT98OIxAj0FMS1yej0
	/4G5NII8rkRnaPKQvX7si2hZeDxGPh5fsYDJx4ZN6HzGw=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAnDnqBn89nqoywAA--.815S3;
	Tue, 11 Mar 2025 10:27:15 +0800 (CST)
Date: Tue, 11 Mar 2025 10:27:13 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, NXP S32 Linux <s32@nxp.com>,
	imx@lists.linux.dev, Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH] arm64: dts: s32g: add FlexCAN[0..3] support for s32g2
 and s32g3
Message-ID: <Z8+fgXENvCrqXvTP@dragon>
References: <20250224134016.3921196-1-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224134016.3921196-1-ciprianmarian.costea@oss.nxp.com>
X-CM-TRANSID:Mc8vCgAnDnqBn89nqoywAA--.815S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3l1vUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQcNZWfPUELrJgAAsR

On Mon, Feb 24, 2025 at 03:40:16PM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Add FlexCAN[0..3] for S32G2 and S32G3 SoCs.
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Applied, thanks!


