Return-Path: <linux-kernel+bounces-434050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC95A9E60C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7762E1885700
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AAD1BE23F;
	Thu,  5 Dec 2024 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Cb43OPaC"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552052391A3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733438800; cv=none; b=C0GyHzd9DdrKDmeDDVszPFP9PYQ32bFTJWLIh0XC7bSYnJTvmHwKI4LDxM5mlkF8HJNxcWmtjVV4lv6zRHN1fWpVmYd9p3YV2njTY/MFxdvRKg59eCo2BAxptMQXAViElFFCAmbOjakmM6Yt1fjpuhk8gRrbxDOby7yLl1Si4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733438800; c=relaxed/simple;
	bh=kSys1miFh76n/13JeF6prq2YaIdC+5aYiljRgT2zqnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cpg0Ad/3jqvp7RfUGT5Lgb0YCsHnWoYlnfd0q6h0eS9GeoWIJ5yNkBFHdm+vA1kliKImmJyFI2420hUP2IGoQYI94DrPcChre68IMdbp53lUKM4cEVhG+Leg7e3qTj8jTlMJfuFPAzjfxxpJ7fAtfWSeyvgJ5tVyeh4sCuy5aLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Cb43OPaC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215513ea198so21162205ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 14:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733438797; x=1734043597; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfJMtQFbbnJLYJc+B7e+6XkPBjJDuJEYU2he5Ao9TfA=;
        b=Cb43OPaCnHyAlpX8s7ENSty7KEuzcXQq0REq45t6C+dNB9URw/o5WWXAavmuLDggEG
         Vj0sU/8RPnLaW1DAprEuuO07V08EjniMJMLy5elsNCnzHKMuBojO339gmECA/KXVNIbL
         VMg0WVoFBjAelBt+8/qroO3nM26JZt5lredun2Jl9yx4qWeoE85J1XTOf3eabdpTuMXQ
         /WZ0wxPjgMUUUCx2qLDRSPg7pRjyM43Wk1tzWTGK8MxDNdJD0gtxWGZdPu63PnmwIP3y
         DAU8NQMTZAmawwMwzTwTBHHQ3IzFrltFJeoSZKhz/ybRQxCR48JcqyonnX0OwElPg6o/
         8s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733438797; x=1734043597;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfJMtQFbbnJLYJc+B7e+6XkPBjJDuJEYU2he5Ao9TfA=;
        b=IijpKnmRCDq9iak6WlJvsr05DWJAPd2CPXOZ0Pxh+yMjVV+h7fJzSCbBB7b8pZiAcB
         pwpz2DTEMJDwgn7RF1P6OH4FN4bIkL38SePi+Pl/OMRTfl+FuhR18yvCiqcxamVeJayN
         vluxnwat3whKx6ZcF89NaGBmg2pqrB8GCzG2nkv2a+gtdq2T1FPWcjJchsXkHFfkytkN
         lI2PeQNctrZjfoyZUGyE4Fyqzon7Vt/mAYYURpszHGtz+kjp0Lmy8dnhhe3NqFaGi33H
         bNKmhzVfw3AYbb9kfrVJc8BDf9P+TweJDY/FmTvTEIGuT2INB0YNqK3xmsgy9kp7r4g7
         SpYg==
X-Gm-Message-State: AOJu0Yy8uMsdFfVaqRB2iHxRGwVHUo7f9FTwYL/xjI3Jw+DTEIuLS/ET
	rWI7Ig44asQsEz55bLYFhBMJHDVUlbWoP6Whof0ng8Wx7DLB04TKwYgU8P8lJDE=
X-Gm-Gg: ASbGnctHap0y7BLBIWqamsO2fjO2w0ypqp673A+XJhkCrb3C6PxBQNPsnCm8+XbB0cc
	Qor7YBauwzOR6r8y0/DHnSyXiBGv32xZ46p+frNTxNh+2zmWq/FLmiN7cofhiYmBEuN2/TgJknx
	I25ZRWfwrGGYtD87zFdcZYAvGC1tuAlz0iVvrPuWeXxAe9NzhH/ExgDJjDRO4GRqz9ZZyKZ+/kn
	wtr4JZLRDKV4AkbX0blbsi6nQJALEKDaBCf8Uq+r60/3VOBcl8slcQ31B/OXrdl5A==
X-Google-Smtp-Source: AGHT+IGxKOF4tRLn53n+/IZITYCtDtQqL2cXFtOxICsp7MDrCCvJrXxUHWRF+tn5X2o0rn6cYCcUog==
X-Received: by 2002:a17:903:2bcc:b0:215:9c06:272a with SMTP id d9443c01a7336-215f3cfb96amr81493175ad.24.1733438797715;
        Thu, 05 Dec 2024 14:46:37 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2ca9115sm1753760b3a.166.2024.12.05.14.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 14:46:36 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 05 Dec 2024 14:46:19 -0800
Subject: [PATCH] MAINTAINERS: Remove Albert Ou from riscv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-remove_albert-v1-1-17eb850f1540@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIADotUmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwNT3aLU3Pyy1PjEnKTUohLdJFODZEvTVENLYwMzJaCegqLUtMwKsHn
 RsbW1APvWqqFfAAAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=915; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=kSys1miFh76n/13JeF6prq2YaIdC+5aYiljRgT2zqnw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qQrnPYb265jRnv91QeMvN8Y80RI+vAuD5nw7mDfln2H
 s/+rdzdUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwEQ+RzEynJtXYXFmYvasdVmF
 r2tmPlu9Y1XWDJN2k/JrNke2XsrvecLwm+VGp9vRlkWPFlzyuqLiFMoktt3vQNP8+1ezX5SY1DO
 fYQMA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Albert is not an active maintainer and his inbox rejects all emails.
Remove him from the maintainer's list to put an end to everybody who
interacts with the riscv linux mailing list from getting spammed with
rejection emails.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..8a5e12355850 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20104,7 +20104,6 @@ F:	include/linux/irqchip/riscv-imsic.h
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-M:	Albert Ou <aou@eecs.berkeley.edu>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-riscv/list/

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241205-remove_albert-b50c95e19306
-- 
- Charlie


