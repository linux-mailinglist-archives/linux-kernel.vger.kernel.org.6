Return-Path: <linux-kernel+bounces-369535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDA19A1E90
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4ED288F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A071D9341;
	Thu, 17 Oct 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gBRHIGkZ"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9377213AA4E;
	Thu, 17 Oct 2024 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157848; cv=none; b=PdAMFkkgLtLVfEMbypvVEsga6wAWAlmnFySnUs0iKaVDQFhUs9q3uclqKc3b3ZoJM46GhHRjE6F+CwCU0kdW2YQ6Gv1J3MFTdUFq+Bg1zmYM8/aDWTnbBC2nkZj4HRTW2FxgBah9vOcctaO/pggKUW//obJc2e7Rs9bYU71NZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157848; c=relaxed/simple;
	bh=xWI71f8VNY/6jODKPIHujw3pQm8LwrhuDJJKQbpkQ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwADGxFkYYHdQ05iY8Ifp3aMxFC5JjvZCVPlGHjwHFY0rRxLhncHae/0ecrT2nu9hHncR9vw2TCUsxtxqmwlBUkmxO+BVSfzYzpbShTub9/k2WPQBPRXeUejl/PaDclR8FnrnnMCXipz8GKav5wXh0WteE+s/3Z4LoeCaC6bSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gBRHIGkZ; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=wyYoVD4usF91bR4K+1sOdk/jm+L3Cg0tKmREs07tdtU=;
	b=gBRHIGkZvcShdsfxMkTZJUay4GMo4foYD0arYDwW3ElAWvkZwSfsGlf1OYrCDs
	S2lnrLQswFUXrhGgwzSHJ6cm8SSgy29bjmVejE+Keuz0xGk8FMxZEfjnlorQJaPV
	aCNzcRcSrUFAtRJnUuXQ/qCu2gCKF64yqWQy/sc4MbL9s=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgBn78N52hBnzR0xAA--.1286S3;
	Thu, 17 Oct 2024 17:35:55 +0800 (CST)
Date: Thu, 17 Oct 2024 17:35:52 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Michael Walle <mwalle@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/2] Add support for new IMX8MP based board
Message-ID: <ZxDaeH2ZJ2vzFmRh@dragon>
References: <20240925124903.1837869-1-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240925124903.1837869-1-michal.vokac@ysoft.com>
X-CM-TRANSID:Ms8vCgBn78N52hBnzR0xAA--.1286S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW3GF45KryxZw1UtrW5Jrb_yoWxAwbEk3
	4ku3WxW347ArW7G3y3trnxWrZxGr1UJr40q34fXwsFkFyxZFn8Xa4vk3s5J34jvF4UAr4f
	JryFya4vvrWagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU03fQtUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRx7ZWcQ0mcYuAAAsp

On Wed, Sep 25, 2024 at 02:49:01PM +0200, Michal Vokáč wrote:
> Hi,
> this series adds support for a new member in our IOTA platform.
> The board is based on the i.MX8MP SoC. It adds support for most
> of the board functionality except USB Type-C port and some other
> minor things.
> 
> This series originally included the dt-binding for that Type-C
> port controller but I finally removed it based on a good comment
> from Krzysztof. I will post the Type-C binding including the driver
> in a followup series.
> 
> Michal
> 
> Michal Vokáč (2):
>   dt-bindings: arm: Add i.MX8MP IOTA2 Lumpy board
>   arm64: dts: imx: Add imx8mp-iota2-lumpy board

Applied both, thanks!


