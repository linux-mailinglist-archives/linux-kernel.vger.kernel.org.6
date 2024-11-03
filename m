Return-Path: <linux-kernel+bounces-393718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E162C9BA45F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6073282189
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8241632C3;
	Sun,  3 Nov 2024 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8wZYeR0"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C3A15D5CF;
	Sun,  3 Nov 2024 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730619228; cv=none; b=MD8qxptjIBDZNnAQEEb5c4So9NgR92pYrfYki0L3gi7gwZ7HGf72E7NZWZlQPpB+S8WzG2Y/jUVWASlvNP4HKFgZSBgwHYPUhJs9buzWMAtK7+wBlkmKra3Oonmcp1LdqV35O4b/Q5/e95qsf5pC2bzkk3wX/xYGpW5eyMbGt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730619228; c=relaxed/simple;
	bh=hDRg0YaHnMb/3mj2Hdxk7ZixHZuwBUovjfJTVCdFUAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sua/BWX/CQAymbTzqoaNnD8Z8Ta3iFqFgPPuYapZg4023upXzOcMiSxqVnnpmkfM0W5GBXtGg72xKPLC+kV/y0/HKJc9jVSnUA68MgQD0EeJhqoc6xntsTO/AUPj4JCUB21ZjPk3A0i86FoNPG3IBDowd4XvQ1Qg07DXgJpiKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8wZYeR0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ee6edc47abso745651a12.3;
        Sun, 03 Nov 2024 00:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730619227; x=1731224027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAhPP1Ue2Iis5GJtsj6WYVFqMLGyqRg1DOrYPcB4peg=;
        b=C8wZYeR0wqYSEAAvtIPwOAR6DCLkqR1pbN/bU/Cxwf2wYnGEpn+t+qyl6Azw1BUYzk
         cMTX8MCjuO2xUGF+PbtN29Yocgp5zl9wtj4s3tcZU9J0l45WWPD3/N1VRwIQkZnDLF7+
         gQ0nGe9mp5WIXB+yuO3N9hKv+bSOjmmOoeJKKLzpUzwBbrzJsvhGrJus/GJL783gTlQb
         nFLJgG696q1ZGWqipreMRcrZSdlanJgzLetRsqCbabl7Rpk+vFf9NmrL8mcEHYhecptM
         jsqrMD/pBN2jZz6KCPt8O50Sws546mIWMN1SyQ9o+3s+IadN6wXvEmZ6UXd1sxnDbdZv
         cYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730619227; x=1731224027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAhPP1Ue2Iis5GJtsj6WYVFqMLGyqRg1DOrYPcB4peg=;
        b=GqQ/GI299Q+xs7rALL4AUOWfWFR3ZDY4UdLDkMMrsw5h2eamWUXBtFbJbc6/JXBI59
         2kR+25QqAqdOHK77f2qkembXFFiloNC+4Fn3v7nBvKZRCoLL0vqdzc2pO1x+tTJGwW0Z
         XT0ksbGnfI9ipXnPwUUmssCsp3Nx0V8X47n8yZux7FJycu/wbwrXe2Ez7A12o/eY9LMG
         GXG1eCgMESZ9vg4sT8g6Ub4DhB4lEWQd1EUiSD8TAY7jct6FWhq4W2MILyoHGuVMfdp0
         9I+heSmWnSqUtdbS0flYBzkfmrGNzRrvntN9Fg2M3RC5Vm2I4UtmDmZok4cRffUHRMGI
         Ti+w==
X-Forwarded-Encrypted: i=1; AJvYcCUs7tU905j6+VqLKWZmeGI7r5vxJJWvYqM2LDa5HSPcGJ9753d9SIpfH+uQXJsn8Ssp/1nwmSH9EriKyQPT@vger.kernel.org, AJvYcCVS5QGdf18M3G4KJV+cbUarErXRa/tlCepaPI97QOoZtTLdik7fMIcUp1VtDNd/Z+Yk294xfNmPxZjF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17KQR1MiNKOZU0OJg9/b4Gt6g9dcsRs0PJpV+N3zJ/5BnGYFR
	+EXEA8tZRlKq17VgLqMsCGm/qTEjOe2D/6YEeLspZQThMNGwvogE
X-Google-Smtp-Source: AGHT+IGImwWeyY3Moiafe2fkJOaFyS7i3wOq6EzM2uCFlnPu6zaavprp4mJQyKnYQAczv96ouYNN6g==
X-Received: by 2002:a17:90b:4ad2:b0:2e2:d175:5f8d with SMTP id 98e67ed59e1d1-2e94c2ac593mr13732559a91.10.1730619226771;
        Sun, 03 Nov 2024 00:33:46 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e93da983f9sm5353443a91.5.2024.11.03.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 00:33:45 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH asahi-soc/dt v3 02/10] dt-bindings: arm: apple: apple,pmgr-pwrstate: Add A7-A11 compatibles
Date: Sun,  3 Nov 2024 15:31:13 +0800
Message-ID: <20241103073319.30672-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103073319.30672-1-towinchenmi@gmail.com>
References: <20241103073319.30672-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocks found on Apple A7-A11 SoCs are compatible with the existing
driver so add their per-SoC compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/power/apple,pmgr-pwrstate.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index 59a6af735a21..6e9a670eaf56 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -31,6 +31,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-pmgr-pwrstate
+          - apple,t7000-pmgr-pwrstate
+          - apple,s8000-pmgr-pwrstate
+          - apple,t8010-pmgr-pwrstate
+          - apple,t8015-pmgr-pwrstate
           - apple,t8103-pmgr-pwrstate
           - apple,t8112-pmgr-pwrstate
           - apple,t6000-pmgr-pwrstate
-- 
2.47.0


