Return-Path: <linux-kernel+bounces-202034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC6B8FC6EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3721CB210AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E802518C325;
	Wed,  5 Jun 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="GnFpXb4s"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91F149C7E;
	Wed,  5 Jun 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577246; cv=none; b=dGPMGiy5RtJTFt+pPsOd2adQn19P0AwQkojOQ+K+P686eqAWG0LIFNpAi7FRtS6/s9mXd0fNw5n96v7VSBDDNWI3Z8Y9EAOrfvpKMi4pWyBB8HkbPv3fEXxGUnfqQ/L4QJ6WpLHbZtVimuG69xsgKrlUMnMQvNqMw8p3I1otPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577246; c=relaxed/simple;
	bh=3Xrui2JoJKAl5MEYnfvzHwAIj37MVBCGvRSHHsxOQwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJi4dd20IVh1h5w/iXtvDD4jXu2NZIryRuNEXR5fLdnmxqQuLzUaOOAKPtSHcoOa1yoYoql/iyaRsBEwDPyXj/+JuLk2sYr7xirpzCAoLWGFTBFc8QkBpKvjHkkYWZf2cgoEAOhykJTSlYl5v3JGKEv/cAURof1iUeacsCXbmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=GnFpXb4s; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 2E8A81F843;
	Wed,  5 Jun 2024 10:47:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1717577238;
	bh=xPg8iIOPgRxEgj4VlXJ9uIv+R1QzFM1fm/iyzjcKhGM=; h=From:To:Subject;
	b=GnFpXb4suv0I34y+fusFjIRa4zEQhy90oZ8X9PW0JFkdG/qB/iHXx7LYd5cw+Qyd8
	 I6/c5dcJy+HipSgJvIciXP5mBIzIxju5l8EtXZFN+TrI1r8izHRfT2peypRPZCXUAB
	 d4BC/pl8RlLldypZ9P4/sauTGkGLdNKaFZI1yAPVSIYAoaHosUdH4QlhohUYrgZ4hL
	 PYL28TV+ULlp4TNwPPikerVtYMCu44ezRrRFWe9i1ihWtEE8HRlbp8hXuQPx+P1ORP
	 kVnjugBfGf09shuYIDEXxhOlbystfYI5JZcrNaixTF4ReEvG5UW5nviP8s2U8ylv1y
	 c5LALiRZ52r+Q==
Date: Wed, 5 Jun 2024 10:47:13 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jai Luthra <j-luthra@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Devarsh Thakkar <devarsht@ti.com>, Bryan Brattlof <bb@ti.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: ti: k3-am62-verdin: Drop McASP AFIFOs
Message-ID: <20240605084713.GA10711@francesco-nb>
References: <20240604-mcasp_fifo_drop-v1-0-03ebe25f47db@ti.com>
 <20240604-mcasp_fifo_drop-v1-5-03ebe25f47db@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604-mcasp_fifo_drop-v1-5-03ebe25f47db@ti.com>

Hello Jai, thanks for the patch.

On Tue, Jun 04, 2024 at 03:11:06PM +0530, Jai Luthra wrote:
> McASP AFIFOs are not necessary with UDMA-P/BCDMA as there is buffering
> on the DMA IP. Drop these for better audio latency.
> 
> Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> index 2038c5e04639..27e5220e1dc7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> @@ -1364,8 +1364,8 @@ &mcasp0 {
>  	       0 0 0 0
>  	>;
>  	tdm-slots = <2>;
> -	rx-num-evt = <32>;
> -	tx-num-evt = <32>;
> +	rx-num-evt = <0>;
> +	tx-num-evt = <0>;

From my understanding of the dt-binding having these properties set to
<0> is equivalent to not having those properties at all.
My suggestion would be to just remove those, therefore.

With that said, in any case, whatever you do my suggested change or not,

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


