Return-Path: <linux-kernel+bounces-350503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D835990623
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8C91C21828
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B892217901;
	Fri,  4 Oct 2024 14:32:13 +0000 (UTC)
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF452141DB;
	Fri,  4 Oct 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052333; cv=none; b=fblSww+V0R8XXp2jvmC6VkgV6RzFUJ/pZkpyGzPMqrr2HCqQp0D1Lll/z7PG/XtW6QOrrqIHCqJbti4oSw1Ql55zOpqWIYfi1GmES4C0BIQHTyWqzjIIdqJmEVY1bTenKWz6OVyaTirJblW1TrPElEZEd7wPMnohTqKmlN5kJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052333; c=relaxed/simple;
	bh=H4L13hMinSbhFmqrQvfHvDsJehnHyv3AWfzb8bWgRyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVlM+wvZTpfths2GTLJs8kWJu3b2I5Fv0xvDxbVIS1qbbBv6Y89wmfb3Rmt+TY30LzgfF1UHJZo8eO+fhSCWl9ivMlR8YHCN5JDGS/OGMDztH4AsZDM40eIuwpn5A9Jlil2M96W58tSAcXHeCqYxWScrhjxsR/7eY7BphiMqK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.111] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <adiupina@astralinux.ru>)
	id 1swjJh-00HM6a-82; Fri, 04 Oct 2024 17:30:01 +0300
Received: from [10.198.27.192] (unknown [10.198.27.192])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XKrZw5Cdrz1c051;
	Fri,  4 Oct 2024 17:31:36 +0300 (MSK)
Message-ID: <2e33446a-5b02-44aa-be69-376755aaf3eb@astralinux.ru>
Date: Fri, 4 Oct 2024 17:31:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH v4] clk: mvebu: Prevent division by zero in
 clk_double_div_recalc_rate()
Content-Language: ru
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240930104934.4342-1-adiupina@astralinux.ru>
From: Alexandra Diupina <adiupina@astralinux.ru>
In-Reply-To: <20240930104934.4342-1-adiupina@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehlvgigrghnughrrgcuffhiuhhpihhnrgcuoegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepveefleetjeetfffgleeuvedujeffieffgedttdegudejheetfeeikeffueefgffgnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepuddtrdduleekrddvjedrudelvdenucfrrghrrghmpehhvghloheplgdutddrudelkedrvdejrdduledvngdpihhnvghtpedutddrudelkedrvdejrdduledvmeehfedtheeipdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeelpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsvggsrghsthhirghnrdhhvghsshgvlhgsrghrthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehssghohigusehkvghrnhgvlh
 drohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgtlhhksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgnecuffhrrdghvggsucetnhhtihhsphgrmhemucenucfvrghgshem
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1728047265#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12194451, Updated: 2024-Oct-04 13:07:03 UTC]

just a friendly reminder


30/09/24 13:49, Alexandra Diupina пишет:
> get_div() may return zero, so it is necessary to check
> before calling DIV_ROUND_UP_ULL().
>
> Return value of get_div() depends on reg1, reg2, shift1, shift2
> fields of clk_double_div structure which are filled using the
> PERIPH_DOUBLEDIV macro. This macro is called from the
> PERIPH_CLK_FULL_DD and PERIPH_CLK_MUX_DD macros (the last 4 arguments).
>
> It is not known exactly what values can be contained in the registers
> at the addresses DIV_SEL0, DIV_SEL1, DIV_SEL2, so the final value of
> div can be zero. Print an error message and return 0 in this case.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 8ca4746a78ab ("clk: mvebu: Add the peripheral clock driver for Armada 3700")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
> v4: replace hw->init->name with clk_hw_get_name(hw)
> v3: fix indentation
> v2: added explanations to the commit message and printing
> of an error message when div==0
>   drivers/clk/mvebu/armada-37xx-periph.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index 13906e31bef8..2f0145a76f22 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -343,7 +343,12 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
>   	div = get_div(double_div->reg1, double_div->shift1);
>   	div *= get_div(double_div->reg2, double_div->shift2);
>   
> -	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
> +	if (!div) {
> +		pr_err("Can't recalculate the rate of clock %s\n", clk_hw_get_name(hw));
> +		return 0;
> +	} else {
> +		return DIV_ROUND_UP_ULL((u64)parent_rate, div);
> +	}
>   }
>   
>   static const struct clk_ops clk_double_div_ops = {


