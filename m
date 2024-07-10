Return-Path: <linux-kernel+bounces-247795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8118C92D4A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A47E1F22AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F31940B1;
	Wed, 10 Jul 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRbiRA/3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F219149A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623526; cv=none; b=jyZAJneflfrBVkAMgRTZfps4WvmgSCBBoe3BGqLu03mJrogPMduLs3Ygm82jSM1uGCbvGgTqpAiW6FZE9GuqKtGY0yuLJS/v5oRuMIhi7BU45HFfN9F08QNQDMJZVeqq9KnNh0/QEv7RpysTJGtWNkytcd6ZlBzEfL7l9Y6JIZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623526; c=relaxed/simple;
	bh=6HLFABBIzqnkp5fPqmIas3ZO5215/W6jH+WPjQdDzvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sgDsPxHumts/y+WU0e+Y+IBwKW1KrcMSYgh4oWA5yWQMl6J/chVHBYxtf+PwQlWcLZi91c5YE4j62MXlA/KyDRescPNCfqAVfLqNG2GjMolQDGf/azQ+oSrDeDtWOL9cIkmp2R45tTRADYavChNwB0j5yGiewOnnRK7Pr+BmAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRbiRA/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE72C32781;
	Wed, 10 Jul 2024 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720623526;
	bh=6HLFABBIzqnkp5fPqmIas3ZO5215/W6jH+WPjQdDzvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qRbiRA/348fPzZAvDn1adrYXsoEMCL8c2nemBkMhd1GqPcNLbcO/uqv9oqx9oOcpR
	 s90cV1LF052MXuwnKy0UfH9NXtLwLaztCeD+EFL/ZigGe3RaL+8KjR6s/PbS7Hejwv
	 jLBrVKULHVGA6NNu/GUsM4B7x5hQ63XtnRrQAQohrEa7MVhSfhhqrQa1VEhIL/DJdv
	 Js6Te8VSqvdwt3QvbsmUHAv1NyXCbbVNX+NGOu7Pt3LT/1gTMEAjE2tFr26rrmua5a
	 w2Cy+oXWYRWoC6qT/XVl7st6xlhqOZCfxpa830ezQigm68TxJMJoJnvnvzrTR31uQ9
	 OVhTvuG1eqHCg==
From: Pratyush Yadav <pratyush@kernel.org>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: Pratyush Yadav <pratyush@kernel.org>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  "Tudor Ambarus"
 <tudor.ambarus@linaro.org>,  Michael Walle <mwalle@kernel.org>,  "Miquel
 Raynal" <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: sst: Factor out common write operation to
 `sst_nor_write_data()`
In-Reply-To: <5fe0e312-0844-4de7-8096-eae24361c0a4@prolan.hu>
 (=?utf-8?B?IkNzw7Nrw6Fz?=
	Bence"'s message of "Wed, 10 Jul 2024 15:35:38 +0200")
References: <20240710091401.1282824-1-csokas.bence@prolan.hu>
	<mafs07cdto0t9.fsf@kernel.org>
	<5fe0e312-0844-4de7-8096-eae24361c0a4@prolan.hu>
Date: Wed, 10 Jul 2024 16:58:43 +0200
Message-ID: <mafs034ohnvj0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10 2024, Cs=C3=B3k=C3=A1s Bence wrote:

> Hi!
>
> On 7/10/24 15:04, Pratyush Yadav wrote:
>>> Notes:
>>>      RFC: I'm thinking of removing SPINOR_OP_BP in favor of
>>>      SPINOR_OP_PP (they have the same value). SPINOR_OP_PP
>>>      is the "standard" name for the elementary unit-sized
>>>      (1 byte, in the case of NOR) write operation. I find it
>>>      confusing to have two names for the same operation,
>>>      so in a followup I plan to remove the vendor-specific
>>>      name in favor of the standard one.
>> Even though the operations have the same opcode, I see them as different
>> operations. One is a byte program: it can only write one byte at a time.
>> The other is a page program: it can write up to one page (256 bytes
>> usually) at a time.
>> So I would actually find it more confusing if you use page program in a
>> situation where the operation is actually a byte program, and attempting
>> to program the whole page will fail.
>
> Yes, SST engineers took some _unconventional_ steps when designing this
> family... However, there are no 256 byte pages in these chips. You either
> program it one byte at a time, or as a sequence of two byte values. So, i=
n my
> eyes, that makes it a Flash where the page size is 1 byte, and the
> vendor-specific write is something extra added on (and mind you, that's n=
ot a
> page program either, you just feed it an *arbitrary* even number of bytes=
, there
> really are no pages here at all, only erase sectors).

Exactly. Since there are no pages, calling the operation "Page Program"
would be a misnomer, no? Byte Program is a fitting name IMO.

Beyond cosmetic reasons, do you see any need for changing this?
Otherwise, I'd rather avoid the churn on something that is in the gray
zone anyway.

>
>> Not directly related to this patch, but when reviewing this patch I
>> noticed another small improvement you can make. [...]
>> Here, we do a write disable. Then if a one-byte write is needed, do a
>> write enable again, write the data and write disable.
>> Do we really need to toggle write enable between these? If not, it can
>> be simplified to only do the write disable after all bytes have been
>> written.
>
> Honestly, I'm not sure, I was too afraid to touch that part. However, fro=
m the
> datasheet of SST25VF040B I presume that if we did not toggle it, then the=
 Flash
> chip would interpret the 0x02 opcode and its argument as another 2 bytes =
of data
> to write at the end. Byte Program takes exactly 1 argument, so it can be
> followed by another command, but AAI WP goes on until ~CS goes high.

I see. Then let's _not_ fix what isn't broken!

--=20
Regards,
Pratyush Yadav

