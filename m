Return-Path: <linux-kernel+bounces-523232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E25EA3D3CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A8A189FACE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4381DF962;
	Thu, 20 Feb 2025 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="J5zTtCwA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DWEMX6AD"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1C1BE251
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041701; cv=none; b=lN4tB17IApDAqon+S432C4XSM3wsYP4zZanFu3RInKrI1d4dqdYHEarUpS02rNPV5desHx1/xmv5a5BUaApCvoZ7Qcjpgb3CebOBQ7Mo1JT+eSBgxvUaSCb6o7RTQZaEinjW4n4hQIKaDapQinAXV1vcAZ1qFmK0NSrwyOJNZ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041701; c=relaxed/simple;
	bh=OEGWZVbsLWuvgh0co4wT1Nb31YSZICtLKNGQ+KuQhMs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WixhL3q1HzzZkc5lMkgK8HStXcqRSdC9LrEuElFPCt5HxPT3Z9g/zfyIob0KhxSTi3vy6CwSboqHJU73B7nzkF8EEmfT8KyRRRGrEjL6fPagkEry6iK+2nxFlHwqZnkpwDIZ8zwi1kS7p73Z401W4BUshBXTgYy/aW5WQXh1hUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=J5zTtCwA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DWEMX6AD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C297F1380990;
	Thu, 20 Feb 2025 03:54:57 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Thu, 20 Feb 2025 03:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740041697;
	 x=1740128097; bh=98fWG4BoRmHvBUIB75tbyVaOGVodq0S3xsdfrIhruNE=; b=
	J5zTtCwAuk+pWPNCDB9y1J1gXbOsO6TBZK9ic8GZxeZaMQ9yU1wr4v8AWVXLv8rK
	CSWYsRR+5YwLK0nlra97Gr1k6Nz1qbSZnxucy8EN48h59eFL3Ym3pZ1jOcQgV3pi
	aZMZjq7GnkqINth2Y3d+tCoaeOOTk4iFIcaL/JppyGAO/6m1BqiPy7peOWfKcwq+
	aYfafN2QvhaluVIZ26QBIv0DvpCbeNGt8dSkBLSPYAdHB5tvoCLESeB9qGWzKzvP
	3gxELYwSX4h3UkfGgazjxXCu1Gg4YYk+kMuv1r8Yxf+JG9FjlqDOtI8UbCJ3QVp3
	2GVnkJoOrBZlgQwhUIXbuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1740041697; x=
	1740128097; bh=98fWG4BoRmHvBUIB75tbyVaOGVodq0S3xsdfrIhruNE=; b=D
	WEMX6ADtsBv1fVomxLfUbnD3rxmv6ql8NbZmJihNCDn/kA476hEXlqHz0hb4Xzs1
	pRDZZcTKY5EBfJwfhfUQJVF41WcnHH8KCqHdpg3HOCarlK30PRFFqENR2vV3PWIY
	cJmlyCC2FY0hyz5ZOkwZx7jd7IrdBisX8CP+yPHZsqmukvj0Psj7GyCKjFvaYHqU
	V1htbUYNiPOESzUN3XoTiPqz4wrkBsNv/nv5P5YsrNlMoqy0kRYiudmrXX05JEHx
	fNMkOc5pwzJG5SFQ7U2GLdBfS1Vi5+jNLadfcycS4PIcwZ/0OvQEVjYupRMqh3P0
	g/LEBeOa+bzwUgpaaofig==
X-ME-Sender: <xms:4e22Z8hBu0rBuEVt7olWVFsxtBSJVA5aGva2DqQxXQOc3I2J9yNPjA>
    <xme:4e22Z1DOKmtozoRhhw4HRvZ0BQTZTgCynnF_xX2_hQr2Gz3fIb7elEsMUrvPcQD6K
    epHBDabTHkGIywznKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllh
    honhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorh
    hgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohep
    nhhitgholhgrshdrfhgvrhhrvgesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhope
    gtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4e22Z0EQtp-TOBKdDOpCv0BSP5MlVsVQxIt6Ed-XgqA6TkRR-pJYbQ>
    <xmx:4e22Z9S97jF3hHmmsf1E-XtmOAMpJdbKZFaVnZZtEnD3H0fuGnLhvQ>
    <xmx:4e22Z5wP59TLWXNYyPUQDtgtHRKbZgmBYJUoXbO41rAA3r-WBqSG8A>
    <xmx:4e22Z75pHmsSSDx2murSg8YXrx9ATtxBR_d5JStXIX-43BUlmYUClA>
    <xmx:4e22ZwmpHOqYlgmgSeLZLO8dqcxFMpBDzgKOEf_meTN-L4wXJqg4RhZ8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 524E12220072; Thu, 20 Feb 2025 03:54:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Feb 2025 09:54:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Arnd Bergmann" <arnd@kernel.org>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>, linux-kernel@vger.kernel.org
Message-Id: <cdce709e-b54a-4f06-9c67-b1e1a2fc8dbe@app.fastmail.com>
In-Reply-To: <20250220085231.1719249-1-arnd@kernel.org>
References: <20250220085231.1719249-1-arnd@kernel.org>
Subject: Re: [PATCH] clocksource: atmel_tcb: fix kconfig dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 20, 2025, at 09:52, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Build-testing this driver on arm without CONFIG_OF produces a warning:
>
> drivers/clocksource/timer-atmel-tcb.c:368:34: error: 
> 'atmel_tcb_of_match' defined but not used 
> [-Werror=unused-const-variable=]
>   368 | static const struct of_device_id atmel_tcb_of_match[] = {
>       |                                  ^~~~~~~~~~~~~~~~~~
>
> Change the dependency to allow build-testing on all architectures but
> instead require CONFIG_OF to be present.
>

And the second I send this out, another failure pops up, please
disregard this version as the CONFIG_ARM dependency is still needed
for register_current_timer_delay().

     Arnd

