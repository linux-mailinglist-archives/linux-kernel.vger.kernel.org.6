Return-Path: <linux-kernel+bounces-347249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB4B98D013
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24613B24627
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256A4197552;
	Wed,  2 Oct 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="H2lPP9sL"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8871991BD;
	Wed,  2 Oct 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861081; cv=none; b=JVMToJI1elbYLkmFggEN1wkwwu72dxPv8xjL0JdyPMb92LE3h39IDBNTMSx1slMpHcPM81XvQgYgAnWPNDwSlkmjk5uD0CL7c9y41TgelMuxrl5nZz9DurQI7p/KmJqmJ+C+rX/XRVvU9BPZAziJhFWXC5lI+KIdr0Jd4BCZGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861081; c=relaxed/simple;
	bh=s8zY2wtb2NP9yFQC6XKkatW6t8yCIS3SSJV7siWsteE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvipYK9ekjV0s7K+ObM9x2+1fuQ8wi6A12NHccQ/W+DSTdCVtv+COkyFBu5uTBGFc4ncYuT2hVAi7eW7Ik0HTQIk/UWsWpVsXnQfIt/GshKYS1eeSVpzO+TPjpCIr5iLzMwAPi8uW5bt72oalTNRYRmTq27h5vJC9hvPr+H3VcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=H2lPP9sL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7300223CCB;
	Wed,  2 Oct 2024 11:24:31 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h6o4A1elZuWv; Wed,  2 Oct 2024 11:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727861070; bh=s8zY2wtb2NP9yFQC6XKkatW6t8yCIS3SSJV7siWsteE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H2lPP9sLEqlW7TI+LKhBty80W2YctkjPDYWNrN8O8DjhJaNaK4zNMvXt7SwoO94Qh
	 mh6HN7XUqCCOikf7wL7T6oQDOeiBkQHlGStpE2/LImaMQxwswl397J/atbvnxudUIQ
	 kgBUCESQ0o3iEbT/yePcEVuaLIFm0ZQfN8554M1JF0f9+TMv7VyFx9xaDkSHcj5bUc
	 1dPj3uB5SKbHDwUIGDaVqUQXWPnE1Jwzh0k+NDoZvJLYlMuA31XFUGpeW7W3BPn5o5
	 +vfuo+4NwF0ve/txWaf0W9ALOXaAPhxOZPwZ6GaLN5XxXpn2npM+dgG6mgxW0dkOOd
	 KnoEWKW74qyJQ==
Date: Wed, 2 Oct 2024 09:24:04 +0000
From: Yao Zi <ziyao@disroot.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: clock: Add clock ID definition for
 Rockchip RK3528
Message-ID: <Zv0RNFnqzW8X8Opr@pineapple>
References: <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-3-ziyao@disroot.org>
 <gb2g7wj3nzc3euhmz7s5szms22qkuhm5yqpnyheq3zm6xf5gmr@tljctg6fpzqu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gb2g7wj3nzc3euhmz7s5szms22qkuhm5yqpnyheq3zm6xf5gmr@tljctg6fpzqu>

On Wed, Oct 02, 2024 at 08:32:45AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Oct 01, 2024 at 04:23:55AM +0000, Yao Zi wrote:
> > +/* SPDX-License-Identifier: (GPL-2.0-or-later OR MIT) */
> 
> Wrong license.

Will relicense as (GPL-2.0-only OR MIT) in the next revision.

> > +/*
> > + * Copyright (c) 2022 Rockchip Electronics Co. Ltd.
> > + * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
> > + * Author: Joseph Chen <chenjh@rock-chips.com>
> > + */
> > +
> > +#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3528_H
> > +#define _DT_BINDINGS_CLK_ROCKCHIP_RK3528_H
> > +
> > +/* cru-clocks indices */
> > +#define PLL_APLL                       1
> 
> Start from 0. Just like your other - SCMI - list.

Thanks, will fix it.

> Best regards,
> Krzysztof
> 

Best regards,
Yao Zi

