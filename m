Return-Path: <linux-kernel+bounces-257417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368A49379A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75D4281599
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E1B5664;
	Fri, 19 Jul 2024 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SgmMEbZ0"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63713D63B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401845; cv=none; b=pMObeQFtgAUYVnzfaaWxslIx60ZR/wBirI4JW1LIV8hTgBvYmG9mS6ewcPVYsuE//kC9fzyW+zqKUW3Z0jAAvla3rnbXFltPYiut2KY+qp1Q/AIdN/5v3+bt0znLxAR+9pIwS8vZxOxOxshXLjQ5FOUyxM2apQwS/sObjWFKQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401845; c=relaxed/simple;
	bh=Y8h40+hGzCh1f/VqyHlIyYZ9PFSZTGJrEzS5F3GcZgo=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=hV8Z8FCoYnFM6+HOP9S1cvy/ax56ISE+1TFhjbaFGmHYY6PJCIELqLiobzaclgH0WxUgxtDdLwjLnoINVjEFb6WNYNAaDrUAeEmu+5xWV4bZpWYtAHYoJ4lAQ0jVQ7T+n1xRWXjeUiEP1T65soxh8AAAWQHKD4AUlTBs6eikbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SgmMEbZ0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70cdc91b227so777545b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721401843; x=1722006643; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=UANqZqiDc/hObQEPAeTfbPtjoPREHLRh8wuDH4Ya/0Q=;
        b=SgmMEbZ0F7zXeO8j6NJIlJ5ZEuaALjcpQ0kOBd5EC1BllxKtuW3ULRBDoxomlL/uMq
         tucWo+OtRrDAotcwgmq4dn49AylOTYx+AsuA8EJaa59Yz+FczeLcthCy4sDzPcH3yJAh
         AA9QCDPH+jW7vMSd7RrMOFvKoAdhpC7sPaa3NLhLt4DQWcMbPmQmZSZh6TNOUlxVVvJU
         D0eb8wLCIk/0Om3/5MoJ8gKd6/uOY4d5ZA1VfMRYj5+VWnKTfaTFKwPr5TWOBndafqU9
         sLmtyrPoU19qSB2KITELOQmUv6mi29VJ2TGceclWXnqVWoIRQCppX5Qq1YD7IgnQpxJ4
         M5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721401843; x=1722006643;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UANqZqiDc/hObQEPAeTfbPtjoPREHLRh8wuDH4Ya/0Q=;
        b=o7uCOY6RSQak3SNo8HWIXLzFr8b7SBSzIXZRDBud9IHRin5gpBkBq9ASyhl4eoDZdT
         Xc9kL9eroVTohSkSsmqHQTlaYRJL8H1MTVLBAnXlE8QMM0HAGcOK/jFr9oV3qN2rxLLR
         7kWAK2osvi3KxhNX++UXZxBxYxWLswbmpF2htS5hbAvTqzc1pGDCDVTQHDjC68jinwzE
         tSAzpyuBndHnxmp/iF1JUs83Vfv67MsFCR0jT9OKtlWmVPVGCnLbJ6tBLjkYpGPug688
         XF+XblqLB+iNPh4uoEXVTH+i10fRAwepSoRbA5XrtYNLES3GUTJCaqdV925EhmhkArTu
         6+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVOjGyovYYuX2I4rZMRXNjPapxiEoBT+RzT+N74zuw04xNczsPmgyeEUk3ca6bYfovPM/skIfE35s0GesjDgx/MuxVv9+eU9JL8shmQ
X-Gm-Message-State: AOJu0YyALcrYlQNSyDtXKzBEwjxpfoCXqvQQZlZRaJWYBbIBgs17PNpH
	kHGQKB+JKuHpwmpw6oJGN4fTcgP8ChXGL4frEtfDmlrL+RI4Ejy9tVJv0h3DWYI=
X-Google-Smtp-Source: AGHT+IEeLKc62kfiNIHZ+h+BGwnX8isvcMG21ge0LKswp626EPzjMdKnVDYLrVG7yFcOjbwUcbRqMA==
X-Received: by 2002:a05:6a21:e94:b0:1c4:2151:7276 with SMTP id adf61e73a8af0-1c422857696mr347155637.10.1721401842734;
        Fri, 19 Jul 2024 08:10:42 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f319773sm5915795ad.171.2024.07.19.08.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:10:42 -0700 (PDT)
Subject: [PATCH] clk: T-Head: Disable on 32-bit Targets
Date: Fri, 19 Jul 2024 08:10:27 -0700
Message-ID: <20240719151027.16152-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: mturquette@baylibre.com, jszhang@kernel.org,
  Palmer Dabbelt <palmer@rivosinc.com>, dfustini@tenstorrent.com, frank.li@vivo.com, linux-clk@vger.kernel.org,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: sboyd@kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

This fails to build on 32-bit targets because of a missing __udivdi3.
IIRC the right way to fix that is to avoid the division, but I just want
a tree that builds and the only real T-Head platforms are 64-bit right
now.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/clk/thead/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/thead/Kconfig b/drivers/clk/thead/Kconfig
index 1710d50bf9d4..95e0d9eb965e 100644
--- a/drivers/clk/thead/Kconfig
+++ b/drivers/clk/thead/Kconfig
@@ -3,6 +3,7 @@
 config CLK_THEAD_TH1520_AP
 	bool "T-HEAD TH1520 AP clock support"
 	depends on ARCH_THEAD || COMPILE_TEST
+	depends on 64BIT
 	default ARCH_THEAD
 	select REGMAP_MMIO
 	help
-- 
2.45.2


