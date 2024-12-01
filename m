Return-Path: <linux-kernel+bounces-426591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3F9DF55B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 12:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10EC28117A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE4139D04;
	Sun,  1 Dec 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZwIwIPeW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qpo34jto"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D478685
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733051978; cv=none; b=MHPstcnn2ISLH7eoZZGmO352vbnVh7CxJdrTC+2IfjwjAG8L1SqwxPKXcPIgVNyXr9fc8fRuKudSOtuaU+Qz6PmkNOfX+9Sc3JOlFJSMnQn6Aq4AelgUPsX0t+ACA1v82/t+shHu6dUp68A90kaEJktAymHs3e0LtnuGH8vqd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733051978; c=relaxed/simple;
	bh=USKpyqoc6OK3QKW03lSTtRliChI1CxcMtkZlSjDhjfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYovAR6krPcj+K3451LtEhe9x0i7yIhxrYalCqCpCOQTQRC/PI44NLnmzBvshWEOqQEHsMM3wifTRpYN7VE0I+xcA/g84+W6lSfH81wBQFef5HIEB8v9udZeztIC5YqEPSIKw2nYOciwk0v0+7SWLHbbNfixGpq8kTV2ZWGTqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZwIwIPeW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qpo34jto; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733051975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDyHPlNEUnQgzVFHMrpiQsLtL9Qxe5uHkWbmpd0Bcaw=;
	b=ZwIwIPeWzc5fJpnBy3tPkmLGRBSLhA0IhvVbKfuB3pCaqDtPBSoXPSSPzHJj5lqePQJXZh
	saw2tyB35caaY1WRFOOTDakG87Rac2CiBdgcnEsVaETGUZ2LIkmO1J6YwGTSL60CTVkkH8
	UPQytJ5nue8MzA2ECyCa5/jfb7zj3bdluniKiU5Dg6qFv7r0CF0BTSTzCVR2/kbHECM+qi
	2dm1pSbgrZliexsj8Vvshwtgchh9EWLqZOT6d2lnwBtk5lNDOLeJPTs/ncJW8sQH6Q4ezl
	X9WB+Csibt8PBhXoLKo6jpbXp4JW7Odw5JyXpzF67j4AGfJ9SoYaAWroXh/eFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733051975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDyHPlNEUnQgzVFHMrpiQsLtL9Qxe5uHkWbmpd0Bcaw=;
	b=Qpo34jtob1LbosMBtAl47/xmhuQNsC1tJXAj85I8Uxf5h6BuaXY+7PhCcNAx7cLLndI2rx
	VgnJuardsEMXGrDw==
To: "Farber, Eliav" <farbere@amazon.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "christophe.leroy@csgroup.eu"
 <christophe.leroy@csgroup.eu>, "naveen@kernel.org" <naveen@kernel.org>,
 "maddy@linux.ibm.com" <maddy@linux.ibm.com>, "paul.walmsley@sifive.com"
 <paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "ebiederm@xmission.com"
 <ebiederm@xmission.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "bhe@redhat.com" <bhe@redhat.com>,
 "hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
 "sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
 "adityag@linux.ibm.com" <adityag@linux.ibm.com>,
 "songshuaishuai@tinylab.org" <songshuaishuai@tinylab.org>,
 "takakura@valinux.co.jp" <takakura@valinux.co.jp>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
 <linux-riscv@lists.infradead.org>, "kexec@lists.infradead.org"
 <kexec@lists.infradead.org>, Marc Zyngier <maz@kernel.org>
Cc: "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: RE: [PATCH v4 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
In-Reply-To: <cd8809e379dc4dd089350ec2d1f8c210@amazon.com>
References: <cd8809e379dc4dd089350ec2d1f8c210@amazon.com>
Date: Sun, 01 Dec 2024 12:19:34 +0100
Message-ID: <87frn7wszd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 30 2024 at 20:08, Eliav Farber wrote:
> On 11/29/2024 3:30 PM, Thomas Gleixner wrote:
>> Looking deeper. This function actually cannot be called from this
>> context. It does:
>>
>>           irq_get_desc_buslock(irq, &flags, 0);
>>
>> which means for any interrupt which has an actual buslock implementation
>> it will end up in a sleepable function and deadlock in the worst case.
>>
>> Marc?
> I will wait for Marc's response regarding this issue.
> Regardless, if any changes are required, I believe it would be better
> to address them in a separate patch, as this behavior existed before my
> modification.

Correct.

