Return-Path: <linux-kernel+bounces-358583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C4199811F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3201F267AB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE171BD4E1;
	Thu, 10 Oct 2024 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2PTAjiqP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jIvjA+SI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602831A08B6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550501; cv=none; b=lO5tnwjY9n3CjFEYksqEaokBpyHYOprfFXs3r0iOFxCm4S2fBjAeRVcbvwXb/uEfDCr8/tDejtmPU3dlPQ3oGmD4xzsbWCWv8bhMhmeHTF4vy2oid7HUwz8wDMe9ldkgv0F5abjf8kecXnF90P0QsXVyiWa/iMMPynDNpAVYkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550501; c=relaxed/simple;
	bh=50kowMStovVhB5VkQ4fn0inZ3NsO6U6i2kwo/meryGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sxQLHey0zP3mpCjaCz/8JIRQdZ0vjWI1J6l/leVnoF33Uv/rcy3ESUe5/DGHjtB346kSBbHh2tylchnC8yPfQSy1oz1R2XF5x6wcWm0EZTvA9aWNh5Xm4EzeV/EJFKRR5syPyGTWmmNIcK9KgDoDRRZZT89V6j8vRyFD1hpHX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2PTAjiqP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jIvjA+SI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728550498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ec6XdUosMlLP404cIM/Sp1Kyqw0kVma/GMPn92t9HDE=;
	b=2PTAjiqPtRqkKvjlSKaANQwVdiwThhCREPlRX8T6WrkNlX9e8SWCTxhLkgfsjJoX/aUSjv
	dcZhDaUfZi9FrtMVTYX+T2YVRkZ19EjmLxtTdqNPnm+i361UiYq5z0iAreXCTIwAWVbSPq
	EVJt1Epoqj0BhfVHzZozCnr4NAo89/tI5IAO32L16fo9XklyAwHtTfdDRaCycKy1I/gLGe
	ohYP4Xh4XP1AoAY8NTWb+mG1eTVfmNZx3f0wo3MA8y/c/q1RFnYKjac1mgo8zh5wLmJRIb
	J3vNRB4/Z+9fzswe/fPcEyuPurtjomHZoM3CXfVeN3W2b9xwFE/VRbBZEFZuPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728550498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ec6XdUosMlLP404cIM/Sp1Kyqw0kVma/GMPn92t9HDE=;
	b=jIvjA+SIxgG5ChpnWhKDeLcT2fIJ6XikDrFxrvXgmh0oyUrc8nqV+ObPf0TmYzHXqd493I
	El6nXhLfmFI5B/Dw==
To: Palmer Dabbelt <palmer@dabbelt.com>, namcao@linutronix.de
Cc: bigeasy@linutronix.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, x86@kernel.org, hpa@zytor.com,
 aou@eecs.berkeley.edu, bp@alien8.de, Catalin Marinas
 <catalin.marinas@arm.com>, williams@redhat.com,
 dave.hansen@linux.intel.com, mingo@redhat.com, Paul Walmsley
 <paul.walmsley@sifive.com>, pmladek@suse.com, senozhatsky@chromium.org,
 rostedt@goodmis.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/3] riscv: Allow to enable PREEMPT_RT.
In-Reply-To: <mhng-f0f516a0-6774-4c87-b8da-313601bad133@palmer-ri-x1c9>
References: <mhng-f0f516a0-6774-4c87-b8da-313601bad133@palmer-ri-x1c9>
Date: Thu, 10 Oct 2024 11:00:57 +0206
Message-ID: <844j5kmj6m.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-09, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> and it breaks my boot test script.  Looks like it's actually working 
> mostly fine, I'm just not getting the "reboot: System halted" message 
> that I'm checking for to make sure the system actually went down 
> cleanly.
>
> I'm not sure if this is expected behavior in RT land, or if we've got 
> some sort of bug.  It sort of smells like we're losing the last printk() 
> line...

For PREEMPT_RT, the console printing is done via a thread. On
shutdown/reboot, the threads are no longer active to print the final
messages. There is a new console driver type (NBCON) that is available
for this. However, currently in mainline there are no console drivers
that have been converted to NBCON yet.

I am currently working [0] to get an NBCON console driver for the 8250
uart in mainline. But that will not help your case if you are using some
other console driver.

John Ogness

[0] https://lore.kernel.org/lkml/20240913140538.221708-1-john.ogness@linutronix.de

