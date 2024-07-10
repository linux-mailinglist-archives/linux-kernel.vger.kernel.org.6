Return-Path: <linux-kernel+bounces-247679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A50B92D2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CC91C219AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258D0192B71;
	Wed, 10 Jul 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="iPEZVz/a"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2C12C530
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618547; cv=none; b=a/DR6EPtBR/rXmta/Co92rRPPQUXaNxyQqrNfQM5TbLQSD79IAXXleWsqcvTBSjRWOWYsjHRhwNHS8hDI3RLg4okG/urjSTVDtU00VrmsKGtToMW3d0nUhcNNUkZ4FR0iuQoN9TLI7mNv6K1fFVO97uWg65MPe8EMnGvj8PwW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618547; c=relaxed/simple;
	bh=alfaPAnYlwGLuTXIQSUbSYcOGGMHFgocc2kkQdoI5Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O4HHPhC+N6F60PHMAMUT4DbmLZ2ubM6AN07lwAKbaCBZbIjhKW+2gY50SVcbPqVgbzCPnQkrsBBP+0XEly8KGAxSa++5Xu0xK29RXRf9ct9AF8EROM7lDbXUlv5or4qPVCXkEm7TGo8xbrLzLTsuubkZfUtQMZ88ckkMosz6jfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=iPEZVz/a; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5D155A0E1D;
	Wed, 10 Jul 2024 15:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ONej5SCahqjBap2i9K2K
	IncrdXGPjQBpSHbxrdrxP3Y=; b=iPEZVz/abMEJGGpAe6Cuv2vorbbtMmrBp8Vq
	V6jMk82ycMpNG/QzGCJ/MIiHcK1UICR5RQZHPWAsn3ABoRY99uk3ZN2uukhSbZ76
	d7bae7RjviGwkja4TEHc09HO3hWp2X/YnVlSLdqFus5gc7U06pB+usOBuKxv66UM
	Ke7jKQFBYIEwJMeKZSYd7BWKNsgKnrXx5L7RmkJtwY6/qE3vqoBnMKO6yix5VE7I
	hExaoLUwScjgBMlIrvdUw8RfL3yr5cW4VZGR4mcKAO5QSkSZUI+SYUwIoucc5K7W
	/UEH6w+BZLLcrDDyC6QUhjSpyfSSdBdPaPYu2UzVcLj+pSBgmsrp0g/He6WOTUJ9
	mlP0CzCYLK27cxfxyjDWvPx/weAT7ybCg3Mq+QmtY6IdrngTBKy3ZUPKUkV/Tjpf
	RgPMF7WsjydUSxWIgMBINSxweCzG3a6AJ/IVBHbfCD0ttNeCr/kP80tWQ54E7PTn
	8bvGx9Q9B+PsW4GO38yfNsvVtAtWSlJrpiWRlg5T26MSwLImnrIjcX/uKHv5xTqX
	0+hSANTZZaUXd3QKjF9PTNHkkmrNdcUG0+vgCSN1rOCs4vX22CI44eatTBfyo2ig
	w8bH9oFJ9gSseG3BKJsQc4Kd7hInM2W1t6gTKFLQ+B/8m8+nZAJ7kOfhERHiIIO7
	Hb8MCGY=
Message-ID: <5fe0e312-0844-4de7-8096-eae24361c0a4@prolan.hu>
Date: Wed, 10 Jul 2024 15:35:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: sst: Factor out common write operation to
 `sst_nor_write_data()`
To: Pratyush Yadav <pratyush@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Tudor
 Ambarus" <tudor.ambarus@linaro.org>, Michael Walle <mwalle@kernel.org>,
	"Miquel Raynal" <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240710091401.1282824-1-csokas.bence@prolan.hu>
 <mafs07cdto0t9.fsf@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <mafs07cdto0t9.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94854647461

Hi!

On 7/10/24 15:04, Pratyush Yadav wrote:
>> Notes:
>>      RFC: I'm thinking of removing SPINOR_OP_BP in favor of
>>      SPINOR_OP_PP (they have the same value). SPINOR_OP_PP
>>      is the "standard" name for the elementary unit-sized
>>      (1 byte, in the case of NOR) write operation. I find it
>>      confusing to have two names for the same operation,
>>      so in a followup I plan to remove the vendor-specific
>>      name in favor of the standard one.
> 
> Even though the operations have the same opcode, I see them as different
> operations. One is a byte program: it can only write one byte at a time.
> The other is a page program: it can write up to one page (256 bytes
> usually) at a time.
> 
> So I would actually find it more confusing if you use page program in a
> situation where the operation is actually a byte program, and attempting
> to program the whole page will fail.

Yes, SST engineers took some _unconventional_ steps when designing this 
family... However, there are no 256 byte pages in these chips. You 
either program it one byte at a time, or as a sequence of two byte 
values. So, in my eyes, that makes it a Flash where the page size is 1 
byte, and the vendor-specific write is something extra added on (and 
mind you, that's not a page program either, you just feed it an 
*arbitrary* even number of bytes, there really are no pages here at all, 
only erase sectors).

> Not directly related to this patch, but when reviewing this patch I
> noticed another small improvement you can make. [...]
> Here, we do a write disable. Then if a one-byte write is needed, do a
> write enable again, write the data and write disable.
> 
> Do we really need to toggle write enable between these? If not, it can
> be simplified to only do the write disable after all bytes have been
> written.

Honestly, I'm not sure, I was too afraid to touch that part. However, 
from the datasheet of SST25VF040B I presume that if we did not toggle 
it, then the Flash chip would interpret the 0x02 opcode and its argument 
as another 2 bytes of data to write at the end. Byte Program takes 
exactly 1 argument, so it can be followed by another command, but AAI WP 
goes on until ~CS goes high.

 > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Thanks!

Bence


