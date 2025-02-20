Return-Path: <linux-kernel+bounces-524730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E33A3E669
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E22E3A976C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96C7264628;
	Thu, 20 Feb 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CsCn6+5y"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A41B4247
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086194; cv=none; b=qX9w0kvldtiyQV4yasNO1WNxPZJ4Hm7XNut6F8YR48CHN6sedV2PuL7HDTECpVKDdpPg8QW9peVb7/yZ8jYAuijqhZSWtQVlxUs27WRbFNxaQ5XSKizkOJJ49hGki3jiwJhidIdRJlYk3b8KRql+Z2pt6SXw76v4lbbDPS1bvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086194; c=relaxed/simple;
	bh=AKgJ4IGqSbL/a88cyY+H0QYMx/Z7oG6hVYBBX9CiYOY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pxUNwKHl8bNGB660WwzTEhBZhd+TYRpAZ7xenNAECzRVEkTswEzure8n7O3FB6dw5rQUmBaOVKTCSu7++ZSAx/UASmlCdr5NLsOVp2MPyTzex9EgB8eJCR5FgIYJqhKdsgF0S16Vfda45OTMMhx1HK4ofn/u5ZrcROIeZ+OJuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CsCn6+5y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc3e239675so4358698a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740086192; x=1740690992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8qvrVN9kBrozRo5CUBDtUXOgIdzDynxQKxj+1pBd5xY=;
        b=CsCn6+5yPzNKlDnn50sXpcEBAqaeiZ5oGeRJf/iSOsNMtISIVZ1/mIgUT/NIXzY8uZ
         B7rzjE7OQFwOaV0qyuCnSrlRlLPSpMjEey50accTbWxnTAJU3E3y34zsBjMHdD+87l1Y
         s/zEksd6rAgSW0a8Z7ucwE6H7ZA/hyfMFeDRbzn5UMDFTrIRgqkZynhcZJnNLWkf0oEg
         KujfxVGZqrFMM6JujP2nbbdHCrNwkV79FY3fxVRFB566ng2l7rrAav0CbISkY/JFqdZz
         xusjs+FhtFsf5VqSWqUfw/XIDJZCnjz38kRyGS1UVm0n2YOTxBhU7QdrbVAVhOFYtR1o
         +nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086192; x=1740690992;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qvrVN9kBrozRo5CUBDtUXOgIdzDynxQKxj+1pBd5xY=;
        b=DBFKMRROxrYK5YvXcIEPw9cltXHFX3oKbRV0k2oztI9Xkuo5qy5fpLWXkvhLg1V/vH
         Ho8+hcxvADDcjAqxtxemp+dZ5s0V3+f3iKpAdPzSqBP+5tlWWGZY/QjRZ5rB43rgNzUv
         rt4/KoIzrCNNiqvOT9icVuF6mwMT6jRAZFD2v47YC2GxxpGZ6R/FC6Tpwwm8BAQR1qMT
         DP5X62Akcd6uIjTminIrU41jrnojuEgUELCWhmrhL4kOmhcMCgN262UqfJyGQigzjlYP
         56Wzj49AgkjsH/Ssc/02GazAFEK8e+/SdQjjrZpaL+/XBQNVZ4o7SyWsFCH2o0PRJEIQ
         pZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2UHFfStjmBCJ7Us1sh/uegaIHng/ZJooItaQPqf+pmnDPfYwIHu4Ohj+oKAiilzmlKB9SFppKHCBdLQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxfQjG1uPjHIgElW8+OxC0MkHWHmC5OnDKWMG4Je1HI4uj08X5
	9ybLvFet2lX9TzKn1ZDwBwxNtbJznYzLbGtYq/Ihgv9i+QwTEA6WTRmuqZ3CkKoWF+roR1k/5k2
	wz78bDQASYdHHeDo4BQ==
X-Google-Smtp-Source: AGHT+IH/8YsBcP5uZYl0bmlmhw3cSkjvn5V2r10re47N885FbaitMXwjoVcr1y27PxvOM4eurK+/YRXaGJnRVEqq
X-Received: from pfbei26.prod.google.com ([2002:a05:6a00:80da:b0:730:b665:d832])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d0a:b0:730:888a:251d with SMTP id d2e1a72fcca58-73426d9ee22mr716372b3a.20.1740086191802;
 Thu, 20 Feb 2025 13:16:31 -0800 (PST)
Date: Thu, 20 Feb 2025 21:16:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220211628.1832258-1-vannapurve@google.com>
Subject: [PATCH V5 0/4] x86/tdx: Fix HLT logic execution for TDX VMs
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jgross@suse.com, 
	ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events. So "sti;hlt" sequence needs to
be replaced for TDX VMs with TDCALL execution followed by enabling of
interrupts.

Changes introduced by the series include:
- Move *halt() variants outside CONFIG_PARAVIRT_XXL and under
  CONFIG_PARAVIRT [1].
- Route "sti; hlt" sequences via tdx_safe_halt() for reliability.
- Route "hlt" sequences via tdx_halt() to avoid unnecessary #VEs.
- Add explicit dependency on CONFIG_PARAVIRT for TDX VMs.
- Warn and fail emulation if HLT #VE emulation executes with interrupts
  enabled.
- Clean up TDX specific idle routine override.

Changes since v4:
1) Addressed Kirill's comments.

v4: https://lore.kernel.org/lkml/20250212000747.3403836-1-vannapurve@google.com/

Changes since v3:
1) Addressed comments from Sean.
2) Included [1] in the series to fix the scenarios where
CONFIG_PARAVIRT_XXL could be disabled.
v3: https://lore.kernel.org/all/20250206222714.1079059-1-vannapurve@google.com/

[1] https://lore.kernel.org/lkml/20210517235008.257241-1-sathyanarayanan.kuppuswamy@linux.intel.com/

Kirill A. Shutemov (1):
  x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT

Vishal Annapurve (3):
  x86/tdx: Route safe halt execution via tdx_safe_halt()
  x86/tdx: Emit warning if IRQs are enabled during HLT #VE handling
  x86/tdx: Remove TDX specific idle routine

 arch/x86/Kconfig                      |  1 +
 arch/x86/coco/tdx/tdx.c               | 30 +++++++++++++++++++-
 arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
 arch/x86/include/asm/paravirt.h       | 20 +++++++-------
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/include/asm/tdx.h            |  2 --
 arch/x86/kernel/paravirt.c            | 14 ++++++----
 arch/x86/kernel/process.c             |  3 --
 8 files changed, 71 insertions(+), 42 deletions(-)

-- 
2.48.1.601.g30ceb7b040-goog


