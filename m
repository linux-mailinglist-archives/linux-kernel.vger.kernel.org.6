Return-Path: <linux-kernel+bounces-355699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E239955D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A6D1C25570
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABFB20ADE4;
	Tue,  8 Oct 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wwRkBKfq"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B69920A5F5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409149; cv=none; b=Y+og3eabM/ADfDF3+sKZ/omytyzrbp+IOxErHkhlKl9q9WBpVsX5PXzutVc/MnQ8ibbIci5TVYb75qsthSfE7ERLv15CscWZ1zpqKnAb4c0JENCW7DOA9aNwUOINVygd19iyW3HyYrxq53+hu5Z/CLcmqhFghq6YecRre4eMl0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409149; c=relaxed/simple;
	bh=K0qRIU2gct1IAPurPWsNp/o/kDxBWiDGIlxlCte6ZbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S5m4ZMtZns1ZyImZFGNuHz/uyQwsc2Y/XQjvk87KdM7qt2bzdF2+KgI7dKd5n5KKeBSnsS2/hqDHfn7D8t91bhVi1JYO5UZMNhq9H6P9+c+sloTrmiGTn1lztEFwQGmUwXpUPlEtFhvRLrUf++y9GCnl1ydPzTkosZi25kS/ZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wwRkBKfq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2b049b64aso95391517b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728409147; x=1729013947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+utCni1L2If5Zb0kQ119kpHr19HtdYxR1+3jlY+lTQ=;
        b=wwRkBKfqW4WZ2aLiKxV7rIL+/nFb4G79d/oJWpmvuyuPY5i8ODqPiCrFyZEfj3HSmt
         +WHZd+O8hYTQsdMkyqDlsEbzyjLVG3X7YZlIfNXOt4cjC3G8K8VQ/y4qMuwnJNuP+Pf7
         3NpcXGTJmsf+0ZaATpzBH3R71XtZJjjK1hmbbfOdhT4SFQ/fiCwh7vhWZobF/EU0cuTg
         4mvK0xyG31BekIwsFcxhAe+lYXyrDOdNdzPspZgOzKbxF6v2XusuzRUpGekGaD+eFqJE
         Lt/phmZ30GW8fw4a0w+Zi8RWgd27imaxlUIoYFm5F5v5fRJ9OtcmBt5+hJGEArzzdX8M
         ndew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409147; x=1729013947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+utCni1L2If5Zb0kQ119kpHr19HtdYxR1+3jlY+lTQ=;
        b=shdugBySKKI4YerdatLqoiKYEG2bEgkSd9O8D+5FhM+rCix6d6nKHASSxxGBAL6KEh
         G20f/yUtGjKsj9iVKWKl55R7c7eHWqoSkn/BuJbGqBnvYlDx4BEW3qzquFocqheZg4aF
         BP9J1Lb2vgOQxTJOZq3cWCYWBegKEbyM3fH5GEqhX2X/nY9kal3DMW5Bd5cxbH9CpM8B
         fhdhRRhQygnwuHVaeiDWN8kAqZgCPqnbgFGuKz4JMWPcRFqx0G2dBFPem4DRTfaFj2YN
         cnpuhO7E+8rswkYjOURNEuOoB1t4j+/f/2eTocqLuKOnGY1o0YIB6flRx1RTFNSUo2xo
         ljeg==
X-Forwarded-Encrypted: i=1; AJvYcCWU/PXY7CkTedSOhQMAaDzirH3EX32vr5FCO1R9n6cpD00FD84sL4c8uGRZ8BoEtiKfJRpsQPUyYcbbOgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cEOqPGX0qGdYRkgYKMx8O0fD19tBQGLLfDR4TPetVlalPwkb
	XYtLVB8F0QQEcG6NZta1WjrIR7nVeDohAgIbi3iZgYp2IrFhkoGp2nfdIss2J251ecTPO2Gijwy
	vtg==
X-Google-Smtp-Source: AGHT+IHCrhL61p8TLN8MW0pIpAL39LcUBMdbO9ONRNweIKqSy4bXfgwZV7m363hRkWMG9A1o+J60cMmmihw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6a07:b0:6dd:bcce:7cd4 with SMTP id
 00721157ae682-6e2c6fd835amr3356707b3.2.1728409147081; Tue, 08 Oct 2024
 10:39:07 -0700 (PDT)
Date: Tue, 8 Oct 2024 10:39:05 -0700
In-Reply-To: <13d192bf-8151-415f-b508-7a4ebe4766f2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802195120.325560-1-seanjc@google.com> <20240802195120.325560-6-seanjc@google.com>
 <13d192bf-8151-415f-b508-7a4ebe4766f2@amd.com>
Message-ID: <ZwVuOcRujpzo9yTb@google.com>
Subject: Re: [PATCH 5/5] KVM: x86: Add fastpath handling of HLT VM-Exits
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nikunj@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 08, 2024, Manali Shukla wrote:
> Hi Sean,
> 
> On 8/3/2024 1:21 AM, Sean Christopherson wrote:
> > Add a fastpath for HLT VM-Exits by immediately re-entering the guest if
> > it has a pending wake event.  When virtual interrupt delivery is enabled,
> > i.e. when KVM doesn't need to manually inject interrupts, this allows KVM
> > to stay in the fastpath run loop when a vIRQ arrives between the guest
> > doing CLI and STI;HLT.  Without AMD's Idle HLT-intercept support, the CPU
> > generates a HLT VM-Exit even though KVM will immediately resume the guest.
> > 
> > Note, on bare metal, it's relatively uncommon for a modern guest kernel to
> > actually trigger this scenario, as the window between the guest checking
> > for a wake event and committing to HLT is quite small.  But in a nested
> > environment, the timings change significantly, e.g. rudimentary testing
> > showed that ~50% of HLT exits where HLT-polling was successful would be
> > serviced by this fastpath, i.e. ~50% of the time that a nested vCPU gets
> > a wake event before KVM schedules out the vCPU, the wake event was pending
> > even before the VM-Exit.
> > 
> 
> Could you please help me with the test case that resulted in an approximately
> 50% improvement for the nested scenario?

It's not a 50% improvement, it was simply an observation that ~50% of the time
_that HLT-polling is successful_, the wake event was already pending when the
VM-Exit occurred.  That is _wildly_ different than a "50% improvement".

As for the test case, it's simply running a lightly loaded VM as L2.

