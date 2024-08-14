Return-Path: <linux-kernel+bounces-286712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9500951E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B07E281FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802A51B5812;
	Wed, 14 Aug 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tAiYKLbk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j6DzcVXm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A61B4C23;
	Wed, 14 Aug 2024 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647977; cv=none; b=Qnq7gtzSEyckCbw09Fnt9bIsjIfGQOZiryjLFggqWsZVzK4Y0gsZpmXPqURdxG8pshXap02ns8vsRM4YrxOcVEcrZnBTMnTJ+D0Xc4nprYlNy3pmJOkHo3jri6aWngxQ9Vyco9STu5E4oDIX3LgnKN+MswddigNzBcMz0FrFQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647977; c=relaxed/simple;
	bh=OU2N/lJoKy29N++pfrNcOUwH/XmHLRz4RAcUETTINHQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PWgmWW0Y7OEd6JTsA4ouA1E/CabBYZ8b5dQOlfSn5FU4y9IjVYdZkv4TCBV0yWOkgZ3K03g2L1RandcCj62NKv22NEVggFDqPT5OjlzQGuW4+FeyxcRVP6R281Zz182m5br2tsiXVLqbHRR6azqbaxOaAgnUd0FtSOaGXXvEQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tAiYKLbk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j6DzcVXm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723647974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgBDpLd5CRpFg6iGANviJjQZYBMsab2XfI71ntFAp9M=;
	b=tAiYKLbkjpo3vw7vm6WQ5c7NaedPhBkRMhEoTNaEjtTBNkJoxXr6ch7ieW7REJBS8Bs0bI
	MFa+tPwBRX6tlTqzlOkNXKFJqYGmLWvZ9WDysaNEfAhIcaMlMI/3ygGfLmajWqPhFF0s1q
	yT7MMOoKP/YEViRCuJ5mO2f4hMzUtha0fAnOq2umhbBZi0VcQ0vMSJrGAZoJytbmAFBTxB
	Jo4QqrkLTErYRR4AuF56fvGbFdAjnb6Gdd9bnE0wb1Il1fxN7ZzfA3Pcy7BI+FfXzq+yTq
	QSPBPJE2RvXKhiKEaXARp2eKHeRbb5B6myXbMlqM6stm/qlbobkrr8b1LuygZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723647974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgBDpLd5CRpFg6iGANviJjQZYBMsab2XfI71ntFAp9M=;
	b=j6DzcVXm1ZA8IVRQAornEXvVYXU17kS2Dzdyv1mD/k0CSU+9aqtNO+Omhv5JKo36g68YUk
	Me2HS01vDRJm2JAA==
To: Kevin Chen <kevin_chen@aspeedtech.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, kevin_chen@aspeedtech.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
In-Reply-To: <20240814114106.2809876-4-kevin_chen@aspeedtech.com>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
 <20240814114106.2809876-4-kevin_chen@aspeedtech.com>
Date: Wed, 14 Aug 2024 17:06:14 +0200
Message-ID: <87plqbnnyx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 14 2024 at 19:41, Kevin Chen wrote:
> Support for the Aspeed Interrupt Controller found on Aspeed Silicon SoCs,
> such as the AST2700, which is arm64 architecture.
>
> To support ASPEED interrupt controller(INTC) maps the internal interrupt
> sources of the AST27XX device to an parent interrupt controller.

This still lacks a Signed-off-by: tag and my comment about the error
path in the init function is still valid.

Do you think that addressing review feedback is optional?

Feel free to ignore it, but don't be surprised if I ignore further
patches from you.

Take your time and go through stuff properly and do not rush out half
baked patches in a frenzy.

Thanks,

        tglx






