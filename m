Return-Path: <linux-kernel+bounces-516183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7636A36DCB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 12:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB701895EF3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB03F1AAA1D;
	Sat, 15 Feb 2025 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pfaB/H/9"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E88194C61
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739619749; cv=none; b=mvA5o4224BK5YBFOt+q1x1SjTa0rzaCu9D0buJPjwNjsicJKjefq345dQHgLsS3rzm1CQARIeHuKZTD4/LmNlreBk4r0doGZ9SVH/xCL6ygoF4Kd6Vjl6zZmAEXCilkzw45pAgXBN+HHBArFvbjqWJHIkgmBeMRQbfoYAgQpnkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739619749; c=relaxed/simple;
	bh=jlEMrtSuczn3fzzoK0xcr40k7TWs77qzuwIsfCAKNZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWaxkQCvTjnwxkiGBWBbZTRAMFcawc75pt1mGzGEcMWyUOivE+BsnZxdVUZSDZ3/ks5zVe4oNUjRs3QbN8iTCM8mobmUr6hXSIboltiDKsLWWBmO1O4PPjLF54DeW5FBTCNueM8qNCGwODPKJFVOfTg5cpIuz7jP3ElRwuHovjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pfaB/H/9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ded500589aso405578a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 03:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739619746; x=1740224546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/9aiwr25oAJ3edH5d9HAj7m2t+5rjX23Aj4vPngA6s=;
        b=pfaB/H/9WBoSSrCcsGBA5+FGpJFd4TqfOqqacNP//cZ+ITb0gs1XmRhFwj6qqfMWTn
         NGfVpuCBVVZIXEQPqwAd4HaRxRT6Fp75iXVrx3c5oFYxnamaR8FwJtxL7uPHpyrD9MIN
         p5pcCBrRcgRnCj5vkPcogpUteE0NpEivaezFdleHjDZLB7Q+rWsB8QwKKkV1Tj6efoP4
         SNAJ4PayvBPf6bhQokH0fRVFknsMgCyZg2pPLHnXb2f2hmVEp1bNMBHgdnfW2IyJbUQY
         zubGLmLJX9Lu/ZLGIHQ1t+P/cZArHCsNwTOQGaIxgZMCBL1KjvJikSRjqsl8liUOYk1e
         hoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739619746; x=1740224546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/9aiwr25oAJ3edH5d9HAj7m2t+5rjX23Aj4vPngA6s=;
        b=UQ8z+qqds7cTBpned8+Zrh/mkzJo5JELzlrHECgUTulLjWQFWGVyUVXXXgl9/t0Kh4
         A9bu3J7cOAF10pC/ukjtYkLqIZQYg1wLkDbnXOdqPjDwBM0IH9Khb2IbEGL4nipd6VKl
         WXbxPV8QbqBBneIlAYJeV2PhgPm01Cq1/inSVpIzPumLEXLkDVC2CiSP7zb7bWVjQN/N
         6j7OJs7v8WXgX5GGpNVCDMP/f4gRC0AhEEZULoW4PI1rbRjZP2ClN93ebZn4FqraAFyh
         JzV1Q5r8PNToKQOXPPOUjXHFJudwF8A0XkLZep1dTi6eu0dVYNsDNZEOWqxxXpVeF9lI
         O+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGaRnN+9zNeCmiXnZo8bTWAn2fT+sA/yoY/ohfpkCymhEPeA07vsv+J5PVAEP/wFrnPqzf5B8Ej3T4XVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKOro0vU/lrrk6PsDtlsll9IMPWhlFj1m6OHpR94fH6PFy57F
	2UmO5w0RPl23FOZHTxQO80sD+sI+otUJXYnRSS0cneMBb/VOhSQcD56Sek3olww=
X-Gm-Gg: ASbGnctyxpPmOW1gWXY7EDNjdFQfJIeC/xS6LoS2lGRBFFYDbPJ9dMsf6M+/viLgtrQ
	w+/vhGtSG3j23XtANadhABykRaUiaHZenXdwNDM1ode74t46ofa3enLUTP2kjPBFdWAcKAYZNcu
	dg1+ZtL98PAiQ3n+he8Gug49ESsRAw+LGCnn/7Tiuhj9A1YJLGTGRBNsY0XoLCtf497/IwnKhxF
	yrr4x8D+VGfOuIkhkk5I9QjyeeHsT7qM46WV8OsQ/uEaKIx/Jx5VuX1Y5E1nyRRCrN+XzaoxxQt
	+9AoKaRSwZ9qjhwXKKWh/eqRwFEwVw==
X-Google-Smtp-Source: AGHT+IHUivwWZ3VEikRDrRYHKU+IYVIYHCuZ3UwvO0EOUSMr15+9iT2JsZ91Gm5M8EVhs19uFDlv4g==
X-Received: by 2002:a17:907:9716:b0:ab3:8bcc:3d97 with SMTP id a640c23a62f3a-abb70ab8c13mr102363266b.5.1739619745715;
        Sat, 15 Feb 2025 03:42:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53231e10sm517697266b.35.2025.02.15.03.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:42:25 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] docs: kconfig: Mention IS_REACHABLE as way for optional dependency
Date: Sat, 15 Feb 2025 12:42:23 +0100
Message-ID: <20250215114223.140688-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several drivers express optional Kconfig dependency with FOO || !FOO,
but for many choices this is neither suitable (lack of stubs for !FOO
like in HWMON) nor really needed and driver can be built in even if FOO
is the module.  This is achieved with IS_REACHABLE, so provide cross
reference to it.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/kbuild/kconfig-language.rst | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index 2619fdf56e68..66248294a552 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -194,6 +194,8 @@ applicable everywhere (see syntax).
   ability to hook into a secondary subsystem while allowing the user to
   configure that subsystem out without also having to unset these drivers.
 
+.. _is_reachable:
+
   Note: If the combination of FOO=y and BAZ=m causes a link error,
   you can guard the function call with IS_REACHABLE()::
 
@@ -580,10 +582,15 @@ Some drivers are able to optionally use a feature from another module
 or build cleanly with that module disabled, but cause a link failure
 when trying to use that loadable module from a built-in driver.
 
-The most common way to express this optional dependency in Kconfig logic
-uses the slightly counterintuitive::
+There are two ways to express this optional dependency:
 
-  config FOO
+1. If pre-processor can discard entire optional code or module FOO does not
+   provide !FOO stubs then in the C code :ref:`IS_REACHABLE<is_reachable>`
+
+2. Otherwise (and module FOO must provide all !FOO stubs) use the slightly
+   counterintuitive Kconfig syntax::
+
+     config FOO
 	tristate "Support for foo hardware"
 	depends on BAR || !BAR
 
-- 
2.43.0


