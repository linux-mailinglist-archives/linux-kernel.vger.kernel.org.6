Return-Path: <linux-kernel+bounces-425821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6465A9DEB5C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281AA2823A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EA019CCEA;
	Fri, 29 Nov 2024 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1gUUJEmH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fZFxntrT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF2AD23
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732899467; cv=none; b=hpEsP2JD9EPQhVZo5ZlXvMu8Y1lBIXwgJBGTFwvFKpsTrBOgzC/dCDV65e681Q69e5FQCjxFHUvdISTQIF6VRus+P74jbauEJWKHWQkX8nEfmBpgeYH2aArlR6gTyEb+Zty47m31rcQrMXotaoWn3xbpmI9+7gakvHuxyslPAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732899467; c=relaxed/simple;
	bh=pE/qS5EEaHYHCucwCEOK1Xv78TCd55llpMIXcf3IAyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kMmtxYseEbZVoXBRN+Er8dIeFNTx1AUmn91HVekClODtDCPkF+LdrH0SQB0rFVath1bQsxJFPHUVHruUJiJcCbQ5P0clTVCNRrBgvpOCWI95KzLAvvEYgzFCjI5bMcuNMg7tgwnp49Vn5PASqxWLOeHv81Es/qGYQNkAN/1CRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1gUUJEmH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fZFxntrT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732899458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pE/qS5EEaHYHCucwCEOK1Xv78TCd55llpMIXcf3IAyY=;
	b=1gUUJEmHXbTvwY5MfLibi1E6txafTuFA8DGVUDx5F+9CdHiXGFtf2MfonzPlXHgIHeO0Dm
	rdgNzG40Sk1/nl4TYC9KYp1lgk9isKoFsZ0peqwO7yozYO9JARjA9jbOBO1B/RszexxRWn
	EKa037nTiFicL6BTT/CHBwYQihZ74X3ZrLO7uwJP+UtG2j9PD3RFyN6jAE3uov+2H0O3iJ
	pL0cFjnO7FW6SqR5OBetzN41Gt8cUIIiLtKrTAl1UuMbN7c67i8mw8FJ8SWjfMvAr1WTwQ
	ly/MQOTMH6OG0mwRMwWKNFMq63y9zTlZhCrPI3xqOGAbZ2+6q/YibHQt9nIcHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732899458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pE/qS5EEaHYHCucwCEOK1Xv78TCd55llpMIXcf3IAyY=;
	b=fZFxntrTnCe8eDSQhCXCg+xp3QxuHHUb1L0k0UexRmyxSlYPxKBKiUzVfHri8UWlon3LpO
	kZeoxgJq4D76LWAQ==
To: Waiman Long <llong@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/nmi: Use trylock in __register_nmi_handler() when
 in_nmi()
In-Reply-To: <89cdf387-f75f-472f-9f4b-e3582d1d2c93@redhat.com>
References: <20241127233455.76904-1-longman@redhat.com>
 <20241128092800.GB35539@noisy.programming.kicks-ass.net>
 <15662315-0332-4c0e-95c9-928329a094a7@redhat.com>
 <89cdf387-f75f-472f-9f4b-e3582d1d2c93@redhat.com>
Date: Fri, 29 Nov 2024 17:57:30 +0100
Message-ID: <87ttbqvuyt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28 2024 at 20:55, Waiman Long wrote:
> On 11/28/24 8:06 PM, Waiman Long wrote:
>>
>> On 11/28/24 4:28 AM, Peter Zijlstra wrote:
>>> On Wed, Nov 27, 2024 at 06:34:55PM -0500, Waiman Long wrote:
>>>> The __register_nmi_handler() function can be called in NMI context from
>>>> nmi_shootdown_cpus() leading to a lockdep splat like the following.
>>> This seems fundamentally insane. Why are we okay with this?
>>
>> According to the functional comment of nmi_shootdown_cpus(),
>>
>> =C2=A0* nmi_shootdown_cpus() can only be invoked once. After the first
>> =C2=A0* invocation all other CPUs are stuck in crash_nmi_callback() and
>> =C2=A0* cannot respond to a second NMI.
>>
>> That is why it has to insert the crash_nmi_callback() call with=20
>> register_nmi_handler() here in the NMI context. Changing this will=20
>> require a fundamental redesign of the way this shutdown process need=20
>> to be handled and I am not knowledgeable enough to do that. I will=20
>> certainly appreciate idea to handle it in a more graceful way.
>
> One idea that I current have is to add a emergency callback pointer to=20
> the nmi_desc structure which, if set, has priority over the handlers in=20
> the linked list and will be called first. In this way,=20
> nmi_shootdown_cpus() can set the pointer to point to=20
> crash_nmi_callback() without the need to take a lock and insert another=20
> handler at the front of the list. Please let me know if this idea is=20
> acceptable or not.

That's way more sane.

