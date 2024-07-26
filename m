Return-Path: <linux-kernel+bounces-263305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D893D415
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E8E1F212F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4B517A5AB;
	Fri, 26 Jul 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b="D4WIbyly"
Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430A78C8D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000100; cv=none; b=oA0AfQ/EVDV3KG+e+gN0MGDtseEpczWcgjWY3rDTkth+VFulOLsCdRLPZLKA0PEGys538MgcoAjqRKgchdKgk8gvJ2Kb0UieYlrLhWmgyu0dUYRaCFhxYrbNtkUwTEevOQRdjLLEOHO2x3P7cDDYATtm0bs/Gb8Gl2njs4cZ7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000100; c=relaxed/simple;
	bh=bmMi5yHnwsW2fFWE/gxkcVQjJQqnGm9uv3gPTHjRgf8=;
	h=Subject:To:CC:Message-ID:From:Date:MIME-Version:Content-Type; b=SlDR8qxCnEhIRn5P37P8lXtZGkrVbZ/K9evK6RHkdy0o8ruwCl25T7dpRnk6m8QL60MqYdk9g2MQvOmoup4+VbqfwxX/IXSxHJ6B3i81f9SKVTjnis+Uz8fl2yQCZBGwbO8nQ+lK18Ywko8p3g0d5WFHzkCDniYPq3VI9yMQ2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b=D4WIbyly; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Received: from pps.filterd (m0142705.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QBWklY001214;
	Fri, 26 Jul 2024 12:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	subject:to:cc:message-id:from:date:mime-version:content-type; s=
	email; bh=g8+0gfoqEoGg6mQfZ5bdueD8op4di8h5ccYvqAvglh8=; b=D4WIby
	lyS7bjHNn5EFMthjsWQlhq6HzWodTNu9PqBuGrVfvxqydpT6+VSuILRWwqqa8lAe
	xmnoKNhzyUvcA2g3BflEzOHJIPChrNv+z5m+92XpMVm1jvjyrFOaKotSUWN2/9RL
	zIcWUxKLeMHzSAn+eHkgzOLYY5w89U1FUu9Bvfwz4Hybo4v7jJiTAgoiE6EnbCdx
	LrqzhpCL4s/RL61V+3SgdJpwTjzcoThJ2GghcNEZf/Qg6RN9x3HYqs4cVT6jutwS
	lFXVV/mDnl4Z8T9S7ACE+TVGnNLMsAWJMvi2QmHm5vMBPr9yFDDUxjnBfFVlSKle
	Om8onvToAOsdOsBQ==
Received: from usgdcecpmsgae03.extemr.org ([144.191.128.204])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 40mamrs7h7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 12:12:19 +0000 (GMT)
Received: from usgdcecpmsgap03.emrsn.org (10.16.75.148) by mail.emerson.com
 (10.16.11.129) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Jul
 2024 12:14:01 +0000
Received: from usgdcecpmsgap03.emrsn.org (10.16.75.148) by
 usgdcecpmsgap03.emrsn.org (10.16.75.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Jul 2024 12:10:17 +0000
Received: from (10.19.249.15) by Inetmail.emrsn.net (10.16.75.148) with
 Microsoft SMTP Server id 15.2.1544.11 via Frontend Transport; Fri, 26 Jul
 2024 12:04:47 +0000
Subject: Re: Subject: [PATCH] mtd: spi-nor: add support for MRAM Everspin EM008LXB
To: <mwalle@kernel.org>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Message-ID: <5bb5d445-e54c-48c3-b7f7-c07886af629e@usgdcecpmsgap03.emrsn.org>
From: <claus.fabig@emerson.com>
Date: Fri, 26 Jul 2024 12:04:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: q8reJrA8fB8KUTRYrPhaed-pOv292To8
X-Proofpoint-ORIG-GUID: q8reJrA8fB8KUTRYrPhaed-pOv292To8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260082

> Hi,
Hi Michael, thanks for your response resp. advices and apologies for the late response.
> 
> There is something odd with your mail client, maybe have a look at
> git send-email.
Unfortunately I am only able to send/receive email from my windows machine and 
therefore have some challenges within our company infrastructure.
I still try to find the best way to get the formatting correct.
> 
> Also we usually push back on the MRAM devices and refer the users to
> the at25 driver. But as this doesn't use the NO_ERASE flag.. I'll
> let Tudor and Pratyush decide.
I am aware that using at25 driver works but have the task to integrate that in mtd
since another used MRAM Everspin flash MR25H10 on our board is also accessed 
in that way and already part of the mainline. That will lead to confusion on user side.
> 
> > From: Claus Fabig <claus.fabig@emerson.com>
> > Date: Thu, 18 Jul 2024 09:53:36 +0200
> > Subject: [PATCH] mtd: spi-nor: add support for MRAM Everspin EM008LXB
> >
> > The Everspin EM008LXB MRAM has 8Mb and is populated on a custom
> board
> > using Microchip's PCI12000 spi host controller running on low 30MHz clock.
> > According to Everspin Read Fast (0xb) command below 60MHz is neither
> > specified and nor tested. Test shows that using Read Fast (0xb) will
> > result in reading inconsistent data in this setup but writing is fine, so
> > only supporting Read (0x3) command should be acceptable for the moment.
> 
> This is really odd. Is there an explanation for that? Usually, fast
> read will just add dummy cycles in between. Also the datasheet just
> mentions a "maximum frequency" which actually makes sense. Do the
> dummy cycles for our fast read operation match the number of dummy
> cycles in your device?
> 
Yes, at first I configured the chip with 8 dummy cycles to match with platform
dummy cycles with the result of reading inconsistent data. 
The answer from Everspin product engineering was:
"Read fast has only been tested down to 66 Mhz. If you are only running at 30 Mhz, 
you should be using the Read command instead. Read Fast is designed for Higher 
speed operation". Unfortunately no more explanation.
> > The device is JEDEC compatible (JESD251 and JESD251-1) but not able to
> > provide SFDP information.
> 
> There is no SFDP data for this chip is it? But it has a READ_ID
> command.
For my understanding reading SFDP works with command 0x5A which is not 
supported, reading ID is command 0x9F and supported. I don't understand your point.
Maybe you could give me a hint to better understand.
> 
> > For spec v3.2 refer to www.everspin.com/file/158315/download.
> 
> Please as a "Link:" tag just before your SoB.
Thanks, I will do in the future.
> 
> > Successfully tested according to
> > www.kernel.org/doc/html/latest/driver-api/mtd/spi-nor.html:
> 
> Great thanks, this should go below the "---" line.
Thanks, I will do in the future.
> 
> > cat /sys/bus/spi/devices/spi-EMR5555\:00/spi-nor/partname
> > em008lxb
> >
> > cat /sys/bus/spi/devices/spi-EMR5555\:00/spi-nor/manufacturer
> > everspin
> >
> > cat /sys/kernel/debug/spi-nor/spi-EMR5555\:00/capabilities
> > Supported read modes by the flash
> >  1S-1S-1S
> >   opcode        0x03
> >   mode cycles   0
> >   dummy cycles  0
> >
> > Supported page program modes by the flash
> >  1S-1S-1S
> >   opcode        0x02
> >
> > cat /sys/kernel/debug/spi-nor/spi-EMR5555\:00/params
> > name            em008lxb
> > id              (null)
> > size            1.00 MiB
> > write size      1
> > page size       256
> > address nbytes  3
> > flags           HAS_SR_TB | HAS_16BIT_SR | HAS_4BIT_BP | HAS_SR_BP3_BIT6
> >
> > opcodes
> >  read           0x03
> >   dummy cycles  0
> >  erase          0xd8
> >  program        0x02
> >  8D extension   none
> >
> > protocols
> >  read           1S-1S-1S
> >  write          1S-1S-1S
> >  register       1S-1S-1S
> >
> > erase commands
> >  d8 (1.00 MiB) [0]
> >  c7 (1.00 MiB)
> >
> > sector map
> >  region (in hex)   | erase mask | overlaid
> >  ------------------+------------+----------
> >  00000000-000fffff |     [0   ] | no
> >
> > cat /proc/mtd
> > dev:    size   erasesize  name
> > mtd0: 00020000 00020000 "spi-EMR1010:00"
> > mtd1: 00100000 00100000 "spi-EMR5555:00"
> >
> > mtd_debug info /dev/mtd1
> > mtd.type = MTD_NORFLASH
> > mtd.flags = MTD_CAP_NORFLASH
> > mtd.size = 1048576 (1M)
> > mtd.erasesize = 1048576 (1M)
> > mtd.writesize = 1
> > mtd.oobsize = 0
> > regions = 0
> >
> > dd if=/dev/urandom of=spi_test bs=1M count=1
> > mtd_debug erase /dev/mtd1 0 1048576
> > mtd_debug read /dev/mtd1 0 1048576 spi_read
> > Copied 1048576 bytes from address 0x00000000 in flash to spi_read
> > hexdump spi_read
> > 0000000 ffff ffff ffff ffff ffff ffff ffff ffff
> > *
> > 0100000
> > sha256sum spi_read
> >
> f5fb04aa5b882706b9309e885f19477261336ef76a150c3b4d3489dfac3953
> ec  spi_read
> > mtd_debug write /dev/mtd1 0 1048576 spi_test
> > Copied 1048576 bytes from spi_test to address 0x00000000 in flash
> > mtd_debug read /dev/mtd1 0 1048576 spi_read
> > Copied 1048576 bytes from address 0x00000000 in flash to spi_read
> > sha256sum spi*
> >
> cf9a1f3f4089602d194d67d1a918a574a5ca1d9aa71d391a661818c1f0ee1a
> ab  spi_read
> >
> cf9a1f3f4089602d194d67d1a918a574a5ca1d9aa71d391a661818c1f0ee1a
> ab  spi_test
> >
> > Signed-off-by: claus.fabig@emerson.com
> > ---
> >  drivers/mtd/spi-nor/core.c     | 2 +-
> >  drivers/mtd/spi-nor/everspin.c | 5 +++++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index e0c4efc424f4..95267d9e8b65 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3713,7 +3713,7 @@ static const struct spi_device_id
> spi_nor_dev_ids[] = {
> >  	{ "mr25h256" }, /* 256 Kib, 40 MHz */
> >  	{ "mr25h10" },  /*   1 Mib, 40 MHz */
> >  	{ "mr25h40" },  /*   4 Mib, 40 MHz */
> > -
> > +	{ "em008lxb" }, /*   8 Mib, 133 MHz */
> 
> Nope. No new spi_device_ids. See also below.
> 
> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(spi, spi_nor_dev_ids);
> > diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspin.c
> > index add37104d673..c1f004c39c1c 100644
> > --- a/drivers/mtd/spi-nor/everspin.c
> > +++ b/drivers/mtd/spi-nor/everspin.c
> > @@ -31,6 +31,11 @@ static const struct flash_info everspin_nor_parts[] = {
> >  		.size = SZ_512K,
> >  		.sector_size = SZ_512K,
> >  		.flags = SPI_NOR_NO_ERASE,
> > +	}, {
> > +		.name = "em008lxb",
> 
> Drop the name, but add the corresponding ".id" property. Then, this
> entry will be fetched automatically. In your DT you use the generic
> compatible.
> 
> > +		.size = SZ_1M,
> > +		.sector_size = SZ_1M,
> 
> This is odd. The sector size is 64kB.
> 
> > +		.flags = SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
> SPI_NOR_BP3_SR_BIT6,
> >  	}
> >  };
> >
> 
> -michael
Thanks, Claus

