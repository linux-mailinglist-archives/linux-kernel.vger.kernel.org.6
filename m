Return-Path: <linux-kernel+bounces-541886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D73EA4C2E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF8E3A51A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01592135BB;
	Mon,  3 Mar 2025 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="mtBilBuP"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24569212FBC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011043; cv=none; b=KBu/MxBRP3lfct6kKqbPFtB2DIbggeiMEDrljODv8Kn1Q73cu/hNri7/V8TJOhGBZAB4hXdNFI4EvEyHdB3boPKGdb0kdo9xPU/stbkSC+H658djq6bt/5ChZAzia+5ylBvWo+8eERPtsro+zD/HTQqxrYX88JdmoOVaBpfnWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011043; c=relaxed/simple;
	bh=7SKQpx9L0mDryeMBd5/7MLfmRiaAKjLbl91XeEq0Yrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAf2uZJcLf1Mt8AE8By0LhoazRuov0zIN40D15PHjEdBt1Siyb25q2TFUzvreoprHZNdkhrgmb6zZGUPBiOhdWBvpKtXhrt/uYuW3EO7ay1EDmnVh44YETmmhY4Bu0KdDqyrHx8Zhe+5DtOzSlJ1llzpjRJ60B2LGKxM3iyEzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=mtBilBuP; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-855b2a5ad32so150352739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1741011040; x=1741615840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrwhJR5XVjeuOKMty1HTRitd46iSfsnGbIHub1a6zjU=;
        b=mtBilBuPCSjtlExPj7kVVK/+ooaiH7eMrY4OEfgSfrko3r9clRXPLCSwV7RHBNHtT6
         R+fcm5fQYIaK+qJwbJ7N6vFrarxR2pJZKpRc/HHVT2reeXtalTFLe6axyLRUxS4Pmu6R
         Yah3UENiY8jYeM8RIkRAffS7796SX+lwWNhi6t7dZ8xBG4BCht2SAWREHZZgwsruS3yy
         0ZQHMslx6T1hG0CYLa9nt3i8DILIFxSDuJQm0Jdh8BFZzuQSvj5QlBReCh9bOoL7zCrS
         jgtiJ6Jg1KrGXQ4CwN0OG8M6oQtYilxpDENCS3ZoyoKQLWhdY+iCvgkghkckCF4YSBeC
         6RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741011040; x=1741615840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrwhJR5XVjeuOKMty1HTRitd46iSfsnGbIHub1a6zjU=;
        b=RWpUG2P9yWyNO7oyEyd2G17zrSBFGOR5N+WTD9lBLs4yX+bg1oadFWP5faq6zIFeUb
         j6X8REZVqH+C+WFfLhzhH8nombkR0FG+XTHrmd4GmO/+HCz3CsLn+PiUl+Yrf8Adxf9H
         gKfB+qNYJGfGKhT9PXioNX+28VlGYX8SzPB8G+tMknVx45HlGhvhUO+cKdeVmsmaj6bF
         qzb/dYnmDZ1U/6FC934lqZj6yIETmdVSRmJpN1z/Kwj11GnX3i3IV/p6TWdtCBThVWjl
         n0nwYJe5NiX8Bbuggpp/xDCeJ1G4jlDVNNCZqcebMjzRd/C90NvC0JnN7Mt9SSylhGNT
         +rrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgD8xF3amPv26py0LbmrSI2V++JGIbpdnFfavYQE3yng0jjLg2k4AszU8mvmZwqE9deE7ZSjEYy34+tK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4xQlwPbaibH/3qfI3nI5P8aS8WPKG5tZRSf5Runs1wu5fRi/
	ZbBNe/R5Hg3vPQSG7hoIKuPKo+Dus18H3iVzveHEDmBwkm2WfzkutwujH4FAk+0=
X-Gm-Gg: ASbGncuAWZN5EhpyEjp+469szZUFfXT7wZHe2EUM1unJ4U6r56aqUvwWPPdDNpGS3wj
	pzwX381sfwYX82KYpUPBcUpreD/uSGlsOSxg2ZfGSKKp4nhZUCu3gJDWj3WZt5l8DoTQo6nmL0o
	IvwhH4v08GxIHveAIB0WBQIvzBcRROPKZNrttU0EJi7ctN0+Ja10xRiUfH88F5BpbZTdrkDpVoI
	OMG8mn/Lha+DNxl9zLbFaJx0PUMoLUHnFiM4mK2Olwc6KRmsk1XstFPCZc+kWuPl/Hjn34BUtSS
	zCZbqR7txgpZf8ZjidbmVknT6QyYuNFHxjMclorbIlSrmR9cK3kPAXpn8PJMN0YfCLFk4bpnjg2
	Cws8V+XoM
X-Google-Smtp-Source: AGHT+IGN/6Wuw5ntiwHBSo1Y/sRm+1DKl1diOGW2BTS+FWQlOXMwdhDgI7em04WI3UtWDvgvTpPB4g==
X-Received: by 2002:a05:6602:1604:b0:855:690e:ed8f with SMTP id ca18e2360f4ac-85881ff0edfmr1228718139f.12.1741011039763;
        Mon, 03 Mar 2025 06:10:39 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f09d8cb493sm382508173.75.2025.03.03.06.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:10:39 -0800 (PST)
Message-ID: <d9db0821-1cb8-43bc-81d3-d511ee164e91@riscstar.com>
Date: Mon, 3 Mar 2025 08:10:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] clk: spacemit: Add clock support for Spacemit K1
 SoC
To: Haylen Chu <heylenay@4d2.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Haylen Chu <heylenay@outlook.com>,
 Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Inochi Amaoto <inochiama@outlook.com>, Chen Wang <unicornxdotw@foxmail.com>,
 Guodong Xu <guodong@riscstar.com>
References: <20250103215636.19967-2-heylenay@4d2.org>
 <20250103215636.19967-5-heylenay@4d2.org>
 <f8b30551-25e7-4626-8c03-6d8807041d8a@riscstar.com>
 <Z8V5OjQTxVeRLAOU@ketchup>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <Z8V5OjQTxVeRLAOU@ketchup>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/25 3:41 AM, Haylen Chu wrote:
> On Thu, Feb 13, 2025 at 10:04:10PM -0600, Alex Elder wrote:
>> On 1/3/25 3:56 PM, Haylen Chu wrote:
>>> The clock tree of K1 SoC contains three main types of clock hardware
>>> (PLL/DDN/MIX) and is managed by several independent controllers in
>>> different SoC parts (APBC, APBS and etc.), thus different compatible
>>> strings are added to distinguish them.
>>>
>>> Some controllers may share IO region with reset controller and other low
>>> speed peripherals like watchdog, so all register operations are done
>>> through regmap to avoid competition.
>>>
>>> Signed-off-by: Haylen Chu <heylenay@4d2.org>
>>
>> This is a really big patch (over 3000 lines), and a fairly large
>> amount of code to review.  But I've given it a really thorough
>> read and I have a *lot* of review comments for you to consider.
>>
>> First, a few top-level comments.
>> - This driver is very comprehensive.  It represents essentially
>>    *all* of the clocks in the tree diagram shown here:
>> https://developer.spacemit.com/resource/file/images?fileName=DkWGb4ed7oAziVxE6PIcbjTLnpd.png
>>    (I can tell you what's missing but I don't think it matters.)
>> - In almost all cases, the names of the clocks match the names
>>    shown in that diagram, which is very helpful.
>> - All of the clocks are implemented using "custom" clock
>>    implementations.  I'm fairly certain that almost all of
>>    them can use standard clock framework types instead
>>    (fixed-rate, fixed-factor, fractional-divider, mux, and
>>    composite).  But for now I think there are other things
>>    more important to improve.
>> - A great deal of my commentary below is simply saying that the
>>    code is more complex than necessary.  Some simple (though
>>    widespread) refactoring would improve things a lot.  And
>>    some of the definitions can be done without having to
>>    specify nearly so many values.
>> - Much of what might be considered generality in the
>>    implementation actually isn't needed, because it isn't used.
>>    This is especially true given that there are essentially no
>>    clocks left unspecified for the K1 SoC.
>> - Once the refactoring I suggest has been done, I expect
>>    that more opportunities for simplification and cleanup will
>>    become obvious; we'll see.
>> - I suggest these changes because the resulting simplicity
>>    will make the code much more understandable and maintainable
>>    in the long term.  And if it's simpler to understand, it
>>    should be easier for a maintainer to accept.
>>
>> I'm not going to comment on the things related to Device Tree
>> that have already been mentioned, nor on the Makefile or Kconfig,
>> etc.  I'm focusing just on the code.
>>
>>> ---
>>>    drivers/clk/Kconfig               |    1 +
>>>    drivers/clk/Makefile              |    1 +
>>>    drivers/clk/spacemit/Kconfig      |   20 +
>>>    drivers/clk/spacemit/Makefile     |    5 +
>>>    drivers/clk/spacemit/ccu-k1.c     | 1747 +++++++++++++++++++++++++++++
>>>    drivers/clk/spacemit/ccu_common.h |   51 +
>>>    drivers/clk/spacemit/ccu_ddn.c    |  140 +++
>>>    drivers/clk/spacemit/ccu_ddn.h    |   84 ++
>>>    drivers/clk/spacemit/ccu_mix.c    |  304 +++++
>>>    drivers/clk/spacemit/ccu_mix.h    |  309 +++++
>>>    drivers/clk/spacemit/ccu_pll.c    |  189 ++++
>>>    drivers/clk/spacemit/ccu_pll.h    |   80 ++
>>>    12 files changed, 2931 insertions(+)
>>>    create mode 100644 drivers/clk/spacemit/Kconfig
>>>    create mode 100644 drivers/clk/spacemit/Makefile
>>>    create mode 100644 drivers/clk/spacemit/ccu-k1.c
>>>    create mode 100644 drivers/clk/spacemit/ccu_common.h
>>>    create mode 100644 drivers/clk/spacemit/ccu_ddn.c
>>>    create mode 100644 drivers/clk/spacemit/ccu_ddn.h
>>>    create mode 100644 drivers/clk/spacemit/ccu_mix.c
>>>    create mode 100644 drivers/clk/spacemit/ccu_mix.h
>>>    create mode 100644 drivers/clk/spacemit/ccu_pll.c
>>>    create mode 100644 drivers/clk/spacemit/ccu_pll.h
>>>
> 
> ...
> 
>>> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
>>> new file mode 100644
>>> index 000000000000..6fb0a12ec261
>>> --- /dev/null
>>> +++ b/drivers/clk/spacemit/ccu-k1.c
> 
> ...
> 
>> The next set of clocks differ from essentially all others, in that
>> they don't encode their frequency in the name.  I.e., I would expect
>> the first one to be named pll1_d2_1228p8.
> 
> I found this change may not be possible: with the frequency appended,
> their names conflict with another set of MPMU gates.

OK, that's fine, and perhaps is why it was done this way.  Thanks
for checking.   I look forward to the next version of the series.

					-Alex

> 
>>
>>> +static CCU_GATE_FACTOR_DEFINE(pll1_d2, "pll1_d2", CCU_PARENT_HW(pll1),
>>> +			      APB_SPARE2_REG,
>>> +			      BIT(1), BIT(1), 0, 2, 1, 0);
>>> +static CCU_GATE_FACTOR_DEFINE(pll1_d3, "pll1_d3", CCU_PARENT_HW(pll1),
>>> +			      APB_SPARE2_REG,
>>> +			      BIT(2), BIT(2), 0, 3, 1, 0);
>>> +static CCU_GATE_FACTOR_DEFINE(pll1_d4, "pll1_d4", CCU_PARENT_HW(pll1),
>>> +			      APB_SPARE2_REG,
>>> +			      BIT(3), BIT(3), 0, 4, 1, 0);
>>> +static CCU_GATE_FACTOR_DEFINE(pll1_d5, "pll1_d5", CCU_PARENT_HW(pll1),
>>> +			      APB_SPARE2_REG,
>>> +			      BIT(4), BIT(4), 0, 5, 1, 0);
>>> +static CCU_GATE_FACTOR_DEFINE(pll1_d6, "pll1_d6", CCU_PARENT_HW(pll1),
>>> +			      APB_SPARE2_REG,
>>> +			      BIT(5), BIT(5), 0, 6, 1, 0);
>>> +static CCU_GATE_FACTOR_DEFINE(pll1_d7, "pll1_d7", CCU_PARENT_HW(pll1),
>>> +			      APB_SPARE2_REG,
>>> +			      BIT(6), BIT(6), 0, 7, 1, 0);
>>> +static CCU_GATE_FACTOR_DEFINE(pll1_d8, "pll1_d8", CCU_PARENT_HW(pll1),
>>> +			      APB_SPARE2_REG,
>>> +			      BIT(7), BIT(7), 0, 8, 1, 0);
>>> +
> 
> ...
> 
>>> +/*	MPMU clocks start	*/
> 
> ...
> 
>>> +static CCU_GATE_DEFINE(pll1_d3_819p2, "pll1_d3_819p2", CCU_PARENT_HW(pll1_d3),
>>> +		       MPMU_ACGR,
>>> +		       BIT(14), BIT(14), 0, 0);
>>> +
>>> +static CCU_GATE_DEFINE(pll1_d2_1228p8, "pll1_d2_1228p8", CCU_PARENT_HW(pll1_d2),
>>> +		       MPMU_ACGR,
>>> +		       BIT(16), BIT(16), 0, 0);
> 
> Here're the conflicts.
> 
> Although they don't happen on all the clocks, I prefer to keep the clock
> names as is for now to keep the consistency.
> 
> Thanks,
> Haylen Chu


