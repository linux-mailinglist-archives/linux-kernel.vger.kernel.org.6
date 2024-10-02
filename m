Return-Path: <linux-kernel+bounces-347146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3F98CE85
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B351C21254
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B070194A6B;
	Wed,  2 Oct 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="FRpXVdoW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SOFcNnCl"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B7194A52;
	Wed,  2 Oct 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727856791; cv=none; b=NK4jEyXCAe8ozzZco2GO+Fw7NC6Mt0DHxBFzWkk7aH2QH4SdOD0hgA9hWPDmtYmSB7wQVGxMh3dIbCor3WU4+h1MerHRcGIHxmkMAmat8Cu0JgaRRY0DxNn9Ypzxe5qxmfRsgv/E3IiyJRcUqG13bZLY3H5BHdELtI81/mZ9q5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727856791; c=relaxed/simple;
	bh=uw1qQz54HJo7mTLuWsb1MqVloXhe4lxeOnwBN7lCNLI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GEEQm2EHuN/LUM2xEZGfHBWjVGwKKAdHFRtQCrGKa0gzLyUkEsBagDUZp8W/ZYoRt+M72qCA3JSM5NUhUtmdcUa8fbcVAdaUV9I9TT8kwKvjOOqt62y7bb4ul7rg2qJRUr+UTbiJG3BEIbXVe9bOv2lmzl0uww6nD9FRgVFeVJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=FRpXVdoW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SOFcNnCl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12E03114019E;
	Wed,  2 Oct 2024 04:13:08 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Wed, 02 Oct 2024 04:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1727856788;
	 x=1727943188; bh=Vy5ZgnIRLhYzMG2xtHG3P3Oha0UxwynPEQvIr1PgH50=; b=
	FRpXVdoWVqV1KvdEg35+vHgi5qnHa3VKX6fv1F5n4nlDKlfU96KtvgRtfESktgld
	S++sCD5accy2Vl3LU9qiqN2bWBZ2E71HQgrIbLcJqEYyPKpLfQ+bK0Za23q3jKhh
	Y90UXJ4ezDhdNX5sMR5lQPX8YC2R6YS0y+9y+r/7LAm2K3ftWycCCfdYi4TUF8/8
	V5UV1B9Etu9UtB7jRt14mPSdHVPOZ/1ICmLEhBSf/K4fS2pxRneS9OJ+mFqyXhhH
	QDML8/9WhbV1L/g5VNoo+8R7DKNGB3y+RDqBNlMB2ZlZ5pVDAD94VQWeKJ5sn5Ad
	UzPOibOYnGXIgqq2YIvobw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727856788; x=
	1727943188; bh=Vy5ZgnIRLhYzMG2xtHG3P3Oha0UxwynPEQvIr1PgH50=; b=S
	OFcNnClIYzhr5qV44f6ZboHf3p1WDyrd1IoObbRxb0X3+8SfSwfJhM9o9q45tPsz
	uBBRMFjtDnykt8OlU7/FSJaFCQ2RerpOlT8y/jQLjmKyWw76I/in9kfzE30cKdIh
	4O7Se87lvxkkQWAhubMkFC8WG3+uQdrzcpax3Z1P5oY7WctjnDwpDw1IeL7jGNnL
	xc60sTK5tBhtj3pMasgBOl0f8nqkU5glLsdvPSTFbtcfbRcZkGTDU6gW5c+o4HrM
	kT/G1Kfzk1Rx/6udjkNby4uMFAXq6lZ8gV+81Pz2HUouNlxBIY/3G8vCZ32yxFG7
	8vah4wsHvlOu3Pyybeflg==
X-ME-Sender: <xms:kwD9ZvPVi7hhojG96mtZOIEfdWrWe-6j78vjGv-KUJxiTZ5MOJqlPA>
    <xme:kwD9Zp-GvHNVRDmnDRbKXUzxgs2GoqV8cpU_hcFylU-ORTLqio6bTI7s1FmMvwa4V
    xW5U969-bpghLAQ-9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddukedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfnuhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdrug
    gvvheqnecuggftrfgrthhtvghrnhepgfeiffehtdfghfettdeiuddtfeekvdejgfevhefh
    ffevtdfhjeelgeefffekvdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohep
    jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtih
    gvlhhlohesrghmugdrtghomhdprhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhies
    ghhmrghilhdrtghomhdprhgtphhtthhopehsuhhpvghrmhdusehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgt
    ohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:kwD9ZuSDLJwl89fzq9ywOzbv-6DWRXH6YeowucC-0XfnIwRBiSzG0Q>
    <xmx:kwD9ZjtshhA0csM_KX2MoAGFZJhDpsAU8H4mu2gO5MB08HVVfXQEXQ>
    <xmx:kwD9ZnfbIPt9vHiBAHwb-tMjuH03mOgurndWMLxRRxWdTvrsBHZ5JA>
    <xmx:kwD9Zv33xHYQvAy6TC5WaGnHOoClbtYeTvK5dMMiYz5XxMqL-p2_ew>
    <xmx:lAD9ZoEYKvDyHLSZ0gecODIQHYzFv_LDYg3C6aVuNS4COxIpoqUvbwsT>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B7BFD3360077; Wed,  2 Oct 2024 04:13:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 21:12:46 +1300
From: "Luke Jones" <luke@ljones.dev>
To: "Mario Limonciello" <mario.limonciello@amd.com>,
 linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com,
 "Mario Limonciello" <superm1@kernel.org>
Message-Id: <de0fef53-9754-4a45-a104-eee595b32f8f@app.fastmail.com>
In-Reply-To: <c19f3530-a065-461f-a5bf-ccc3988cf24c@amd.com>
References: <20240926095344.1291013-1-luke@ljones.dev>
 <c19f3530-a065-461f-a5bf-ccc3988cf24c@amd.com>
Subject: Re: [PATCH 0/3] platfom/x86: asus-wmi: revert ROG Ally quirks
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 27 Sep 2024, at 1:36 AM, Mario Limonciello wrote:
> On 9/26/2024 04:53, Luke D. Jones wrote:
>> The ASUS ROG Ally (and Ally X) quirks that I added over the last year
>> are not required. I worked with ASUS to pinpoint the exact cause of
>> the original issue (MCU USB dev missing every second resume) and the
>> result is a new MCU firmware which will be released on approx 16/10/24.
>> 
>> All users should update to MCU FW as soon as released to:
>> - Ally 1: v319
>> - Ally X: v313
>> 
>> Luke D. Jones (3):
>>    Revert "platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU
>>      powersave"
>>    Revert "platform/x86: asus-wmi: disable USB0 hub on ROG Ally before
>>      suspend"
>>    platfom/x86: asus-wmi: cleanup after Ally quirk reverts
>> 
>>   drivers/platform/x86/asus-wmi.c | 39 +--------------------------------
>>   1 file changed, 1 insertion(+), 38 deletions(-)
>> 
>
> This series looks good to me, but I would suggest that you also in the 
> appropriate HID driver that communicates with the MCU to show a warning 
> or notice if the version is below the required version.
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I have something that works, but it's in the hid-asus-ally driver. Since that might take a while to prepare I think I'll bring it over to this series soon.

