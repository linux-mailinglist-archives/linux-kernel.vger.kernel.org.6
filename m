Return-Path: <linux-kernel+bounces-183470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5318C9972
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4A2280CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE561BF3A;
	Mon, 20 May 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PopMMAVy"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170A1B7F7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190887; cv=none; b=PuARbkQ5tVodXVvi33U+5Z+b2R8LZRVX9crS1JFAo/2WsnN+101DjRDkk+zi1JBGTzTq4YKgyZEj+zrysOkA0zT3k92xQK9PNfnfgXmHSEb11Q5BNE7I/DWPs+JiVboML5nM9F3jJDpEoQXRe9ZKqL3K2aibhQi8C3AjJvS7Yuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190887; c=relaxed/simple;
	bh=plzvp7rNugX3K6ANyXjr92sRX1YWIuJEC3UHm68SOb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VJ4JMhecvpxOiWcAlYc6kZno4TvmDEHYF58UZaCupZ5QDjhVq7VWSeS2Cc0PTpoZGqnogS+QHzAc3dQ8L+KN0RLjPl0HaVArImljbg8r3ILU6PpwmZIDND6GEDzvKZGa3JgnvLWWMZI7XKmthNW+suetROJVBduxqichlgvIvos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PopMMAVy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59c0a6415fso728134266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 00:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716190883; x=1716795683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9y2+R5Z+lMlXgJtdu7Zc9o7DnmU5CSj/l6XtGSHRsxY=;
        b=PopMMAVyZIXgyz5xm/mDb3uJeyXYybjA4txKywJB7MaIZDlwvt7R53tzFR5qZhuvQX
         NdiJpoD7UM7DFTu3sZNoEd7g3/hJUOoBD/HCx0wHV0T/O0egtl24CAk9byQPvzE+L3+6
         cxtmsXoBqQDGLveolFYZvOiLDVFCrmD2Ez+QgeqjMIn5KOUEcwXX4oxoU2wj7wdvCOwE
         03GkKcafd5pk9pfKTXZr01s12MqW7gUzznAlv2M1npuZ4XtDaa0fHpsETS3CNEiDlGtj
         PZoJFRCbLhPqwV5bxfXULmt7bz9yLs/eiFbxKg6RWn+djnKBSLGfGf80eGBcJ+/p5RLZ
         nS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716190883; x=1716795683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9y2+R5Z+lMlXgJtdu7Zc9o7DnmU5CSj/l6XtGSHRsxY=;
        b=rSznVw6iayYU5sayYXGfwPBUBmdoQo8/lw2JcIaGxJBXZ3uqiggP0UwDm0iMauRVoE
         ZCmtDwhVz9AP/GXSZMXKlXxkZWsAyFHiEMFXczwRCj4gkxewBvluMuKLLggxD6O6lTT2
         RF2k/eZj1qmpPWjG565bSD5RKVJIOQqO8LBZ0+xczYeJOE952Oc31a42hOs3vib9Jyzv
         /+WRsbuLnhuglWY+nr6cjg7Pm9Itcc8RSq3T27VANU5qMcbelrdOEyHeB7Ixo36pfJfV
         QvhyY4AU46OYrMPbv6CpEXKjB86vdtJxdKXoowEZK+rDJ4olYH7SowYWRwQ/uFSB9Q2w
         7yQg==
X-Forwarded-Encrypted: i=1; AJvYcCXEnvSFQ63HrHAQUyL8c5ld4kQGZ/T85YvuVbrOFJbb6c5IJY/ktqYBiV8x64HBUlZqcWAmDT/WDHv3JHnUInrP0hjFv7KkXMAJ5Lej
X-Gm-Message-State: AOJu0YyqK2uQTAlb+SrsFSfs6wtlIgdOl6RK4BVBwsGD1Bt7ahRmKebo
	tK08PpPQcE0/HcQE2LsFCOc+04/OBUCu6xDpgtuOWURLp3bFg4FLfecMeWsPyEw=
X-Google-Smtp-Source: AGHT+IH9haA9iR4YwoKX0PzjzpCIy5yTTINDqwVFObjzHq50kZ9iLXtPJQM9TPGv9QNsFnHhLLi5EQ==
X-Received: by 2002:a17:906:6a02:b0:a5a:7c7e:a0d3 with SMTP id a640c23a62f3a-a5a7c7ea16fmr1445195766b.44.1716190883404;
        Mon, 20 May 2024 00:41:23 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a893a91b9sm754853166b.7.2024.05.20.00.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 00:41:22 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	arm@kernel.org,
	soc@kernel.org,
	Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] =?UTF-8?q?ti:=20omap:=20MAINTAINERS:=20move=20Beno?= =?UTF-8?q?=C3=AEt=20Cousson=20to=20CREDITS?=
Date: Mon, 20 May 2024 09:40:12 +0200
Message-ID: <20240520074013.9672-1-krzysztof.kozlowski@linaro.org>
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 CREDITS     | 5 +++++
 MAINTAINERS | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index 0107047f807b..ea84fb373310 100644
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
index a482f2a499e4..8193bd95c84c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16147,7 +16147,6 @@ S:	Maintained
 F:	arch/arm/*omap*/*clock*
 
 OMAP DEVICE TREE SUPPORT
-M:	Benoît Cousson <bcousson@baylibre.com>
 M:	Tony Lindgren <tony@atomide.com>
 L:	linux-omap@vger.kernel.org
 L:	devicetree@vger.kernel.org
@@ -16202,7 +16201,6 @@ S:	Maintained
 F:	arch/arm/mach-omap2/omap_hwmod*data*
 
 OMAP HWMOD SUPPORT
-M:	Benoît Cousson <bcousson@baylibre.com>
 M:	Paul Walmsley <paul@pwsan.com>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
-- 
2.43.0


