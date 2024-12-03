Return-Path: <linux-kernel+bounces-429496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BD39E1CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78C7282361
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B0B1EC009;
	Tue,  3 Dec 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RFCjKLmc"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C92BD1D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230558; cv=none; b=juMyledjYeNt5Qn96TFtJv2K152q6CLRs4t2JaidG7E6kFpw+Ru0Edye6V/rLb4UDpZHmcOB4sxh774k82Ma0bN1i6FxhgCh3R5EpYo+NlihqoJu/y1Fum8CU1ElWyK3m5R8jcERwXyM/R3bDmHay5LPtflPPN5UuUIKSgt/AeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230558; c=relaxed/simple;
	bh=B5ftrZueJZtaVda0Ke11fKcz3ceJLnjy+MBzoc7WB+0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TDymPhCMOPXa2WlROGDR3Y771zaktAMySZZacHMzQ2Rv3+D+pRG22UUftjzQ5M6o8bW2aQftyho32CRfd+yjq82DU70IT/6IogParQ8BaA1J/uVoPyMGnTBi7Aw/0+kgAUGhsR4pGQIPBDXK3cdvFAacZZJtzylmfpizTWCBXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RFCjKLmc; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733230558; x=1764766558;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=zHt8L2Z6dJwqzsWV71weChOsU9eMWPerfPu1DOoxdJ8=;
  b=RFCjKLmc/KCXO9Hugakk2be49ggZAjBUINj5zLL0dbik12l96M/KRtWa
   QH6ogNiVZY/fe3Nxe/5qvfcLO+rOqQZu6lcOwty09felquxvUqlPvOfMq
   4QPC+aoXw0ljt2kzlSoEtpKwiAkNcRNcXCFBOhYTqgQp8XivVho42H+zJ
   c=;
X-IronPort-AV: E=Sophos;i="6.12,205,1728950400"; 
   d="scan'208";a="357635905"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 12:55:55 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:25389]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.206:2525] with esmtp (Farcaster)
 id 321ae853-bb47-4473-a697-0a3ceab94d46; Tue, 3 Dec 2024 12:55:53 +0000 (UTC)
X-Farcaster-Flow-ID: 321ae853-bb47-4473-a697-0a3ceab94d46
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 3 Dec 2024 12:55:53 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 3 Dec 2024 12:55:53 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.1258.034; Tue, 3 Dec 2024 12:55:53 +0000
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
	"hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
	"adityag@linux.ibm.com" <adityag@linux.ibm.com>, "songshuaishuai@tinylab.org"
	<songshuaishuai@tinylab.org>, "takakura@valinux.co.jp"
	<takakura@valinux.co.jp>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
CC: "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: RE: [PATCH v5 1/2] kexec: Consolidate machine_kexec_mask_interrupts()
 implementation
Thread-Topic: [PATCH v5 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
Thread-Index: AdtFgq6lXwncie71LkSE+iBNpljfQg==
Date: Tue, 3 Dec 2024 12:55:52 +0000
Message-ID: <077908c5f02545f0a9e02ae77cbd771c@amazon.com>
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

On 12/3/2024 1:04 PM, Thomas Gleixner wrote:
>> +
>> +config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
>> +     bool "Clear forwarded VM interrupts during kexec"
>
> This should not be user selectable. Just keep it as:
>
> config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
>         bool
>
> which defaults to 'n'. Just add a comment what this is about like it's
> done with the other options in that file which are only selectable.
Question: Should this new configuration option be placed inside or
outside the following section:
```
menu "IRQ subsystem"


endmenu
```
In my patch, I have added the new configuration option at the end of
the file, outside the "IRQ subsystem" section.

