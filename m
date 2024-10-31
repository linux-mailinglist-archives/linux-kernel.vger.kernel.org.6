Return-Path: <linux-kernel+bounces-390556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23249B7B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED981C20B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B495B19D8B4;
	Thu, 31 Oct 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R1QbpqJ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XVobfpzT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E91465A5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380176; cv=none; b=L+rHLvwUVQZIlMEx2cyFIFPXjzZCcE8/KyzAYv3Epbv0DCDbkEJHh14cycdEAcVnub2vEChLC2GUCrOkYPRsYXxudQ9HY9Yk5N1jhI8P960AMVpDFndDl1tcWeLraYioZBafpeCpT8Mq0rezzfrVROGAsL4doSDN1yjT/NOM6d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380176; c=relaxed/simple;
	bh=SH8+d+sp1L0q61ye3hYxOj6jjeTHCKUrE8yugA+gXcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lebV+VKqtO84wf43mwH+ORt1+S7dpg+T+lE6/I9dJKJtKn0MKwJ17FGd+ZTJQkz9XTqmgkcih1G6quXO4FFyyp6DTuiDPxmPh5pm8pB+PmOMLEdQ2Qigx596g8zxTvSTzUIjdggejyvshj29IvKpXIy2cIk0WA1QVCwrzhjc5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R1QbpqJ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XVobfpzT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730380172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciN+nyayTKz3wqHR14S67B36whOAcWTkEZbgGRT8BkA=;
	b=R1QbpqJ7HHLYvc8ElG+Df3/6fsczqpTSSLqrRvVhjemOUXLKOnuEzAxdogFwJ4amSrPTK9
	N5AIGSwe2qg6aMtBU6WtOXygFJvEjhsY/fEPTFVCNNj1u65M0uQZvabRcwKJqjNaLVfj7w
	WWQwLiB8o0vFoJUknXNIbenCFf4MoB4gD5427fAXl1xT1gAQbt1rH6WGyXhREGuXnF+oTZ
	Crqos+8EktsUAfnBC+C0Q6/rJDN79yGJfpyxOgKYzRdM//7pwQ8/oP7kkztQoiV+ONR0wL
	XTZ+FAVa89Zm6k6xAqPAkdHcO/eAVbUCulWdUUQGvvd7LNO1eo15QrbUnYEbaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730380172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciN+nyayTKz3wqHR14S67B36whOAcWTkEZbgGRT8BkA=;
	b=XVobfpzTcC3Fz6r+hITkj8ozqmLroPvvVzBQlV2BW4Mjh+zRYCHKjmrk/VMf99h6ch19ZB
	ccgaeB9PmcT2f9BA==
To: Marek Szyprowski <m.szyprowski@samsung.com>, Frederic Weisbecker
 <frederic@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>
Subject: Re: [PATCH 02/10] clockevents: Shutdown and unregister current
 clockevents at CPUHP_AP_TICK_DYING
In-Reply-To: <82382d49-cbd1-4a03-9402-bc7d41bca9b9@samsung.com>
References: <20241029125451.54574-1-frederic@kernel.org>
 <20241029125451.54574-3-frederic@kernel.org>
 <CGME20241031121635eucas1p19f01e659d411ceac3b934641bdb457b0@eucas1p1.samsung.com>
 <82382d49-cbd1-4a03-9402-bc7d41bca9b9@samsung.com>
Date: Thu, 31 Oct 2024 14:09:31 +0100
Message-ID: <87ldy4wh9w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 31 2024 at 13:16, Marek Szyprowski wrote:
> On 29.10.2024 13:54, Frederic Weisbecker wrote:
> This patch landed in today's linux-next as commit c80e6e9de6ae 
> ("clockevents: Shutdown and unregister current clockevents at 
> CPUHP_AP_TICK_DYING"). Unfortunately it breaks booting most of my test 
> systems (ARM 32bit, ARM 64bit and RISC-V 64bit). Reverting $subject on 
> top of linux-next (and fixing the merge conflict) seems to be restoring 
> proper boot sequence. Here is a log observed on QEMU's ARM64 'virt' machine:

It's fixed already. Refetch the branch (force updated).

Thanks,

        tglx

