Return-Path: <linux-kernel+bounces-347322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB8498D10E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A4EB21C95
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17D31E6DEE;
	Wed,  2 Oct 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="mkyWSGxU"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB91F1E6DE0;
	Wed,  2 Oct 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864412; cv=none; b=kcvQiWjElWuU8b+hwUNlVcb7yUWUDgj9V+b7UT4jZpWUeBt/SCR/tb6lZmj5mja1LaSrpPIZbIFqhS1KoDvTKOqmFY8IJ8RRfXtxjq6R4MxdU3BLY9bR0YDzxAbZf2k/oJgzTsxjD77ptOwu7wGsYzzpSk/cfJjsQeqmGah2Xlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864412; c=relaxed/simple;
	bh=v/SHaBe3azNycrMX3xW1hD4p/17jiqX7UnkDglACAuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpWlMAWkgi9MW1l8GERmkSQbbzVvx7PXFyOrbM1XEyWxrvZkF6VIao8ix4UvO2dGvF6Jr8TWu/vETWwd/jPfnYQ7NC3qeNyugdyNXlPVgocCxV5p9224qG4AlWWVV6RAvXreBhFXuxkVsXO1aSE7DM71LDXvBAP8MvTP0CAC/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=mkyWSGxU; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3114923D0C;
	Wed,  2 Oct 2024 12:20:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3x9mbW7CcFki; Wed,  2 Oct 2024 12:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727864408; bh=v/SHaBe3azNycrMX3xW1hD4p/17jiqX7UnkDglACAuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mkyWSGxUfC2oOU3psYN5YCbt3QbaFJddEq1Ypg0q2JvA8zooHmk0ptKXK2MSYDJUv
	 VSE2afuV85JyyJ8fvStXw5/uJtaNadaigGITnfsmf/wa5JQ2YkMurGVvP1CdiBmjDW
	 0jbuj4CAzPGA5NoQNLAFVB82SDK++eVBmL/L3Pikc7nnTxJQdn5dL/ZdbsKpU7hcMd
	 gRwIIgo2WW3y8fn4LUHP7f1JFvolA4USCGPvPVy5pD3SwHH+fsu0q4TbXE53g3TwZr
	 i/bcJEfq9IUtad4G8YS3ZUzJjsfup0Z4SB0nwRUOCYftWhgp6pBEs6pXfbVrlEtI8P
	 q3snlL+imgJTg==
Date: Wed, 2 Oct 2024 10:19:47 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: reset: Add reset ID definition for
 Rockchip RK3528
Message-ID: <Zv0eQ0GofiaXxkB2@pineapple>
References: <20241001042401.31903-2-ziyao@disroot.org>
 <kg7lh6gafeegmljsygukhfjiztx5wbothngtxrcreccao3itpy@f4bxf4w346ky>
 <Zv0YRkabzDTARc-L@pineapple>
 <2647978.Lt9SDvczpP@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2647978.Lt9SDvczpP@diego>

On Wed, Oct 02, 2024 at 12:07:06PM +0200, Heiko Stübner wrote:
> Am Mittwoch, 2. Oktober 2024, 11:54:14 CEST schrieb Yao Zi:
> > On Wed, Oct 02, 2024 at 08:31:53AM +0200, Krzysztof Kozlowski wrote:
> > > On Tue, Oct 01, 2024 at 04:23:56AM +0000, Yao Zi wrote:
> > > > +/*
> > > > + * Copyright (c) 2022 Rockchip Electronics Co. Ltd.
> > > > + * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
> > > > + * Author: Joseph Chen <chenjh@rock-chips.com>
> > > > + */
> > > > +
> > > > +#ifndef _DT_BINDINGS_RESET_ROCKCHIP_RK3528_H
> > > > +#define _DT_BINDINGS_RESET_ROCKCHIP_RK3528_H
> > > > +
> > > > +// CRU_SOFTRST_CON03 (Offset: 0xA0C)
> > > > +#define SRST_CORE0_PO			0x00000030
> > > > +#define SRST_CORE1_PO			0x00000031
> > > > +#define SRST_CORE2_PO			0x00000032
> > > > +#define SRST_CORE3_PO			0x00000033
> > > > +#define SRST_CORE0			0x00000034
> > > > +#define SRST_CORE1			0x00000035
> > > > +#define SRST_CORE2			0x00000036
> > > > +#define SRST_CORE3			0x00000037
> > > > +#define SRST_NL2			0x00000038
> > > > +#define SRST_CORE_BIU			0x00000039
> > > > +#define SRST_CORE_CRYPTO		0x0000003A
> > > > +
> > > > +// CRU_SOFTRST_CON05 (Offset: 0xA14)
> > > > +#define SRST_P_DBG			0x0000005D
> > > > +#define SRST_POT_DBG			0x0000005E
> > > > +#define SRST_NT_DBG			0x0000005F
> > > 
> > > What are all these? Registers? Not a binding.
> > > 
> > > Binding constants are numerical values from 0, incremented by one,
> > 
> > Do we have related documentation about this, or I just miss it?
> 
> here the value notation in hex format is very strange.
> 
> For reference have a look at the rk3576 and rk3588, which follow the style
> recommendations.

I have checked their implementation before sending the reply. Older
Rockchip reset bindings, including this series, encoding register
offsets and effective bits in IDs, resulting in the mess.

In next revision, the new style will be adapted, just like rk3576/3588.
But what I'm asking for is a generic style doc of writing dt-binding
headers :)

Cheers,
Yao Zi

