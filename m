Return-Path: <linux-kernel+bounces-538803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD85A49D42
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67657A94A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73B125DD1E;
	Fri, 28 Feb 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="koRZsvEn"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DDA1E4A9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756015; cv=none; b=DHs5w1MuI4x8O4hNKZaX7/vSwMGAeajj5CTkxp5wBHb+kClquNPPaJDvG6qa6ojeMb/vNa4Dgnk0d6ocXzX3T2Sp1JF7PsiCvrcFFfHV6VipcD6tunxrHN4DuCrt/IFqwHVQmxFDjDPCFd4rPWGlTdRCT4aK/meWQf6QxCjLE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756015; c=relaxed/simple;
	bh=Rc20F5r9mpBcN4fiDTVuotzKFMtsdmXBMtwxA1mQV8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LZQnJiDl+wRZB4GRAEiD7QtLpFoSVKspheK7nE+mRmZ2Qg/e8dAS5LNZtMaFBY+cfeUOVXY8oprsLlA61zmBEOYIEKeZiZx4lcZsEhRnD96zIms1YVKI3FvIUYwxHrInaB7xkOGc2DCelpOyL6ZLj2rNSHM9KdMJXhHbcwdrl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=koRZsvEn; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fed0f307ccso243425a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740756013; x=1741360813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnRNqc6xf3vLI0d4jgeOR5IoeVfkbwd3YSxybWBJS/c=;
        b=koRZsvEndcvjudDAuknMqmjMkSN/Pd9FCIPR2f6pEL0yVoN4JAYTK5M3/R+w3E080R
         2pXZZLKUDLhswk1YAldulQcuvGnRZDfmKI348FyTUszAl8dPRAz7K02bXIFq/ZEgON7f
         ribTYY2bgVJZ2nAdKaCSo4jkGoiVT5ikx7Y5kdshXZvy6dht/kLn250YfcR2np8xCaEq
         mcmSxTpDdPA5GIZTrkJRu1/NlVznMCMPcxfWDPvb+DgIPjSHLDal7yUILUiyhMJd622c
         HBCw8GODkj3P/QNHNMrWo1JskQMsbIt38VAhqmjU07wQEgCj76b7Vjrxpw6O5PmEb7qn
         H11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740756013; x=1741360813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnRNqc6xf3vLI0d4jgeOR5IoeVfkbwd3YSxybWBJS/c=;
        b=YOaUqFrxAMrvZ6yVJB5IgVDDqjKS2gT53vbOHIR9r4evsVy7h92714kTt930ulaIPE
         A9PuZ5xGyzOiOAtQjENkokJKAk1Z9i1lTsfCRVVCpqqHvCjdr2ZoQrwe63i8BzpOFvxG
         sl/rwqWapJH4z7jWMixC+snN7XLj5wN4fCEH5MsMPYfOlzCAfek/8vB8v+ti8EorB0ns
         0igxbCU8x0HArb/hnlfq8vFQLPeAWvifzme+do6dXUB2GF5E/dHxp1jXbCZO+tJbe8a3
         3P7kpN45zbu1mYvK6naAbv2fH4z28xB2XNsQt9ZClm4DqgfZfm9QvCSgjy7SkssfHdhT
         F6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsv4gVNGkK//oyhtrK1+UNV2pRynaePMzOlfQMorFS4fVIx28Z0ogIxQ+vdCx8CKb3zmWaGI17wa12YXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKK73IC6qqKvX4TtFt0CwmnhAIrdehpWUbW8Krq99wdrQ+/1Wo
	yxzeqS8ao4zQOrm+5NouXKsSpjm/IjOiEM5kpdHsPJ/WunOc/+mrxSbK5zjsTawVxA55xs2TqaL
	utQ==
X-Google-Smtp-Source: AGHT+IHxrjbgja5s5/MSwytHiq/fjqNyQDRtL1BTVI/8VvKR2D/IiVsXf3wwlnlVWtXexSDeJlW9StHdjZE=
X-Received: from pgbcq12.prod.google.com ([2002:a05:6a02:408c:b0:ae2:add4:b424])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:696:b0:1ee:ce0a:532a
 with SMTP id adf61e73a8af0-1f2f4c9460emr6403280637.4.1740756012993; Fri, 28
 Feb 2025 07:20:12 -0800 (PST)
Date: Fri, 28 Feb 2025 07:20:11 -0800
In-Reply-To: <d1b46250-793e-41a5-9b65-95ed6312bc4a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Z8C3ZcMgHuBtIjFR@gmail.com> <674db309-e206-4bb4-bf99-b3c39bff7973@intel.com>
 <Z8C-xa7WB1kWoxqx@gmail.com> <af4ec757-22fd-4438-91fc-d8778998bf07@intel.com>
 <Z8DE0K2EEDe1dQdh@gmail.com> <4c71fc86-2d70-4d50-b041-d6ef8c1baf4c@intel.com>
 <Z8DLKj8qdLb7MllO@gmail.com> <1fb9325e-4430-4ac8-956f-c5255c9c9971@intel.com>
 <Z8DbEqXaxEB_4wmI@gmail.com> <d1b46250-793e-41a5-9b65-95ed6312bc4a@intel.com>
Message-ID: <Z8HUK9bliN1sZYdL@google.com>
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order table
 and accessor macro
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, "Chang S. Bae" <chang.seok.bae@intel.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 27, 2025, Dave Hansen wrote:
> On 2/27/25 13:37, Ingo Molnar wrote:
> ...
> >> Like I showed in my earlier example, the CPU enumerates which XSAVE
> >> features are available. These enumeration bits in CPUID leaf 0xd *ARE*
> >> set at boot independent of any other enabling or enumeration. In this
> >> regard, XSAVE enumeration is quite independent of the other parts of the
> >> ISA. This could, in theory, be changed to become dependent on some kind
> >> of APX enabling. But that would be novel for an XSAVE feature.
> > 
> > Yeah. That would be novel for an XSAVE feature - but so is the change 
> > in ordering. With my proposal we'd avoid the 
> > xfeature_noncompact_order[] indirection table AFAICS.
> 
> Yeah, so with your proposal, we could toss out most of this series, so
> roughly 100 lines of code.
> 
> The downsides are:
> 
>  1. It can still confuse userspace, arguably in an architecture
>     violating manner because the SDM says: "If XCR0[4:3] is 11b, the
>     XSAVE feature set can be used to manage MPX state and software can
>     execute Intel MPX instructions." (this would be for userspace)
>    1a. Userspace like GDB still needs code to disambiguate XCR0[3:4]
>  2. It would add complexity in the XSAVE enumeration microcode. CPUID
>     data that comes right out of a ROM today would need to check some
>     CPU enabling state and change the enumeration.
>  3. Linux would still need to go fix up KVM in the kernel, like:
>     https://hansen.beer/~dave/intel/mpxapx.patch . Every APX-enabling
>     VMM would need something similar.
> 
> KVM folks, would you have any issues if XCR0[3:4] (the old MPX bits) got
> used for this new APX feature?

Yes.  I could live with complexity in KVM code, but I agree 100% with Andrew's
take:

  : XGETBV(0) & 0x18 in userspace has a very well defined meaning that is
  : MPX and not "MPX now but something unrelated in the future".

The risk of breaking guest kernels and guest userspace is decidedly non-zero.

