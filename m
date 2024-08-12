Return-Path: <linux-kernel+bounces-283500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657494F5AE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A942B1C214A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D6D18800D;
	Mon, 12 Aug 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tisC+cn3"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC518784F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482834; cv=none; b=D2c9a5l72Wahsxyx6dTcX4tlP4CqbL7mfnFLF8+AinWTkP2JiV1BGPTRPPFSNcKZCi/R/RzRvzHm2tvSbJEAfguFJB3/A1l9O77ZOrZ7nV1MBKsLy+ISoHNOPq0lsN6MHUt3dE2IXDY3SIQZES5P1+gB0xQ1NVEH6n7U7fsOqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482834; c=relaxed/simple;
	bh=x1Gb8SB4mpP+wfFgYnDE4mv3uyT5UcVGyJZO+O2IoKc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ehtUmZ1VmTarpjaXx+rFpBvUiIbt5VayzAswYXCwZdgtCICwi2eQMNuafGyByBaa3z+y01yhJSLVRWTC+urwcvMSyeRKdUNngV4U8S3N1WbZqoOpqstVtdWX2ZavCNXlIRx7qTSnLYCCgr5yK5nlNE6/Z9G+etKMVq0xBXv0lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tisC+cn3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-721d20a0807so4736554a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723482832; x=1724087632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z1s1bGCcVN/xkxWve8NUCJjdRnJHJDY/h72u7nlvk/8=;
        b=tisC+cn3Zosb84aYhyGsY7urdJk94FVHm25pGt33TvpfdyXQqzZPaaWPJZi6KH/Sgi
         Oxdeyh03UUdmgxwWWfE+wAGghRm4QdxF/7Ng/lBWZRF8NxqBE+ExrYZi7eDsJaczKQso
         guIDxfcOmEIpokjP8DgAP3Ukqk8MBgSAHDGWAb6HYuBX7dGHNAWj7vFzvbKWgg2ZlB63
         A2w+6mamCpkAIXIKDQrS8eypOFvp6S7LkbOou9sccutBhUClpz1otonx/Vc9jpsKbWsd
         wbpxyLMFjIj+0ralhSKBrv/FFGnbJ0S1Mi7KlQBBgTzpvGFtVbteszNMZs1E0ZOM6kzU
         3cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723482832; x=1724087632;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z1s1bGCcVN/xkxWve8NUCJjdRnJHJDY/h72u7nlvk/8=;
        b=Nwfjeo0NPwIDB6Ne1uZUqnZ/y0FxNJ4ixk5uJkl8jZIS0O7jwnwPbCrRJtN/bgvDGa
         jFUyTyVqiPcQEJoh12wvLeRmscWxLjaTTfjwSxl3GbV6Pc7OihJnkGHG25iFwgII1Yjh
         Hn5ALvfu8MsO4MROhFQrwsfqhDDvB3ZKYayUq0kjYXczmoyB0qfAW0oYfwxSBfDWKO2H
         2AHQnqAjOO4EZN+ffWBEBsd0SIvgADqXx4ZY1C325GYGldretheM1U7ytzbnN2J6bdWD
         Iw0nQ92Mz6Hkworj8ma4GxXUYNooURv7NiMj14qH4f6Qmh0N7grwXQPsMFBbJhXm7FLQ
         08Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXXpSFBVf7lYbeVKH6iRc92kERyCUresa4j3nm1KxQa0i6jCB0mcPq9x1E4kxwra++ZE64tJyz+9GrtdjmsHEaBKj3wE+HnyQYaDcKA
X-Gm-Message-State: AOJu0Yza6+2+1uycsVzB5Vk/5AXshNu04mmfK/k+507R7Fs0Txj6smn6
	u1g3VL1s6J68+E7wx5MlDZRFRJIymUwOCsKQ2Jf5vu5ADz/0RFqUk+HCEhwu0y0NXvHPQEor0AD
	Gzdli6A==
X-Google-Smtp-Source: AGHT+IFZur4pxrvFdN706JZtZb8N8sYJW5Ui4zQ330SdBlLi/fdgnC75M4+aVGUBezgmmGmCPuo1mHy56p3R
X-Received: from vipin.c.googlers.com ([34.105.13.176]) (user=vipinsh
 job=sendgmr) by 2002:a65:6a0e:0:b0:7b2:5893:ac16 with SMTP id
 41be03b00d2f7-7c695196a9fmr1008a12.6.1723482831991; Mon, 12 Aug 2024 10:13:51
 -0700 (PDT)
Date: Mon, 12 Aug 2024 10:13:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812171341.1763297-1-vipinsh@google.com>
Subject: [PATCH 0/2] KVM: x86/mmu: Run NX huge page recovery under MMU read lock
From: Vipin Sharma <vipinsh@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: dmatlack@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Split NX huge page recovery in two separate flows, one for TDP MMU and
one for non-TDP MMU.

TDP MMU flow will use MMU read lock and non-TDP MMU flow will use MMU
write lock. This change unblocks vCPUs which are waiting for MMU read
lock while NX huge page recovery is running and zapping shadow pages.

A Windows guest was showing network latency jitters which was root
caused to vCPUs waiting for MMU read lock when NX huge page recovery
thread was holding MMU write lock. Disabling NX huge page recovery fixed
the jitter issue.

So, to optimize NX huge page recovery, it was modified to run under MMU
read lock, the switch made jitter issue disappear completely and vCPUs
wait time for MMU read lock reduced drastically.

Patch 1 is splitting the logic in two separate flows but still running
under MMU write lock.

Patch 2 is changing TDP MMU flow to use MMU read lock.

Patch 2 commit log contains the test results. Here is the brief
histogram, where 'Interval' is the time it took to complete the network
calls and 'Frequency' is how many calls:

Before
------

Interval(usec)   Frequency
      0          9999964
   1000          12
   2000          3
   3000          0
   4000          0
   5000          0
   6000          0
   7000          1
   8000          1
   9000          1
  10000          2
  11000          1
  12000          0
  13000          4
  14000          1
  15000          1
  16000          4
  17000          1
  18000          2
  19000          0
  20000          0
  21000          1
  22000          0
  23000          0
  24000          1

After
-----

Interval(usec)   Frequency
      0          9999996
   1000          4

Vipin Sharma (2):
  KVM: x86/mmu: Split NX hugepage recovery flow into TDP and non-TDP
    flow
  KVM: x86/mmu: Recover NX Huge pages belonging to TDP MMU under MMU
    read lock

 arch/x86/kvm/mmu/mmu.c          | 168 +++++++++++++++++++-------------
 arch/x86/kvm/mmu/mmu_internal.h |   6 ++
 arch/x86/kvm/mmu/tdp_mmu.c      |  89 +++++++++++++++--
 arch/x86/kvm/mmu/tdp_mmu.h      |   3 +-
 4 files changed, 192 insertions(+), 74 deletions(-)


base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.46.0.76.ge559c4bf1a-goog


