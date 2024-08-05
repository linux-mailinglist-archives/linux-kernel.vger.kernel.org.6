Return-Path: <linux-kernel+bounces-274772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5963947C7E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496A228367F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295112C484;
	Mon,  5 Aug 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vln3Bwi3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="emPpfuxY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1817C64
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866891; cv=none; b=hwW148lpmxrzDl2OnHNyG5gE2PHjDdjJVmGxJGC/6aFuumv9TagpknrSK+xPmWBZqvA8aVN3Z+/b+hohvjAHEWqU9kNqYwnAfJnnl7pGMycwGNBLeGadgE4P4PjOoVHBbTA9rfBoXrYTeWmq2bh37K9Ob1iXKTTOGzhU0gQ3FX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866891; c=relaxed/simple;
	bh=78YSS1pNV41Y12sltGt1mHk2XtfIL8Dz9Y0FUrVvYZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PSmC27Dy204gGDHBuuaYs+yRsQ6b1ZAlECbEbRrSbuB//zT4xMVEb8zB3876dFa17YRi4Ro2ZQwQ1U0Gjw6EvDanRU7o0TYCKhraTH/t4OcYn6fwit2aJ2TOn2Ux/wtobdqd6hULEbsKixYqcMSI8UO7aS1zzaeBmO+mGssSjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vln3Bwi3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=emPpfuxY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722866887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1mBssYLnd5rBgY93iDsBeptu7zRQp5Y+8ElqUplOZBQ=;
	b=Vln3Bwi3XoBAigcEwku+v7ryual1z5nan/t0HJr2aDODB91e/c+Dq7v8a+gv1fjNKY4LtR
	cR4uJ8l3r1oTkpJix24jVfmNBkXUSo5epbjk57icwMazL9rP9iNlXJhBqMiLwVrvKGmwUL
	2xRcW7a/P1QTDZvLgoXCrJPQE0zC3mZ99L1x5zi1ycMaW8iIHWZHiWbpfa7uo7kSZnJdXZ
	VIXeSdSBv0VTNdbBkKJQnmQ1LDsp7spXaaly2qoePmY8FpVa71jJgQUFza1Zgp5l8yUJFq
	6El1P2UFViFBzZnw+GJUTyaKUuD6a05q7TrjMMV1DIUQ+Vnn1odxr62u14BEkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722866887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1mBssYLnd5rBgY93iDsBeptu7zRQp5Y+8ElqUplOZBQ=;
	b=emPpfuxYSgJiXfCTD/iEC2zWpD328sPXIH6NWXnZWCUoIrBe3V0P6p4aNLq3c78JC+cjLi
	jMgglvJAHRA4cZBQ==
To: Petr Mladek <pmladek@suse.com>, takakura@valinux.co.jp
Cc: rostedt@goodmis.org, senozhatsky@chromium.org,
 akpm@linux-foundation.org, bhe@redhat.com, lukas@wunner.de,
 wangkefeng.wang@huawei.com, ubizjak@gmail.com, feng.tang@intel.com,
 j.granados@samsung.com, stephen.s.brennan@oracle.com,
 linux-kernel@vger.kernel.org, nishimura@valinux.co.jp, taka@valinux.co.jp
Subject: Re: [PATCH v2 1/2] Handle flushing of CPU backtraces during panic
In-Reply-To: <ZrDYfU6SVrR2Hj02@pathway.suse.cz>
References: <20240803080444.221427-1-takakura@valinux.co.jp>
 <20240803081230.223512-1-takakura@valinux.co.jp>
 <ZrDYfU6SVrR2Hj02@pathway.suse.cz>
Date: Mon, 05 Aug 2024 16:14:06 +0206
Message-ID: <87r0b32hbt.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-05, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index 7e2070925..f94923a63 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -252,8 +252,10 @@ void check_panic_on_warn(const char *origin)
>>   */
>>  static void panic_other_cpus_shutdown(bool crash_kexec)
>>  {
>> -	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>> +	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
>>  		trigger_all_cpu_backtrace();
>> +		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>
> Hmm, this is too dangerous.
>
> console_flush_on_panic() is supposed to be called at the end on
> panic() as the final desperate attempt to flush consoles.

Thanks for catching this. I keep forgetting that
console_flush_on_panic() is the legacy variant of
nbcon_atomic_flush_unsafe(), but is called much earlier.

John

