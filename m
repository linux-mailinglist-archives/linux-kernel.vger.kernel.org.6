Return-Path: <linux-kernel+bounces-347335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC20698D148
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F51F222F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576191E6DE4;
	Wed,  2 Oct 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="mgaU6W4S"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB441E6DC0;
	Wed,  2 Oct 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865081; cv=none; b=bz5WE0Mjh4uRz20K3awgrhvtBxnzMU/6CG3mQVIpz2jbmzYZ+gDLxfUjqdnfQGWz+zCTxoaaxXOkX52jeNDdFBfjV8QhJfAf21mBPrELVF/v5OgbFcYpuMNfrmWvY0LtaPWKgQVePwV2kcTHh4ypFp+vVlM7WA+C03z/WgDdCCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865081; c=relaxed/simple;
	bh=rOELVSnjZgJ2jLuwmK36lE3rBUWz5L66VNmRiHrxopM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II6xDFOaf8R4jBF8qawpl6yLJBjb4XMjW1RzRaK8xQgL1VfmGp4+ygBNDDI9w5FKWtQXhxi3CCaY3pXS4LmHGoaZ2xSt3kdjwVKkC2AzWzGR7eU2TMES86iDqeua2rU1lf1/6Z0clFVHbEgv/Yb+6gOUJ13hPJt8AKJekMK9soU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=mgaU6W4S; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A9DBF23D7E;
	Wed,  2 Oct 2024 12:31:17 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TK-AFE1673VL; Wed,  2 Oct 2024 12:31:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727865077; bh=rOELVSnjZgJ2jLuwmK36lE3rBUWz5L66VNmRiHrxopM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mgaU6W4Saco/58d5mR20FQEGu4JFYvXxbwh7CBQ0+ocwf0qf1Xx6lHX0Fvwgegt+U
	 uDpqd3DW8qCB4ibs9WeVtiV/kv0di7IMYsP8Kic5XrbfAZq/IqvADZMiNgBtMbgyA+
	 cNsjgV3vSvpJUaGmAWVFYx0qMf5xbchdQVVTOgSW1HUxI09sQXrcOrIa3J+HZEVT/n
	 MF1U6wXneVrB+4KrWf418YRTmDmZ1UYip+uIDyQUVDtDyMTjKVSzQPsk4q8QcE319A
	 PriXAC11/uujFZh22CzfPIWwjhmaKmn+N1+2WVmFR9BoRwOjkw4Rj/1v6ahIca9SC6
	 zKhOwZwZnQgmg==
Date: Wed, 2 Oct 2024 10:30:55 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH 5/8] clk: rockchip: Add clock type GATE_NO_SET_RATE
Message-ID: <Zv0g3ytK2LgeUj4y@pineapple>
References: <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-7-ziyao@disroot.org>
 <9365795.CDJkKcVGEf@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9365795.CDJkKcVGEf@diego>

On Wed, Oct 02, 2024 at 10:08:36AM +0200, Heiko Stübner wrote:
> Hi,
> 
> Am Dienstag, 1. Oktober 2024, 06:23:59 CEST schrieb Yao Zi:
> > This clock type is similar to GATE, but doesn't allow rate setting,
> > which presents on RK3528 platform.
> 
> this definitly needs more explanation in the commit message.
> 
> I.e. regular individual gates always set the CLK_SET_RATE_PARENT flag
> because of course the gates themselfs cannot influence the rate.
> 
> 
> But in general, I'm also not convinced yet. Yes if some driver tries to
> change the rate on those, it may affect the parent rate, but that is also
> true for the other individual gates.
> 
> So what makes aclk_emmc (as GATE_NO_SET_RATE) more special than
> "hclk_emmc" (as regular GATE). [Same for the other clocks of course] .
> 
> 
> So this either needs more explanation, or for the sake of simplicity
> use regular GATE for now for those and we revisit when it becomes
> necessary.

I agree that more digging is needed for GATE_NO_SET_RATE. If no obvious
reason for adding a clock type could be found, will convert these clocks
into general GATEs and give it a try.

Cheers,
Yao Zi

