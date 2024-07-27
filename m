Return-Path: <linux-kernel+bounces-264033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C8393DE25
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46482B21E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 09:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE1648CCC;
	Sat, 27 Jul 2024 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lbm+CFvA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1WpClalE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081851FB5
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722072333; cv=none; b=BPHvOkKtcAEkrxtGDPSQiQ7OzHC6tYakBRt5IAN/8RX+GiHAnG/z47Eq6jm1cM6/eegbn9PFKZF+reGCp1CnBBNP7V3OWq1VZDu5IiS3irhbQinmzlBRa0IFL4DfaSeRjFZJQOl79FsXnlfHlEAjWbYFKHeyuiipUiIR4AwGCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722072333; c=relaxed/simple;
	bh=e5HV15MhOUdvCohE1w53qqEalr0SiHFoh2ItQK16SwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UKMgDOktem89yzViv6dewmVljAY5G8fJHMH90XESarlR/JkWaLYedABVauZukozax8PT33aD9dyvF2EtO+BrmYL5PtddoJMzZ+wdS1Y5Qhs2XI50erUDm+sYa5hXNQ3WJbONTd5xWp/0jg/YT0+ahlZDJyTLvFiOOzGdJYNTSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lbm+CFvA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1WpClalE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722072323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqgoJW7g7u7HqVS4qFxDoO7rT/lHn05xZnz3i/ktMoQ=;
	b=lbm+CFvAwWkc+6r0ahaP1ILMnN0DRfy+3/67vnyXKccqve05wp5UJJzWkaDCazI04LvEHp
	iMkBmHPSQOG0d/ULkYaJOL/YrN5MKgDAnsNfeRL7HbXllunH72ZmIqoy1P4DKwJuFU+Sqg
	WUqvn3B/kw5Q02aJj+82QvJLrDX3knJZaWww/gfugOXR/SdfDP2p0axNv7KTmzNiEL23vW
	NkJpiHbgddvxGY4HJ0mZA7SllNDsAkbVx/zcOsuNYpRe2A6kM6bQ94LEO3Qc0np5F+WkoC
	l+Jllv0jMaNa6lTScS5QwymJB5DaayfN46aNtfDGysJ+elroBlDdMN7D9szlQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722072323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqgoJW7g7u7HqVS4qFxDoO7rT/lHn05xZnz3i/ktMoQ=;
	b=1WpClalEFCiFnT5MaUoBCEIIWNB2v+tWCBbNCItXXPozuAo7lchhN7/0GcsMP8CSy1gXrx
	A/1aFNJlvNc2UuBg==
To: Jinjie Ruan <ruanjinjie@huawei.com>, maz@kernel.org, joey.gouly@arm.com,
 mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH] irqchip/gic-v3: Remove asmlinkage for gic_handle_irq()
In-Reply-To: <20240727073648.1042377-1-ruanjinjie@huawei.com>
References: <20240727073648.1042377-1-ruanjinjie@huawei.com>
Date: Sat, 27 Jul 2024 11:25:23 +0200
Message-ID: <87zfq3tce4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 27 2024 at 15:36, Jinjie Ruan wrote:
> Since commit 064dbfb41691 ("arm64: entry: convert IRQ+FIQ handlers to C"),
> the gic_handle_irq() is only called by C functions, so remove
> the asmlinkage.
>
> Fixes: 064dbfb41691 ("arm64: entry: convert IRQ+FIQ handlers to C")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Right. Can we please fix all of that and be done with it?

# git grep -l asmlinkage drivers/irqchip/ | xargs grep set_handle_irq

should find the remaining leftovers of asmlinkage.

Thanks,

        tglx

