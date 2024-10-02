Return-Path: <linux-kernel+bounces-347307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB94598D0CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864C6284268
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F33C1E500C;
	Wed,  2 Oct 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2Ky6Feob"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96C1FA5;
	Wed,  2 Oct 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863636; cv=none; b=VbG2Ibgr6yp2RBmwEz9f46NTat3TaNwuY5eXf6W/F1x/lI4fTx9GN61WE44vRJUnnjjCF5Fa2hx1ui0N3Ej2ePqomY1A6Sb0pzvn+lVhRHT4rKEqcrbpG8XtrHhVnWr6P7lQRq6SpN1YGB/imw7Cap2a5/2R7Ij5K4qmSvVVM4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863636; c=relaxed/simple;
	bh=bViSOnDan5xAvHRDsJl+7nXNfVYM8HovTW1C4Ewz4lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qd2A7oGFaOKZ0NkKl2NR7LGPizbdDC5ZtA93AJ8yV1l121Pp1D5aRzLKk1JGkLu0uknVNy1RTLgEz15rc5+Fy6qEWJvYc2q9HlzFSJ+m3qtBownkCY5uJV0wPFB9FVvyZzTrjShf4wkXdoXDEK1I4BehJ9W5njsvtRT96bZP88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2Ky6Feob; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YM+ZZx538SZg8+AacW1cTkqZavu9B1gbZymZ3la2/oI=; b=2Ky6FeobrjpcWunt4lekKD2Es9
	nKtDbKiGZEu5OFxWnNxd4fSr4HAc/9Kv/d3ScsXnodoO2K26x2GUu9AAUIYC350thK65RKz3VsDwG
	UpAAHuSYkeFeEwY1DWtbsbjQh+aHWW73uIJc8JNlqXIt4o7qvUooJEFgntr6yUlBGMFb2wAXdZHPb
	e2CyhEhVwpF8GmlDrNNkxubeAaKDmOixvlaNpa7shhcqW3trUPhKl3R8eM/uTxa9CMksiWNgfFDrm
	7579NqmCDhnzgcEuK7xzM/ODiT6jz48Qgdhe0bLNnYfIRs1HxAfFoB5Dgq/TfJkC35jwJxtxMLOS3
	ozpiUhcg==;
Received: from i53875aa1.versanet.de ([83.135.90.161] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svwGB-0004pF-K4; Wed, 02 Oct 2024 12:07:07 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Yao Zi <ziyao@disroot.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Celeste Liu <CoelacanthusHex@gmail.com>
Subject:
 Re: [PATCH 2/8] dt-bindings: reset: Add reset ID definition for Rockchip
 RK3528
Date: Wed, 02 Oct 2024 12:07:06 +0200
Message-ID: <2647978.Lt9SDvczpP@diego>
In-Reply-To: <Zv0YRkabzDTARc-L@pineapple>
References:
 <20241001042401.31903-2-ziyao@disroot.org>
 <kg7lh6gafeegmljsygukhfjiztx5wbothngtxrcreccao3itpy@f4bxf4w346ky>
 <Zv0YRkabzDTARc-L@pineapple>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 2. Oktober 2024, 11:54:14 CEST schrieb Yao Zi:
> On Wed, Oct 02, 2024 at 08:31:53AM +0200, Krzysztof Kozlowski wrote:
> > On Tue, Oct 01, 2024 at 04:23:56AM +0000, Yao Zi wrote:
> > > +/*
> > > + * Copyright (c) 2022 Rockchip Electronics Co. Ltd.
> > > + * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
> > > + * Author: Joseph Chen <chenjh@rock-chips.com>
> > > + */
> > > +
> > > +#ifndef _DT_BINDINGS_RESET_ROCKCHIP_RK3528_H
> > > +#define _DT_BINDINGS_RESET_ROCKCHIP_RK3528_H
> > > +
> > > +// CRU_SOFTRST_CON03 (Offset: 0xA0C)
> > > +#define SRST_CORE0_PO			0x00000030
> > > +#define SRST_CORE1_PO			0x00000031
> > > +#define SRST_CORE2_PO			0x00000032
> > > +#define SRST_CORE3_PO			0x00000033
> > > +#define SRST_CORE0			0x00000034
> > > +#define SRST_CORE1			0x00000035
> > > +#define SRST_CORE2			0x00000036
> > > +#define SRST_CORE3			0x00000037
> > > +#define SRST_NL2			0x00000038
> > > +#define SRST_CORE_BIU			0x00000039
> > > +#define SRST_CORE_CRYPTO		0x0000003A
> > > +
> > > +// CRU_SOFTRST_CON05 (Offset: 0xA14)
> > > +#define SRST_P_DBG			0x0000005D
> > > +#define SRST_POT_DBG			0x0000005E
> > > +#define SRST_NT_DBG			0x0000005F
> > 
> > What are all these? Registers? Not a binding.
> > 
> > Binding constants are numerical values from 0, incremented by one,
> 
> Do we have related documentation about this, or I just miss it?

here the value notation in hex format is very strange.

For reference have a look at the rk3576 and rk3588, which follow the style
recommendations.

Also the "//CRU_"* comments should probably go away.



