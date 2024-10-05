Return-Path: <linux-kernel+bounces-351725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B575991564
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A5EB21A67
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 08:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE51C85260;
	Sat,  5 Oct 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6Z/u0+L"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5771211C
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728118289; cv=none; b=MxyMZZVmaGJqCqdlD3ZrnoCyrI+u6fv2O7Ni49tFqu20Y7eqIdWIYr2dxc4j3gCyWjEvkUgC46uTLvlfZP+tR7QWG0MYGP1eOVKJbpOt2jEmJRNmoGR0xt6/Aqvjiwjrde5+RGlMFJzbhcwSbcWH0QQ8opI7e5W5bNpzB71DoxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728118289; c=relaxed/simple;
	bh=d4mKYVbUq1hHMJyzM7xfukOBhhm8zWos2hXlisST0XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UgMlsG8mHbkmtqx4VxzLCRI3vm3rtCXPps+gryUDB+KkfwKGD8ushxn9xHnBtdzb/k3gaubUYXrTAekBhwX46bYvxzT6f6NT+Z4h/DZB14fyV9MtuHoIYmpDnjN4i3bxEfqg/+9vVZrOkppeA61yHLAbpDHgyVQZSjgtX1Agsg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6Z/u0+L; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b9b35c7c3so30552845ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 01:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728118287; x=1728723087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1uwbZR6dedOxY2OXlJ4sLBFtE4VsmtFeSgA1LhChHmg=;
        b=G6Z/u0+L+wMZSBZszAJNIfdDXx1y2Xii1tD8l9xNVja6OiTR/ezyupCYhiyYF5jHYy
         mmKt0YOdQQamWaYOr8y+EudnAgf4EicM2WUsCvt6wGSr+rbqLYblNs6SsZzm3nvs2I5s
         pTu8Mmj2I5PCCGgSE7xFtJuK1u0zNeijcvMNM1kAgMnib4Mxl3G7tVDUUcw4OxLJdXQv
         VhkmQEJxCsFowla6bcAMosd0DN51+a/eYdMo/XpQgDZo+7s/SH2Mn9QKkEX6Lwp550sq
         R6OKM8O9q4pUj4/txdCt/jBY/QYzzlsOgiUQ3/5XQ40ZrELc7e4Pl3do3LDow9iYk5BL
         i1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728118287; x=1728723087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uwbZR6dedOxY2OXlJ4sLBFtE4VsmtFeSgA1LhChHmg=;
        b=FZOT6yl8FSuymJ/hZ71OmjkGaRyHHTvZDBjyv7AwjB+5ABfyiXI/GLLBpzOrNS1KsK
         kgH3QqgBbdhCahG1nSMbCSiOwiu6hNRfNC01i5u0kIIowmO1zYKmE5ok3+ckgGIcKRFU
         2XR1yTYbc5QDlkG5qWAD6jfhY8AbZiDd1fin8cG6aBFDfJh9qX4J7xGLlZ5sGRdmJo+0
         oWrFafSQdTPN0rMiQNRiYfhurHnTm2ePYbmplBEa717zDtQna+jo+UsHf1xpjWwmR3kv
         UVRvzb1AvNbdvpeI6XqTHZlz/GlFW7V2RU3ev3fEaPFkNTaCQFGRtBMJI4w7fpIzXBXl
         8wSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUCW1H/u3ow9Nlf7NUAWeXWR1eetm//Wi3aZwhQveFzLnIsuGtxdgVWx/3/xacbz3KJi+JkqajuBaMUm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL4ro6X3ONok/aWW2AQKNPKXjv9AE16Xm6EDIGBU2fP+RgCrxS
	31lrCMcIsQY2EKF/R0hi6TclmgvdaewravPPPt6x3ns7aWK6heLP
X-Google-Smtp-Source: AGHT+IHTfwXYAULeUrH7diqjwK8fFsq4toX7YGwE89RuQnVQtBU+hwPYb8/K+OAVK3Hb3/xC2oC2Bg==
X-Received: by 2002:a17:902:d483:b0:20b:6208:b869 with SMTP id d9443c01a7336-20bfe01dbedmr76069995ad.24.1728118287107;
        Sat, 05 Oct 2024 01:51:27 -0700 (PDT)
Received: from Kuchus.. ([115.96.37.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13990d12sm9582735ad.277.2024.10.05.01.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 01:51:26 -0700 (PDT)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	lpieralisi@kernel.org,
	linus.walleij@linaro.org,
	linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH] Fix typo in versatile.c
Date: Sat,  5 Oct 2024 14:21:17 +0530
Message-Id: <20241005085117.438715-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected minor typo in versatile.c
- Fixed "documentaton" to "documentation"

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 arch/arm/mach-versatile/versatile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-versatile/versatile.c b/arch/arm/mach-versatile/versatile.c
index 7ef03d0c224d..f0c80d4663ca 100644
--- a/arch/arm/mach-versatile/versatile.c
+++ b/arch/arm/mach-versatile/versatile.c
@@ -134,7 +134,7 @@ static void __init versatile_dt_pci_init(void)
 	val = readl(versatile_sys_base + VERSATILE_SYS_PCICTL_OFFSET);
 	if (val & 1) {
 		/*
-		 * Enable PCI accesses. Note that the documentaton is
+		 * Enable PCI accesses. Note that the documentation is
 		 * inconsistent whether or not this is needed, but the old
 		 * driver had it so we will keep it.
 		 */
-- 
2.34.1


