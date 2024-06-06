Return-Path: <linux-kernel+bounces-204791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C438FF39B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2BC285C9D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D29D1990AB;
	Thu,  6 Jun 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="FPpehQCx"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691F38FB9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694610; cv=none; b=Sftk6JV8gisOEtwOcJZLxk7qebyUO5VJhzyI0otixV+YPU0cFexIrcTwusvOtpDBZP6e4OygXupdUH4YS/nybSs3SqiGmnEbitT7l45iNzWdBi83QNPqcjOhVHk+/NFDMhm8pYfcBBOqJEkGqRCSQv/kMpd/Jaz2kf2/Mwg+IL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694610; c=relaxed/simple;
	bh=9fdDi/VIvNMFcoSPb0vjtLDb1QNbD08nrQuXSB8HujQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MPTXnNcQ2Q2nIO/D6Kk0rZ7qlab8ip6ze80CEICh0A65a5YOhREKRB406k0Cwvr+16BMVy0Wq3J+lmL5/CcHgtnfa4djDqUbcUFH6G4/R65694aa7UBGsB5bFkzZuC72RDRasA4NPpCNWogE/00Csx1T1Qrz6DJ1Nkui+Yl6UNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=FPpehQCx; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FedF7oPNdqEHHuz3xwLH/2qCzL60HSgGzIWdOOictbg=; b=FPpehQCxUOysukHnwgSo9tnbW9
	BCihYTPtfMSlFzboPjZijiIEGyz+GdYfLd/HrMnHchxFF/4hVPywBldgzxXt/ktfM1ZAoE3FI+Kzw
	XmPkaIqI25ncKL6rVy2/wvF4f9W0XQqWOyu1bKY51xnVcFlEdS9cMP+lzaeS2cg3fV35y/LuWi1hu
	9qPudxhAouqNt4/5qHMDrPWf9YHMrLIlU28EdRXbimH1Tbt2BinGwqO8ERIQCEuzKUqxrqgRZ2MVZ
	PDyNHA7KJ0uKIZFKepEtLmYIJui+Z5sRhT0QSUaTcKAuzTzqW/gP80mHyPJfOKZ/EgOxzJASGIY/b
	Sz+UKIwQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sFGpl-0002rG-Mz; Thu, 06 Jun 2024 19:23:26 +0200
Received: from [80.62.117.184] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sFGph-000MWE-31;
	Thu, 06 Jun 2024 19:23:25 +0200
From: Esben Haabendal <esben@geanix.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,  Rasmus
 Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: macronix: enable quad/dual speed
 for mx25l3205d chips
In-Reply-To: <cdd6bc25-6282-4e43-9909-16ab918ed983@linaro.org> (Tudor
	Ambarus's message of "Thu, 6 Jun 2024 14:33:16 +0100")
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
	<20240603-macronix-mx25l3205d-fixups-v2-2-ff98da26835c@geanix.com>
	<cdd6bc25-6282-4e43-9909-16ab918ed983@linaro.org>
Date: Thu, 06 Jun 2024 19:23:25 +0200
Message-ID: <87v82m9e9e.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27298/Thu Jun  6 10:30:08 2024)

Tudor Ambarus <tudor.ambarus@linaro.org> writes:

> On 6/3/24 14:09, Esben Haabendal wrote:
>> Macronix engineers apparantly do not understand the purpose of having
>> an ID actually identify the chip and its capabilities. Sigh.
>> 
>> The original Macronix SPI NOR flash that identifies itself as 0xC22016
>> with RDID was MX25L3205D. This chip does not support SFDP, but does
>> support the 2READ command (1-2-2).
>> 
>> When Macronix announced EoL for MX25L3205D, the recommended
>> replacement part was MX25L3206E, which conveniently also identifies
>> itself as 0xC22016. It does not support 2READ, but supports DREAD
>> (1-1-2) instead, and supports SFDP for discovering this.
>> 
>> When Macronix announced EoL for MX25L3206E, the recommended
>> replacement part was MX25L3233F, which also identifies itself as
>> 0xC22016. It supports DREAD, 2READ, and the quad modes QREAD (1-1-4)
>> and 4READ (1-4-4). This also support SFDP.
>> 
>> So far, all of these chips have been handled the same way by the Linux
>> driver. The SFDP information have not been read, and no dual and quad
>> read modes have been enabled.
>> 
>> The trouble begins when we want to enable the faster read modes. The
>> RDID command only return the same 3 bytes for all 3 chips, so that
>> doesn't really help.
>> 
>> Instead, we can use the SPI_NOR_TRY_SFDP flag, which forces the spi-nor
>> system to try using SFDP, but fallback to the parameters specified in
>> struct flash_info.
>> 
>> This way, boards using MX25L3205D will continue as before this change.
>> That is without taking advantage of the 1-2-2 that it supports.
>> 
>> For MX25L3206E and MX25L3233F, the SFDP parameters are used, and they will
>> therefore be using the optimal dual or quad mode supported by the flash
>> and the SPI controller it is attached to.
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/mtd/spi-nor/macronix.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
>> index ea6be95e75a5..090f28e05a5d 100644
>> --- a/drivers/mtd/spi-nor/macronix.c
>> +++ b/drivers/mtd/spi-nor/macronix.c
>> @@ -61,7 +61,7 @@ static const struct flash_info macronix_nor_parts[] = {
>>  		.id = SNOR_ID(0xc2, 0x20, 0x16),
>>  		.name = "mx25l3205d",
>>  		.size = SZ_4M,
>> -		.no_sfdp_flags = SECT_4K,
>> +		.no_sfdp_flags = SECT_4K | SPI_NOR_TRY_SFDP,
>>  	}, {
>
> let's remove support for MX25L3205D. You'll then be able to drop the
> flash entry altogether and instead rely on SFDP to discover the flash's
> capabilities.

So anybody updating their Linux kernel for boards using MX25L3205D will
get a bad surprise? While in the embedded world, upgrading Linux kernel
is not the common case, it doesn't seem right to knowingly make it
difficult to those few who actually tries to do the right thing.

/Esben

