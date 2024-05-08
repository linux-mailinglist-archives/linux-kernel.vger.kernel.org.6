Return-Path: <linux-kernel+bounces-173740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE608C04C1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8059285A86
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB97130A4A;
	Wed,  8 May 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YS8pNXld";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jEhofAns"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9AE130A45
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715195524; cv=none; b=NlWfCZe/aprbRsgXvdk1oIn4QBv2vBDBmj6URtDhZORHoMADYw888eZrf1T+Kn1UxN4cvnCbYB6xpE/OQrBgyL9dQOTDnvHLq+Tz6g5z7V52+Jgu+kcwRl16g2OcMklLh8h+7Vs8QLfx2Lod7R2hgl4AWVeaGyH4XHDicXNO3/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715195524; c=relaxed/simple;
	bh=PK6qp2vMhDHRSEY9lMFS/YvbuAahsOCgdiwJdZeUw4w=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=CjZG2iHI8rBAytYI3Hf3jzl54LFflm+Oq5CyS/rBqhMsikiG+FMQ63+Wv0M5ncYKWc6ylaOz7waMsE8D/bIsG2b/6fyWqtSyNY1TxwLEkP4QPn9GQGD/uzy8kxcaeH2t/Grz0Z9CV1x88mNRaeyks0ynYmHjpSLxzIc/zq2ke7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YS8pNXld; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jEhofAns; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1F6CB11400A3;
	Wed,  8 May 2024 15:12:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 08 May 2024 15:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715195521; x=1715281921; bh=b7o5ZIjvfH
	yrKOMLF/GO7Tf2G5tsfeSYs7cv6FLBodc=; b=YS8pNXld9MoEVFnM3PA+o3jDNH
	/1iECD7yIG0WZhlsEJ6rt4mFOXTstjVkzSEewqD44PVieMviC9D6Dhe/d4K53lT5
	XxYzibeFCH6MPYJ35Fn998iY5CbSbG296s/pv1ypot2Oxm35Inm38uUB0AujAM/+
	LlzQJGoOcd2iYM9RymGrxyt8DBQFX/DY09AzTt/c0FPqTk398xaCEgUjvxRR7Qaz
	ayWrtzCANIgSYGNYXSVOzbgcHlt3yOr8eD0mNHn2wDaMP9VFeknIB2QhciJtL76j
	IuhIsVtMElpp8EeDzZwkigGQcO1JCMbGtGWbbVQ1vVoJMMclFKcmcoa5h9gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715195521; x=1715281921; bh=b7o5ZIjvfHyrKOMLF/GO7Tf2G5ts
	feSYs7cv6FLBodc=; b=jEhofAnshvxHm3cHDrSYvsan3rcETEqNcWFzXM7AQARL
	+IaRm1bCIJ8tkXVjSa/rgeU4DQSEOQ9GSTNsqw9FFcZNbyo+HhYHOW+qZYlCrsUq
	ga04rTtsqHlvRebWTZUyw7Kjj1RjoguWEhOLS1EEDWvPu1tl25/iCYNTgk3RSHNT
	07gKW4kxbP+RxOlzo/Htjp8/ItoBvXGWTc8wyeMDHFBX/4wezX356Cfv1tpTLFpN
	7hA1XsVJiKUUMtb9pR5l+HF6fVjl7kOJn8baa3SMeDFWzYZH+VNUlS7w7MpqPU8i
	wVZZTSHrZMcschDzvYetbICKy7rSpB9l18AMsHWKxA==
X-ME-Sender: <xms:gM47ZkBZqHf9gPXM4RNeSK31Fo1szPR0IFzeyEX8CgvXo7_oop8_gA>
    <xme:gM47Zmic00G1wYJMUg275c_joMszQk90nOsTYzzAKDJPFzC7JOw6h4R8_eSHwPVOs
    jO1bFVqGFzxZ9iJUlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:gM47Znlg33ysrc70-QyWQgf9ss5EFQZsFOHDfjid6PrDx6mSdL9foA>
    <xmx:gM47Zqw1OP5WWpN3q00fj98TL_8TipdU-F-FFw64Oni4hQYxQgXKCQ>
    <xmx:gM47ZpQm-5wteSX80TnRqWYvr7y4fbyGfRwEMJeGPQmQyDpaDrmLVw>
    <xmx:gM47ZlYB7-R_nuQK4n4t8QEzK_vfF7gTXb0EFCIkaO3wO9p-nTMQfg>
    <xmx:gc47ZqQQfS8gmCMdczs9bb50_3XOzJXeQzW54XeO_HRzWwr0fdBsaxxC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A66F6B6008D; Wed,  8 May 2024 15:12:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5b29d981-aa8a-413e-8250-5fb33802f32d@app.fastmail.com>
In-Reply-To: <9a26dac6-d776-4b84-830d-6f622719d7eb@kernel.org>
References: <20240414154957.127113-1-krzk@kernel.org>
 <20240414154957.127113-3-krzk@kernel.org>
 <Zju8HpBCiOjjIZ1j@smile.fi.intel.com>
 <6599e2a3-3b04-4ea2-aa5c-a916b66c8009@kernel.org>
 <ZjvEam5paLD0Iv6V@smile.fi.intel.com>
 <9a26dac6-d776-4b84-830d-6f622719d7eb@kernel.org>
Date: Wed, 08 May 2024 21:11:39 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] eeprom: 93xx46: drop unneeded MODULE_ALIAS
Content-Type: text/plain

On Wed, May 8, 2024, at 20:44, Krzysztof Kozlowski wrote:
> On 08/05/2024 20:28, Andy Shevchenko wrote:
>> On Wed, May 08, 2024 at 08:15:00PM +0200, Krzysztof Kozlowski wrote:
>>> On 08/05/2024 19:53, Andy Shevchenko wrote:
>>>> On Sun, Apr 14, 2024 at 05:49:57PM +0200, Krzysztof Kozlowski wrote:
>>>>> The ID table already has respective entry and MODULE_DEVICE_TABLE and
>>>>> creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
>>>>> the alias to be duplicated.
>> 
>> ...
>> 
>>>>>  MODULE_ALIAS("spi:93xx46");
>>>>
>>>> I was stumbled over this (leftover?).
>>>> Commit message doesn't elaborate this bit.
>>>> Any comments?
>>>
>>> It is not present in ID table and commit msg removes only duplicated
>>> aliases. That alias has meaning - someone might be actually relying on it.
>> 
>> It seems no users for it. The only user of platform data of this EEPROM uses
>> board files which AFAIU bypasses modalias matching.
>
> I don't think that's correct. The modalias of SPI board is there on
> purpose. 

Right, but I think a better workaround would have been to change
the board_info to pick a modalias that is part of the ID table:

--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -76,7 +76,7 @@ static struct gpiod_lookup_table eeprom_spi_gpiod_table = {
 
 static struct spi_board_info digsy_mtc_eeprom_info[] __initdata = {
        {
-               .modalias               = "93xx46",
+               .modalias               = "eeprom-93xx46",
                .max_speed_hz           = 1000000,
                .bus_num                = EE_SPI_BUS_NUM,
                .chip_select            = 0,


    Arnd

