Return-Path: <linux-kernel+bounces-529668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E83A42981
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B88166B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60217264FB2;
	Mon, 24 Feb 2025 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1sd66+l/"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014462641DA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417881; cv=none; b=Zzj1ESokwL5LMvrVrzgzs3DQHzqQWUaP6RSoacKrbTvwVExv0/ilgS//a0PiP+NbNm/kTtjMm/KEYA9Ztx7FeQaFSgFYUljUz4k7S+7FAWE2o1geWejyzWGGOSYA87Yu4woWU4WYux4R+IQAnIlSIEpgn1cDOrjCXIBjqXmzrk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417881; c=relaxed/simple;
	bh=j8o5OPFQDdp5ed8gL+HidM6ulcc/XNNFd6l4na/fMKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdZOQLcUNz5Poieku3MdqUuGL+59Z7tDOfcowEiNX7gkzQx+L+MQ9V80bwANof/j/oiVB7P+GwTGtwK5YOf0xL2JbWFTjiiH0kkB6lzELEmWdHb7mLAlwqwShBUcA+X0N6jIqltdGEwx1EqlWZfE/O8o/Z2EtoJym98Syg9Xqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1sd66+l/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ded4a3bf0bso17267a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740417878; x=1741022678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJhGd7GaLmZRvvcyvB5aQANV1c8QojfLDrKr0YA9JN8=;
        b=1sd66+l/Nt+gNZLkRwiEKHzKayIISadI0kpcqJ//z7R12mcMz6SIFYpgqRHquDssAn
         AD2DiF1763bTVkjY2uF9llDpXGlYKIV3gvuLgbxpGEj6YV8V39B5P9ARan+rXPpOYBN8
         BMIkAA73oa4obW4zfDPQasXz9ScChUaZiOf7SzeNaetHGz4Sbx49cm5ewOTDfIeU4Qto
         agP1LOyU1OSKUYcXHDbYzxTNw1138ALG/gz80CgcNGi73ywACNpUrD130H2GIiFCG97I
         UzVlESJ6I3CUUM4S5nPlojoqkYz3SovAU3MEz7PRil7I37rk8NR6GM1iKVDwUzCfy+iD
         mF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740417878; x=1741022678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJhGd7GaLmZRvvcyvB5aQANV1c8QojfLDrKr0YA9JN8=;
        b=HnLXmSN/4d0ZSN/7sargHSDQActlsdjZF1UoEUm1/Et+wS61WDtTVpG3WCWZctL4i5
         VE3x0rzkgwXLLTScnHY9Q++ZE6Q5Y01dDlFTODR9vreRz5dPR6aSxCXnNnV4BwP8YjAR
         a85edf97hwUM6JCJh+P8Dx4S97My0Sd2vx1hvci1CXS/w4/9A8CUUDmIGPteOCuQ4eUo
         b8XXBJJOBZ0uqnX743U68LIbBDQCZfnUonS+yzptNPdZ/0cOvCa4Ok6FuKd506mCAFqW
         v+1tHXtmgGlQxtXtZO+h8zPnt8doO74O/7A0aEX2qznpfyVo67UjvVmWMKO4Og27IzZa
         /kxw==
X-Forwarded-Encrypted: i=1; AJvYcCVoNEMxm0Qy00RhCl/L8CDsMzTH7LzeuyB6GBoxZjTWLiVK4Vyy+L6783s8za8vgzgN5+Z1aTyGUUcxXNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUNGwdL8YdLVHQ9jgZFvH+F/PrrzICpfqWv7k1p/KlcdkYYm+
	ky8LQbrANfmPe6h96J5KBQ2LYnzbLNrgEDcL2ET1Ai/dhly4+RDn8u+E/NW8y7w/R3GhsrKtcMv
	LjutaBSuOxeWTsg0N48KHcJGTgyba0J7DkxXks5s2GNviOY2oWg==
X-Gm-Gg: ASbGncsZoaRClEdeTXbTypWDPkShXhr3dLs43MMELfPNScinqI8dgFYIoqSYXAgTqHa
	bUXM8yfBc6hDsfcTRkOkzqYuf8TB2B2swtRhFv3/Bf26CFs2i782h/zXR0lTjfa+gw0KswDieIV
	vuboJQRtM=
X-Google-Smtp-Source: AGHT+IHwP5mLIh5JF9uVa/AqGrOYMKVMNcBxn0db4r4HdhthzzRBzjToV2A2Ak6OXdT6On9YzvaQ/WzXS/ZwnTxH8XQ=
X-Received: by 2002:aa7:c943:0:b0:5dc:59ca:8f3b with SMTP id
 4fb4d7f45d1cf-5e407be4a8emr1151a12.3.1740417877968; Mon, 24 Feb 2025 09:24:37
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224165442.2338294-1-seanjc@google.com> <20250224165442.2338294-2-seanjc@google.com>
In-Reply-To: <20250224165442.2338294-2-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 24 Feb 2025 09:24:25 -0800
X-Gm-Features: AWEUYZl-SRtwzgdVLwsp3huQVpOnyENCsoMsqbLaDuQc7dlYTDuJpWqYE0Iiv_0
Message-ID: <CALMp9eRfU7b_4080ku-z2w+pQT0dZyenBb=9rM6m2kH-9-5WLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: SVM: Set RFLAGS.IF=1 in C code, to get VMRUN
 out of the STI shadow
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 8:55=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Enable/disable local IRQs, i.e. set/clear RFLAGS.IF, in the common
> svm_vcpu_enter_exit() just after/before guest_state_{enter,exit}_irqoff()
> so that VMRUN is not executed in an STI shadow.  AMD CPUs have a quirk
> (some would say "bug"), where the STI shadow bleeds into the guest's
> intr_state field if a #VMEXIT occurs during injection of an event, i.e. i=
f
> the VMRUN doesn't complete before the subsequent #VMEXIT.
>
> The spurious "interrupts masked" state is relatively benign, as it only
> occurs during event injection and is transient.  Because KVM is already
> injecting an event, the guest can't be in HLT, and if KVM is querying IRQ
> blocking for injection, then KVM would need to force an immediate exit
> anyways since injecting multiple events is impossible.
>
> However, because KVM copies int_state verbatim from vmcb02 to vmcb12, the
> spurious STI shadow is visible to L1 when running a nested VM, which can
> trip sanity checks, e.g. in VMware's VMM.
>
> Hoist the STI+CLI all the way to C code, as the aforementioned calls to
> guest_state_{enter,exit}_irqoff() already inform lockdep that IRQs are
> enabled/disabled, and taking a fault on VMRUN with RFLAGS.IF=3D1 is alrea=
dy
> possible.  I.e. if there's kernel code that is confused by running with
> RFLAGS.IF=3D1, then it's already a problem.  In practice, since GIF=3D0 a=
lso
> blocks NMIs, the only change in exposure to non-KVM code (relative to
> surrounding VMRUN with STI+CLI) is exception handling code, and except fo=
r
> the kvm_rebooting=3D1 case, all exception in the core VM-Enter/VM-Exit pa=
th
> are fatal.
>
> Use the "raw" variants to enable/disable IRQs to avoid tracing in the
> "no instrumentation" code; the guest state helpers also take care of
> tracing IRQ state.
>
> Oppurtunstically document why KVM needs to do STI in the first place.
>
> Reported-by: Doug Covelli <doug.covelli@broadcom.com>
> Closes: https://lore.kernel.org/all/CADH9ctBs1YPmE4aCfGPNBwA10cA8RuAk2gO7=
542DjMZgs4uzJQ@mail.gmail.com
> Fixes: f14eec0a3203 ("KVM: SVM: move more vmentry code to assembly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Jim Mattson <jmattson@google.com>

