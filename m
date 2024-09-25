Return-Path: <linux-kernel+bounces-339388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A198646F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791E11F25712
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBC417BB4;
	Wed, 25 Sep 2024 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VMB4Xryn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mk8j8pJk"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C753208D1
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727280342; cv=none; b=jVLl0h8NHx1/VApvBOZ9XwUrhIxt/yRoyeX5md5fni0wQNQDDwynrmEeH9yZJur+23ROqUuGIfdcoDi/YhvuhzqC1YuUO8IGXvej+yzuK3SvGzYJc8dQUbgt3Z2jnLJH+ZiYq7DexRi1YxaqjabG41MW1y4VlkK+5my1ztmEcgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727280342; c=relaxed/simple;
	bh=YzQrJg/S2A7PM9rT1EAcA+I3pRA4EnsshfBm2/PzeYY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gz/9BQ1adymjDf7KmIetGL1hvWab9X2LYFlua5oNp3pgVNxKJvpqT1fNODiJFQke9Ta2W3jMM0FwAEtCAu00Y4fS+WtMZQBhWkkWIqRCbQxnqSPmLNfEIVdp3ejXEr6jsuHiqDYvH0DPS8oBaWuEsZyQAiWk5yPX1ESFmQ5KY/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VMB4Xryn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mk8j8pJk; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E707A1380600;
	Wed, 25 Sep 2024 12:05:29 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 25 Sep 2024 12:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727280329;
	 x=1727366729; bh=1Jou7M4p83DcYzy5Ln4gAWeJqnubiTKkro2D97yUltU=; b=
	VMB4XrynzJA4JABRzZPdOiYDRIosap8SM48qCziC2ikivtNJT0EBLfYiDuXi9l00
	y8kOYz3DKZLPhgt20oG+0X9mfe7hdlBSC1SuAtFCuWrD6XOKHThVH7btAUfkFplx
	O4QvrH5e/Al4rWkEj8g3gR7b3bh5wPHAmgvBhGR5ulFy+QwGO0wGSX96aSeN8Z2r
	+LIZtLIrand6pgLsz9NnQI45vYgWtOlUgHTuJnE6v18JgBOsoRFE5Y4f1ZNejdMF
	slqahInX7D4mBV/aWUl4Zw4RgMrcClvCr3X1VscsnHhhzBpQ4fbwZ/Ea5aRRaavI
	qZDQT0ajzviIPoH6HJ6PcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727280329; x=
	1727366729; bh=1Jou7M4p83DcYzy5Ln4gAWeJqnubiTKkro2D97yUltU=; b=M
	k8j8pJkiwfmDa1GoxI4u76IQwwnbCC/vUDCYqXVc6KVt7FRf0wLBmi587C0zT8l+
	yRJRSF1FhKLsv/HKk+gHSI0kjrG0wh6vLX3tEduNN9Whp0p6cn8VQCPEty1THVkd
	w4nJLv+s/KgUm4/2vShwL7e6gj2/W4e5sjmjxNIH802v1Yh7BCOZTO7QUTyJESr9
	nltvyGw9vSLBeBmW+0Si1BYD9+rzslJR/g+X7pshzCJiWFCkVuQIdfUsutj7foYQ
	681AlG/anny/mI89YeGeelTHgoqwa31N00VItXM6MfZ5ZasV4UV2vAPwjsxvR6HV
	+XKi4PD0jAPJBo7PLlzsA==
X-ME-Sender: <xms:yTT0ZvQORKncCTVSWRYGivmg2IScxDzfzJPuvF-dKWOovWy5YbUrpQ>
    <xme:yTT0ZgyyT-C9g9m8ZDgEqjeHxHX2CTXOgHFve0R1mAYunyYe0oYF9ap6h_S9smKXK
    pmSHObMmTr8-AvYlQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedgleejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:yTT0Zk3vVZ4YcnfDmGBnxe8Qxw_AQlFpd0vVHOZ9JLNraE6FuFPSMA>
    <xmx:yTT0ZvB9dUWaoeuhevthtk2v1EEtrfae2hzuKjyVFuljeSXLyPmR1w>
    <xmx:yTT0ZogDsJdyr7trVOSGVQoy_JRIcS8TozEs7WiY2wtZY477yBsZBQ>
    <xmx:yTT0ZjpNZGvEpWLF0HtOxtSk_uZ4LmC55s7xSNR5MXZUY1NwXmwxhA>
    <xmx:yTT0ZpbNenf67gM6ZAAEIA2-LcLbc2cJBFv6hjXnuvSJ__BCsLbiU6XE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 754232220071; Wed, 25 Sep 2024 12:05:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Sep 2024 16:04:54 +0000
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
Message-Id: <486054ad-20c2-45f4-a457-c9334afb53ed@app.fastmail.com>
In-Reply-To: <20240925160026.84091-1-marex@denx.de>
References: <20240925160026.84091-1-marex@denx.de>
Subject: Re: [PATCH] soc: imx8m: Probe the SoC driver late
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 25, 2024, at 16:00, Marek Vasut wrote:
> With driver_async_probe=* on kernel command line, the following trace is
> produced because on i.MX8M Plus hardware because the soc-imx8m.c driver
> calls of_clk_get_by_name() which returns -EPROBE_DEFER because the clock
> driver is not yet probed. This was not detected during regular testing
> without driver_async_probe.
>
> Attempt to fix it by probing the SoC driver late, but I don't think that
> is the correct approach here.

I think the correct fix would be to propagate the -EPROBE_DEFER
and return that from imx8_soc_init(), so it gets retried again
after the clock driver.

      Arnd

