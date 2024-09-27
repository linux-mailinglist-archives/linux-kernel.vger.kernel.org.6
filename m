Return-Path: <linux-kernel+bounces-341645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336FB9882F3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AF52824F0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC62185E7A;
	Fri, 27 Sep 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Sa0op7Dr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HaO1PFwd"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E2186E29;
	Fri, 27 Sep 2024 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434810; cv=none; b=b82/j6oyl2marpwpKisQHb+d4FYqo7RBD997pt0Bd+6PvW3rtoCN44yM/K1FL7/GWVEXGvVCvJBkhkupSjk1/ltQ8SEfIYKelcdSSyWXmRYX9WQ31W9EHa8wD97IR67OCWF+DCi8tAizDTP1na05ZZEbex9p6yFxQtCoahpM5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434810; c=relaxed/simple;
	bh=lcNikPtKAxq/dN0ibeXX8gwGwA4AaxcYAE0tjk+fG1c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gsgnIv/A0HUhZEjDkXCz2b6w4LOOO4hiuewFcUGJ+nlHyY1hyVvjRaJxAKeKVHnp7Sf/pdrxukw0SarlxdC9pYCCw80JxTyeN6WnmRCH67W8qwBMJ6iU/zwmFDH6b8+BZr1JyspDrE7I76Lly0KDddPZ1pyLS8tsEOQkM6pA0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Sa0op7Dr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HaO1PFwd; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 18FDF1380712;
	Fri, 27 Sep 2024 07:00:07 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 27 Sep 2024 07:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727434807;
	 x=1727521207; bh=pM2APWPqWSep6TrEUhdTADKW01Hs8FHzTKdjsf1tTCg=; b=
	Sa0op7Dr+YKcZT4oSmDjVDjyMXp++/lhg9SG1pk3fix1TZsDR1PQWsO3JOSQ7ZTE
	TG+bn6JASXdbNtP2wemJRrtSYzFtLA0j+/QrA4V/JcTksSDprGBDgx7jJdcAvAF5
	bvMbk+FESfTZzdv2Wl6E0oUr1i2mpmwCb0/AmMhqu57jWG48qSo5cjfOiXdO9Oqp
	MRpgpIrqaDx/SLmVkP+nX6NwQ/EfrptteLz2XeTOgt7ANclRlZVb8oiRlzJwcf+g
	z9Qtq0qarFNckTLUBu0a8kFxg3KwpIrFH6MTfFXfVmNCTq5vh08Ehlwe/npM5eB5
	XvDNY1hp7zYHB0A/0om7MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727434807; x=
	1727521207; bh=pM2APWPqWSep6TrEUhdTADKW01Hs8FHzTKdjsf1tTCg=; b=H
	aO1PFwdJbcwb/BehiJ5iwCUUWbl9Htv1oPV7KPmK+sSA4EgddZMkdtohxsYgpu5O
	DR+Q0Dz2HG67E3K5tLab2uGGg3gq2PmzXu1ebKzBHtmHORuXSJrmrwenqajM5gRk
	Ee9DeYsfwljro3NMVgJoROOsELCctNMwdDLI+Y2fH4DqGcThMKi6b0M49G4IkqpG
	Q0MKDbXwloEJ2ic68aHg5sTn9RSQvrrz2LuCFxoYvtFmnELPcYBzkmPU0ggpv+gW
	eAyZCfBQOKlFMIqE5TtmnVQkuLwbqPyZ3nbNQtHvRz3DD0jsGbkt0QrvvHLhm+kU
	m8lLxabveKBu30AwKHZUw==
X-ME-Sender: <xms:NpD2ZqeoXQiUdMM4N8bET5a2qBVYW_jNcmmobJya1kyF0ZzAQheh6g>
    <xme:NpD2ZkP1UElTwyTzTPb6rPqh-VwWjpMkNUMzzD8Axor6jBICpWo1SYJkPPbd03moo
    E_w8vagQGjFgCEvsY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrg
    hssegrrhhmrdgtohhmpdhrtghpthhtohepjhhvvghtthgvrheskhgrlhhrrgihihhntgdr
    tghomhdprhgtphhtthhopeihshhiohhnnhgvrghusehkrghlrhgrhihinhgtrdgtohhmpd
    hrtghpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehguhhorhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrd
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishht
    shdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:NpD2Zrj39h4VXYFaMgI8sVlcLpAxmyDOujVyG1ZgjUZ3BT1CGw1SlQ>
    <xmx:NpD2Zn81OkRaBTLxkF_TIr7PeiNMt_LEThqUoLdGK4t0gQ1yr3D7eg>
    <xmx:NpD2ZmulMAj_Gpr4hsFXlDcuEbDVjnHZrWLGKMLnPdfXSbCQskLxvw>
    <xmx:NpD2ZuEs3_rbzNrhVBC-fy7VEXLVJNrvXFvYi3hodc8RvZeUmHKIHg>
    <xmx:N5D2ZuE5jmWpEuas5KCvyuGrRCcFCPV7idgmVmfWNgU5dFBTyKnkVfC5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 661A92220071; Fri, 27 Sep 2024 07:00:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Sep 2024 10:59:43 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <jvetter@kalrayinc.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 guoren <guoren@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <7100d48e-2b11-4d7a-8c5d-48900e8d4916@app.fastmail.com>
In-Reply-To: <b9f3f692-d4fa-473b-9bdf-4ea73b22ccde@kalrayinc.com>
References: <20240925132420.821473-1-jvetter@kalrayinc.com>
 <20240925132420.821473-2-jvetter@kalrayinc.com>
 <f47e66f9-ec20-4e75-b88f-d412339e797d@app.fastmail.com>
 <b9f3f692-d4fa-473b-9bdf-4ea73b22ccde@kalrayinc.com>
Subject: Re: [PATCH v6 1/5] Consolidate __memcpy_{to,from}io and __memset_io into
 iomap_copy.c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 27, 2024, at 08:19, Julian Vetter wrote:
> On 26.09.24 09:14, Arnd Bergmann wrote:
>>> +#ifndef __memcpy_fromio
>>> +void __memcpy_fromio(void *to, const volatile void __iomem *from,
>>> size_t count);
>>> +#endif
>>> +
>>> +#ifndef __memcpy_toio
>>> +void __memcpy_toio(volatile void __iomem *to, const void *from, size_t
>>> count);
>>> +#endif
>>> +
>>> +#ifndef __memset_io
>>> +void __memset_io(volatile void __iomem *dst, int c, size_t count);
>>> +#endif
>> 
>> I'm not entirely sure about the purpose of the #ifdef here, since
>> nothing ever overrides the double-underscore versions, both before
>> and after your patches.
>> 
>> Unless I'm missing something here, I think a more logical
>> sequence would be:
>> 
>> 1. add the definitions in this file without the underscores,
>
> by: "...in this file..." you mean the 'lib/iomap_copy.c' file, right? 

Yes

> But what if an architecture does not select 'CONFIG_HAS_IOMEM'. Then 
> 'iomap_copy.c' is not compiled and we don't have an implementation, 
> right?
> I tried to compile with ARCH=um, with some MTD chip driver, like 
> the robot did and it indeed fails, because um has 'NO_IOMEM' set. and 
> the driver uses memcpy_fromio. I mean it's a strange combination, 
> because apparently we try to use IO memory? Is this an invalid 
> combination? But shouldn't the driver then 'depends on HAS_IOMEM'?

Yes, I think that would be the best way to do it. Alternatively,
arch/um could provide a dummy implementation of these.

>> 3. convert the other architectures, removing both the
>>     implementations and the prototypes.
>> 
>
> I have removed the prototypes and have aligned the function arguments in 
> m68k, alpha, parisc, and sh, which all have their own implementation, 
> but had slightly different function arguments.

Sorry for being unclear, I meant only the architectures that
you are already touching.

> Btw, I have not removed 
> their implementations because some of them seem to have optimized 
> implementations (e.g., alpha and m68k), that I didn't want to touch. But 
> you're right others (e.g., sh) just do byte wise accesses and have a 
> comment "This needs to be optimized." Maybe I should remove these and 
> let them use the new version?!

Ideally we should end up with only one copy, but I'd leave the
rest for a future cleanup. In particular, alpha probably still
needs a custom function.

      Arnd

