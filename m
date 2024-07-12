Return-Path: <linux-kernel+bounces-251243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813F6930291
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C50A283053
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4213A240;
	Fri, 12 Jul 2024 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1uVMrMsY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F91386DA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828637; cv=none; b=KRmrkvMf+uRPc+iEJGs4xPMLUYwZU8TSiEBD16c/ng4cV70PqI6wZP5Kis85RRc01PvxDu1K+HxDNQY35aAJ50sF63UNvIB8j2LKPMVtM1Oo46MihmPJfS88OjyPZdmuAB3Njd1EZsNriJvq2rP6r1ryNwXBPT5E7rM5p7Gvt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828637; c=relaxed/simple;
	bh=jE5Q/yNCYT9c7v86hb29UGgniqR0gk9A6USCxo5jHW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XN+ETQpSjUGNou2nUj6c22K4gGr3OhfvtUb+kARKl8+CuLPhkVJ8ccyflkcosrMr0e2ToyNlxre6IZQEoHI/KdV52VM9daFrPM1/pdOVDlIrryrgDd9BPBNMMCuegTqLlmK/SpyLP5iJUvDsB8S3Nm3gXTylUuStuKW1tkc65j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1uVMrMsY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa7a8147c3so4665337276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720828634; x=1721433434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ2evPb3yicx4BVE/K0nN/M2w76ygvg8rXfg8tUdJZI=;
        b=1uVMrMsYB6ahqQlGg0t+r3ttaAHlIwdCmS4/li/TGbT0iKk3PY8bpSR1aM/W6alcKF
         ViCx2lkEEwmMN5gaIrerdl78jLN36eQJEybvP9bmZLEArmKeoRfNzMON8ZvGDLTkcHeh
         30UVyFkoGj4SJTaXSdmGH/VIr5wIdYUxvPWuTM5aIeHUwYWBwmv0hBcrfJZYlXQbKwcJ
         xA7ipmw5XL9Ig9DNLaFpSeZHa7tEgMWUJ00Ki5fOHCIoFgxZYw1Ir0l8KlvQSIyJ8w7J
         H9Rs62rSoDLVp8kf3CfF8ywkjOcvLKMF7Lh+2kuR/NqNOosyKzzmnbwQGRtUuJrx1K/Y
         vHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720828634; x=1721433434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQ2evPb3yicx4BVE/K0nN/M2w76ygvg8rXfg8tUdJZI=;
        b=QV9qpAEy/r9F987uYtJlLagUwJByyb8KPKBdgfzuFs5FFEoB84OGoe90cj6it5KVqf
         CxRKzO3U7508v20yjg4V8f08tgmxkSdbWsSGNOdP+G2pmz1RxCHABRnIs3qYD54oybcW
         pOLhpH3aMx93qbm9W+jhf5JIWys48WpW9522w2DcJMzHn/NM1+ifH0t+8SiyolQbh+aO
         UhfwfmgOUtDP2UE7yxNMASa+OvkL8sFjnpixgGpGdvRCLkzpBJS66xaos8QrvY4iqepL
         c9NfONp74pEQi5jb0Xs79DMyPNy2yk0pGX/eVDARoBp2YX/VMhsKdsJrOzl9/Uv7kNOJ
         crew==
X-Forwarded-Encrypted: i=1; AJvYcCVrDYqGWb+1M80Z841wWEuvGQ7ZRxQU8985fXb2PM7FOQaOJViWytw/EtFamfECiLNH0LoxtKjd4XP66g8sxBlyfEsZ2/nMthNd1Y9E
X-Gm-Message-State: AOJu0YwmtFnfDt8D0N52SqPmG+87mOGA6aAyF5AxfDBi2mGUzwPjToWx
	xUIB57xKAQpsSSu/5g8VrFwfHeKWrjXFonuKda6Sv3b81dStJwOxbobUmxP25odgSSeJFlFUVV+
	DXg==
X-Google-Smtp-Source: AGHT+IHpbISAfrUVTmXP6KWQxkiPjcQFcSIqtJ/C19p7nQ/lH0cFneNPxuGNFGQEcr4AgwDJ3DqGBkUGeWY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2403:b0:e03:554e:f396 with SMTP id
 3f1490d57ef6-e041b05b915mr558009276.6.1720828633739; Fri, 12 Jul 2024
 16:57:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jul 2024 16:56:55 -0700
In-Reply-To: <20240712235701.1458888-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712235701.1458888-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712235701.1458888-6-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Remove MTRR virtualization
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Yank out KVM's MTRR virtualization, which is Intel-only and limited to very
specific setups, i.e. can't possibly be useful for any real world, modern guest.

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-mtrrs-6.11

for you to fetch changes up to 377b2f359d1f71c75f8cc352b5c81f2210312d83:

  KVM: VMX: Always honor guest PAT on CPUs that support self-snoop (2024-06-07 07:18:03 -0700)

----------------------------------------------------------------
KVM x86 MTRR virtualization removal

Remove support for virtualizing MTRRs on Intel CPUs, along with a nasty CR0.CD
hack, and instead always honor guest PAT on CPUs that support self-snoop.

----------------------------------------------------------------
Sean Christopherson (3):
      KVM: x86: Remove VMX support for virtualizing guest MTRR memtypes
      KVM: VMX: Drop support for forcing UC memory when guest CR0.CD=1
      KVM: VMX: Always honor guest PAT on CPUs that support self-snoop

Yan Zhao (2):
      srcu: Add an API for a memory barrier after SRCU read lock
      KVM: x86: Ensure a full memory barrier is emitted in the VM-Exit path

 Documentation/virt/kvm/api.rst        |   6 +-
 Documentation/virt/kvm/x86/errata.rst |  18 +
 arch/x86/include/asm/kvm_host.h       |  15 +-
 arch/x86/kvm/mmu.h                    |   7 +-
 arch/x86/kvm/mmu/mmu.c                |  35 +-
 arch/x86/kvm/mtrr.c                   | 644 ++--------------------------------
 arch/x86/kvm/vmx/vmx.c                |  40 +--
 arch/x86/kvm/x86.c                    |  24 +-
 arch/x86/kvm/x86.h                    |   4 -
 include/linux/srcu.h                  |  14 +
 10 files changed, 105 insertions(+), 702 deletions(-)

