Return-Path: <linux-kernel+bounces-203751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE40A8FE000
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 532B9B2287C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A2913B5B9;
	Thu,  6 Jun 2024 07:37:48 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B813AD06;
	Thu,  6 Jun 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659467; cv=none; b=nZ76Gjs9sWrFrWqBTCg2bKqH6ZWxTSJJhTeDP+2JhiDThz6IyHdf/uPSozdJvcXGEYUzmYrwmUpj3IQDAYOlUylOdbA7zYmeWEmKqKMTcGKe6yk7RI7J8TsuKVVeVBQB4Yyfm4k/RLtS47/LpB/vRHStkePDBT5nQDIFq4liyhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659467; c=relaxed/simple;
	bh=a2LuMo4gSmwdzRlaVNt1YnokeK3if9obfVCp+HFlEZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwcqF/dRg5shKnx1YzXLqzC5J1GPXhCQU5HdoTf5FKY38xQQIU7y45KBRcY6el3FDwJeCTIfYqgRVV2rDTXlUE6rorU+9gM/u0beYqJLew1OAgoMdDykkWsLR9V6gWOxPJf+A6Bf67Kv/AeVpqBraW9Jxfknta+LMbG5BbzsVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b65.versanet.de ([83.135.91.101] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sF7gh-0006li-LF; Thu, 06 Jun 2024 09:37:31 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Alex Bee <knaerzche@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Add SFC support for RK3128
Date: Thu, 06 Jun 2024 09:37:29 +0200
Message-ID: <7129744.aoefvbuG5b@diego>
In-Reply-To: <fcff0181-b6de-4e47-b7ff-47baac061b3e@kernel.org>
References:
 <20240605205209.232005-1-knaerzche@gmail.com>
 <20240605205209.232005-6-knaerzche@gmail.com>
 <fcff0181-b6de-4e47-b7ff-47baac061b3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 6. Juni 2024, 08:41:19 CEST schrieb Krzysztof Kozlowski:
> On 05/06/2024 22:52, Alex Bee wrote:
> > This series adds support for the Serial Flash Controller (SFC) found in
> > RK3128 SoCs.
> > 
> > As without using some "id holes" we would run out clock ids in the binding
> > and would have to touch the ABI, I added patches which removes the
> > CLK_NR_CLKS macro and uses the recently introduced
> > rockchip_clk_find_max_clk_id helper instead to find the highest clock id.
> > 
> > changes since v1:
> >  - added patches to remove CLK_NR_CLKS (Connor)
> > 
> 
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets.
> 
> You sent now v2 immediately after. Confused.

it looks like Alex had some mail trouble yesterday.

The thread you Acked patches in actually is v2, just missing the label.

- original v1: https://lore.kernel.org/linux-rockchip/20240605172154.193047-1-knaerzche@gmail.com

- "unlabeled" v2: https://lore.kernel.org/linux-rockchip/20240605205209.232005-1-knaerzche@gmail.com/
- this as v2, but as reply to the previous
- real v2: https://lore.kernel.org/linux-rockchip/20240605210049.232284-1-knaerzche@gmail.com/

The last 3 are identical, just the sending process was somehow fumbled.



