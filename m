Return-Path: <linux-kernel+bounces-341682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0C698838C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A507928745E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE65B18A6CF;
	Fri, 27 Sep 2024 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="b8fHkR1R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jdiGp5DQ"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4578157E91
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438204; cv=none; b=Tpscx+lYKC8D5rPWAb/MnE6U43n2B2cWbIZKYCzLJspf08njY+rCgo3ADmDQV+gXg3hlORgtRZ5ZzJTQcmxAAn6+FlGpfcCowK9kZokpY0gepe6A0HjXoyv5tH8v0cIs9mPZKlx4lT30+lxT9i8OiqngBLZA4PZ/FR7d5lTk2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438204; c=relaxed/simple;
	bh=6DmNFqmmvb83gXmF9WjsiVyXZP10O269GmkfDdyUmMo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LcDC2/2Uy9zDZwjrHv5ejbD06ofol92UqXe+9UEczh6AbFXIgWvUhPJugmLAS0bCCj6Njfj5WxptHsilNhK04754WGsO4DRx176Zsp22XmxqutTZ1mnunWfjg6At9IYJdGlx6lsQBfAs0IicViZpi42eBOuwM6PT26lqCqVuKbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=b8fHkR1R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jdiGp5DQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id BBCE113805C9;
	Fri, 27 Sep 2024 07:56:41 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 27 Sep 2024 07:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727438201;
	 x=1727524601; bh=Ay7YF/Xuo5nNlHfCru66Td9SMu/HSo2oVALKq6Fnm2w=; b=
	b8fHkR1Rn+U1DJr0+tJSBZGI3631TwN7E1T1eXk2gB0RDtSsy5+kgtCSZLVcAWQV
	MhliV3zGoOUgueadUA0nCdVyFVAA22K7rxTB7CFcQsQLs000ArMgX+xrVEoMQ7eF
	Kfp64KnAckL0a+4wh5zNN9CD6CZ/2JBJ9dJmb/AbP/O2hvTA7sQctCX57yISD7od
	T5CxHaTW2T26nnplrIzvBSfiOT0W2F9C526sI6hGvHNuYLux8e3ip4uA47NbtH/r
	uEOUZwIwBX7JY3R0mUihBhD8EfFBxCUPMQHn0XcpslJHxinEhfEN5lpFjYB12Y+Q
	+EZycAayGLaT2Q/GjyGX7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727438201; x=
	1727524601; bh=Ay7YF/Xuo5nNlHfCru66Td9SMu/HSo2oVALKq6Fnm2w=; b=j
	diGp5DQLgrsMw7zxu42iklMeZLvUHinEA7GgbnaaRILfgf1RxAtIqEu6eiqW2OrE
	k3VGmxZJwLEe/P/T2c8NTX1s21PT8msK7k589/q/m4C6RkwPBav649qnl2J4ARIK
	2hSmi6OhtOon3eaZFGeKPFDnwPn+2ueAiVvqVnT/ay2NAPy3fKma3f+lMRMBfD9Z
	Mp21FuoWnMJYSaGpeckTluNGJOTYaAbeTJ4oorrC7tS9ybHArfoJYmKm3vLNQOUI
	u08rZXi3NRANmc07DjszujhlmV7dZtDHwVFP481N/MD5N7tE2MeZLZK0mz6SCZGV
	zdJVunAT2jOvaSvs+JmYg==
X-ME-Sender: <xms:eZ32ZgYX4kGVbPPs_XTlr75uogeZ5Qygikd5CBXpIackj7tKd-mr6A>
    <xme:eZ32ZrZNceMX0N6dD4us9wQQWHOavHC428HNlbn2LHOJSGa0sE9YN-VBEt6JH4M0n
    fxM-B0JgSY4CamFpas>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhgvghlohhgihhorggttghhih
    hnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepmhgr
    rhgvgiesuggvnhigrdguvgdprhgtphhtthhopehkvghrnhgvlhesughhqdgvlhgvtghtrh
    honhhitghsrdgtohhmpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epshhhrgifnhhguhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghilhdrrghr
    mhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    ihhmgieslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:eZ32Zq_yNxIIomxFYxqWVZQbH1Iw3DCWl35sCtIo7HHY2YS-8mQBEg>
    <xmx:eZ32Zqr6EsZLS_fcYlitFUwSH_jRawbIOp8FmvDGVzS6GhfDPRK_zw>
    <xmx:eZ32Zro6RSDPlwg93-pUcBGfFaic2u91pCHDv-nUuiRQbWmbfXqWEA>
    <xmx:eZ32ZoS5m-DfODkHL1RWKcjktB_4XE0WtSn666PTf1acte3crahqfQ>
    <xmx:eZ32ZphJk9ACd2OgZI6jpVJsQsL8IqvtQMdH0o5Xku4S7OKpmv-rR8t2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1C8A52220071; Fri, 27 Sep 2024 07:56:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Sep 2024 11:56:20 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Saravana Kannan" <saravanak@google.com>, "Marek Vasut" <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel@dh-electronics.com,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Fabio Estevam" <festevam@gmail.com>,
 "Jeff Johnson" <quic_jjohnson@quicinc.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.org>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <dbdb9141-a345-4a17-becb-29e69a494e59@app.fastmail.com>
In-Reply-To: 
 <CAGETcx-q7+DGhPYd3QrsPh7O_0HU7T=NhaJYp0Fu7YW2zwbo7Q@mail.gmail.com>
References: <20240926213729.2882045-1-marex@denx.de>
 <CAGETcx-q7+DGhPYd3QrsPh7O_0HU7T=NhaJYp0Fu7YW2zwbo7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] soc: imx8m: Probe the SoC driver as platform driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 26, 2024, at 23:39, Saravana Kannan wrote:
>
> Also, you might want to check that your list of probed devices doesn't
> change without any async probing or this patch vs with async probing
> and this patch. Quick way to get list of successfully probed devices
> is:
> # find /sys/devices -name driver
>
> Arnd,
>
> Why is soc_device_match() doing a bus_for_each_dev(&soc_bus_type,...)?
> Are the real use cases where more than one soc device can be
> registered with soc_device_register()?

Anything can register a soc_device, and I think there is a case
where both the actual SoC and a firmware driver each register
one, see drivers/firmware/smccc/soc_id.c and 
drivers/firmware/imx/imx-scu-soc.c.

Not sure how common this is, but this was something that people
asked for when we created the interface.

      Arnd

