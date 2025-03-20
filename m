Return-Path: <linux-kernel+bounces-569585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B09BA6A4F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B87418993BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C021638D;
	Thu, 20 Mar 2025 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P9K6ugwT"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A1189F36
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470329; cv=none; b=aKKk8FIzP/NZSdRLfI86fMjhfrwqLtPJrc+K6PAb/oOnV3ldggL//8bKBY0ITq9FPQJudpdxOfLWeeW40PBBC+0hWxtYM8piyVTDYPaDTr1FEpFbTtWvlyT7VpbZ2e3xPz7aPBLNd+c+gs9gOM83Qzt6WyjNoUOee00jPpoMgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470329; c=relaxed/simple;
	bh=bIWxxHLaEUs7nKR8UquB5Bxi4qsYCUmHqTaYzR326DA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aZ4wr/9IC60PDuu/fyoPgDAzU02jVmpYGycfHqWnq8CVk2AxlfFm33TJyK80a3qTuUmd9IHkX5Ef8xmMk4TujIavlo3L+U7O+Ip2e8vaD0UpLdR2RaU04Q7+Y7lAkWqlN0P2gGub0dVvqNpn6gbCZ2VZRGdcrPWJLw9qBojGT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P9K6ugwT; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEE7543150;
	Thu, 20 Mar 2025 11:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742470319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWcS7+LaqjyqkZYE4vdWzKlwoH9+A6aKT6QyHshPnaQ=;
	b=P9K6ugwTO5leK8GhtCbUb1gS4TsDUg1MMCfoFYEMUHnzfjo9NOyJgV9vAVd+IfShl0JvLt
	wf8xjXLHDumMs8GFxwFZVkjOxmR3ty7vc4FaqlMFjV6fTVxyqVKHkd7U6dJIdWxeZibCO4
	Sfo/8NByF4Nf0NehnKfkMOPgx+9cv+Chsqu0lWcqAERS3nzkOTXLsaqQsuWGtd+l9dehVh
	g4wNO4Ev3O6h4nTINUUjTppwm+t8UapIREdpcvZJxujPhvODlflgJe2YYDQhm7A750mGSJ
	egj4gHhqdftxnptwAlRt5QXbSyMcFVAIIrR3CfRMqIwITP1+H7/nnz8mLJSwCw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <michael@walle.cc>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  Steam Lin <stlin2@winbond.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/21] mtd: spinand: Use more specific naming for the
 reset op
In-Reply-To: <ba99ef52-0c98-45a9-91e0-4fd205649e00@linaro.org> (Tudor
	Ambarus's message of "Thu, 20 Mar 2025 08:08:50 +0000")
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
	<20250307-winbond-6-14-rc1-octal-v1-1-45c1e074ad74@bootlin.com>
	<9004166e-5535-4024-8114-9fdb217407bb@linaro.org>
	<87v7skrgjl.fsf@bootlin.com>
	<f1111d1b-a111-4171-9467-450d90a14c0a@linaro.org>
	<87iko50vvb.fsf@bootlin.com>
	<ba99ef52-0c98-45a9-91e0-4fd205649e00@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 20 Mar 2025 12:31:55 +0100
Message-ID: <87msdgvsyc.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegvdduleeihfettdfgieevtdffjeeggfefveetudeludekieffhfeiffduvdehffenucffohhmrghinhepfihinhgsohhnugdrtghomhenucfkphepledvrddukeegrdduuddtrdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddutddrfedtpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepshdqkheisehtihdrtghomhdprhgtphhtthhopehprhgrthihuhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhto
 hepmhhitghhrggvlhesfigrlhhlvgdrtggtpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshhtlhhinhdvseifihhnsghonhgurdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com


>>> How do you feel about a OP-An-Bn-Cn-transaction-format,
>>> 	where A, B, C is {1, 2, 4, 8}
>>> 	n is {S, D}
>>> 	transaction format is {0,1,2,3}{A,B,C,...}
>>>
>>> Care must be taken care of at the transaction format, as I see there are
>>> a few, depending on the xSPI profile and protocol mode.
>>=20
>> I must admit I really dislike the transaction format abbreviation because
>
> I'm not in love with the "transaction format" either.
>
>> it is specific to a spec we do not follow and is not explicit. I have a
>> strong preference towards keeping just "An-Bn-Cn", like I did in this
>
> Okay.
>
>> series. If people are in doubt, they can check what is in the op, it is
>> self explanatory. I chose this in the first place because it is more
>> explicit than just "An" which may feel like a cropped
>> acronym. Furthermore, most octal capable datasheets I've looked at seem
>> to use the "An-Bn-Cn" format, even for single opcodes.
>
> So for RESET, WREN, WRDI and other opcodes that don't require address
> and data, are those datasheets referring to these opcodes as 1-1-1 comman=
ds?
> Can you point me to one of these datasheets, please?

All Winbond datasheets use this convention:
https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_B=
rief.pdf
See 7.1.2 Instruction Set Table p.25.

I checked Macronix and Gigadevice datasheets, they simply never "name"
these opcodes clearly.

> In SPI NOR, WREN is just WREN, regardless of the number of lines it is
> sent on, 1, 4, or 8. How would you model it here, 1-0-0, 4-0-0, 8-0-0
> using the same opcode?

I guess, yes.

>> So unless there are strong arguments against, I'd prefer to keep the
>> current formatting. TBH, it is not set in stone and can still evolve
>> later if that's needed.
>
> I find the naming scheme An-Bn-Cn good, I'm arguing that it's not needed
> everywhere, opcode only commands are better off with it, I think.

Ok, I can drop the -0-0 in this case if you prefer.

Thanks,
Miqu=C3=A8l


