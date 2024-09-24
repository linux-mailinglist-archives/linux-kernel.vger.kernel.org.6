Return-Path: <linux-kernel+bounces-337186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB8498469C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C6B7B23019
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F641A3AB7;
	Tue, 24 Sep 2024 13:15:35 +0000 (UTC)
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A4C1E505;
	Tue, 24 Sep 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727183734; cv=none; b=MQqKfnJzpJiDMDvsIHWhnVLokV8H6jljlA4pjma9sVdlYu/YgXFFMvk1lGFpwfO5alAJ7BRIEwCa59g1MKYLGAAwgUxrpNGMUtIfr4UQ3aX4GsgQt31627spPq6NLSDYtKSV03rvl659ZaUfrp9DPnziow0N6jDlhaYE4QrxlQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727183734; c=relaxed/simple;
	bh=SOwz93M5OOM4wXDqepkCz9ZtA45fzHr7ITDXWtX3T3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0ZmaGj65ich1cUpWno/E/rSl+gpoZDphLzOLSE9pHdV2dt1SKuX5iWQFc4kUZq9JbnCoeIuxqi4i2FX1Z+i382IFaHyP8ChisXMxlrcYxnV1iD8RJhUFywDpnW4fwKffRvFPE5l2Uf/XXpw8u5bUW2bAJCEsYjCFhe1xKPZpc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.108] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <adiupina@astralinux.ru>)
	id 1st5ME-00Ee27-BV; Tue, 24 Sep 2024 16:13:34 +0300
Received: from [10.198.26.104] (unknown [10.198.26.104])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XCgM70ylCz1gxcy;
	Tue, 24 Sep 2024 16:14:59 +0300 (MSK)
Message-ID: <d05d9ebd-f954-482b-878b-9dcb422821a8@astralinux.ru>
Date: Tue, 24 Sep 2024 16:14:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH v3] clk: mvebu: Prevent division by zero in
 clk_double_div_recalc_rate()
Content-Language: ru
To: Stephen Boyd <sboyd@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240917132201.17513-1-adiupina@astralinux.ru>
 <af7dc028ced22413210701a5e2e05990.sboyd@kernel.org>
From: Alexandra Diupina <adiupina@astralinux.ru>
In-Reply-To: <af7dc028ced22413210701a5e2e05990.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehlvgigrghnughrrgcuffhiuhhpihhnrgcuoegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepveefleetjeetfffgleeuvedujeffieffgedttdegudejheetfeeikeffueefgffgnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepuddtrdduleekrddviedruddtgeenucfrrghrrghmpehhvghloheplgdutddrudelkedrvdeirddutdegngdpihhnvghtpedutddrudelkedrvdeirddutdegmeegiedvleekpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeelpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsvggsrghsthhirghnrdhhvghsshgvlhgsrghrthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvg
 drtghomhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgtlhhksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgnecuffhrrdghvggsucetnhhtihhsphgrmhemucenucfvrghgshem
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1727174896#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12181954, Updated: 2024-Sep-24 11:32:51 UTC]

Hi


19/09/24 13:24, Stephen Boyd пишет:
> Quoting Alexandra Diupina (2024-09-17 06:22:01)
>> get_div() may return zero, so it is necessary to check
>> before calling DIV_ROUND_UP_ULL().
>>
>> Return value of get_div() depends on reg1, reg2, shift1, shift2
>> fields of clk_double_div structure which are filled using the
>> PERIPH_DOUBLEDIV macro. This macro is called from the
>> PERIPH_CLK_FULL_DD and PERIPH_CLK_MUX_DD macros (the last 4 arguments).
>>
>> It is not known exactly what values can be contained in the registers
>> at the addresses DIV_SEL0, DIV_SEL1, DIV_SEL2, so the final value of
>> div can be zero. Print an error message and return 0 in this case.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 8ca4746a78ab ("clk: mvebu: Add the peripheral clock driver for Armada 3700")
>> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
>> ---
>> v3: fix indentation
>> v2: added explanations to the commit message and printing
>> of an error message when div==0
> Please stop sending as replies to previous patches.
>
>>   drivers/clk/mvebu/armada-37xx-periph.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
>> index 8701a58a5804..b32c6d4d7ee5 100644
>> --- a/drivers/clk/mvebu/armada-37xx-periph.c
>> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
>> @@ -343,7 +343,12 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
>>          div = get_div(double_div->reg1, double_div->shift1);
>>          div *= get_div(double_div->reg2, double_div->shift2);
>>   
>> -       return DIV_ROUND_UP_ULL((u64)parent_rate, div);
>> +       if (!div) {
>> +               pr_err("Can't recalculate the rate of clock %s\n", hw->init->name);
> hw->init is set to NULL after registration (see clk_register() code). If
> div is 0 what does the hardware do?

Thanks for noticing the error. Yes, hw->init is set to zero,
I will replace that code with clk_hw_get_name(hw).
If the value of div is 0, should I return 0 as stated in the
comment for .recalc_rate (in struct clk_ops) or should I
return parent_rate as in some other similar rate recalculation
functions (in some other drivers)?
>
>> +               return 0;
>> +       } else {
>> +               return DIV_ROUND_UP_ULL((u64)parent_rate, div);
>> +       }
>>   }
>>


