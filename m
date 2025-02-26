Return-Path: <linux-kernel+bounces-534462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BB2A4674D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741691655F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113E2222CF;
	Wed, 26 Feb 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="g4ieDrVv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KBJbDOIZ"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A318E21E082
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588727; cv=none; b=oqXCgy2Epsh6hi5/O9BqdbLVMjIo/aQ69tgY0fquKu3+lJf9SLLmzz1TpYvNQA3lYDLNkJO+lEN30GfK2ZPTlAx3rhls63WKKp2esxQNdFsrI++poypa5LlFFx1hIpIsUuL056tyshfeTn9bu3ncn5VirMinUbFhKd7TcC7svjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588727; c=relaxed/simple;
	bh=jAnxxUBZkMArF5ezoFHTnzmqC7CXXOP/qNQnnrdNBns=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=T4FD/FOXaA8h/W+DfaYX/jMwzYA5XX5W6RLEdYpvBV/8xUyvQ3HjYRmp+o1oQdRqJyWMQJ910nYMK22r1332vIVmO34EGWXteV2Ab0AeDUD+K7UHZPjW2eEOcCJsdEBJjxA1p+rUjVBYMiNsheso7U48DFEkWPYAdBa+tB39yxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=g4ieDrVv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KBJbDOIZ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE8FB1140094;
	Wed, 26 Feb 2025 11:52:02 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-10.internal (MEProxy); Wed, 26 Feb 2025 11:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1740588722; x=1740675122; bh=5iYy0IpLCeQb1PHojS9KoM42iYxcOqMQ
	sa9CMfL/p/c=; b=g4ieDrVv/phXnemR3ZsNThAk6E6AZbzLbXJAMV8sJ8sYq63f
	C9l1L+KTzRWxZCTuoBAsnCkGKNjKdkaiXGvcW8V1yzw2JaeSBvPwfp1WnpQ00Aut
	XcKK3uF858Mr3vwuu1sx1GEzscaCN4U1QoMUj9ardGnUJzM31t9wa155iHJjauzl
	27yl0jUZlnvRVIhJctmudrk2Y5FMOKZtgZ+8hxkQieIA7iKojT7IvwZGhDh9BKQW
	zwOYVE9KoMX6Jg9URnZ7mXjzGkkSh19GhNxEeeNDI/cuNB+LrVgNTaOb1AG87X53
	JLZMWsIUc/sPraV1lRNGXYEzEmIzeNczIwPR6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740588722; x=
	1740675122; bh=5iYy0IpLCeQb1PHojS9KoM42iYxcOqMQsa9CMfL/p/c=; b=K
	BJbDOIZUmLK+w/0hXVbFDRphkfhDphV97il3nzweFbcxWAJEFDjU8Gqw2nFoBi0b
	o6Av1GVysfMFWCuefVHOy+gjv9lAQGNwlHZ0cgGATLitdagCdzxv2o1zwgQGJdjg
	OD4wZtqAUwI0OryKx/TDwrj2ZEcxKcvYD51ObUDPBMfg0lxVmDGnY2jp5KaHdKeA
	hBzMHJRB9DH4vtbWij9TnQXMWtJCX9Br5OAGPf5mtX5CSUfB6ZGe4P1xmWJhS/sl
	x2BPoNXdVQzAtxeoz9W6CqFswHcsAkNrKs56A8qeteHgSazbV/0EuaBLo6cJw6XP
	QdosrjWtjktUSlZafCg8g==
X-ME-Sender: <xms:sUa_Z4RY0KqV2cDjzbFvyZ_o0xAouYiCysSFrkIj_2NPaFiyWR1bnw>
    <xme:sUa_Z1xk4kM9Jj9iW699vYSOR03jmfTc97a3GJ-ZLpZLijBgtf7SWtgsdLNy-7kPG
    4x63_D32yAYzy662hI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvg
    hrrdguvghvqeenucggtffrrghtthgvrhhnpeegheduteffteeguefgteeugeffvdejgefg
    gfegkedthffgudfhudduieelkeekkeenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghn
    sehsvhgvnhhpvghtvghrrdguvghvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopehlihhn
    uhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprh
    gtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohep
    mhgrrhgtrghnsehmrghrtggrnhdrshhtpdhrtghpthhtoheprghlhihsshgrsehrohhsvg
    hniiifvghighdrihhopdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sUa_Z127v5F1-tpz_DKAqecbUd9oZRtYLG4AJuxaWLIRoiaKOxaQFw>
    <xmx:sUa_Z8DAl_UAdWwb2mIcj2iO8LqEc9RuvyJNj4d3i5B61o1RAhZqbA>
    <xmx:sUa_ZxhWDVY2g5KByIq7c4dKW-uOc4w_ezxWdLEWpL8rw5rn2qKbRA>
    <xmx:sUa_Z4rUDU6lA7RnFBhp6lG2kcbfeKFv3TrbtaM0DkoeIeQnC8V-nA>
    <xmx:ska_Z_ZVP3Lm1_PJXM5UDde9viUfhnDEgXIdFDIYe7jvGiWoPzm8HmU9>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CA904BA006F; Wed, 26 Feb 2025 11:52:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Feb 2025 17:51:40 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc: "Janne Grunau" <j@jannau.net>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Hector Martin" <marcan@marcan.st>
Message-Id: <63c5cbfe-4751-4409-9be7-2fda21b09503@app.fastmail.com>
In-Reply-To: <Z7y14Q3ifu7U1tHI@blossom>
References: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
 <20250222-apple-soc-misc-v1-2-1a3af494a48a@svenpeter.dev>
 <Z7y14Q3ifu7U1tHI@blossom>
Subject: Re: [PATCH 2/4] soc: apple: rtkit: Implement OSLog buffers properly
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Feb 24, 2025, at 19:09, Alyssa Rosenzweig wrote:
>> +	if (ep == APPLE_RTKIT_EP_OSLOG) {
>> +		buffer->size = FIELD_GET(APPLE_RTKIT_OSLOG_SIZE, msg);
>> +		buffer->iova = FIELD_GET(APPLE_RTKIT_OSLOG_IOVA, msg) << 12;
>> +	} else {
>> +		buffer->size = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg) << 12;
>> +		buffer->iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
>> +	}
>
> The shifts are suspiciously asymmetric. Are we really sure this is
> correct? My guess is that both size & iova for both oslog & buffer need
> to be page-aligned, so all 4 lines should be shifted, and the bit
> offsets should be adjusted in turn, and the lower 12-bits in oslog_size
> and buffer_iova are reserved. But that's just a guess.
>
> Anyway if this logic is really what we want it deserves a comment
> because it looks like a typo.

That guess can't be true for syslog since there's no change in behavior here
and the syslog endpoint has been working fine so far. This common code is
also used for other endpoints that request buffers and there haven't been
any issues there either. The size is just passed in "number of 4k chunks"
and the IOVA needs no additional fixups.


The entire reason for this commit is because this common logic just didn't
work for oslog. Our u-boot fork uses the same logic as used here [1]. We're stealing
a chunk of MTP's SRAM to make hand-off to Linux easier there. If either size or
IOVA was off by a factor 0x4000 this would've never worked in the first
place.

I'll add a comment that this is really what we want even though it looks odd.


Sven


[1] https://github.com/AsahiLinux/u-boot/blob/582f851413c3fd1fcd60d701ed54fff2e840b9cf/arch/arm/mach-apple/rtkit.c#L144


