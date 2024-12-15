Return-Path: <linux-kernel+bounces-446352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28EA9F2342
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C85E188661D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 11:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419CF14E2C2;
	Sun, 15 Dec 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Z6u1m/gC"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A31171C;
	Sun, 15 Dec 2024 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734260793; cv=none; b=JBekrnuDkg5yvUUMgGocyBz4IQ/15tvgb2rBss8dg22ZT/o2f5PT2mRD//qoaxFmSYtQCVJ1lkWWdpcO3n3PTXTwyDlpz/ZJ5N+UfMI2pHn80VjJzG7q+FrgTpxyDGuIg+eNeZKZ0haSpMUaheIoPBC3jdEcohFccVwB40uVk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734260793; c=relaxed/simple;
	bh=FsSnXJ+yDk0Ahld3aH+y0j2Il9K5iNtDR7v10eoQTb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rv8Qpv24xuo3Yj03EOlgpnW3gsmfG+IHN0F3OMUVucR/ZC4uj2GtSuI9sX9bOjnDrxBBPIOJiIe/OuZ8YJ7Ac73jyqvXI8OrzuPojn+hwlsJpoAcm5pt4GzdrRc6pzzSpWMFZMuqP2NBD0AlDXdpTjPv8oCDH/42MqGdiEvXek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Z6u1m/gC; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8A7FD1F920;
	Sun, 15 Dec 2024 12:06:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1734260783;
	bh=pqmyyA9V+nWvG2IPtJHyJld9/5ghcdXXrxiPRuEcLP4=;
	h=Received:Received:From:To:Subject;
	b=Z6u1m/gCu7/Y4/nty/KowRsKY0JfM/YWRcK9HRgSxHkn1lzir9qs1B1/vVHjQjbHd
	 3gPvpnMUaOZb1K+QhzvSHgqGfdFWZ3TbdPdDsTsLdKlkzi68XtrTlZElUNsSmS2X5w
	 7htrwVBWblRsxcWurMJWuu1tyiDMuZFuuSv3Wxb1C3342s8wmUJuy6whejFpUXAnJT
	 +z688M9HDurpTALx0ZJaTTQ9ore/FDTQUGrG6lesO9L0ZJLkKdfR00DhoSW3aYvROH
	 7JI3K2GrsZXZixCXFo7eNfTNRpb8kSUqTGCQ6uNCi/AUeghkoYPiZIp7tLfJQQo9gN
	 0gtTZwxecErTQ==
Received: from livingston (unknown [192.168.42.11])
	by gaggiata.pivistrello.it (Postfix) with ESMTP id 396ED7FACD;
	Sun, 15 Dec 2024 12:06:23 +0100 (CET)
Received: from pivi by livingston with local (Exim 4.96)
	(envelope-from <francesco@dolcini.it>)
	id 1tMmS7-0002m8-0H;
	Sun, 15 Dec 2024 12:06:23 +0100
Date: Sun, 15 Dec 2024 12:06:23 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Bryan Brattlof <bb@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62l: add initial infrastructure
Message-ID: <Z164Lyg-AH8KBTYZ@livingston.pivistrello.it>
References: <20241117-am62lx-v1-0-4e71e42d781d@ti.com>
 <20241117-am62lx-v1-1-4e71e42d781d@ti.com>
 <Z12rnZiCXQxtMWlf@livingston.pivistrello.it>
 <20241214215624.e372oju6eserpf4f@bryanbrattlof.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214215624.e372oju6eserpf4f@bryanbrattlof.com>

Hello Bryan,

On Sat, Dec 14, 2024 at 03:56:24PM -0600, Bryan Brattlof wrote:
> On December 14, 2024 thus sayeth Francesco Dolcini:
> > On Sun, Nov 17, 2024 at 11:34:07PM -0600, Bryan Brattlof wrote:
> > > From: Vignesh Raghavendra <vigneshr@ti.com>
> > > 
> > > Add the initial infrastructure needed for the AM62L. All of which can be
> > > found in the Technical Reference Manual (TRM) located here:
> > > 
> > >     https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
> > > 
> > > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/ti/k3.yaml |  6 ++
> > >  arch/arm64/boot/dts/ti/Makefile                  |  3 +
> > >  arch/arm64/boot/dts/ti/k3-am62l-main.dtsi        | 52 ++++++++++++++
> > >  arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi      | 33 +++++++++
> > >  arch/arm64/boot/dts/ti/k3-am62l.dtsi             | 89 ++++++++++++++++++++++++
> > >  arch/arm64/boot/dts/ti/k3-am62l3.dtsi            | 67 ++++++++++++++++++
> > >  arch/arm64/boot/dts/ti/k3-pinctrl.h              |  2 +
> > >  7 files changed, 252 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > > index 18f155cd06c84..b109e854879cb 100644
> > > --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > > @@ -31,6 +31,12 @@ properties:
> > >            - const: phytec,am62a-phycore-som
> > >            - const: ti,am62a7
> > >  
> > > +      - description: K3 AM62L3 SoC and Boards
> > > +        items:
> > > +          - enum:
> > > +              - ti,am62l3-evm
> > > +          - const: ti,am62l3
> > > +
> > 
> > can you clarify the differences between AM62L and AM62L3? you have a mix of names in this series. I assume that
> > AM62L is the SOC family / product name, while AM62L3 is a specific 
> > part number.
> >
> 
> Absolutely! I found the naming a bit confusing myself. 

Thanks for the clarification, having ti,am62l3 is consistent with what
you did with AM62, in which you have ti,am625.

Francesco



