Return-Path: <linux-kernel+bounces-543778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2028BA4D9D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B751D16E37E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74C1FDA7C;
	Tue,  4 Mar 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1umtxGSh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P7Qostk+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031881F8BCB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082998; cv=none; b=i0ehAyUYvBObTOv8vj5Rv2AjzIq0XOmCTNjSZAaLcRvjQZG6Ldsfdi3tMnSmJGbCgA2eFpIbSFI4kEM1zf+IvNyiw+0xrAmlrljsmyU5P2DyI3tf2MiLkfN5dMi2k3cp28kE5jQvJ+YVR4+cM+W0IFO09MOSYocC4ZoyIeBrNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082998; c=relaxed/simple;
	bh=gpufqaTqjpP6z1NEK42OACyK2k4GqN0zGHXMKvy3KzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkI0fJ3/YLDYyBCKah7apUakLL8F4kJo56VlIahkF4WKI6vC4pKmaXan2QqXp3Teztf+i9GgEuQ0XUbD9Da0n8BBBWHfNdYYE34Q3POONe51bOKMHNnf9FyMkIksMbRrbATU0saK5OmnALaOODaqUdbwZ1fxB0vs/VTAf5waCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1umtxGSh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P7Qostk+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741082994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dGrYAp2UYRB4ahPvzjkNTvyhBhRpzSJnkRhzP34zvcs=;
	b=1umtxGShTe/HM+xs3bZ9BbOVGzCe2+AifYvLvOD7LbDIzG3k9DovpDEe3hbkcKG/gGy0pO
	kCNEbrRfXhxm6h+ZWnKLzaPPCTBfQgcGRHdPa9laVB4R4srBdRo7dgzx8Nnr5Y6VCA1dqB
	6Yj8c6GtisdPxbuc6ys7Qrqyp9zYK+ZA82wuDJBRXL99FnB5ylI/CFPIfrGbDqjIGaOJvZ
	kF2yf3Ju0wgKapobQxMVttUxgwq8HSEtQo4OCiKUI8pKlAdzUXKkhcQypCKa5KnFRny9Ly
	E9AxM2s4TTKd2ejwAlyI7nGl91W66NBgbsxzA2v/of7ieCW5amVYD2zyjIo3Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741082994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dGrYAp2UYRB4ahPvzjkNTvyhBhRpzSJnkRhzP34zvcs=;
	b=P7Qostk+Q2bXrVqb2DnypZKDI/nn16FYUiL0Zw/eiCQzbwL+O6vI00L7Pq9mXI4tuuItMZ
	+mtiNDa5jOQadkCA==
To: Jacky Bai <ping.bai@nxp.com>, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc: kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 aisheng.dong@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 shengjiu.wang@nxp.com
Subject: Re: [PATCH] irq: imx-irqsteer: irq_count can larger than registered
 irq
In-Reply-To: <20250304094513.1964356-1-ping.bai@nxp.com>
References: <20250304094513.1964356-1-ping.bai@nxp.com>
Date: Tue, 04 Mar 2025 11:09:53 +0100
Message-ID: <87bjuh6r9q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 04 2025 at 17:45, Jacky Bai wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>

Please use the proper subsystem prefix as documented:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-submission-notes

Also 'irq_count can larger than registered irq' is not a sentence and
tells absolutely nothing what this patch is about.

> The irqsteer IP itself can support up to 5 channels and each
> channel can support max 960 IRQs per. The actual number of

Can you please write out words, i.e. interrupts, hardware etc.. This is
a changelog and not twatter.

Aside of that: 'per.' does not make any sense. 'per' wants to be
followed by a noun: '...per $WHAT.'

> channels and IRQ per channel implemented in HW is SoC related.

> For previous i.MX SoCs, normally only one channel and max 512
> IRQ is implemented, But for i.MX94, the irqsteer HW is implemented
> for 960 IRQs, even it only has 384 IRQs connected.
>
> That means on i.MX94, the 'irq_number' is 6 but the 'irq_count' is

What means irq_number and irq_count here? 

> 15, so we need to increase the CHAN_MAX_OUTPUT_INT to 0xF(960 / 64)

What kind of math is 0xF(960 / 64) ? And what has this to do with
irq_number=6 ad irq_count=15?

Thanks,

        tglx


