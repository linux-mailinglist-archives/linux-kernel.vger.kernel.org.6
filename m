Return-Path: <linux-kernel+bounces-259767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6E7939CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C259B217A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326E714C5A3;
	Tue, 23 Jul 2024 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eHQQ496o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hvH/b/9M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24614A0A4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723967; cv=none; b=rS2uCBzXpOVEv1anLFji1UzigOYXlmV67TrXacNPh4iltGiVTat24KdM5z36mKAAGwRCJ8twrYdknUz0ldfQmKhJ7hB7gnPka1L4Nfaff5ZBOGtBB6pzNEbGFlLt3N04tX3z5dbcRi9uT3AiseK7GeGPzws+1Z968D0tetXsaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723967; c=relaxed/simple;
	bh=ipT0RnXjheg8iIbNcn4+g+FJIMKZoHPjHapnK77d5g8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PzTaX3b64eioJWj3z96LPmz21DZCpirlZt6mbXuu/iKVJIa5HURW55tEjhsntp3TIyWVP0Nzx7u5zrGR4NqVkUPXH+7vcD0w/wvZS5bet4nRKXo7WHFd5bLBSW1j1t2C/fjX4V5pe9Bc1YN1Nm6/ZaT+oyRZXNmPM4LHjppE/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eHQQ496o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hvH/b/9M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721723963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KYDfW1PS59cduUxwtRKA/m/Clwwf2eO1jg3HqbuLmM=;
	b=eHQQ496o8RLHdYqnLtVO3c6eNySyhGM5fP4XhTtEIkhcSO67i4B8ziZOh1NwUJziv5VIUI
	rY/akKKSD4stsyd6cCfWgE9L9BF5DkaBT47mUO5PnV153iZOtbZONAkaqgl03lzWE1L8K4
	9y293xmF7xQma3xWqFVI/xYPnIfhhcUKz/mZy0HxOvjosieNwzCa8/Y4ihgbTZQBzUK2WR
	YMce+yzy94Tfr7QTB5YFMVd6xmSRKzdGu7fVs6A+150cjVtK35zPBobYGHwI7pPxflfOHF
	QjIeUkVaIvXGnBdvZkw6rIf0J5n1UsCgdchWbeeJCq2zWFryxGu01gz3M6pCXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721723963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KYDfW1PS59cduUxwtRKA/m/Clwwf2eO1jg3HqbuLmM=;
	b=hvH/b/9MT7uzujqiO5QMdc0y81wSs7LvTrXT+EP4QE7D3ru2zxeE2iZIkcXzn55CRJMUkE
	si4wnfg8GdRTWxBg==
To: kernel test robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 07/19] printk: Add helpers for flush type logic
In-Reply-To: <202407230936.FqviIH1q-lkp@intel.com>
References: <20240722171939.3349410-8-john.ogness@linutronix.de>
 <202407230936.FqviIH1q-lkp@intel.com>
Date: Tue, 23 Jul 2024 10:45:23 +0206
Message-ID: <87a5i8biys.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-23, kernel test robot <lkp@intel.com> wrote:
>    In file included from kernel/printk/printk.c:61:
>    kernel/printk/internal.h: In function 'printk_get_console_flush_type':
>>> kernel/printk/internal.h:188:26: error: implicit declaration of function 'is_printk_deferred'; did you mean '_printk_deferred'? [-Werror=implicit-function-declaration]
>      188 |    if (prefer_offload || is_printk_deferred())
>          |                          ^~~~~~~~~~~~~~~~~~
>          |                          _printk_deferred

Thanks lkp.

I will wait for the feedback to this series before addressing this. The
flush type macros may not land in mainline in this form anyway.

John Ogness

