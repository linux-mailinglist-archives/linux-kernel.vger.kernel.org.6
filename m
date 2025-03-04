Return-Path: <linux-kernel+bounces-544090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473D5A4DD4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0565D7A26BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8C82010E3;
	Tue,  4 Mar 2025 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Iau2oren"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B01FC0ED
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089619; cv=none; b=Fm9FUCcsKayYAGlxPGqWV7uco9C/r3WzvLpAfB68imjKkE+DSNTuESZb4qDDRma2/dE6G1Q+BSWVfdinGD4hj8FgDdiUB/sUbDeUgab3HzvqUyut26xsGi6zerQhKit8Xh9qE8B99aD0F2qKG5kWXN+J57ODt7XznaEblL3pK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089619; c=relaxed/simple;
	bh=lAYc3uG4ODtfGd5Uci1oNMxfRTh4DPCMHXRMjqJre6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NAiPuX6DEmJ1zkUGYepBBcFK5UIW1BKssOpR/zPBEm7g30peXp1ogzB092uyf5eWW40cmKotvPDoRw0cwsRwz5yFKFZgIYjsydUuJBWlw36hNga5EN6WzEvY+qHCRFO6jX8aGU18OJxr9cjJCIQY0ALyiomaULpNY3eXNYQPgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Iau2oren; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bcc85ba13so4383575e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741089616; x=1741694416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NB210ZztxQ2LtczNET1K44yOz6rQJqr3jB3V+b0mE4A=;
        b=Iau2oren3rnWy6jgmlRdEOhf6gWcweP21qbGPrfuDkJjP8NtfxesQKzli57/YUBEt3
         WGiHR62Lo6kaIrxuz0f/WQEU3qDW/JpY5ASXtXLLEUEO1Pu/3vhOwXyE44SoKHHg/1Gi
         UJ+WSfMktJr3xTguVqqUlDUvfPoODNQujGX7quc+5RnYuuEFXkNBHk+b09twHC6R6W7/
         E083pXjIrWzO7OWy6rdF8EpmyAceXSYRdB86K+iOqgRjCkAbbaJcFZhqeqRkmJ1/3SFR
         uaN96/0fnQAaeu3m8+XXk2ZWQFB4Kcq0Zjc6FUQ25z2tklxAUVLABn2TA2rUVZXdlqHO
         6fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089616; x=1741694416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NB210ZztxQ2LtczNET1K44yOz6rQJqr3jB3V+b0mE4A=;
        b=H6Twy8mvbGJZlWbdNo/fDiDxMUDKIHWKG8sKL0vO/wUmfWGCwNKKp/wCHDp6/0fzZl
         tRo9MXLzgJDk+9IpBxKSvt7JCUfbRy9p13fOkDtvhQlPIkBpSztUHBy/9mZ7d3e03Gvi
         xcpHYVdswBHPSwqFRCqui1c78QPnH1Op6AvYmASFawsXze05Nd8j49C8sNBW5A/GTgUb
         WFbYQLSLBnFxora/S5GoHSTfSL29X2h5J4so2nI8Or6ETrD0uKERQLjDZpmDaXtj8MWm
         JX+U44wsc+H8ZNyZ6X0dKEQQPMOHBGoiqf5ImMJmwWvuHo1BW1EvWiSW+wxVhGCftvZ9
         1fOw==
X-Forwarded-Encrypted: i=1; AJvYcCVTilC0AANc78sK09khudkV9B6W5B+wZDColkMLWX9NqWR4v8fAIBxcYiOydE/wug9Xj64FoemXnA4gFXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUoZlVb9E1uk5O176VkLFYFOKiYqrrjxyNL1gYDeAvqadLikGx
	wyMqM/Fk5YPXkcdQgBBekfQd7pEqgCHBhUI9JvCOnLWW9RfJO2hvP5f+DhiIxrs=
X-Gm-Gg: ASbGncv9xNs7ExrV2MKblOCOaMo1x1RGxUQv7Bzi1zhu8Ztv7AqPSUlu8e3jkYZQ00U
	8C9IAWARRA0JuKCUMA3XOSjwIVmUrBrQMve6aOvXwJq8IJD/vnGnnT+CgHWlSBgQ+3m2ARRh5uh
	J5aYgWIF5nvzLSJRg9J0f2ADK7A8ThlT3iivzHYt11F3PVbCXMQoKdS+61720naiMKssWWRd0c2
	iuCYOPYGJIJKojT9hjnZGiHHIA2dFXo95+5ziWXXOm0v0NWhxwRcPic5e1u1aV0WVTp3y5IPx7t
	eyKos77WgW2pVXz65SFaG994NrYv2lz3
X-Google-Smtp-Source: AGHT+IE28Ld4ZbsEY6m2165jne/c4f8G51MRYc/QAM+rC+BPf+C5KmQYo2vTrDADjsSOJ3h4TGPaEw==
X-Received: by 2002:a05:600c:4f95:b0:43b:cf9c:6ffc with SMTP id 5b1f17b1804b1-43bcf9c7b45mr3677925e9.12.1741089615752;
        Tue, 04 Mar 2025 04:00:15 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b737043aasm192879455e9.14.2025.03.04.04.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:00:15 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	alex@ghiti.fr,
	Anup Patel <apatel@ventanamicro.com>,
	corbet@lwn.net
Subject: [PATCH v3 0/8] riscv: Unaligned access speed probing fixes and skipping
Date: Tue,  4 Mar 2025 13:00:15 +0100
Message-ID: <20250304120014.143628-10-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first six patches of this series are fixes and cleanups of the
unaligned access speed probing code. The next patch introduces a
kernel command line option that allows the probing to be skipped.
This command line option is a different approach than Jesse's [1].
[1] takes a cpu-list for a particular speed, supporting heterogeneous
platforms. With this approach, the kernel command line should only
be used for homogeneous platforms. [1] also only allowed 'fast' and
'slow' to be selected. This parameter also supports 'unsupported',
which could be useful for testing code paths gated on that. The final
patch adds the documentation.

(I'd be happy to split the fixes from the new skip support if we want to
discuss the skip support independently, but I want to base on the fixes
and I'm not sure if patchwork supports Based-on: $MESSAGE_ID/$LORE_URL
or not at the moment, so I'm just posting together for now in order to
be able to check for my patchwork green lights!)

[1] https://lore.kernel.org/linux-riscv/20240805173816.3722002-1-jesse@rivosinc.com/

Thanks,
drew

---
v3:
 - Fix compile when RISCV_PROBE_UNALIGNED_ACCESS is not selected

v2:
 - Change to command line option from table


Andrew Jones (8):
  riscv: Annotate unaligned access init functions
  riscv: Fix riscv_online_cpu_vec
  riscv: Fix check_unaligned_access_all_cpus
  riscv: Change check_unaligned_access_speed_all_cpus to void
  riscv: Fix set up of cpu hotplug callbacks
  riscv: Fix set up of vector cpu hotplug callback
  riscv: Add parameter for skipping access speed tests
  Documentation/kernel-parameters: Add riscv unaligned speed parameters

 .../admin-guide/kernel-parameters.txt         |  16 ++
 arch/riscv/include/asm/cpufeature.h           |   4 +-
 arch/riscv/kernel/traps_misaligned.c          |  14 +-
 arch/riscv/kernel/unaligned_access_speed.c    | 237 +++++++++++-------
 4 files changed, 168 insertions(+), 103 deletions(-)

-- 
2.48.1


