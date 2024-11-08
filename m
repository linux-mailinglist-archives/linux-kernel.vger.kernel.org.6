Return-Path: <linux-kernel+bounces-402203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4E69C2500
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50735B222EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74761A9B54;
	Fri,  8 Nov 2024 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xRleWoVd"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40E1A9B36
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091470; cv=none; b=mIqmGRapdgUU9qRW4h9imG+ti+qwBzgvLz7yjouEbQIn2x9TeRHFdA5EPOsxhJcf55gk7G2wvv84xCtCM5JA8wN6X5nUNXofiwFHVnvp5Qtb3XI1nDipMT8twqWUdAceLSHTOqAvYPJygezQktT26lNm1Xg9ZOd+T3TSZqoh0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091470; c=relaxed/simple;
	bh=xJjap7sNY/81/oXWIYKmLfhopGKwOX3mvVuYtwhXGds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y1OWEGgVxE1WAV1cagqGgKK0JZ3ygfqseSIMdy6YdiI7L39qgFgEMgZZYLRmocmaoSYTGXFILhw/HWmYbsppKnZxKo/Fm14KZCOnWVFm3AKYi+rZPFCJLIS9YL2zRzZmbuP7IwOnf5/LgefQtFIgvxLMtaUgzwNx0J36wTj4lCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xRleWoVd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e2ed2230fcso2541454a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731091468; x=1731696268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WoOm9ACkx5SWCzD3BiI5DqC4avsoAgUOaWIdVW9u+Rc=;
        b=xRleWoVdjCMDnSrolcmD1snIBmFyhwXW0ZzKyCP+LxdBWtPP/GvpzbLAEI3rasHT26
         586y6KTl9+lMcnShpqx+PCBMMfDHid9kV64iFrZpQO+P08gZnTiUq8Nx7hL2XVLWxMfg
         5WI8ZRU19c3d7BUhs+XReK89KcfEKOFYc/UuGm4JgH8gbfq0yhGmOTBUSeBJQjVwr9Wf
         c575pjgKjzG/4PsvrWCrxf9ukpgokgMZLeTPNbOrDKPbkEJy810nK6NwPWqooztamwCX
         jpui46XVYFUJJYtOQeFhtCWV8CCDbAAX/DoqbbSJUgA4PYlJ3GZYpA6jm+WpRZ7QrEDC
         p6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091468; x=1731696268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoOm9ACkx5SWCzD3BiI5DqC4avsoAgUOaWIdVW9u+Rc=;
        b=EPkuMk6Clikj7/sh9N90FaDutr3/DCxRxnz4kcmRsMxqmLovU9GlWtCQbdykOHyGyp
         97KZLGXAd6kyqjBk3W3VN9QvydJR6OxJzGUqyZyqQETwWrGSqftEzhNfhFdHnAA6Sl8W
         1qOBZluDdjsldTno4lO3mJJYnYS9wHsT1OHQhWL7YOg7RUccg9PPV1HEnW7bZjlKSrXt
         QOzIVv2AfMmacSGHDdj3oLfX8xMRXMklX7gWftPKpKu/E5Wf85fEt5AVRSLtWP75ogoP
         jyrCOtNpzg+8NkZZADHAZZE0HjSiZ5wKIEgfSJj1VwV7oIGtkrYTngMEkb8Ee41/r6es
         Nzog==
X-Forwarded-Encrypted: i=1; AJvYcCW9h9jCUVyyGqyWmTytJs2nU1Kpjl8yqp0p7UubU1Jqx+D7wM9dPG4SPhPnviBMT9XW6meZiLFI8eW69tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu5POsR3na/YxPHMKUQ5zS2C1t8zdEC9Q/YHGLY/In209Ph4tW
	ZWtScZ+koKtOKt8uHCNRISUOqg+uOwgSfk7M7G6SLn5elH93Iwiy89ZCqxotlfBqc4nMUvHrKvj
	yiQ==
X-Google-Smtp-Source: AGHT+IFVEg3hBrHUvpQAXsewTrpUVfh6ZcizLr1BwBeaZYtb+taySoJXMd2e7OomEttUBjSKQhB3qW+zBz8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c41:b0:2e2:c183:8b1c with SMTP id
 98e67ed59e1d1-2e9b168bfcbmr21938a91.7.1731091467897; Fri, 08 Nov 2024
 10:44:27 -0800 (PST)
Date: Fri, 8 Nov 2024 10:44:26 -0800
In-Reply-To: <20241108171304.377047-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108161312.28365-1-jgross@suse.com> <20241108171304.377047-1-pbonzini@redhat.com>
Message-ID: <Zy5b06JNYZFi871K@google.com>
Subject: Re: [PATCH] KVM/x86: don't use a literal 1 instead of RET_PF_RETRY
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 08, 2024, Paolo Bonzini wrote:
> Queued, thanks.

Noooo!  Can you un-queue?

The return from kvm_mmu_page_fault() is NOT RET_PF_xxx, it's KVM outer 0/1/-errno.
I.e. '1' is saying "resume the guest", it has *nothing* to do with RET_PF_RETRY.
E.g. that path also handles RET_PF_FIXED, RET_PF_SPURIOUS, etc.

