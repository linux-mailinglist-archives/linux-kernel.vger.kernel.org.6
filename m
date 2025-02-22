Return-Path: <linux-kernel+bounces-527433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4956A40B22
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5AF7040C7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F42121504D;
	Sat, 22 Feb 2025 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvPfAtr8"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBA2147E5
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251219; cv=none; b=D2BkBEuLAURnzSVX+99sLJAAl2YMkUnjYoXZqXMjCFkTPtxxCm1ixCB3UJHpmj9DwRHsyOYIeT9j+lhuCffiEKsKWYlJQbEswnsL2Bz447Hcw2YU7TebkPcwnj5UBZsQBzxEAPyLP6Vqib4zYtp7+wuWVI4A5U1xa/nZbnStdQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251219; c=relaxed/simple;
	bh=sCJb295kfpNZJraMgWG8u5wtIixvHjWMUi3T4z6Le9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itaVr0i83G0DrhU0Oo/BULlE0k+lT9uSfGOnD0M918x/cwJ5GLS/DLyiyoDTVGZocarJvUOjpDIHPGsYzgRI68sXuhle8ZPIDDwZYAIWeSmFOjwZAUCQ2vlAoRbQr/viJ1POZjmtiliU+5p50zDDpMLdg6IT8M5lMF9EPtnuwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvPfAtr8; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c0bb7328fbso335680885a.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740251217; x=1740856017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEdxq9t5pZYrTokyQQH+c0hLwTUa97QlsNU/pVltUII=;
        b=bvPfAtr8jaAR+nvCpwSGRXoN6m9demujzHatjrEsykz+gx2QtX1xMvEr3WsuvtfXi4
         Dsvow+Tv3PesVe8lTgCsHyx4qaIEjCwQlM4CbyDhuyP79F//9T4IHtkj4iYdMZAjHw/i
         LZdPyhPC5VL6JUBsTN4OMPPFOiES/tTzG7nFTiBn9UDOOwGLOoh6HVITve85vA+BVLvw
         +6M/ym3J1wF6vtKPc1vPsoADMPlkv3dV/c9OuWhJKPFUtOqMoXavBTi/a5t/v28hdKyi
         Ki9nAUDOq99e54AbJjHIA5YboH+rCNHR1gV6LykLO/uCci0Q7hUzKQ0/LEUAD8Ahl76Z
         LwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251217; x=1740856017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEdxq9t5pZYrTokyQQH+c0hLwTUa97QlsNU/pVltUII=;
        b=GwY6JVfoW7jZk/2izZyXLJs6ReqRlSwtfCsvaKkzztOMJxgEXgoAdyIbSxat5+Zejc
         UR7ZH+ec4vdsnrhOH43jygeEUvAeXxVJbpjU6FOhPbatmtvD5fLfZa9HTQ6+JB6nvuTo
         OIIXmhtr/ffhHlSs+Udtacv9lbyZv27HX+QITRswtpvhCGk5AvW2mhIAMTdfi31rWezK
         9UGee0ksSfnu4yyvgsTHxhjoYVoFhiwMt1NsgO27kicp/yDV1JkmAyB7Zu773NKAY4R4
         Z1RERhSNhcZkETMdnZIEUyiIoZdhspybx8IKYE0vkv5WLJzI/sEKN5VmgX5pj61lWoUe
         xrYw==
X-Gm-Message-State: AOJu0Yw0T+KrnQke1jqS5E5VFDKAdp74XRXhai/Bk0EO3Wm8unfS0mYC
	X2DdfOoFgi+ULiyteT3XYvQ/gX0ytqwN5zO2uwtAGZDA5QCmWkMoXmKB
X-Gm-Gg: ASbGncs9lTYpOnoaorIVstUieq+C20xAM6QDeJC7Bo/G7ehJfbZFhhQkytQPNnaKv6Z
	TEhW3I1KAue+aP5tXbILEMayXqaf1GSKkLg11CQxB58JBz6AFQVM60cEekThwsDt31AYzkFfZLG
	MOCZn6M6GuAAJZHGx6C4buy+2H4u/5fY/jca32HjHypuIRgCm9S6l8Id/1OPGz0H37x9/SoZgnp
	cqm4IzdWfm7sch8Fqqww09wZUudKn8Cvk4RATEaa2a1aU6ruX1o4QJXKulimRHBzh79H2KOX0wi
	6phhCDU=
X-Google-Smtp-Source: AGHT+IFluJWdccE5UzTWh9K4kVeSSBzncztfk/7KSRsf76mtVD8rCM62hDMMa6Xbkur7pRLcp9SE4Q==
X-Received: by 2002:a05:620a:1995:b0:7c0:a5bc:3ac0 with SMTP id af79cd13be357-7c0ceee98cemr993549285a.12.1740251216925;
        Sat, 22 Feb 2025 11:06:56 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b1ef73b8sm550185285a.65.2025.02.22.11.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:06:55 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [RFC PATCH 10/11] x86/stackprotector: Move __stack_chk_guard to percpu hot section
Date: Sat, 22 Feb 2025 14:06:22 -0500
Message-ID: <20250222190623.262689-11-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222190623.262689-1-brgerst@gmail.com>
References: <20250222190623.262689-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/stackprotector.h | 2 +-
 arch/x86/kernel/cpu/common.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index d43fb589fcf6..f08304ac262b 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -20,7 +20,7 @@
 
 #include <linux/sched.h>
 
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+DECLARE_PER_CPU_HOT(unsigned long, __stack_chk_guard);
 
 /*
  * Initialize the stackprotector canary value.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ba78ee8fdb21..eb7ac92e8565 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2089,7 +2089,7 @@ void syscall_init(void)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR
-DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+DEFINE_PER_CPU_HOT(unsigned long, __stack_chk_guard);
 #ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
-- 
2.48.1


