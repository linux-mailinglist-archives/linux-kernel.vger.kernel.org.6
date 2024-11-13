Return-Path: <linux-kernel+bounces-408205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BDC9C7C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74782B264B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463ED204001;
	Wed, 13 Nov 2024 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PioDHrV3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QJpMZa2B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE115ADA4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524998; cv=none; b=SPUn1Mx13enh/2kw34bqNnYTKGpn4tqE0BSBIKfQDkEn5FkkYwVAJkwq9mB/ljxvU8MWus0Bfmiq/n6AzY/qH59gqMwFgRbjHN4w/xQ+YWbi+Bq9045BsH+3X30eudHhyO/7Jj9WcJk8YQlanXDl5VcJvexLjfx3lAmC6gDacZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524998; c=relaxed/simple;
	bh=nuMJdn0vO4BlSljFOA9TRpDiV4tyCUGTs57BO2pxi7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aT00++T6HQg1oqceuP933Tmv+tyoBFDCfKJpaDVYER76g59IbWbFT6NfbCHQeZVvQ/xZnqDCGOp5akvN+38vflL9jkvaSGaJUc60zhdLT6rs4xLqctcu8YVkEZlFzdbxDuyFCpRVFBfNoszJ/0RX1ckll+t+WFXEuCEPiHf9Hk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PioDHrV3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QJpMZa2B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731524994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xA/h1AmdIDv6i2BzDTtnig43OB2tag+5jBBHNqpA5Ks=;
	b=PioDHrV3e1XLWVTsFrcpLDSo+qVuHPO+He22liD5tntPZF9wZyv6J8yXOZysaVS9Sg+ogN
	Mjzgy6j1E+WCa1+mSvI2Cdq4S2dQ3ojfwJ3QWmC4ZjKRpZAc0pOfmj/7nXi7n4/0VlhIHw
	+7bPayeteNOLtnV7v/aIyiLbYu7M5Z/rppqar1lIkMs89QypCr4qIemj+J3wu4dISnzkmU
	JOwfurm3lOQXDMWmPeglAb1e7UQhVWraDZKAQPN3oZKz8TfAxB4z73BuIbV0lEzzDWPzp6
	+HvuG22doX3rULJREpPht6ie5J0kXNMqyNZo70k4ovf/Oe3yE/zWAvqhEp/Avw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731524994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xA/h1AmdIDv6i2BzDTtnig43OB2tag+5jBBHNqpA5Ks=;
	b=QJpMZa2B8Vpj6XK5/sY/j2ydNJHWKQyGAGnKl7GtVm9f8Yri9u7EVCuUFB+kKseIdenZQI
	LnOnJ9AR4hVY+LCg==
To: David Wang <00107082@163.com>
Cc: linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 01/13] kernel/irq/proc: use seq_put_decimal_ull_width()
 for decimal values
In-Reply-To: <20241108160717.9547-1-00107082@163.com>
References: <20241108160717.9547-1-00107082@163.com>
Date: Wed, 13 Nov 2024 20:10:08 +0100
Message-ID: <87jzd7kl0v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 09 2024 at 00:07, David Wang wrote:
> The improvement has pratical significance, considering many monitoring
> tools would read /proc/interrupts periodically.

I've applied this, but ...

looking at a 256 CPU machine. /proc/interrupts provides data for 560
interrupts, which amounts to ~1.6MB data size.

There are 560 * 256 = 143360 interrupt count fields. 140615 of these
fields are zero, which means 140615 * 11 bytes. That's 96% of the
overall data size. The actually useful information is less than
50KB if properly condensed.
 
I'm really amused that people spend a lot of time to improve the
performance of /proc/interrupts instead of actually sitting down and
implementing a proper new interface for this purpose, which would make
both the kernel and the tools faster by probably several orders of
magnitude.

Thanks,

        tglx

