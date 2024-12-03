Return-Path: <linux-kernel+bounces-429851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC909E2C2D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA85B2DF80
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6341F8AD4;
	Tue,  3 Dec 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZFy87LnX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="51K1fTOk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D442BD1D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243823; cv=none; b=RWHRddMA5JhVzg6ZsTxyFZ7KpXFWha9UMFR9GZ2g1f1Oa1HdgUzpaAwvZNG0Zl52KbH0VB5VhNp6QC3YGi7BCZrPu+Sx1aKx9EfwcXeGKqjdpKh8mzIDHqL+bL1GHSo5DmwUhH+5kNZPB7ZsIht6rgnvAkpkeMKsQ4PfZ6QGDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243823; c=relaxed/simple;
	bh=kZJvCWgDdqqp0HCKkuN3LGvkm8OwJHwR7M1PWwgctWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bC9BDNRzJZGYUY5MH6C0BF+/iX1O+3856S7hAYpc1uiQ1lnCNkhB0eBnK/wJ2eYFvwpfeLiXOogqdVZ/B1VDA518Orp6BSlQHHCJc18QNalFi+ePGRtwSVjTK4jGFDSZrExzkk72c5QDEdevnFdaenh73iBQYnSdyjLEXKwOmDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFy87LnX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=51K1fTOk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733243819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HxF1YtbxctjOgLe3e+5LAqOGqmoJ7n+8c9ePfvewlDs=;
	b=ZFy87LnXgxMe5bIwTwB4SVdDCSlcxqDM5Dwg3iZ8DiJODrOVGAZoQBBdLtoXDjt7JG0wKP
	mTN7fvMltxJ83iJSbYgKO8MderplffT0fOTfQB2/Wtntej162k8sEI5zkBAjxQi2zIHnl8
	BxFPwripxKWqXWIELnCObC6BQbbFI8mURLp0hdAxRn8umpG/RD/LZ0fbGMRkbRKIvp6ddC
	57glirNfQobi0tK8mH+8iNULQWU1v1HVw88nIrYfvKEwkDgKvrtvlvZOlafyDfnHl4x77X
	Quw8iMqSljd30mOQ7x1HQpzooupKG8wmDhqSOvDvriiZLNSWQdTg8cuMFNk8ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733243819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HxF1YtbxctjOgLe3e+5LAqOGqmoJ7n+8c9ePfvewlDs=;
	b=51K1fTOkCTCXZgTFGRDR/uHKZh8KeFOlAsYai8RG5Iq9JQAuG5x/cvB3XaojGxxMqrjr49
	ScBrmG+vuWWtr/Cg==
To: "Farber, Eliav" <farbere@amazon.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "christophe.leroy@csgroup.eu"
 <christophe.leroy@csgroup.eu>, "naveen@kernel.org" <naveen@kernel.org>,
 "maddy@linux.ibm.com" <maddy@linux.ibm.com>, "paul.walmsley@sifive.com"
 <paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com"
 <bhe@redhat.com>, "hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
 "sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
 "adityag@linux.ibm.com" <adityag@linux.ibm.com>,
 "songshuaishuai@tinylab.org" <songshuaishuai@tinylab.org>,
 "takakura@valinux.co.jp" <takakura@valinux.co.jp>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
 <linux-riscv@lists.infradead.org>
Cc: "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: RE: [PATCH v5 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
In-Reply-To: <077908c5f02545f0a9e02ae77cbd771c@amazon.com>
References: <077908c5f02545f0a9e02ae77cbd771c@amazon.com>
Date: Tue, 03 Dec 2024 17:36:59 +0100
Message-ID: <87ed2ou3is.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 03 2024 at 12:55, Eliav Farber wrote:
> On 12/3/2024 1:04 PM, Thomas Gleixner wrote:
>>> +
>>> +config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
>>> +     bool "Clear forwarded VM interrupts during kexec"
>>
>> This should not be user selectable. Just keep it as:
>>
>> config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
>>         bool
>>
>> which defaults to 'n'. Just add a comment what this is about like it's
>> done with the other options in that file which are only selectable.
> Question: Should this new configuration option be placed inside or
> outside the following section:
> ```
> menu "IRQ subsystem"
>
>
> endmenu
> ```
> In my patch, I have added the new configuration option at the end of
> the file, outside the "IRQ subsystem" section.

It does not really matter when the option is silent, but keeping it in
the menu section as the others is the most intuitive IMO.

Thanks,

        tglx




