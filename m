Return-Path: <linux-kernel+bounces-352093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB004991A12
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3FD1C21622
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C6A130AC8;
	Sat,  5 Oct 2024 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="eZGlAjsW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CZA6rd9l"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9BE154BEC;
	Sat,  5 Oct 2024 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728157760; cv=none; b=Za38qLGmmAk2T+5W3mZcPlltI+JF6fvMWtS0OD2UQSpoP6et6vs1yOqSXYtUR9cp3TuI48dUDc6ZWqeJmqd6GeIFP9qfbqnFj8ORyS8IGeTcFvLbYXFIggCPOHfRH1FMVYc9mS/fJpWQ00R+JfLALUubfdgXqwnuQHabZ7GJ/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728157760; c=relaxed/simple;
	bh=0NTJ5gmyS2VaB5jXMSQ/Gf7pJJxKuofxyR1z8Ta8m5g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LDeWQO3nw7EWX+kZ5vS5B78RkOmYciVfz+O6A4KK+J9QPYIgms0HIwtrPpjtgFVUeaiksvz8pi/Xmg3W/tG70UWGrNb7P2C/q6EuB49uVGwHmhwghHoco4kvb9f+umS7KDUcNU30+88Km7owQyOTUR06mNXCm5hToZs9/ag4ueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=eZGlAjsW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CZA6rd9l; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id BFCE513801D0;
	Sat,  5 Oct 2024 15:49:16 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Sat, 05 Oct 2024 15:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1728157756;
	 x=1728244156; bh=7LLxQhrHX1VUf6OqCJXZ4+LiaLyEjOsRM0SGQWvrFZE=; b=
	eZGlAjsW+KtBqpw942LsonRyJJmoG11zS/KAntrvie7MCqQ5mlqVjg1Bs0lxfZ13
	MYz8MbOZ2CRqhB3nbHfuzMbLOhb9PVxGEFnje//j6GIuDlcYOJHLWMPC9S1d39O1
	c7uXrpw/eUY7qncUhKDGMcrrLDQYF0Jod9PnZRVYJ477VsqQJySLKd5it+xWuVI/
	Ngps01pbgd1EnPEwX8X2PwrAxO5Dd/mixP2gECJwSRyqSZKHBUcK0d5vCahD0RbX
	FXcz4qmQVTXQ1NjCvr309EyPNj+x1P/i10VGyEkq/rOGCoeLM1Bj97WuEBwoba2f
	K/pBOR1upCaxDPTfATSzEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728157756; x=
	1728244156; bh=7LLxQhrHX1VUf6OqCJXZ4+LiaLyEjOsRM0SGQWvrFZE=; b=C
	ZA6rd9ljJwAdisLlt/XWSgZiKcK8p9fw4WADCZP23Y3oNziPlZ0GAzL5yz68xs2R
	G91h1u6D+RxTITwL0T4GmkKwR6syjJ4bWRAKViYXdOvIXOc6HmTPJPt3z3RXGgbv
	iPPOJLbkl7ZNc1HxO3K/exQLuALu+5ZW6Q+FSxD77D9fLFQBmAsEJLrbUtybTeYv
	l8QvA7umy0IOEeeUUJsEhFuuNleDJ1Twn3/9Do470AI9TS2fetP7n758K8NMMMzo
	GGUN8kWP9ThfB3nHlZUeq0H13iEFA57BDGtKv5aa9rjoE28AAKbkJ56ywUcMp7N3
	s+0Bmg4ljatC3uFz7uxyw==
X-ME-Sender: <xms:PJgBZx_J761i-HPqS2mOPqn2rnhgA78aDv8FXhggg1Z13lOWFB3KdA>
    <xme:PJgBZ1uYVBAo8yIUaLlzTe5F4W_i_gcmP8mPF4gOJD-_rPpu8eFiuyItTo6YBPsDs
    xupWcJdd8nu24c_5rI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvhedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfnuhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdrug
    gvvheqnecuggftrfgrthhtvghrnhepveetleekfeeuueeljeevteeuteevgffgueelvdfh
    vdegvdehleefleekhffgteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhj
    ohhnvghsrdguvghvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdrtghomhdprhgtphht
    thhopehsuhhpvghrmhdusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehilhhpohdrjh
    grrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghg
    ohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehplhgrthhfohhrmhdqughr
    ihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PJgBZ_D4KkrN9jVvxaObEb-cgRKWdicpCo36tzJ-isSinrcaDbwIag>
    <xmx:PJgBZ1cKFxJXWPSv9H-14clxHcvuwd3PuqTpx3tB0MzGna8H2zyqPw>
    <xmx:PJgBZ2NVkZ1E06HVQS4PYJ9D-T52dx2-avEnfQZ0uIZn5GZF1rjtfQ>
    <xmx:PJgBZ3npwrvQY5cO4CL_nrdXsr-Fj6luERXDFYWF2viNXL9KPD3nFw>
    <xmx:PJgBZzoV_-jiBddj6W_qQ9s8pMwnHGsB1Wg3rlB2o1Qhx3SBzWIVC8ok>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2E9613360077; Sat,  5 Oct 2024 15:49:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 06 Oct 2024 08:48:55 +1300
From: "Luke Jones" <luke@ljones.dev>
To: "Hans de Goede" <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 corentin.chary@gmail.com, "Mario Limonciello" <superm1@kernel.org>
Message-Id: <e8107624-cb9c-4eaf-9760-073424b38b3c@app.fastmail.com>
In-Reply-To: <5c21455c-c688-4287-a4ad-d047efa180eb@redhat.com>
References: <20240926095344.1291013-1-luke@ljones.dev>
 <5c21455c-c688-4287-a4ad-d047efa180eb@redhat.com>
Subject: Re: [PATCH 0/3] platfom/x86: asus-wmi: revert ROG Ally quirks
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Hans,

On Sun, 6 Oct 2024, at 3:37 AM, Hans de Goede wrote:
> Hi Luke,
>
> On 26-Sep-24 11:53 AM, Luke D. Jones wrote:
>> The ASUS ROG Ally (and Ally X) quirks that I added over the last year
>> are not required. I worked with ASUS to pinpoint the exact cause of
>> the original issue (MCU USB dev missing every second resume) and the
>> result is a new MCU firmware which will be released on approx 16/10/24.
>
> First of all let me say that it is great that you have gotten Asus
> to come up with a fixed firmware, thank you.
>
> With that said I believe that it is way too early to revert these quirks,
> users are usually not great at installing BIOS updates and that assumes
> this will be handled as part of a BIOS update, if it requires running
> a separate tool then the chances of users not installing the update
> will likely be even worse.
>
> So IMHO for now we should keep these quirks around to avoid regressions
> for users who don't have the MCU update.

I wasn't sure how best to handle it, mostly the intention was to publicise things. In any case the quirks don't affect the new FW update at all and most folks won't ever notice.

> Related, have you seen this series:
>
> https://lore.kernel.org/platform-driver-x86/20240922172258.48435-1-lkml@antheas.dev/
>
> that seems to fix the same issue ?

The history of that is here https://lore.kernel.org/linux-pm/20240919171952.403745-1-lkml@antheas.dev/#t

> And it does so in another, arguably better way.

It is a variation of the many many things I've tried while building a comprehensive set of data for ASUS to work with. You can achieve a similar thing with only s2idle_pm callbacks and Mario's patches to export the DSM screen-off as an external symbol. Better is subjective since it still fails to fix the initial reason this work ever started - fixing the Ally - unless delays are added.

> Although unfortunately as patch 3/5 shows just calling the global
> "display off" callback before suspending devices is not enough
> fixing things still requires inserting a sleep using a DMI quirk :|

This is because the issue can only be fully fixed in FW. What is happening here is just another variation of the quirk and the things I mentioned above. It gets worse with different compiler such as clang, or different kernel config, or even distro. The cause of issues is that a particular signal the MCU is waiting on may not occur and that becomes wildly unpredictable depending on kernel config, compiler etc.

Even Windows can have the issue we have here.

> Still that series including the DMI quirk might be a cleaner way
> to deal with this and if that is merged then dropping the quirks
> from asus-wmi makes sense.

All of this is fully negated by the coming firmware. Having said that, *if* there are any issues with these patches then those issues will never come to light with the new MCU FW either as it fixes the root cause of the issues seen.

The mentioned patches achieve a similar result to using Mario's s2idle callback patches and using those in s2idle_pm_ops. But as seen above, the timing issue becomes apparent - and this is fixed only by using fixed FW.

Kind regards,
Luke.

> Regards,
>
> Hans
>
>
>
>
>> All users should update to MCU FW as soon as released to:
>> - Ally 1: v319
>> - Ally X: v313
>> 
>> Luke D. Jones (3):
>>   Revert "platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU
>>     powersave"
>>   Revert "platform/x86: asus-wmi: disable USB0 hub on ROG Ally before
>>     suspend"
>>   platfom/x86: asus-wmi: cleanup after Ally quirk reverts
>> 
>>  drivers/platform/x86/asus-wmi.c | 39 +--------------------------------
>>  1 file changed, 1 insertion(+), 38 deletions(-)
>>

