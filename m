Return-Path: <linux-kernel+bounces-288076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FB2953321
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6731A1C22E33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041561AAE34;
	Thu, 15 Aug 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AVZ6dA8z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EwKkpvFc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6019E7FA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731078; cv=none; b=uNTKDZEaVZKAOUodjfxnwVo/HqscRFK0nTlNZgH5t9bVB86y/SX0AutT7ugXQ8JUFQl8QB2lL/KFTx5sRbz5U4Lr+owVJwu4jpHivN7iFb3dpPm0Om8Ts9LECQIjEY9c8cnHUbxcSKTTRuF0qKfRepfiUe9letq6XHuekETowog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731078; c=relaxed/simple;
	bh=BnZE5Jpl5lUFiGJHhXUIJqsw0w98rHad8LCRtXFyD7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZHlrrM0Ya7vyDwvS6N5fgWqfv5yz+ezEYv89Dye6yP6FmuRJMN7wds8JVWjLxTYdIW+ewQY6nMRbMVMcUHD9xb8n/SSUgG7zuhPuz8tqenb7bQNFORb7R62kUU1k3akRVcuReQoy9n1d4v2Y6i/Q4rGc9qcu9YKnA3Y88BQG8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AVZ6dA8z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EwKkpvFc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723731075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYjvollJesTtLslkUYJNxH63AP1fPwf99+zNcpu4LzI=;
	b=AVZ6dA8zbr8yWSpoLeCRJQ0yENWLGxaOIgkvFE5/HwbHqg4psAUugYyCC0uzYX8Cue4/s2
	jJp2E59k8QTNhFSdO+EU/t7A6WDYteD7wT1eE+ARj2GwtaBDA0tJeqFcfoGoBEZkw5nzSy
	AdK0HQAbuzwWlb6L9LMh5LFnKY1B5Xp5Y4zCLYzSrHPCKnhcKLzvioZsO19237yPGXVHwG
	Jv2xMJ1u7YvQN8rFbHf1yRMbHhxf3AxW+40G6aklxCXErIcY88uxIFN/91Aw5Db4qjlPwG
	i1shN4TXa/v6x5SwWPlJeMzLmgeTaOIfJLmaWz7suGjhZFTg14qCXEAmaIGcHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723731075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYjvollJesTtLslkUYJNxH63AP1fPwf99+zNcpu4LzI=;
	b=EwKkpvFcNgcVqMSLQHel5aNWHCit5L2msYI4Pn3qHFBhlJpWGd6cDU26O09+fjTNXAVWp0
	dwpIM0JVYLkdFgCQ==
To: Samuel Holland <samuel.holland@sifive.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Anup Patel <apatel@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano
 <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
In-Reply-To: <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx>
 <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx>
 <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
 <87plqalyd4.ffs@tglx> <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com>
Date: Thu, 15 Aug 2024 16:11:14 +0200
Message-ID: <87h6blnaf1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 15 2024 at 08:32, Samuel Holland wrote:
> On 2024-08-15 8:16 AM, Thomas Gleixner wrote:
>> Yes. So the riscv timer is not working on this thing or it stops
>> somehow.
>
> That's correct. With the (firmware) devicetree that Emil is using, the OpenSBI
> firmware does not have a timer device, so it does not expose the (optional[1])
> SBI time extension, and sbi_set_timer() does nothing.

Sigh. Does RISCV really have to repeat all mistakes which have been made
by x86, ARM and others before? It's known for decades that the kernel
relies on a working timer...

> I wrote a patch (not submitted) to skip registering riscv_clock_event when the
> SBI time extension is unavailable, but this doesn't fully solve the issue
> either, because then we have no clockevent at all when
> check_unaligned_access_all_cpus() is called.

check_unaligned_access_all_cpus() is irrelevant.

> How early in the boot process are we "required" to have a functional clockevent?
> Do we need to refactor check_unaligned_access_all_cpus() so it works on systems
> where the only clockevent is provided by a platform device?

Right after init/main::late_time_init() everything can depend on a
working timer and on jiffies increasing.

I'm actually surprised that the boot process gets that far. That's just
by pure luck, really.

Thanks,

        tglx

