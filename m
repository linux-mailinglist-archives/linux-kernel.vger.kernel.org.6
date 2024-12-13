Return-Path: <linux-kernel+bounces-445176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0379F1256
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CF2188C17A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AD117A597;
	Fri, 13 Dec 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vkCS8yNk"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A315815573A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107786; cv=none; b=lXHXAMCNKylw0r0BfObcfiTzDx1QHkB04KSa/hgOtoB21aKsqkTR5X6UvGpp07cyCEa8qjFI7iRVLY0OBnGw3Zcl+Tbqn8RiidsHcxcUnFe5RAxAcw67dUoH2vBmM4utnTJrCmvJsioP0LEyYpZhUQrsaJlOqcYk8XFk/iTEQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107786; c=relaxed/simple;
	bh=fiWLHn1Vh7Rkee2vngeT6U/jlOV99M3VJ9PlRs+HJtQ=;
	h=Date:Subject:CC:From:To:Message-ID; b=FKbBFsJncjY+yUZpz/zM70KtyDd2KAPRrNgymjvT6TCEZkiJFauNWec/aK3RgLx3yxOa0AUXdqgj2BkshAu3/brstPRMigXixL+Ek5IycJMh1xBEdSVe5yVGa/QmJW9XErjnXUNe37iqpQ9+n6MexCV+nTUfRVL7Uqpis8cXXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vkCS8yNk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21680814d42so17526565ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734107783; x=1734712583; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVTI6igU8T6dL4skxylHch7ZipanOhb4/E7t8iY1Njw=;
        b=vkCS8yNkUH6746hozdsUZP0+dYLXtm4PLRVRdxfsO1NckZbz4nXBOY1LX9+te+1wj0
         IanRLsh7vs95YmK88ztT3wgAKwn7y8kpsANv/J+4xisvrvF3T+jFzH3dsfHKs2/wSEjs
         ENNtmQ8jkNwktjpoTa44bbONhyTM9wG4jpmyOCjbHGpwjbaazQjvQrU+lmyRSs2KEMxF
         vS66Ul5u1WlqmO6TA/VIMkWNs2RsyUGxDyDAYeCDe6Saj+Sn+vWbszhc9aFtBAWgWmX8
         aZBVf9akIvfCeUSxA3XWE0NdK8L03br6+qCb9ly8QLH0yqCwcXq48HAscwsGEXgtLGl7
         ez2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734107783; x=1734712583;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVTI6igU8T6dL4skxylHch7ZipanOhb4/E7t8iY1Njw=;
        b=BkbooupZbCf+6cvlnWBNwrZ4ROsAT4I2NRmf1mgSz1h58j2wejgbrSckJIqH6kO9FY
         mk3niA5ZxkEJCdIAiy6w3aG9zVSTS3jBKhJ+qI9nc+InX1igg22Sqcp5eG/jx23/A1e4
         u21M1vHoe2ocDwJVQNrU56l3iKB32/+I0K9tDl47XCAVko3wRHl2tne1Rg1H0poQQKho
         MfSThVkcEHCClbsxx0cXQKX7t6lIAlXN0kebEk7QVIQB2lJMJve+5WaQEeOxOh3Zon7e
         sN/HTLyhFT+Hmtyy4PpCs5cKZLXgp3V9QsAhiT+ISa/bPLZz2fnc4VRrZno31GuUSOdK
         28ug==
X-Forwarded-Encrypted: i=1; AJvYcCXytcT7qyNuaf2hkWsaqV7JUppGSjbzHOome3xNAVEQf2kEHEXlGJaHJ13vMtW9nIo9p63TPDbo0WkT0Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKIk0XOBWGL9wuZgzJsa+40FBQfCwd8Vb5QTS5A4NrLmnR45Z
	8Dz2e2edYhYz4nbkfwO1O2wgQGi4BmIU4VdAnR2+29mNSjtJfVyppzcMa69MQ3Mj8kl3UZve36M
	F
X-Gm-Gg: ASbGncvbgWgKSWBt9LGpAuk6oWYiFKDM5ngbjKi8m80we3PhIhU4ISR3AaDkvTFeINV
	m27hIez7+diEiGIvtbbCLJZFeQB69IUj3OVI8yXxwYF7qjqZ7zYKcHrvyGlNKlgv0L5kyGVA0oX
	NRFjzrM1bEBdaEpN5FBWXAeiGhlNFITJOfzzgAXH4WYmC9ESXzhymFmFnKK+0APTppC9upUnqj5
	YAIrLn4kVxTCFS03u2KFTQUus+/etnmy3LdM4GqMhcVIi8gOWo+ewc=
X-Google-Smtp-Source: AGHT+IHgrhZcyZQ6XsrxmSLV9cBdFXpMwXfCONCTz19YmGg/T3D8dGAPOzolX4aFTm6Bcmc0raKirA==
X-Received: by 2002:a17:902:d4c8:b0:211:8404:a957 with SMTP id d9443c01a7336-21892a3fc7fmr48954265ad.41.1734107782899;
        Fri, 13 Dec 2024 08:36:22 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21634f24f78sm103353275ad.32.2024.12.13.08.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 08:36:22 -0800 (PST)
Date: Fri, 13 Dec 2024 08:36:22 -0800 (PST)
X-Google-Original-Date: Fri, 13 Dec 2024 08:36:04 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 6.13-rc3
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-d041d4cd-3e9f-4533-ac26-e0d67be93496@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.13-rc3

for you to fetch changes up to 21f1b85c8912262adf51707e63614a114425eb10:

  riscv: mm: Do not call pmd dtor on vmemmap page table teardown (2024-12-11 11:44:21 -0800)

----------------------------------------------------------------
RISC-V Fixes for 6.13-rc3

* A fix to avoid taking a mutex while resolving jump_labels in the mutex
  implementation.
* A fix to avoid trying to resolve the early boot DT pointer via the
  linear map.
* A fix to avoid trying to IPI kfence TLB flushes, as kfence might flush
  with IRQs disabled.
* A fix to avoid calling PMD destructors on PMDs that were never
  constructed.

----------------------------------------------------------------
Alexandre Ghiti (2):
      riscv: Fix wrong usage of __pa() on a fixmap address
      riscv: Fix IPIs usage in kfence_protect_page()

Björn Töpel (1):
      riscv: mm: Do not call pmd dtor on vmemmap page table teardown

Guo Ren (1):
      riscv: Fixup boot failure when CONFIG_DEBUG_RT_MUTEXES=y

 arch/riscv/include/asm/kfence.h |  4 +++-
 arch/riscv/kernel/jump_label.c  | 12 +++++++++---
 arch/riscv/kernel/setup.c       |  2 +-
 arch/riscv/mm/init.c            |  7 ++++---
 4 files changed, 17 insertions(+), 8 deletions(-)

