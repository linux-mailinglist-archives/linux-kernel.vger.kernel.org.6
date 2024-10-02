Return-Path: <linux-kernel+bounces-347395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3302298D21C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4795283FF6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B208D1E767E;
	Wed,  2 Oct 2024 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8WdQnD4"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B011E7669
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727867980; cv=none; b=qzHKIwuQ5KhtndhdfTUwzCiUTiVLsGKQHksAql0w+p6vq8+3zyRnmeY4LNxuHdd99IDomGmKeOegtm/JyZPACW1YFlrf40yIJx5/UjF+BYVppt1lsqu6rYJK4+Vqo1d9pOmoOnMqvtkrVrVA0xznqgxhwcFawRfXR/94tbgRe3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727867980; c=relaxed/simple;
	bh=H6akfT75OuIL9AGUQs6bGG0fvmSemTmrYX51VFTUiSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xb6mvkWBqZBokerj0rlCTM7cOO8nNkz324ySh+R+A+zYCRf/wl1fTSoV9aFLK3GHn/czyBgXMiZpc0PjGx9w0U6o3WV3qQRgbe2EQtYPYKtSvfoffQkvJhJ+W5R2jCJ8sZQFafzfgj8JIe8LKwSve51V+2/ljLgWaikvmcLMNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T8WdQnD4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb1866c8fso9221935e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727867976; x=1728472776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDMJSbyU2HJotKgJW9nkYw44o0hFOSTLiqNlMsEhdY4=;
        b=T8WdQnD4scxCq3R0LWN+tidBDl+tuG9vOydAe8OL6uLyn7v9pVAD3kJDIuLEWO827J
         4DU8FG1p1pjU75APzgcALls0w6K4auCd6QDzKvRUqv+CqYqZ4dyMK1R9Z6VX0HvXaQe6
         gPE0bafWdxcBb3boFOpCadPdNzJ+HIqgJIYHZtVtLBRvf4gFRa87YDjZJxxPh9Oeqx9T
         hI0ZTHGepNgO1ORt/uBsbxaq4Pcffxg3L1IOeifGJvr7JwIYFZI1SeybtOk2lMTGF4Hi
         UURItR/U1tqcWV7E2icGLQdL0sPQe8H11IxSFv3Q7XPVpUCHMezXKp26gJViGmSvasot
         LOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727867976; x=1728472776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDMJSbyU2HJotKgJW9nkYw44o0hFOSTLiqNlMsEhdY4=;
        b=D06hXRm3A+vqXt/N/n+0R62ADsMgDGGikw+ZL+eDQ0Q6zzU5EnMMwEV3LRgYT0u9eS
         Sve2CemJ8AMRK4YQwEZNKgx5gBkG4p+US+APLT3Yrypxuhq7NCMpdd7/aRqKR8Pq+ubk
         FtghNu3i/pFyM+oRrIt/DHEhYKVPGi73RFVqrAEQ4u1DfG4PQQl6fnBRgHx6rU9D7kXA
         eqs3rRICY7DRZW4Dm43UDO7Rt4Wg7LKCPh2Om5G4uk/hRvZcW3mK7eJ18wmME644EcJp
         X9MZyMCpVHMrAmU9fmmF9B8nKUYYfQTI63OUhrbHSC0qbJlt/YM63D20NQqiRAlHGtLw
         DrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+0Uouz5qGcpR2zoOFDGF5UL73HXAIJ76cAumMl+RyE9+mWR/L2vSH9rttSPDOOG9GOiTQ5RWU09sjCas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2VpBOOAKpQ7ElnNCpwAA0DgdT3GDJL2mn8gOtj75zOwoB6KrZ
	It0M6+MjNqeQQlA2SShE0i+ETZqGP6qKc/vQJzAHdQYOQ/xp8+jmox0OtFMrC6nx4Pz7nknP/Sv
	+
X-Google-Smtp-Source: AGHT+IEH41YDB8bUZYb+w6BPwYA1Znv1lZ7S0t6j26mCqlyvI8v0kAqyYD48tXBUKk3rk1ggo4H34g==
X-Received: by 2002:a05:600c:3b2a:b0:42c:aeee:80c with SMTP id 5b1f17b1804b1-42f778ffc41mr9628225e9.9.1727867976261;
        Wed, 02 Oct 2024 04:19:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd575c830sm13681100f8f.111.2024.10.02.04.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:19:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] CREDITS: Sort alphabetically by name
Date: Wed,  2 Oct 2024 13:19:32 +0200
Message-ID: <20241002111932.46012-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-sort few misplaced entries in the CREDITS file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Andrew,
Maybe you could apply it directly for current fixes?
---
 CREDITS | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/CREDITS b/CREDITS
index d439f5a1bc00..63f53feefa0a 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1358,10 +1358,6 @@ D: Major kbuild rework during the 2.5 cycle
 D: ISDN Maintainer
 S: USA
 
-N: Gerrit Renker
-E: gerrit@erg.abdn.ac.uk
-D: DCCP protocol support.
-
 N: Philip Gladstone
 E: philip@gladstonefamily.net
 D: Kernel / timekeeping stuff
@@ -1677,11 +1673,6 @@ W: http://www.carumba.com/
 D: bug toaster (A1 sauce makes all the difference)
 D: Random linux hacker
 
-N: James Hogan
-E: jhogan@kernel.org
-D: Metag architecture maintainer
-D: TZ1090 SoC maintainer
-
 N: Tim Hockin
 E: thockin@hockin.org
 W: http://www.hockin.org/~thockin
@@ -1697,6 +1688,11 @@ D: hwmon subsystem maintainer
 D: i2c-sis96x and i2c-stub SMBus drivers
 S: USA
 
+N: James Hogan
+E: jhogan@kernel.org
+D: Metag architecture maintainer
+D: TZ1090 SoC maintainer
+
 N: Dirk Hohndel
 E: hohndel@suse.de
 D: The XFree86[tm] Project
@@ -1872,6 +1868,10 @@ S: K osmidomkum 723
 S: 160 00 Praha 6
 S: Czech Republic
 
+N: Seth Jennings
+E: sjenning@redhat.com
+D: Creation and maintenance of zswap
+
 N: Jeremy Kerr
 D: Maintainer of SPU File System
 
@@ -2188,19 +2188,6 @@ N: Mike Kravetz
 E: mike.kravetz@oracle.com
 D: Maintenance and development of the hugetlb subsystem
 
-N: Seth Jennings
-E: sjenning@redhat.com
-D: Creation and maintenance of zswap
-
-N: Dan Streetman
-E: ddstreet@ieee.org
-D: Maintenance and development of zswap
-D: Creation and maintenance of the zpool API
-
-N: Vitaly Wool
-E: vitaly.wool@konsulko.com
-D: Maintenance and development of zswap
-
 N: Andreas S. Krebs
 E: akrebs@altavista.net
 D: CYPRESS CY82C693 chipset IDE, Digital's PC-Alpha 164SX boards
@@ -3191,6 +3178,11 @@ N: Ken Pizzini
 E: ken@halcyon.com
 D: CDROM driver "sonycd535" (Sony CDU-535/531)
 
+N: Mathieu Poirier
+E: mathieu.poirier@linaro.org
+D: CoreSight kernel subsystem, Maintainer 2014-2022
+D: Perf tool support for CoreSight
+
 N: Stelian Pop
 E: stelian@popies.net
 P: 1024D/EDBB6147 7B36 0E07 04BC 11DC A7A0  D3F7 7185 9E7A EDBB 6147
@@ -3300,6 +3292,10 @@ S: Schlossbergring 9
 S: 79098 Freiburg
 S: Germany
 
+N: Gerrit Renker
+E: gerrit@erg.abdn.ac.uk
+D: DCCP protocol support.
+
 N: Thomas Renninger
 E: trenn@suse.de
 D: cpupowerutils
@@ -3576,11 +3572,6 @@ D: several improvements to system programs
 S: Oldenburg
 S: Germany
 
-N: Mathieu Poirier
-E: mathieu.poirier@linaro.org
-D: CoreSight kernel subsystem, Maintainer 2014-2022
-D: Perf tool support for CoreSight
-
 N: Robert Schwebel
 E: robert@schwebel.de
 W: https://www.schwebel.de
@@ -3771,6 +3762,11 @@ S: Chr. Winthersvej 1 B, st.th.
 S: DK-1860 Frederiksberg C
 S: Denmark
 
+N: Dan Streetman
+E: ddstreet@ieee.org
+D: Maintenance and development of zswap
+D: Creation and maintenance of the zpool API
+
 N: Drew Sullivan
 E: drew@ss.org
 W: http://www.ss.org/
@@ -4286,6 +4282,10 @@ S: Pipers Way
 S: Swindon. SN3 1RJ
 S: England
 
+N: Vitaly Wool
+E: vitaly.wool@konsulko.com
+D: Maintenance and development of zswap
+
 N: Chris Wright
 E: chrisw@sous-sol.org
 D: hacking on LSM framework and security modules.
-- 
2.43.0


