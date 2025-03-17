Return-Path: <linux-kernel+bounces-565158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6DA661ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9031780DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04391DE3CB;
	Mon, 17 Mar 2025 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ddfkz9DN"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A612BB15
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251594; cv=none; b=B9TofoOLYhm7Gh3TTIA9VSPW81saYkcOKj4Z8abBPZ5TW9FvHARiRAYuj7Dgpb06J6xqR+2d+qnHLnDnCy3nZzjhsPHYv+JGIPoX2ket5JMf6grWn+cBVFh8FTY3P2OAUwJ0CZq5xq+RBT8mSUz6GcWc3SQMKTsBg+GGwbE4lIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251594; c=relaxed/simple;
	bh=cjymc5PeszVdsKv10AeFf62tVSp/z5XfS0VgIM/bJ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1dkCksYpKcqljDX1RiUdHTEypXsYeW33onuYyGhqkKZdl6SHajPPH8UKgqrkc+LZbmf2XMJgGoZPr3Gm5WQYlPM3p0u1pcrBSYUiZPFa4ummS2AR/8EBE9l0CWK8NEg+aWnQJp5Vmo0gCMjjgMk12nrGb+Ew8cfO2kmRQGRTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ddfkz9DN; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6E7243137;
	Mon, 17 Mar 2025 22:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742251591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TeZfqthe7IKkfbLBAb1vbIIB/6rALBJUMgUfaxe4eSY=;
	b=Ddfkz9DNMIzWIK3bvsBmjKyF1ai4Du6OFnryJ3idXVDTOVbYcgN3iG1hfGAPqAIUEC6Q1I
	1ztcFQVyaaYMWM8TfuYaAsGkh0AirHgzdv5dC06UHWTk1YBMVTEF3G7uzLQ+64gmHPYD89
	JNXNLEj48WYjBNHDZjIR3iRW4kVue/V1xLGfBpH21q+Y2Pz7FePyZj57EfOPpV6BffKLhH
	gRT2krF7oXPJbmyGqgh3iSf3vWXvTBi9RLGmwYFbJf0UVKHF4aDRuFRAWy/jmmWuIld97g
	SKo26MzoVMhKp93OsgO9WRmQkEoKskcQlbdTNrULbG0JZ+aZZpEVRJyEXHKWFg==
Date: Mon, 17 Mar 2025 23:46:29 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: frank.li@nxp.com, miquel.raynal@bootlin.com,
	linux-i3c@lists.infradead.org,
	Stanley Chu <stanley.chuys@gmail.com>
Cc: linux-kernel@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v1 1/1] i3c: master: svc: Fix i3c_master_get_free_addr
 return check
Message-ID: <174225158210.1593610.10018812780731849409.b4-ty@bootlin.com>
References: <20250310023304.2335792-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310023304.2335792-1-yschu@nuvoton.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieejfefhffekjeeuheevueevjedvleevjeetudffheeutdffudefjeduffeuvddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepfhhrrghnkhdrlhhisehngihprdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtt
 hhopehlihhnuhigqdhifegtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhtrghnlhgvhidrtghhuhihshesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmvghrrdhmrghimhhonhesnhhuvhhothhonhdrtghomhdprhgtphhtthhopehkfihlihhusehnuhhvohhtohhnrdgtohhmpdhrtghpthhtohephihstghhuhesnhhuvhhothhonhdrtghomh
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 10 Mar 2025 10:33:04 +0800, Stanley Chu wrote:
> The return value of i3c_master_get_free_addr is assigned to a variable
> with wrong type, so it can't be negative. Use a signed integer for the
> return value. If the value is negative, break the process and propagate
> the error code.
> 
> This commit also fixes the uninitialized symbol 'dyn_addr', reported
> by Smatch static checker.
> 
> [...]

Applied, thanks!

[1/1] i3c: master: svc: Fix i3c_master_get_free_addr return check
      https://git.kernel.org/abelloni/c/d6cb667b8e15

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

