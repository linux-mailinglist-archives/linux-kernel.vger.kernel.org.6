Return-Path: <linux-kernel+bounces-549855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78DA557E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E9B3B3FEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174781FECD1;
	Thu,  6 Mar 2025 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nNDA+zAr"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61C1A2388;
	Thu,  6 Mar 2025 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294522; cv=none; b=PODGHfBvEZre0ytV+01lwXsrByb6/OMbZap7wle2haNFL+0eyoQIE63cpr0L9jHKgw+lT5Su/lc4wGUX3xd4GZIhj4F3kCfg9wfGTqwjTHRflvyq1KTwjdHHGUZXGaiVPf2OIRyQtkliZWHMe0t2QnQFuwH+54UChvVW0vFTR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294522; c=relaxed/simple;
	bh=y6UJr9/af8XKHeVmyD9bsK/ENSFbQvYZIoPUy/Hf4mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a01fr8OCFIAqU0QqyG2P3iH3t/uQRlkwgsODb3oQD//A47Gzc6+vMJsIQQiu0F6xd65fqo5ixuY06ciD5/xAcwIlThWZDsG24Oko8iV5mHN4+oOw/9BORWJhiPepkKQj4lyEDGj0oe3AKRwAG9gQMqhFAglefnDZF0U/DPGOm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nNDA+zAr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31DAF44379;
	Thu,  6 Mar 2025 20:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741294518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nVgb7S8E/iw4FdNE85VdkMBVo9++SKBT2e5KYx+FTDQ=;
	b=nNDA+zAr0zBQ2VWBQwLLNLtzJ6gqdYttxKfAa/FB5Q6HlQMrdtezUGqiVn48xjMyRLfL6+
	QbGQLcSCj6VaZohrE6znHzNaF5fB/L2bnBZMWejHEJEdZBKXfR57YwmHkfZ8/JGpPTL+WR
	mwcK6PpnRyl+/DmaP3HwO1RTemVhmrMBi4suZp4fPnF5r+pwk8GSLMTmsOtmOlLMIkEe7e
	AEMlIQ+abb9jQQJtZj3JR7/MAz/oRiY01D3B5yuzOqVj9AJDsj+T2lSNU9Nlah0h6usgts
	CqGRGou81dg5QIWNyOIUmLrCB1SiHkc7KOQD/PJz/AhYfegDLm8Ummn1nHv4Wg==
Date: Thu, 6 Mar 2025 21:55:16 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: frank.li@nxp.com, miquel.raynal@bootlin.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i3c@lists.infradead.org,
	Stanley Chu <stanley.chuys@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v7 0/5] Add support for Nuvoton npcm845 i3c controller
Message-ID: <174129444617.1163689.11942276093411687387.b4-ty@bootlin.com>
References: <20250306075429.2265183-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306075429.2265183-1-yschu@nuvoton.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeefhfffkeejueehveeuveejvdelveejteduffehuedtffdufeejudffuedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeejjedrudehtddrvdegiedrvdduheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejjedrudehtddrvdegiedrvdduhedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepfhhrrghnkhdrlhhisehngihprdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhifegtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhtrghnlhgvhidrtghhuhihshesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

On Thu, 06 Mar 2025 15:54:24 +0800, Stanley Chu wrote:
> This patchset adds support for the Nuvoton npcm845
> Board Management controller (BMC) SoC family.
> 
> The Nuvoton npcm845 uses the same Silvico IP but an older version.
> This patchset adds fixes for the npcm845 specific hardware issues.
> 
> --
> v7:
>  - Fix kernel test robot build warning.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: i3c: silvaco: Add npcm845 compatible string
      https://git.kernel.org/abelloni/c/c24a084ab6a2
[2/5] i3c: master: svc: Add support for Nuvoton npcm845 i3c
      https://git.kernel.org/abelloni/c/98d87600a04e
[3/5] i3c: master: svc: Fix npcm845 FIFO empty issue
      https://git.kernel.org/abelloni/c/4008a74e0f9b
[4/5] i3c: master: svc: Fix npcm845 invalid slvstart event
      https://git.kernel.org/abelloni/c/4dd12e944f07
[5/5] i3c: master: svc: Fix npcm845 DAA process corruption
      https://git.kernel.org/abelloni/c/2a785307e41b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

