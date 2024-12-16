Return-Path: <linux-kernel+bounces-447026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD489F2C36
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC2516740E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1946200B85;
	Mon, 16 Dec 2024 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="c8ddOrWh"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7D1FFC44
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338922; cv=none; b=GQVw3pL9JG93IGfehRHsHYSwowAYsRBEXMJ/4v8stuNez0tK2q5UcFsGrnzgtI74OQ5zPoSIOmGoZb14sfAzy6AKa6wGBPi3YxBqxzrb/CBEM5mJcR+hf+y5aiPrvOZP0Zn5nicdjNv2blq7XauObdV9uiM9R+JHBNf7DyrkyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338922; c=relaxed/simple;
	bh=WUNE4+/vgYu5ic9c+DmiHQY0R8adpw80lkuC6ZFbCtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVf8sRXtNjjCv3WEUJomBXI8qomiHZ3/Y+AISUaRHE6gdtHNUitErwp0+zm/0meKjrHqnS26SvVm5liuSM3frYQmBHCNEjNMJ7it/TlLL4tKOsDAfG4EUIrtfbJOVsXAy8paFvSfg/4Xs6QvVoJsO/JyLDJLyQQQXa6exS+97rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=c8ddOrWh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2161eb95317so34386475ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734338920; x=1734943720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eei5CeEAyNvf2PS4xwdFaq29ZOKnFWm89T3hqpCmQHw=;
        b=c8ddOrWhz/YN8EN4xP/LzezHbkEEeYwwFofldTa+UX3v1ZKc/xOR5thbXheHuQaaQx
         KKNdaMTqFjCMEZeLEigC5qxwMbdeCLbAP3/SCysHbZoU9UmGFtlLt2z2VCWrJeiL+c6M
         dG6YXGsdz2Fij6aMYX/VMNyRgknwoGeixQYjAVkV2u8EmFxBP+bAHIFPradgB/xXLseN
         SKGb73MS9gXiQtZrEV5Y651FRTcrpplFtycfpvyOiJ5GufHuGLE99EvRUJzEzHQZin9i
         9+0u8T1Ld7PeCne5RIH4OUNbFxBs00i+H3thX4038V99WgYAXCFCco7ok5MpXprLIVoc
         jxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734338920; x=1734943720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eei5CeEAyNvf2PS4xwdFaq29ZOKnFWm89T3hqpCmQHw=;
        b=PrRr8iUlLV6DNDVeP8Bh/11CVRuNfMWTR6lH+V8s+l4LuJBzxv47RuZcGNn9lQXNv1
         I2sYynkaWfzbyM9bJemZR1ICJ6ytVu2R6trS4MTJEdG7n5RTXeWVFN7E2a97yCIdgC2m
         eOJY07L8d9JM1u7qmpmFyxiQQpR8wVZfJNnccxrukwH9pBGDqySuun3S2L9MmINPYJhr
         iU/Vg+nF+K95Rj4xD+KhB/9NKlGShHNRSiF1v9HBB1Sn7Bs5/qVCNH16vOujy/uFJR/D
         R02P8wKehywKDmCFFRmDr8otDsNgIWqiJwfr64N0H/6e+mVwKqKdaxZ9rJoM2AlsKjYb
         JAAw==
X-Forwarded-Encrypted: i=1; AJvYcCVaPTFtwK+DeslfrKVlBPgxXqeSzKBGb/UOx0WOu3mTxNow9av1doSD2Jp/6mIdxLjHDi9+8584c6s5Ojs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw11jaNF4T3sBdn9aJiGHEKImfhEgqEbAveRBG9TN1L/49I9L0i
	458tvw9+HlbpmGOOeyvHHdh08Fg8w6GR4bu7+OOzuDZ4FoktJIJeeo0w76SV9f0=
X-Gm-Gg: ASbGncsZ0pFJSspQ8m8h4Ti0cIFH3KzBDntF1geIAIZ0ura1U3fLZlcWGvUPBo0vIeV
	8RX1ZG4x4UApXG4hNbDxuuUOFNTldx+eEFExbs+b767qlkkGNiUx5YqafL5z62+iNTETk6J7Rxq
	H7iEHwDo3fW2JkB/clFIrxs7UPp02u2924xdVc8Uy85ATA6Z3P95xQyuxsrBYCB4EVJum9bz+IY
	lI6I3hqvWrwtCMN35Diy9uHcqjVn7NqobqcCG9pgzh3vPvqgrdfs4KCcG9dOJnbQxgz68EcY/9w
	eMHsEDaTmX8E50Q=
X-Google-Smtp-Source: AGHT+IH23xFB2kNx/gOskLUHtyyFSXX+WD7siqR8qRzGwZ+oJpSpIMc4NvB33gu7U5vEEvlRMs2S/A==
X-Received: by 2002:a17:902:ce85:b0:216:7cbf:951f with SMTP id d9443c01a7336-218929c72b5mr138434115ad.21.1734338919985;
        Mon, 16 Dec 2024 00:48:39 -0800 (PST)
Received: from localhost.localdomain ([223.185.130.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e501d0sm37711495ad.116.2024.12.16.00.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:48:39 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [RFC PATCH 1/8] riscv: Add new error codes defined by SBI v3.0
Date: Mon, 16 Dec 2024 14:18:10 +0530
Message-ID: <20241216084817.373131-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216084817.373131-1-apatel@ventanamicro.com>
References: <20241216084817.373131-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI v3.0 defines new error codes so add these new error codes
to the asm/sbi.h for use by newer SBI extensions.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6c82318065cf..bc35ad750e28 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -418,6 +418,10 @@ enum sbi_ext_nacl_feature {
 #define SBI_ERR_ALREADY_STARTED -7
 #define SBI_ERR_ALREADY_STOPPED -8
 #define SBI_ERR_NO_SHMEM	-9
+#define SBI_ERR_INVALID_STATE	-10
+#define SBI_ERR_BAD_RANGE	-11
+#define SBI_ERR_TIMEOUT		-12
+#define SBI_ERR_IO		-13
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
@@ -504,9 +508,15 @@ static inline int sbi_err_map_linux_errno(int err)
 	case SBI_ERR_DENIED:
 		return -EPERM;
 	case SBI_ERR_INVALID_PARAM:
+	case SBI_ERR_INVALID_STATE:
+	case SBI_ERR_BAD_RANGE:
 		return -EINVAL;
 	case SBI_ERR_INVALID_ADDRESS:
 		return -EFAULT;
+	case SBI_ERR_TIMEOUT:
+		return -ETIMEDOUT;
+	case SBI_ERR_IO:
+		return -EIO;
 	case SBI_ERR_NOT_SUPPORTED:
 	case SBI_ERR_FAILURE:
 	default:
-- 
2.43.0


