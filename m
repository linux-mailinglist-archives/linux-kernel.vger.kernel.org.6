Return-Path: <linux-kernel+bounces-254044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58885932BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D6B280E22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D0119DF88;
	Tue, 16 Jul 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="uvMQIl7v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gvXB098s"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141D19DF53
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144941; cv=none; b=YRWyMR+2NCkP+2vn7T8GklgrWVu0FewQiH2Vmd1XMlfGJi8S64tTCXgIdQMvybRLqZT9cP3NjDnSKj0XmOrT1jDDcDBB6Om73YaAxv8lGCjjXrbCOnqifEdtulHeKGfNj1FE3Y5jNuwdt5/FDNI9q1Lguo17bgQkoi+qjDV6zBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144941; c=relaxed/simple;
	bh=RG0OOcowRv7G/wQ529Xh5NxbuzC8x7bbZE1w2c5DLDU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PjhwTInXLmmV4DnrvsbXYeQsoN/rk6Rw2O1LkMQdJmFzuEYrREfKe02yZocWUfzGUEzIVHXrzD+1sfTAxpj0f434NL+L+scPvsFN2TMHvYAa/u4RR+p95HeYFHmFxlyeuZ5SirF/o0AeYUXv1je891Utg4ojQEvPwdw+jbnOhKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=uvMQIl7v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gvXB098s; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D39B11140A13;
	Tue, 16 Jul 2024 11:48:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 16 Jul 2024 11:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721144938; x=1721231338; bh=pgpViVSXQF
	5LkqrApHu3+j3/uGYvXxssZVnHOA1Pxy0=; b=uvMQIl7vMbQGIdyxbwFRkZ+e6r
	zDDntJgaIyt8ofP//YZO0+xcyHxo9a7d9X2NAFeJy2MI13nTlmlKA8+OgBK33iRg
	0a8KUSGAatufOqgF/aPIj6LoTYIsnoc2ZftGCyMEmFDkvtJTSrzYXLyRJMEng8YF
	JSXYJxUJv0rd17c8ap8yQg5ClN9bhW7n+KAiSpG38Zxc+AuQqWpH8hXq46d0vdfA
	hRLzQmfCLMrGvcl8xjQVCsQGkIBVudUOon+xZEmyvFJKxN7CnpZ1H66J6pTcD6z1
	1q0QhE71e1cjb/IbbPyizdKZUN6unzxwC+KcKMisBSWYideM5xKLD8V4yH8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721144938; x=1721231338; bh=pgpViVSXQF5LkqrApHu3+j3/uGYv
	XxssZVnHOA1Pxy0=; b=gvXB098sg6CkqEk+obKXHKbQVjUs4NvPq30RFYL8Mq8F
	VF+DDCkpMPj1Gwm0X4uDMwTq2aLj61wPHFFUY5gIWBxGoO4iAoOXRGH9us1/c35d
	cRwkHUBX4UXgP1L+TGGyMPdyYXg/1LnftojU9g9ctdq8M+BL8F18Y2hYfCA+8tYL
	VP5wFEOiHzOYaT6fXf0JdE5k0GX9tMD0OZ4le6j/R8ubSBY/K7K+tgMZTYO3LS2B
	JOtYuor5ueeZB6MZ7uoRBTocU3AjER5SmdNDwMUNE0/5G7xMPGDVF5q+Kx4X5fah
	oQizIRucrbimEh3fhsLHxH6kuAev/swRzlQ/HSTD0A==
X-ME-Sender: <xms:apaWZmRsoi-8Kb0B7hl3kPCrCa7n-sqJGu0BxxZ-bJaUqLtd9Uo93g>
    <xme:apaWZrwasCFSTmAceSO7H2sEi6Z7_txuDbkNHRxJDxBZLVqcRHZVrnZg7YEkbewLD
    vB5qgL0AI6wbq9S52A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:apaWZj2isDT_m8DLcrAYx1FlQQE6fugS2UHEo-tzwJ4Zb6knEkUzPA>
    <xmx:apaWZiBOF9wTHZ66JIAN8TCt-7o7Uc8w1ySHhLowIR9HJhVnYbfltA>
    <xmx:apaWZvjH4Kepq1mSOujrhI7VuVgW-GCcy-YDjeqboV0GU80rey0SpQ>
    <xmx:apaWZuqQ5FfJOKmE11pIe34r8i5Pf0IslgcZk1E6W5zx8qtPxQBm5A>
    <xmx:apaWZstp8ncO0f-f0pBjSP_D4F9r6B_XY-R1e9aETbyGgw1ZX_k6wC5r>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9AF18B6008D; Tue, 16 Jul 2024 11:48:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10d583d4-29ec-4dae-8629-f6097639cc4e@app.fastmail.com>
In-Reply-To: 
 <MW4PR18MB5244F75E2D16051A5B838FF5A6A22@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <20240711120115.4069401-1-vattunuru@marvell.com>
 <20240716132603.GA3136577@thelio-3990X>
 <83ac6b91-c7f1-4b18-a522-8188d6d1298b@app.fastmail.com>
 <MW4PR18MB5244F75E2D16051A5B838FF5A6A22@MW4PR18MB5244.namprd18.prod.outlook.com>
Date: Tue, 16 Jul 2024 17:48:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vamsi Attunuru" <vattunuru@marvell.com>,
 "Nathan Chancellor" <nathan@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH] misc: Kconfig: add a new dependency for
 MARVELL_CN10K_DPI
Content-Type: text/plain

On Tue, Jul 16, 2024, at 17:33, Vamsi Krishna Attunuru wrote:
>>> Including one of the io-64-nonatomic headers would resolve this but I
>>> am not sure which one would be appropriate (or perhaps the dependency
>>> should be tightened to requiring 64BIT, as some other drivers have
>>> done).
>>
>>Right, a dependency on 64BIT makes sense here. The alternative is to include
>>linux/io-64-nonatomic-hi-lo.h or linux/io-64-nonatomic-lo-hi.h in order to
>>have a replacement readq/writeq implementation that works on 32-bit
>>architectures. However, doing this requires understanding whether what the
>>side-effects of accessing the 64-bit registers are and whether they require
>>writing the upper or lower half of the register last.
>>
>
> Yes Arnd, I am checking the functionality using lo-hi calls that you suggested.
> If it has any implications, I will fix it with the 64BIT dependency.
>

If the datasheet does not give you any insight about how it works,
you can try it out on a 64-bit kernel by changing all the
readq/writeq into lo_hi_readq()/lo_hi_writeq() or
hi_lo_readq()/hi_lo_writeq() after including the corresponding header.

Usually only one of the two works, or possibly neither if the registers
require 64-bit access. If you figure out which one works, you
can change the calls back to readq/writeq and leave the correct
header included that will provide fallback implementations on 32-bit
architectures but use the native 64-bit access on 64-bit architectures.

In practice this is not really important because nobody will ever
need to use this driver on a 32-bit kernel, given that this SoC
only supports 32-bit usermode but not kernel.

       Arnd

