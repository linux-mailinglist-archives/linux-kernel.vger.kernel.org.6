Return-Path: <linux-kernel+bounces-516230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F943A36E70
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1DC1893E6F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CADC1C6FF3;
	Sat, 15 Feb 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVGl/8BU"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35478F35
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739625466; cv=none; b=JFF9xZtLjImQeOzTLGHUCkAL7fM7FI2WYo0kReCp4N5LsofRndl8h2Xsr05gWPBobgtfHoJe7iViH1r2agdxZcauN7QE7HbN/8OZdArkSjE/4AAwwunlmsbvGKofyskRr1i/ANYWtLuxTY53lTrj+RIjPLl9fpO1EbbftSWApnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739625466; c=relaxed/simple;
	bh=DKMOzS871WD9BJFS19NydgkrDfk1vu7SOxWaxOYXzfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lugYWn9c2bRGiicX0UVTlzI2ZFS0zNWPFZw6gaR8m5XGn1zfis+GKosIN3lW6j+e2t/q6oAdJTSAhVilhTyht3MW5/Pi80yyHYJywxDaklAABVViamApTZniHTdJFzD5VwF2+Y/roVQxKkP+g808JvqdapsZAhYgrFvIp67gen4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LVGl/8BU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f245ac38dso369159f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 05:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739625463; x=1740230263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGXmB4cgRj7i46AipgnBwCCKNXQmiHxqqe+OiiW6adI=;
        b=LVGl/8BUxnK3QhuGWpelbYdTp40jtgGS6U3Vsm8rGKV5MdZMcffnRsu3ukt5DixLWa
         qE+c2CxKez7Kk1OtydeH6u4TB917XXFBy77m8RZqfxCTuhJzON6wv+tqMGeIjx2nu+sa
         uTiq7X3vhUvWnlk+I6WGERCSdVgVFraRE+15PLNl9Jf9kipirnA6VplGGAyJiRQUYU62
         cR0ZNnlF2cpdOuGGrX0nY8kdELRKymLw0x+RkalXJqCWBgc6BZL7BMlRTE4CJrSItehn
         hJsVgya5PE3QyAc2x173F1dcFBMEmKn95XaI96a+AwnBkV3ImwRgXnkf5IZtj5vIEfZa
         iOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739625463; x=1740230263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGXmB4cgRj7i46AipgnBwCCKNXQmiHxqqe+OiiW6adI=;
        b=JsvVjK6yhnHeAB7mVIrgpgfQ6fz8Ua7eQNJuIvlCYJERSF4eUmCb5/5M5EBArRmPAp
         +/N4TLskVqtCX7GGpkqyslac3HwDVFazjpof5duniBs4J4nQzLQlAiwmyqUgexeGtQaH
         AiYl2j0nyNmgMpCP2xL3o66JNWY78Ix9haC3M4XtavE+joC9DNy3mZvEMbyURFyI8vr/
         U8HT2Esx6+QHsQ4KK1kd6oPAfGjyFrp21uRkNwMMK5h/LcQqOXl0P1hp9eVPE0+ifxmn
         ZZVBkXIBw9jmkhuR+LcmKQFBjq5071Cz5HgDOTYoTUDLq92z6+Xi+54rzaYQklISbSal
         um4w==
X-Forwarded-Encrypted: i=1; AJvYcCUDTMW3oW/OcAsFpAGKi+c66nh8+9CIQ7jgKhs+12GCRHgUYy+M3meJMmJ5qUQkpuRJ9Ol1Rm9tbIaqEZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjw+uouBCZVh5SL/lnhvs0SzHcU2Tr7lSQ0Y+8sAFl3KXxUlm
	KBR+ZBZU4aHlc0bNb3qJ9lMboiOgn7dNjCF02yXXwgbWxIr74cra8p5k4uWnoEk=
X-Gm-Gg: ASbGnctj0v43E2y+B8LKGEC5qpbziKHgmFJXwJMliFKPYnOu0VByh4oSIwqHCg8zYhz
	obhbGS7LCESOn0s45I3wTwsa5fsoRZ1m9BzmPAzX5ZcAbvBuDYZeh+8fUutUCcA9Uup4zaEUZn3
	gCsVU53DRScacSaViGjDWpqoJdr2rjryKn+hCDYoaapKQ4ZPXsBhlhjypn6CWp6omamCKh+dInq
	XTXCf/l6FvycOlQTbMChO3mpqsvifj3Ms2WpSz4QPrcpxPIZkLDkjnbJkTaRoq26RSpBGTLdoqg
	pPzsk2yBtyy9Z1UaujjFVMCAFYnGqA==
X-Google-Smtp-Source: AGHT+IH7z2R9nNG93i2MZaB5NKPEWF7rlrwQLWbs/edrhlggOHxufJUOIdYz/d9/Z3xKUdvgy+nFkg==
X-Received: by 2002:a5d:6c66:0:b0:38a:888c:6785 with SMTP id ffacd0b85a97d-38f33f29377mr1138906f8f.6.1739625462851;
        Sat, 15 Feb 2025 05:17:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5eeesm7284499f8f.63.2025.02.15.05.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 05:17:42 -0800 (PST)
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
Subject: [PATCH v2] docs: kconfig: Mention IS_REACHABLE as way for optional dependency
Date: Sat, 15 Feb 2025 14:17:39 +0100
Message-ID: <20250215131739.220629-1-krzysztof.kozlowski@linaro.org>
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
is the module.  This is achieved with IS_REACHABLE, so move earlier
section from "imply" chapter to "Optional dependencies" and grow the
description.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Replace FOO->BAR
2. Instead of referencing earlier "imply", move the code here and add
   more text (Masahiro)
---
 Documentation/kbuild/kconfig-language.rst | 35 ++++++++++++++---------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index 2619fdf56e68..9a8dff58b3af 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -194,16 +194,6 @@ applicable everywhere (see syntax).
   ability to hook into a secondary subsystem while allowing the user to
   configure that subsystem out without also having to unset these drivers.
 
-  Note: If the combination of FOO=y and BAZ=m causes a link error,
-  you can guard the function call with IS_REACHABLE()::
-
-	foo_init()
-	{
-		if (IS_REACHABLE(CONFIG_BAZ))
-			baz_register(&foo);
-		...
-	}
-
   Note: If the feature provided by BAZ is highly desirable for FOO,
   FOO should imply not only BAZ, but also its dependency BAR::
 
@@ -580,15 +570,32 @@ Some drivers are able to optionally use a feature from another module
 or build cleanly with that module disabled, but cause a link failure
 when trying to use that loadable module from a built-in driver.
 
-The most common way to express this optional dependency in Kconfig logic
-uses the slightly counterintuitive::
+There are two ways to express this optional dependency:
 
-  config FOO
+1. If pre-processor can discard entire optional code or module BAR does not
+   provide !BAR stubs then call can be guarded with IS_REACHABLE()::
+
+	foo_init()
+	{
+		if (IS_REACHABLE(CONFIG_BAR))
+			bar_register(&foo);
+		...
+	}
+
+   Drawback: this might lead to run-time debugging, when looking why
+   bar_register() was not called.
+
+2. Otherwise (and module BAR must provide all !BAR stubs) use the slightly
+   counterintuitive Kconfig syntax::
+
+     config FOO
 	tristate "Support for foo hardware"
 	depends on BAR || !BAR
 
 This means that there is either a dependency on BAR that disallows
-the combination of FOO=y with BAR=m, or BAR is completely disabled.
+the combination of FOO=y with BAR=m, or BAR is completely disabled.  Unlike
+IS_REACHABLE(), this option favors configuration-time debugging.
+
 For a more formalized approach if there are multiple drivers that have
 the same dependency, a helper symbol can be used, like::
 
-- 
2.43.0


