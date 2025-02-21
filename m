Return-Path: <linux-kernel+bounces-525957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832D7A3F7D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A6F3BEE36
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDC821127E;
	Fri, 21 Feb 2025 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="G7VorVNA"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1720FAB4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149843; cv=none; b=WRrsNZDUsk/avYVb3H7VAoX1jAN0ALxBrf/BU3YxBRbxkrQ5jCUKkDrEvvFTjKEXzzhzUc9QgTQjO/O4IeaXQSMBXpd/IInSG57rYZmnNsno+pZcUQqZZPzpijq5L1oBN58pYMJMZV5nZcEzjULwp3kbqb0eAvEZuLJaodjPktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149843; c=relaxed/simple;
	bh=/nZ4N4UtIwyjJxxgpgvskDKWmKNoiKDSeC2y794swWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aiOZ41npH5At4Av6jNgkom7IhlZo87tuTsheMhmoj43qNfFVGGRoB7d2p+HdVWkqT1tdTMl8O6Xv4SxoCl1S96bTyX2yCsaNbiimr21UL7PIl2J1tNd0jNELwn9S2gm12lUe6jZwSaME/39kv1mk7HiIoFHzJFVYHVW6WXTuHw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=G7VorVNA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f31f7732dso1452126f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740149840; x=1740754640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RoC2FL5as/gzDPsPktuw00do1BQmGVd/xU0hU5pjN2k=;
        b=G7VorVNAsYI2RmvYqLNXF58uXnglgOKipZvEI54hChytwwKpfLqkFVUfL3JfU9veA7
         EaYr+/U1+TDY4vXmu6VocThgXAhQbGXByeLASel33nOruy2myo2usdw4VDsq3hYmKcfV
         +n/OhIV61jbHWz40EFMzyS9s7jgHUEN4CuYgpTVmxlfhQhfnktHIYeBdjKmHCz6K/sDX
         Kx/wU/Lh27AkFseIYh3vOHEa06h+dIYG4Ug2wvrsxOMwY/oCMfKuPVWBwjZq1wbu21Md
         3D39z3byuIyoXU40WW9PNmEKZiXRTpJGYvOQiah/8EH1kzjARHeWws2RyWdn0b5qnb1l
         NDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149840; x=1740754640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoC2FL5as/gzDPsPktuw00do1BQmGVd/xU0hU5pjN2k=;
        b=sY4Ruv1DUjGuoxcyUmB3UqdZZnPgoWSrt1XBbkhB352gqeHWT0DhJDw0crSThmXVGs
         lT/JfCFnfWHRtXCs0LNPPYB5mAvI5PmHFVFw3fXDepX1nUr55Rn5lNOTNqUKl5b6j3YO
         7UjLT38F9f3bb/u5jhS+rkYrjI7WnX2DJJ+/Z8rWZcIRcCWhe/5i8RbvA8RfXDdx/iD5
         KdtRURzp1Mm8LHf79uFBaKoqgIp2z/7A5V8cIQfoTp+IXInm6PEfq2rxRh0EqynA+pFg
         UEKNl3xJ9CimHLE5UZcKBSxYIKZ5LokFnqlVJKJNvE32/SvpqwogJdJz7wMIaHS/dvF/
         6XHA==
X-Forwarded-Encrypted: i=1; AJvYcCVgcwos5VQp6PQX0qZ1VQ636mbzH/6igJ7zL5vHi/bVOsuybH/g2RMT6V8/YrS61P2nsuyDAjpMC3KTBtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+Qx5YUveG6DZCWV3GNqleW0QKJCIeboct0KwTWnfhpAhkAwH
	DnVXl5rgySXL/tIrE1mPtzLoBXdQzDyiXae8clhOCnVIzFXhFzmiws/7WCUKq68=
X-Gm-Gg: ASbGncuSo92sD2tB4sYIHaXdyHxPzuq65euLwsWENckKM1ETIDg552usDafib6zJuTq
	YBJi6irtNh2694n8Z9yrJymh0EdCTCaQNONlBapVGkHwv3uK69BFRKLQeE/gFbE5yq5jZoN5h1B
	HsFDzC/mi/qNowog/dRIsVqQTW+dcEyw4Gbjt/l9qxzmZ69Hen2lgeToRBzDKRgxsesmER8vs50
	60PrgaZSYs+cRBvuMeaS7U1rVMO2T8OcWwnhai4dFIFR7RAo8mQ0OiVanvhIEVr8JSIPSxd+9V3
	9vGzEr2It/2s3A==
X-Google-Smtp-Source: AGHT+IG5zeZfNQajaoHNUMrIzD97HRkcbEBCj3VNxO98/Xx2UMd8yWsZFWsFod/9hBsiiQ/8Th2zug==
X-Received: by 2002:a05:6000:2ac:b0:38f:221c:2c8e with SMTP id ffacd0b85a97d-38f6f3c506fmr3115700f8f.6.1740149839671;
        Fri, 21 Feb 2025 06:57:19 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258fc7ecsm23332438f8f.49.2025.02.21.06.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:57:19 -0800 (PST)
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
Subject: [PATCH v2 0/8] riscv: Unaligned access speed probing fixes and skipping
Date: Fri, 21 Feb 2025 15:57:19 +0100
Message-ID: <20250221145718.115076-10-ajones@ventanamicro.com>
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
 arch/riscv/kernel/unaligned_access_speed.c    | 212 +++++++++++-------
 4 files changed, 154 insertions(+), 92 deletions(-)

-- 
2.48.1


