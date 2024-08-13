Return-Path: <linux-kernel+bounces-284008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF35694FBD9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD0C282495
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ABC17BAF;
	Tue, 13 Aug 2024 02:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="XWV/BGCh"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D1812E48;
	Tue, 13 Aug 2024 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723516479; cv=none; b=pz77EUGXnoOvfsrIR6fc4cxQrTbvlMWcJzy71K5EgVaIT7vLkSDR2gjNSI8HWe4sVIj4+Za8mq/q1qDMF++xT/nScpBiJ5ZwkhbAvQMajne5GL09mgWK9AtKb59NUDC7PFqAV2dT/9BE+QzkMUJ9Y3JjYmNVmpkofiN/dkDjtE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723516479; c=relaxed/simple;
	bh=EMeH1NJHx5IUNy98hKE4tOu9I1lZRfEgI6otXBXVUIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TysOPUKyxW5T8PZtkR7mgohbV/aXORYVB8KxJ54UX0mJLHdURagO8UIBUnPRkNlhpiQ4EGp3pzfNCtP9J4MQ+5UFUblbS/aCvxneXskKf8XsY6ONsOO0Ntwy8Rl0sUgGOGXSE3V4xEaCR7QrXigIUAdm8fNLttYywmz6T/KXIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=XWV/BGCh; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=0ZFfYlPCfZ60YODfVnYog5x+aSANQghjZgqNXkiTGMM=;
	b=XWV/BGChF2An0Wg1diKhPt6UtZe94DgIZQlpHqlF4JV4s7g7MxGmv/a8PW90xD
	2IbtGooY88UEzWzAkm6q2lGNhBezZWO1JAnepyvMAKFFpzr5vJDWs64PF2tDixrr
	p0WqYI4KOR8dyTZwn81X2ESfhPSydfvbP/kEl2np+sRQ0=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDHz4fyxbpmFMReAg--.37813S3;
	Tue, 13 Aug 2024 10:33:23 +0800 (CST)
Date: Tue, 13 Aug 2024 10:33:21 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Wei Fang <wei.fang@nxp.com>
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"abelvesa@kernel.org" <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND 0/4] add NETCMIX block control support on i.MX95
Message-ID: <ZrrF8b91WAsmuFG9@dragon>
References: <20240729012756.3686758-1-wei.fang@nxp.com>
 <PAXPR04MB851069B02D5B71BC7AADD38988852@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB851069B02D5B71BC7AADD38988852@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-CM-TRANSID:Ms8vCgDHz4fyxbpmFMReAg--.37813S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVxR6UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRs6ZWa6WIL-LAABsZ

On Mon, Aug 12, 2024 at 06:39:05AM +0000, Wei Fang wrote:
> Hi Abel,
> Can you help apply the first three patches to your tree? Our i.MX95 Ethernet
> driver depends on this patch set to be able to go upstream. Thanks!
> 
> Hi Shawn,
> Can you help apply the last patch ("arm64: dts: imx95: Add NETCMIX block
> control support") to your tree? Or should I wait until the first three patches
> are applied and then send a separate patch about DTS?

I will pick up the DTS one after the first 3 patches get applied.

Shawn


