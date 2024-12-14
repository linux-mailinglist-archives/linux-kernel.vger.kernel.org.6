Return-Path: <linux-kernel+bounces-446123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B29F2016
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F87188804C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A891B0F3D;
	Sat, 14 Dec 2024 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ploH3Zt7"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDD1A8F9C
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197215; cv=none; b=ouCcnKY7J8g1kdY62hDZSKGCrirEJpUawIr/W1mxxqZbUtLnI8Rjp0A9UZp382BqtBhBJDpY1ohE/8ZiSD+Rt9l6C8TyQoaMJe5pq1H62xLID9G5ewtxSshKr5Qb+elbxVrm7dqleH4BiX/ANE66Vnu/c4GftJdN05EZDOFw3NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197215; c=relaxed/simple;
	bh=aE+CJCpUn5kUAnEgYyEV3gtDvbC5Svv8OP258wfgmN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVeCrURO8m7Pi4RFYu3BWBhTExqzGOGRea56OPz7NHxNOOX9w00Vr42U+7YFpAPlwdP+KZB4HC2kPNxfXbGMKyA8TEgh+twznBC7MXLlgPupMe64MxF0Roqt9smFALI9jeBZQ6g1gYVw8g+mkcc+8MrblIti/hKq4h7F8tY6JzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ploH3Zt7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216426b0865so24514105ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734197213; x=1734802013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yE+w0neHmk87dMRt+p213gF5rtqgAWN6iext8wGVFRM=;
        b=ploH3Zt7irmUPLOxQPo4cihjIN1TWCyNc2pBk2qBlMuPYrbgvM49tsdxwmnCngUYa+
         brQsa+409wy3YDm/MRXMS+1yv4DUHf8iFkZgNtMAyXV4RVggtCY9wcYRH0oCdXVPTMT7
         AWIB9R3hG0LT1CDPyxaWBP5XvtwmVQZxp475ntaktjJMs5Q05AbaizN7U5xyVbYQCVxQ
         WTeV0pO58YUaQwOZJY+IU1WX7JsKGhqSwJxWOIMimKAtaEvWSw6gSrgiXDR1AP/cL5do
         aJ7xKKQSEh2Dt9CIlMeMw4XZhNgkB8KRzY3PRIBOBSpmjRiWOKay/FzxFVVZbp1+nh7d
         pSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734197213; x=1734802013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yE+w0neHmk87dMRt+p213gF5rtqgAWN6iext8wGVFRM=;
        b=Gi43Mxk8i83EKbWlH1qSGh+qKCbLuJflxH9dhDTYvVpqQ/PZpikrpPd1jZwebOm3rP
         ms9fZPdIFNegYkN66lfipzWjNGyVe6XVbsFHdi+yY3a06ZzuU2LxWqty6Ah9KGQ/VqYu
         5omVgyJIHPGF3Drtc5EqKDG9VmAFcqM15aHmvqmo/eVBIVXybJlsu6LZluDH0XaNyXOn
         Wj/fZgTPkmv6fqIK5l93sHBMD4u3+c0HI5y8Mp9R1Fo2fIhYcmeCuZsMXezhJS5MENwt
         J08p4dI90umMpHkTtuhypWTaMP4tXilEzTT+O9XyTaN3eIa53xo8MySi+GrtOXCnKbsb
         F2cA==
X-Forwarded-Encrypted: i=1; AJvYcCWWujm6902V0o8iB3AnX+c1YdFTmq8Zr/1kUPV1NrdFUAcQT+1uaWvmcwoMH92nLfLuJEfSzoIX/IsH13o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXf++VRZdaV5n2pnajUsdJRn5nzQg7r3hA7IC4SCmVEAQcOp9
	vqEBHqZWdNmE14D9X82QhVzhSpTIBpJo116j4r0HDUTyO57lreuo8oK9492B5uruvoO/gJohUNC
	M
X-Gm-Gg: ASbGncuU/JHwxJzo/315ZG8Wd+Iro1BgFOWwt27+LfHbXjSk7oTQw6bRlV5FjNM/nFd
	ZeLtawd2zyWjySBJl2z7/Q2SFOBLDxRvtQWDBkkn2ThQLWFmT2PoHhVnrD1fn8Czznae6ZW1rNN
	X8mBlCt+oe6uwPpYeyRLWbuzfV7P1rhP4Rc5e1heo4Wa9VKYxheKVAm+NsL5tBBLPpILKzpjvWJ
	hu/z30ruSZ7SPK7igRpGeUKFaCpEfrUyY2SrsbK/Pl0FtIKiusHxGsND8t8uVtptveSgLAVy3vg
	1Djo2Uv/Muz7ygE=
X-Google-Smtp-Source: AGHT+IFHcRze2J0M8hyBJEZA/NeT8/eZWD7tT0rfNtTykqj4Jc1ZWMZrjfrUoQxfR7mhTVQoKpV61g==
X-Received: by 2002:a17:902:e545:b0:216:30f9:93d4 with SMTP id d9443c01a7336-2189298bbf7mr99837005ad.8.1734197213088;
        Sat, 14 Dec 2024 09:26:53 -0800 (PST)
Received: from localhost.localdomain ([223.185.132.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm5049811a91.41.2024.12.14.09.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 09:26:52 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 07/11] RISC-V: Enable GENERIC_PENDING_IRQ and GENERIC_PENDING_IRQ_CHIPFLAGS
Date: Sat, 14 Dec 2024 22:55:45 +0530
Message-ID: <20241214172549.8842-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214172549.8842-1-apatel@ventanamicro.com>
References: <20241214172549.8842-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable GENERIC_PENDING_IRQ and GENERIC_PENDING_IRQ_CHIPFLAGS for RISC-V
so that RISC-V irqchips can support delayed irq mirgration in the
interrupt context.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d4a7ca0388c0..adc878f029fb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -110,6 +110,8 @@ config RISCV
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
+	select GENERIC_PENDING_IRQ if SMP
+	select GENERIC_PENDING_IRQ_CHIPFLAGS if SMP
 	select GENERIC_PCI_IOMAP
 	select GENERIC_PTDUMP if MMU
 	select GENERIC_SCHED_CLOCK
-- 
2.43.0


