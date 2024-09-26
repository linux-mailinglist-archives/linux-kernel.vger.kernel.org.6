Return-Path: <linux-kernel+bounces-339941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19509986C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C07B1C2175E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF86318786D;
	Thu, 26 Sep 2024 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jXN2Au9O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MDw1giAo"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868DA1D5AA2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727332121; cv=none; b=TrU7er0LKm3lXoRM2tT941q+GRkv38nZCNlfKm9ROAiKq+yig+oRXRM2C1RQktucCjhpPHrOG7riMg4Rw90rQguYZHaS/2ad+2TSwxGUeD4ujqhY9GtPbX/ngQUZ3rIyuD/7SrSwuSbmxbIVSduFczXqb3Jixgfv0BZB5eiCvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727332121; c=relaxed/simple;
	bh=WlIFDJInKZtVYW0PXevAogwdC0j2srxDEHaooRYGe2Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SYJ8WI3exwZSWHL6ukUcPp+WuAp2AG3gvIGt8FOu4BmThrYBQPysumXEsQ++KNOWmT2RdlsCf1Hk++QLgcCVdnIJ5m7ysqfRrVVK9MfupBa1lJHgkfn7zc4X7Tlgs1nvCWyN4lETI/F2cX3BqK2rWrQZ+IXB9R6aoD9GOFPQW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jXN2Au9O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MDw1giAo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 90C32138031A;
	Thu, 26 Sep 2024 02:28:38 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 26 Sep 2024 02:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727332118;
	 x=1727418518; bh=Wzu0f2mKdw7/gLDCyB3jOvx4YvyPoGu6VkYjr384628=; b=
	jXN2Au9OVv20ZKrPPLIirBd0pgHwKGvcPQBdo4FrdT0TmBfNGG34u9uH0waVJWmd
	jOBnUNHH5reAdZHXGKIm/EufOM4a7rDN2YMQFn//O+nZCuVE+OpgvnR9MS7dejWH
	ImRHziWEDNVaSu4xmqa3nOF6pfnyJzsmeoZNcixS9YQ1USDkzcq2KeaU50f5sy8I
	D0kB3z2NzCFTCuW/5TmLKdr+4ygEtM5NT3wvd2KDOFWWMMFd6ulGeE/SuBbes3mD
	5EYmsVnItzewJo8BLOCFn6Hg/PhV6d581cp27pz195uknRmyhOG4qzfJvbnP8DN6
	ekTd7Rs0BiEL+DLR2gElzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727332118; x=
	1727418518; bh=Wzu0f2mKdw7/gLDCyB3jOvx4YvyPoGu6VkYjr384628=; b=M
	Dw1giAojHOOcoc0/97rxAUKXxtD1OJYPpli3IbNmIJAadHgXzzknGjN7b7SNLKNx
	OevP3amQoANPXGrIBEnJOMLHkKQ5o6QPGwUBaOpXTDslf2bSw2jIYIVV8ZfFLvNf
	CmG+Mnejyy4mJcAqIrPu6on1UOnHixKghsi6thxWxltp0baWeO1YcwQWqjioWZ9y
	2iB9NuZHup1JcEPwCNVh/lCZhpxMwqcO2Qd9rCpRvZWfTXCOTHKG+of9YbOGQmIq
	RBCKovm5ohmQ4FQPDK3HIpntlXl0gMo3S/Z4a8IEOpxU2BQ5a3RmXwd54xDtihNO
	n6wn/uQBd0WdGFDH6wf7w==
X-ME-Sender: <xms:Ff_0ZmXzArUg8wHwTCxI5q-eCM74op_jz4dfcAnbbva7rAIIknHItA>
    <xme:Ff_0Zil8APh_9m7PWKdFKcF5aUM1QdLJnzUZ2-fLZ3CQag5wBAICAGWLK3itSrIYv
    yw0KovnqIELWQ73dPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtiedguddtlecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Ff_0ZqYL7gJFQgYTbq4XKTWPzA33Ez5cc_pV0VM0EtmdOySSlv14Jg>
    <xmx:Fv_0ZtWFvROHTrT8XSIFc1HJomVaKRwqa5O19DgQBmgbNy2TCAbdxA>
    <xmx:Fv_0ZgkejwAgXtA-VFGR78U16hmQkbCQeqjthtgasNXgMuBbGp1Tkg>
    <xmx:Fv_0Zid8HtFeyjrw2ulnAEv_WJQn57dFJjiIG80kZ4qXzdtpuUhUbg>
    <xmx:Fv_0Zr_ChVDjaaK5_SJPGIwMYYqhOBY0SmI74mQ-8hEuuEs8n1CY5MKz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DBE0F2220071; Thu, 26 Sep 2024 02:28:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 06:28:17 +0000
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
Message-Id: <a9967a8c-8e03-44c2-8f79-14c6dd5d74af@app.fastmail.com>
In-Reply-To: <20240925220552.149551-1-marex@denx.de>
References: <20240925220552.149551-1-marex@denx.de>
Subject: Re: [PATCH v2] soc: imx8m: Probe the SoC driver as platform driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 25, 2024, at 22:04, Marek Vasut wrote:
> With driver_async_probe=* on kernel command line, the following trace is
> produced because on i.MX8M Plus hardware because the soc-imx8m.c driver
> calls of_clk_get_by_name() which returns -EPROBE_DEFER because the clock
> driver is not yet probed. This was not detected during regular testing
> without driver_async_probe.
>
> Convert the SoC code to platform driver and instantiate a platform device
> in its current device_initcall() to probe the platform driver. Rework
> .soc_revision callback to always return valid error code and return SoC
> revision via parameter. This way, if anything in the .soc_revision callback
> return -EPROBE_DEFER, it gets propagated to .probe and the .probe will get
> retried later.

Thanks for the new version, that was quick!

> +static struct platform_driver imx8m_soc_driver = {
> +	.probe = imx8m_soc_probe,
> +	.driver = {
> +		.name = "imx8m-soc",
> +	},
> +};
> +module_platform_driver(imx8m_soc_driver);
> +
> +static int __init imx8_soc_init(void)
> +{
> +	struct platform_device *pdev;
> +
> +	pdev = platform_device_register_simple("imx8m-soc", -1, NULL, 0);
> +
> +	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
> +}
>  device_initcall(imx8_soc_init);

Did you run into problems with the method I suggested first?

I don't like the way that this version still registers both the
device and driver regardless of the hardware it runs on, I'd
prefer to leave the platform check in the initcall and
only register them if we are actually on an imx8 machine.

Having two initcalls also makes it impossible to build this
as a loadable module, which is why I suggested
platform_create_bundle(). I think you can keep the
of_device_id lookup and pass the imx8_soc_data pointer
as the platform_data to platform_create_bundle.

    Arnd

