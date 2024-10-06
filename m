Return-Path: <linux-kernel+bounces-352580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A39920FD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A8AB21110
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE6018A933;
	Sun,  6 Oct 2024 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UXCB50le";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+RnTSjL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F1F1A716
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728244732; cv=none; b=l2+G1i0USfU6VXAvkfzqJXw8UxwM5NWQjfoPh20eA4xb1iI/ZwcqDwd/13KKSjek+WIUTfKb/2Xg2crd1w4U6ohA7XVFWwJ3hZq8BpqYiH08sBz97GxkoPLTF0J+uYL3qh9Ujq0MeexvkawXI4UVmSbDU6KTyNVAmy8gJdY7gCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728244732; c=relaxed/simple;
	bh=yzhsqsF9oOGQ+EJh5j7sPiN85yqR28UG00mdZ23jRpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YTslsq8DBBmgRcTLzUFytOKD25VJU2zBQnXcSw/xbsV82n7CFcC/knJ5dpQJbBPDR3V+3z73aSGWZLGshUAJDXzGNtsdPi9iPCEYhRGYjSm8PSr/5FxDaQFgKezXA4geiKqrf+OrT80lmLeJqRfu0uEt/oSAYKdzvhhkPooHVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UXCB50le; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c+RnTSjL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728244729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2Rf09BGvVRGoGF7ggkhPU2Hi1s03+6FHwCcsr+Zr+M=;
	b=UXCB50le/uhAYr5DNdVFy3JoG2oA7PSTQ+nwKFxgsOabNZ4QcWYlB9e/l3aAClKhR75snN
	9NSExreDD9yTHSOabeQz5BOAPc8mbd0ST0lthXbRcShJc+NAN4Yopy5USuzrdczHMQ3gnj
	mK964bPqsY97hpyPefcRTfo/XiS/XXsv3hL7kKv6PVhpMpJwjrjiHNKZSRe1mXIZCPy8U+
	J0BZIf+FwLxOw/kIG8ukRn+izs0HNnTKctIx0b9FDUGCvGMJY2G65BFl8Gi2pZdwigkdKV
	11yeccJqOzsqpwF2ufqNrB/XrDThNmL/mafSEDTM9e2LfGyUQvEUl9ez74P4iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728244729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2Rf09BGvVRGoGF7ggkhPU2Hi1s03+6FHwCcsr+Zr+M=;
	b=c+RnTSjL4xmuUq0c1ZM94DCYLVNDXwtVUj6H7N7KgeXkdA6QhcB6szrnHT/U9wZDPtlgyW
	x6HLAcwnsGcHuZCA==
To: Bart Van Assche <bvanassche@acm.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/21] genirq: Introduce number_of_interrupts() and
 set_number_of_interrupts()
In-Reply-To: <b4eabf2f-5c88-4d36-89e3-d27cda0eef36@acm.org>
References: <20240930181600.1684198-1-bvanassche@acm.org>
 <20240930181600.1684198-2-bvanassche@acm.org> <875xqcypds.ffs@tglx>
 <bd377620-7781-4b93-98c1-93f778b74724@acm.org> <87ikuawlm1.ffs@tglx>
 <b4eabf2f-5c88-4d36-89e3-d27cda0eef36@acm.org>
Date: Sun, 06 Oct 2024 21:58:49 +0200
Message-ID: <87ed4tuhom.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 03 2024 at 14:01, Bart Van Assche wrote:
> On 10/2/24 8:49 AM, Thomas Gleixner wrote:
>>> How about irq_count() and irq_set_count()?
>> 
>> Sure.
>
> I just noticed that a macro with the name irq_count() already exists.
> How about the names irq_get_nr_irqs() and irq_set_nr_irqs() instead?

Sounds good to me.

Thanks,

        tglx

