Return-Path: <linux-kernel+bounces-412410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694C9D08C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E6A1F21A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C273613D89D;
	Mon, 18 Nov 2024 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K6E0u7e3"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48413D24E;
	Mon, 18 Nov 2024 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907191; cv=none; b=uenMXyBV1rTCwjTMCRJqzXCbkkWS0P02n7P2uxip7+09dtIR6i4ClrnRM/zDIl4ULJKF5TRMq2d7NGpBYNF5qGBCW6ugOyRIG894WQxMH5Qv1ve3XUVvkb0Sz6blbwr+adSYFMRW3zbkiX/aSC40mHcGUon/Griu05I6M2J7KBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907191; c=relaxed/simple;
	bh=t7xtRzyOlLAXeS/GZkTnfowlx9arz3amp/eepwEQOlc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhs5lrstYFWV9Ci1i+RM5eA6wAPzXzSzQ3i6YRffdvTQLLPu74EA3XPuaa05cE9pueYy8szvmlTHNYreHGbm6XPHi0OQa1HB+ViBAZ/YrX6Ziz6WNK9RyFoW3VQ0ctkj2/T08U/ujjv2x2EJO/39fVSXNGtjfiSJSWi4oTR3PiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K6E0u7e3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AI5JSDQ028295;
	Sun, 17 Nov 2024 23:19:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731907168;
	bh=s9IN5OznuVVvXmBLPtTBjQEWZ4OA6WUbSbNTYMWN6WA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=K6E0u7e3WsIjif7EOuC9F3PTnNOWSQB8+jUwLn0vzZ61QkP36fat2C7kpe1XNUFfY
	 7MOZcbqFMYOcOV7P5Lec7KlWPisr66sHDrOBJeO36SCs02RZ6dbudnO4Z+tZSEzlqo
	 gRoArPSH81jwbP5k4of75z5+uG4QEwN5b48JGf9Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AI5JStC124683
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 17 Nov 2024 23:19:28 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 17
 Nov 2024 23:19:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 17 Nov 2024 23:19:28 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AI5JRj6025092;
	Sun, 17 Nov 2024 23:19:27 -0600
Date: Mon, 18 Nov 2024 10:49:26 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Rob Herring <robh@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-pinctrl: Introduce deep sleep
 macros
Message-ID: <5b35c736-74d6-4fe9-ae82-272dc2e98b82@ti.com>
References: <20241112115650.988943-1-s-vadapalli@ti.com>
 <20241112115650.988943-2-s-vadapalli@ti.com>
 <20241115154822.GA2954187-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115154822.GA2954187-robh@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Nov 15, 2024 at 09:48:22AM -0600, Rob Herring wrote:

Hello Rob,

> On Tue, Nov 12, 2024 at 05:26:49PM +0530, Siddharth Vadapalli wrote:
> > The behavior of pins in deep sleep mode can be configured by programming
> > the corresponding bits in the respective Pad Configuration register. Add
> > macros to support this.
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-pinctrl.h | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> > index 22b8d73cfd32..cac7cccc1112 100644
> > --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> > +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> > @@ -12,6 +12,12 @@
> >  #define PULLTYPESEL_SHIFT	(17)
> >  #define RXACTIVE_SHIFT		(18)
> >  #define DEBOUNCE_SHIFT		(11)
> > +#define FORCE_DS_EN_SHIFT	(15)
> > +#define DS_EN_SHIFT		(24)
> > +#define DS_OUT_DIS_SHIFT	(25)
> > +#define DS_OUT_VAL_SHIFT	(26)
> > +#define DS_PULLUD_EN_SHIFT	(27)
> > +#define DS_PULLTYPE_SEL_SHIFT	(28)
> >  
> >  #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
> >  #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
> > @@ -38,6 +44,19 @@
> >  #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
> >  #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
> >  
> > +#define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
> > +#define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
> > +#define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
> > +#define PIN_DS_IO_OVERRIDE_ENABLE	(1 << DS_IO_OVERRIDE_EN_SHIFT)
> > +#define PIN_DS_OUT_ENABLE		(0 << DS_OUT_DIS_SHIFT)
> > +#define PIN_DS_OUT_DISABLE		(1 << DS_OUT_DIS_SHIFT)
> > +#define PIN_DS_OUT_VALUE_ZERO		(0 << DS_OUT_VAL_SHIFT)
> > +#define PIN_DS_OUT_VALUE_ONE		(1 << DS_OUT_VAL_SHIFT)
> > +#define PIN_DS_PULLUD_ENABLE		(0 << DS_PULLUD_EN_SHIFT)
> > +#define PIN_DS_PULLUD_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
> > +#define PIN_DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT)
> > +#define PIN_DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT)
> 
> Are you going to go add the 0 defines to all the existing cases? If you 
> do, it's a lot of pointless churn. If you don't, then it is inconsistent 
> when they do get used. I would drop them all.

The "0 defines" are present for the existing cases as well, namely:
PULL_ENABLE, PULL_DOWN and INPUT_DISABLE are all "0 defines".

Other existing macros are defined in terms of the above, due to which it
might have appeared to be the case that only some of the "0 defines" are
present. For example, the following macros make use of the "0 defines":
PIN_OUTPUT, PIN_OUTPUT_PULLUP, PIN_OUTPUT_PULLDOWN and PIN_INPUT_PULLDOWN

So the current patch is consistent with the existing convention followed
in the k3-pinctrl.h file. Please let me know if I should still drop the
"0 defines" in this patch.

Regards,
Siddharth.

