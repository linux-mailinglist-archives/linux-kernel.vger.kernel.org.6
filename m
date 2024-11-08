Return-Path: <linux-kernel+bounces-401750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA8D9C1EB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE96E1C20A8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB3E1F4274;
	Fri,  8 Nov 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="qkQu+86e"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837921EF0B9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074343; cv=none; b=NwjXTzQ4ML+m+5ycM83K09ya6lhcmeulN9USWxW+tC4/y144Shlx8LO4O/V+J8GIQXWc1FSo8KqBoIjIHbdbbKaYhYUXzcpFDTdgKcfQrqSEen7RI+audYtPVG6fMi2Uy+8SnBWHF3TWa752mpt89G35Sp/0w0IDuLkYsxADuKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074343; c=relaxed/simple;
	bh=mAPRkq8mcGAitqZ2NJPZs4WYcWRS92IxYDvqOFLptL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P06ntmtbNu0A6sTXTCa9zNhdF1w+X1MnBTPx0zGec6b4K6+U3vm0ygApMu3wGETFzGKbhj/3AyW/wdrHgB8XZp3sD+Ka/iK7K59b4274kgOBnR+e+U4Uvpc+UvmPB+VP9u9Q/1gbMCcUmwpKaWaaWvGrKu76O376yWJ8ayeYl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=qkQu+86e; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so1304185f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 05:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731074340; x=1731679140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1w6RpVPZFLgX8W7zDDIW9Bt9wUWPJmCNFHj/06iwgR0=;
        b=qkQu+86eglnwUU9e8q9m+yhXyGghSfSZTooQfBRXhxgUsdjODQsxDdcLCDyrBk3AeM
         3mnA0Jhj6/iFBSiVQ1E3C7XQYppjfAFuTL48w9U+H3wSqVgyu4ofF2QpzgWcFAPO3rIK
         4uR5gchkf1dB7Eciy3rD/PUCaeCZzc7aoiwvjkVitFWMbMmKDmQsrvwXiZZVq/+x+ANV
         pCqGWzUUZrJcLBV7Wi4trPZk14Kw1i93WJOgLI0ljveiKdSEaRUc6iUL3DGZj1Qhg0ml
         MxWDAcwxLFq/leG7aYfHMfRKvr1NRasFROur0x2EIqBbYVeMCzNKfuTRP5NXzAlkQH8J
         o/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731074340; x=1731679140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1w6RpVPZFLgX8W7zDDIW9Bt9wUWPJmCNFHj/06iwgR0=;
        b=hPKcO5ucKp7Te22da1bac48/rNkw52ttND6lEgvF3gyKckoxkZwj9garWY8y1RC73c
         u75QdSp8aE0pYOHp8hYdM+DDA/gCpSAnXAfsfsx9VjKCg8kkCDDUSdW1GBElRTIebbwp
         xkGGAyKtkibNPUXhuXTYyv1FXgje+5T8AIbDQFsdemfsHV95X8K8vEwhpYGm1cfYWtlW
         g9zU7uf9zMi1IpNWh/MosMcanX51Mr59mEh3EGOhRWbm4NzTfSJeGYD2VjtK+mNEso3n
         EoJGxnSe/v9GsZYU6r7zWmD0yDlfJSeDS62IM5TN295xv8Od7ImdB4aIV5xfe/8w7kS9
         8PmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd4beGQACqSXtXn1ZJLVBR1h9PhDPtyNt1hEWHknINRI+jwz6hEzaBGLkJEpqZKSe684rPtEgm8yLt8Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYc6Mg2zCD+Acbk9JNYjEAJrSCOY+LTBbJMDbiJuyWESRneW2I
	5hutd5N7rUl+YCY8Vw5WJns07naSJmUnS/xBtrLAb1h1Mud8Dxrhwp326FCbhl0=
X-Google-Smtp-Source: AGHT+IE+nAqhwysBWUwaiDHL8021dYLt45cexYtLiP8CXTNVID4kP6yjzuHQfUBix0HKH4CQF1DrWg==
X-Received: by 2002:a5d:6d06:0:b0:37d:45ad:8394 with SMTP id ffacd0b85a97d-381f1866bb5mr2611022f8f.15.1731074339782;
        Fri, 08 Nov 2024 05:58:59 -0800 (PST)
Received: from fedora.. (cpe-188-129-46-99.dynamic.amis.hr. [188.129.46.99])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed97cd97sm4924431f8f.27.2024.11.08.05.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:58:59 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 2/4] clk: lan966x: make it selectable for ARCH_LAN969X
Date: Fri,  8 Nov 2024 14:57:32 +0100
Message-ID: <20241108135855.129116-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108135855.129116-1-robert.marko@sartura.hr>
References: <20241108135855.129116-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the same LAN966x clock driver so make it selectable for
ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index ef709327cba1..713573b6c86c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -270,7 +270,7 @@ config COMMON_CLK_LAN966X
 	tristate "Generic Clock Controller driver for LAN966X SoC"
 	depends on HAS_IOMEM
 	depends on OF
-	depends on SOC_LAN966 || COMPILE_TEST
+	depends on SOC_LAN966 || ARCH_LAN969X || COMPILE_TEST
 	help
 	  This driver provides support for Generic Clock Controller(GCK) on
 	  LAN966X SoC. GCK generates and supplies clock to various peripherals
-- 
2.47.0


