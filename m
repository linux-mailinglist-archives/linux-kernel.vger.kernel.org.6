Return-Path: <linux-kernel+bounces-563111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F04A63715
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C0C7A5850
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59321FF1A0;
	Sun, 16 Mar 2025 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Djz/jjHc"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDDD1F755E;
	Sun, 16 Mar 2025 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742151413; cv=none; b=FqyeQzHMK4dHE9J//B1F2sJPotE6LNOVyx8RPBbJT6hy1+yWgl08+AIko5itE+wUP6kerHXOc/yBebedbrbiTnfVW/m1pD8VAaJpIGQtq6PU9o2E4fP691t6baIyBNfdMdUBKzTvp3F5VKfO15mtxkUNUFWLz3zf4v2PL9WOXVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742151413; c=relaxed/simple;
	bh=X0fjjZ/L5GK/kteVD4gJY36Hx8xP0KlfE2Bq6S2LLzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoRlQiWMJUukwSUVWUUvADBVV05hOe8kBNVOhQKXOSVamMfV7/229BgRjYrNQiV1cobkqHZjDNimlw144/EvUow6twXLb6SPmG8H3icCJNFniuLK7plIqbsjFKz8TVMwlSmPtaDtz3CfSd23skVeFdGIhNG6a8U/utvuiFcNlvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Djz/jjHc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so2340483f8f.2;
        Sun, 16 Mar 2025 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742151410; x=1742756210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ileqFVBRvtJdVr8tErJr7A3nzPzqi0Kezboo4Q441CI=;
        b=Djz/jjHc4KmNziRVcGP3Geu8Hlrj90VWRsQRiDU9+GR/lbisWE3+gKvNs4BjAd/p5H
         PtllATxhX9DmGG05MUsUcoS8+wntvi47ZGPcuHhwc5puRO9TvQyPTsKxAzCZk1EUwefn
         crKnO8eYAq3CsaPGC5GPgI/x5itRBZx2nNYJforUDS2b+IkFeg/fFOAnNnoSpp2RYpj9
         +EkyG790AvtCagplZRC2vR+APkOzo/oSm/Z/BvaWN3wHMgOkVJMj2inpnk51AlYH13mc
         hhHsea7EQxOOdYqnZIH9F6oHn9fYDdRvjfdMclYKuzjCTuGY6k9Xz+7e6qcfnt5cPeD0
         VGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742151410; x=1742756210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ileqFVBRvtJdVr8tErJr7A3nzPzqi0Kezboo4Q441CI=;
        b=qteLJja+2m/k04V6zmaNgfBD5QeBgkSU4JtQp+5/E+VVH5cuiZ+39Amz3t4kd8mWH7
         1Ucyjp3nWB6l7WLTGBQ9O+048yFTnSOntDnea3O5ITrbBO0amGLAvZ9p/iPNrba8FaOg
         ZCb7nSrl1R+PCiUMqeGyoDlE9L63xq7ZtYC4jQWik/xn06OZ17Kqx4GhZuXIPs3j2995
         190gbDU0u8KCfbJ4SR2045hNBzTTsG2oSvRj9L7rqg2SMxppo7kfNlAj0HUMDGYIoe+K
         gHa5uW4CXlLvIHKkUcaCpN+B6VxEdzOdnJAHT66TXVjBsNds+1nUF1+cT47w5rN+i6EB
         N05g==
X-Forwarded-Encrypted: i=1; AJvYcCVlD6E6UZwbUO5WOzpIeafW9cYTJ/4iT/jsJ9tPtbUJ6s3dHVeJxUD1atsgu3kb3TkN1/1wRAbKe6rh@vger.kernel.org, AJvYcCWutzlTdusCuuxyLxm5vBy2Z/2iklVG42RIrrqY4NncQsyA0TDMqbWD2354Z/mdBci8EIP6qKsUIX0ioF8T@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OnQmzh0LfVBdXV3bUnXHLkc4Z6DhHGqy0wFcM2Lqd745NOMK
	005VTR5isnXWqwhmQGD9Vrkoezk3w+AUl4d3J8jjH5GZqCQBBz8Q
X-Gm-Gg: ASbGncuJ2BClI7H9Ga8qKZMIm0eJXJpuwVjdt2bw6nQUJ4iE3+o8KDbUQJSJnEbSEUG
	upfvCbshIW9F9hUaG4KjyFkFVYPMA+VYjYmLpEpTPBCgtLf7PbBXd5Sif+VElkaDhfcL4+QEDHa
	8ws5HfEqWxZ+Jg2jznWLiTv0GcfDQRjvceM3Ul/SMiCdlXBARTtd4T8KUlD+HcIhQP0/zVA0QPI
	zvxd6j2KdpnSWlK/8IJdhhT9htf6qTGeUYVui+0+SPcTS96ssRHmO+BPXhl3AoDQRZqOIpGhJgh
	DRZKJDHHBd9raqWQqMzRHptypecEn+ko7RBp3161jw6T11+IqUE3npBUfg==
X-Google-Smtp-Source: AGHT+IHJ26+oZrdKRblSpHUYREjiIopohAi7e4Zi8nHStB+4J8T3y+CCblGsR2BG4HwURzM96IZoaw==
X-Received: by 2002:a05:6000:18ac:b0:390:f9d0:5e4 with SMTP id ffacd0b85a97d-3971d9f0e26mr10803759f8f.21.1742151409707;
        Sun, 16 Mar 2025 11:56:49 -0700 (PDT)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb6292sm84692335e9.1.2025.03.16.11.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:56:49 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: sophgo@lists.linux.dev,
	soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 6/7] arm64: Add SOPHGO SOC family Kconfig support
Date: Sun, 16 Mar 2025 19:56:36 +0100
Message-ID: <20250316185640.3750873-7-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
References: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First user will be Aarch64 core within SG2000 SoC.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v5:
v4:
v3:
v2:
- shortened the help message (mirrored from RiscV ARCH now);
- select ARCH_HAS_RESET_CONTROLLER instead of RESET_CONTROLLER;
- moved CLK_SOPHGO_CV1800 selection into defconfig;

 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 8b76821f190f..af74bcc3c861 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -307,6 +307,12 @@ config ARCH_INTEL_SOCFPGA
 	  Stratix 10 (ex. Altera), Stratix10 Software Virtual Platform,
 	  Agilex and eASIC N5X.
 
+config ARCH_SOPHGO
+	bool "Sophgo SoCs"
+	select ARCH_HAS_RESET_CONTROLLER
+	help
+	  This enables support for Sophgo SoC platform hardware.
+
 config ARCH_STM32
 	bool "STMicroelectronics STM32 SoC Family"
 	select GPIOLIB
-- 
2.48.1


