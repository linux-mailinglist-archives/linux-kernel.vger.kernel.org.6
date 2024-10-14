Return-Path: <linux-kernel+bounces-364452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49BB99D4D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AC52832BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411841B4F24;
	Mon, 14 Oct 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bAcwgtUu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xTroEj4c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FCE231C92;
	Mon, 14 Oct 2024 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923931; cv=none; b=U5TN629rgezv5JrRKoRhLIvVyjb7oldd+/Ccc1bSr2TPacUpHPDXvIaalLpigjYTZEI+092L8ty3nKOA+KRPERJgnTjd4GlKWbsa2T6GA2mKgZsjHyD1pqa8h6/WWwL+8jl1xpn2p1SwnEp9CXcXAFlxOiO9epjb9lq69LeB99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923931; c=relaxed/simple;
	bh=mEdzq09V15Xwnr66U6AvoYDlsXhPCZU3z5I0NbdtL28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LP2XQYAtZ1FBJbukZSdLlbw+lsgzGhA6gCGvYZXAsyENxF0SqLrCixjN6Kl8ztnKauYbshZJDwCQUp+iD7yPesRZNr4ceAfeIw+i21OHknVkPbJA22wQR2gNI1AtB9xDt3MWSRPm5olZec0mvjCTKpYlVQpEQ2aPmDi9rVBhINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bAcwgtUu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xTroEj4c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728923928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YIY16wXiGYjvpyHqlLYNoeeEF3MtoTc0EB4XbDJop/o=;
	b=bAcwgtUu3xFLP8Lco3S25VfYe78YgxOCRrvsYOhcUEjNIe5uyhJjVW+mhk3MGFbc+WSvKB
	bFH2fOrzr7zSZzVDp5mR8bD1A1rJ0Q0BirRC5T/jWY1+yiRUsXcMXeSPMxQrybm29fIhhr
	9N7GZI+/HH3en6R7K3nmjqgjvephhsZHw/0EUadRJc439KDwYSXb//708DSYBbPwhLgDVu
	b91t6hFjMCLx+g+9AP32kFwUBvXATR/YBCvAofCIsSvelICgL/pvE+SnTlSTRnrb1ztGj/
	+AfQpARP76G6WdrLv7Vuq/aaIJ0YFRqK3cYukaORonVZV0YkpaO0ezp5ceCuCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728923928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YIY16wXiGYjvpyHqlLYNoeeEF3MtoTc0EB4XbDJop/o=;
	b=xTroEj4cBADdE1o+N9fbYKa/4pmpakOv+wcnu7mALpMU6XjcNrzWA0Z1jenjtoTIrpsh9/
	PH+h7MnATOpiAiCA==
To: Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Peter
 Zijlstra <peterz@infradead.org>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>, Lad
 Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Yangyu Chen <cyy@cyyself.name>, Jinyu
 Tang <tangjinyu@tinylab.org>, Hal Feng <hal.feng@starfivetech.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@gmail.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
In-Reply-To: <20241009224410.53188-3-inochiama@gmail.com>
References: <20241009224410.53188-1-inochiama@gmail.com>
 <20241009224410.53188-3-inochiama@gmail.com>
Date: Mon, 14 Oct 2024 18:38:47 +0200
Message-ID: <87ldyqfxm0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 10 2024 at 06:44, Inochi Amaoto wrote:
> +config THEAD_C900_ACLINT_SSWI
> +	bool "THEAD C9XX ACLINT S-mode IPI Interrupt Controller"
> +	depends on RISCV
> +	select IRQ_DOMAIN_HIERARCHY

Lacks
        select GENERIC_IRQ_IPI_MUX

Other than that this looks good.

Thanks,

        tglx

