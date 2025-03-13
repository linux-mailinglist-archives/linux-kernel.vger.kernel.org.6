Return-Path: <linux-kernel+bounces-559571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F23A5F59F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE5317BD30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A984267B66;
	Thu, 13 Mar 2025 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2C+LSWC"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54D267AF7;
	Thu, 13 Mar 2025 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871520; cv=none; b=ZZbLb8+pZnf0HAA9wSazo2xUKOt/edXtoMUdZmJgbtPA6vJRtCfqjYf9QBFgm57a6wvDtWzQdGBj/VV08qW0xIQtsm2GuEa8HumMRE9iDE/+tBhQcqDcnytDNB+9mT2FxtFq8vxNiMEH9NK7071VQtJ08N/uRx0nRNZBN0krMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871520; c=relaxed/simple;
	bh=ymhFzABxxhmuPpjW8bVGj4OoIaYa+Zw8k01HF8R1co4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ub31gBA7G2eT5no1L2Z2cL15paR0l8it46WdZsDyHaUYfMbhDVsmJbvreW2AdUFEDLSGd+rISc6XgRchmZ3z0nxBUFzDM/uGrEscHLGAn8HmOROAIZmMCOQk30E8kjSmEI46fN4eKq0TBRPeTDdwxOYQZL8t/veKCbRgSn+P9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2C+LSWC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240b4de12bso22505755ad.2;
        Thu, 13 Mar 2025 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741871518; x=1742476318; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=whAbkbFeemn/zGkgo0Y/FdRAbnzleJIZKjpHt+Srrxs=;
        b=d2C+LSWCTr+6A2P4quj23MNbc3Cv1Yh239T6GMe5nRXiNzVdcQ0UzvhGOzRaa2ZtcJ
         Caqk9eUK/BAjYgX8eiUE3UzSDfWwd9SjHn9Q46HVK1r3mPEybxLz+6OHP7umpYwR2KKX
         IwkaUlfy0DIamEjX6jLzPYFYWna3nXWnHaLRfvmAJmOwCxxtLyFlLZqdoHUJlso07O9C
         2UdYpsMIKPixA/LLru3QrI5q8eBD/cQep7n3xQFrY53KBjX4Ln8W9Mdsn15Ui0v3vuqV
         3fW4u/R46q37W8US3JQke3/hB9SLig/0ukXiPUj1b9RkszXx2lF1xKBxhRP6IVBo1wrF
         O5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741871518; x=1742476318;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whAbkbFeemn/zGkgo0Y/FdRAbnzleJIZKjpHt+Srrxs=;
        b=aVoZTOggUAifKAUVAkLKEoeseXELPCi7DTkMZie1OJIImPRR5GBr+/WwAv2hrarNe+
         Q1K1cvW3Tr4BDz0LHD5AwqH7A1HTUEpFRvKHKgRWOyZ8HUowSXJNLOs6GyN7Hb28zI93
         crg9B8Iqtw7llVFSZHHqbHPPmhQzCV4tZOvaTAGJs1LWhNAxATyLbLgcJRGgIxc0O4P0
         BaIMwKBgseknlvSo/y/vEKW1xfqbXVRWxjK09fq1ll0WhPTxvaE/VrsL3Cr7IdnnTqGr
         T1DA3maJx+FtkIN4VtmzjcJtlXlR1YxpcAhqDzoEHZBqaU6XtW73w7q4S3QTSc5jFMj4
         muuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD3XvSaAnFlnzI7pOGRYMMLzA1rZap4eyW5jNlHMkHi1RGJyrIGrB1faxzgSvqHk1zV7ZCE2NDrVnm694=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrHZ90dJAETmMy9+kUqQwU2GgmkKi0tKUyP6IPUGyal+5VpvN7
	0wWz7BABgNfmb09Va6ECYQv0XfLl3Oxev+tufT5bDXqkQfIo1WeF
X-Gm-Gg: ASbGnctPRZBMqOn9iHJlNOh+W/aPncB0OoWcZFjjcH4JzQE8SbXa0KAVMND3A6AkVhD
	fRPjPq9yPUOkZLQpwW89rYM01UEkC57e7CILoubnoVK52CYnisNbxb7v7NvmPDW0UZrTYYx2H+V
	jUfaE7kmVb+O/9kLWCB3vM33tMIaFFaewWAYffm2OHSQnyJfuYhAuPwWlZI+kcDcA027VsM8tDv
	+ycvT7lX2pLkeHpbFbUTKw5vbX8DtZzxma5Bha/9yQeK5gw+FfeW4zrI1J2JtEZwUwwSaGdRwIY
	ZTU8f6C9tAcUrWq9Tny39ETedWCmEj+gXXU=
X-Google-Smtp-Source: AGHT+IGYDZAgi/KLUPOznQ5xgfjN0dWdgaVF7llKO+O2iscvEuZFt77ZOFuioppulgZ1uLXSYl+/UQ==
X-Received: by 2002:a17:903:230d:b0:223:f9a4:3fb6 with SMTP id d9443c01a7336-2242887b4abmr382460685ad.11.1741871517948;
        Thu, 13 Mar 2025 06:11:57 -0700 (PDT)
Received: from [198.18.0.9] ([2a0f:7803:fac5:a7b6::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6d52sm12539615ad.116.2025.03.13.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:11:57 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH v3 0/2] (no cover subject)
Date: Thu, 13 Mar 2025 21:11:48 +0800
Message-Id: <20250313-sfg-spi-v3-0-e686427314b2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJTZ0mcC/3WMywrCMBBFf6XM2kgysZC48j+Ki6SdtAP2QSJBK
 f13064EcXku95wVEkWmBNdqhUiZE89TAX2qoB3c1JPgrjCgxFoiGpFCL9LCgnRAR62T1nko7yV
 S4NdRau6FB07POb6PcFb7+tvISijhrbGOOnuxSt360fHj3M4j7I2MfzwsnvE+oPam7iR9e9u2f
 QCfbwvy1gAAAA==
X-Change-ID: 20250228-sfg-spi-e3f2aeca09ab
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, chao.wei@sophgo.com, 
 xiaoguang.xing@sophgo.com, dlan@gentoo.org, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741871512; l=1276;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=ymhFzABxxhmuPpjW8bVGj4OoIaYa+Zw8k01HF8R1co4=;
 b=ceQjO7hj4JE91EZ1K+OmC7H/r1+Yyt7wnSBhFNdaAQyaqmBpaeoOe3uYiEL1M4O+ok1M+xlVp
 c0kytGfEnFvDm4NumSnrSAsMqwu9q4iIQxryJ1f2zrVPUKtWQcjC/En
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

This is tested on milkv-pioneer board. Using driver/spi/spidev.c
for creating /dev/spidevX.Y and tools/spi/spidev_test for testing
functionality.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
Changes in v3:
- disable the spi status on sg2042-milkv-pioneer board
- create dt-binding of compatible property
- replace the general compatible property with SoC-specific in dts
- Link to v2: https://lore.kernel.org/r/20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com

Changes in v2:
- rebase v1 to sophgo/master(github.com/sophgo/linux.git).
- order properties in device node.
- remove unevaluated properties `clock-frequency`.
- set default status to disable.
- Link to v1: https://lore.kernel.org/r/20250228-sfg-spi-v1-1-b989aed94911@gmail.com

---
Zixian Zeng (2):
      spi: dt-bindings: snps,dw-apb-ssi: Add compatible for SOPHGO SG2042 SoC
      riscv: sophgo: dts: Add spi controller for SG2042

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |  4 ++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 26 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)
---
base-commit: aa5ee7180ec41bb77c3e327e95d119f2294babea
change-id: 20250228-sfg-spi-e3f2aeca09ab

Best regards,
-- 
Zixian Zeng <sycamoremoon376@gmail.com>


