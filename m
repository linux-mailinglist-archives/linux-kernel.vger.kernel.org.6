Return-Path: <linux-kernel+bounces-390000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1D49B7452
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA43B1F24F57
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE99413D882;
	Thu, 31 Oct 2024 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCsGv2md"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758EB1465AB;
	Thu, 31 Oct 2024 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354979; cv=none; b=XzQCcF1nlqmmmHGGuyz6QGX9u5q/urvklJwMdbol6ft+uN/6zC1HRlb/shTJm6oOkjmGfXvEcaN1QtYPFa6dnInkDkxi+Y1FyUWiyT7czKoAfFCMuWL7uzgEnGoMDX5HgjUbce//mzxWORAYlaHFHKJJlZqmOOri41OLYJKXSVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354979; c=relaxed/simple;
	bh=Q9CnyF7t//8HC8h6F6lh1zeH9rMHPCikrgtfjgJg+a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llbhjA0AaUWtr8EiOqOGmYf39ozrG973x8pWsGPG7pNOF1V3WKZDTvX2Uh9dga+p0+3n9Zgkk8aENLPIePYacryQ1boCN0X6LvKEdzNFnPBLRO/taMkQ0RtKhV7m1jMKNuFRYZRHflf/19O5FqT/geBFPOaKSwQ0a/8sFdg2eFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCsGv2md; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so514760a12.2;
        Wed, 30 Oct 2024 23:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730354977; x=1730959777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncgmlyGfcrqHCYKyqt0DRpGIqa2UXUmRq5v7oAb7ZpU=;
        b=HCsGv2mdXs5DdK2iPp6y0Klq9JkySVhO/lb/QlmMNcGWHq74AiFDnO0F3ojDnytv0M
         9V3XwcJkvma3qr0OtIDMIzueE4HNjsKIBVtm2s+fEI1X5ECmQDSsrXLYVsWL5nrczJgg
         cZc32r35Vs51dkz4dZLndUps0iSsyzdUOOD5DxQx8ZsCi528EKNyo0gVwEzCVx3dVpKr
         p6SrrraeyPeyFG65LP0paMutbeQmQuCd/OjZpftc6NqDF6656tx1PqpXkFzfZWkpZvfz
         +lB+a1DOSyqCHvhlDfdWsHYdRPagr6/o7NdnvhCW6V0LUdemBl6ITVCOe92pNTqQNUKP
         zXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730354977; x=1730959777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncgmlyGfcrqHCYKyqt0DRpGIqa2UXUmRq5v7oAb7ZpU=;
        b=qEKWFDsontLdASx84/3nVGiIR9pfLPXz/lY8txikH6PsmBR3cQfLUHhaGAsE07SNOB
         Pwo/sGKL2eLIqWU0EUiiRx1GtTxgFtRTMm9x4bUd94+6sl/lNBuYeO/ZSX8P26jgLJ0x
         y4Z59wLrwKv/ES/A5PG+1j6Ir+aGiq4NRvqtaBdzORYuKOteB7XB0McQwt3J6J9JQcYu
         8N2XJVtS29kTSpihspQN+7kihJefSpnzTdjd22kpiNaMlA9qdtm7Yik799D0ibOtdo1u
         fhADla0//cFmZZ0iDxK+GQqWn0FMaAL2E4PppSUJLXywpVzUla1GLmpVANloF5N/NPzQ
         S8rg==
X-Forwarded-Encrypted: i=1; AJvYcCVHcylOpzcnQPPRqQfKXxV4T+sIOgY4Zq8ku21POpdQihPvTV2p+EgXIs+A8tcT5KcZXGEuIFhKPqW3@vger.kernel.org, AJvYcCWpCBq3zDmXLFDiVH0bkczKcaP/tqpBj6Z95t+zzcKSzouVq18d+QArdz5gLa9z7JBxatOOGphMTnPaJe4N@vger.kernel.org
X-Gm-Message-State: AOJu0YzYe0/rXkgRP9/pA3Ebnxm/hEPrBhDw8E6U4GIKidNLdxeVQcZA
	CO+mFp8oMctAa/IZER69bSq8ERFT/hvzDYshZQexbJ5PdrItHa+O
X-Google-Smtp-Source: AGHT+IGwIIjCJ9cra3CtW/n855IKa7eXRuLq3icr68WZ/L++36slplZBz+5pTu2cxLdjevaZWAGmAg==
X-Received: by 2002:a05:6a21:3990:b0:1d9:1f7a:a44f with SMTP id adf61e73a8af0-1db91d898fcmr2823576637.12.1730354976633;
        Wed, 30 Oct 2024 23:09:36 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1eb1a0sm557691b3a.67.2024.10.30.23.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:09:36 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Anup Patel <apatel@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 3/3] riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers
Date: Thu, 31 Oct 2024 14:08:59 +0800
Message-ID: <20241031060859.722258-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031060859.722258-1-inochiama@gmail.com>
References: <20241031060859.722258-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for T-HEAD C900 ACLINT SSWI irqchip.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 2341393cfac1..5b1d6325df85 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -256,6 +256,7 @@ CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
 CONFIG_PM_DEVFREQ=y
 CONFIG_IIO=y
+CONFIG_THEAD_C900_ACLINT_SSWI=y
 CONFIG_PHY_SUN4I_USB=m
 CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
 CONFIG_PHY_STARFIVE_JH7110_PCIE=m
-- 
2.47.0


