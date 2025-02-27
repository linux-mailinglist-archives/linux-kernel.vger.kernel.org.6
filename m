Return-Path: <linux-kernel+bounces-536166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B10CA47C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953B23B0B71
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E022B59F;
	Thu, 27 Feb 2025 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5aJlq2F"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEC22AE6D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655999; cv=none; b=WcNhD9byJUU5BzcTZ01rgX7uURjsPRatEsgzyiW+ozFfLq03tzIQ4rQ70f9aNjOX2aR9nSw1a4jGwoIZhmbWj/vE2UxSmDZ5WfvOBhdiTjk1yAJPq/kXvYMU+2tbOyamYAePPzApu9SlpCqoRquZGCSyE1FrZjoUFPWLPF3w92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655999; c=relaxed/simple;
	bh=LO2N9vciU7HB99mtlW3h5ysZsPTzOm1mscKvDNw90XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TwW65lLcfKRxg8+lTCbGS1zTY/OV8vca+rb2Qz4ssz38q2kBJvtyZviPTX9Xx8sRBk/TuH4MrLlVXWUK2TiX1+jYHajPfpn08ufaGkYN05jIyUReLmxdb1MnCgPVsB7i+wEEoOJNQMKuan3QKKOYYX244Sfp+B7focQKLiaCPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5aJlq2F; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2234e5347e2so13318935ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 03:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740655995; x=1741260795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cg8yMwZ72Jlc0r5z1N3IiuaraHv4s6b2xThN5W01Djk=;
        b=D5aJlq2F6R3GUVFt9YVYvhZSbEIyrGG1WMu63jw39i9UyiEW8h3xQDgfWN5Pycnn8P
         beqrTO3UYTF8846iPQOltFhA1dkAD6wN6puK4jcojLYSt2ztSzGi9i2tx3dMkFy8F7Y8
         3P9XUvlZfrALUIckJ3n71tffqsz1+ZFWZbAMasuiVZQ3Gy7K1ceewuk3Z8DOIU6Nricn
         HKI1frdmWR289oCt0FpSOlm4NMj0HnV1FFhyvdPGR1hYfOyyT45CDAmLcC4VQhbRhJIZ
         jJGWvxdM7sF3f+YSy4oeDBoDeCdtPGkLeFXR2pwUJ8mafwT3f8hiUkKPJhpxeUYviKDT
         NCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655995; x=1741260795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cg8yMwZ72Jlc0r5z1N3IiuaraHv4s6b2xThN5W01Djk=;
        b=McJsm2QNuYwkCwlPxlFn2K8NM7u5OUKG09DywBS2AgWaH2Gua8Vw46Tvii0heFAYCr
         I//lhvNfoED/Uta+txyeUSiKiUzmVaMsSH6xjT/DU/pdeBmY2EFGq5MbIdiJdLXcMVYt
         fkiJA+p0y2msPp2NbpTIrpf1tBNW8u2TDm4jtB7FFtumQ9PJCPxMmdoFhkvQVAPjJer7
         HPKaNGLStOWho2O3HpD8dayznJeHefeEe8b5Q5hnG4aQJd+15oT1PNUE1Fnsj+0JY6QU
         8J45CyrvYWqq2ZhExJ/8EdY+prU+0wH/g1w8hz/kLOPGXqdkSXjons8cReA83x0K9h0C
         vxgg==
X-Forwarded-Encrypted: i=1; AJvYcCXPK/byf3jDJtVS6aqglt/qSebsYJxOfiBe93hlV2L4QXVya5D4/mQXXgenZ8mZvACUZS0+lQyDRA8N5NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Iol4KWXU518fvMJIQkDxLFJWlQunCsDF50Fdseeyy0U4O897
	8aNshDmgJZRgXCAsbb1DfjDI6kOKqmYO5KnpQWXWGbhbQENw2XxqOsLXJmRwjx+RrN44Hbrr0Pk
	I
X-Gm-Gg: ASbGncteRtFTfseNFnUcIfk/vuGE40OO46odmCA3h0Y4XDmwf2LVXmN8BZ8a2ubiOFT
	OZndiMhwerQTka1A3YZy8bd1ptSKUXN2NoJ03HUckyRqk58M4US1klig+4VR0ECF7I0XwBXTg1h
	/LMq9acl+NQMBwGrIJ5uJXwLFcDtMUSEtzwksafataf7HmQWc9rkh3oj32frhjeUFjAgaedfaLS
	5kdpT7Y6/0AxgcO1tFYlvZx1sVyZQJbGC0Ha+5LmFEay+IOwkr4pMLahMHsT+GQ2p9P9skYzSAj
	p2fxVNr4i83u6W/YAsElz1FiNqKp
X-Google-Smtp-Source: AGHT+IG4VU2x6YDtNodsc0R4UfSHlwxikIm91sBEmZvthobIJS1xQjZsA9eqGdyUlDUdvBKd735Xuw==
X-Received: by 2002:a05:6a00:4614:b0:732:13fd:3f1f with SMTP id d2e1a72fcca58-7348be7eeb2mr12060717b3a.24.1740655995332;
        Thu, 27 Feb 2025 03:33:15 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48858sm1343733b3a.51.2025.02.27.03.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:33:14 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: akpm@linux-foundation.org,
	herbert@gondor.apana.org.au,
	jarkko@kernel.org,
	jens.wiklander@linaro.org
Cc: sumit.garg@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	linux-crypto@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] MAINTAINERS: .mailmap: Update Sumit Garg's email address
Date: Thu, 27 Feb 2025 17:02:28 +0530
Message-ID: <20250227113228.1809449-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update Sumit Garg's email address to @kernel.org.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index a897c16d3bae..4a93909286d8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -689,6 +689,7 @@ Subbaraman Narayanamurthy <quic_subbaram@quicinc.com> <subbaram@codeaurora.org>
 Subhash Jadavani <subhashj@codeaurora.org>
 Sudarshan Rajagopalan <quic_sudaraja@quicinc.com> <sudaraja@codeaurora.org>
 Sudeep Holla <sudeep.holla@arm.com> Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
+Sumit Garg <sumit.garg@kernel.org> <sumit.garg@linaro.org>
 Sumit Semwal <sumit.semwal@ti.com>
 Surabhi Vishnoi <quic_svishnoi@quicinc.com> <svishnoi@codeaurora.org>
 Sven Eckelmann <sven@narfation.org> <seckelmann@datto.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1b0cc181db74..616f859c5f92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12861,7 +12861,7 @@ F:	include/keys/trusted_dcp.h
 F:	security/keys/trusted-keys/trusted_dcp.c
 
 KEYS-TRUSTED-TEE
-M:	Sumit Garg <sumit.garg@linaro.org>
+M:	Sumit Garg <sumit.garg@kernel.org>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
@@ -17661,7 +17661,7 @@ F:	Documentation/ABI/testing/sysfs-bus-optee-devices
 F:	drivers/tee/optee/
 
 OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
-M:	Sumit Garg <sumit.garg@linaro.org>
+M:	Sumit Garg <sumit.garg@kernel.org>
 L:	op-tee@lists.trustedfirmware.org
 S:	Maintained
 F:	drivers/char/hw_random/optee-rng.c
@@ -23272,7 +23272,7 @@ F:	include/media/i2c/tw9910.h
 
 TEE SUBSYSTEM
 M:	Jens Wiklander <jens.wiklander@linaro.org>
-R:	Sumit Garg <sumit.garg@linaro.org>
+R:	Sumit Garg <sumit.garg@kernel.org>
 L:	op-tee@lists.trustedfirmware.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-tee
-- 
2.43.0


