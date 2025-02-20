Return-Path: <linux-kernel+bounces-523896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 484EEA3DC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BB57ABDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215AF1FBEB0;
	Thu, 20 Feb 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3oufnGd7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D9Knt0/Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC641DE4DB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061282; cv=none; b=MQ/df5JaK5RY/6xzWncaysQEG8U0NkxsvhiQsmGRU/oqrfO4/U3Krc+R0Yf0uN2U/81Omx0lSnFP+w7FqLfj5XdMfahJGYDy1B8okavxynFjK3x8wevoDmWHiacKepDCf9Ytxj6bCXXSvnCpTeRxi1L/Av9ywzd2tfgjPkdH4gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061282; c=relaxed/simple;
	bh=lJ1fuL6wK8CkBl8tMlUZAzn0eYU+XWFjZX7mmgbguCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JNRvUYYnYoNXAWsjkNJ24zAgPtkMlC4gnfIeTirHSCHIIEgvRFQQNXTUSou0KDHcE6lvEoyAqYGynLgxTbiWlZGPnGlfBqZAFGIJYnvwDUveM0c06t1U7te8F/s8m6mk7nKEJ8iR+7LMrmpn7cH9215yz2w1cVpgwOcDL3hEgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3oufnGd7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D9Knt0/Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740061279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/BmtFl2k81SUm/1VjrdU/jVgNub5nHsJ466sJIBSwU=;
	b=3oufnGd79cXN4jTTMDZ7Z6srl8Ucj1sL35GTITM5ip/hhNfLdNEYBcfYEMW975QF6921cA
	cciHlQX7+abbQrJT0TieGU8ctAA7wGO0cqj2/piqAaIcbrDv5L/4HeIGVwShaFC3Bq48YH
	suiMDHR3vg34aEAzMe+BV0KSW9VSPNgdjwW63lvegZgL1TQ5UiPythFZ5KnPHQRHxJG2Xj
	giFg2lDq21Vm2EoS1vuwvtqlttU4FdQYnquG8StF/7Qc2U1dMZXYRZ0FtVE75DzBMrzz/P
	N3504pfJR4o/GLBBGIeWk5v9l0bJsYmm0QupTJ+nNCCVRtaoXf+P0gSK0HcClw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740061279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/BmtFl2k81SUm/1VjrdU/jVgNub5nHsJ466sJIBSwU=;
	b=D9Knt0/YpIddKDTVG7BDrv4vvrba0CkVNAk6jPl1IKKFJVU+mQyOoOkRYYlV8EljvtiK2B
	sr28C0ab+/lVqCAQ==
To: Mark Brown <broonie@kernel.org>, Anup Patel <apatel@ventanamicro.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, hpa@zytor.com, Marc
 Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement
 <gregory.clement@bootlin.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra
 <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v6 02/10] irqchip/irq-msi-lib: Optionally set default
 irq_eoi/irq_ack
In-Reply-To: <87jz9kiuvu.ffs@tglx>
References: <20250217085657.789309-1-apatel@ventanamicro.com>
 <20250217085657.789309-3-apatel@ventanamicro.com>
 <Z7Xto0WZ-Crxunik@finisterre.sirena.org.uk> <87jz9kiuvu.ffs@tglx>
Date: Thu, 20 Feb 2025 15:21:18 +0100
Message-ID: <878qq0itnl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 20 2025 at 14:54, Thomas Gleixner wrote:
> On Wed, Feb 19 2025 at 14:41, Mark Brown wrote:
>> On Mon, Feb 17, 2025 at 02:26:48PM +0530, Anup Patel wrote:
>> I'm seeing boot regressions with qemu on arm64 in -next which bisect
>> down to this patch.  We hit a NULL pointer dereference:
>>
>> <6>[    0.898900] virtio_blk virtio1: 1/0/0 default/read/poll queues
>> <5>[    0.910197] virtio_blk virtio1: [vda] 3906250 512-byte logical blocks (2.00 GB/1.86 GiB)
>> <1>[    0.924459] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>> <1>[    0.924508] Mem abort info:
>> <1>[    0.924521]   ESR = 0x000000008600002b
>> <1>[    0.924559]   EC = 0x21: IABT (current EL), IL = 32 bits
>> <1>[    0.924580]   SET = 0, FnV = 0
>> <1>[    0.924597]   EA = 0, S1PTW = 0
>> <1>[    0.924616]   FSC = 0x2b: level -1 translation fault
>> <1>[    0.924667] [0000000000000000] user address but active_mm is swapper
>> <0>[    0.924833] Internal error: Oops: 000000008600002b [#1] PREEMPT
>> SMP
>
> Uuurg. I wish I had double checked that the final submitted patch covers
> _ALL_ incarnations of this. The below delta patch should address it.

I'll redo the branch accordingly.

Thanks,

         tglx

