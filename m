Return-Path: <linux-kernel+bounces-403099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA19C3104
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 07:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D77B1C20B66
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 06:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581581487E9;
	Sun, 10 Nov 2024 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="AWpm4gsU"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13D813B58F
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731219075; cv=none; b=PbqoLehSA7RNjfvw9RK9yNufbAtGHxtNy7v4SHZE8almGaTvRNY4lTL4a6dyXWOR3yFstcIIgfQPYUfFcoFZC5j1GuzHezigi4RNy8UPIRc95IOsd4lCQ35keepJayXepz7EFfUW939cPIA/LeHhzrOkc4RTTQOoQdGMgjv4cMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731219075; c=relaxed/simple;
	bh=ghOxaHkb8fT8cboRFWIlckWraHKHiWH7y5asxPZdkZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JZd+Cn5QSpPFxpwDga+ht0swsN8WSezbqWqbi3eqjjcDH/4AVbzAO51rrSUBdR/p40PL/Zn70ORU9SPDMN7jyYHfy/8lPoa0RlOBSw/0qRpxALeMvEnBMXoYMTzuGHMl1FELSDbgNakWzB7M5beZ9n0htalqxfZUgEpUVdCiFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=AWpm4gsU; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so2409015a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 22:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1731219073; x=1731823873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/aRM5Ww9FHH05vD+pnExec4peRxorVW2HFD8O0Pjugs=;
        b=AWpm4gsUdLZdy0gninx6HWSn+J9gaxdARqj+vGEd1AoZI+guk+7iQvtU8P/EXDo45L
         3LrZy2Z7qAZoVeCPfrxUgJAMV2x7NjBab923xU9UC7yKkP+x3KQ8/Ieb8YE10+swLu+F
         hwlL03G5GdmdKPPnlSafhlDdZA1rUsC/X61Y+Cs0V6mtJ2zU8V5jdpak+adw1H6EEDD9
         RTeP/B9iNNORnHKF1HR4iTSVbk0kT/wtXdKHWv/HrrGmCBzt4HvTRrqYWQYtwDynGYXh
         T01pRz//Ut3AvCI/4yVz5NROIrxlX+R2Uyy45qgnLmJeUBg9IIUtRDMGrDpqNJIAh65w
         Krag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731219073; x=1731823873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aRM5Ww9FHH05vD+pnExec4peRxorVW2HFD8O0Pjugs=;
        b=sB9naI8/VWgCd2bpKQ208apd1sfYffeamyGGTYVbKnpJ5RlrywEGOagA1BZPHMnArv
         XvOFq7g+d/e+v/Z3nTVBE0APVxf9kAU5Ljfx8/qWWatz1+xfPaRwLcX758UTvKqWfD07
         PCwNHNO9ONLnEwE5aesnMJBpgFSQGFv0w5hHbui8uBjjE0622ODd2OYKDu6IoGkWELyA
         NAGLynPlhD3iBfh0pWP9287Wo2BUkawuKbH1I7napac6t77D7z8+iOh8O+FNwpjWF7Uz
         iT4UeonNYnuW4TU8xSN7k+E5CHUAQxuCyEkIagUHgfhOiy/4VwJJOukhZYH01D6q2juC
         UAvw==
X-Forwarded-Encrypted: i=1; AJvYcCUaiz8VeZwEw5OFspmxFG9t7V3rv1EkYbhrRkIBxQh8RoqcGvDKMmQ1Cxzl1KVjPD5oH9LxmO1HUQGnQyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhiA65f1bfxnTQRmAfHK9odNQBYR4+wC8Y0AlWZSI1Fz7DRfng
	h/RClhwsXe65u0PouwGUg/LpYEznaXTAZCf12lNxTgclyzfRcz39/L5LZEahV5Kxy5JfmjrYBXC
	T
X-Google-Smtp-Source: AGHT+IH7Xi3ivP4+SmhzEM00uzgJKu3Ewsu9l50QIYl6viRlDLtPY+yrZXelv5RLlMBav+OKnuEI6A==
X-Received: by 2002:a17:90b:4c4c:b0:2e2:cf6d:33fd with SMTP id 98e67ed59e1d1-2e9b174821bmr12073495a91.31.1731219072969;
        Sat, 09 Nov 2024 22:11:12 -0800 (PST)
Received: from x1.tailc1103.ts.net (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fe8e1bsm6205467a91.51.2024.11.09.22.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 22:11:12 -0800 (PST)
From: Drew Fustini <drew@pdp7.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Drew Fustini <drew@pdp7.com>
Subject: [PATCH] riscv: defconfig: enable pinctrl and dwmac support for TH1520
Date: Sat,  9 Nov 2024 21:44:11 -0800
Message-Id: <20241110054405.667779-1-drew@pdp7.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable pinctrl and ethernet dwmac driver for the TH1520 SoC boards like
the BeagleV Ahead and the Sipeed LicheePi 4A.

Signed-off-by: Drew Fustini <drew@pdp7.com>
---
Note: the th1520 pinctrl driver and thead dwmac ethernet driver have
been applied by their respective subsystems and are in linux-next.
I've successfully tested next on both the ahead and lpi4a boards.
This patch is based on next-20241108.

 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index b4a37345703e..99a11142c03c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -167,6 +167,7 @@ CONFIG_PINCTRL_SOPHGO_CV1800B=y
 CONFIG_PINCTRL_SOPHGO_CV1812H=y
 CONFIG_PINCTRL_SOPHGO_SG2000=y
 CONFIG_PINCTRL_SOPHGO_SG2002=y
+CONFIG_PINCTRL_TH1520=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_SIFIVE=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
@@ -242,6 +243,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
+CONFIG_DWMAC_THEAD=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
-- 
2.34.1


