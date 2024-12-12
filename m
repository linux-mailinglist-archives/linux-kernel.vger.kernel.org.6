Return-Path: <linux-kernel+bounces-443927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBC99EFDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB1E188D419
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11E1C9B97;
	Thu, 12 Dec 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="N3V2wTpN"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C4174EF0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037022; cv=none; b=sIeLBKcxbP3mAUxPC9PqtLIR33QmRI/baNHdoHoLE8Ze5JK4546+I0N3yNEw3HbjPUMzO/H5ojjsKb8ec+lwzxfFWGi/ok3BsVUj6rxpMPBBNqX6Rap4pbdX0MuGs0LxcD0Bq84Mg6Utd7GypZJUDmNzFyadvdT41vsbbpLdeuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037022; c=relaxed/simple;
	bh=OOwZCUb+iP3kBmv9zRpt0uMTiqTyzgTaYygvmgcQ7CU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PrqRFe6mDIrn1AA7fZqAIrWiXqy2f6UE67YRoMO9NvIDfsvOT58QMIYT4lFFOtqjCtopC3LoF2BefG1muCFN3L5SKFdnHNnkQG0F5fqLPcukAd7vjSvHQUyYy3JEv2TTKYHXmHF27vxwqPzg5lFB2er2Rt7BirJCGvfZieQQegY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=N3V2wTpN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21680814d42so9694395ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734037018; x=1734641818; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tN0Np0I/Y4AvFV8aJjEc8kjQ4MihsgPm5ajnYSHONIQ=;
        b=N3V2wTpNs+XSHNF9t34zBhvFL5jHoyelGlhjxQ+aFxhlyPBQ8EDlooUdhNpDuMJIER
         VdOyyAnRzUiuwSLBLzEm8rkGwf4Lue/yJRAFrpM7KHY/j4sHmfxcnFTx6BuefphjY+jA
         NSfXAmRPCFZB0vZJHdqeewQnDHJn6UYZKbQKgbL2JABuDGjcRt50cJCKhKdS9rUqC9k7
         WLfCELhMrdvMUUhAylxcN5Z5z+TBcLQcWwZzrsfjGRZiMYpPQkezqW2cqW7yyQrd6Hoa
         3sW/YP/3eN8LAy5R+83NNGQQXVFw8k9RE9bZm+XDIyk/zaWoj4T3Aru2jgwRZPmugnQA
         DewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734037018; x=1734641818;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tN0Np0I/Y4AvFV8aJjEc8kjQ4MihsgPm5ajnYSHONIQ=;
        b=vaDvq6MGmeOvPc7EeD0h78SdLS9Us1H6H2fmrSQCLUrwPXLT1rF8FruG7WzNQRH4Lj
         6BdazEWsd7cctVxNlraBFhGKxuedP4ri9nv3qsBAahj6G07Jui25LctT+D0yeVqSVHVA
         RmxT+HkdtZrsGPGbIbnp8/zqpXuRKzsLwZd5WJr9isTLSjXXQ0mXg4DSoc9GUzUd6AB3
         LEirD8uLXE6jxXSRkR67YjjQ4LZuHx5O0Dz5yuiJehL10qC73yDTDiKddbdfR77tV70Q
         XpE0CRczxIXO2GaXWOXb0eQfAChCDza2O4LouVa3ZLdALOMgQ2kcenkGU1uQweeIcOQi
         6i1A==
X-Forwarded-Encrypted: i=1; AJvYcCU1hQER8vyKFCulqR6Z7MvFBNNZi5AaUEQVLbLNyfa9+1hFVaYgzT3FYR2NsC+yXJJYC8eU3a79Jcsus3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEb22OnQfPcBVLnxp0rUox1lrUTKhRsKrAptKiv92fVG0TRQQ
	beQ133YBwzqz1Uy6t9KUL2VMf56OTFETs07mYT9fSErtb0ja7V8qRQsvyOD/BzA=
X-Gm-Gg: ASbGnctvSGuWBihYGwf1OwqYkvU4ojC5OtW2ZgsA9wOrohEfhBsfwPRC618UoCKc3rJ
	B7BUt6eIxQU0mYin/gOqTdK9eO8EKqA9oVi3ifSzNF5fRBYJxB3oMevpqdezECjKhnk9BDf1zwE
	xsbxWTq4Ebt/JjXMbavoYJBmydoAXDPAdQo0j0GNWeARnhRspBZAhdoiC4ez4DU/90JNW59zFxZ
	HfVdY88kBAlYmP4wABAqrzFdumSvgEEaATDX5PSEJbrojiA8JUbs480V+wURl6i68JBKg==
X-Google-Smtp-Source: AGHT+IEXAiBGQzLsJG95dn4oVog9wDVG/U9w68CWre1GKqNIKH0u3bVdjPlSX71Hw1mqCrUyOUt07Q==
X-Received: by 2002:a17:903:22c7:b0:212:67a5:ab2d with SMTP id d9443c01a7336-21892a3fdf8mr2207705ad.44.1734037018404;
        Thu, 12 Dec 2024 12:56:58 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162e53798asm94019785ad.60.2024.12.12.12.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:56:58 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH 0/3] Collect guest/host statistics during the redirected
 traps
Date: Thu, 12 Dec 2024 12:56:53 -0800
Message-Id: <20241212-kvm_guest_stat-v1-0-d1a6d0c862d5@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABVOW2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Mj3eyy3Pj00tTikvjiksQS3aRkEzNLMzPTJBNDAyWgpoKi1LTMCrC
 B0bG1tQDWHDJDYAAAAA==
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>, Quan Zhou <zhouquan@iscas.ac.cn>
X-Mailer: b4 0.15-dev-13183

As discussed in the patch[1], this series adds the host statistics for
traps that are redirected to the guest. Since there are 1-1 mapping for
firmware counters as well, this series enables those so that the guest
can collect information about these exits via perf if required.

I have included the patch[1] as well in this series as it has not been
applied and there will be likely conflicts while merging both.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Atish Patra (2):
      RISC-V: KVM: Update firmware counters for various events
      RISC-V: KVM: Add new exit statstics for redirected traps

Quan Zhou (1):
      RISC-V: KVM: Redirect instruction access fault trap to guest

 arch/riscv/include/asm/kvm_host.h |  5 +++++
 arch/riscv/kvm/vcpu.c             |  7 ++++++-
 arch/riscv/kvm/vcpu_exit.c        | 37 +++++++++++++++++++++++++++++++++----
 3 files changed, 44 insertions(+), 5 deletions(-)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241212-kvm_guest_stat-bc469665b410
--
Regards,
Atish patra


