Return-Path: <linux-kernel+bounces-241795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F7927FB2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64B51C216B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFA8FC11;
	Fri,  5 Jul 2024 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="dScaGYx/"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1510A24;
	Fri,  5 Jul 2024 01:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720142389; cv=none; b=lo8Yf+fu39A8zQa0bf/5Chrp2svBDU3+M1NV/9OqlSkHQ6/E6ChuZBZaB7d43i2SQ6vp9lEIMtvmrnb4kity18FurAVzBJUdPZ28Do9XAs+VwJXMMFv1ZXQ/SoTp3+dH5lvHEGTVnJuYA2Jl7RMox7X+RY1671D+u2O6nqojs3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720142389; c=relaxed/simple;
	bh=4jXA60CwTqUR5bZu5hr9dmdPy/sOO2/oK1vX+xklF5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kmFleZq+dhCzi5wYYjUMlgHtcj6fqwD2+ekd0QnqWWpv4wSoznYrLL9dqUWNvz6W2oEdioz6qnXNXNC1PWZf371gTGgOKR11Tq1VjcZ1hS2XNyqU3ZKYrnQH8ZhSx3LcxbwugMqOSz5Yr+2U75i/djWlJ3BU8c28Nhx2unJ6frY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=dScaGYx/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720142382;
	bh=UCMaIVTnGE08WOL8bGCywK+Z7TDVAMtL/zyKNBMfqBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dScaGYx/VAT1PxfoDVsug+gCtBq4YJ4QfRBfg7DW04HpffBYfKmUJHAruupwwMsWr
	 GNYcEBSFfTl/llWg1f8VT1LwAU/H1dVxv6OcCPQLAkUwzCbA70fo+FcimqPKJ17YGV
	 wK2VO3TdDquqcngJsKeg4bCN1NWoT/sBJbKt9c9tVeNSVhDcWeZG9yicBKCFn9x8bm
	 /wxenOnMKvQEudhsKzijOqw5Rv0DGEPUhbWLrTAEbc3+7aGvg5qNzIfKs4VP8EkHFP
	 xTdd0jdhCobAWneOQdFmCEYpjGKyRusmZY8J/w8VJepbBHSU4V7Fh/6yLH2v2/rXHN
	 S8QgFt72S/IBQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WFbK93fn5z4w2F;
	Fri,  5 Jul 2024 11:19:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>, apatel@ventanamicro.com, DTML
 <devicetree@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, mad skateman <madskateman@gmail.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Matthew Leaman <matthew@a-eon.biz>,
 Darren Stevens <darren@stevens-zone.net>, Christian Zigotzky
 <info@xenosoft.de>
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives
 after the of/irq updates 2024-05-29
In-Reply-To: <dfc7ec00-5216-4590-9347-ee10cd1e8380@xenosoft.de>
References: <3ab66fab-c3f2-4bed-a04d-a10c57dcdd9b@xenosoft.de>
 <86zfqzhgys.wl-maz@kernel.org>
 <ccf14173-9818-44ef-8610-db2900c67ae8@xenosoft.de>
 <874j95jrur.fsf@mail.lhotse>
 <3baff554-e8f6-42b0-b931-207175a4d8fd@xenosoft.de>
 <dfc7ec00-5216-4590-9347-ee10cd1e8380@xenosoft.de>
Date: Fri, 05 Jul 2024 11:19:39 +1000
Message-ID: <87o77ciqj8.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Zigotzky <chzigotzky@xenosoft.de> writes:
> On 04.07.24 20:27, Christian Zigotzky wrote:
>> On 04.07.24 13:53, Michael Ellerman wrote:
>>> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
...
>>>
>>> Instead of that patch, can you try the one below. AFAICS the device tree
>>> fixups done in early boot mean the interrupt-map is not needed, and also
>>> has the wrong content, so if we can remove it entirely that might avoid
>>> the problems in the parsing code.
>>>
>>> I don't know if your firmware actually implements those methods, I
>>> couldn't find anything online to confirm or deny it. Seems the only
>>> option is to test it.
...
>
> Unfortunately, the kernel 6.10-rc6 doesn't compile with your patch. "rc" 
> is undeclared.

Right, I had some debug code that I removed before posting.

This version should compile :}

cheers

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index fbb68fc28ed3..965d58c54fab 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -3123,6 +3123,7 @@ static void __init fixup_device_tree_pasemi(void)
 	u32 interrupts[2], parent, rval, val = 0;
 	char *name, *pci_name;
 	phandle iob, node;
+	int rc;
 
 	/* Find the root pci node */
 	name = "/pxp@0,e0000000";
@@ -3138,6 +3139,14 @@ static void __init fixup_device_tree_pasemi(void)
 
 	prom_setprop(iob, name, "interrupt-controller", &val, 0);
 
+	prom_printf("nemo: deleting interrupt-map properties\n");
+	rc = call_prom("interpret", 1, 1,
+		      " s\" /pxp@0,e0000000\" find-device"
+		      " s\" interrupt-map\" delete-property"
+		      " s\" interrupt-map-mask\" delete-property"
+		      " device-end");
+	prom_printf("nemo: interpret returned %d\n", rc);
+
 	pci_name = "/pxp@0,e0000000/pci@11";
 	node = call_prom("finddevice", 1, 1, ADDR(pci_name));
 	parent = ADDR(iob);

