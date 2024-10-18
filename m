Return-Path: <linux-kernel+bounces-371290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0C99A3948
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D911C2105A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A918FC7B;
	Fri, 18 Oct 2024 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R5OOXKMH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9HZqYjxJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB218E025
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241867; cv=none; b=lbq8q7FLUkY7HxLlgsaGA6ByZ6KWBylmZInJM/43kmVsxwWOP6taibjRRtF0iXEOvv2aPl4QUmTB2BLZGn/5I39AfGdwyZFo0RMTKDsh0FTbG49PhQr6JYKGrhXxGjwubeZnkT7j2g2060maeAG/AJCeBai/NQbaQsOE4Hs1Mx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241867; c=relaxed/simple;
	bh=W2Gf3kpzk/qEdnYxuslcKYjzw866coDZLbiES4Se7xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OcFgNiqa6IyBa2Z0CRMyQHJCa49scf2R67A29w5f00f7wVS4UcVirZeYJ8tP3CNh6sW/feb1ocMlMPHRcuKqn4gYK4dcN75oBL8OQ0rY6cf4lWImzb8xwSXmTOhmOf/NrQnyXMvHF9SpVkNGrnQlGgQYGUnav/ukNkcUpISlplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R5OOXKMH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9HZqYjxJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729241864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=he8SfjQkv2RURZO75uoVnm6b9puEZfL50Gs/fmXGs1k=;
	b=R5OOXKMHv6BnwO2vHiFjJpG6zrtS60SnS58gtFsDsf/qpo8RLa06wG9ngZ9poQo2F/xPZe
	ZlBTliJ1z2Yqo0NWrWDzYVglasbpzBdQ6bPBgxAGq0UcSXsUzwbd8Ugs+sC0IRb7JaNcKm
	8CfNFGJor4sfmP+SIqW4wIsID/XoWUR4KZarA9uRphBM8Yp+dCyiLEsOqfixK/pw6jGsVi
	hhSayM7cW1MKhKq7Y80QyPwNgHtXecHsivF1062nkPGImNiNUgr+PV5q8m6lUJrcjcaMM4
	/HbgjSrVdSNejlJCO2ck7t67YtjkvT0c7YUK7nUw4TLk2+tW/FyKUq6myRKUGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729241864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=he8SfjQkv2RURZO75uoVnm6b9puEZfL50Gs/fmXGs1k=;
	b=9HZqYjxJjySdfbsqCvWs9aAOL/5V+Vw/qJ+NxJMj324ajmxKfB8EVm+fcpyyF45Y94lcKX
	96o46w0OonzNulAQ==
To: Zijun Hu <zijun_hu@icloud.com>
Cc: linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] genirq/devres: Simplify API devm_free_irq() implementation
In-Reply-To: <07f223e0-9a42-4637-a081-a057025e216f@icloud.com>
References: <20241017-devres_kernel_fix-v1-1-4aa0d7c4fee4@quicinc.com>
 <87y12m8o76.ffs@tglx> <07f223e0-9a42-4637-a081-a057025e216f@icloud.com>
Date: Fri, 18 Oct 2024 10:57:43 +0200
Message-ID: <87sest94ag.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 18 2024 at 06:36, Zijun Hu wrote:
> On 2024/10/18 04:33, Thomas Gleixner wrote:
>>> It is simpler if devm_free_irq() is undoing what any devm_request_irq()
>>> variant did, otherwise, it can avoid wrong and undesired free_irq().
>> 
>> This is confusing at best. What's the wrong an undesired free_irq()?
>> 
> for current devm_free_irq(..., irq_A, ...):
> it is undesired if irq_A is requested by request_irq().
> it is wrong and dangerous if irq_A was never requested.

There is nothing dangerous about it if it was never requested.
free_irq() won't find a irq action which matches devid and do nothing
than emitting a warning.

But that's not relevant either because there is no matching devres entry
when the interrupt was not requested via devres_request_irq(), so
free_irq() will not be reached because devres_destroy() will return
-ENOENT.

So all this change does is changing the logic from:

devres_free_irq()
    if (devres_destroy())
        return;
    free_irq();
    
to
    devres_release()

where devres_release() does the same thing as the above, i.e. it looks
up the devres for a match and if found, it removes and frees the devres
pointer and invokes the release function which in turn invokes
free_irq().

So in terms of code logic this is exactly the same and does neither
avoid or prevent anything.

All it does is sparing a single line of code.

Thanks,

        tglx





