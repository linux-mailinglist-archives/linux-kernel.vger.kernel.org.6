Return-Path: <linux-kernel+bounces-253344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CA1931FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE3A5B21741
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569981643A;
	Tue, 16 Jul 2024 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DFq1Np6d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gKYycB05"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231314277
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721105786; cv=none; b=HPMrGX7Sw4dB8jZ/XHVWJpInt3by7SYw4A+Kav2VTcP86KRpp9EUR/gSLvIaubLc0MMW6jDXW0O40dpiyMHW1XUmkxKRitDN9IMrThklheC1gAQrhookmeIt4QzLgKolQshLUOUFPNUFxNkIj4rC/3ghE18oXIsL3LZeK22d6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721105786; c=relaxed/simple;
	bh=syOYvpmYJoomQOVv9UITH+FD6N5mSQUr5UHI5OXJuWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cuZcgfEby35JUAIZDQkRIJ5fgDTp9o+CVo6u3i6bn3apbH0wfyCqCgPOtFGZ+7zXIL0fUV8p1PrrEgfTGgSxCKO1hOdwrGxqUQYthvF67nFgKsXFbqUUTngIQhR5NQxI40HvjZ/03uaGkwgs5+vXSDuKnOExR67pS1l7KYbshLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DFq1Np6d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gKYycB05; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721105783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drhMb3NY44UZP8hK4Ge06hvrMhr6F+cON6IP/ctV/n8=;
	b=DFq1Np6dwv3RMFEy+sDAj0lwelR9V1nJwinozjHHRKzbc42SxXQcB6wefUiZ/P1q4hikUX
	W4oV2Dvyo5Z9gpL2okMnsOfYHLWc21YL6ic5k+rh4DAw2XT/9pi1zuLJ8SCP/qa8+Woi+W
	RFE39yVYK6Q35KiLcV56cRtMBU5sn7T5r414zxDfhdSN/wU1BiltYfJehTN3a1PYmMB8sk
	6nSs8E8vCGXCrdf6wptoppgmEZIT8/gwwOmFlJkrPbbr7t8AOkYz9zCcy6BrLrKzr/zv44
	EKufr+PKTt6G7Isl17++U5FerclSWIHGSuD9BGm/xjPpfNvxA7udkNWDpdFw/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721105783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drhMb3NY44UZP8hK4Ge06hvrMhr6F+cON6IP/ctV/n8=;
	b=gKYycB058nJkV9F1bMnlMUdFuhvN4OLB47+wfthd2AqxwR2w2Y4aVeRo6V7qo1MbhAhwFm
	UDEIS95H2NYfQqAQ==
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Zijlstra
 <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Jiaxun Yang
 <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v2 3/3] LoongArch: SMP: Implement parallel CPU bring up
In-Reply-To: <20240715-loongarch-hotplug-v2-3-7d18b3d46b11@flygoat.com>
References: <20240715-loongarch-hotplug-v2-0-7d18b3d46b11@flygoat.com>
 <20240715-loongarch-hotplug-v2-3-7d18b3d46b11@flygoat.com>
Date: Tue, 16 Jul 2024 06:56:23 +0200
Message-ID: <87a5iiq6iw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 15 2024 at 21:35, Jiaxun Yang wrote:
>   */
>  void loongson_boot_secondary(int cpu, struct task_struct *idle)
>  {
> -	unsigned long entry;
> +	unsigned long entry, stack, thread_info;
>  
>  	pr_info("Booting CPU#%d...\n", cpu);
>  
>  	entry = __pa_symbol((unsigned long)&smpboot_entry);
> -	cpuboot_data.stack = (unsigned long)__KSTK_TOS(idle);
> -	cpuboot_data.thread_info = (unsigned long)task_thread_info(idle);
> +	stack = (unsigned long)__KSTK_TOS(idle);
> +	thread_info = (unsigned long)task_thread_info(idle);
>  
> +	csr_mail_send(thread_info, cpu_logical_map(cpu), 2);
> +	csr_mail_send(stack, cpu_logical_map(cpu), 1);
>  	csr_mail_send(entry, cpu_logical_map(cpu), 0);
>  
>  	loongson_send_ipi_single(cpu, ACTION_BOOT_CPU);
> @@ -525,20 +522,10 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  #endif
>  }
>  
> -int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> +int arch_cpuhp_kick_ap_alive(unsigned int cpu, struct task_struct *tidle)
>  {
>  	loongson_boot_secondary(cpu, tidle);

What's the point of this indirection and why is
loongson_boot_secondary() global? The only caller is this function, no?
  
Thanks,

        tglx

