Return-Path: <linux-kernel+bounces-176308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926B58C2DB7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 01:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC63BB242E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14FB17A938;
	Fri, 10 May 2024 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bkce7VLF"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFE179206
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715385066; cv=none; b=haIeUlx+TNI+67FZXLxaNxy9uPMWVZDQd5M8Gh/kwDtt7Dg/B69NNgRDjJ3mobacKkm/XwbRu/kOIe5K2cfjkiMR/scGcze1TL4TQZINn75wZ4E0J1GJsMIwZCw47zQMssKDydNz2dwVCpapTHBtKbRdeEaUFFWxl+p+6/bh2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715385066; c=relaxed/simple;
	bh=ZlffHLYLW2tKey64BAi+uDrFxzH6O45Ynpm+ndlWyW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c2X7ab7YYuAO1ZnWy9lZVEQLo/ItoahWTuU+zSVYHvt5ZBkhWF9UELsVRcYvHQu+G1AaD6WvaVEez8/TOSSEJDdCsj294ZVFhCx3tPzWBv42ouoaxYj2xjPEv316g3vqF2lhAnAEwrIe/B3VBw34m79o/vYpowMg3FpjiEZyjHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bkce7VLF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a473ba0632so2357007a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715385064; x=1715989864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+oxS+OE/YCIQOoW32vIVdH9ODHELlY8/x8l7G2xYxLk=;
        b=Bkce7VLFptAAjRDgl6JGndcB8omALDmqk212F+Mg1jtz9S5VdxcGdxKajZ3B31yMB5
         k0Zz/zbAlZBWD5BSQ/zfcZoS659Nx0ByCRjJIukHOx34YRLs2ouo9ZKVsONgEMutvwiX
         KW6omvvUabEnfyOJeE38jqK7zbarm4+u2qyP61GrW/CdvGkRJXYg3QX26ZzQ5j1kAtnv
         LhAXGCPmppz/nqtzky23ESEm30XFEYb1Pyyeb1NzauN+14av7tIOWQa2r/1MsEujJew1
         UjJgtuVvaDC0haGJiOn8uFSeXaGB5MKlN9gKoTQHF3Qzx1e9RhaeIsJVV8YjPwu556QO
         f35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715385064; x=1715989864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oxS+OE/YCIQOoW32vIVdH9ODHELlY8/x8l7G2xYxLk=;
        b=VIq1sIjWA5nvqjs5wQ10kzq/Mqwj37Hhav+42A22xLYmE9IJPamz5PxR0bKvW34VXY
         pQOlgSpS0YAz6hVpuDTCWzwGAJHlklqMNAGHAiVgmTJ/qBiGej+Xt+wxHcdgN87LQiMo
         UEdJopgYroaZSbgRlWoN6P3Cphnqg27wKroZq1sFEzUHMY3n295W/ylCaNCSHmy6AC2s
         wuhLyPCEiBgKW+uHd9WVXkFkjkmXiGOY0GNiH/172XJGW5mEyI8k03hzj/+LZou1ZVJ4
         /R7tHpxbYCCgFHlMYJnymBHChNA8CI4J0LGO9kIen302s0QcRx3qI7DHfxDaXALA6sPe
         tOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv/8ZCaaHHlNs4+uHTi4H0C29eWqkFd7Q9pDjX7o0hpVnZ0JGTiO7M68Ni0Tw5JSIZcCh9YImWeD2wlCpb1i4V4rYIxSlepllKLVgz
X-Gm-Message-State: AOJu0YxoOKPugsgngqab2wpXrgrAFLaVwv9UCR8LOG4lRwYirbwd2hJE
	ojs96WpujMbKWGsgS39lw/0Cr3XqRvWrAaWIXKa0YWo52gnYsu1P4bbr9esqJDYlP2L8ErVNLl5
	ryA==
X-Google-Smtp-Source: AGHT+IEF86qaNaZhdbUdqAfO36CKBgwl6mZXf9q97ikcfkb+M0hzFfMoK0Ecqt4QjhWdh5g4c+0Pgj7tOSk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:fb4c:b0:1eb:7b9:4f7d with SMTP id
 d9443c01a7336-1ef44049833mr757285ad.11.1715385064140; Fri, 10 May 2024
 16:51:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 May 2024 16:50:48 -0700
In-Reply-To: <20240510235055.2811352-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510235055.2811352-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510235055.2811352-4-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: MMU changes for 6.10
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Tag says it all, though I feel the urge to have _something_ here.

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-6.10

for you to fetch changes up to 226d9b8f16883ca412ef8efbad6f3594587a8dab:

  KVM: x86/mmu: Fix a largely theoretical race in kvm_mmu_track_write() (2024-05-02 07:49:06 -0700)

----------------------------------------------------------------
KVM x86 MMU changes for 6.10:

 - Process TDP MMU SPTEs that are are zapped while holding mmu_lock for read
   after replacing REMOVED_SPTE with '0' and flushing remote TLBs, which allows
   vCPU tasks to repopulate the zapped region while the zapper finishes tearing
   down the old, defunct page tables.

 - Fix a longstanding, likely benign-in-practice race where KVM could fail to
   detect a write from kvm_mmu_track_write() to a shadowed GPTE if the GPTE is
   first page table being shadowed.

----------------------------------------------------------------
David Matlack (1):
      KVM: x86/mmu: Process atomically-zapped SPTEs after TLB flush

Sean Christopherson (1):
      KVM: x86/mmu: Fix a largely theoretical race in kvm_mmu_track_write()

 arch/x86/kvm/mmu/mmu.c     | 20 +++++++++++--
 arch/x86/kvm/mmu/tdp_mmu.c | 75 ++++++++++++++++++++++++++++++----------------
 2 files changed, 66 insertions(+), 29 deletions(-)

