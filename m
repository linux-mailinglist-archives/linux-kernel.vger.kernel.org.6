Return-Path: <linux-kernel+bounces-441828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB29ED4A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EB9281275
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC0E202F9D;
	Wed, 11 Dec 2024 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4eJwPPod"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF224632E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941237; cv=none; b=seCOiKyVZbHxlPcMFelOZWy8HzLNeTEvJDKWeWJIc2hbxT6aznclCTtJQW03Z+O6ayMb61an7xHGnz5wv+2mE+cus6T/TwlaX+HK3UO827d+zZvAM3jS0s3t9vW16dz4RWPtDVBmcX6PuW4pfAAsbFIeXVl9qiZ4WAL7ap7k7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941237; c=relaxed/simple;
	bh=eLQNLd5wRv8SOWkCMUttN5dD8JyVnkMs9ZHP4OQrzcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qvDHX2QDfZ0FBrjKC9naIl130EypSyjgZKdr97ETE7Jw0NUvYygW4LEFBVcDQ33wxDj6DHidbSyrT9gEUGkbCSe3RjjPxh9z8Ux4LyhpENeLUHClNt1na5rva4rNDTXactHrcrRJV/wYbrNx5aVnvV6RhBUKfL7vNwW+/M+l2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4eJwPPod; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-728e3d9706dso1802120b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733941235; x=1734546035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+Ox1uza8Q79A6RwFeyGkXs+VHW6BnofeA5s7qSYG3M=;
        b=4eJwPPodg6mtnp3VFSBnHN396zCQKMsddDlh5NS8jZqSShPHLqM4mHxNfqXeBygMwR
         lVAQ38m9BzqChj+byZ21K+XX5JjzRVaR7vxVUxiTJ501mVPAt4PYdX9hzN4xobsdi1UI
         g+I6lYegvVJjlKWZZVTVu9uS1olmtiNsW6h5P4lBBYSSKBDrgJzx4dWecfcniPExwY4o
         BGJM2II5ziQLi6OY+xeOiJAIygxIIRzl1ycWylY0G1NVPWElZ8lcGi21tdiOOb/fM0OB
         PmEHHu3L2Q0yHk5/YVTTNnj1j5AixR24thMLxMNu0FJwhpCcjsv9ygJa0RqLPl2aMXs3
         hVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733941235; x=1734546035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+Ox1uza8Q79A6RwFeyGkXs+VHW6BnofeA5s7qSYG3M=;
        b=iK2jrdQxIKnSfQhoUbwngIXatMInC75pYqK8tgO7kEy192P8Gg4ldJzWGK4Ygl1751
         Da+tyASJDUNYQgrwdA/cdKS7W/xxp2bRkbs3AcdUVGHY8NMlLgZsO1WY+4Y43w6drkYP
         n7fnPnMls5bS9XwNCdbLrCIFlK7cZkv1LU840yuVZ5gHMafGgNgyAQGEcMHPOLW2mnHp
         2HuOp6J2TQ3Ofj3ZdpEP05gRFAki5bndIBIN2VQmfyXoOc5xTi9rzVMU2dCwXxuONiFH
         LiSJF0Mryvfj6hNYkDloTyn2Yqb8Np1gt82NfAeNy1zGKsIXTBJWvsKHbyd07tMWOjkU
         wQFw==
X-Forwarded-Encrypted: i=1; AJvYcCWWWpKkNKE212Dq6nljDiqXCSKxBAUEGtpSXx3N0RveCllcMLUrY7U6ClrHweyroumqsfSBrKZ/Mq46P8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDc22ffc+9Y/sAG7gVlLAx/nKvsY5++F19e563ITWy+y8R5SkS
	kC9WTdpJlTV/IO26/B4dz+eBW2gJBzvLISw+Uq5w3AtlpUkef7s5D+nmbTH1WAuOM+cteazgeCZ
	ZSA==
X-Google-Smtp-Source: AGHT+IEZfd8RpvX3OL8+D64SC/c6EBzqjS61c4iGRcc1nCHXG9qtDFB2g/ZbpKx2mvqm2c2s2Smm91XqVPU=
X-Received: from pfwy4.prod.google.com ([2002:a05:6a00:1c84:b0:725:ceac:b484])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10c8:b0:728:eb32:356c
 with SMTP id d2e1a72fcca58-728faa1fcb5mr375468b3a.11.1733941235183; Wed, 11
 Dec 2024 10:20:35 -0800 (PST)
Date: Wed, 11 Dec 2024 10:20:33 -0800
In-Reply-To: <20241111102749.82761-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111102749.82761-1-iorlov@amazon.com>
Message-ID: <Z1nX8aCfZMvJ4co4@google.com>
Subject: Re: [PATCH v2 0/6] Enhance event delivery error handling
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk, 
	dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 11, 2024, Ivan Orlov wrote:
> Currently, the situation when guest accesses MMIO during vectoring is
> handled differently on VMX and SVM: on VMX KVM returns internal error,
> when SVM goes into infinite loop trying to deliver an event again and
> again.
> 
> This patch series eliminates this difference by returning a KVM internal
> error when guest performs MMIO during vectoring for both VMX and SVM.
> 
> Also, introduce a selftest test case which covers the error handling
> mentioned above.
> 
> V1 -> V2:
> - Make commit messages more brief, avoid using pronouns
> - Extract SVM error handling into a separate commit
> - Introduce a new X86EMUL_ return type and detect the unhandleable
> vectoring error in vendor-specific check_emulate_instruction instead of
> handling it in the common MMU code (which is specific for cached MMIO)
> 
> Ivan Orlov (6):
>   KVM: x86: Add function for vectoring error generation
>   KVM: x86: Add emulation status for vectoring during MMIO
>   KVM: VMX: Handle vectoring error in check_emulate_instruction
>   KVM: SVM: Handle MMIO during vectroing error
>   selftests: KVM: extract lidt into helper function
>   selftests: KVM: Add test case for MMIO during vectoring

Minor nits throughout, but unless you disagree with my suggestions, I'll fix them
up when applying, i.e. no need to post a v3.

