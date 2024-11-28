Return-Path: <linux-kernel+bounces-424897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393E9DBAEF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BC8165231
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D341BD9D8;
	Thu, 28 Nov 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="tsIkxMKT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d57gQfrP"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88671BD9D3;
	Thu, 28 Nov 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809449; cv=none; b=nQu4oJp2ooxZ7km8BrOjYwOjAkhU63ARkHqBmq4EMAaDr1VFvuzMe1143rnalVxYuZCgXi8F0TQnPEh42rBhXIgWICVqb5NzpN8bgx01GpPBCl4MXhFTz11t2J5CPOhICV17AxGgrPuY10h75k3DkItMveiXRGc0TA25bC/SMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809449; c=relaxed/simple;
	bh=dSOMWrBY2TGgE1tHHSqXlcpTQgmxE2lA9HGxbXSW7gk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WHSgwhEehShAL9pR5VM7L2rUvgnQroGPlkoBWA3O4uJAb/k94fOST0DmO3VxnrQVvp0Qe6uajO0yflTSn2AlXg5mJxdprJEMR8EKGxHLMu+XJpqRVeaVYxAa9FVShAMQjMEV5CHu0HD7F7NU2fuGaydDlZEgZEleP255atMY3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=tsIkxMKT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d57gQfrP; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A86E81140167;
	Thu, 28 Nov 2024 10:57:26 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 28 Nov 2024 10:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732809446;
	 x=1732895846; bh=YLbYVuE+2I70U4G6Tv0Fw1qLqzMtWhXRWDEVOPcHUqw=; b=
	tsIkxMKTN5TzK58higrMm9rKTXOwyQV/+AAHxG1GR6c8Iw27tjfWK85XKfI28twt
	Je7xSoav4D+DJkRVK91ccfA+Ztisu7w2JOSAGwLKqWZc7WeEYXqgv1l8OSRMlAne
	4MtqS9d5GB8X+WDM1H9UHY+owEHx9ArnRfMOyZq8QOkKNLd4UgORGOHBTWouX7+4
	937XElr2NloT9tFpn1PuOoT+/iN4bmfgH35aOXb2F/0axrASpy5uwNf9IiurvU03
	JkBsY4Wef+vnaAfeQpo4Wx6/5q1hu1r2JOpHnnsKHS/6xIkfHCIz/OpA5Jax0jYi
	iolnCmjNEqWVT1++36HkQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732809446; x=
	1732895846; bh=YLbYVuE+2I70U4G6Tv0Fw1qLqzMtWhXRWDEVOPcHUqw=; b=d
	57gQfrPqbR2vIYywJPLLOPDoXCRYivydNGPvcfv0x0DtZeuGN66zoSH4RshzV3Fo
	n88XgzzHRfD2Ag/j4f7lLa1ZGTIyiwobbCwcQLnlREzqp2u5NtGSvctgbLmjpSjg
	5qXdfixW+hqn+odSeil1O/UrA/jpH2ijK44x2R77A7VL1M8vAQfqyIrGZy914MwP
	BDrTlcZO3nmTvaIPIo2Vq0XVP4qKSvfp1kqoWS1wqLOGRT9aC0fgZJNIdXWBsghp
	2TCerMGheusrhqmqHEpz8UJ8tjjHMv69cSxm8YwyuNxlxgzjkP2HJkJKwVncHl3H
	r7GwafrrdAInKYZUi825A==
X-ME-Sender: <xms:5pJIZxt_MAL5RPByZVUvQCvzre6nAx4kHZgR-cf8jcq96GKQjyfqOQ>
    <xme:5pJIZ6d8sl-lJDisTTviE7Qcc_lxjx-mJtZrxyqqywVMWZqwwad7QRNuFj3RaLPqO
    Oan12izjEajFAtI7U0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduuddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgsrhhunhgvthessggrhihlihgsrh
    gvrdgtohhmpdhrtghpthhtohepkhhhihhlmhgrnhessggrhihlihgsrhgvrdgtohhmpdhr
    tghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtth
    hopehmrghrthhinhdrsghluhhmvghnshhtihhnghhlsehgohhoghhlvghmrghilhdrtgho
    mhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghilhdrrghrmhhsthhr
    ohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqrghmlhhoghhitg
    eslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgr
    rhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:5pJIZ0x1Uc5hPex8ZMuMl36CBiBmjBVXxJhbNqd6a0tHFVUl7R_HEg>
    <xmx:5pJIZ4OlBFcHrSoBS9a69C17THQbMX4mLgWiJKBVUO4-hH1TkLIiFw>
    <xmx:5pJIZx_vtaS0xtNOS01vzehsZ8gs_uj8TIvA7B3vEbm1rdjFnizxPQ>
    <xmx:5pJIZ4VGx2mSUiHsd2Q0fdnjE5wvTMzRx1QrCet2NkXjlu9Uuvl0zQ>
    <xmx:5pJIZy2HgsgwVq-Ut9K0R-mFexkpgXh6wMXMGlwWjCSaEdWvJ9Xb4W34>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2BE532220071; Thu, 28 Nov 2024 10:57:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Nov 2024 16:57:05 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>
Cc: "Jerome Brunet" <jbrunet@baylibre.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <22f0ec0b-889f-4588-91fe-764a45870f25@app.fastmail.com>
In-Reply-To: <30cd9a80-e9d8-4387-ad28-451f7f95637d@sirena.org.uk>
References: 
 <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
 <12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
 <1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
 <f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com>
 <1j4j3r32ld.fsf@starbuckisacylon.baylibre.com>
 <306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com>
 <1jy1131kxz.fsf@starbuckisacylon.baylibre.com>
 <c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com>
 <1jplmf1jqa.fsf@starbuckisacylon.baylibre.com>
 <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com>
 <30cd9a80-e9d8-4387-ad28-451f7f95637d@sirena.org.uk>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 28, 2024, at 16:52, Mark Brown wrote:
> On Thu, Nov 28, 2024 at 04:34:46PM +0100, Arnd Bergmann wrote:
>> On Thu, Nov 28, 2024, at 16:06, Jerome Brunet wrote:
>> > We are deviating a bit from the initial regression reported by Mark.
>> > Is Ok with you to proceed with that fix and then continue this discussion
>> > ?
>
>> I really don't want to see those stray 'select' statements
>> in there, as that leave very little incentive for anyone to
>> fix it properly.
>
> One option would be to get a change in defconfig for -rc1 and then deal
> with moving things about later.  I would very much like to have these

That sounds ok to me.

       Arnd

