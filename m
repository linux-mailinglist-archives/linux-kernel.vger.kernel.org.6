Return-Path: <linux-kernel+bounces-170258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830C68BD435
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA692831DE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22184158873;
	Mon,  6 May 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yz0LYfni";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q7kGooUr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100B158844
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018108; cv=none; b=BPo5JoBPQIEIJl6J8e8p38HK3SXdUkHXqeR6fGwped66C/SACEnNBlToo8mjB/tYT8fel2grVWkFFxwSwbLdEwvDbSB9n9jfzgDR7j9sNS/Raux8vWHwqHjVgpR7uFy+sSp5a0aUUiGz4RzDzgb6agU8dCWgTtgL3OHHQDOEXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018108; c=relaxed/simple;
	bh=n27Qz5MtRxSJNQb6ApH8VngkuT8JGmIHQ5xZYNGihXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s3mvBuHwITfDLJZGo5OnxEVMXZRU9yYBn+CdhIS7Cdby0bdANNmfZOI7/fJJzurAHziBDGSjN2WcIQfxSZa77KT/SNCEpbp6j1HJq4nk2MzS3iAssuPVNEudsY3xrYWMA+bMEUCqmbDll/ntXLQUAL99bydc3YcxOzR2lRKBYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yz0LYfni; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q7kGooUr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715018105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U51dnmYHkLKYOuLjpfA/M9qO4l6bj3W7dZL4udcjMGM=;
	b=yz0LYfniCXAqDLQpoqs2QJTst6IGAckzLShFyVDzoht69vAPo5gvnsJq8uYd2pDr4j5S+N
	i/KmTlM+StmxVxnXP6Z8xseVoSUHM96QiiyMQXItk9vhGCAQ8SicQk9qm6fQrVjtn06tCL
	ZIhCOP9YBje7c1rE1ykEbpK4/Hmb5fLb8W8ddv5eD7UJsOHlDAbLBvwWJhJC+soKfRewao
	0mjnLJcav2d1gkY5llEaFIH8wcrgEkwrM77OB84BkO58te3CfUx3s9s2lUaO/rMhP6Z2Wt
	TLSiTaa8NuYzh0m/Qy9Wfp2yGY6kA73TTd+KeMZNmzw7IjzdFq7d3vKKYuOQ8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715018105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U51dnmYHkLKYOuLjpfA/M9qO4l6bj3W7dZL4udcjMGM=;
	b=q7kGooUrRBeypvxmuEZeZ3ywzccEJ7NeyBhKMk479RoRLt58eK1/EvddwtMpTLN0h9cddc
	uZDa6VvliAloLmAg==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH] genirq: Simplify the check for __irq_get_desc_lock()
In-Reply-To: <20240506125057.307586-1-ruanjinjie@huawei.com>
References: <20240506125057.307586-1-ruanjinjie@huawei.com>
Date: Mon, 06 May 2024 19:55:04 +0200
Message-ID: <87seyurfk7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 06 2024 at 20:50, Jinjie Ruan wrote:

> If it set "_IRQ_DESC_PERCPU" in "check" but the desc is not percpu, or if
> the desc is percpu but it not set "_IRQ_DESC_PERCPU" in "check", it both
> return NULL, so simplify the check in __irq_get_desc_lock() with "!=".

What is exactly simplified here?

> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/irq/irqdesc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 88ac3652fcf2..6c52deb134b9 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -882,11 +882,7 @@ __irq_get_desc_lock(unsigned int irq, unsigned long *flags, bool bus,
>  
>  	if (desc) {
>  		if (check & _IRQ_DESC_CHECK) {
> -			if ((check & _IRQ_DESC_PERCPU) &&
> -			    !irq_settings_is_per_cpu_devid(desc))
> -				return NULL;
> -
> -			if (!(check & _IRQ_DESC_PERCPU) &&
> +			if (!!(check & _IRQ_DESC_PERCPU) !=
>  			    irq_settings_is_per_cpu_devid(desc))
>  				return NULL;

The existing code is readable and obvious. This is not.

Thanks,

        tglx

