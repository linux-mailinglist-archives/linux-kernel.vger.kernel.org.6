Return-Path: <linux-kernel+bounces-552967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1306A5819B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837E41890936
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CD2189B8D;
	Sun,  9 Mar 2025 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FGpvuTua";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hGRltaDW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4417B17ADF8
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741508604; cv=none; b=eJ6UWEM8HQlLKCwho+ZuAarhSfuXCUdqDidUWVrDFnUveYhLSLGXxoKuHP9T5zqA5F43qaRK9/hmiltjg+lArEONey3l/INO1Vh2JDNa2zvx10dyXvR+A8DUXKKkBbkz2iDaRIQaisQ/EMW1TdkJG5Fmb/o5BsuK5lnWEp1ChcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741508604; c=relaxed/simple;
	bh=4G2oC/NE+kGa8qqrLwL81mlZJEp69TjT+8rgSD9/wmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hjTLl6XkQEeM7vIDqYUOOGp36ILR33mWDsThMqtFu5jaGRH9sMMm9GHzvE4caMBHzUw4/tZi1dpucuzUy8OD1EHjHpIGFiPsNxPIc/ulmmat0uUTIeG64J4AF2fZ/VNSDQaHC8K4ODygiIeERR77zlEXcVM02oQX03l2udw/3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FGpvuTua; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hGRltaDW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741508601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZEfVXfbWSs4mJiGD94+1pNr7HfhKB5xKrjUV7TTCks=;
	b=FGpvuTuaBLJSb1t+8raGXBRaENq4zgAFP5112yZK6Y/PRpvsL0QIULDhRL8YZL1BuBa242
	KruaEiHzda+wWE730CcnNZ6DUNxRFAGaqPHOGzBLdV+DdSD7mkn0YfMQYkjLQukxMDlLxM
	ueGqpnesEEhjskLv+h7ZAV3QhceW09d1uaY8mp1mwEev1XGHS+p64zjqovZjCCE6XxN2dE
	a8MEPtFd+8OfpeUynCyE/8oEQX2VEctEkfXE4ztHoA32weQHqoZ/mnMwIf983ZTU/C9kn9
	WcMDVwdquae+ufreSX1XS4roIe8xPrQvQSkbDyyk5QlVL7mOAS6Rgz88UofbgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741508601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZEfVXfbWSs4mJiGD94+1pNr7HfhKB5xKrjUV7TTCks=;
	b=hGRltaDWVms6RukgrjSfzrFHRypAnpcy7O0x/FIB69T7MKmVomnus0BjoUxWbhUYqunqmW
	c/K+5IMExs81UbCw==
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Peter Zijlstra <peterz@infradead.org>, Andy
 Lutomirski <luto@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev
Subject: Re: [PATCH v5 4/4] entry: Inline syscall_exit_to_user_mode()
In-Reply-To: <Z8zb-L8bFMh_YHxO@ghost>
References: <20250305-riscv_optimize_entry-v5-0-6507b5dff3ce@rivosinc.com>
 <20250305-riscv_optimize_entry-v5-4-6507b5dff3ce@rivosinc.com>
 <87senn3dh1.ffs@tglx> <Z8zb-L8bFMh_YHxO@ghost>
Date: Sun, 09 Mar 2025 09:23:20 +0100
Message-ID: <87jz8y3953.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 08 2025 at 16:08, Charlie Jenkins wrote:
> On Sat, Mar 08, 2025 at 01:37:30PM +0100, Thomas Gleixner wrote:
>> On Wed, Mar 05 2025 at 16:43, Charlie Jenkins wrote:
>> > Architectures using the generic entry code can be optimized by having
>> > syscall_exit_to_user_mode inlined.
>> 
>> That's a pretty handwavy claim. What's the actual benefit in numbers?
>
> I put the numbers in the cover letter! Here is the data I gathered:

They should be in the change log as the cover letter is not part of what
ends up in git.

