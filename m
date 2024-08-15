Return-Path: <linux-kernel+bounces-288187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D1B95370B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87BF2895AD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE431AD3F7;
	Thu, 15 Aug 2024 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7H7vJFW"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C0176AA3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735399; cv=none; b=sLEHJTQkcF3EhDGEPG6dTOfFh/JLoXfR7A7gSaqSH1ytDQf+VwyO9oHyuP/Lsmeqd53Xmd5EG5EqVVJpRxlfX7QyqiITY6+awe3R+MKEKjW3+S/DEiJjnxC90yN/scPr2wuZdOPaFUMfu83Tm4BYC0oqFG6YiaUcB1h2w3CkJbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735399; c=relaxed/simple;
	bh=RCmMBR8DvUYeuvHk6y3sEzZPOE5ZBWrbKoIqGeQ9lWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XI6Zkr07hzX+zoLL/W0IwwvbyYMQ77cM8lIqp25Px2zX30j5YP1YZN1ou9pgjtsPdhv8LWNBVYYiG+8d2rcaGvwArq4ZWXIyVXXFJ8VIF2233ddzr6jOvCQ/3hm9pAXCAxqKTbgIXTsSZY+RKbvFQLtQ28sLBh/nWY0oEB8ZCDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b7H7vJFW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71050384c9aso979581b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723735397; x=1724340197; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZHCOvhAjcmBbX1eOeOharlXaIX1okAqgVUy9FSEGIA=;
        b=b7H7vJFWv/E7gPm7yd+JT827VrbWqc2F0PwUNhvwaSD3f3DBZlilmVF/fkr+6DCG1K
         aqeJKUxMmW0GlyzWbdXbQNrQfUeL+rV05eUM9xmRNaejG7rGZp8wzTPBsAwHZV7/zZak
         UFQ5rtE+Nfg1ezM1Ygy1huHszDhJXZQpnFqjDQLjP48DCHjRSkxhALT89sybkAzERRRZ
         vdAPRCkmrdAi/l5USDzvSQceXbKTueKjhicsu2CuARVxg+4gZOmrsDQk8uqQcm5ekNIs
         +bmZWQNy6cu5F0w510FJWTLXzJ9euSepNg43/nh3RTICPGbEzpueNhOhoRowR2XUhHU6
         9DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723735397; x=1724340197;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZHCOvhAjcmBbX1eOeOharlXaIX1okAqgVUy9FSEGIA=;
        b=JfL9n2z5YUKt35ApmdAkyCuW241eUND5RVZ3hY0+AMKjDr3xw4fQacBDigziWMy9Nu
         /hMCnwXpqRP+Co9sApw+iHHgkjbjsKjSCsBElb3lt+K9TsAbpg6uhpzP398ASRHYTQ9H
         7WqeGvRt8TS1+HS95sxEeFGty82K/XSVKr6vZpvhwg6MGu8Tf5BZ3ZoCvaFeu6qHa9aS
         r4ubGzsAC+C2eoCar3xoAxTwNqgMv/OySHdlpFNOPzKloz4Qk7ID1HMV9KUkchIh4Nhu
         yDnvlPwyIk0ZgeBTGAWm8DqGBowihxzMEwv0WDFRcWHeCT2OSl8qPgst6872vj4Buml0
         ykNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW15qDWH7UjBRwMtLk70ZW3Udkl2pngKwXc+M8+CRuMVOhcvvYuUh1MFJp4GbI6Ht3Wg+afSnH+U+qOy6TM1o+WeuVUp92OdE3dKf2E
X-Gm-Message-State: AOJu0YwOliB/gDKnXjKxjtiQwox/pQ8c9H3SIoFI06RPl3PM1aEr1Jcb
	oFmuNTCWaNboaHzhPkiRmKvz4ZxOiD9LUcDDsYn0QO5QJaKXSxIlJ7l+nz4ppTZvAs2Et6F8U9s
	kGw==
X-Google-Smtp-Source: AGHT+IHmTF1tHqrCbwhVwT870NoGi74qkwpNRwiZLS3kdWZMOuGyHdwVhFJz1azvuma30wR+ZpAWfYoUa/U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:915f:b0:70d:3466:2f1a with SMTP id
 d2e1a72fcca58-7127aedd631mr17807b3a.1.1723735396761; Thu, 15 Aug 2024
 08:23:16 -0700 (PDT)
Date: Thu, 15 Aug 2024 08:23:15 -0700
In-Reply-To: <20240605231918.2915961-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605231918.2915961-1-seanjc@google.com>
Message-ID: <Zr4dY1EbVu6u7Czv@google.com>
Subject: Re: [PATCH v8 00/10] x86/cpu: KVM: Clean up PAT and VMX macros
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Jim Mattson <jmattson@google.com>, Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 05, 2024, Sean Christopherson wrote:
> The primary goal of this series is to clean up the VMX MSR macros and their
> usage in KVM.
> 
> The first half of the series touches memtype code that (obviously) impacts
> areas well outside of KVM, in order to address several warts:
> 
>   (a) KVM is defining VMX specific macros for the architectural memtypes
>   (b) the PAT and MTRR code define similar, yet different macros
>   (c) that the PAT code not only has macros for the types (well, enums),
>       it also has macros for encoding the entire PAT MSR that can be used
>       by KVM.
> 
> The memtype changes aren't strictly required for the KVM-focused changes in
> the second half of the series, but splitting this into two series would
> generating a number of conflicts that would be cumbersome to resolve after
> the fact.
> 
> I would like to take this through the KVM tree, as I don't expect the PAT/MTRR
> code to see much change in the near future, and IIRC the original motiviation
> of the VMX MSR cleanups was to prepare for KVM feature enabling (FRED maybe?).

x86 folks, can I get Acks/reviews/NAKs on patches 1-2?  I'd like to land this
series in 6.12 as there is KVM feature enabling work that builds on top.  It's
not a hard dependency, but having these cleanups in place would make my life easier.

Thanks!

