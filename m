Return-Path: <linux-kernel+bounces-424879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5039DBA9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2032B24410
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6061BD00A;
	Thu, 28 Nov 2024 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BEMNsoQ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4qbVI3GC"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0A25761;
	Thu, 28 Nov 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808132; cv=none; b=F85fKCs32w+2Vit7f2G8cDFj+HY0AxRgZi4p0CVT2W70i7dTDDkHKwsfv9UGv3ehvAvYn5dOeUDy7G2RKkEqjT+/jmeVRDF75oMwXsOJLHLGx+fKIuhY0GYvwlj6iCOL/7bsIJSLlMS/eeOBqGSUaCiHTFB8cnv+eMubPHUmJY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808132; c=relaxed/simple;
	bh=ldd3XnucPRlTS2AWfFnwJZqf912/JE3iKoAKAAoGeT0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Xcqn+NlJsYLXm+oTVn8MEHK0KA+RplUwirqKrYphoLMMhSGqlh/i2g1Lzlg5LXB641gPMWU3zBqTsaM+GhyREiWUtCyl9keyNwNSZaP0J61AKH6gEE/7HOUQn1PPKFqXwTnM+W3xLJ4oSFP/wBwG1c3GJyfvZdeOfdLNu0d3XiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BEMNsoQ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4qbVI3GC; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C559611401AA;
	Thu, 28 Nov 2024 10:35:28 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 28 Nov 2024 10:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732808128;
	 x=1732894528; bh=ABd2E925i20MEj4ELZS+Ijgs5QfhIL7sEUJJIVYesWg=; b=
	BEMNsoQ9uCXfNDsb0MTId8qxxrNIFf6WII43GdcSgCtAF5NjH3ErVbMNW+UYrCPz
	jJIaPgs2irKbfmRFIhgEpaf8dO13WBgCeIWGGNmgq6hCY0o6vNuDRLo7JH3YysI6
	adWri8GFYNdOUA1QfAUR3yHxfQvNwJuZfzOI7/wHtsYGuTt+xE0AhHNqtK9FPzYr
	ND+Q9NAeiCBLUFu1jgRPwERvWLLlAJSL5jZN7KFBhfan8xnbQyGn9F15K1RvT9Oh
	8Jk0yyP10aor/jop+auqG1h6B0Ul7vcVDzl1aFVSljjzUydrgpOyHSms82cJYY63
	UzfD/AbyP+tNrJEr7nWW9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732808128; x=
	1732894528; bh=ABd2E925i20MEj4ELZS+Ijgs5QfhIL7sEUJJIVYesWg=; b=4
	qbVI3GCWTAuAgTnL/VwXQnOQ3cZgRSKdUzStu3ng0ZQyfUz/ozrYsBvKSDyaaZxG
	GcZOzFDKltWxWCfZzku/nc2gS0toHdFukvTPtDx4LTlJ2QaUvvfeVHAuDJqdL6qg
	Q/PAnsf4oSnUXZlCxQubTJbdYZJjwvqdUASdY5B72oKSeH5ywjTEnAQSR5Nmo4tt
	nridA5YQ69ZdqLqNuRAaAk7+yLKAqRu8VtUob9EGUTBv/onLOYzRPcgfE8XaK8/8
	J6UuqSaXjPWdvhMn7Bsl3wYiioo+FKPcggaN/KbMQDZgw2EV2Gjm9tsBsYM7eGAX
	Lumfh89mEd72OW2ZvTeUg==
X-ME-Sender: <xms:wI1IZwuSYzX_k7OJfA_6xV7N4GOtl0tcUsX2qy4Hg9Y3apIV08alZQ>
    <xme:wI1IZ9cstaQRaaoBk4vnH44BcWGmKeeUtNsg1Nj7sLwrHwTXQUOkKar0zqYJ56FWR
    MYJWD59mEyeAb2CDug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeek
    leffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjsghruhhnvghtsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehkhhhi
    lhhmrghnsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehmthhurhhquhgvthhtvg
    essggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdgslhhumhgvnhhs
    thhinhhglhesghhoohhglhgvmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprh
    gtphhtthhopehlihhnuhigqdgrmhhlohhgihgtsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrd
    hinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:wI1IZ7yZAaffLnkN_MPOE1FMgd9cLSlFlyMz7p6XwacP-iiFq6VOvA>
    <xmx:wI1IZzPJAJIlFkJ-YbyEwZW_q5Zj_cJ7WPmZe5WHrqCB8tCAQN13LA>
    <xmx:wI1IZw9BYdCWqSIUkT5o1Z41hiYbqWUvvPaWnV5E1aScT0vfMczDtw>
    <xmx:wI1IZ7XJlpagthbBUorL1TIcTgGOK720Gx1PQ5kB4g9UV9CcjiMZcg>
    <xmx:wI1IZx01Zlb3znosZEH8ZfnPYlesaVlCsUlCYWYALqYcm1MWhJemZvG2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 394B72220071; Thu, 28 Nov 2024 10:35:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Nov 2024 16:34:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Mark Brown" <broonie@kernel.org>
Message-Id: <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com>
In-Reply-To: <1jplmf1jqa.fsf@starbuckisacylon.baylibre.com>
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
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 28, 2024, at 16:06, Jerome Brunet wrote:
> On Thu 28 Nov 2024 at 15:51, "Arnd Bergmann" <arnd@arndb.de> wrote:
>> On Thu, Nov 28, 2024, at 15:39, Jerome Brunet wrote:
>>> On Thu 28 Nov 2024 at 15:11, "Arnd Bergmann" <arnd@arndb.de> wrote:
>>> Eventually that will happen for the rest of the reset implemented
>>> under drivers/clk/meson.
>>>
>>> It allows to make some code common between the platform reset
>>> drivers and the aux ones. It also ease maintainance for both
>>> Stephen and Philipp.
>>
>> I don't understand how this helps: the entire point of using
>> an auxiliary device is to separate the lifetime rules of
>> the different bits, but by doing the creation of the device
>> in the same file as the implementation, you are not taking
>> advantage of that at all, but instead get the complexity of
>> a link-time dependency in addition to a lot of extra code
>> for dealing with the additional device.
>
> My initial rework had the creation in clock (note: that is why I
> initially used 'imply', and forgot to update when the creation moved to
> reset).
>
> I was asked to move the creation in reset:
> https://lore.kernel.org/r/217a785212d7c1a5b504c6040b3636e6.sboyd@kernel.org
>
> We are deviating a bit from the initial regression reported by Mark.
> Is Ok with you to proceed with that fix and then continue this discussion
> ?

I really don't want to see those stray 'select' statements
in there, as that leave very little incentive for anyone to
fix it properly.

It sounds like Stephen gave you bad advice for how it should
be structured, so my best suggestion would be to move the
the problem (and the reset driver) back into his subsystem
and leave only a simple 'select RESET_CONTROLLER'.

From the message you cited, I think Stephen had the right
intentions ("so that the clk and reset drivers are decoupled"),
but the end result did not actually do what he intended
even if you did what he asked for.

Stephen, can you please take a look here and see if you
have a better idea for either decoupling the two drivers
enough to avoid the link time dependency, or to reintegrate
the reset controller code into the clk driver and avoid
the complexity?

      Arnd

