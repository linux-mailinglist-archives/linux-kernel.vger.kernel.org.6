Return-Path: <linux-kernel+bounces-364733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B632499D892
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9831F2196B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1251D1726;
	Mon, 14 Oct 2024 20:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="tFnkTz98"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496991D14FF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939266; cv=none; b=Ply9ufjs0lJp9AP1JqGXZICm64DugGMQdq0bN/sHC7ZLhgc/mpb+2AbDhu1nJWVmDUeYmcTe5b4Qghbr14S7uVnkvIEkrJ/DmuXwWkAHHO74wIP6ed07l/eN4/HrDgYqsezP4cHo2oqEBwu7PdBRmcLTQKpkZsBlSJj71penurw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939266; c=relaxed/simple;
	bh=ecwCNyY08pw4NyGI13qICJ21vTpSZg1pUCkauZBQgyM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=EZA4pcVP5yTHsOQ2KsPyKSK1oo0P0g2rEcty1RU4OreHZX3bxjEPc2+KIy8j9QLZU4Uv8F1fe8RgvjnMGEFGh+YRBeFjAq0vKOxD5U70+ME1Ouoi+x7KarymT5Mwhs0j8Ujxn82ssWWBkr6ebstb3/BQVGgcLxb89tHjgnFX0Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=tFnkTz98; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so1098103a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1728939263; x=1729544063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=upBIwmLVEKrYA/8mpgHqplBGbXrpIDV9EVYbTEhbDSc=;
        b=tFnkTz982ZJtngZfcYhN6IexLp6clTut9o8ScB3KJzdPVp6l6CJKUTY+rr5sRr0VAx
         K8OA7JBoADz8Sl8CZcUnoJkZiWw67ycKKefcWe3U95TBoygHwos/P/a8hrWGD8oyec3I
         D7X0GIFKqWkh4V+gtveAfY59leAaGJyDqHxu+QvTRlt3/fih6eA0Do8btBD95YPIBKgR
         QOQUXiraleYFvBoNNBDU8Y80R1T/ictCnno9SptQrqHWdN1LAL6sRSQvEq1LT8yvaatp
         LPLY9RMZC+A9rPyRLjJ2r9T4zDkB4srV+8TG7CoTtSR2pCim29DGBXxCITY41k0vighs
         8d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728939263; x=1729544063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upBIwmLVEKrYA/8mpgHqplBGbXrpIDV9EVYbTEhbDSc=;
        b=WR4piB2WpD60ocHpN0VU32Op8gxSKe4h2gQCYPjC1FREHiIbo8Q0I2KKLiT963/4ud
         4WOjnLXF9KRcV2+f+PLYqkQPlrTmvN02KS37Ajx2fpAMJa8c9h7K8T2EejE5AgnbZ/+a
         0aUwkaRdJlbIlNpubM9a3wfmQqZO2YEIuqL4EfI9akVEpW1teeOd5FJAYEfLeyCWAr7m
         qEguwVbLIOQwRGeWs715jitDW8lImN+lP58LPKOCKO0hSa+rRsoP6d02x2toNcsa+qQv
         bkD159vUSgM0KXGN7d6uZ5McgkhybY3/prmcGpoZq+vbNjo1dwHmNMkk0BvqXyTlBZZh
         Fbqw==
X-Forwarded-Encrypted: i=1; AJvYcCWsvjFd/piZDYVPgF0gA6WNTjnT/Q3NoCy62InJvRr2x/1glCM4ssl4sxJEgB9JLWzmQ2HCgBh+lW1k5Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26xseVVyZ4R0YQKb6BHLFPBs9LYv7oK+vdbkKjLVmzHLbBAEd
	MFyLYCKIosdiVZ8lCFVYE9oicfabKsu8bRPbfxItf+mob86Tj3e4Zw9MSJKClpg=
X-Google-Smtp-Source: AGHT+IFHzS+dJQbp8kc2lCYA4RjGEvgxYJIfozZyGXFfM/lJ8tRvHTCm9spf7yg8DFMCiQPoDUFa9A==
X-Received: by 2002:a05:6a21:9cca:b0:1cf:451f:4624 with SMTP id adf61e73a8af0-1d8c95d5594mr15722713637.21.1728939263331;
        Mon, 14 Oct 2024 13:54:23 -0700 (PDT)
Received: from thelio.. (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e59aa9917sm3845277b3a.135.2024.10.14.13.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:54:22 -0700 (PDT)
From: Drew Fustini <drew@pdp7.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Drew Fustini <drew@pdp7.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: defconfig: enable gpio support for TH1520
Date: Mon, 14 Oct 2024 13:53:15 -0700
Message-Id: <20241014205315.1349391-1-drew@pdp7.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable gpio-dwapb driver which is used by TH1520-based boards like the
BeagleV Ahead and the Sipeed LicheePi 4A.

Signed-off-by: Drew Fustini <drew@pdp7.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 2341393cfac1..cfc887a7243d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -167,6 +167,7 @@ CONFIG_PINCTRL_SOPHGO_CV1800B=y
 CONFIG_PINCTRL_SOPHGO_CV1812H=y
 CONFIG_PINCTRL_SOPHGO_SG2000=y
 CONFIG_PINCTRL_SOPHGO_SG2002=y
+CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_SIFIVE=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_SENSORS_SFCTEMP=m
-- 
2.40.1


