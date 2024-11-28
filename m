Return-Path: <linux-kernel+bounces-424956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E31149DBBC3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2EDB20E38
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266311C07F3;
	Thu, 28 Nov 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Jp52ll3G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ET/uR+w0"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD93211C;
	Thu, 28 Nov 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732814515; cv=none; b=SFg6Qe0DD9TY12Ng/jWBXiajD2NdBguVLpRJ827CChubYkizhj2cF6olQWno8teoR16Q2KWnFxV1w3tTzbed3+plILQ19ITOtI7IrEGFqAdIMrxuyVoOJQTThYkQ5Y9HwW1ipi3NtK+OS3Ckqr/V+Z2e9QYiuaMXPAL9MBCK1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732814515; c=relaxed/simple;
	bh=pAX1jrffx7q9SDnrNtDT47lFFCez4oMl5YQVjpbvDwY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Qez6ke+RaO5Hl+kt9rAXrcpItOjz75383IwrG1XmokAzr413JqqPYCXbONJWKYA465v+i6IwOHh1dQmVpYPTr3AfJrYVmfycJ3jzukqkbzYflFeDijRL7Umq6uwGkLlgC5m7+Z2p3Evd4crUaiFPBZvgmDHrhOmc9o/zjwoLihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Jp52ll3G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ET/uR+w0; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 0161111400F6;
	Thu, 28 Nov 2024 12:21:50 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 28 Nov 2024 12:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732814510;
	 x=1732900910; bh=D2JfyjmFw8hYMAoKDuRJj7W6G1enn12a5hgwxx1fj9c=; b=
	Jp52ll3G22wzbfSDV7I46FNUZiHQdr86GldQCqs5UqIpEUxBFmEE/7YDd1+MP2+g
	DMUPsWMGLsRrC9fQFbLc/rlJn/zozKI7zegq+O1JFOpYCz7LHrWQ0LKAeh6Aj4tO
	Jx3ciVBFG4MePp3pP6qMDztvw2znEUiTQ/jifJmmNsciSswIQ1cVu1GTb0ru5Vlt
	Tvb6pZNsr1YVr/h2T0oZU2nT9oxh7dBVQ/MQxr7Of7+7MdYRXYtmk5g9b22uDjRD
	9jxHXWGgL7FbtkFUiS3z6Zu0slR11ZX4fHb0TCeyGUv1/S5HbAKUQnMyIlsY6uqF
	kMQFa1qTi1NzUjpzhuX1/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732814510; x=
	1732900910; bh=D2JfyjmFw8hYMAoKDuRJj7W6G1enn12a5hgwxx1fj9c=; b=E
	T/uR+w0Xbs4pt0N4XKqdYg+927Ck7HzQJt8icOd0efcIy+9lTQPKjAFwoutY4spp
	ZIMAQaycjwgbpYnAaeixrkhnHVKEsFFolCVFEJJ8d5ZWU4bHSk2Hy5tPnfnjWMwD
	8dh6YLk01gHuq92wkjhVOEZvU07ek9htbOQ/E6YdK/o1GGCUgl1x1ls1BIXatGwJ
	LAc8ZPo5Lu9UzCGafrNq61ABTletA/We+ukKOHCK/lCqNH0VrKQ+F3nWkvm7JDF+
	IAAbpyjR8KB9kzTDh1GSoRz5iGNxuQSsFCENHnftXJDCX1SLRYb5LbhvIE24vCGJ
	f0wkLHzQG7womcTEYbAkw==
X-ME-Sender: <xms:rqZIZwLyhuhF6CKIUD-Wfx2c2y6Rz9SpBQyG46K2ZyLADpr5fjoQEA>
    <xme:rqZIZwLzsFzvyTpdwRHJbPBvjBgtWr58hdgg4_mooghvnLXhzE6-NsmHwb9Ke4fK_
    fxkPyDM1ODsUDw40uo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdelkecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:rqZIZwuc4yptTvpwqKE3Ho5XTlP5fj5MReG5ufvl8Psmg1mUHRhVbw>
    <xmx:rqZIZ9a-ImrpDo4YOtLQNRq4PEhuebl77Q2c63Fy8Lp6CFHZ5DJwKw>
    <xmx:rqZIZ3ZJyyWzl4jzoFKzBd4IZHpNwIN3ABU3I1MJ4vo1DlfAyopxLg>
    <xmx:rqZIZ5DnPEnprSrx7jCZE0SPlxI8YOCSuQWoY45lpCo860CCjaUqMQ>
    <xmx:rqZIZ0QlD0mp5wU8TQVyBLfb7M_X6fL5Yx7rZ3FYPC96wKEXRhPg7oX7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 46BB02220071; Thu, 28 Nov 2024 12:21:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Nov 2024 18:21:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Mark Brown" <broonie@kernel.org>
Message-Id: <4206bf5d-a11e-4d0d-86b7-50c922e41119@app.fastmail.com>
In-Reply-To: <1jjzcn1hiu.fsf@starbuckisacylon.baylibre.com>
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
 <1jjzcn1hiu.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 28, 2024, at 16:53, Jerome Brunet wrote:
> On Thu 28 Nov 2024 at 16:34, "Arnd Bergmann" <arnd@arndb.de> wrote:
>> On Thu, Nov 28, 2024, at 16:06, Jerome Brunet wrote:
>>> We are deviating a bit from the initial regression reported by Mark.
>>> Is Ok with you to proceed with that fix and then continue this discussion
>>> ?
>>
>> I really don't want to see those stray 'select' statements
>> in there, as that leave very little incentive for anyone to
>> fix it properly.
>>
>> It sounds like Stephen gave you bad advice for how it should
>> be structured, so my best suggestion would be to move the
>> the problem (and the reset driver) back into his subsystem
>> and leave only a simple 'select RESET_CONTROLLER'.
>
> Okay, though I don't really understand why that select is okay and not
> the the proposed one. There is apparently a subtility I'm missing I'd
> like to avoid repeating that.

The thing with 'select' is that it really has to be used very
selectively. The 'select RESET_CONTROLLER' is fine as an
exception because there are already tons of clk drivers
that do this consistently so they can register themselves
as a reset controller.

A driver selecting a driver from another subsystem is pretty
much always a mistake. A single one may not cause much harm,
but the problems are frequent enough that we need to have
fewer of them rather than more.

>> From the message you cited, I think Stephen had the right
>> intentions ("so that the clk and reset drivers are decoupled"),
>> but the end result did not actually do what he intended
>> even if you did what he asked for.
>>
>> Stephen, can you please take a look here and see if you
>> have a better idea for either decoupling the two drivers
>> enough to avoid the link time dependency, or to reintegrate
>> the reset controller code into the clk driver and avoid
>> the complexity?
>
> If I may,
>
> * short term fix: revert both your fix and the initial clock
>   change that needed fixing. That will essentially bring back the reset
>   implementation in clock.
>
> * after that: remove the creation part from driver/reset and bring back
>   something similar to what was proposed in the initial RFC for the
>   creation and finally switch the clock driver back to it.
>   That should provide the proper decoupling your are requesting I think.

Works for me as well, though Mark's suggestion would be simpler.

     Arnd

