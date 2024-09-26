Return-Path: <linux-kernel+bounces-340688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E4A9876A2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCAA1C245BB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9DB14D6F6;
	Thu, 26 Sep 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV6w3MP3"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647EB14F9EA
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365115; cv=none; b=MkJ4vUllPdzH91r7LU1IugVEPRDvhj7OHO0K6+MaWQscLkDbmopfhTd21r18x3tojRrhS6n+xzqiE9tg+uxqMTYvHe9UEu2/7H+lXn1VeV3SlgeQ79pbfxxdkO1ov/InZndjZP1X0WC5i1t5wSScKyWe5MGcTqaZDc0xb+Twhzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365115; c=relaxed/simple;
	bh=Eq5GJAJW9gWB2bjQPDklI/+0WFiJqbWGaaQKuerdUmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oZms2bULcQntvvwP+BIsQ8r8S7Ff4JCWVnJk79fOomOMl2jmkdu6EUAWL7FgoYLwe24kr1N0dhlYWMwI8tqDqEpHEscOirj/hsQrloZ1n2VlUzdYGFZqRolRBWIRUOE6stlOhGZiV1GALcR5DD2Q46RwZ0CIEWMgFJSkGa97HM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV6w3MP3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so740733a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727365114; x=1727969914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SnvXb2mLs82k43WPV3LtZkDr2LTLT42MIdJw+XKETCE=;
        b=bV6w3MP3NkQOkDqCIsewpqDRVCRT6D70kHuaayST80KL5FJXJBhfuKbDQbaw2prbQ0
         hz8uvIiWAugzhDcwEO2q0WfjmzYf5KuYu97SyPqCF72jIZeU3DQ2NqXkykohz0/IDXu3
         eGu9BaQR/87H3G2Z0CaxmgMjbR4VKwz2A3/qZytst/PqlnXQxHUEYQKipolvI75/TVwk
         BHqwXuag3VSxR4LDjTqBL0fB6tRI37ZujWncCMK9zhSnrzWVmy8SJ4EmCKW1wgZFJ2mB
         JNGlJ8QOz+IU3gZMmDbb7/zYANDSgU90RFhrynFB9zAWHgjx3gYHu5RKa3DyM09A/aov
         oUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365114; x=1727969914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnvXb2mLs82k43WPV3LtZkDr2LTLT42MIdJw+XKETCE=;
        b=Xu8sch6ivas6lsyeUqtGVVUOthF4I0SmwRTG3PDQMW5w0RGQoI4UIul1WU9C5BRITQ
         ecyeErjyTMV7yxjaUurS5h+kE0R8fcL0Fu01EjDmRQ9V3BUHKlbu2ZmisUpunrFYaOi5
         RaxrUvxbe7FGorJ56MUoLxxdtUQNS+u+AfrtYqgIx6Ap6ZOMODuDJ18/5YL5PTB4q+Vp
         8WcF2c9Dh8JmRBz1TywOnnwtaQKSKVVzTObLRfGToL3ogd7C00gWsqmHG7iGhF4F1cjJ
         jozQhIE+7EU6Y8KfnLx+R5qKyL4c5/79ujZ6lzQa0KF0Q/rnYVrdtwkUlunlK4o82Dpc
         NUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0mnIwVMTEa8OR+/ZbsHQuhyXMdORkLQMwYcgiO2AhY969AYuxa+/Zm/Hg0ik7AWXhHQoMpMgox/sU/7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6m469sc3/fTvGarcWnokBkBwDv1KfJvhrR4EfvxM5zOJHBeSe
	K28dTqh4R7mtoMufF+Zl2Cyi/NtyXglILTLCcwSOue4VNpqMTaAeN8X0JA==
X-Google-Smtp-Source: AGHT+IFgU58UV3+3r9BTOQs2SprNogB0Kcw2ApQZwhIFWDnxqRaUoVwjUvjcp+FVcrkN2KpRFDILEw==
X-Received: by 2002:a17:90a:f40f:b0:2d1:c9c8:301c with SMTP id 98e67ed59e1d1-2e0b8ec8c02mr103545a91.29.1727365113644;
        Thu, 26 Sep 2024 08:38:33 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e2d7ad0sm3675952a91.42.2024.09.26.08.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:38:33 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: defconfig: Enable CONFIG_EXPERT
Date: Thu, 26 Sep 2024 20:28:16 +0530
Message-ID: <20240926145817.1124-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable CONFIG_EXPERT to allow the configuration of PREEMPT_RT.

PREEMPT_RT depends on the following configuration:

CONFIG_PREEMPT_RT
	bool “Fully Preemptible Kernel (Real-Time)”
	depends on CONFIG_EXPERT && ARCH_SUPPORTS_RT
	select PREEMPTION

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5fdbfea7a5b2..3d9d29eb0c13 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -28,6 +28,7 @@ CONFIG_CGROUP_BPF=y
 CONFIG_USER_NS=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
 CONFIG_KEXEC=y

base-commit: 11a299a7933e03c83818b431e6a1c53ad387423d
-- 
2.44.0


