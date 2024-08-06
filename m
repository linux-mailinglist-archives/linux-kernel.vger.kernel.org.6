Return-Path: <linux-kernel+bounces-276855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40359949936
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBAF285780
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBE14901A;
	Tue,  6 Aug 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Vx4k+ZxS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gx05RsPi"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418237703
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976630; cv=none; b=iypY5lst466f5mTMCWbPf3jQW/ApktzYBVJjDB5A7g/1a88I4c8kB6kLw1dMcgLGs/OEoAmOd+1UHKssjRMnvpb2S7jO/PdibsH3Vu72/PpIHBhmXARVzGHe6dmd49vQhGoz22psrtizBknGvwEJD++GlEGjbCcytPyvKaKkCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976630; c=relaxed/simple;
	bh=nMb7149c8K2+0MlE5TN1mtcdxqWb5z3hrCXdJKbCLn0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bBqCghF/0X3ArlhTutvFkJ8jNkdPTkJdaQ9vItxjbg9k5bjeB5IP+/Jvfp/QbDjUDWRSZF4uQ4ZPydExVVtopeMPNRNlyLS17vaIO5+cfeiPTH+WSCU7VstPJtcg8HeY521/eD4GnZa7WV32A4Sm7e775JKtmaWxf+8LhQzQIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Vx4k+ZxS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gx05RsPi; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C9ED7114E9FC;
	Tue,  6 Aug 2024 16:37:07 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 06 Aug 2024 16:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722976627;
	 x=1723063027; bh=VA8pGHt6SaTpelqTKxhCB3v7RaWJ4peeRnyyJtDzzKg=; b=
	Vx4k+ZxSGoTlBNA/Tx/I2cca6vzmGov9S7s7mCEDI7w9HGCqoXY1o0rZPzj/wQjF
	h38ERNNsodRHI13dmNPZSN+wc5pXP2lfTV0DkAeQnbRvtIoQkch9NZKq6DKMwwm3
	VNJSoQ2F87ImOUMay4QjFaURjUEy07ys/+1duktWLr2H0sS4zR+FT7ueG7ehYpci
	ORHLmnNd2qLnV3lN+C++K2cWhGJQi+zUBTDLqPQIqneUxtYf9tqZPP6TwyCacYMN
	WbhiQyhggQopHh3H4aaCZWZopEsXMAo9/DZD5BKwkk3H9898gQxatz7d7ArYWuYq
	6TRZj5MPENKt+IwU4O9+8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722976627; x=
	1723063027; bh=VA8pGHt6SaTpelqTKxhCB3v7RaWJ4peeRnyyJtDzzKg=; b=G
	x05RsPiok3HaWtSr5EgIzK3FTt2Dr04NXH0g6hVS0WidDLDb6r0hgyrRNi7qt1Sx
	VnQo592DTwSA3e2B3PuxgUiCnGDcD6JnTHB6TaEUqgjZBXENnCCOmRZilAihUc6W
	246ySv/ERsVM7EKV530GgK9K1M/pxkv9uMZ2psa+sgGYaGLl0FrzQuKP1f5DmO/4
	BB6iM8XeUwRKyQUMOzSZlwH9dNfZDMvW9X2pFYikpTmQRUIFmXnnRNGr+ohQDAuI
	0spVMrPl72EIPPVU0RM3M0FqXT96qdzLzR+WuExOjQs0mNIx5d4Nsr96jro/fd22
	rSZ/Yp+y2xTea/wladLpQ==
X-ME-Sender: <xms:c4myZmGskA3xjg_0TFMNMnZ09EkO0UPe3vnSbbTCQUIMLOJnAEGXmw>
    <xme:c4myZnWn2hAruEpYg4Zi2QDXgYyYRl5ndiuN5ueayrio9Sco2CYjyjg5ut64d_pzj
    iTkjOu2tdCGnYK-L6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefh
    vdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:c4myZgLDyGyL0AphZYlMj0dHk-gHJtCcq7_EVSI482OHux692CTWpA>
    <xmx:c4myZgFAanedca9D5kOXi3VkYpl9lg-1N68Up38I8-URK8eA4pEtmw>
    <xmx:c4myZsXq7WjBoleoVtN5wJGJv2-L6dEeXnPJRcbMF_o_xa9aFnRKAQ>
    <xmx:c4myZjOQvDJAmiU6FlYIvdqp0CURlf7ZNYff7S5SXA0biEpP-_eXrQ>
    <xmx:c4myZvH4QLBvlhvsoRitRYyRfw_MuExfkMgZ8mmGFYn0LwUHHYBhLtSl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5A15DB6008D; Tue,  6 Aug 2024 16:37:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Aug 2024 22:36:47 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Daniel Mack" <daniel@zonque.org>, "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Linus Walleij" <linus.walleij@linaro.org>, soc@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <86398d78-8c26-479b-84af-904d9198da10@app.fastmail.com>
In-Reply-To: <ZrJWJoDdNTLuIViH@google.com>
References: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
 <20240628180852.1738922-4-dmitry.torokhov@gmail.com>
 <3f7971e1-0576-417b-8aaa-c06e1697908f@app.fastmail.com>
 <ZrJWJoDdNTLuIViH@google.com>
Subject: Re: [PATCH 03/10] ARM: pxa/gumstix: convert vbus gpio to use software nodes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 6, 2024, at 18:58, Dmitry Torokhov wrote:
> On Tue, Aug 06, 2024 at 09:19:55AM +0200, Arnd Bergmann wrote:
>
> Ugh, you are right. Its weird that it does not warn me that the compiler
> did not warn me that it is not used... It built for me with
> pxa_defconfig so I assumed it was all good.
>
> Ahh, by default it forces CONFIG_USB_PXA25X to be a module and that
> skips that block in gumstix.c. I'll change it to IS_ENABLED() because it
> should not matter if USB/UDC is built-in or is a module.
>
>> 
>> I assume the gumstix_gpio_vbus_info needs to be turned into
>> an swnode, but I haven't figured out how to do this.
>
> It is just a matter of initializing .properties in
> gumstix_gpio_vbus_info. 

Right, makes sense.

>> Based on the recent board deprecation discussion, I expect
>> that there are no users and that we will remove this machine
>> early next year, so we don't need to care about making it
>> pretty now, but maybe you can send a patch to make it build
>> again.
>
> Yes, of course. Could you please try the patch below? And if you see
> failures, please share your .config.

This addresses the configs that failed earlier, and I'm not
seeing any new ones.

I've applied this to the arm/fixes branch now and will send
this branch later this week.

Thanks for the quick fix!

     Arnd

