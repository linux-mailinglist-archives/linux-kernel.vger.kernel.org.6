Return-Path: <linux-kernel+bounces-568510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F7A69692
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E0E17F64D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE821DF747;
	Wed, 19 Mar 2025 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c4d3vOtx"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB418DF93
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405550; cv=none; b=di4jA2r7tBhvCQ+D6nAp+j1nPSWjPAorRmJwyVz0SHHMDIMPQYAAepSQRlrgLsKxy9cJjoR8lm8IbiroVbsV4Bpf+1RiQZnneRP75W/cqAJKJG4X1wyHBA4linzZL30KspEaOgaTqxCtdct+0xZizzdesDPXxTdpE29QMnk33yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405550; c=relaxed/simple;
	bh=1X9u9KzK0gb6a1C8FSSp6AtPgQJA+sK4ulkRKoFnqbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sy3PLM3NQvqyzsK3UgSK2LC+FYbYwXZSfiWIZTEouAiM+aURzm6NvnmJheHtddLvVUw9XsFlRAHrjTFO+Xzv2/vAvNkFWdGspbgSFoiiQ6z15TTq4++bbta3tVEeD6Dv3jcy6F6vp4AcIpJD+/5fwMnK1QzgC9HNX24RSkaDe4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c4d3vOtx; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0942D443C7;
	Wed, 19 Mar 2025 17:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742405546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5C7I0N55tGNiLgOlLviaVlEZTLMrzLLmEJs0DulmBOY=;
	b=c4d3vOtxZ9r3CFRArLFjw2OSj+8aoBFQg+7+NdkH7Y1E77lORyM5o8oWpCLwMyZVOCu5QG
	NPBnBOpyQ+69GnyIonraYCfPo6gtlQZ+9y2kWwsxeewlV+qYWQZ7LkaD+Non9xwfboxRab
	I52hP3KgFBVY9MeGe5Ry08e1TRNJs3t08p2R1hwSVWy/bkLM3USH0dnKlrs9xiJ9NTopYT
	vfBF6xrXO3ghUVP/N1I7SE5yJKvBMlTsSwEUeRqBraBEJkFPwzm+I9pz6NIsKEEPpSrMVJ
	DpW7k5orHM4lpoS4Q2ef4te5Sg6z5uhd9+89GFYfqRr3iXeD6HOt1jSbA+1WCQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <michael@walle.cc>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  Steam Lin <stlin2@winbond.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/21] mtd: spinand: Use more specific naming for the
 reset op
In-Reply-To: <f1111d1b-a111-4171-9467-450d90a14c0a@linaro.org> (Tudor
	Ambarus's message of "Mon, 10 Mar 2025 12:14:06 +0200")
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
	<20250307-winbond-6-14-rc1-octal-v1-1-45c1e074ad74@bootlin.com>
	<9004166e-5535-4024-8114-9fdb217407bb@linaro.org>
	<87v7skrgjl.fsf@bootlin.com>
	<f1111d1b-a111-4171-9467-450d90a14c0a@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 18:32:24 +0100
Message-ID: <87iko50vvb.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepshdqkheisehtihdrtghomhdprhgtphhtthhopehprhgrthihuhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggtpdhrt
 ghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshhtlhhinhdvseifihhnsghonhgurdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Tudor,

On 10/03/2025 at 12:14:06 +02, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 07.03.2025 17:45, Miquel Raynal wrote:
>> Hi Tudor,
>
> Hi!
>
>>=20
>>>> -#define SPINAND_RESET_OP						\
>>>> +#define SPINAND_RESET_1S_0_0_OP						\
>>> Hi, Miquel,
>>>
>>> Have you seen any reset op with address or data? If not, I'm not really
>>> sure whether we shall change the name for these basic operations.
>>>
>>> Changing them to 1S-0-0 may also indicate that there are resets with
>>> address or data fields, which I find confusing.
>>>
>>> I think the change is good for reads and writes. I'll check further in
>>> the series and let you know.
>>=20
>> I want to rename this macro for two reasons:
>> - We might see in the near future the addition of 8D-0-0 ops (I plan on
>>   working on it).
>> - I would like some kind of harmony among these macros.
>>=20
>> Now, whether is should be named like I proposed or just
>> SPINAND_RESET_OP_1S, I have no strong preference and I can change that
>> in an upcoming version.
>>=20
>> Which one would you prefer?
>
> I don't know. Which one is backed up by a standard?

Well, as far as I know, none of the SPI NAND devices follow a very
specific standard. Most vendors in practice follow similar conventions,
but they all deviate a bit from it.

> JESD216F defines
> "(An-Bn-Cn): Command mode nomenclature used to indicate the number of
> active pins used for the instruction (A), address (B), and data (C), and
> the data rate used for each. Data rates(n) can be single (S) and dual (D)=
."
>
> Also, "(x-y-z) nomenclature is equivalent to(AS-BS-CS) unless otherwise
> noted."
>
> What's an "active pin"?
>
> Then if I look at JESD251-1.01 and JESD251C, (An-Bn-Cn) is referred to
> as "protocol mode". Write Enable, which is just an instruction command
> with no address or data, is seen as a required command in both 4D-4D-4D
> and 8D-8D-8D protocol modes, and it's defined as a "1.A" transaction
> format command. And the transaction format is:
> '''
> The following transaction formats are used in Profile 1.0 mode 8D-8D-8D:
> Format 1.A: Command and Command Extension
> Format 1.B: Command, Command Extension, 4-byte Address, =E2=80=98n=E2=80=
=99 Latency
> Cycles, and Read Data
> Format 1.C: Command, Command Extension, and 4-byte Address
> Format 1.D: Command, Command Extension, 4-byte Address, and Write Data
> '''
>
> So according to these standards maybe we shall refer to it as:
> WREN-8D-8D-8D-1A? This seems less intuitive than 8D-0-0, but I think it
> all depends on what's an "active pin". I think it describes the protocol
> mode, and not what's actually sent on the line. As we saw, WREN is
> considered an 8D-8D-8D command, and not an 8D-0-0 command.
>
> For dual mode, which is not covered by xSPI, I guess we can use the
> single spi transaction formats 0.{A,B,C,...}.
>
> How do you feel about a OP-An-Bn-Cn-transaction-format,
> 	where A, B, C is {1, 2, 4, 8}
> 	n is {S, D}
> 	transaction format is {0,1,2,3}{A,B,C,...}
>
> Care must be taken care of at the transaction format, as I see there are
> a few, depending on the xSPI profile and protocol mode.

I must admit I really dislike the transaction format abbreviation because
it is specific to a spec we do not follow and is not explicit. I have a
strong preference towards keeping just "An-Bn-Cn", like I did in this
series. If people are in doubt, they can check what is in the op, it is
self explanatory. I chose this in the first place because it is more
explicit than just "An" which may feel like a cropped
acronym. Furthermore, most octal capable datasheets I've looked at seem
to use the "An-Bn-Cn" format, even for single opcodes.

So unless there are strong arguments against, I'd prefer to keep the
current formatting. TBH, it is not set in stone and can still evolve
later if that's needed.

Thanks,
Miqu=C3=A8l

