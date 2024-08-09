Return-Path: <linux-kernel+bounces-281054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F5B94D271
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF881F24BDE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDFD196D9D;
	Fri,  9 Aug 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dBZkVzJQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eZbR59GZ"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62213FFC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214885; cv=none; b=sHiB5qvdf2hR61q3II0gHGYM4ULP4P0OwHLpdf0+AkjvgmWzRYxGrN+gEDIwe0yCuIcQUobpzhtyLxDq84fcZrLxYXvy/LQEpkWKAzRjO46oR87P/QZ254h1siD6kMaybi5RDBNOoCk935V4HOhb1shHq4OubeH4qXg3jW95Q1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214885; c=relaxed/simple;
	bh=wwHqCQ7oXb3dk7d6B4VaQj3pbfd2OP93/Zw0s+uKaoM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hQutHackDG0F1nkK6lC6YFOyZ8xj8Df7BXvtgf4PxqxZOodOfq9shKtuHyfOWR5htClW61iZWCIiqz5tb+5LZYe31lmpCjrfSEFFuJxTK7tqx95n5AGi0VkKO/G+T991nCu+9Re6xlDz5RWINfnBqFc/BrMk8XFYzlzd+YXou1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dBZkVzJQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eZbR59GZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 130E0138D8D0;
	Fri,  9 Aug 2024 10:48:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Fri, 09 Aug 2024 10:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723214882;
	 x=1723301282; bh=5ni6AdfPBznvU83xL6paslqlLx67PEUkh/hkcnAU01Y=; b=
	dBZkVzJQBZpNLv87oZ4kg0i7Gbnu513FzxSbNNGScuNPOER5Godd/m5TN7gADraA
	xTXnbcnRhutjyzRXIqJJyGcUoT+pUZMkkGWFn8GDwAv4QLUtK6flXLI6SPZFpQnj
	BV6/4rz6sCeA58N1Xw6abneISLU0QCm3L3xZAK6S4N8iJ+DfVQVSX3OQHxU5W0+J
	nnB2exbPNSbOwuKyHDY15FnTsTyUNq9qvLVQ2ZR8T0gwchfdGGKJCPNAGXHmlxaL
	3BgVRUxFTAH5cKZF524JdGo/qV10D6P2pwuiL8jijJuH7vUWpR9cHmXfTXG8UeTq
	jO9biyU2IBzuneuM3sIysw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723214882; x=
	1723301282; bh=5ni6AdfPBznvU83xL6paslqlLx67PEUkh/hkcnAU01Y=; b=e
	ZbR59GZJPbhsjM5XATcWATySFiePqBoPMkMIiq9T+DUcLEpzX/yXKnrzCerZzK7q
	lRXsB69sJwxP/F/bmqmaqybniLM+4uYI/USDwpWEW+uyUJD53yZhp3bhqaSvE2P3
	98bklOl0UzfWsKXq9eaKPsOTo107Jvl/Sk2jSWPH/LOGsjvorUQdAczs9OUqB4Yt
	BFDqXEMJNJ0IRjLX2BPDVYfxXpdB48qkolaRou+N+F2yHdSidHvRsTVfAUH8UW7m
	ckRHPbv91Tv3CzHk81YlzDzLJTUTGOq4sCGp/UoPGby1w+4cBnMA8LLmipMDL6NN
	HQwR71SMY7vFiUt61uztw==
X-ME-Sender: <xms:ISy2Zuuq7UjrBJs5nQgcNrrX780Mj-lAg9AQFJLCIpUReSB-pXbsQg>
    <xme:ISy2ZjcEWzfXU3OQXRZwBE4uHlhcwQKUSr4PsfjmUY6uVZ13udgFHp9WKG5AgjLdd
    R2tK_tXT0WEo190QL0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleeggdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeek
    leffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprhhm
    khdokhgvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepmhgrih
    hlvdhhghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhiuhihuhhnthgrohduvdes
    hhhurgifvghirdgtohhmpdhrtghpthhtohepmhgrshgrhhhirhhohieskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhg
    pdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrggu
    vggrugdrohhrghdprhgtphhtthhopegvrhhitgdruggvvhholhguvghrsehorhgrtghlvg
    drtghomh
X-ME-Proxy: <xmx:ISy2ZpyNnuMVxP1_hnXpe8GgX3RcWPG5RMzOzLm7EAPM9k2Dw3QSxw>
    <xmx:ISy2ZpPfb3b5M_WaSCZi2D29YhkB7Zy2RDfw2OtcPNvNxe0TElVbDg>
    <xmx:ISy2Zu8HSMId--mGSKJNQUAg7TjDDWH_IEgV0NG979MXVyNY2jFEDA>
    <xmx:ISy2ZhW3BoOcMB5BGQABSc9ftDAf2O-c0ju_zYc3O8KW8FmMoLa5UQ>
    <xmx:Iiy2Zv1zDK0EQ3GWwFgFgr1ZfdCde7chkhvl8KfLeS1K-K_Lria8Nj1p>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5EEE4B6008D; Fri,  9 Aug 2024 10:48:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Aug 2024 16:47:41 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yuntao Liu" <liuyuntao12@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Harith George" <mail2hgg@gmail.com>, "Andrew Davis" <afd@ti.com>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Eric DeVolder" <eric.devolder@oracle.com>,
 "Masahiro Yamada" <masahiroy@kernel.org>
Message-Id: <b9aa586e-5685-4b5b-9732-81f2dec7120a@app.fastmail.com>
In-Reply-To: <20240808123556.681609-1-liuyuntao12@huawei.com>
References: <20240808123556.681609-1-liuyuntao12@huawei.com>
Subject: Re: [PATCH] arm: Fix build issue with LD_DEAD_CODE_DATA_ELIMINATION
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 8, 2024, at 14:35, Yuntao Liu wrote:
> There is a build issue with LD segmentation fault, while
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled, as bellow.
>
> scripts/link-vmlinux.sh: line 49:  3796 Segmentation fault
>  (core dumped) ${ld} ${ldflags} -o ${output} ${wl}--whole-archive
>  ${objs} ${wl}--no-whole-archive ${wl}--start-group
>  ${libs} ${wl}--end-group ${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
>
> The error occurs in older versions of the GNU ld with version earlier
> than 2.36. It makes most sense to have a minimum LD version as
> a dependency for HAVE_LD_DEAD_CODE_DATA_ELIMINATION and eliminate
> the impact of ".reloc  .text, R_ARM_NONE, ." when
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled.
>
> Fixes: ed0f94102251 ("ARM: 9404/1: arm32: enable 
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION")
> Reported-by: Harith George <mail2hgg@gmail.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> Link: 
> https://lore.kernel.org/all/14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com/

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

