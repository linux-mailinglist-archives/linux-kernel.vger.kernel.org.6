Return-Path: <linux-kernel+bounces-571665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C631A6C069
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D2817CBB7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291BA22CBC4;
	Fri, 21 Mar 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IZib4ih0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GEYGpQCM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D722CBFD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575505; cv=none; b=o6nQBf9GipacJrP7xUdkHAFwwQiYj6lBnVlC+yWl640i5LKWKVn+14eYTuTCOWb1Yl3IYNil+ZGjWzR1fsoMhXPhBDGH7W4QRo9yWfy1bz7ZPRQZjHTE+m9I+Mqdjys5o4sMEHheADklUh0taQehl9CBuTOhrc6DYN3YujqaQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575505; c=relaxed/simple;
	bh=n489pTkthD/IVo4vNeww2jBMm9ymO/XnkZtj8ojplPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B5Mtg/+33+BcysTDZFK3nsgSYcbhNxOKvNc5VOKvvaHzyfoGf6lZ35uLeX1qJVQCjaTVQsgJQ6BK+IYHv6PKrtDEbCr3SLw/9SU9gdW0HgTqOZlq4ynSjDWb8pYrQxAGNIvyMGYogM6hLpWQ5HTSNSZmEwjYE7HbkExuz9abMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IZib4ih0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GEYGpQCM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742575502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+UWHetQY5W0wEpNt+ltL/woe+32rLHYPTXlYR/LExw=;
	b=IZib4ih0AmQnAlfpAL9UldH+OcC/5Ao3DennVmTWpHigjRz53xeJfLj3MTzIqt44Icvglm
	7qYoZLikDDsExYh9SoB13gQ94MvL7zrLD99NrSfxr017vepE/K1uundsmbmjeYYJuhASEa
	uhf3BZg0lUF7Md8KOOoANCc4fopQLj8NUME0/5cNkFgJlYcMOm2jX2aJMHZ6VOVzIZidBw
	nHSn5/AKmIbgPo+fqC84O6rZZjM0aRodyI9PIyEQheHPtI1wLPIibP7QVzz3+NefK4oKtG
	HlT9nSiHJ3x/aYi44tCmqctrBeuzps9leZrKl87HzMCCjnAUlSErb18C/WNMTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742575502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+UWHetQY5W0wEpNt+ltL/woe+32rLHYPTXlYR/LExw=;
	b=GEYGpQCMPHSnWAClp8t2I1S8kfCEmpHzCfC/t9QAcV377XSZhFJiEBofVBfxI2FeGg5WuY
	DMhiiRteFDrk45Dw==
To: cuiguoqi <cuiguoqi@kylinos.cn>, anna-maria@linutronix.de
Cc: frederic@kernel.org, linux-kernel@vger.kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev, cuiguoqi <cuiguoqi@kylinos.cn>
Subject: Re: [PATCH] hrtimer: Fix the incorrect initialization of
 timer->is_hard
In-Reply-To: <20250321020341.1404557-1-cuiguoqi@kylinos.cn>
References: <20250321020341.1404557-1-cuiguoqi@kylinos.cn>
Date: Fri, 21 Mar 2025 17:45:01 +0100
Message-ID: <874izm2v02.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 21 2025 at 10:03, cuiguoqi@kylinos.cn wrote:

I have no idea why you think that sending this patch to
sales@linutronix.de makes any sense.

It's equally useful as me cc'ing sales@kylinos.cn on my reply.

> When PREEMPT_RT is disabled,there is a possibility that
> timer->is_hard will be incorrectly initialized.
> When creating a high-resolution timer and setting the mode to
> HRTIMER_MODE_ABS,the timer->is_hard will be incorrectly initialized.

What is the consequence, i.e. malfunction, of this being incorrectly
initialized?

Nothing as far as I can tell.

So what's incorrect? It's slightly inconsistent and confusing, but not
incorrect in the way that it causes malfunction, right?

If so, then please say so. If it causes malfunction, then describe it.

>  	timer->is_soft = softtimer;
> -	timer->is_hard = !!(mode & HRTIMER_MODE_HARD);
> +	timer->is_hard = !softtimer;

Now timer->is_soft is always !timer->is_hard, right?

Which means that one of those flags is superfluous, no?

Thanks,

        tglx

