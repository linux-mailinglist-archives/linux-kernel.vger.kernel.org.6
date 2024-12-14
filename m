Return-Path: <linux-kernel+bounces-446095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6279F1FD4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17A4166A76
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050B4195FE5;
	Sat, 14 Dec 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="xJYOmTSX"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E02522F;
	Sat, 14 Dec 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734192043; cv=none; b=QyFGm33x2fjD/cyN4bKi/2MluzJrAXCipkxvdKaqvrF+lJzg3btqnywBSDb9EXTDAntHXfEWfpHgp3AdwbRXjHfv6V1C6WVLhcSm16aiCLHdBao8g+DjnDnTweuXnvx2hhbhrDyiY3h7TzDq/ICiXfiq/uM9Txk94jVUGlC5nFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734192043; c=relaxed/simple;
	bh=cQzWzu8XtFrCLU07Ik3mfaf9pv8rRjwApaUuo6gfXgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSWtf/sb/q+G9fE+jNMsJFkjwfuUUXN9FOR0HRLaXhTJevdamQHzV/QDTA5P3lFC5mzJjy2D3QRr5DSAMIgi5CK+T2k3+jTYorM9Slhu1v4Q8IAH9BFnhZa59x5cNtg9MvL8tjPMfCvD2/gkzHUQvW0KQIQekobSTLBxGayRh70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=xJYOmTSX; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 63DBA1FA3C;
	Sat, 14 Dec 2024 17:00:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1734192030;
	bh=NAvFo4B9xeAbWfzauXAxpZ2NpPI3rl8NI6umA00zduA=;
	h=Received:Received:From:To:Subject;
	b=xJYOmTSXu2e6untE2uCAon9U2SPqLIY1jbLP2oZ13DSKQyY9E7ET9X8yW0l2TKo0z
	 ral4rx6HC2bW1Y1C//mvocH/6RdlG6hK1ciZu8zggBo13q7LsB1uZL1RKDab2xeczi
	 Wg8EVCCyPQOPqMNemv5lYRE1JFzH2vFM+wkDwxuOrG3a1Ocj+Lo+HUydwi9p/j7dz5
	 85yNVa3uzsDKQPEyZmXmPUrb7kq5SjGFQIdSJsOh/dMJvDorMcOUf4oDdY3EoRsVEl
	 EIhyTlQDrM181893LOe0B2mVeKKQIbPiG/u/mjezjKQfqUYLsTVIQTQlIeP68Lbn3i
	 +twmHBxxEBDmg==
Received: from livingston (unknown [192.168.42.11])
	by gaggiata.pivistrello.it (Postfix) with ESMTP id 0B7277FA6A;
	Sat, 14 Dec 2024 17:00:30 +0100 (CET)
Received: from pivi by livingston with local (Exim 4.96)
	(envelope-from <francesco@dolcini.it>)
	id 1tMUZB-00028R-2o;
	Sat, 14 Dec 2024 17:00:29 +0100
Date: Sat, 14 Dec 2024 17:00:29 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Bryan Brattlof <bb@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62l: add initial infrastructure
Message-ID: <Z12rnZiCXQxtMWlf@livingston.pivistrello.it>
References: <20241117-am62lx-v1-0-4e71e42d781d@ti.com>
 <20241117-am62lx-v1-1-4e71e42d781d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117-am62lx-v1-1-4e71e42d781d@ti.com>

On Sun, Nov 17, 2024 at 11:34:07PM -0600, Bryan Brattlof wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Add the initial infrastructure needed for the AM62L. All of which can be
> found in the Technical Reference Manual (TRM) located here:
> 
>     https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml |  6 ++
>  arch/arm64/boot/dts/ti/Makefile                  |  3 +
>  arch/arm64/boot/dts/ti/k3-am62l-main.dtsi        | 52 ++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi      | 33 +++++++++
>  arch/arm64/boot/dts/ti/k3-am62l.dtsi             | 89 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62l3.dtsi            | 67 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-pinctrl.h              |  2 +
>  7 files changed, 252 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index 18f155cd06c84..b109e854879cb 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -31,6 +31,12 @@ properties:
>            - const: phytec,am62a-phycore-som
>            - const: ti,am62a7
>  
> +      - description: K3 AM62L3 SoC and Boards
> +        items:
> +          - enum:
> +              - ti,am62l3-evm
> +          - const: ti,am62l3
> +

can you clarify the differences between AM62L and AM62L3? you have a mix of names in this series. I assume that
AM62L is the SOC family / product name, while AM62L3 is a specific part number.

Francesco


