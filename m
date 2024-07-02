Return-Path: <linux-kernel+bounces-237573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FF4923B08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2216C282ECC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0311534EC;
	Tue,  2 Jul 2024 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ex9r250k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vhc5Rfl9"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74FC12F392
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914642; cv=none; b=Hi2kbDkx+f1i/uHUvUPVbnWl7qjyQmTFPBKwdNZFAObob7hRGsYPGrAj+DoKwHc8m2S6cQB9ahi6bMbmqqdpCcTH8duoWOgOblkxF63TjhVJuYrB+p9a8/A2dwgktg5+9FHjDuPp7mSNT1Z70RVXaoCpzWLMtYOHhN+97opFyqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914642; c=relaxed/simple;
	bh=w0BsET4XO2EbD/Q55BNLIPKw+27X4/d1LTf3mFB9I8E=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=TVguYnaupjIytBLcKDYzur5ZHNZHS5gZ22rI8XSuVkZMa0cqdRofQoiL1wlqx3iiGsQbk7tt08XEujLLRpl2yH72EGa9XIFhLyErzuBJa8GR5seO3D5xbwF1Idhc+5gXLjXSkzOZKBdTe4lZp8sxPDkRpSHvY1Y2owMJQ4/NPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=ex9r250k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vhc5Rfl9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id A041A138019C;
	Tue,  2 Jul 2024 06:03:59 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Tue, 02 Jul 2024 06:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1719914639;
	 x=1720001039; bh=w0BsET4XO2EbD/Q55BNLIPKw+27X4/d1LTf3mFB9I8E=; b=
	ex9r250kwDRCDdvJ3HMp6mKSzdvEg5JRtpeVZA2XzMlbG3yqWcG/6ODWxLzpCLqI
	o0isffMgdjne1jrmpJ9oKZJV6OT0rwMbj84madVhsFLCTkejrobrxegicEtI9nwM
	aUnB06KhUcwWYuPlH4cQbW6tRETdb4iOkjV+WItHekDeNWIMoIVkFBGrbftBCxyD
	VFa7tdAN8YZpTRNLxzr1XODKHfnL5niZqXwpUeCstaWqJnAHlASmouaU0h+9d4/H
	Wf4GroXcCmlsNRMKWBZfV1RBA1A8zW6kQ+OLFP2AQfcHOpUoLgWg/WacUix4m2GB
	ygbeHtmIQtxXFv0IRkr/AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719914639; x=
	1720001039; bh=w0BsET4XO2EbD/Q55BNLIPKw+27X4/d1LTf3mFB9I8E=; b=v
	hc5Rfl9tST/T0gL6boDn7oupli4x0OqFxRJIAYjPw1feUyeSqNJvFGvL1LR06qOK
	2eNm+o6kApn43P4QWuZefgL9Qq+e6EGT+nrfwFkUEc8rUY/rEJmsO2qdPh6EdTgB
	jFs72uO7PaRx33XNdRLzEuMDtOMTcmnjjfcHUZ3b+biXV1cRRan1DrmVtcFX7axn
	yvVsXVh2YSbq3U3k5rH7qi7+e0CC/RFTgS4DzDA82vkjJG4sGQgRPVEgnFU97Nm2
	LnuLsBxGONXXv1aC9VexlfXDNYiOzsDjU6F38XkJZh2UfIPJpAiktGBypUNYdAhD
	JSS6zzo7hCqLD99R47P2A==
X-ME-Sender: <xms:jtCDZiY8s8YICgZZhhqRfoPfIgV8TwXUYuX-1gMqG5q-49kv_jCXCw>
    <xme:jtCDZlbcWFHp4jyhOjcyRiwqdz8zG9ccl3xTTXvDlYkrA1Go-IdeHIvjJZoed9-4X
    j63YKFLKnO5aPLc4Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:jtCDZs9scyNdgoMJEeDSDiXIG3hZhYVLfNA-1rtViUjGfsxOXm4PlQ>
    <xmx:jtCDZkq6nuFn4Qk8x_UPWtANu4mBTzCh7DDJPkSs_rcfqj0-hLNvXg>
    <xmx:jtCDZtqRb9DaJ6zJ-zLfZl-KXmk42-IcIw9Ucf4SNtVs-ZF4V7f32g>
    <xmx:jtCDZiSSaf6gDsDY1jgXLMkXM-0YK_tqtoWJNrvnP3B-KK7hxuntog>
    <xmx:j9CDZo0BX82S6ioGFEzkgZG-EdLY40OahBqdbw_0G4uDY7ftjoWnnkM2>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B2A5536A0074; Tue,  2 Jul 2024 06:03:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fd1d0a97-7075-4936-b58b-e99bab9afc58@app.fastmail.com>
In-Reply-To: <ae7085fd-3bca-4a4a-b465-5e4941011877@amd.com>
References: <20240629052247.2653363-1-uwu@icenowy.me>
 <20240629052247.2653363-3-uwu@icenowy.me>
 <a143a2c3-c6f0-4537-acc6-94f229f14639@app.fastmail.com>
 <2760BA02-8FF8-4B29-BFE2-1322B5BFB6EC@icenowy.me>
 <7e30177b-ff13-4fed-aa51-47a9cbd5d572@amd.com>
 <6303afecce2dff9e7d30f67e0a74205256e0a524.camel@icenowy.me>
 <ff1bf596-83cb-4b3e-a33a-621ac2c8171c@amd.com>
 <b9189c97f7efbaa895198113ee5b47012bd8b4dc.camel@icenowy.me>
 <ae7085fd-3bca-4a4a-b465-5e4941011877@amd.com>
Date: Tue, 02 Jul 2024 18:03:37 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Icenowy Zheng" <uwu@icenowy.me>, "Huang Rui" <ray.huang@amd.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "David Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] drm/ttm: downgrade cached to write_combined when snooping
 not available
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B47=E6=9C=882=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=885:27=EF=BC=8CChristian K=C3=B6nig=E5=86=99=E9=81=93=EF=BC=9A
> Am 02.07.24 um 11:06 schrieb Icenowy Zheng:
>> [SNIP] However I don't think the definition of the AGP spec could app=
ly on all
>> PCI(e) implementations. The AGP spec itself don't apply on
>> implementations that do not implement AGP (which is the most PCI(e)
>> implementations today), and it's not in the reference list of the PCIe
>> spec, so it does no help on this context.=20
> No, exactly that is not correct.
>
> See as I explained the No-Snoop extension to PCIe was created to help=20
> with AGP support and later merged into the base PCIe specification.
>
> So the AGP spec is now part of the PCIe spec.

We don't really buy this theory.

Keyword "AGP" doesn't appear in "PCI Express Base 4.0 Base Specification=
" even
once.

If PCIe is a predecessor of AGP, where does AGP specific software interf=
ace like
 AGP aperture goes? PCIe GPUs are only borrowing software concepts from =
AGP,
but they didn't inherit any hardware properties.

[...]
> We seem to have a misunderstanding here, this is not a software issue.=20
> The hardware platform is considered broken by the hardware vendor!

It's up to the specification text to define compliance means. So far as =
per analysis
from Icenowy of PCIe specification text itself it's not prohibited.

>
> In other words people have stitched together hardware in a way which i=
s=20
> not supported by the creator of that hardware.
>
> So as long as you can't convince anybody from ARM or the RISC-V team o=
r=20
> whoever created that hardware to confirm that the hardware actually=20
> works you won't get any support for that.

Well we are trying to support them on our own in mainline, we are not as=
king
for any support.

Thanks
- Jiaxun
>
> Regards,
> Christian.

--=20
- Jiaxun

