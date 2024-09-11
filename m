Return-Path: <linux-kernel+bounces-325179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6DC9755EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39363B2C960
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F031A01C6;
	Wed, 11 Sep 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BgwxafNM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NykAzLAG"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42B1156993
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065888; cv=none; b=RSDdSbaSmHOyEIaUXAyKXXr1ZUP6xGwDhZhvxodrygbNKJXKIFbg4i9+8sveyb8QLKkzOmo4ACv8caiJdIY9ZjT2Z6Z5Of+5/Lq3/GQ76WLL/SJeJrRdH+6oP0Y5OsstfvYVx8zgNO1sYow/8qNLb406LQCKmGGA1Xq9BWQ8EiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065888; c=relaxed/simple;
	bh=2odF99ee1cMXzMIBgWrtpiE+8wSE5xsuhArLITMhHjU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z5Sq0eTdW3R+Ys/RdXLQERbMWEoxBrunZz8ToQBp7+7BUu2Jy0wE5VQ2dq/ShQnNho5bFUCd0iGj4+nE8lhlpMadrD/34rrj7BU4UQmLempr1VQ5cLZ0y6Y7FVhOy7Qki/8eG0K+LdRqAhJpxXmhyOWkDgf/cTTQ7zaV+zROj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BgwxafNM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NykAzLAG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id BCF72138015F;
	Wed, 11 Sep 2024 10:44:45 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 11 Sep 2024 10:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726065885;
	 x=1726152285; bh=2Ng/bXiCXjVjtyMJeROcRRqL/fQsE7Mfw13aZjFqLzA=; b=
	BgwxafNM5bKX3Ce/U0F6WZ+aC5o5sjz4OMh15+TTzPfa0YCiPmEK6cR2kao8bmWQ
	aBh4d34vXfH4Yfc/8b9atNR0DXwzsrw5eQPFF5k1l5DkcvroDhaJQa4CGoukUtM7
	k7wFXBCu46sNDgYH6hJ/v6HjWXHs0oI2cyCcUEvLdTr2oJHY7iBDjdvZaHwuZpLf
	97Z6SdsHOBRoSWwo2jaXBuwUGMluy9rGXbJJ3PSuHgghCQv21a06YxPxtU5zVaeT
	HKA+iE6/WNnHX6L5ZZC/Xi2xym07F2sUSHanuyY4a8wwL2ze5tyRshWbXNCd1629
	xJG4egfKjuGRR5y2lWXpgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726065885; x=
	1726152285; bh=2Ng/bXiCXjVjtyMJeROcRRqL/fQsE7Mfw13aZjFqLzA=; b=N
	ykAzLAGujHi/rvqJ8EyJAfxN9i0jeUnDXGdJ2GyMS6i6hRarnwUefd8RJjm1PnB3
	4CSi6jWDGoFnNeOtyF0ni9DZzmqNGXXLu4creP5L97eoWa9snxW//gsH9Uic+QZ8
	7FOvD0DbBqGpzdE6wGnPxpP/0U6r3UOSpwAcV4MuSZEZcWQ2eEUZRX/7SxUQ2I19
	zLSd5w7dFVhrFpBg4Y3wz0iisDYc+UTmzKbeivDNSeYYFAZyOixWOz1rZk9PGykq
	QjYb4jHDBcx+o/ri38d5kWpOi9fo/+3n5rLZqdnFdR8rUM4egAvWxbzOLtbWLo5A
	0yVvZhuzjC1Yxg7AsfokQ==
X-ME-Sender: <xms:3azhZmcWYMzkxBe_L5peqV-q_7TkG-pMXZ4RXgt0o_fhgtyjzoB91w>
    <xme:3azhZgMw9Jm_APNWZ-ATsKY91_Ad5IKSQXU331WNdT560KR6StrUeeloWJGJuR_PM
    jUfJbUT6_KtfvRzMzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejuddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghrihhsthhirghnrdhmrghruhhssh
    hisegrrhhmrdgtohhmpdhrtghpthhtohepshhuuggvvghprdhhohhllhgrsegrrhhmrdgt
    ohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvg
    hnshdrfihikhhlrghnuggvrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhu
    gidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3azhZnh7P8Sh9kqIr6wiFh_Ri79ju2rS5FEf4YHj9ETHcpcSrmh4Rw>
    <xmx:3azhZj_OeL_d4IK3MaTSHwqV8Ev8lETu2y9LBWt9vySol0FOD8u8mg>
    <xmx:3azhZisvFBCMbrAivJwZCCqy1nkxHDSOkmAVRFb3LT89wa_XETKT2A>
    <xmx:3azhZqFTg0Fr2mT-4a02yWunZLZM1b-wsr7clrUzWFOWp4VxE_fH5Q>
    <xmx:3azhZkUbEq0qNZqzXCTwneM8X9DWUt1ARtMjQk4JivN3k8GmmEsd9QCU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 51A3A2220071; Wed, 11 Sep 2024 10:44:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Sep 2024 14:44:25 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sudeep Holla" <sudeep.holla@arm.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Cristian Marussi" <cristian.marussi@arm.com>,
 "Jens Wiklander" <jens.wiklander@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <0ae7475f-f53a-45e3-a484-667820042724@app.fastmail.com>
In-Reply-To: <ZuGl3v0y4SYR1np7@bogus>
References: <20240909110938.247976-1-arnd@kernel.org> <ZuGl3v0y4SYR1np7@bogus>
Subject: Re: [PATCH] firmware: arm_ffa: avoid string-fortify warningn in export_uuid()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 11, 2024, at 14:14, Sudeep Holla wrote:
> On Mon, Sep 09, 2024 at 11:09:24AM +0000, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Copying to a 16 byte structure into an 8-byte struct member
>> causes a compile-time warning:
>> 
>> In file included from drivers/firmware/arm_ffa/driver.c:25:
>> In function 'fortify_memcpy_chk',
>>     inlined from 'export_uuid' at include/linux/uuid.h:88:2,
>>     inlined from 'ffa_msg_send_direct_req2' at drivers/firmware/arm_ffa/driver.c:488:2:
>> include/linux/fortify-string.h:571:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>>   571 |                         __write_overflow_field(p_size_field, size);
>>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 
>> Use a union for the conversion instead and make sure the byte order
>> is fixed in the process.
>> 
>
> Thanks for spotting and fixing the issue. I tested enabling
> CONFIG_FORTIFY_SOURCE but couldn't hit this with gcc 13 and clang 20

Unfortunately I also don't have a reproducer at the moment,
but I know it was from a randconfig build with gcc-14.2. I tried
another few hundred randconfigs now with my patch reverted but it
didn't come back. I assume it only shows up in rare combinations
of some options,

Do you have any additional information on the endianess question?
Is this arm_ffa firmware code supposed to work with big-endian
kernels?

> Also do you want this sent as fix on top of my FF-A PR now or after -rc1 ?

Earlier would be better I think. I usually have one set of
bugfixes before rc1 even if it doesn't make it into the
first set of branches.

      Arnd

