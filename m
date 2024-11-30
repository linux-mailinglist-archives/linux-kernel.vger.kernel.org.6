Return-Path: <linux-kernel+bounces-426429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CF89DF2E3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 21:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E865CB210E0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 20:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7161AA1F4;
	Sat, 30 Nov 2024 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AW5qg37Q"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26A917BD3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732997335; cv=none; b=T1pXRNHWqYIj4gxcNR1gC/ApMSUzksauOnJNL223HTx5zZh2hoCYp3sMf9Z9XOmuU1rUWE4G04wmFUkPb2lajoGvT0arnAguKWFdvJ7N1ThwuTRsCJj1hH8MHLvAUFXYOHcb7yaDnXW0l8hjw1rnF10+uVvi8bilqfRYX3XAXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732997335; c=relaxed/simple;
	bh=+Lc71UXvaBy0d4rbLbYwg8bndK+l696GJrQv98F/KkE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FwyPVRIY+pUaFxTKMGp1XJMRuojng0a2dl7sCVSH76YIkKTryuNdybVLGn5wXnLRB0TchFC0cOTm+hCqkH6exHJG7YsDBrlZzyIoPapR2bNkLbVYcUHRdLkVOJNI1EB2cBlPcx+K0TYtHCZaOl96/4TuvPNKSQc+z2EjG228hDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AW5qg37Q; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732997335; x=1764533335;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=AhSV92xctZtOIuDX4XdK6Ka318O9z4zvPM7btw6h77c=;
  b=AW5qg37QtPUkA7VBHAX8fMlebquLIe2x66y6EWZ8DGfbBQARv/9eDpqd
   MMm/Ibqk/Y5dREJt/WZ+KrVE3Or/pXs24cfP4QqifqGLYDTT84cPGdIPM
   02uBM6rfMQOgQFDYEg0l/6Ulu1L6o0WCBxSxFT8j6FlnKJffYV3SKuf+5
   U=;
X-IronPort-AV: E=Sophos;i="6.12,199,1728950400"; 
   d="scan'208";a="779857217"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 20:08:48 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:15968]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.11.83:2525] with esmtp (Farcaster)
 id 6ac350d1-00ea-4165-8f54-56833500c432; Sat, 30 Nov 2024 20:08:45 +0000 (UTC)
X-Farcaster-Flow-ID: 6ac350d1-00ea-4165-8f54-56833500c432
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sat, 30 Nov 2024 20:08:45 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 30 Nov 2024 20:08:44 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.1258.034; Sat, 30 Nov 2024 20:08:44 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Thomas Gleixner <tglx@linutronix.de>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"naveen@kernel.org" <naveen@kernel.org>, "maddy@linux.ibm.com"
	<maddy@linux.ibm.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com"
	<bhe@redhat.com>, "hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
	"adityag@linux.ibm.com" <adityag@linux.ibm.com>, "songshuaishuai@tinylab.org"
	<songshuaishuai@tinylab.org>, "takakura@valinux.co.jp"
	<takakura@valinux.co.jp>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, Marc Zyngier <maz@kernel.org>
CC: "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: RE: [PATCH v4 1/2] kexec: Consolidate machine_kexec_mask_interrupts()
 implementation
Thread-Topic: [PATCH v4 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
Thread-Index: AdtDYtCFjQWQn9I6QGW+NnB/V7SCxQ==
Date: Sat, 30 Nov 2024 20:08:44 +0000
Message-ID: <cd8809e379dc4dd089350ec2d1f8c210@amazon.com>
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

On 11/29/2024 3:30 PM, Thomas Gleixner wrote:
>> Move the machine_kexec_mask_interrupts function to a common location in
>> kernel/kexec_core.c, removing duplicate implementations from architectur=
e
>> specific files (arch/arm, arch/arm64, arch/powerpc, and arch/riscv).
>
> Can you please move this into kernel/irq/kexec.c?
>
> It's pure interrupt core internal code and there is no point to make
> core internal functions visible to random other code just because.
Done (in v5 series)

>> +void machine_kexec_mask_interrupts(void)
>> +{
>> +     unsigned int i;
>> +     struct irq_desc *desc;
>
>         struct irq_desc *desc;
>         unsigned int i;
>
> please
Done (in v5 series)

>> +     for_each_irq_desc(i, desc) {
>> +             struct irq_chip *chip;
>> +             int check_eoi =3D 1;
>> +
>> +             chip =3D irq_desc_get_chip(desc);
>> +             if (!chip)
>> +                     continue;
>> +
>> +             if (IS_ENABLED(CONFIG_ARM64)) {
>
> This should not be CONFIG_ARM64. Add something like:
>
> config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
>         bool
>
> and select this from ARM64?
Done (in v5 series)

>> +                     /*
>> +                      * First try to remove the active state. If this f=
ails, try to EOI the
>> +                      * interrupt.
>
> This comment does not really explain what this is about. I know you
> copied it from the ARM64 implementation, but it should explain what this
> actually means. Something like:
>
>          First try to remove the active state from an interrupt which is
>          forwarded to a VM. If the interrupt is not forwarded, try to
>          EOI the interrupt.
>
> or something like that.
Done (in v5 series)

>> +                      */
>> +                     check_eoi =3D irq_set_irqchip_state(i, IRQCHIP_STA=
TE_ACTIVE, false);
>
> Looking deeper. This function actually cannot be called from this
> context. It does:
>
>           irq_get_desc_buslock(irq, &flags, 0);
>
> which means for any interrupt which has an actual buslock implementation
> it will end up in a sleepable function and deadlock in the worst case.
>
> Marc?
I will wait for Marc's response regarding this issue.
Regardless, if any changes are required, I believe it would be better
to address them in a separate patch, as this behavior existed before my
modification.

Thanks, Eliav

