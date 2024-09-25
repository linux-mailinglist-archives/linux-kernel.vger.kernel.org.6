Return-Path: <linux-kernel+bounces-339422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3E99864DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93F728A0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B2361FD8;
	Wed, 25 Sep 2024 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IBnRxkLL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D2wrJykN"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984ABDDC5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281895; cv=none; b=j/xib6zI0gixF8xHco1vPna6QNgklEygAbECbJDuyJ4/HgnFQqO0x2Xmoh+m+DkZ3r6df9MSD/E51wgaSKctVieDLwoEn/LSs/0sTbLrLy0UeGIftyPeiaG1hieDF1c6xxd72e2xIUL1dEb2l35gz8ldYFlR7rmCJSZhsygl29A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281895; c=relaxed/simple;
	bh=0wHfzOc496HvVN4fYLnjqiOw9aqvqVmLd29lNZ/5x2k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qStOfWQxWQcHVujZZsUg1mMZdI8uAvoy1cBLywwkOab3WUb6N69e+rGK1ZkD4eVQbPFmD8OxS0U4+Z2VxDfVhub2bEeR/W+P7a7OcHk8R6zPF6T/3Hs53qbBiKV5X+ltLmFlljIrIVrLqiu3A/wzxlkUs5xSYo1D1juoJKVifdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IBnRxkLL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D2wrJykN; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2E031140102;
	Wed, 25 Sep 2024 12:31:32 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 25 Sep 2024 12:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727281892;
	 x=1727368292; bh=cCq04gC5CE/gJbEL0QfCDxqzOjOqobJNsPfOX58NLBw=; b=
	IBnRxkLLrb010iQ/gUc84zgST743DMKadxTtEwL13pVBIpYzdesTCxZFf/yPvqy8
	YK087mD+Dqq7Yw9NYIZhCSDh4oRZwkg+dUKrzQjtN5rI2hZJBdGYXolNUy1NCLKK
	ga7mHWexC0zYztgefMFYzGNUV/YCMGcPzDDbK5pKvZLvfDSKAFznSiQBDpAJ7fOK
	tRJIEIZz3wMv3SlMK/TzEsBC6rBevcYdoNPWmZgXVFUQfZh4gkJQL5bD0NVfInrm
	aBLd1VqZqRkII92LZ+OFFurhVW1mmgZ3mlHU69HAbPJnPlPFDMwb4bfAUCTTRh5R
	3iiSvjg7rWTjqEqHcIDGeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727281892; x=
	1727368292; bh=cCq04gC5CE/gJbEL0QfCDxqzOjOqobJNsPfOX58NLBw=; b=D
	2wrJykNvjRJ9Y5/k2wW9guig+xhI50AS4BT3d3+dK/UbfYhpuW2/FFnl8UTRn7xk
	ONzHeaipwB9OHBEUMUmVO0jCfI7P26SGVF8lURjRsiEygrQqLSFz590YTN4DpPiU
	FctjapkPxqxkkkjO6WVzx6/HaLDVuJFBw58+1Def7PgAV7D+xtbnAhOyaH7lnCnn
	vIMrNYotV4AGhBjZSea4F7Zj7D+Bi+9W16WQrrP29mGXnLEw5Myk0GbuqlzoH59l
	dXBVpFmoTV2CXDHBQJu+8UXut2HbleiK5kLabqHSAZjYCuQqfIWI+cWNS9gaDPSz
	TRJrfcIkztuKOB8XotZxw==
X-ME-Sender: <xms:5Dr0ZvFJTkB8RM4OocXHby-YT8-dFMfWGp48-nxhAcqkRBUpLXVKDQ>
    <xme:5Dr0ZsUd5ifr2VHUe-t9GBg4ddxo_h8t3Ml65XbBTgT2ise2ebQA-VuL8yUxQF1ht
    WhG2OJMC_EllM7N1UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthh
    hinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehm
    rghrvgigseguvghngidruggvpdhrtghpthhtohepkhgvrhhnvghlseguhhdqvghlvggtth
    hrohhnihgtshdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvihhlrdgr
    rhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrh
    hmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    pehimhigsehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:5Dr0ZhIDtvqkvsXrdAzAb6pLKj-avMeob7RcvNvVXwLBoNltu70mQQ>
    <xmx:5Dr0ZtHmvPuHkAaVr5Zt7QmHxW5bgs-OCNkh2HC6gEKohVwifpuXCg>
    <xmx:5Dr0ZlXRvSkMYjY7vv7xNdIJooRqFsDWok9g30hm42oTiksxBbf1tw>
    <xmx:5Dr0ZoMbJ4HIkOG_3My56NI1EBmkE6JhMZC_dsHnWq3Eu7fkYU6-XA>
    <xmx:5Dr0ZusnQ2u9S1uWA4lEVuLLkvNUSKu3nZJuivI38dZQeFvwOo1v-S2H>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 24ED12220071; Wed, 25 Sep 2024 12:31:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Sep 2024 16:31:00 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marek Vasut" <marex@denx.de>, linux-arm-kernel@lists.infradead.org
Cc: kernel@dh-electronics.com,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Fabio Estevam" <festevam@gmail.com>,
 "Jeff Johnson" <quic_jjohnson@quicinc.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Saravana Kannan" <saravanak@google.com>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.org>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <4897ec78-b82c-415d-88dd-5092fa009f77@app.fastmail.com>
In-Reply-To: <03b05be4-2276-4e70-9480-2b1467df4ef6@denx.de>
References: <20240925160026.84091-1-marex@denx.de>
 <486054ad-20c2-45f4-a457-c9334afb53ed@app.fastmail.com>
 <03b05be4-2276-4e70-9480-2b1467df4ef6@denx.de>
Subject: Re: [PATCH] soc: imx8m: Probe the SoC driver late
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 25, 2024, at 16:09, Marek Vasut wrote:
> On 9/25/24 6:04 PM, Arnd Bergmann wrote:
>> On Wed, Sep 25, 2024, at 16:00, Marek Vasut wrote:
>>> With driver_async_probe=* on kernel command line, the following trace is
>>> produced because on i.MX8M Plus hardware because the soc-imx8m.c driver
>>> calls of_clk_get_by_name() which returns -EPROBE_DEFER because the clock
>>> driver is not yet probed. This was not detected during regular testing
>>> without driver_async_probe.
>>>
>>> Attempt to fix it by probing the SoC driver late, but I don't think that
>>> is the correct approach here.
>> 
>> I think the correct fix would be to propagate the -EPROBE_DEFER
>> and return that from imx8_soc_init(), so it gets retried again
>> after the clock driver.
> I already tried that, but if I return -EPROBE_DEFER from 
> device_initcall, it doesn't get retriggered . I suspect EPROBE_DEFER 
> works only for proper drivers ?

Right, of course. And unfortunately it can't just register to
the fsl,imx8mm-anatop/fsl,imx8mm-ocotp/... nodes because they
all have a driver already.

On the other hand, making it a late_initcall() defeats the
purpose of the driver because then it can't be used by other
drivers with soc_device_match(), resulting in incorrect
behavior when another driver relies on this to enable
a chip revision specific workaround.

     Arnd

