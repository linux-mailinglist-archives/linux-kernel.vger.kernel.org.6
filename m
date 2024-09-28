Return-Path: <linux-kernel+bounces-342487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281D8988F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 16:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B451281EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB35418787E;
	Sat, 28 Sep 2024 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IdV53BGA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eF6YXgo9"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63474C8DF
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727532572; cv=none; b=OJL+8fncMLJjnt4ojoAJWEMfK3Z2aK82+VpEW0Qd+OwKVRwssEh2bf/Vt0sgfnzO1fv3+gw6OY3tBCTAyllwBb4h5La8SFDZlen9raEZ3m0JxpzkDYxTUlUTd4crX4kBHp/kNv9N3I+zp2bHWKabh/nbTwJHUcvyLqDEOwjipnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727532572; c=relaxed/simple;
	bh=KecOuKoLewITTSrqbiR1Y/I9RReXT860zcx8WJ9weHM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Nyz74kmILhWxlxOp3MC0K4Ap5EOmaM9pokMtOZowOh2sOCvetItttNt+NRQWLhb3y5dEpgHiws1tUcvVRF+n/dZCLjk1YCWjEKGWwKKyQel2TEnuNxi2VjSuQCl63Ot70je5MWPIJKW4N9tQYTq6+nzKdAbVFHePK920JgTdias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IdV53BGA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eF6YXgo9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D9F21380151;
	Sat, 28 Sep 2024 10:09:29 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sat, 28 Sep 2024 10:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727532569;
	 x=1727618969; bh=jJtTej3N29UQuA0Eq4igiZrn07B+NAdGgZDiqNs8oc4=; b=
	IdV53BGAw/UsaGOCm64Fdi4+5Qd7lqVPO2QgBLmvUOPWLbB9ZD3AuvAFqzDabUfw
	eTMZLsIU5kHPnTkADgZbkJzSMamLfsqK1AUpvTLLiNZRsQ7I1fx4TnfooCugA0Xw
	D556xgXOonkPXbD5+fFlrEC/i/rz684C/Wr5ymQI/lgZf9CsmWuRfCjACNnfTwNi
	auVxuExS/gt7hVTzduNuYZJr8l91ZqA/HIaXECKV0kWacEVP1+n3PXPNBfFJsdFW
	pbYmbFDSGY9eRDRYdFpYJaBHuH+w24zB0iGDQBmAv3Od5omktjEhGR7/3GqSpfh0
	I+oJ/r3MwOlqoi+xqMzxAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727532569; x=
	1727618969; bh=jJtTej3N29UQuA0Eq4igiZrn07B+NAdGgZDiqNs8oc4=; b=e
	F6YXgo9SIgn8X8W6iLEzMu8wLIo3tHXUCOgo7fCsVoFeJb0JW9hCYD5aK4BiFxxr
	gLH3uaPEUfoGDnuKXgDAHJj2nSewsp2ATQiviuHq099hnkyAmLBFbOGv5u8zGali
	rvENMUEtKmKjKmJXpU8zWjuMVO9AJ39PLdVfMZqwVJw6klHxvONi6icrMFRrdB/Q
	gmUNF1xsfIlQRyQ88V/tQpeaVzYsLd77Z68GsBIe5W76V0Nc4HVlBFLvE63XZtmH
	csBgcIufSss8Tebfs+OEOD2usyBqlUxU+8fFH/55gWAUa7wC/wqZF62ihX7DGrop
	5fxhZ4jkcIHKeF0CjuDYQ==
X-ME-Sender: <xms:GA74ZjN4oj0zmgf5KboYeH4oKt1XwmHzk43bfZE1dbcnMO7y_N7pKQ>
    <xme:GA74Zt8bJYcQo5v-kJecnQAWsnK2xLdeGu6b8DgjvEwOSWqfA5Ssiv-X_off_gKLI
    xb_Si_tpwgHjp44Xkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
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
X-ME-Proxy: <xmx:GA74ZiSQy-xx6yCXB9YRCxk_GDYjvYEKApBb-YJhWFIYZkTv7tXQkg>
    <xmx:GA74ZnsjQBQlpqGsseAhleAV8p7sHYIYreDR4wSRn5TN6wEqpudGxw>
    <xmx:GA74Zrdh19ofhEMdAUwaddvU4IUf_bl5tkIKtCpK3Il3XHMF2APhfg>
    <xmx:GA74Zj2hGffJJp88HgvbnSimvxY5G3kHIWLM5Hhy6N3Q8s0YK_xgHA>
    <xmx:GQ74Zp2k5hmr_yLdEfMWoCgaG2UjaJDsqKdUXh8ZsoGagH9JV9i26yM4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3507E2220071; Sat, 28 Sep 2024 10:09:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 28 Sep 2024 14:09:06 +0000
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
Message-Id: <cf49f401-725d-4460-8c04-5acd993333f3@app.fastmail.com>
In-Reply-To: 
 <CAGETcx95ZMBJR0F-3Cr8++1_MwiMCPHiwfdx7m5q0XDAiGG75A@mail.gmail.com>
References: <20240926213729.2882045-1-marex@denx.de>
 <CAGETcx-q7+DGhPYd3QrsPh7O_0HU7T=NhaJYp0Fu7YW2zwbo7Q@mail.gmail.com>
 <e32ed329-b012-44f2-854b-80a8b0efc4e6@denx.de>
 <CAGETcx95ZMBJR0F-3Cr8++1_MwiMCPHiwfdx7m5q0XDAiGG75A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] soc: imx8m: Probe the SoC driver as platform driver
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024, at 22:27, Saravana Kannan wrote:
> On Fri, Sep 27, 2024 at 2:55=E2=80=AFPM Marek Vasut <marex@denx.de> wr=
ote:
>> >
>> > I'm glad it's working for you, but I think there might still be a r=
ace
>> > that you are just lucky enough to not hit. I think you still need to
>> > fix up drivers/base/soc.c to return -EPROBE_DEFER when
>> > soc_device_match() is called but soc_bus_type has no devices
>> > registered. That way any drivers that try to use that API will defer
>> > probe until this device gets to probe.
>>
>> soc_device_match() returns a pointer to soc_device_attribute or NULL,=
 do
>> you have some other function in mind ?
>
> No, I'm talking about the same function. I'm asking to change it to
> return ERR_PTR(-EPROBE_DEFER) instead
> of NULL if no soc device has been registered yet.
>
> And you'll also go change all the drivers that use that API and are on
> the IMX boards supported by this soc driver, to handle the
> -EPROBE_DEFER correctly.
>
> And this error will only get returned for boards that do async probing
> and using a platform device to register the soc device. So it's
> not going to break everyone if you do this change.

I don't like it when an interface can return both NULL an
ERR_PTR(), that just makes it too easy to be used incorrectly.

Changing it to always return ERR_PTR() on an error is still
risky, e.g. when a new driver gets merged that did get the
same treewide API change, so if we do that, this should
probably also change either the function name or the prototype.

    Arnd

