Return-Path: <linux-kernel+bounces-286280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EE895190B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936C6B2250D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0132A1AE85E;
	Wed, 14 Aug 2024 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjzMX2gm"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DDA3D552;
	Wed, 14 Aug 2024 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631799; cv=none; b=TLgJyZR3gJqOR6nQRQRaBr28WfW0lw+UAtj1ea9FV+wHCmBcAmzL1Jinq1Mys/rUqPTACKV+rs0XLeyDOk+GID84K1uNPzD7AfQeqN8Y0D0OeMkoQAmCkrZ5KMPoSF+9Cib79em59+X8zEdOgPWiGetpBCCxCYuz3Xrv7xTggLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631799; c=relaxed/simple;
	bh=pD1qICRTfQfBXyMHWfEjwsThkEYKZjAlRwhKA1VfgEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SK2azCLXjawXtUx2kdRMQ1gXREh8f7HjDV9uJjOaCAtMzPMMjaomxfJ8WNsxItALcDYcu31+LCr/tsAOsxXpZbBmkrcLnecgxN22fukYDO3iZCfVXJgwDt0HbRTiag+0W3i4PId8khHSkwgRH4minCnbOHxgaxQUPF3zYFzro/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjzMX2gm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d28023accso5189139b3a.0;
        Wed, 14 Aug 2024 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723631797; x=1724236597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0h+7UnaE/DLI0nJCpVlTNs/3jRtkis6/GXWtA6PfOY=;
        b=mjzMX2gmrS45fbxRLP2CsualumeNaRkSFBGzAc31xttljAtLO95ZP0P+s4DCv5KLXS
         GvWkYhpyG1enxSp7qrtOnikcobWCA7RN1c3fePBSmcehlz7yilkZepLLyH7eF8jHmnCl
         heq3Aco+89YAYafIMvwbejW9h8dq8XTD9HqVbszkDIf1X2+ByWHhT8+X7eFSQEqkoNXP
         ZEs0+ExIfRUA12SQ0r/m/cQCPnmpjSwKaOvZe3O1+1J97CYsAYV4VzDLDhkL2wAewuE0
         w18giT3XIYVK9Yvnc8XAT4QGoZruNRHKHe3nfiKF0vA74cPHI1aq3UypYOLIM+1a2A94
         0wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631797; x=1724236597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0h+7UnaE/DLI0nJCpVlTNs/3jRtkis6/GXWtA6PfOY=;
        b=WF0tiz8xEo+TZkQTdO/I+pomo3cutCm2Ekt7CfOcVjIaKLwPQQJ20E6R49O6uRq5Mt
         PkXIGOkH2g/GRpniCTlPj9wwmROguDPAhT3QYGr7v6qmEr/4nyUOtKJdFN81F6QZo+gL
         hsG9aIUw3O5KisPOMj5L30x+3YQntDdg2VCYEb2eIpBO5BkGlCVgpwXUkWEKJlHkIUwF
         pJroG/06cGEJUvnxMqXo1DixS53duoQgfBAMDUokMRhl55l46d5DRV1+zg0SeVxPvVfe
         aryAh1ug3aUdtACh0H5I+UWsIWO3vYE6sq78A1aphAO+OYP3fh6/6crBg80B9yAAOQfA
         PEpQ==
X-Gm-Message-State: AOJu0YwXhFu0egksqzzLFlLy9tIqYNj+LfLBruSa2sXLJ/q8FA0gn4zN
	NFYdtFhmz2i2A9uxNCvFlSG6ikF4gfV+4mxUb0gzqzocuyNaSm7Xqygo1WhbWMo=
X-Google-Smtp-Source: AGHT+IE30yDPQkUZHYG1aHmEdXElVvOkuLkl7uSUJRc2YaIFPPcWe157IZb5zsqv/SFK0l2nEBeHFA==
X-Received: by 2002:a05:6a21:398:b0:1c4:dfa7:d3ce with SMTP id adf61e73a8af0-1c8eae6f521mr3264316637.17.1723631796524;
        Wed, 14 Aug 2024 03:36:36 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201cd1bba6bsm27159465ad.225.2024.08.14.03.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:36:35 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH] LKMP(Bug fixing fall 2024): Fix documentation spelling errors
Date: Wed, 14 Aug 2024 16:06:18 +0530
Message-ID: <20240814103620.8912-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit we correct some simple spelling mistakes
in the Documentation/arch directory.

1) "Assitance" to "Assistance"
2) "parant" to "parent"

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 Documentation/arch/powerpc/ultravisor.rst | 2 +-
 Documentation/arch/riscv/vector.rst       | 2 +-
 Documentation/arch/x86/cpuinfo.rst        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/powerpc/ultravisor.rst b/Documentation/arch/powerpc/ultravisor.rst
index ba6b1bf1c..6d0407b2f 100644
--- a/Documentation/arch/powerpc/ultravisor.rst
+++ b/Documentation/arch/powerpc/ultravisor.rst
@@ -134,7 +134,7 @@ Hardware
 
       * PTCR and partition table entries (partition table is in secure
         memory). An attempt to write to PTCR will cause a Hypervisor
-        Emulation Assitance interrupt.
+        Emulation Assistance interrupt.
 
       * LDBAR (LD Base Address Register) and IMC (In-Memory Collection)
         non-architected registers. An attempt to write to them will cause a
diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
index 75dd88a62..e4a28def3 100644
--- a/Documentation/arch/riscv/vector.rst
+++ b/Documentation/arch/riscv/vector.rst
@@ -15,7 +15,7 @@ status for the use of Vector in userspace. The intended usage guideline for
 these interfaces is to give init systems a way to modify the availability of V
 for processes running under its domain. Calling these interfaces is not
 recommended in libraries routines because libraries should not override policies
-configured from the parant process. Also, users must noted that these interfaces
+configured from the parent process. Also, users must noted that these interfaces
 are not portable to non-Linux, nor non-RISC-V environments, so it is discourage
 to use in a portable code. To get the availability of V in an ELF program,
 please read :c:macro:`COMPAT_HWCAP_ISA_V` bit of :c:macro:`ELF_HWCAP` in the
diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
index 8895784d4..fd7999c4a 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -12,7 +12,7 @@ represents an ill-fated attempt from long time ago to put feature flags
 in an easy to find place for userspace.
 
 However, the amount of feature flags is growing by the CPU generation,
-leading to unparseable and unwieldy /proc/cpuinfo.
+leading to unparsable and unwieldy /proc/cpuinfo.
 
 What is more, those feature flags do not even need to be in that file
 because userspace doesn't care about them - glibc et al already use
-- 
2.43.0


