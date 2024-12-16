Return-Path: <linux-kernel+bounces-446646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7109F2783
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB94164DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC7D6116;
	Mon, 16 Dec 2024 00:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="e+WHU635"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21342256E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734309102; cv=none; b=Vn2tH9tm7O5d6ivTEkfcMM17gP+xLPlAv0HVbvbAcabpKhp4BizM60EuloafSBSBVFeifxRc01Yt0M2EDg1WiQnKiD+woXSOzufAqeiCYVwSdo1b8NOtQJKJ6j2DM/YRxZaWU9kHxcSyeDbL9GQbO1PecmVaIEZjJDbJCvnfcFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734309102; c=relaxed/simple;
	bh=OIESOetAwuLECZztjcPNDr7X4k2Z3mmW068BNVz+9Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QKUMqv7AZlPXZ9hK2+1K2DBIlkfHjpnmt85et3OQ2ndzmmoorW7orP32pwEPNviOgIc2/ut1p49/Q0Akfpf528KiOy1ZYtAuKqyHYh9cNVH+QPX9xhnf8/8gIaRRgtHQ8X8x/Cpf7dLQs1ujFbohqqdFfopT4+bPGc0tUX5ZLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=e+WHU635; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so2651613a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 16:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1734309100; x=1734913900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wjgf63X56bGGjXplIZClf8v63m4wUGZdNsKWrwYGmwQ=;
        b=e+WHU635kPDSzTjnlNHxFo49Kp7rk5oAINnH+Bf8LK2b75/wUeDeWDH1od72OzgQPa
         XzIFOvbFYkf+PHd+HdIxPQsFGX7IotqhE+PxUgPV7o7k4gdiEDcGf/4wQ8+hVH7VtKZL
         KtKnwYSKxQGP2rsDWd0wFsbdh8Vl+Gdz4Y3l4sGgkTGWuV5L4E7hxKu03aRptI18/H0+
         pQbiucIpi7m8YB+bEO4TqmFfH+CQDJ+5exbtZh53mbfYHDxNJRR/LP/B4ifKK/TQzVQ1
         E+nFfToCfIWY494L734eKk3qatY3fXyT0srMCXmxv71bNG73uhXuLFRxIegrNbH4XXxt
         k3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734309100; x=1734913900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wjgf63X56bGGjXplIZClf8v63m4wUGZdNsKWrwYGmwQ=;
        b=qu8vdp9NkswctiklZnuC1Jckk05hHRQx1s6CMpo172ApQywe0o4dqsplLa2N2aJ89M
         slN0cWLBfRER6grJ32poQ/2/3chWVIv0x3RGO1XWfbmdvyFyovEl7raUj0WkC5C9wGVk
         A6TP2wM1dFjZ0nYxL13MBCgMdKyZRiIe4g62iJrbUQzwWyyCFrmmwqYikl4qjt0Odlrw
         mwgwUhi2QhlPFazhcBPVPWo+I5HFWbbJk6U8xkoB8CUwAu3F9fpNIFHZXASbVWlzxufF
         QcdzggSuQuUYs2/JddWGRioB85EH18JZUfLNTR8uO9Tq/L8Qut+wiAxOtBbe8ZDfnUOJ
         7zhg==
X-Forwarded-Encrypted: i=1; AJvYcCW7LY7+GPYk/jTeSgUAGUBY1e3JpWjpJnjzUU0AmH0ZG4uH2mWdFnMle1pPENaARhUrnnE/XwvQUlJYHMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhB5gX5s6N5SCiTJg2JNTBjnGsM7k4Oma3+wI7nj8j5wJUv4A5
	cYfxYGd/bH8ZpwdE0LbUu773SljN9icuSsbsPj0gDdb+YgPTZACe0Nv5WoQrl3o=
X-Gm-Gg: ASbGncvGC9IFthckRtv8msc1ipoYJlyImI7pUAvtNO+tg5NgP3bJcktkFFwGIohufFZ
	b2iWokbAoZxcYz7nsPKm6XtTLekMJDvNSYPQPie3p7ReT0f0H/V3ww6lrfjQD0Vx7zbztT2I9NQ
	lP/hJMxD+3XNA5x0I+5G5XX/YDpaoEDHNbXsJXCdtCBvMXgYK1LDLl6HNw+e1K3ZAlKzzTqdJ2j
	PkVpZ0K1epybnsoqcy/A+HtdEJ4hdMbep/riRhh6XQUVB6DU9ID/9XAg3f96tkvIrLFHx2XPK4a
	73NMPGta5zFj
X-Google-Smtp-Source: AGHT+IE6hWu/AiGUMcCIzE+Djl5ZsvZivICvhS5bLKVYfQP3DTp8yAD9VUpIONRzJAvAK5ShHk2dUQ==
X-Received: by 2002:a17:90b:51d0:b0:2ee:3fa7:ef4d with SMTP id 98e67ed59e1d1-2f28ffa7db3mr16665936a91.24.1734309100191;
        Sun, 15 Dec 2024 16:31:40 -0800 (PST)
Received: from x1.tailc1103.ts.net (75-164-218-15.ptld.qwest.net. [75.164.218.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142de3403sm6826614a91.26.2024.12.15.16.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 16:31:39 -0800 (PST)
From: Drew Fustini <drew@pdp7.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Drew Fustini <drew@pdp7.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yangyu Chen <cyy@cyyself.name>,
	Anup Patel <apatel@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [RESEND][PATCH] riscv: defconfig: enable pinctrl and dwmac support for TH1520
Date: Sun, 15 Dec 2024 16:31:15 -0800
Message-Id: <20241216003114.326129-1-drew@pdp7.com>
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

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Drew Fustini <drew@pdp7.com>
---
I am resending this patch since it has been about a month. It is still
listed in patchwork in the "new" state:
https://patchwork.kernel.org/project/linux-riscv/patch/20241113184333.829716-1-drew@pdp7.com/

 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index b4a37345703e..d26e670404b6 100644
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
+CONFIG_DWMAC_THEAD=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
-- 
2.34.1


