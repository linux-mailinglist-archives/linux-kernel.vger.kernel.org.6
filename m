Return-Path: <linux-kernel+bounces-299936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C28295DC71
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9071F22887
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 07:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F61547DE;
	Sat, 24 Aug 2024 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="INAlDDzn"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062AA14F136
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484333; cv=none; b=Wygce0xSJzC+0IXTJwEJdbFiAhv2gGQG5oewpDrbUNUJWBM0Zq3r3nQTGs6Hy6N1+VhoxYIp9xx4rz1WyLAmPlFV276sA9GDApwVkr+KTtTY466IDmlsZLWaJoqa2W1APLnlKZA+gmgxPJi/7Lbqf1QiLFCe7wUvN4kYfRXmmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484333; c=relaxed/simple;
	bh=9cJghPE6mR+q8eXvD4wxfHpw8V7ONgRyZH7zbM10Fmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/JkfEwKgkhLu3MCoECjzG+LxQsC3xN7zNsgfCNfgUPrUguiM/JXcW/MVr+UvOf7rKt55F4oJ1QML4FJxvPFepSXAGDN9bvcyzLE9mN/k/79JZS0p0xEn/UkOemSq6FDi8JUrd5+iqnaqFA79Dl8u03wDp8QvWBT0C1vXfA+xCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=INAlDDzn; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e7b031d7-3916-4d6d-8dfd-70412c5d24b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724484328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNwpW+dhI3WcSvOhMblfwuy4AIQGE/JpZhutqjIXD2o=;
	b=INAlDDzngoIIvdtm/MNGjx50dbg5lBZorHHqNHLIck2oYngJqm+hrEFyowHiWNDqj2IRZP
	w81qDZ12ZPBqdr0wRbAbc5Id9y6qCSvYCAXG/xyviyDBVsQ9aQ3z5echO/6t3ioe8zGBb2
	ZuB0zom6UYUx2eSSWYrBOz0BTlP6tjw=
Date: Sat, 24 Aug 2024 15:25:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] pstore: replace spinlock_t by raw_spinlock_t
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240819145945.61274-1-wen.yang@linux.dev>
 <2024081925-opposite-pessimist-9b98@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <2024081925-opposite-pessimist-9b98@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/8/20 01:45, Greg KH wrote:
> On Mon, Aug 19, 2024 at 10:59:45PM +0800, Wen Yang wrote:
>> pstore_dump() is called when both preemption and local IRQ are disabled,
>> and a spinlock is obtained, which is problematic for the RT kernel because
>> in this configuration, spinlocks are sleep locks.
>>
>> Replace the spinlock_t with raw_spinlock_t to avoid sleeping in atomic context.
> 
> This feels odd, is it only an out-of-tree RT thing?  Or does this affect
> in-kernel code as well?  What prevents any normal spinlock from sleeping
> in your system configuration as well?
> 

Thank you for your comment.

If we enable PREEMPT_RT, it will also affect in-kernel code, such as in 
the following scenario:

echo b > /proc/sysrq-trigger
   - sysrq_handle_reboot
   - emergency_restart
   - kmsg_dump
   - pstore_dump
Obtained psinfo->buf_lock, if there is a lot of error log in the kernel, 
it will last for a long time

If the system unexpectedly crashes at this time:
   - panic()
   - kmsg_dump
   - pstore_dump
Attempting to obtain psinfo->buf_lock while disabling interrupts and 
preemption, but since this lock is already held by the above process, it 
will result in illegal sleep.

--
Best wishes,
Wen



