Return-Path: <linux-kernel+bounces-309621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51532966D7E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8410E1C22315
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D500742AA1;
	Sat, 31 Aug 2024 00:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3OzyIw36"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C23CF51
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063746; cv=none; b=YQCNEY+htktm5rce93rI4o693Dqtd9EFXgQRR78DvLnIbMtOrTNEPcGCZtwqR0Hh6s7EKE0qsoU89vwvgBWugm+MS7/nNkjOYWZJWidnZQBuJmfmynmsEGWZAchUiUdTvNhGPldSPgWXAtUmsmL8wGX8hxk+5MPx73bPXZM3Xv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063746; c=relaxed/simple;
	bh=pOnikIeX/hx6RJZ3wP0KY3kh3B7ROYqQ/ZIW1bTiavc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kV37Rw0hdTO87Du2AahRUEoWrupjarTTDshBVNspSPzBFIs9ZJhryG0XRKf2p+MEBqX3qqtdaTrQE//vNZTg41N348+8foPoNl8j1GgFOQCgnRvtVyQRnBKiARAHv+GN2WjoJTCaeiAVu1OQUWSH5YKdw91LXbHG3ekGs2VsykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3OzyIw36; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20535259f94so10240055ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063744; x=1725668544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfPXYWUZzU2kLwWvr5udHYDk6DJfP9px5nwFhFPqn7M=;
        b=3OzyIw36D5o1b4/ZEk04dFeWAc9G/rbI17mXvYT0zRk3O9HhGwgBMT3kVnhHFMcS7V
         codiA529GDMg+orBCjDhD4J4Sqj8i+y2rOoLjMl63vV8Gcy+yblyCRJCDIg7hQB9yhZG
         YniT+W4ytmwhI5ZMCTJTqy8FEE9JDVphbBHhznBTzyhd+5px/GizYj5sMl5nYP+6smsn
         LcD5C6gVFkw9iKNXTp6j/xUU/6YBsaQnasnPzbGz4x5pHRvZxueBTO8KPKq/F7wkI6xh
         WdFA07oc77b+Gf9Jb4Ew/kUcfXpxNZD7u5+lE3z6Ys4jgB4nXOWYHJn7TTYPuQGtcbdc
         cjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063744; x=1725668544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfPXYWUZzU2kLwWvr5udHYDk6DJfP9px5nwFhFPqn7M=;
        b=s/Bni1uGXZTVOoVwSj6sHNGtzCCBNYQM4IiT35xNl9azfsIWwfRLK6jsfW4Xyr4bo9
         7UVe3a7qZkMs5plAX2DC9Xti/uAMfuBLNl5tj8SnHTFHrEc91QuEJouptm5LBBM3Jn4a
         Tu+3eQnTCzghV7dwPMNkhdPFxtmU44lPCsn3uyd4oVxOsXu1lvu+xZ4+YmRNg7iae/bZ
         PevnyGTCTU18go1m8st5Yd4YtAvWpHNzFm8Wzt4kh8C1R806nj81FntZXM/w0Ox7dGTV
         x7gHyhqjqgMr6ZDC4+Yv29jpT9VNf4oDs/M9mWr12jt5C2XK85y2zBop0WwOYfqdZC+X
         OfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/5aqqukSvAJfRFzi9gT9P+kJUeXeBCs3EemBvKvS1cCmEnmHHUWRvHKDEUSn8LxwbH7TakyypRTChfvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWe22nDwhsq47YsqzuTMxYmvhbWYvNR+dCfiMP6ozsjDv2p2r8
	XCpUi8Zu5V/vKF690LRWgZJAAuaYqZ6i46omOcr1LnQ1sNN3nmSX38qqow48QHy25HKwezml1kJ
	rtQ==
X-Google-Smtp-Source: AGHT+IHw9nlj1RDw9fvFahv3VS7maxtfXI673zlaEm3HTQPEUSrWXzkh0viD9otkg49B4GER8BqpxoOPA64=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e5c7:b0:1fb:716e:819e with SMTP id
 d9443c01a7336-20527669412mr2038565ad.4.1725063744059; Fri, 30 Aug 2024
 17:22:24 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:21:07 -0700
In-Reply-To: <20240802204511.352017-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802204511.352017-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <172506355251.338547.8844071082030684446.b4-ty@google.com>
Subject: Re: [PATCH 0/3] KVM: SVM: Clean up SEV-ES save area management
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 02 Aug 2024 13:45:08 -0700, Sean Christopherson wrote:
> Clean up KVM's handling of the SEV-ES host save area, and opportunistically
> add a helper to dedup code for converting an SME-tweaked PA back into its
> struct page.
> 
> Sean Christopherson (3):
>   KVM: SVM: Add a helper to convert a SME-aware PA back to a struct page
>   KVM: SVM: Add host SEV-ES save area structure into VMCB via a union
>   KVM: SVM: Track the per-CPU host save area as a VMCB pointer
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/3] KVM: SVM: Add a helper to convert a SME-aware PA back to a struct page
      https://github.com/kvm-x86/linux/commit/48547fe75ea7
[2/3] KVM: SVM: Add host SEV-ES save area structure into VMCB via a union
      https://github.com/kvm-x86/linux/commit/1b5ef14dc656
[3/3] KVM: SVM: Track the per-CPU host save area as a VMCB pointer
      https://github.com/kvm-x86/linux/commit/32071fa355e7

--
https://github.com/kvm-x86/linux/tree/next

