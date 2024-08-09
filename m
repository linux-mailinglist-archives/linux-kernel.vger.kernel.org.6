Return-Path: <linux-kernel+bounces-280325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1299494C8B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 04:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B32B211C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F961803D;
	Fri,  9 Aug 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmAVLbCS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01B17BA9;
	Fri,  9 Aug 2024 02:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723172302; cv=none; b=tDhoOXAxsltTH4ryX51KryqJxFz4XNAC4cpGYNePaajE8Zf2gQKr8wCrT6Jz8YoralplukGBt5V3AYA25btaM8KtWzCc5JVUwTZsPmTc62BTmmO2e4YdpHQnRgoUKfvTZTibn96GIamTXOdj/Hh5HR4V0M84rFnwEpgUGC6Sk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723172302; c=relaxed/simple;
	bh=bz9nhQIN68rliIlQwFtbNxyMdG7FAqda1nTylmhka+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RP9MduRjgmDhVzN+Q+VaUyWL7xiFcmAKJkjOTAVyfa6Qi6xMzbCcCIMAKoueAMnUXDCkRUS+WCmafcXS32USjpmMOcU0IV3cUu0CtC3N1Et5FWq8ubGI9IkdzjaIbrCWgiMRIxtFTj1wS237/XmKfjEkpRtL0bpyJN5keTpziiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmAVLbCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F99C32782;
	Fri,  9 Aug 2024 02:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723172302;
	bh=bz9nhQIN68rliIlQwFtbNxyMdG7FAqda1nTylmhka+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FmAVLbCSCRp8O5sabC8ZA9Fa2UUWiO/oGl54klQO5M7hAyxEj76clzs1czMZAsL1l
	 qqEBFHFOBMF+B8i/loc6HelWxB5dmnNjz85wStJ4hKUcmoDtpdaSkkq2TOauEKnZOB
	 dZWV3KVBpOGHjku33R+mJMhFsMw0idKGqByaujnHY5jNdvqdUCcmR/y1qIE0HrqCy2
	 zc/37hS1nvogm0AwyyRCYb2gNwq11txgewgV8A7mvBKuQOUOub7Whw2QndAezhXmu4
	 zuPZAcLp132TMDVXUSgL1B1nCpjj7cYENNrYw57QyKzb/KdxuC7drrS/pqcb8cxWGS
	 7E9dI40Enn3Lg==
Date: Thu, 8 Aug 2024 19:58:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, Linux Team <linux-imx@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/4]  net: fec: add PPS channel configuration
Message-ID: <20240808195819.74f9e594@kernel.org>
In-Reply-To: <ZrU_QwbcgaUxBg61@gaggiata.pivistrello.it>
References: <20240807144349.297342-1-francesco@dolcini.it>
	<ZrU_QwbcgaUxBg61@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 23:57:23 +0200 Francesco Dolcini wrote:
> On Wed, Aug 07, 2024 at 04:43:45PM +0200, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Make the FEC Ethernet PPS channel configurable from device tree.  
> 
> I realized that I forgot the `net-next` subject patch prefix on this series,
> let me know if I should re-send it with it added, thanks.

Hm, normally I'd say no, but we also didn't get patch 4 CCed to us.
We use patchwork for a lot of things (including CI ingest) and if
we don't get all the patches patchwork considers the series incomplete.
Could you either repost and CC netdev@ on all 4 or repost just the 
3 patches meant for netdev as a standalone series?

