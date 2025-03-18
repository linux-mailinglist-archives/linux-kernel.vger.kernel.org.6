Return-Path: <linux-kernel+bounces-566514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24874A67927
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C781189D156
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F5211283;
	Tue, 18 Mar 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nRgon7Sc"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786082101B7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314768; cv=none; b=i09zELp9x402HIzbRbUlMIv+xSnp8SyG0myu3PJ1+13yDf3OgXU+2K32AHJ96i91OpdzuZ/OTvO5AdCWZt56xIlYwTXlNt4wl8rEIo5lmkNbwIhVxlkjcUN5mvILdzOt8giUMtv30s5lfBfRotWGmYYTv33CbdDseWwWcJPG5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314768; c=relaxed/simple;
	bh=1LdBrTsOTT7bqE7JfVH0WA/3+gdovPuYkJIVQn/UGEw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KIeDqdvuLdeDqlrZII+9HPwIkJUIQbhGh69bT+d2I5rH4gp5m01Xy2TQqE+7tu5jIsgs0uHnpIsqH3eYR+fn7Clgc4V1ZWEzhZrLWiaZBoyIUF173TRsHOtU77u8wMCBd/IYAPMblzyUqlIPE2wilFlEpnRtOdyBzsntdb1ZSxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nRgon7Sc; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E91D44401;
	Tue, 18 Mar 2025 16:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742314764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vy+dwG9Ed+BXIN6V7N6B5XsHShfpjTK1x/IEQLwhV1g=;
	b=nRgon7ScSSVwqM6Ohvz+i4Nvuv026ZMBCSwfTfLJBd33Fr7KAtptQcBlI3hGsw4W2nQr0L
	QHLJ+8/dwYXCK0Bb717cLFzakI5JE+RCYCJ9kaj8Uk1Ka9RXJp6OsC47FGPEQ2AOrHNYMO
	i3e3NooY4bzIC/n8p+JPAY5gaURM1uI+DxN7fGJ79gmsPbnbQ1/sBL/eh0YIyivxbb1P7o
	NvvHFTeDPSrIjDyxsXiHN+Bv1USIXyEppkRFveuRfYdQDFRtPLY5sJH0BJIFTKRvhpYPZC
	ned1PcKK7ECH23v54b7KIYQRb+QTuAf+Kuwygzd9bEUmX7mWsQHyvEbVH8GLJA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, han.xu@nxp.com, hs@denx.de, 
 david@protonic.nl, jre@pengutronix.de, Zhang Heng <zhangheng@kylinos.cn>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev
In-Reply-To: <20250313095756.945890-1-zhangheng@kylinos.cn>
References: <20250313095756.945890-1-zhangheng@kylinos.cn>
Subject: Re: [PATCH 1/2] mtd: rawnand: gpmi: Use str_enabled_disabled() in
 gpmi_nand_attach_chip()
Message-Id: <174231476355.980483.5273570691547518617.b4-ty@bootlin.com>
Date: Tue, 18 Mar 2025 17:19:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevjghfuffkffggtgfgofesthekredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieffhfeulefgtdeltefgleevgffgheduledvheduudelgfehlefgheeivedvgeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggrvhhiugesphhrohhtohhnihgtrdhnlhdprhgtphhtthhopehhrghnrdiguhesnhigphdrtghomhdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmp
 dhrtghpthhtohephhhsseguvghngidruggvpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvh
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 13 Mar 2025 17:57:55 +0800, Zhang Heng wrote:
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function.
> 
> 

Applied to mtd/next, thanks!

[1/2] mtd: rawnand: gpmi: Use str_enabled_disabled() in gpmi_nand_attach_chip()
      commit: 9fe1617df3c8f522755996383b9a3abf8ce81662
[2/2] mtd: mchp48l640: Use str_enable_disable() in mchp48l640_write_prepare()
      commit: 3081f26059a88ce9f39a2fe1c1bfee853200bd79

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


