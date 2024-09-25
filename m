Return-Path: <linux-kernel+bounces-339128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C383A98609C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E161C25DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F151BF58;
	Wed, 25 Sep 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="db4rKSUn"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B521BC59
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270160; cv=none; b=edwy3I7RNf2r5VMi02RWKkibcshvzmCoHeuwUD2O6UCY9a1A+pNuna39lVaZ6ar8qHD21RvaIkXv/jEooTRyNXDxiZix/3QzhfTQgc9D1hqlI5HKeJ2NnQAmR5UxGWAd50M9JZHj/CcYRMTzt/3HYF8xTqLE6a08dhM8m2F9RFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270160; c=relaxed/simple;
	bh=XtQ2DHqYCezkEBNmICScDopdL4rFO4eYyWpu9DkPHs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XE/i7JSos8xZZkLttes9tmJ+zeSdLz5qONNtYbxzy0Rj/FuuJ7rD4SS2pZD3pfhHX+F1xq6s/yQihaz/YlhyEafnriOnNV+JbQReIWPR/i0TTL4QidNzPUmCOY8iYFXUPbU69b/ApWZXQ+4ELzKP3UociumuipgJulMxeaIe+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=db4rKSUn; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e078d28fe9so341823a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727270158; x=1727874958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XUJTSwNM1e4VTN+bCMYDMDP5A3DfmVKg+wgt1x46TI4=;
        b=db4rKSUnl0iy6FYgZL0e714zI4X+LlUG2FikIN8cp3Pn3btcFPq6KKSlzJKXJanax6
         UL92aVlfbomQbLgPT5anqMV0T1nn/miyXCWbYS4qwOBk6BSJavS/y8+VYvI5HHLYOXvs
         UyI2cRZpxKRd3+/xNdPcsLu8hAhlsFS61+Y9d4BivjyCYPmNEODtHEvarW+pWgZyUs4a
         gf5KskITNLejDWG54BiSwgUdy/PeSGLr7CrvDdMaWhGU5FERFjwp2x2x0jM0CmS38ljW
         rzPwZ3d8vO3pWAdAekdtGE+Km9VLDHd77H72mhfHM83KG4BXES0cZonBtpDXFx5yTk1x
         zjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727270158; x=1727874958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUJTSwNM1e4VTN+bCMYDMDP5A3DfmVKg+wgt1x46TI4=;
        b=IsUBTmQ4Pd/AnWcsRz9dmUTf8vWe40mgpTPAyMH2m1kc73J77zTeLcXjYm1OEOMJ1f
         JX2fwcwMRszessUFuGYLwCAwJAai+L+XKGm+Y3IMcodWHQzQeLcnOxjzZgfpoFqcxNyj
         RO9r/vI5Cnf0WwWNZ/gL9u/B3QGh16yTwv/oFmTqoUxhmSMlUx761FoV8DdxYuoxJb+n
         LKm+Tg4Vh38rrKo0oDQtpF3YFsnJ3ayXAhegMwjKHnbLiMeatJWJN7mAX2A+q7eNURs6
         UKhWCAPLJ6zI/u4wsCKl3e2LjyjcswKw2XbZF+chkK1Uoh080b3Yh6WXGHoc81NH4Kj3
         cz8w==
X-Forwarded-Encrypted: i=1; AJvYcCWpHMQXxZObw5nJNdGamLlO8Ef8ib1DlonjTmtj5/ib41gFEe3+bJwA3BeIx4G0xvRFd1PxuXFNlssqWg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlf2dagAcxzJPsPxFZG2o85KNO+UKXpW6E1c4DIKFQMbMSohsF
	EAm/KRBFJhxwp6cHaQK5TA2EimVDUOt4anp8KahRhfaIE+M0HNRlmTFCUZCmWitQSWbSV84d6Pg
	v5co=
X-Google-Smtp-Source: AGHT+IGKQFKFIicIvwhIpG4qJ8M43Ad5bDM2eqKiY3aBm1kBagIZP/pVcceYSqLXQDDwD/rQiYLZWA==
X-Received: by 2002:a17:90a:6b06:b0:2d8:8d62:a0c with SMTP id 98e67ed59e1d1-2e06ae21751mr2920097a91.3.1727270157832;
        Wed, 25 Sep 2024 06:15:57 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1e09e2sm1479465a91.32.2024.09.25.06.15.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Sep 2024 06:15:57 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	andy.chiu@sifive.com,
	guoren@kernel.org,
	christoph.muellner@vrull.eu,
	ajones@ventanamicro.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lihangjing@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v3 0/2] riscv: Idle thread using Zawrs extension
Date: Wed, 25 Sep 2024 21:15:45 +0800
Message-Id: <20240925131547.42396-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the third version of idle thread based on Zawrs extension. We
noticed that Zawrs is supported in v6.11 now and rebased our code on
it. Below is the original description.

This patch series introduces a new implementation of idle thread using
Zawrs extension.

The Zawrs[0] extension introduces two new instructions named WRS.STO and
WRS.NTO in RISC-V. When software registers a reservation set using LR
instruction, a subsequent WRS.STO or WRS.NTO instruction will cause the
hart to stall in a low-power state until a store happens to the
reservation set or an interrupt becomes pending. The difference between
these two instructions is that WRS.STO will terminate stall after an
implementation-defined timeout while WRS.NTO won't.

This patch series implements idle thread using WRS.NTO instruction.
Besides, we found there is no need to send a real IPI to wake up an idle
CPU. Instead, we write IPI information to the reservation set of an idle
CPU to wake it up and let it handle IPI quickly, without going through
tranditional interrupt handling routine.

[0] https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc

Xu Lu (2):
  riscv: process: Introduce idle thread using Zawrs extension
  riscv: Use Zawrs to accelerate IPI to idle cpu

 arch/riscv/Kconfig                 |  10 +++
 arch/riscv/include/asm/cpuidle.h   |  11 +---
 arch/riscv/include/asm/processor.h |  32 +++++++++
 arch/riscv/include/asm/smp.h       |  14 ++++
 arch/riscv/kernel/cpu.c            |   5 ++
 arch/riscv/kernel/process.c        | 102 ++++++++++++++++++++++++++++-
 arch/riscv/kernel/smp.c            |  51 +++++++++++----
 7 files changed, 203 insertions(+), 22 deletions(-)

-- 
2.20.1


