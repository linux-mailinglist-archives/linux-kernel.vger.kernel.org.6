Return-Path: <linux-kernel+bounces-339588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CC598674F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880571F27121
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E025143C7E;
	Wed, 25 Sep 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qdn4/v2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O4BeWQyE"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA9113DDDD
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294425; cv=none; b=GBgynIUiJ15lzkXq9N5jm2pWXA2LkEoHCJWTKRBcQ5pqbWKFR1TuZ7Ior2F2dQC4W18MwAPWOSQ3Lf2g7dYHtBJJ3xWZARACv9EmcElB4DZRp/LnPQbQfPvQxBD1xf6tMROcUtuy/mViy+BuSUz6Qx86cwoa8f0WSA1NLj7M7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294425; c=relaxed/simple;
	bh=PNa1FS0u3O5mpNiAJK7nyV8y2dI9ENLhs6BzM2eXwvc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gvG3Gd+xr3ecarXJm9dY5io+KUeYjoEeSoaX8QlgOnxd5Iwp1QM6TttK2/taQ/es8KYFOe++VVzjJG09W8GZeF19nTtS81T2qad5lB8XyEHGtvB6f311jtNZ7urh1xqms7yQcOfydvcRn9eW6xMWu4SWjKoa5PtWHrAhXF7GOns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qdn4/v2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O4BeWQyE; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C659E1140071;
	Wed, 25 Sep 2024 16:00:22 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 25 Sep 2024 16:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727294422;
	 x=1727380822; bh=LSpI3zn56MmGDaD2Q4q7Kzj5Vu7iXTMjLmRFHsROcQI=; b=
	qdn4/v2T2bQpC4Br4iQOk/gwfUSI5tpigHIyOx7hefjF6kBDXOLQNsvdeXs+hMG3
	EY1eZgHWBWuSMNx03tzTM7v/5uSE1AUUhYJgn5aMyzslhn59Axwlj9B16C3LfXMn
	BgXvGsa1Yd+QnJMDnxOmVAIxL7XDTtW4asXlEaOZ8qhbv4Jp1YgXBrEqolPYQFGz
	mYArK2vIxy5jLTuPF4qcOT+fYxFcwgjE+wEVG89O4/zljTnpbjsNuQ1rHPPMyhVL
	NFzbJTYyTxsw2tMwARvjokyvUw8X0pYU0pu6R6v7AiVFQH8Ok46HOxWxOvGVQzvc
	YtCvbS+XSxp6wz3NElfGBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727294422; x=
	1727380822; bh=LSpI3zn56MmGDaD2Q4q7Kzj5Vu7iXTMjLmRFHsROcQI=; b=O
	4BeWQyErFjNcNkEflRtlpVBsqjYNz7cAKBdS2Z+/6PNZy/KZ6o9Md84u8NS3dTnN
	Lg/B31WCRFetvF0kWUZ3CDywH3a2ZyeYTAz7clozl52kMd86R+PRD22ahf2x8wjh
	xZM1d3bCZUSLyp4cL+UafnVQIv0UFpNzta37F46tCK5BGIRwTVlQ9n4/2wjViiwY
	lxDZnhz/XHhgOek4nEp96wJ5rUFETc2WezkMmEuqGzDP2ABGM2sHYDKuq3VMnHlH
	r0xLSk+CBMKIrDF8FqAjhmDpJ/SYKYZ5rxhuNACd11q1JKzUYZsv+FFc5qn/ABGx
	yJFbM8OCSRdWVne1u3XOA==
X-ME-Sender: <xms:1mv0Zviwk6ahZW972dv-7bz9iKD9Vq76CYvWcV1W7Ip_YQyWsdVtXw>
    <xme:1mv0ZsBFdxp8e3L70nNwHfmynnobLYz3ClfQ0aHXrfTk7dp9z7hR7pPXDStQLUP6t
    0vSph7cyZy10R6NEc0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeetteejuefhueffleevteettdekueejleefleet
    hfejtddvgfevgfeutddujeejhfenucffohhmrghinheplhhptgdrvghvvghnthhsnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhl
    lhgrsghorhgrrdgtohhmpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtph
    htthhopehkvghrnhgvlhesughhqdgvlhgvtghtrhhonhhitghsrdgtohhmpdhrtghpthht
    ohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrrhgrvhgrnh
    grkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhord
    horhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugi
    druggvvh
X-ME-Proxy: <xmx:1mv0ZvGK0zGInEUsSsnJyffSAdyVYEVngbUqaxhTAJwNMZFoZqavoA>
    <xmx:1mv0ZsQa9p4zTJZdsG0atOP5kmjffIIvubkFw3KCvlpx1WAETkUeAQ>
    <xmx:1mv0ZsxByauuLZwOcQhO0Gkd6llmsDWSlXjtEsUBa7MARUSqMpihVA>
    <xmx:1mv0Zi7oxAbIEmL4Vh5OQsoGzXlK7S0_QpR5_B-2C9tXjxHuIqGBbw>
    <xmx:1mv0ZnpAxJt8gKjtFiNsPp7Gp51dQ8lavIQ8V8BFfPEG_SR5xXNxGAHk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 20C5E2220071; Wed, 25 Sep 2024 16:00:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Sep 2024 20:00:00 +0000
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
Message-Id: <37634d8e-678e-45ba-98e9-a40a5e71cf77@app.fastmail.com>
In-Reply-To: 
 <CAGETcx_ODj-FqhH7stxu27PpGNg2LiFwgC=1piLaBjDV4OagLA@mail.gmail.com>
References: <20240925160026.84091-1-marex@denx.de>
 <486054ad-20c2-45f4-a457-c9334afb53ed@app.fastmail.com>
 <03b05be4-2276-4e70-9480-2b1467df4ef6@denx.de>
 <4897ec78-b82c-415d-88dd-5092fa009f77@app.fastmail.com>
 <51c340c5-b104-4872-bfdc-8c6d52f6a35a@denx.de>
 <CAGETcx_ODj-FqhH7stxu27PpGNg2LiFwgC=1piLaBjDV4OagLA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx8m: Probe the SoC driver late
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024, at 18:48, Saravana Kannan wrote:
> On Wed, Sep 25, 2024 at 10:07=E2=80=AFAM Marek Vasut <marex@denx.de> w=
rote:
>> >
>> > Right, of course. And unfortunately it can't just register to
>> > the fsl,imx8mm-anatop/fsl,imx8mm-ocotp/... nodes because they
>> > all have a driver already.
>
> Can't we change this to add a platform device and a platform driver in
> the initcall? And then the driver can return -EPROBE_DEFER if it can't
> get the clock yet?

Yes, good idea. So the initcall would still use of_match_node()
to see if wants to be loaded and then either bail early or
call platform_create_bundle() to register the driver and the
device.

>> > On the other hand, making it a late_initcall() defeats the
>> > purpose of the driver because then it can't be used by other
>> > drivers with soc_device_match(), resulting in incorrect
>> > behavior when another driver relies on this to enable
>> > a chip revision specific workaround.
>
> We could have soc_device_match() return -EPROBE_DEFER if no soc device
> has been registered yet.
>
> For cases where it's already working without any changes, we shouldn't
> see any new -EPROBE_DEFER return values. But for cases like what Marek
> is trying to do, it should work properly. He might have to fix bad
> driver code where they remap the error instead of returning it as is.

Right.

> On a tangential note, the soc framework seems to be yet another
> framework violating the bus vs class thing. If it's a bus, then you
> need to have a probe. Otherwise, just make it a class. Might be too
> much to fix at this point, but might be good to keep this in mind if
> you plan to write more frameworks or redo soc framework at some point
> :)
>
> See Slide 20:
> https://lpc.events/event/18/contributions/1734/

Very useful, I don't think I've seen this explained like this
in the past. It's probably not easy to change now since I'm
sure there is existing userspace looking at /sys/bus/soc, but
I can at least make sure I'll follow these when reviewing new
bus_type or class submissions.

     Arnd

