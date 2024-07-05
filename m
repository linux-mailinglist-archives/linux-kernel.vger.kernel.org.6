Return-Path: <linux-kernel+bounces-241955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC599281BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C3AB230B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA82014388D;
	Fri,  5 Jul 2024 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yoI0vWtd"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA82132103
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159812; cv=none; b=Tzccr/+6qqtaXgant7kvcjRANMjvr5DeNuuogEMG4keLDITfgV6Qs0Oc3a0I7BIhu3pMJhO+UNsYandzB6eVSZ+H6JUiAPp9/Io5oGapReileJG3KXR1dlFZm4XMnkHEvO56+JqDrgT8xAQpyT2hlOP3e0tat237PMivFTzEk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159812; c=relaxed/simple;
	bh=W+qamwsHuyOBrSd6E6yy7gGaZxUWsVukqdHyod550SY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cd52ReKOxaIBCCTDnUxk5uDDgCbTMmwyR4n1mfw7hYJHqY41cb5qn/78ZeSU/ek01QsgvHZ1hjTojYo7xSLnKws5wnxGztirRrh7I3E02lB9MZeYW5sPMR90zNVs82bMl3qpK66KexohQMSdch22KCjLMfFa9I2jLZuMD5rcaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yoI0vWtd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367ab50a07aso157533f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 23:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720159806; x=1720764606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOD2jtdAtfNII56GP5rqsRV5KAthLbsUXOQKU9980nY=;
        b=yoI0vWtdAf2AolvOLzrTOsWksWc2xC9H3Xn+mfrO3SP8SCFUz1Wt5hXkg4o8Assl3q
         vxbblN9rZ5iNxQDAG7De79y6AK21m3ee+DcnbMMLd8cV2kJpjEy+6o6AGusRzgEX5qDB
         gPXHpPLgtzpfXY52/TenmkEO1kOiT/N0E1LDWjQ2QTs97A9WadavhKtqrmv0Avgpfobv
         VK+wrf6//dgvTagN4vDm1aOJWjwm9aUHJQQfwjiYDFNtHpjyXymP/pMkB10WleQbYCk6
         Kx/wsQK+JAa1CgqGqOaewLbOQB6cc+SWq3H1PtUEHw9qp+p9029PWi4MxTZpBgw2O3L8
         Llbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720159806; x=1720764606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOD2jtdAtfNII56GP5rqsRV5KAthLbsUXOQKU9980nY=;
        b=RoyrUB/u7CdIw5scob/6tRW5OMVs0854//1taUoV3LjtfSVD5NWg3op7CYlycmUccZ
         y8PxBlUkt8mtjJOQmqOO8NKx70oXkirEriqHdF12zNBn5GXO81K5XJhq7rlc0KUJtsKw
         0fPefn+IQkYyGodLmM3SmSPcVIPYK+vrEJS3mh2v6dqJfFI7sf6bkYRu0Ws9J0OxT67v
         cXx89P//WxOw3ESeVzPP9xhaASPCLH01SOcjh747SCO+wCH7YbIgsMW04VV+mRxu+L5Z
         i/zS4SFFSC4LlWjODulV9l8pE/dKutbJWyJtC6HsofYHkxfrn8KcaDcU979YUKy2EQxt
         oBhw==
X-Forwarded-Encrypted: i=1; AJvYcCVRV4xoscLCuswGQ+a4TEhJiOeDNdtWOzhUdFnFxWAGMcSK4z0P49xMPYPkHc/6/+adeDCX5gcfZ1CyMlTMTTROf0LTI1kRc4sgBhwj
X-Gm-Message-State: AOJu0Yzh/RxCcpPJIRLwDBH0VG9hSW66Vvsb6c2bncacfbY3WjcJzL9O
	jItt+Y/nL4PKIHyQtZhsP21A4V1GnPHF4N4+AhLSjvX1WlZ76NCe9C0Wq2vMmgk=
X-Google-Smtp-Source: AGHT+IGSC+YguDLIlW5OOjetUrmmUspzykknqUgbL5edv3k5thftEFlmWv4eaRYhBjzCWN1bS4fzfQ==
X-Received: by 2002:a5d:410b:0:b0:367:89a7:da5e with SMTP id ffacd0b85a97d-3679dd2997amr2862491f8f.19.1720159806299;
        Thu, 04 Jul 2024 23:10:06 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a40a6d4bsm1709446f8f.51.2024.07.04.23.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:10:05 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Vladimir Isaev <vladimir.isaev@syntacore.com>,
	Roman Artemev <roman.artemev@syntacore.com>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 1/2] riscv: vdso: Prevent gcc from inserting calls to memset()
Date: Fri,  5 Jul 2024 08:09:01 +0200
Message-Id: <20240705060902.113294-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705060902.113294-1-alexghiti@rivosinc.com>
References: <20240705060902.113294-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gcc is smart enough to insert a call to memset() in
riscv_vdso_get_cpus(), which generates a dynamic relocation.

So prevent gcc from doing that by using the
-fno-tree-loop-distribute-patterns option.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index f7ef8ad9b550..c7e40bf36371 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -18,6 +18,7 @@ obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += -fno-tree-loop-distribute-patterns
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
-- 
2.39.2


