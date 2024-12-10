Return-Path: <linux-kernel+bounces-440472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02379EBE95
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DB7285A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3663923EC06;
	Tue, 10 Dec 2024 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SOjKMGWx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5aAe3vG/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7123EBF9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871126; cv=none; b=bjnUCjNUaR3rXPZl8AaMQfO7gguguo7Mukb+7UdgYykWqLpIGEZtFWcEcZdG+/+JX2sDDZrRGPNeziBQRZDnNpcesbZ+rf6j7es/AU7EUC9T7XyyKtJ4GHY0q0f2aBsTg8kDrGNhh4WnSXbchT0bnAORG6q/zqrJ6tLgZeahgPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871126; c=relaxed/simple;
	bh=euFvufvuPc0yfa5OA6Zwp2aLlRqCTwBdHn2vaPH5Fww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bWXO0C4GhlCihxsg07jFHONlBFsB3aXwnyFbz3EOZ8EqALVtOHiyQCn6qwJdEZ75pj64ZaZyF32Zd1TqSh83MH+qf4bOOAC+LwbK0QKOr2pKtOV4Wy7CFCeyi2+eap4xAdMvDdwNrufjHX+Av5mqCbCV74qAwW99ZXeOqj/OxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SOjKMGWx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5aAe3vG/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733871123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHG4Wsrq+4IOD2mbry4N+Czu5o/hVxAZA6KxkpHXr+w=;
	b=SOjKMGWxRIUb2CQ3GyJ13LYJP9hvEp80AcvKzrlaqCnWXzi8IXrRMiYpLyFXiDKd5Bm2YL
	YDkrab0yMjrgcdnrmVmnUYq2Q074ajz9B/U5oxOjGvEJAZAsNGqg/SwDpCowje8G8dpg3R
	o/LrRmy/A3mw6mqnvKCUmX/aWsKKcysbmkornjqhdAvv+rs7EScfTMzpYcZ+iSnBO3ZT1Z
	EfY/nnHMyYN1hboCmZvIv/3rrvoJjuhGypUelTiPQyRomh09F4eqzlX5aGtBXT2ntLBpU5
	mrcwyM+/d5sQ8KDRE01grLoTKDxg6DRYtFxo24YDENa3ZEoCJCZ/FtNkVC2q9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733871123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHG4Wsrq+4IOD2mbry4N+Czu5o/hVxAZA6KxkpHXr+w=;
	b=5aAe3vG/7Q0SJ12hxEdf0+Dw34elFPzlm2AaLt3noSFfVpQ/rxTU3GQtQ1TJYyJHTa+x4T
	jfWIWltufiNgiIDQ==
To: Vineet Gupta <vgupta@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Anup Patel <apatel@ventanamicro.com>, Vineet Gupta
 <vgupta@kernel.org>, Brian Cain <bcain@quicinc.com>, Wei Liu
 <wei.liu@kernel.org>, Steve Wahl <steve.wahl@hpe.com>, Joerg Roedel
 <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Juergen Gross
 <jgross@suse.com>
Subject: Re: [patch 1/5] ARC: Remove GENERIC_PENDING_IRQ
In-Reply-To: <00beef4c-fef7-4628-854a-f3da3ba90541@kernel.org>
References: <20241210102148.760383417@linutronix.de>
 <20241210103335.373392568@linutronix.de>
 <00beef4c-fef7-4628-854a-f3da3ba90541@kernel.org>
Date: Tue, 10 Dec 2024 23:52:03 +0100
Message-ID: <87wmg7b17w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 10 2024 at 09:22, Vineet Gupta wrote:
> On 12/10/24 02:34, Thomas Gleixner wrote:
>> Nothing uses the actual functionality and the MCIP controller sets the
>>  
>> --- a/kernel/irq/debugfs.c
>> +++ b/kernel/irq/debugfs.c
>> @@ -53,6 +53,7 @@ static const struct irq_bit_descr irqchi
>>  	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
>>  	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
>>  	BIT_MASK_DESCR(IRQCHIP_IMMUTABLE),
>> +	BIT_MASK_DESCR(IRQCHIP_MOVE_DEFERRED),
>
> I think this leaked in here, needs to be in patch 3/5

Ooops. Yes.

