Return-Path: <linux-kernel+bounces-347293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B89898D08D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0533B25780
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12411E4129;
	Wed,  2 Oct 2024 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="h/NgNNyV"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5918027;
	Wed,  2 Oct 2024 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862885; cv=none; b=DN8Tvh+m4jU9rAB+mrt3iFp69bw7PNyLCtxmelt4lafn0gZeQ4us0DHfQUgSxOZ7RJYp/P7ELBl4HaKu3Bj1KyqpwyuHlePOxNJDzVmIxsZQTo1cqWoEIPBHHG2ZM4FaO1ayZKyOrETja4TCovkC1IY/eYdXR6wRf+rUZjwj01I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862885; c=relaxed/simple;
	bh=xSMt1kdSUdvpC5ZcDXz5AqDxOhErvDD1+6Rv89kNfwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8TCc+nFPgS8weeLa3HUUuydEbewVED1rmfkIrXsZkJZicalDopTYSpdB5eU1zOxNIFfCKBOSgg4DmnLVE9DfmX7aCi1HFUUtpw1aNqw6fQrMTUrBlIAQ3ZSqLtmhqd6xa2kFa+9/eYKMorEz0fke3kkuEsOJrKh2sGRu1yjuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=h/NgNNyV; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AFFC720410;
	Wed,  2 Oct 2024 11:54:41 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRQmozoVNeoh; Wed,  2 Oct 2024 11:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727862881; bh=xSMt1kdSUdvpC5ZcDXz5AqDxOhErvDD1+6Rv89kNfwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h/NgNNyVEHy0CqgBObDYEx05zHyGSr14BwOL+E1a7IYWzz6eG1iNGPfNGA9F4Tk0G
	 Pl9yeSDg5sHmFAx46UxMMVIKbGd3x80TTu24MbIKbLr2F6S3BwHDw15eLw725+NBBt
	 l/mjM6jxsViaFTePNVqqcM66nnntk+18IVefuucl1nZXK8P7kwTuQiIE4q/pg8gAeM
	 nwr6VuGyFcdfY7qf4eGswCBqT2uyr0rYpEHxaUwm9yclmeVtXNBE+mD8XMhaiQQyFz
	 vPMX/uIOrvEsBdL/PyadGsjWJa6ftA1PT9QAK9D3X3lW4IuZIINtDTZcdzx6KpOB3G
	 6yk2T+ray6DZQ==
Date: Wed, 2 Oct 2024 09:54:14 +0000
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
Subject: Re: [PATCH 2/8] dt-bindings: reset: Add reset ID definition for
 Rockchip RK3528
Message-ID: <Zv0YRkabzDTARc-L@pineapple>
References: <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-4-ziyao@disroot.org>
 <kg7lh6gafeegmljsygukhfjiztx5wbothngtxrcreccao3itpy@f4bxf4w346ky>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kg7lh6gafeegmljsygukhfjiztx5wbothngtxrcreccao3itpy@f4bxf4w346ky>

On Wed, Oct 02, 2024 at 08:31:53AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Oct 01, 2024 at 04:23:56AM +0000, Yao Zi wrote:
> > +/*
> > + * Copyright (c) 2022 Rockchip Electronics Co. Ltd.
> > + * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
> > + * Author: Joseph Chen <chenjh@rock-chips.com>
> > + */
> > +
> > +#ifndef _DT_BINDINGS_RESET_ROCKCHIP_RK3528_H
> > +#define _DT_BINDINGS_RESET_ROCKCHIP_RK3528_H
> > +
> > +// CRU_SOFTRST_CON03 (Offset: 0xA0C)
> > +#define SRST_CORE0_PO			0x00000030
> > +#define SRST_CORE1_PO			0x00000031
> > +#define SRST_CORE2_PO			0x00000032
> > +#define SRST_CORE3_PO			0x00000033
> > +#define SRST_CORE0			0x00000034
> > +#define SRST_CORE1			0x00000035
> > +#define SRST_CORE2			0x00000036
> > +#define SRST_CORE3			0x00000037
> > +#define SRST_NL2			0x00000038
> > +#define SRST_CORE_BIU			0x00000039
> > +#define SRST_CORE_CRYPTO		0x0000003A
> > +
> > +// CRU_SOFTRST_CON05 (Offset: 0xA14)
> > +#define SRST_P_DBG			0x0000005D
> > +#define SRST_POT_DBG			0x0000005E
> > +#define SRST_NT_DBG			0x0000005F
> 
> What are all these? Registers? Not a binding.
> 
> Binding constants are numerical values from 0, incremented by one,

Do we have related documentation about this, or I just miss it?

> serving as abstraction layer between DTS and driver.
>
> None of these here are bindings.

Thanks for explaination. Will fix it in next revision.

Best regards,
Yao Zi

