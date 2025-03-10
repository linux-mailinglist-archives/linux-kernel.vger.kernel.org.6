Return-Path: <linux-kernel+bounces-554837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A98BA5A143
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4531C3ABA11
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2061233722;
	Mon, 10 Mar 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j//qbsSw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tay6z8pi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E422E418;
	Mon, 10 Mar 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629537; cv=none; b=PbmdabaKkh9CWEbpcMKXi/fB6faalVE/2I8UjZK6RVyJhvCk7wq3fY2VL2Zm2ZI1597q0/V4WjDEc6F1I9wPnH6uzDhdKmZWJW2BYk8UFYn7bvi/xVswgs+Ht8WCVcZRKMOIMkLr4yRuEKBXqFHT7X5AMR1LnHPGlg0O3XFsvcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629537; c=relaxed/simple;
	bh=Al66dsQDQ1AjZ4p3RvfOqWj4xDz7Yh0Li6CQqx31OAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y4a9Y8tGmlt3dVCTqNOlqcg2UZDTrOFkhxK3oGZVUqAuMGZnPRq96VDQuwMyS/UXIquS8RnvnIgvH51UU+V72Uu4vCKz1+HN2bJQsNO6cl0lGeE4TXy79TXPhhx1Ztq9fDB52NjPDWPbLQg1AM4FkRgrO9OTBnFa8YOlxWZJ2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j//qbsSw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tay6z8pi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741629534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ly81vQvGXLIQAxg5uok81uLig8KVjTlFKKgmBlnmwM=;
	b=j//qbsSwkuy/0qqOlBzR/DCCFBWPkp8dpqdoEsmmHRzZS3qU6u2n2wupSWSz6nM1dpuUri
	aiLxBe/uYDvzyTjKz0ZvnjLnA1uv9j3zNWECtlFN2n6PjkVPVNkGSaBLsY7jNRCa0oHt+Z
	TR4Et6ZYlJTN7ceEdWzvdd+J49x8+htWKzrawqyGXmwAEbf9cOxCjQmiuZeoUQK7lu/o09
	8w+CMSlbnB87sxTKWO5zeS0E+NAL/NZf0OenWsDqsF7VPTwh+A9VeKwvzjemMYwQ83IXaS
	LkW1H8ID12Cw/KuajwYfbJJaPkUKhk+vx63TXUbvqVyJ0nozoB4BKQ0FKBZ3zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741629534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ly81vQvGXLIQAxg5uok81uLig8KVjTlFKKgmBlnmwM=;
	b=tay6z8piYzjYTDcVT49X42zfRg7CquVlxe7fBfutBqZbIPgXozgKkKf1wQKrMY9lhcs+Eg
	x0hweM8q8QaQwsAA==
To: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH v4 2/4] irqchip: Add support for Amlogic A4 and A5 SoCs
In-Reply-To: <20250307-irqchip-gpio-a4-a5-v4-2-d03a9424151b@amlogic.com>
References: <20250307-irqchip-gpio-a4-a5-v4-0-d03a9424151b@amlogic.com>
 <20250307-irqchip-gpio-a4-a5-v4-2-d03a9424151b@amlogic.com>
Date: Mon, 10 Mar 2025 18:58:53 +0100
Message-ID: <87ecz422ea.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 07 2025 at 16:49, Xianwei Zhao via wrote:
>  
>  	if (type == IRQ_TYPE_EDGE_BOTH) {
>  		val |= BIT(ctl->params->edge_both_offset + idx);

Not new, but this really should be 'val = ...'

> -		meson_gpio_irq_update_bits(ctl, REG_EDGE_POL_S4,
> +		meson_gpio_irq_update_bits(ctl, params->edge_pol_reg,
>  					   BIT(ctl->params->edge_both_offset + idx), val);

and this BIT() calculation is obviously redundant as it is the same as @val.

Would be nice to have that cleaned up.

With that fixed:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

