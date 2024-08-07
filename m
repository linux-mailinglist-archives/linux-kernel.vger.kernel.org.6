Return-Path: <linux-kernel+bounces-278628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8520094B2A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98422B2138A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A115534D;
	Wed,  7 Aug 2024 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9bAcj8g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5SzbqhtE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D3153573;
	Wed,  7 Aug 2024 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068214; cv=none; b=ilubVYF/rqWdhq0R2XEy1SuVwyZKfQYK4V1ets52V4s932sZJ2Z7aieu/e8Y3rOx3cajsWd+h7VJytWHTmaXLMPEqw664l81F/MH372GtT/KSFbm1P7YD0Ybv7FLgM7qeTCNXcSrRvIwHTyk7evntox5e2jgs1MQSz5ZztbIxlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068214; c=relaxed/simple;
	bh=qc16byn3ghSUeajrTNZZfu67gQEZGCpp2eVLadjMeXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVpXLYitNxzWnLuh6IAhBS84CViHK6zotOTwEYCckfq4/d00Wi7IObelzHd+wVZSFrXuxn2eTTohDaEDLB85NpL5GEJ9OclbjHxGNN99o0ROeR8FeF/eBZMrBn4x35/fBa5Wc/XRwhZbO2DdyhHVByEghmC0qPKXeuL1YIzxCcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i9bAcj8g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5SzbqhtE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723068211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=idaTkTxvS7g1I4rkk4nWkMzXobMXnmoj6e7iBxcCGvA=;
	b=i9bAcj8gKiiZyen0DHRyLVpgB4aVFMyxEZEAwCY8HPddVKm95gomGXOf3u6vANQ7XM8qW6
	HvB8gDS4IEG5/RXSygeQp6bZdkRm/mSTDDvyOyyHUmGK1vKnO4Fn9E1/ec6SqmjbsrBTqA
	oN4cPF/WWz4DjVlNJmP7F/8KRr/5AlYdGLyPxEwVDo74jWlN5BNyuWpmSS+Hc8LYDidPPX
	gtlNjHff2j6bemWV1ToF6W/3+iUJFQRRufEibBXV16QYK6s1cQZRWFIiDwEdEBSh+nu3Va
	xNpQbdLmHWXHveqpImmhJ45gKwkMvD/bDJwgK9g/yWYLBNQAjD6xKavM2jR7/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723068211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=idaTkTxvS7g1I4rkk4nWkMzXobMXnmoj6e7iBxcCGvA=;
	b=5SzbqhtE4+BjdgUnIiN5YcI5ENzYU9H+nGTjXMa5hgvxljYnTJF0VslEWi07NX+xdYqgxI
	ZgDZz9/89EE9+ZDg==
To: Tianyang Zhang <zhangtianyang@loongson.cn>, corbet@lwn.net,
 alexs@kernel.org, siyanteng@loongson.cn, chenhuacai@kernel.org,
 kernel@xen0n.name, jiaxun.yang@flygoat.com, gaoliang@loongson.cn,
 wangliupu@loongson.cn, lvjianmin@loongson.cn, zhangtianyang@loongson.cn,
 yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org,
 dianders@chromium.org, maobibo@loongson.cn, xry111@xry111.site,
 zhaotianrui@loongson.cn, nathan@kernel.org, yangtiezhu@loongson.cn,
 zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V8 1/2] irqchip/loongson-pch-msi: Switch to MSI parent
 domains
In-Reply-To: <20240806115546.4558-1-zhangtianyang@loongson.cn>
References: <20240806115546.4558-1-zhangtianyang@loongson.cn>
Date: Thu, 08 Aug 2024 00:03:30 +0200
Message-ID: <87ikwc0z4d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tianyang!

On Tue, Aug 06 2024 at 19:55, Tianyang Zhang wrote:
> From: Huacai Chen <chenhuacai@loongson.cn>
>
> Now remove the global PCI/MSI irqdomain implementation and provide the
> required MSI parent functionality by filling in msi_parent_ops, so the
> PCI/MSI code can detect the new parent and setup per-device MSI domains.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Lacks a SOB from Tianyang. See Documentation ...

> ---
>  drivers/irqchip/Kconfig                |  1 +
>  drivers/irqchip/irq-loongson-pch-msi.c | 58 ++++++++++----------------
>  2 files changed, 24 insertions(+), 35 deletions(-)

Nice!

Thanks,

        tglx

