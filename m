Return-Path: <linux-kernel+bounces-319477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E935396FD2C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59BD28405B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B601D79B7;
	Fri,  6 Sep 2024 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Lrq1+el"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641A51D6DA0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657236; cv=none; b=ZHq9M3ExmvlxMxIKMKMflas1pjHI7n+LV+4orYZZ3GIcmY+VQJqsN6usc3j9uUwXgTIE2m69W30InF/8nL7lgFTXSI2nbZzLN7BGbzdDJXGpaa5nwH8yWrkeX9OXC7XBI7iYIQpe386mJ2qWVcr7LNoSRePMLLljfDljUxXUzoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657236; c=relaxed/simple;
	bh=PidQRgyhau9RywwQfMwnSi++A1DlF0VCF5P36FYOOlw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HS86zdT02QuY8Ok3c8yMHpKIvIis8iPL/YTJ1oSbnGc39ES1yDQBhdMVjsbTpBekCgOuli4TsR1b0J63Cz7RQi42h5FpolSu1AbKO8J4X02ndH83F91kQMDFqOsVunUhqZJEy9xZJqZWmg4noewqHMPg1EJk0tbSSgC3QHNL0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Lrq1+el; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b43e6b9c82so103990827b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 14:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725657234; x=1726262034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZRF+Uz8RACsevk2adlxaEtEYzeBIw82PDVENRhyYjs=;
        b=0Lrq1+elYX22BVcKAgTl8af8vn1bPTjM8jDaHIUK1Z1fLyk7T2Mm2xA6v+cXVdgvLx
         9UqRxHn2R8rQOAtbBMXcYLqTgxiAcLyUTX5YchKsRyi3RFiQZoWp/ozGxAz5LQKNQ/ny
         7xHWaEIZrxIlAVoEf7OeLdDlU9lq01yewF14H/LtTK+6MnUxLFFAC95/5+PPSryC5Jr0
         6953cV2wz8xTzuI/jcg3YxsbT/vIsjLCTRetyNNdSIPvFI2NjkTGeBM32FCMEhY9WhkT
         OQfBsMv3TZmd8Mw9jHBLQRHRWWZk/XUOkX6r+eu1kwJpN0UvLKcAyp8T7JjmuXKimFjP
         tDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725657234; x=1726262034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZRF+Uz8RACsevk2adlxaEtEYzeBIw82PDVENRhyYjs=;
        b=naoHdsXF+4z5yzexb8tfiswheTo+OlZy/wHE3m8cSyI+JhGNYC4IiDiQpnLI+n0pdi
         lm5apuCfnVBbDwFZOYEU3kfrY961L+OPxLmEYm1+syChkbvdBEscNo/qABvfLcsCRkAR
         Rv//1HSIFTdyJ+1TaBVcKagNxKp2n3UV8dewu8+Q7ukDhYKRo99bvPm5yfT0ijMIg2GN
         uv5a3mGW47wBo1fFo8nfM2I2oyqKCgDhmwWIYXNc6ma8629B0U1HReq+BJogb+LoRYNt
         WekdJoAN6hwekiM2gOTzjXTTYcy6jH7LIw27s6WNPED1a2AfV/b5a0c2tze4wzjRiSuK
         HISQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSSL1qfOrrjJHXGYyS24BnmmvUS9jUYf3PpxyT3fW5sGM8buR8gbnFMdVs0tBdODu1K+UzMDaoXRLB0Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfuQ28N9wj1q/1cBp2Ejry5qJ60hjwYMR8tNCp1vR4b3pyDwRm
	QD3MCOlzMR6P1v0ZB/OpWipKYr3E0h0iVD44zBgQdp5T2AdkmLnGR5TDXWCV4Vc/RgXHqWAQVXR
	WhQ==
X-Google-Smtp-Source: AGHT+IEBxxDqT9l6zNOeVcgpC3KwWhesu1gDA5QEnrw1Cpx5yRsYUm+B0QR+anioUUBz73TqJuqgcao9Lg4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:ece:b0:6d5:9459:538e with SMTP id
 00721157ae682-6db4515d939mr1250217b3.3.1725657234393; Fri, 06 Sep 2024
 14:13:54 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:13:52 -0700
In-Reply-To: <6c158a14-ba01-4146-9c6c-8e4c035dd055@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1724837158.git.legion@kernel.org> <cover.1725622408.git.legion@kernel.org>
 <6c158a14-ba01-4146-9c6c-8e4c035dd055@intel.com>
Message-ID: <ZttwkLP74TrQgVtL@google.com>
Subject: Re: [PATCH v6 0/6] x86/tdx: Allow MMIO instructions from userspace
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Yuan Yao <yuan.yao@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, decui@microsoft.com, 
	John.Starks@microsoft.com, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 06, 2024, Dave Hansen wrote:
> On 9/6/24 04:49, Alexey Gladkov wrote:
> > Currently, MMIO inside the TDX guest is allowed from kernel space and access
> > from userspace is denied. This becomes a problem when working with virtual
> > devices in userspace.
> 
> Kernel MMIO and User MMIO are very different beasts.
> 
> The kernel MMIO instructions are trusted and can be constrained to use a
> very limited number of instructions that match the kernel's limited
> instruction decoding capability.
> 
> Userspace is not constrained in that way.
> 
> TDX also doesn't have the option of having the VMM deal with the
> instruction emulation.
> 
> Before we start down this road, I'd really want to hear from the KVM
> folks that having the kernel decode arbitrary user instructions is the
> way we want to go.

That's an x86 kernel decision, not a KVM decision.  KVM cares if the guest kernel
has delegated certain permissions to userspace, which is why emulated MMIO is
preferred over hypercalls; the fact that userspace can access an MMIO region
communicates to KVM that the guest kernel has granted userspace the necessary
permissions (by mapping the MMIO region into the user page tables).

But whether or not a particular user/application is trusted by the guest kernel
is firmly out of scope for KVM.  KVM's responsibility is to not undermine the
guest kernel's security/trust model, but KVM doesn't define that model.

Ditto for what behavior is supported/allowed.  The kernel could choose to disallow
userspace MMIO entirely, limit what instructions are supported, etc, in the name
of security, simplicity, or whatever.   Doing so would likely cause friction with
folks that want to run their workloads in an SNP/TDX VM, but that friction is very
much with the guest kernel, not with KVM.

FWIW, emulating MMIO that isn't controlled by the kernel gets to be a bit of a
slippery slope, e.g. there are KVM patches on the list to support emulating AVX
instructions[*].  But, a major use case of any hypervisor is to lift-and-shift
workloads, and so KVM users, developers, and maintainers are quite motivated to
ensure that anything that works on bare metal also works on KVM.

