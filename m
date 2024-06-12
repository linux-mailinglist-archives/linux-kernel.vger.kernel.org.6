Return-Path: <linux-kernel+bounces-211195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2B3904E53
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C13B25E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B016D4E2;
	Wed, 12 Jun 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="du3fKvOu"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A0B381D4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181655; cv=none; b=VPfNcOr41vM2ka/fB7m4pvpXdqYpAkO8+FC0lcvKh0w4JCjAvMbIZqYJpLn2f9qLU6hvESyfODBAoya2rVs7dQk+GnG1B+rtB6E3WSQMTWtV8h/aYyMHhWUoR7tvtzeZudHdtwkeop5rU56QZ4py96KxILvOA0M6iDVQJRJkGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181655; c=relaxed/simple;
	bh=DRwMk50Q5ZERjqin0kgpH9SsCM8/Ay+il3Ft2/qkOy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vm+i21yADV2fIc3Y0wdBHEa1eYCXNrLspzRX5LEYgc1gP+2nzifKgzux5BiLZs3ekMFTjJZjYdEl4Kzuv55GW2y+BreIDLpplvGuPiJfU9SckgRKrWbI09b7Q7WxDZq8MvN1YLU+N8HkYDDv2xFUQJ3odVq1LWlhoXtqdIAew6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=du3fKvOu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c68c3f8adso2499612a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718181650; x=1718786450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CBqkwyledWDoKomBjA7EooqDlwqm9RQ4FDDh9XT1SX0=;
        b=du3fKvOuWI6z0hGpT7UJBfWWBX11BmfvGtqdL4w//JWWj2y9d0BUVDyGlHPrp+y0GR
         saBsmXaKHaTKFgjNbw3qsFqzRzicW7c5n9LvYkTs8Jk8ICJ0o9OAmxu0g780CvyL3312
         /PkT3+L+6neIFmIpEVXLuN0f4R7r8WjhZs8JnbLi1UD5j4V7nfE1qbflBbtqSFyIVA78
         KyssjsE2ibOfhR909OuZQDRbww3YTp7L1sGkcLjd5FSF99LTVzs2re2bcUbgZtbnVaE/
         bXCRnmfWcQbQU9MvT9Cqnmwf9w4EOYOC6tkpfQCOKaEDVhOCSsR6eCqhKWRV2zaLD99H
         1GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718181650; x=1718786450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBqkwyledWDoKomBjA7EooqDlwqm9RQ4FDDh9XT1SX0=;
        b=unAECjbHO/VJh4mIGeDkuy55qs0DFzSoiLeq2lylzlrUCnRS55YFSQ1Kn4xAWEiMur
         8uY5aqlqzxyuVmicif/RIDofEboDYB6cp8ihRcsIMkd5a0LAG5/0F1NRSiOvpelzJv8r
         c7mt1bGIDd+cGyYAF8FGh/WYijcht3NwD1oQXJp8ZcRujw+Q+DfLlrb3R5I46lg1SVyS
         o+YwQ7TFq8qy2NbpjxLyC6H0BBkt7QspyZ3kTj+hBK02rP7gjEBPdOZlF0JaLsPjD3YT
         SzjanHka2DRES55jIjR4DQNuKAqI0xkhrSolv8mBD7x2BveGkO25MTqVfJKhFJvIHu1z
         EKMg==
X-Forwarded-Encrypted: i=1; AJvYcCW01ifR5MjRFHY0A08yATPPsIj7tTCSispMc1QfW9JR9N9VA4CC0JT5aKvvcsGGrbWei0yVhPGUwPb/nNueSSmjma/2xvCknIGf9UwA
X-Gm-Message-State: AOJu0YxYxxMS4lgsw76Jfv/Jq4TALUytikYgw1DmZhoHNHm1z9MEsTq/
	wlqfJZYM6m/6WncsR4fRWzr+tbmN4WH7/eVN+eUrATLPGXqK/AE7N5G6xOPWeeU=
X-Google-Smtp-Source: AGHT+IH75PTOT0paPjqMnY/iJPs4xleR7i4cuMCQyz5XdUYS9YsW2cY6K59sOro/O50yc1412ToTQA==
X-Received: by 2002:a17:907:86a5:b0:a6f:4c90:7958 with SMTP id a640c23a62f3a-a6f4c907d27mr35442666b.12.1718181649661;
        Wed, 12 Jun 2024 01:40:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efbcc252esm604812366b.143.2024.06.12.01.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:40:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	arm@kernel.org,
	soc@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	=?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 1/2] =?UTF-8?q?ti:=20omap:=20MAINTAINERS:=20move=20Beno?= =?UTF-8?q?=C3=AEt=20Cousson=20to=20CREDITS?=
Date: Wed, 12 Jun 2024 10:40:37 +0200
Message-ID: <20240612084038.18519-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Last email from Benoît Cousson was in 2014 [1], so remove him from
maintainers of the TI OMAP platform.  Stale maintainer entries hide
information whether subsystem needs help, has a bus-factor or is even
orphaned.

Benoît Cousson, thank you for TI OMAP contributions and maintenance.

[1] https://lore.kernel.org/all/?q=f%3Abcousson%40baylibre.com

Acked-by: Benoît Cousson <bcousson@baylibre.com>
Cc: Benoît Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Arnd, Olof,
Can you take these two directly?

Changes in v2:
1. Just add tag.
---
 CREDITS     | 5 +++++
 MAINTAINERS | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index 8446e60cb78a..2721aa9122bb 100644
--- a/CREDITS
+++ b/CREDITS
@@ -796,6 +796,11 @@ E: luisfcorreia@gmail.com
 D: Ralink rt2x00 WLAN driver
 S: Belas, Portugal
 
+N: Benoît Cousson
+E: bcousson@baylibre.com
+D: TI OMAP Devicetree platforms
+D: TI OMAP HWMOD boards
+
 N: Alan Cox
 W: http://www.linux.org.uk/diary/
 D: Linux Networking (0.99.10->2.0.29)
diff --git a/MAINTAINERS b/MAINTAINERS
index 0ab2fbd8b6e8..0a2c9163933a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16374,7 +16374,6 @@ S:	Maintained
 F:	arch/arm/*omap*/*clock*
 
 OMAP DEVICE TREE SUPPORT
-M:	Benoît Cousson <bcousson@baylibre.com>
 M:	Tony Lindgren <tony@atomide.com>
 L:	linux-omap@vger.kernel.org
 L:	devicetree@vger.kernel.org
@@ -16429,7 +16428,6 @@ S:	Maintained
 F:	arch/arm/mach-omap2/omap_hwmod*data*
 
 OMAP HWMOD SUPPORT
-M:	Benoît Cousson <bcousson@baylibre.com>
 M:	Paul Walmsley <paul@pwsan.com>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
-- 
2.43.0


