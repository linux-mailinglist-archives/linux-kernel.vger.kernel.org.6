Return-Path: <linux-kernel+bounces-276474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B103949446
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457C2288FFB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8C120011D;
	Tue,  6 Aug 2024 15:13:43 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE11BCA09;
	Tue,  6 Aug 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957223; cv=none; b=DuZlAogqptx5ZA07UdgAQEhnHxY5qm8jeWOhyLHzrt6gQWYSZ7pq2E/6cOK3WcG1kiPmpyRjT/7/n7XMbkmOQq18T369PVS5I9XZO6j60aozujNQ6Z2FJWiV7oYpnyuS5Dt4lb4BjB7S3WVqAGOU1ADJFsXu2YdOJxv8ydd4U/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957223; c=relaxed/simple;
	bh=ZTi9W6KQUxZNG8bClo476MM7Nla8g1TY3m6qhrfsvZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rshgv2TOQglfdH+PDxCPLyAGamKJ0TBqsMm3TJ7iCsM8zE/Kn+dPWAUxDTHIbuHfpqffDWi2iLdWmJpQ8Azy/pvvOpa1tWRXtFiyrH1HZIe6mxARkZyiqeSFF+p8BD1NkTqIrppe8qSIRh9mAFdG7Hv7XG3/8Pub8yNNbtOujOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sbLsT-0005t0-N2; Tue, 06 Aug 2024 17:13:33 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, zhangqing <zhangqing@rock-chips.com>,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Finley Xiao <finley.xiao@rock-chips.com>, YouMin Chen <cym@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v2 3/3] clk: rockchip: Add clock controller for the RK3576
Date: Tue, 06 Aug 2024 17:13:30 +0200
Message-ID: <1936032.MyG8hOvIyE@diego>
In-Reply-To: <2335430.ElGaqSPkdT@trenzalore>
References:
 <20240802214053.433493-1-detlev.casanova@collabora.com>
 <a9a9219d-325c-4afa-b40c-b261ff95263c@rock-chips.com>
 <2335430.ElGaqSPkdT@trenzalore>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Detlev,

Am Dienstag, 6. August 2024, 16:15:41 CEST schrieb Detlev Casanova:
> The suggestion from Heiko was that those reset should be managed by the 
> subsystems that use them, because they are on a different offset and therefore 
> seem to be on a different core.
> 
> But I think I will include them here like you suggested because:
>  - That's actually how it is done for rk3588 (which is quite close th rk3576),
>  - According to you and the TRM, those resets are on the same core, just with 
> big offsets.
> 
> Having the same structure for both SoC makes sense for maintening them.

Just without the big offsets between areas please.
Similar to how rk3588 does it already.

And yep most likely they are in the same block. Just that huge block of
space for the cru somehow suggested some algamation of multiple ones,
but looking up the rk3588, you're right that it really seems to be one block.

I did request the rk3576 TRM from Rockchip - hopefully they'll follow up
with that at some point ;-) .


Heiko




