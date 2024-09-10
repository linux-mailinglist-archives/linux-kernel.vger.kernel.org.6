Return-Path: <linux-kernel+bounces-322318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC997274A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5D31C21F37
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1A149C61;
	Tue, 10 Sep 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="HWlnnbac"
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA03EEC9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725936030; cv=none; b=ZD5izq+bnP3uP/kSrW2mIftyHsZiDgHjw7FZdbPe9QmOL7ZwS58iVXAAXA72PRhLs1VIgEUJKlLO09VIMsEgo/T/aWV6ZKoFhfWelyRAd2izOY8+yxisrrC2pkum21vJSxhHZUsUVthIQZvm6kSH8JeP1nf8IB2Gz9JlzReaa2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725936030; c=relaxed/simple;
	bh=46xTTPwnWBchAQHybHJcNZNB9Zo/4SV48mhuWkgpixQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orp84RyhprF+tNo7BSLCY75M/6r/AU+tcKCVxLsnLrW0lCeZUFIaNofbc4Mfgnbe6JcOSWPgP6eD+6zctz1xpy20fp0pZnEi4XcagZ5AC/bjXaxvItx5bbdrMxnEpwz2olX0Y99J2fXlH8K8Yv3hil7Vnri6TfQDJav9AOSvtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=HWlnnbac; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id B5B5120113
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:40:20 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 568D03E953;
	Tue, 10 Sep 2024 02:40:13 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 0A76A401AF;
	Tue, 10 Sep 2024 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1725936011; bh=46xTTPwnWBchAQHybHJcNZNB9Zo/4SV48mhuWkgpixQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HWlnnbac+YgHD7nW+3TrMArNHmbcve/vPwa8lynBH81/CxzsDWv8HCd1s2gfIGk2t
	 jUkZdGkAhxhcaiwCiwHr4Ng9JmmOSivuaQyxgOWls0goWHtqwW3tkZRz5tbtFJ5T7n
	 H150KpcNEO0zZqhjN4oy/fL8LiMq4jCxSr/FXVU0=
Received: from [127.0.0.1] (unknown [38.207.154.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 1DB46410D0;
	Tue, 10 Sep 2024 02:40:04 +0000 (UTC)
Message-ID: <f9070564-4672-4aee-8e63-c9ca9d985f4b@aosc.io>
Date: Tue, 10 Sep 2024 10:39:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Allow to enable PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Clark Williams <williams@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 John Ogness <john.ogness@linutronix.de>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>,
 Will Deacon <will@kernel.org>
References: <20240906111841.562402-1-bigeasy@linutronix.de>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <20240906111841.562402-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A76A401AF
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Sebastian,

在 2024/9/6 18:59, Sebastian Andrzej Siewior 写道:
> The printk bits required for PREEMPT_RT are sitting in linux-next. This
> was the last known roadblock for PREEMPT_RT. The RT queue has
> additionally the "atomic console" for the 8250 UART which is not yet in
> linux-next. This means "legacy console" behaviour as in no printing from
> atomic context in emergency cases. The 8250 UART driver is the only one
> providing "atomic console" support as of today.
>
> With the printk bits merged, PREEMPT_RT could be enabled on X86, ARM64
> and Risc-V. These three architectures merged required changes over the
> years leaving me in a position where I have no essential changes in the
> queue that would affect them.
> ARM and POWERPC have a few essential patches left and I lost track of
> MIPS.
Congratulations, it's been a long time coming!

I'm wondering, for the architectures not included in the enablement this 
time, do we have a readiness checklist/guide for maintainers to refer to?

Thanks in advance.
>
> Sebastian
>
>
Best Regards,
Mingcong Bai

