Return-Path: <linux-kernel+bounces-263158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2934793D1C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D626F281AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73773179663;
	Fri, 26 Jul 2024 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3T9mXjyi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zBwsZydH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87B1EF01
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992378; cv=none; b=RgzOgQEw/w1NC7JOmkA2nqTP3839zqMAlAn0p/ofiXzDqVR6thr5qVfU7/DvmGxsliB2ZO2UnyFTrRVf2siIqZx/6DiOrcBh7KcXcrGxqdpb8lRikotCDOeU2wMQnhY+W96+D1uEbRWqOghlLQNOEaiKjiJ5w2Atx05oc8bgkYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992378; c=relaxed/simple;
	bh=nMKUTmWMgsjXlZUYFwK7TKXtNvLkxxn4s85M2l2ojs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zra257sgzzcsHJV1FqBoK5wUsKRHKBdlyDjeRb0rp+3HJtRo4Hx44kpCklcMLA9RNr2htIPiu1JtCyjxbuYl5E0e8YZ8nqEEOSZdfUVh0C98/NqFA1lIuwe57yuSxNeoUuwBRQVokOoDtjOMwqDIPkZQ0LPMvYn8Q7Fjw+chb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3T9mXjyi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zBwsZydH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721992375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nMKUTmWMgsjXlZUYFwK7TKXtNvLkxxn4s85M2l2ojs0=;
	b=3T9mXjyiiEapMkP9EVmjGW6z6WbDN5C17UNW9VfxzWj5C/YMt5aukSTfD8OjYGkHpXda9c
	Za089FAa1weog1mKL1nEX+0f3gjtWPG6xR+EA01yQO/qdbEUEbTALMnTMpAhJG6WRN3gik
	jO7dS4hQVGO7mdLe32LXIWNEXdtzrrCTUJGGc0aPzKlSbcxJGsDwK8OCodTnx5FJphV9Ji
	7cMvV24DIdKczR0Op7FyjfgOTXvu83/vwb75D7bs0M+rRVByyIqn0JYE9IfKneu/OEmtER
	AbnmaXHJiseyywvqCnXf25ukANz3pyRD7dX2vR2/9a819EtRgUPDiRKyPIpxeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721992375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nMKUTmWMgsjXlZUYFwK7TKXtNvLkxxn4s85M2l2ojs0=;
	b=zBwsZydHm0LtDuwjTPm1IU40yoQ2sJSTCwq+2F74H2R3RtcTYZCjFBonTKObdHohjfidVX
	4RAnxiEva4K95cCw==
To: patchwork-bot+linux-riscv@kernel.org, Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/riscv-intc: Remove asmlinkage
In-Reply-To: <172191363918.6240.8119408289460257884.git-patchwork-notify@kernel.org>
References: <20240614151955.1949-1-jszhang@kernel.org>
 <172191363918.6240.8119408289460257884.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jul 2024 13:12:54 +0200
Message-ID: <874j8cwgnd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 25 2024 at 13:20, patchwork-bot wrote:
> This patch was applied to riscv/linux.git (for-next)
> by Palmer Dabbelt <palmer@rivosinc.com>:

It's already upstream: 722c9389c7fa ("irqchip/riscv-intc: Remove asmlinkage")


