Return-Path: <linux-kernel+bounces-250756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA5F92FC52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC04E1C21F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990DF171664;
	Fri, 12 Jul 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JtlEYOS1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pSE6bfg+"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93A22318;
	Fri, 12 Jul 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793587; cv=none; b=mwdoOr6J2SmTw2nmF1N1RHo/l2gK84A0abYJgnSgw4y7Uy5Ygv3k29p8F0S9hKAfgNdOiLVIjqIC0J67f3voHDdeiLQp0qiNicmT6iN6DAvhzpKSpmdezCHPgMM/bWGII6ZR9Pfo+bMpRBYoWkd/0ejf+av+EpuoLpq9zEuf98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793587; c=relaxed/simple;
	bh=BhfudW1t57qBbkL+ZRpI46jU4jO+ayHu43f3qvIWQ0M=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=XZ87qYNbm6SNpoMcl6wkjpeYEZyyzGvkHDWLZ24w65iHQwzUyb0b1V+LbQu3xTEFjLrSYNOvsO499GzoozlxkWA4gjSshgyxnhwDXZ9+PO177fmjLkBH8WRHobvePlbvdvtosBEfmBOrIcZZjO6DRSIjdx5dPI3rHmA7DmZpGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JtlEYOS1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pSE6bfg+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 435DE114014E;
	Fri, 12 Jul 2024 10:13:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 12 Jul 2024 10:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720793585; x=1720879985; bh=BhfudW1t57
	qBbkL+ZRpI46jU4jO+ayHu43f3qvIWQ0M=; b=JtlEYOS1gVBGEHudnHSrqLU7Gu
	SiEawUdD/hiXVUSIdjtJyP9f8FdBCKpGs07lQ4rWJ2ilRqTVSIqZujXCm5qW1tLJ
	oOtdiVT+63NbX9TgYdMI8ykhJFb43liDvtGhSfbwfLtEwP3K6y4mSPhHEu3ZBeNI
	FkrW1zP1TZpC+Y2yBrVHWgOLrdBvERjO1NxvnPPdew7RyOfVIvggJ7fe7jEwihPI
	sa1NTvttkTMahqyMU/jSpKR6lJdNGLE8NbJjdjNZJx4+bCn438b9Qz7a8Q2NTeZ4
	lvD+hEG2u/vqksP8C81S35eJ7OpPP04YoysT1qb/bqBMdN2M5C0blcZlhKww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720793585; x=1720879985; bh=BhfudW1t57qBbkL+ZRpI46jU4jO+
	ayHu43f3qvIWQ0M=; b=pSE6bfg+a7O27urS/jGZPrAFwG9h7eT6qapM1ZeStloS
	SkX2sHI7Gc7lHYrASDupZm5hvlRnpik/zzULp7XIqBGL7m4UPhevMHaVolRDQkA0
	KvF1MV9sWd4tojNza7ybArSxMEX9syNzgURo+FMBRZAzmRzNx3QeSqDnd3g0WBv/
	p/umsiBLvk39UZxy42F6PwkVXZY+0bXRMjLZ+q4Zro6W9+PlHcr4EYLTpPB4atog
	I6WiWiuZBrqeKVbEvW63oWAly4rfmxuT0Q+Vf2PQQ2pA189yxx/rZdfURE5kuhyO
	B7oqRmPC2v9aTl6gIs+9l5gts3YH3HIGdTzbgVUCJg==
X-ME-Sender: <xms:7zmRZog0TNvUHyax7-bhPwGR08XMoRT5vm0TIV9bCGs35Q6KgNZNzA>
    <xme:7zmRZhCq-nt1o7wvQYz_iZZ-5lP6s0gZ1wlKKTeUa53yO354A6AcDw4BGx37JzKtX
    QlqHNW-cDS3q-Xr8vE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:7zmRZgEhpZzJ7IbLnJMoiTVRpG_UEub7NW0d3JB7WQPb8ehXTZoeKQ>
    <xmx:7zmRZpRfxZ1wXJ5G5swTt7vd1t-IKbQ1Wr55z20rGoN0Y9pszkEULA>
    <xmx:7zmRZlxunDEWphHir41anaWP2rrrH3grNTOOcW8LKNpaYVevX8lHRw>
    <xmx:7zmRZn5BeLCOQYJ3cdGo2xybtmxVRXToCml7tpMh5sVPjAkv0P4wvA>
    <xmx:8TmRZkzYonEQMJyJUV_iETYWtl2y2F08zjMSZqJWk3XDdwqkHzg0eLDq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BC047B6008D; Fri, 12 Jul 2024 10:13:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5dc4eded-aa3d-478a-826d-b184b4eb0c8b@app.fastmail.com>
In-Reply-To: <b5c51026-a2de-434b-8f45-44a641ab1c82@stanley.mountain>
References: <b5c51026-a2de-434b-8f45-44a641ab1c82@stanley.mountain>
Date: Fri, 12 Jul 2024 16:12:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>, "Armin Wolf" <W_Armin@gmx.de>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Guenter Roeck" <linux@roeck-us.net>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] eeprom: ee1004: Unlock on error path in probe()
Content-Type: text/plain

On Fri, Jul 12, 2024, at 16:04, Dan Carpenter wrote:
> Call mutex_unlock() before returning an error in ee1004_probe()
>
> Fixes: 55d57ef6fa97 ("eeprom: ee1004: Use devres for bus data cleanup")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

