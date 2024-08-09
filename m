Return-Path: <linux-kernel+bounces-280947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7382194D13F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AE61C225A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A868E194C7A;
	Fri,  9 Aug 2024 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b="Q/ovBOp8"
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE11E86F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210161; cv=none; b=P69Fj+/rm39vdmFGDO+LlpWWD6bgEjAQmlssg3NBb6k44NzK9C8GZ8oA17PLTN5zumLamxj0UCSj1rSjFzP7lSQlkrbatDTDmqEueEjW0zbWUTymT7Zbt+8uz4//fP0HUXxFRpZX4q2okrFAWSEq7UbiDhWDg+DtSdqe8QsfVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210161; c=relaxed/simple;
	bh=jeBxFV67hp0FgsHTvPUscsVtasWz+IcOSf8lNgbbrHM=;
	h=Subject:To:CC:Message-ID:From:Date:MIME-Version:Content-Type; b=lyDrXD4JuzEeAeRMsD3xTLKtvSFFQp14ZUiVjwxDcY7ATod+Wl2UKgB0PQEuf0ZuAQmGJyH0QkJMkIPKPMMFfe3QDRlGVgg8FYxOyBqRHIF8g1PzuNALM8X3QBC4zU3eA75ETPTpRmAq27Sabo54wr5a1oV1nX5l7I9Wet3TgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b=Q/ovBOp8; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479B6Bw8026624;
	Fri, 9 Aug 2024 12:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	subject:to:cc:message-id:from:date:mime-version:content-type; s=
	email; bh=PDJZc+peGcM01wu3dHjA4ojQzQen8/SY4+uT+38tyUE=; b=Q/ovBO
	p8PvSWSfb+OxEN7IfUvMcoYmnUX1eaoSTZT++WKMMjuhOhqjBxVFtlTaJR4+L0Kc
	LJtkS/G/tqGjiLB5ixKfRov8kC/Nak8YCE5ATN1Gl+5kVWaRSiZ/oZrL2TQxIwLm
	fkLotiHaojt30jzSmjF+9aGZqxOEShB0xPT65KFYcjcgHzule5HPEqSp1A+uPoBL
	+tMJ9vNQNUsWBG3RU1vxqlWqnGDyvT1RJFJEfs2HDRV3D9hIYRz63/D+UX9Rz6E0
	VurEZwPdz7eYsf2SgcHQwlXyiUFvtiMzjvr80Yy268ELrgPrSG0c6ru03Te+NnK8
	JuaVxlzdyeZpBU2w==
Received: from usgdcecpmsgae04.extemr.org ([144.191.132.85])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 40whxj15c8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 12:20:59 +0000 (GMT)
Received: from usgdcecpmsgap06.emrsn.org (10.16.75.142) by mail.emerson.com
 (10.16.11.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Aug
 2024 12:21:29 +0000
Received: from usgdcecpmsgap05.emrsn.org (10.16.75.137) by
 usgdcecpmsgap06.emrsn.org (10.16.75.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Aug 2024 12:19:19 +0000
Received: from (10.19.249.15) by Inetmail.emrsn.net (10.16.75.137) with
 Microsoft SMTP Server id 15.2.1544.11 via Frontend Transport; Fri, 9 Aug 2024
 12:08:07 +0000
Subject: Re: Subject: [PATCH] mtd: spi-nor: add support for MRAM Everspin EM008LXB
To: <mwalle@kernel.org>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Message-ID: <8bf78b2b-840f-4309-acaa-e1ab7bab084d@usgdcecpmsgap05.emrsn.org>
From: <claus.fabig@emerson.com>
Date: Fri, 9 Aug 2024 12:08:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wNWz5fOiCPnbmjrTagrK4G8lUZwSSg9f
X-Proofpoint-GUID: wNWz5fOiCPnbmjrTagrK4G8lUZwSSg9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_09,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090089

> Hi,
> 
> On Fri Jul 26, 2024 at 2:04 PM CEST, claus.fabig wrote:
> > > Hi,
> > Hi Michael, thanks for your response resp. advices and apologies for the late
> response.
> > >
> > > There is something odd with your mail client, maybe have a look at
> > > git send-email.
> > Unfortunately I am only able to send/receive email from my windows
> > machine and therefore have some challenges within our company
> infrastructure.
> > I still try to find the best way to get the formatting correct.
> 
> In that case you can also have a look at:
> https://b4.docs.kernel.org/en/latest/contributor/send.html

Thanks, I looked into it but have problem with our smtp server since it 
requests a password, even with smtpauth=none in .gitconfig. I will clone my
Linux target repo to Windows virtual machine and use git send-email
instead since there no password is requested.

> 
> > > Also we usually push back on the MRAM devices and refer the users to
> > > the at25 driver. But as this doesn't use the NO_ERASE flag.. I'll
> > > let Tudor and Pratyush decide.
> > I am aware that using at25 driver works but have the task to integrate
> > that in mtd since another used MRAM Everspin flash MR25H10 on our
> > board is also accessed in that way and already part of the mainline. That will
> lead to confusion on user side.
> 
> I suggest that you'll look into evaluating and converting your existing boards to
> nvmem (which is the interface at25 exposes) instead.

My problem is that we have two MRAMs on our board configuration - both 
from Everspin (MR25H10 and EM008LX). The first is accessible via /dev/mtd 
and already part of mainline. The second should also be be accessible via this 
interface so this is why mtd is more preferred than nvmem interface. I noticed
that the first MRAM with /dev/mtd is also existing in nvmem but only as read-only.

> 
> The MTD maintainers agreed that new fram/mram won't likely be added
> anymore. As I said, this patch might be an exception, because you are actually
> emulating a flash device (because you *don't* have the NO_ERASE flag).
> Otherwise, the m/fram are more like an EEPROM and thus should use the at25
> driver.
> 
> > > > From: Claus Fabig <claus.fabig@emerson.com>
> > > > Date: Thu, 18 Jul 2024 09:53:36 +0200
> > > > Subject: [PATCH] mtd: spi-nor: add support for MRAM Everspin
> > > > EM008LXB
> > > >
> > > > The Everspin EM008LXB MRAM has 8Mb and is populated on a custom
> > > board
> > > > using Microchip's PCI12000 spi host controller running on low 30MHz
> clock.
> > > > According to Everspin Read Fast (0xb) command below 60MHz is
> > > > neither specified and nor tested. Test shows that using Read Fast
> > > > (0xb) will result in reading inconsistent data in this setup but
> > > > writing is fine, so only supporting Read (0x3) command should be
> acceptable for the moment.
> > >
> > > This is really odd. Is there an explanation for that? Usually, fast
> > > read will just add dummy cycles in between. Also the datasheet just
> > > mentions a "maximum frequency" which actually makes sense. Do the
> > > dummy cycles for our fast read operation match the number of dummy
> > > cycles in your device?
> > >
> > Yes, at first I configured the chip with 8 dummy cycles to match with
> > platform dummy cycles with the result of reading inconsistent data.
> > The answer from Everspin product engineering was:
> > "Read fast has only been tested down to 66 Mhz. If you are only
> > running at 30 Mhz, you should be using the Read command instead. Read
> > Fast is designed for Higher speed operation". Unfortunately no more
> explanation.
> 
> I guess you cannot use it with at least 66MHz?

Unfortunately not, it's limited by hardware design.

> 
> > > > The device is JEDEC compatible (JESD251 and JESD251-1) but not
> > > > able to provide SFDP information.
> > >
> > > There is no SFDP data for this chip is it? But it has a READ_ID
> > > command.
> > For my understanding reading SFDP works with command 0x5A which is not
> > supported, reading ID is command 0x9F and supported. I don't understand
> your point.
> > Maybe you could give me a hint to better understand.
> 
> Please see my comments on the code in my first reply. You basically don't
> probe the driver by the name, but by it's ID.

Understood, changed this accordingly and will send Patch v2 
(via git send-email hopefully).

> 
> -michael
Best regards, Claus

