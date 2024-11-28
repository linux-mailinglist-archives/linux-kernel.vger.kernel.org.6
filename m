Return-Path: <linux-kernel+bounces-425037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D79DBCBF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80DBB21849
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07FC1C2450;
	Thu, 28 Nov 2024 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uBGz+W8Y"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DBB145323
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732824483; cv=none; b=q0n4Tds20RQiolHwJjnjEmoY9yEIYWD65QVnFD2CRC7lXpGNHoDqacMnifVW/Dsfpg6Pf63GQC+fSLauMjYvapSAjnNPf//tvbRNZ+nND8KR4mHULE0C1NQ+ak6PXq4TjCKMK1AwWr5Ik2OHEpsUtkzJqb2S5Pat+nT8leBD+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732824483; c=relaxed/simple;
	bh=BgCvXF9nE/Md0VPYMuBYdI6DN8IIFIVm9FDT/hEgzPc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QFDSBFHgYLS6xb6JXnSb9n3aSaVC2zwRyy/VkXlSlvLkhkD1p7Ienv3ImiJ9ljN13zXFpDNWnJEthXL2U8CXHVXoEyyAIeln3gyFAZ9M24KV304j2063IjOeZLVKyuZizhqbm6bpAd7n3ILonhZO2AdT8exKy8gdsV1T/ea5eC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uBGz+W8Y; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732824482; x=1764360482;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=OqkEOPg1Ntw5OzjoKV6qV13YxrudUL0x8D+JX5oOx/Q=;
  b=uBGz+W8Ym016ImqJwd/9QWuOFasP8zm48RXXq39TdpuS59IvV9HH+4Ly
   y/65smXn6MUrbEKjivgSxbqUJFa7eYOkOUGPsCi1/UbcYxrGthP8vFPsT
   OpkFH8KTmSOcrxDhxvoAgTfAJRhKpqNPOW0uZhn9lsQICQcqIZ6TXiQOd
   4=;
X-IronPort-AV: E=Sophos;i="6.12,193,1728950400"; 
   d="scan'208";a="699037645"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 20:07:59 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:44286]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.34.163:2525] with esmtp (Farcaster)
 id 092245c2-527c-4203-87c5-e650bdd3ad53; Thu, 28 Nov 2024 20:07:58 +0000 (UTC)
X-Farcaster-Flow-ID: 092245c2-527c-4203-87c5-e650bdd3ad53
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 28 Nov 2024 20:07:58 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 28 Nov 2024 20:07:58 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.1258.034; Thu, 28 Nov 2024 20:07:58 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Thomas Gleixner <tglx@linutronix.de>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"naveen@kernel.org" <naveen@kernel.org>, "maddy@linux.ibm.com"
	<maddy@linux.ibm.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "bhe@redhat.com" <bhe@redhat.com>,
	"hbathini@linux.ibm.com" <hbathini@linux.ibm.com>, "adityag@linux.ibm.com"
	<adityag@linux.ibm.com>, "songshuaishuai@tinylab.org"
	<songshuaishuai@tinylab.org>, "takakura@valinux.co.jp"
	<takakura@valinux.co.jp>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
CC: "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: RE: [PATCH v2] arm64: kexec: Check if IRQ is already masked before
 masking
Thread-Topic: [PATCH v2] arm64: kexec: Check if IRQ is already masked before
 masking
Thread-Index: AdtB0CLnH24qyvw6Ek+EUcflLj/BEA==
Date: Thu, 28 Nov 2024 20:07:57 +0000
Message-ID: <3a499ecdfa5042f8b6e8834c47cdb2d9@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 11/28/2024 12:39 PM, Thomas Gleixner wrote:
> This is just wrong. If the interrupt was torn down, then its state is dea=
ctivated and it was masked already. So the EOI handling and the mask/disabl=
e dance are neither required nor make sense.
>
> So this whole thing should be:
>
>                 chip =3D irq_desc_get_chip(desc);
> -               if (!chip)
> +               if (!chip || !irqd_is_started(&desc->irq_data))
>                         continue;
ACK. Will be done this way in V3.

> But what's worse is that we have 4 almost identical variants of the same =
code.
>
> So instead of exposing core functionality and "fixing" up four variants, =
can we please have a consolidated version of this function in the core
> code:
>                 struct irq_chip *chip;
>                 int check_eoi =3D 1;
>
>                 chip =3D irq_desc_get_chip(desc);
>                 if (!chip || !irqd_is_started(&desc->irq_data))
>                         continue;
>
>                 if (IS_ENABLED(CONFIG_.....)) {
>                         /*
>                          * Add a sensible comment which explains this.
>                          */
>                         check_eoi =3D irq_set_irqchip_state(....);
>                 }
>
>                 if (check_eoi && ....)
>                         chip->irq_eoi(&desc->irq_data);
>
>                 irq_shutdown(desc);
>
> No?
In V3 I will add a preliminary patch that will remove the four variants
and instead add a common implementations to the kexec core.

Thanks, Eliav

