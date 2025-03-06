Return-Path: <linux-kernel+bounces-548646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7E8A54777
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AE0172115
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80A5200B9C;
	Thu,  6 Mar 2025 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FejN7/Xj"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D119DF49
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256093; cv=none; b=ncQFVt9vtY/pN+VbdGVey96/Qudzi4ZBOBXCkQOALFXU4lQcmeQ5JwnXS15+ph5x40SNOZkhnLI4gx9u2XfJoXti2xjGUrC35CX0HjZClK1m4E7OqicrKcLzy516PAI8xt1IQ1RWvzIzhBhhedUHUGcf0ZN3PvoPbMLT9V+3Lbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256093; c=relaxed/simple;
	bh=zZ5zRPaBf5NaYRVFcYpDRW4Giwj9aHf2bI/tXWWPQGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wy5R86XHff90Me+UTo6kXxZoUALyxbbIpgAfbqy5sbY1VIoFeoyX8iWvW1NN6dYK2lxrzlbmLPd6RXOBsuVPYh8S9QAsTYeOHjFgoTwNWp+pNXR241OK2izMDYKmV3X9xJbaLKns/5x3LEIXSjho9C3sS4bJyYXHIR5KtQu9/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FejN7/Xj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so792803a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741256089; x=1741860889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTX2x3w2+rrqKrzKo+38sY9i/3t1a9Grj2c0VzKk3Q8=;
        b=FejN7/XjiXAYXgr9oe/+HXlxHroGXXNbDazRWX1gsLEUp7hH7aiZXETq4yYepQe03A
         oTqqMbOcN0ovsfxuwPrK+3lFtC4QDeTjUlzOX13ub9AWubLK9u70w5i8i2BlzJJ2X9u2
         D95X9QseotoUPF5UI6U61W323dGaz/Hrfs0cYcfnRBx/awwR8e6gOlz2ruNuy6OXMGr+
         azes7xL0y1YnjNt+m5xL8V3SttT9F0Wxghs3DDgljVvN4k3+egduRB4i6k4qXIZLqd4H
         GfP5dHKTMKjODZvi3G5GLBcStmgOjGnk1FIbGqwAoF9CbY7XkqDWDAiwwa8RqO6SLJX3
         ieVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256089; x=1741860889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTX2x3w2+rrqKrzKo+38sY9i/3t1a9Grj2c0VzKk3Q8=;
        b=b1PSztR2tR3Zzw8pQVsllHL/aX7agRzl6XWcctMavOyqeOLb6tTU+9D0b3LlTL8szg
         kdzYx+3rmRhCJEr1+WbjyC6EU1uvaCErta0/jA5AJh7fWdhrw9vVlPI++j1aT//c+gyP
         daqSiKM0cgUVLg7lwmF6opbpFmrUzfGlhLoYw81eMmfXpUIq0l0bX8i9vunCZLILQEOM
         ekkwmtYYFYLKKFKcTd7R75hI2S1XDf0q5jP7Pp+hQWrunzC1yzNYNPqpqLgRGE8TabOb
         DOzF5z7ewpkU12A/tXJShxHxQk8updpT1C/454M/ezKV5w1ON93BlJXYoQm1axSaksdd
         EXIw==
X-Forwarded-Encrypted: i=1; AJvYcCXJRa0PySAR3VhJH9Sa7JL4XdnA1qKJROw0Uhc03nZr2P+BpSR62aOiXro9OXRx1JieEvBlazMQRQJMFkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NTGW6F8QM5feoO1C1mH18OQbez1hp5vQgqGOqlj2MHG+6ULE
	1lizzxhY2iGYZKkMCGR9+xjAqLWGZlwnXGu2iCu8in3id+VQk1Fmq9zbEvppJQU=
X-Gm-Gg: ASbGncttq4Pp/3el26+qr4pZYg1rLMHbQ7sb/1nYhLsFiWwSQzx+qTTDn+scpRajMoy
	yaytt7+CVUdsaWiEL54XfwJMxPzdVtQJrnaVQij5KHd3Lvt+Jjy0jg1dcIl51/ssSfRiLCKpZBJ
	nZC80NQD6x7mt9ijEWcJz3JDIjWMhfrLjdqrUsRiRCPviqzq/AhzwOwi5o5dFNDnMp+4a2wan/T
	GDXPrZIl8bVH5o5q26Oj+aZmq6ydx7LYU8h5yvHmt9/9QjQ+LgMSa/on6UDLuNGOMhlXcEw57YX
	eWoWe2kwdtt6gM7vq/sPwHvcAz+PbYFCceeaMQiH6BUkQwfLs4fyb/E4WxfxsZOAVOrJ3aKKuwj
	xvam7X/NeET+IE637mkzqnT7ciwCe
X-Google-Smtp-Source: AGHT+IE/o3v5XJFu7xvLRW9BZC3NmMkBoh78OMt+bw+ZmwbbxHMBjWL9+2GSNHmM24JOepTrXIj9dg==
X-Received: by 2002:a05:6402:3902:b0:5e5:b3cb:38aa with SMTP id 4fb4d7f45d1cf-5e5b3cb3c80mr4508256a12.25.1741256089661;
        Thu, 06 Mar 2025 02:14:49 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a6af7sm708972a12.33.2025.03.06.02.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:14:49 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 06 Mar 2025 10:14:46 +0000
Subject: [PATCH 1/3] arm64: defconfig: enable Maxim max77759 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250306-b4-max77759-mfd-dts-v1-1-9fe8b0eb8123@linaro.org>
References: <20250306-b4-max77759-mfd-dts-v1-0-9fe8b0eb8123@linaro.org>
In-Reply-To: <20250306-b4-max77759-mfd-dts-v1-0-9fe8b0eb8123@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Enable the Maxim max77759 as this is used by the gs101-oriole and
gs101-raven (Google Pixel 6 and Pixel 6 Pro) boards,

The child devices' defaults are based on this MFD driver's state, so
this commit enables those implicitly as well.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a1cc3814b09b31ee659536a64b7db704153d6fe9..eaa88c3e6a93ce555468458763c2531fee2a903f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -763,6 +763,7 @@ CONFIG_MFD_EXYNOS_LPASS=m
 CONFIG_MFD_HI6421_PMIC=y
 CONFIG_MFD_HI655X_PMIC=y
 CONFIG_MFD_MAX77620=y
+CONFIG_MFD_MAX77759=m
 CONFIG_MFD_MT6360=y
 CONFIG_MFD_MT6397=y
 CONFIG_MFD_SPMI_PMIC=y

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


