Return-Path: <linux-kernel+bounces-321579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9A2971C44
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5FF284526
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857011BA26F;
	Mon,  9 Sep 2024 14:17:29 +0000 (UTC)
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6101F942;
	Mon,  9 Sep 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891449; cv=none; b=M3lvWJkJg8p3ZbTpCOwGTYwFScBd6meI+2Jpi/1EGMOUBxzj8DZtkbrRsIWVXevoZ+yZOfYbGfMS5WsxMya/zKiiRpuy2NDE409xXp+wTESvkAZXT5cMATEmWokwdDWRlKKiRjikewmfqYkGZqaM3g9q3GIz68655SVk778uYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891449; c=relaxed/simple;
	bh=lrXpZWxMJMtBvHEtOnh0l+dSZpM73JGQiIsvvw50KPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEM3gZDHCDCa1giBBdn6jj/uQva7dHqeew9LJkEh6DAHrmWW5wpjVr9PnlxDmS/Oa/I8Je9JJetc8u1qFjSDGLSIM0A+XuVwCEyk6pkDhiAhLWKJLOYaiei6LWe4NaVVpc0gdheI7eoNol3i1FyHdz2RX8ClJlHvW4Z35sCh2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.108] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <adiupina@astralinux.ru>)
	id 1snfBQ-00BL95-1B; Mon, 09 Sep 2024 17:16:00 +0300
Received: from [10.198.22.196] (unknown [10.198.22.196])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4X2TRn2MdVz1gxcY;
	Mon,  9 Sep 2024 17:17:09 +0300 (MSK)
Message-ID: <6a563471-2268-40a3-9c95-2761bcea5e3c@astralinux.ru>
Date: Mon, 9 Sep 2024 17:17:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] clk: mvebu: Prevent division by zero in
 clk_double_div_recalc_rate()
Content-Language: ru
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240909133807.19403-1-adiupina@astralinux.ru>
 <e2d1e181-f094-4d6d-b77e-8d7c0ecd8270@lunn.ch>
From: Alexandra Diupina <adiupina@astralinux.ru>
In-Reply-To: <e2d1e181-f094-4d6d-b77e-8d7c0ecd8270@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehlvgigrghnughrrgcuffhiuhhpihhnrgcuoegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepveefleetjeetfffgleeuvedujeffieffgedttdegudejheetfeeikeffueefgffgnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepuddtrdduleekrddvvddrudelieenucfrrghrrghmpehhvghloheplgdutddrudelkedrvddvrdduleeingdpihhnvghtpedutddrudelkedrvddvrdduleeimeefgeeggedtpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeelpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsvggsrghsthhirghnrdhhvghsshgvlhgsrghrthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehssghohigusehkvghrnhgvlh
 drohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgtlhhksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgnecuffhrrdghvggsucetnhhtihhsphgrmhemucenucfvrghgshem
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1725884359#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12165719, Updated: 2024-Sep-09 12:19:23 UTC]

Hello, Andrew!


09/09/24 17:02, Andrew Lunn пишет:
> On Mon, Sep 09, 2024 at 04:38:07PM +0300, Alexandra Diupina wrote:
>> get_div() may return zero, so it is necessary to check
>> before calling DIV_ROUND_UP_ULL().
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 8ca4746a78ab ("clk: mvebu: Add the peripheral clock driver for Armada 3700")
>> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
>> ---
>>   drivers/clk/mvebu/armada-37xx-periph.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
>> index 8701a58a5804..d0e1d591e4f2 100644
>> --- a/drivers/clk/mvebu/armada-37xx-periph.c
>> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
>> @@ -343,7 +343,10 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
>>   	div = get_div(double_div->reg1, double_div->shift1);
>>   	div *= get_div(double_div->reg2, double_div->shift2);
>>   
>> -	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
>> +	if (!div)
>> +		return 0;
> Looking at this code, it seems to me some fundamental assumption has
> gone wrong here, if the dividers are 0. We want to know about this,
> and a kernel taking a / 0 exception would be a good way to indicate
> something is very wrong. Won't returning 0 just hide the problem, not
> make it obvious?
>
> Checking for a /0 on user input makes a lot of sense, but here, i
> think you are just hiding bugs. Please consider this when making
> similar changes in other parts of the kernel. Why has a /0 happened?
>
> Tools like SVACE just point at possible problems. You then need to
> look at them in detail, understand the context, and decide on the
> proper fix, which might actually be, a /0 is good.
>
> 	Andrew

The value of div depends on double_div->reg1, double_div->reg2,
double_div->shift1, double_div->shift2.
The fields reg1, reg2, shift1, shift2 in the clk_double_div structure
are filled using the PERIPH_DOUBLEDIV macro, which is called from the
PERIPH_CLK_FULL_DD and PERIPH_CLK_MUX_DD macros (the last 4 arguments).

It is not clear what values can be contained in the registers at the
addresses DIV_SEL0, DIV_SEL1, DIV_SEL2 (can readl() and some bit
operations give a value > 6 in get_div()), so the final value of div can 
be zero.

I used just return 0, since the recalc_rate field in the clk_ops structure
has a comment "If the driver cannot figure out a rate for this clock,
it must return 0.". I'll fix it to kernel exception, thanks for the tip.

