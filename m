Return-Path: <linux-kernel+bounces-181771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCDD8C810C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8D11C20F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 06:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DFF14A99;
	Fri, 17 May 2024 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YLgMcoux";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Frlzh7Ig"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AC31118A
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715928623; cv=none; b=UrywD3gIDIxisJj6OVqCHGFd6J2z/ChAeG86nghTZfrdBJ1WAg3CPLSKAhxxKeZQpCkPC4Hxt3inn890cQwa/X/BbsLtdsMNB89iyOZORXXERH63F1TH3V7fnLH/pjbyfrfObdXvvgJ045FUPGNXfx5LYzglhMC8eL7w+uGFe44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715928623; c=relaxed/simple;
	bh=WX9otc8kbhG2FRo2+iFFolQP5OPTg3X6ZvvBvvio6P8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rKd289DT5s0DSRhNnmo9/71iCyOB4pO0Ah6yvvjkrIPzORzhD+svj69ykVbqiqt3TWptZsRaMd94z77G9nUxjQshAFxO+kS/BwOjnD4BOES0L+IkEfiyYS6XOZZCUJkShSWM1v2W/dbjgGJgGlYTyOOVgItWT7G+CNOIzwj21J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YLgMcoux; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Frlzh7Ig; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EB9CE1381527;
	Fri, 17 May 2024 02:50:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 17 May 2024 02:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715928620; x=1716015020; bh=6sp7OgXIqg
	TfGv8n43kRxLU8KwaiKmw+pUfX32MllI0=; b=YLgMcouxET9yTMzIhYFGLSq9KC
	xouDg9STaY85sbTbFKGa+sj/yL19HOzLVs/r6XBSt3Oz4xfk2yZhvW2LS0a72rLQ
	Tu5oK4QlDC+gPM4ZuG232DmJvL5F0+pCOcqtGxEacDlfI0Ti+u2ppH0jVEWq0q2Y
	CO9fhNSIhVeoTKyNpVFLKLuziP1bTX+F+94i0L6UnSiBKPJzvaKAJ1TSaONUVNMH
	V3TBafFEOb39iPaxiwUU34hD7wpiqnnn3MyzyYfCXxVJ6l98lVz20qNHr8aH4Qqd
	yK6+H7N/xt90vorBGIbm/BZ5lgt7VQeUnVa3036SrNYXpi9Tmwc6QiyH6k2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715928620; x=1716015020; bh=6sp7OgXIqgTfGv8n43kRxLU8Kwai
	Kmw+pUfX32MllI0=; b=Frlzh7Igr2JEvhY6Ab0ARPdMZNLy8qBqI5/9ZHFONl0P
	5WorOhahooDtP4P+a0XghOLYU3e91Kn2nsx2pq4O9UGpCKIjMkR9mD3wry9RXGN8
	EyowRBmE9zXgvZhCjspEiq9SkNIdOXCfbHvfHds5YTg6FmGwH8XwoxNwX9m7amM5
	LB4R3L+WLjEnPq2fNIvBzjCyAmWW7yXmeKHOfx8LwqoJLc+Jj5AW4F2CDXfbephh
	Wn6czwuGeXpvk2wmXJy7xYzvAD8H6m9k1Y4ifr9gTkjT9uH9D5c71gqstj6tuWGr
	NHNJLeGAfsMAeRAB5AMK+g359q/3I863nNJe48pozQ==
X-ME-Sender: <xms:K_5GZnJPdg0OACn7pYvqe5cVTseUvLwtyY3tzriSE3oZ1TXROt_0VA>
    <xme:K_5GZrJbzmfys6CVK5NwoPfYG2Wz-xd07fIOlqmcMm_wdTAzC1rd-BWTzDmBqtzA9
    JER0rI6J6HPlFeHNq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:K_5GZvtOt3Td9mqHrC-zMSvukSYRhXVu010Xw90j5fvze9zIDX8h0g>
    <xmx:K_5GZgaPSSFzTd80xnjldkN8EA-h2N6SQMt6uD2XgcsN2z7RiiR1Rw>
    <xmx:K_5GZuYNnYxAmzt7K-l1_QQBwaggDp0JnwdTJVgSaHAX6OxZIOdM6A>
    <xmx:K_5GZkArSr5qd-kLTssrLGfZMUFIsfbBPsL3lAz_HFSa1RgEI10JyQ>
    <xmx:LP5GZkywqTDyxo2SGVfo3DYxI5REPL5PeBRNsjIlgXMXxcboVLGnm0kx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1B6BAB6008D; Fri, 17 May 2024 02:50:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1d1c92f3-1692-40a1-aeb9-ef3e342e9bf6@app.fastmail.com>
In-Reply-To: <20240516095733.276807-1-b-kapoor@ti.com>
References: <20240516095733.276807-1-b-kapoor@ti.com>
Date: Fri, 17 May 2024 06:49:58 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bhavya Kapoor" <b-kapoor@ti.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: "Udit Kumar" <u-kumar1@ti.com>,
 =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Biju Das" <biju.das.jz@bp.renesas.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Shawn Guo" <shawnguo@kernel.org>,
 "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Bjorn Andersson" <quic_bjorande@quicinc.com>,
 "Will Deacon" <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: defconfig: Modify number of usable 8250 uart ports
Content-Type: text/plain

On Thu, May 16, 2024, at 09:57, Bhavya Kapoor wrote:
> Jacinto SoCs have a total of 12 serial uart ports. But only 8 out
> of these 12 uarts can be used at a time.
>
> Thus, Modify maximum number of 8250 serial uart ports which can be
> supported as well as modify how many 8250 serial uart ports which
> we can use in the runtime to 12 for all the SoCs.
>
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>

I forget what we had already discussed here. To clarify from my
side: it's ok to raise the limit if there are any known boards that
connect more than 8 8250 style uarts to external devices or
populated connectors.

On the other hand, I don't see any dts file at the moment that
has more than the maximum of 8 in k3-am642-tqma64xxl-mbax4xxl.dts.

If you are adding another board that has more, it helps to
clarify in the patch description that this is indeed a board
requirement, and not just done because the chip has additional
unused uarts.

     Arnd

