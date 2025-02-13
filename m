Return-Path: <linux-kernel+bounces-512889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F56A33EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D467A1FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170CE21D3F9;
	Thu, 13 Feb 2025 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nQa5DEVI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EQrHOm5e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864ED227EBE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448777; cv=none; b=UAPrKOGl7sTf4zAxYWPnBdw5CbkADus8uj+7qDiZJyHz+4ncuKT5ZFTLykGtPrCIrERaec/pG1+IOBtoPQQa7P+kiTXElyKtyRlQvv0iASDvH3kSc0uj/vRbpoE44uTDcDFVoojsMs1y4cfE2nYSoulDNGrb0+zLa+lpnCOiNjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448777; c=relaxed/simple;
	bh=IkT1HXnvhmnIAy7ak03esG1cDt05Qmm78tFPJg+aYTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yj1Bounn6HQH6XlCpeJ2cSz0XLAmOZIhV1p6Zcnxm7dKKC/WrXciKcpaZobD/p1WrCs0TAtfvL13MRFqsnYU+kyovnaOgLz3a25zqTmCSrQHyjGdB+yUNCv0EFYio5KfuVhzsOSkUWxjq82XvMO9lvK8Y931mVVoQOh0MWvkSDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nQa5DEVI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EQrHOm5e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739448770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IkT1HXnvhmnIAy7ak03esG1cDt05Qmm78tFPJg+aYTA=;
	b=nQa5DEVIVciTNLFayb5YHiTTdqSbOXVAXcAnHis9A8bp5C+WaXQMOIMkXcdAMsAjBZdDnb
	A24kTgc0opcSVHVjjJOi5cYdyc0sU6M8D7Ba9JdH2b+L+jpTPKHtt1YCrUZj0KJEVvYjCa
	JR/fm0bGJ30H0OUfwKejyV/bs5vDuiCZD1KGmFODedweYcD5xcYdgYt1K3byL7gXUYT9a/
	BffVs1Kvd1hESQYMAST0JoKvSrEjkMuxB8pVHzneOFLGs2+d09YzC9Q2DmIZvZZA7ZG5Yx
	Tadw7oAGvjS+GOlqNnXCdUxY/3ojA2BQRn5nDt4UtyBRa1v9X27Tvuiu5f+NCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739448770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IkT1HXnvhmnIAy7ak03esG1cDt05Qmm78tFPJg+aYTA=;
	b=EQrHOm5eu4qUbGUFL7thOi2PpaAuHnmB/RxDrvQL4TzjrZ+H2ohXWAWggSJtwHR67CDUl4
	O90uincGPSZMZsBA==
To: Anup Patel <apatel@ventanamicro.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: hpa@zytor.com, Marc Zyngier <maz@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, Gregory
 Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra
 <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, Anup Patel
 <apatel@ventanamicro.com>
Subject: Re: [PATCH v5 01/11] irqchip/riscv-imsic: Set irq_set_affinity for
 IMSIC base
In-Reply-To: <20250209041655.331470-2-apatel@ventanamicro.com>
References: <20250209041655.331470-1-apatel@ventanamicro.com>
 <20250209041655.331470-2-apatel@ventanamicro.com>
Date: Thu, 13 Feb 2025 13:12:49 +0100
Message-ID: <87seoijb5q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Feb 09 2025 at 09:46, Anup Patel wrote:
> From: Andrew Jones <ajones@ventanamicro.com>
>
> Instead of using imsic_irq_set_affinity() for leaf MSI domains,
> use imsic_irq_set_affinity() for the non-leaf IMSIC base domain
> and use irq_chip_set_affinity_parent() for leaf MSI domains.

This clearly lacks an explanation of the purpose/reason of this change.


