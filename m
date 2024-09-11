Return-Path: <linux-kernel+bounces-325749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BB975DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45E21F23F99
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494C1A3021;
	Wed, 11 Sep 2024 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rPj8FKMf"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F413D502
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726097509; cv=none; b=vCaxxS1mgerPeU7IVqUi0/uamKgXCHZKADLeO300sBzCBSIGUXuIvWK6OJDB1S9JJp2OHdrfu316Ac5QRtnQwDlByWa1Pk3FybvvH8PHtr13uE6pOWrPzTGtbJ50UT57wlLmPK2YwMCAgf32Jam1T0B2s5+w2ZaRMgHkQcvkWWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726097509; c=relaxed/simple;
	bh=z9U4HbiEuFhGKos1gmTUMjT6OYGXO8JxmAs6sF5RZLg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+//yrhmzKqTdi8dXvdHubPh0T+ce3/US4a2ri5tkzR/rEifSL+63UiK6uav/78Z9BH9VowAXcCot9A1TF51Qw56A5Q5/ayjDno2nNp8LecxyVQYngiZevozwfs9TbPq6b7CVERFEfYY8Q0s4NLn0gXFsDAn2OMrGBa2vgsyW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rPj8FKMf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2070daaf8f1so5094345ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726097507; x=1726702307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pHnlH+pH4QGhSAdS+6z8R3FVfMy6IzZKMdnVMkZg7oo=;
        b=rPj8FKMf96PrlJtU5Zull4O0tHHCV85sHf4LLGZQedd06R0d6BGD+95mEhw3fyYnKb
         rr+WkgkDKnHfMHKePaZ76dvQV5J2bkS1Z/9/M5p1sP/UXZikb434rQl72IC4gMtTwj1c
         x87w0Eya+azbik4eVPYx2Iv14Flg/BdIdbBYGZ+UnHR1lMkRe8UgkLdxDGl0dcX8JTus
         mknsCGKTzZTNqvIvnY7skjUzAGuMVx8dPOKMYje4fkN6z7WbZcQsdKv0ITe3iD/FQZYj
         Jj6kAtvfuts+dol3lzuJwydb4XHzg/sAsVyjRCaeeP5FgDETPHbFfOdxHG3sGtPqGhnX
         b7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726097507; x=1726702307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHnlH+pH4QGhSAdS+6z8R3FVfMy6IzZKMdnVMkZg7oo=;
        b=ewy3jv6y6X28kq5/5ET55q8rVwx/83IjJw5dZK3ihGs2eouK+QwRj1gGqBJ3T2JJbX
         g3TopXTW6zk1P2xzKAIBBTlTCMgUdz/Xhw5oGNFjugQYe6e3n+j/vIhVKY0hTwG30Z6u
         TN5BYB/gWht9yh0RC6oHYTGdX/gxybVBxLYD/LVwn1HyZtZY8W37jPzO/2cr5KY5u8+k
         mJ5fDRdnk14u3jJmc0DhkWM+YW9zkgqJYxXBfMGbdUmkW4Qrfaq5PORfgBnQt6n4/Oq+
         8Ww5QkF5APYXSbLQr8C/CTwSBunBik9Fb+OQK9tQNXcrB4Sy6e/nqfAYDioxDJXQrG7l
         s+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVK/sS6kulWZDVpOdLgu2gBoRmFUW/N1QlNFrfwVoDy9iopFrDeH4X/FrIhbYVlO8eCMBtb0BpQ/3dYCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YywlfrIM6hT5LvJlYwIRXDjlb99qE4yhJ3nGZNwth5uuCK8ewT7
	vnHEl2bAmo/oUHZSInt7/aicriHS5JnM1IvhInEFAt9ftTrvIPAr4SDHmW4D9zvUmeR2wfyjQ/i
	t3w==
X-Google-Smtp-Source: AGHT+IFNRwx2gTMhNsyitKZnT2yohlwJlFqNdkxyBgStEIKIu3twZqn2Lqc71xWomvSuKolY1sCGDK/a+ZE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c950:b0:206:8c37:bcc7 with SMTP id
 d9443c01a7336-2076e315e2emr484135ad.1.1726097506689; Wed, 11 Sep 2024
 16:31:46 -0700 (PDT)
Date: Wed, 11 Sep 2024 16:31:45 -0700
In-Reply-To: <8e3146250f31db92fa42a29a892858c9ec33aeab.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240602115444.1863364-1-kirill.shutemov@linux.intel.com>
 <8992921e-7343-4279-9953-0c042d8baf90@intel.com> <crv2ak76xudopm7xnbg6zp2ntw4t2gni3vlowm7otl7xyu72oz@rt2ncbmodsth>
 <Zl9sXGj890yerBPJ@google.com> <8e3146250f31db92fa42a29a892858c9ec33aeab.camel@intel.com>
Message-ID: <ZuIoYUnJ9uJoSLzm@google.com>
Subject: Re: [PATCH] x86/tdx: Enhance code generation for TDCALL and SEAMCALL wrappers
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, 
	Dave Hansen <dave.hansen@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kys@microsoft.com" <kys@microsoft.com>, 
	Dexuan Cui <decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 28, 2024, Rick P Edgecombe wrote:
> On Tue, 2024-06-04 at 12:34 -0700, Sean Christopherson wrote:
> > 
> > If we're willing to suffer a few gnarly macros, I think we get a
> > satisfactory mix of standardized arguments and explicit operands, and
> > generate vastly better code.
> 
> Hi Sean,
> 
> We are kind of stuck on improving the code generation for the existing calls.
> x86 maintainers don't seem to be enthusiastic about tackling this urgently and
> there is not consensus on how to weigh source code clarity with code generation
> sanity [0]. I think we are going to table it for the time being, unless it's a
> showstopper for you.

I'll survive.

> An option is still to have a separate helper infrastructure for KVM's calls, but
> as discussed originally this duplicates code.

Ya.  Tangentially related to this topic, at some point in the not-to-distant
future, I think we need to have a discussion for how to maintain TDX (and SNP)
going forward.

Not because I want to take more ownership in KVM (I would generally prefer to do
the opposite), but because I suspect there will be more overlaps similar to this
in the future, e.g. if the guest kernel gets cornered into doing some amount
of SSE/AVX emulation for userspace MMIO.  And because I also suspect that future
additions to TDX and SNP will require modifications and tighter integration in/with
subsystems outside of KVM, while simultaneously moving further away from the areas
that KVM has historically operated in, e.g. emulation, feature enumeration, memory
management, etc.

I don't have any concrete (or even half-baked) thoughts, just flagging that we
might want to have a conversation to hash out what we think would be the best
way to operate, knowing what's on the horizon, versus winging it as we go and
hoping everything works out.

