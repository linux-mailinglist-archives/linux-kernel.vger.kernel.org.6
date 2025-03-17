Return-Path: <linux-kernel+bounces-564311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E162A65282
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A361887A12
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34F5241124;
	Mon, 17 Mar 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="38wMzcOV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MbNC3vgG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90042405E7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220801; cv=none; b=DWBCKRtJQVsmzOn+MU9vDk+4XCAVwhHzvE0Ff3nIHHnV+AqNlVVAjq2frUW/5cBgJHHMfwyDgLMIoGuEJLZ3OqXxWCHEf4rbKdSoX21rPmAf8f4qG2G7/49qeLZF5TTwSUCJ9Txu6Egdz7cRMewgfoPVm6Anne0JRc6VWzcQx7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220801; c=relaxed/simple;
	bh=nttrMiC22XUOZZeCE6J+OZeJmt21H3KZf0SpIOcrUp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H/CgRTuwO0T6ylwaTr8NRlkn456jgLeVjdTQm15bFxE8xPlETW7+BbMqKvZB4tpPQSALLKgKR+wnbqnqTeSeMdv5vs3k6R5abZ6F+xpx9/1qIb1AoiCBaREgqmbLXd575bEUcHqOQO/WDAUnqIZ16yQUIHdi6L6fFmtJNtFjPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=38wMzcOV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MbNC3vgG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742220798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mE08OqTuzsR2/w5zN3sp1pgCrBWoxVxCSSigXCl2u9E=;
	b=38wMzcOVPjNcvdZA4sw4ard8aWVbf8WEwkTwsfWwggtHvL1yPoxCIinzRpSRjPeMlb0yNu
	8nZHoIk8GtYSHbeG2DsaL0DBlrgBb4fJwCONxGHwwtznfyLZxR5aaIYbXq12AA+9I90bUD
	vaZuYb4XmI+K34fFXnHx5AEO7FQy2zI5TcfUQOaKRcsp1A2cOyzoAgS6wVmyDESvSB1gyl
	btO8HEkLSYu/xEIx11t41lucSeSzltABseheKL21mpEGCZCUHUS4IuGnA2hBzcfs8eZiGa
	LCwU3VQeKv1eFRRFmSkSKlnc4OWJHxiWSnCqGlysQgiQ1da+1Cz7grgEGTpevA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742220798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mE08OqTuzsR2/w5zN3sp1pgCrBWoxVxCSSigXCl2u9E=;
	b=MbNC3vgGngFVhLFUKUrXmi8zNYsFaZGhNyorF7fUqF+ezWuXa8/fev3ERWyjXFb7c+LZiB
	uCaJqdTlsojiCMBw==
To: Petr Mladek <pmladek@suse.com>, Donghyeok Choe <d7271.choe@samsung.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 takakura@valinux.co.jp, youngmin.nam@samsung.com, hajun.sung@samsung.com,
 seungh.jung@samsung.com, jh1012.choi@samsung.com
Subject: Re: [PATCH] printk/panic: Add option allow non panic cpus logging
 to ringbuffer
In-Reply-To: <Z9gnfSYnX3r0wwci@pathway.suse.cz>
References: <CGME20250305044241epcas2p45a526aecf91f33b9ac253f561e909978@epcas2p4.samsung.com>
 <20250305044046.1249972-1-d7271.choe@samsung.com>
 <Z9gnfSYnX3r0wwci@pathway.suse.cz>
Date: Mon, 17 Mar 2025 15:19:17 +0106
Message-ID: <84senbpwxu.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-03-17, Petr Mladek <pmladek@suse.com> wrote:
>> +#ifdef CONFIG_PRINTK_CALLER
>> +static int __init printk_debug_non_panic_cpus_setup(char *str)
>> +{
>> +	printk_debug_non_panic_cpus = true;
>> +	pr_info("printk: keep printk all cpu in panic.\n");
>
> I would update the message:
>
> 	pr_info("printk: allow messages from non-panic CPUs in panic()\n");

Note that every printk message in printk.c is automatically prepended
with "printk: " (see #define pr_fmt(fmt) at the top of printk.c) so
please just use:

	pr_info("allow messages from non-panic CPUs in panic()\n");

John Ogness

