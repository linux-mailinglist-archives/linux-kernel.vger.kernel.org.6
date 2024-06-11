Return-Path: <linux-kernel+bounces-209577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA78E9037E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2D11F260CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A45178CC1;
	Tue, 11 Jun 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2xshGD6"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C634502C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098314; cv=none; b=bNWijNt7fcDuXBLYdjSKGtTt/5RkLhAiT5ZbRRK3Nqd5NFZ/fukYiltS3CJY02c6LNeIxL/UwzvaozynskxMZoS2GOAiCnJK8QnXmobHm2c4bVOJOr0u6zvLTjD3fwLHlTlyQItPgyHzZnNSM1w5vOrrLBHOtIJYyOWtwUKXUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098314; c=relaxed/simple;
	bh=ftgWZiqtadHCzhVB2m+D7dbu8Hr2VpGHA+tMkixI3Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLe9I3BLJ0DYBxwem25WjNjinBty/96AelwJhkCmby7oTDtilpKslFzPlQ8JqSO3eUHCo7roMwYlhjWephoyUYzViKAwnE1qonr/v1ij0kKiAI1EEhcPzy3ZLpdm4ALMA3DNDfZNbzNMKPJOMpUsAjQj7S+pGpo9B/4JbzPCU+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2xshGD6; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52bc1ad11aeso1822e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718098311; x=1718703111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4o7ZRkApNXFZYUkwJrI9XiAWPg4SK4rdhZDRj0Mf6YU=;
        b=S2xshGD6hi4uY9zdNC+u8dmZH6ppxK1zGiq8PMz//1YshJF1KElWDgkn8CZyySjxY7
         8v4KLPko9cT/3q4yCrwHi06dn3+CSLDuCOIZ1mFUD39lMEUAXXlIf7CzfVKo1Ohynm1a
         8Tju7KLVGWDWxIitis3hb1YsTwm3tpySwTWOf2cRNv+E2ZdqG8WyIgWphbfo6IucMUWS
         pVWFRptu+1/s7aKX2sD/meewb8dr/Ws4vJI0elFXCMMwcwy/GQm6sXI6J44yJQUA92aV
         KGkIVu7u4WLkN6BAy0/A4WKA5mTEIeLK6SQQsgBoKbEvQJgTbYgOefE9wgPomzhY/sgQ
         OJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718098311; x=1718703111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4o7ZRkApNXFZYUkwJrI9XiAWPg4SK4rdhZDRj0Mf6YU=;
        b=ncB2QZc0XUS0x27WXYoiqVWMvv+VA8jNAX3tMhViGB3nA0G0/NkhAcmqdt9h/b3iap
         lxIx6qExTryqTsuq2bt8BL0eepm/jhrrby+0UNhw8wx72Ni1sVCuoZaSnGHxoogkjLlQ
         aPX42YzI/g0KD68DtybKlAw/HZ8pU0I22D4kAWgyqWlIPXLmrbsXZyk+NRSCSXd1Yb1Z
         VAl7Q9f/ltfNoi2Z1Vg8eV1DwwLfmkZDClctIrzRAxqAzLlCVEBmhKbciEH02A3Du7nK
         +9JqU0vtzi2nXxlo4HNu66g25+T/FrZ1pJ5E7rlNYcrr5RS1vpgS8qbXZ8hdPaQ68iwd
         ji2g==
X-Gm-Message-State: AOJu0Ywp9DRyuz5xuT0ln0GKZCJfLz3mZGAYgf/9E6Omi8Uo9PCBInGX
	kovgGNx26x7WTp0qqH9dCZe1FX+OvU0idBA76XyyvVLGjO28i3cI3Ob+OjR5YoHXdWFa0NKDFyX
	Lf4MyJ8Z5IyuPuc0AXGRdAk9bTIgThjjW9ZA5ZyeKjGadT6hKRKah
X-Google-Smtp-Source: AGHT+IF/pXibEy+6RKtWy/x+3T1h90IZS/g1zeB1zrxaCBW6zvJBR6nZzy4vnR7LxFT2eektIwbz/A54OyoRnl1mCt0=
X-Received: by 2002:a05:6512:3d15:b0:52b:84eb:9072 with SMTP id
 2adb3069b0e04-52c93d73d10mr103071e87.6.1718098310488; Tue, 11 Jun 2024
 02:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com>
In-Reply-To: <cover.1718092070.git.dvyukov@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 11 Jun 2024 11:31:38 +0200
Message-ID: <CACT4Y+Z=U+Y8gKBgaU76=zg=rAdq=AQ=epAq+RxDfdXsaqO_0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] KCOV fixes
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, elver@google.com, 
	glider@google.com, nogikh@google.com, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 09:50, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Fix spurious KCOV coverage from interrupts and add a test.
> Ignore some additional files that lead to large amounts
> of uninteresting coverage.
> As a reference point, tracing a simple open system call
> produces ~10K PCs with these changes instead of ~45K PCs.
>
> Dmitry Vyukov (4):
>   x86/entry: Remove unwanted instrumentation in common_interrupt()
>   kcov: add interrupt handling self test
>   module: Fix KCOV-ignored file name
>   x86: Ignore stack unwinding in KCOV
>
>  arch/x86/include/asm/hardirq.h  |  8 ++++++--
>  arch/x86/include/asm/idtentry.h |  6 +++---
>  arch/x86/kernel/Makefile        |  8 ++++++++
>  kernel/kcov.c                   | 31 +++++++++++++++++++++++++++++++
>  kernel/module/Makefile          |  2 +-
>  lib/Kconfig.debug               |  8 ++++++++
>  6 files changed, 57 insertions(+), 6 deletions(-)
>
>
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> --
> 2.45.2.505.gda0bf45e8d-goog

Thomas, Ingo, Borislav, Dave,

Can you take this via x86 tree please?

