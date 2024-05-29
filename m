Return-Path: <linux-kernel+bounces-194251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F3A8D38F0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4E928B947
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7167145A00;
	Wed, 29 May 2024 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bI1zbr1E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IVmMjRdp"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078121384BF;
	Wed, 29 May 2024 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992066; cv=none; b=OfaSZExTG1inXzlksJkqHrlTUdxsMLueKC5Hk8twzSJ3cKODY8CgLrhyjKNVq938RPSgX2SFiqucrP2QPuWBNpq4F00A9+258jOQ4c/ooTxFfVdlMWOQ0wrau+PJR2KbAJnth/02HCw5BEe5yFBaE1UTFrtyLFhXEug9htJfcJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992066; c=relaxed/simple;
	bh=W22hC2Zv+Foa0qgUlAk4AdngF7rx6T8UVXQlXFr2Ybw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FlJkQjbMUCBIVqoglC29OSfv0sI1BM+yC/o0Q8r2yxPIN3Hhl8BdiGuPxPCtPu3sZTOWhEbzKcqYo+Xjmj1QvCpjMU5CmZIGZeqJUXFlViouSI+p5k6gV/FHxy3zQlrHhfw16voQ+oZegmcqoVIw8V/YHDHpkTBlL1eIx3LUjoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bI1zbr1E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IVmMjRdp; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id C56691800110;
	Wed, 29 May 2024 10:14:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 May 2024 10:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1716992063;
	 x=1717078463; bh=eY7afOORxV4hOLeuj409JKFKJJHZi+ceauiiRURn6p0=; b=
	bI1zbr1Eb+X1iMahPtzHX/yHgNrHIdjzD3VaSIgED2LkcqzEANSnJ1go5m3UqMGT
	9+vkPva0paWhLAtf0nXq3Pc1WKmN07H5Z4refYIiZhCCJoT5DBwdtElPP4tI03cY
	DxnQhbEPjGLZT/nHLk6w7HCIf/9FOeU3W6v13BrJL/0KLnFd+/inGqYqzdLCNsdv
	wgC+paVBRdzqtdkIuyTiruJPSJ/UGWDTzS2nGFpuZrugrlAn2J0WFGFGQDha5Owu
	IDKLp3G1NyUVyWI1i9aoosARcXRHiFe/GyCioZcx8TB923OyUTbWIWCwjWNIdGnk
	+GyU3nf2OIjOEGRzCKOPFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716992063; x=
	1717078463; bh=eY7afOORxV4hOLeuj409JKFKJJHZi+ceauiiRURn6p0=; b=I
	VmMjRdp6zSIXUpPEqQWlVXQCwmiB0e1D1LTqDIN46bb1VsgHQB5z2mLLcF67KwO+
	SGxniaTxoon8DUR0w7TqGud/g8yqHeHZEP9MLcICCR/YFWIRpZfN2N1RJ40qjE4u
	KqfD6Mttdvk0F586BCTmac/P2GWRY+LUSsCv3Gkt920hci1zHDv3nl9SHGueBxj/
	8fd86otV4tdKL5ci3AWhLtbyCYToLgU4Ycp3xPd+pOtrCDs0ebBta+jXICuMElYt
	2XBkZZhnnOcZORUsJRiyBCFKReDIiYgDSUliNH1ARERcxGY7bZcpuQp5H8jOqSIH
	kKX2/i6UjldcQp2kHmo2A==
X-ME-Sender: <xms:PzhXZjZ_xcl8Quhl_JiO65RwGo7KYNl0IBFQh2FFtDlRZ_JRAVTfFg>
    <xme:PzhXZibKH7u9T7SLRNvYuf4XLG6Bqq5TwPZP0lQIS6v0jLVWZKcH2qYrPbcfqrKXl
    jxAjuOnl_vZTfbQpVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:PzhXZl-Oj4JxwLGV06iFYzauzjMooXMBN45ZIQ5H5DbqtqjVt9Nlyw>
    <xmx:PzhXZppkgHf-kuSBZSpBmACSe3hSYaMiJwzw8WTMDNqPOJKMCkHdDw>
    <xmx:PzhXZur1SMKx1xj9mrxPLO0LosZlpwziV2r858lVjq0kohwLebeqeA>
    <xmx:PzhXZvSMn2YPUWmnEbUBKwAQGD7XWLq1Ce5jIezdu180kdhTw0ch1Q>
    <xmx:PzhXZvcdCVZPDoVPlmz0R0duefKXkhr4ZgfmvdWbvwHrxdPWFvI02mBx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D4196B6008D; Wed, 29 May 2024 10:14:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <436667b5-308a-4a0b-b66e-230667ce0cc3@app.fastmail.com>
In-Reply-To: 
 <CAHp75VdRuK_sOF=25xP0azp8sOJ8DY_SRpLq9mUSaNEmWj5EAg@mail.gmail.com>
References: <20240529095009.1895618-1-arnd@kernel.org>
 <CAHp75VdRuK_sOF=25xP0azp8sOJ8DY_SRpLq9mUSaNEmWj5EAg@mail.gmail.com>
Date: Wed, 29 May 2024 16:13:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Daniel Scally" <djrscally@gmail.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: int3472: make common part a separate module
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024, at 15:41, Andy Shevchenko wrote:
> On Wed, May 29, 2024 at 12:50=E2=80=AFPM Arnd Bergmann <arnd@kernel.or=
g> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Linking an object file into multiple modules is not supported
>> and causes a W=3D1 warning:
>>
>> scripts/Makefile.build:236: drivers/platform/x86/intel/int3472/Makefi=
le: common.o is added to multiple modules: intel_skl_int3472_discrete in=
tel_skl_int3472_tps68470
>>
>> Split out the common part here into a separate module to make it
>> more reliable.
>
> ...
>
>>  obj-$(CONFIG_INTEL_SKL_INT3472)                +=3D intel_skl_int347=
2_discrete.o \
>> -                                          intel_skl_int3472_tps68470=
o
>
>> +                                          intel_skl_int3472_tps68470=
o \
>> +                                          intel_skl_int3472_common.o
>
> A nit: Can this be put above instead?

I've changed it like this now, is that what you meant?


obj-$(CONFIG_INTEL_SKL_INT3472)         +=3D intel_skl_int3472_common.o \
                                           intel_skl_int3472_discrete.o \
                                           intel_skl_int3472_tps68470.o \

intel_skl_int3472_common-y      +=3D common.o
intel_skl_int3472_discrete-y    :=3D discrete.o clk_and_regulator.o led.o
intel_skl_int3472_tps68470-y    :=3D tps68470.o tps68470_board_data.o

> ...
>
>> +EXPORT_SYMBOL_GPL(skl_int3472_get_sensor_adev_and_name);
>
> Are these namespaced?

No, is there any advantage to making them namespaced?

It's only a few symbols and they have proper prefixes.

     Arnd

