Return-Path: <linux-kernel+bounces-571705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5720CA6C0F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6736F3B4D56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263BE22D79A;
	Fri, 21 Mar 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMKA0vlI"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3C22D791
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577069; cv=none; b=L0DX7eCfy6GFa5M61HU9Rjy/keW3rCm2NHrO7czy98DkpEmGYJJKhCR7oPvHbO+GbvUGkHQRXdE3ZIC9INeG+l1UT593hIHOHgB2qej4rSqTS07+AASpAKnCXEZC4bXYqSpdwnoFbPyy0ZUp6pont+xgIR4Oiz/xs30+FWBX7rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577069; c=relaxed/simple;
	bh=XLV+kVClLI9qsCWDLyKlt3evct7GKZ9yWu2AEeUJCfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h3NKKnXSdRYb5k3mXgSsbz3LIeFz7YrFN+Rgaaa69vvxxxgEG4O6pfbY2eMCYkmyw97QNZWz5BIG4hATGjuIdxuHrrc0+j0C+oJXlq1BoUlH8lCGxPpKaIltiNw/nCknf7PKgcPl/LgL3fODpkIWjAqpAEknprsDejy/RPJ6msg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMKA0vlI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3011bee1751so3429844a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742577067; x=1743181867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZcCaE0eVuNlPG5p578LcbkklGBnH9nl3P1MA70Z8AM=;
        b=YMKA0vlI9E4K9UPPRELSa4EnyYmaPUD0ecMnzXghAxTb9C6i2NU+3YITvUeY033qgh
         ZhjU62VU3QfRBjUtuU9hXeXW7y2TsNjlvPsY5jwmX7rwEr46ut8TYy6VfJtGiiMfcqnM
         8MLTNUW05EKROknsWWF+nXK4woXOI/jCHIfovWTXsoEQtSEthM27gET6eq3iOsXpRXqp
         qaok9VadERZhAsP/Z0WLTzkdiqHYUWVasMe1XxP5iAvMXPaWRkISm8rHl+abgq4jF25B
         oDK5gg/cMQkP0su6x548RQgL1cKB2vptG7vXXbYsDmuiB624HAtNqOQLAmBaQ2exNq4q
         rT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577067; x=1743181867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZcCaE0eVuNlPG5p578LcbkklGBnH9nl3P1MA70Z8AM=;
        b=BsQbh9fmYFIYLBpI77i9oPv4NvA4lAbE8M5wopHhXI2z18cO2tua+W5QCiu8T0WzyN
         0PxL923W/MjmCrHUK/1QKqnQKOUpXObsqjqcaHBPyGoHmkOgTniikCvuRJANj2b6CO9s
         BjV0bOuOGvfZ2J72e1B7biYUk/DJrh9ae/Lji0N2+jGp9lHGvdTk3p7tCOj15F9Nhfzk
         /wcwinlWFGUd6IWCO91U22nTbbVtBNEgnoO7OtaKihHG13W1RchvRatDew/RAtkAljsy
         ZUqsQRLPjHje+/L5rfQGLnUtd7o7yyQbN2OpMHiKY8AAayiJ3k/c7s45NqtfuM0v50+V
         sX1A==
X-Forwarded-Encrypted: i=1; AJvYcCU+DiQ8eW8OVnw68YwGDvSr8SP9QolO3R/i+5hYjLdolGuAoweGW5j2KOW8mjQLCdPycO4BP1Z2fs+DRFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2eeKGtUw6RJM6i/OleGEKHw5l6AB/mDAa2MyglEHUUHmHDD16
	FUPW0Ff9Ef9BPwnkBjhNKur/ei3yyNg5lCPD/mU+MCH/VXNJICFulF4TspoajGUNu4zZ0ciU6bQ
	qgg==
X-Google-Smtp-Source: AGHT+IHvo2uFLbO0X/Ntlpb9CNP/4H4/Y0afbFJGOtw8GTISI8pdAkD5BbQTOhDIfCrikuggvFoQobAHfEg=
X-Received: from pjur6.prod.google.com ([2002:a17:90a:d406:b0:2ee:4a90:3d06])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5407:b0:2f9:cf97:56ac
 with SMTP id 98e67ed59e1d1-3030fb219f6mr7694936a91.0.1742577067168; Fri, 21
 Mar 2025 10:11:07 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:11:04 -0700
In-Reply-To: <87cyea2xxi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226090525.231882-1-Neeraj.Upadhyay@amd.com>
 <20250226090525.231882-14-Neeraj.Upadhyay@amd.com> <87cyea2xxi.ffs@tglx>
Message-ID: <Z92dqEhfj1GG6Fxb@google.com>
Subject: Re: [RFC v2 13/17] x86/apic: Handle EOI writes for SAVIC guests
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, linux-kernel@vger.kernel.org, bp@alien8.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, Thomas.Lendacky@amd.com, 
	nikunj@amd.com, Santosh.Shukla@amd.com, Vasant.Hegde@amd.com, 
	Suravee.Suthikulpanit@amd.com, David.Kaplan@amd.com, x86@kernel.org, 
	hpa@zytor.com, peterz@infradead.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	kirill.shutemov@linux.intel.com, huibo.wang@amd.com, naveen.rao@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 21, 2025, Thomas Gleixner wrote:
> On Wed, Feb 26 2025 at 14:35, Neeraj Upadhyay wrote:
> > +static int find_highest_isr(void *backing_page)
> > +{
> > +	int vec_per_reg = 32;
> > +	int max_vec = 256;
> > +	u32 reg;
> > +	int vec;
> > +
> > +	for (vec = max_vec - 32; vec >= 0; vec -= vec_per_reg) {
> > +		reg = get_reg(backing_page, APIC_ISR + REG_POS(vec));
> > +		if (reg)
> > +			return __fls(reg) + vec;
> > +	}
> > +
> > +	return -1;
> 
> Congrats. You managed to re-implement find_last_bit() in the most
> incomprehesible way.

Heh, having burned myself quite badly by trying to use find_last_bit() to get
pending/in-service IRQs in KVM code...

Using find_last_bit() doesn't work because the ISR chunks aren't contiguous,
they're 4-byte registers at 16-byte strides.

That said, copy+pasting the aforementioned KVM code is absurd.  Please extract
KVM's find_highest_vector() to common code, along with any other APIC utilities
in KVM that would be useful.  I haven't looked at this series, but I suspect
there's a _lot_ of code in KVM's local APIC emulation that can be shared.

