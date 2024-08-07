Return-Path: <linux-kernel+bounces-277712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B99894A52A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5690328380E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6351D3622;
	Wed,  7 Aug 2024 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CXTKAAGG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xh0v0E4/"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573D1BDA9F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025467; cv=none; b=it5VFK+6newXPqtMCJT9E44v/7sOyKFyuMHqEsYm867tOgkDxc98K/sU4L/eJHaxQSDU7nHqSXqjuVnvWxIWEaRxvxtj0/IwQf+BDmlp4HRmZIpHFPuhycwud/22+wlea78no6SCIfqulDZr/i+baCGRxZo0Mz7npveP5Qows+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025467; c=relaxed/simple;
	bh=KO2kRsuSQSDXww4WAfSGLqF9DOeb8o4t+SCHSusZylA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KKHBd/3vvEjalaPmXHTb9NndtxzeX4sDzWIqWLHrnuX+sFrpu3Ac1/l9dIWGPCs6eevXVPzJAUVEQCZQiomhFxXEOOPld/+65UTUBZetnpy61YYOGixUvNRJxKXU//XWx0KznwCyLmO3KQiu9ofHfsxezLY550VyKezLCUkEXns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CXTKAAGG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xh0v0E4/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id B2EE2138FD5F;
	Wed,  7 Aug 2024 06:11:03 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 06:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723025463;
	 x=1723111863; bh=EjBkt7Nh/1tr0JgXo5PFdMHmHta/OkKCYJpNRMtg2C8=; b=
	CXTKAAGGLq1fW//BSYjiDnhe/ag50sDfQeCZ3JqyvFEY0kybChTxHzOWqskNnMto
	J+lxAHSZI0oiMNpMdYHQEleY/pJjCAXTdzp6xk4S+FWpP7zXXUcOyV8pY8M+bi37
	Sn1oqqh6WNQD0oGezFvBJLFF/CzTctJXRgve0x9rvhQyWOV6/QzkFGX59Ln71OKr
	Eq6qUspRjkbGbe4S1YG6UGxoQlIwFPbgbnGa0FTdP2tUxTuNuk3Rl7ktL/TcdbyN
	dO44Y4/wH/1qet+dsf3si2zjPyiNtBvf4wdN2K0jPHRzIcHoRsi/X+doLbR1pO4y
	G7wE38O59/0ix9lpoWP1EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723025463; x=
	1723111863; bh=EjBkt7Nh/1tr0JgXo5PFdMHmHta/OkKCYJpNRMtg2C8=; b=X
	h0v0E4/nJIcRfJM8Lv5RyN3u6xlloPk1g+zxAh5tzMvh3DZAuL6/UugftpLzrSW6
	mSk8MwxibHVaKAvogxQU/JQsN30INtq/k/hfFqU1eWC1LLHPTb+ZRmPGuujV/v9f
	JQhJpj/N/Few0TWaynaq82rebmyE96L2xDEfe+22hSoJoJjJZkzv9eN/cihpc1aD
	KBiF+gR+THpF/YRpV1R+qvkRU7sOjL2qkv0fiXYPvT2YjAjcfyggl7SyQewLfsjR
	ex/D4o+f06+VKsjIgFS9TLPUSdDT9kdBTzkOMp4FmFr1M+XhNL1GgjWP1zfhoEeC
	MtaxMzW4grMzAfUkLOHQA==
X-ME-Sender: <xms:N0izZt7NkzasCIQA9RiZdi0JtrsmfAUNhDAJqW7Je0tL3KJ9V960gw>
    <xme:N0izZq43gpxvPoQ7VzzYsIVV84mrhwRcLKC3BdQGnYR_396dAqtP313L_AxOxXb4f
    wTS2r7yp2souRCk7bU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeethfekgeevveeiiefggfeifefgvdfhkedufffh
    ffffvdfftdehkefgkeeljeeggeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsoh
    hothhlihhnrdgtohhmpdhmuhhslhdrtggtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpth
    htoheptd
X-ME-Proxy: <xmx:N0izZkdhQNGaIQCfuQjx63hp9nsfkpK8TzRmGJorCLXQRCfFQxG6og>
    <xmx:N0izZmKhJnSopo3MaqveisCm1Gk-L6KddQh8eNv9Ruz0AytxufwZmA>
    <xmx:N0izZhKHDCgjD_R1BWIS55FZgRn4dI1M5OsqE1mDCFz4wCvpgYPwuA>
    <xmx:N0izZvxKLvCOzlrA0AfF5DpjihlenYSiD54Oo04CoiYO6cpqWhFl6w>
    <xmx:N0izZmoJwS6Z2aAslTK78r0zy_imJV6biyIWsEUJZjtj_R9YxnSeMAQW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 421F5B6008D; Wed,  7 Aug 2024 06:11:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Aug 2024 12:10:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Harith George" <mail2hgg@gmail.com>,
 "Yuntao Liu" <liuyuntao12@huawei.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Ard Biesheuvel" <ardb@kernel.org>, harith.g@alifsemi.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <acc20caa-79b1-4174-98e5-97a651012685@app.fastmail.com>
In-Reply-To: <14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com>
References: <14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com>
Subject: Re: [build fail] v6.11-rc2 from "ARM: 9404/1: arm32: enable
 HAVE_LD_DEAD_CODE_DATA_ELIMINATION"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 7, 2024, at 07:12, Harith George wrote:
> Hi,
>
> I am seeing a regression in "make xipImage" builds in mainline tree 
> v6.11-rc2  with LD segmentation fault.
>
> $ make V=1 xipImage
> ...
> + arm-poky-linux-musleabi-ld -EL -z noexecstack --no-undefined -X 
> --pic-veneer -z norelro --build-id=sha1 --orphan-handling=warn 
> --script=./arch/arm/kernel/vmlinux.lds -o vmlinux --whole-archive 
> vmlinux.a init/version-timestamp.o --no-whole-archive --start-group 
> arch/arm/lib/lib.a lib/lib.a --end-group
> scripts/link-vmlinux.sh: line 49: 3371164 Segmentation fault      (core 
> dumped) ${ld} ${ldflags} -o ${output} ${wl}--whole-archive ${objs} 
> ${wl}--no-whole-archive ${wl}--start-group ${libs} ${wl}--end-group 
> ${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
> make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 139
> make[2]: *** Deleting file 'vmlinux'
> make[1]: *** [/home/amol/hgg/mainline/linux/Makefile:1156: vmlinux] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
>
> git bisect pointed to ed0f941022515ff40473("ARM: 9404/1: arm32: enable 
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION")
>
> "CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y" is getting set with the 
> commit in my .config.
> But, my .config is _not_ enabling the "LD_DEAD_CODE_DATA_ELIMINATION" flag.
>
> Reverting commit ed0f94102251, resolves the linking fail.
> Infact, reverting just the ".reloc  .text, R_ARM_NONE, ." additions in 
> arch/arm/kernel/entry-armv.S resolves the linking fail.
>
> My toolchain is
> arm-poky-linux-musleabi-gcc (GCC) 9.2.0
> GNU ld (GNU Binutils) 2.32.0.20190204

Obviously 'ld' should not segfault, so there is at least one bug
there, possibly also a kernel bug that triggered this. Can you
try with newer binutils? This should hopefully either solve your
problem or produce a more useful error message if there is still a
kernel problem.

Any of the binary toolchains below should work in general,
the latest one is the gcc-14.2/binutils-2.43 version I uploaded
to kernel.org the other day.

https://mirrors.edge.kernel.org/pub/tools/crosstool/index.html
https://toolchains.bootlin.com/releases_armv7-eabihf.html
https://musl.cc/

     Arnd

