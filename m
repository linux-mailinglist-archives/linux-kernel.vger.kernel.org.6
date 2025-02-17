Return-Path: <linux-kernel+bounces-517504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4F7A381CD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5653B3CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF89218AD2;
	Mon, 17 Feb 2025 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPFMBWWt"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B5A194C8B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791921; cv=none; b=MI+bWJM4azVShlg0RP/plDfmC8uIM7a8w1SxGFAWsuNNaGSv1FDiAD57+rcGpELI1bO7kbQStkYmMsQzU7J36z/mwzCok2BUtVP0umBJ3Km/ThcuePhztIGx8VnSvMKH9XET7qAd7HwH/HNx0dA49M1cLV4R4kxTYiBdb/SkClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791921; c=relaxed/simple;
	bh=+hLWA2hCnKT5kulKutuWGIx2zEUObNyrhqOjKdPI9nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LcHgB8pnx2WG5flxCt220OWEI/nzhLilsAXI+iTqYNo7tXGgQJ0v7cP91rnNJv32sY3Emx8iJ6yoe9vrc62omzpyeJoUihdCJXnbfVJfmHZyvLTQUfERocQXUnDTNDeysnhsmcpUgZcKd3gU2CbBiiZdf3gh0+GclQebcHu+wQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sPFMBWWt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ded500589aso600238a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739791917; x=1740396717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKimg4pzOrqaPAD9ALPNCd7JMmdFnSaV4akqnAMH+aM=;
        b=sPFMBWWt8A9jgcuPvG4ovrehKfJc/Fn+3Q4YXus57fEYgun1t0bARqoIcFf8d2i/0S
         ocB9QKSy8JXld2eC9BTFlbAhG2BPE5hbXYGFpClB1EscXBesRrF9PB3+OYS9bA4HbkBF
         aUReJKMYYZlrXNp4OLMJSQ7c09L8AA/w03fd/J3Ql7tuTisIuvuSaae20B/unvGLaRI2
         DgWZbyEv5fIHKZ5iNMu3vpuc/B90hqdCE32Z642LcetDEC0NMcgkOae8OpAmrAEEZ6mx
         y5F1KdSr08CGljLMrgwYZLnyG/16irMovSAFpQgq/+43kpD4twTyFmajOhmfTj/Gnbx7
         PITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739791917; x=1740396717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKimg4pzOrqaPAD9ALPNCd7JMmdFnSaV4akqnAMH+aM=;
        b=pLgn/nT6e9o947s9M8pmWZttsgNvFZct5fTsnrjzb4vTpbidgygG5xSTMDqX0Gbeuq
         LxehCs7kQ9Aa/ALpfOZ7D79NG50awV+YW8R44F+Ugwq00LT279OVae76N6EDZUtb81Fd
         cG69JRi97bMz76DQe9VwULuNAXgeb2mMqnG3j7UAaAUk15hmfWmDs39SKuU215N4tquC
         TSAOQowz+sIZptvnfMkB/aVYebQd6Q7i4ivMZCeg17jm5jb7VBeAhoj6Mm08AJ/TQRH0
         rlbkERFJo3it2A1D5l6wInGAMv1rePDhJyXzYnZslMNfBTV5KF19Vmbx5QZrS/H+pbft
         /J6w==
X-Forwarded-Encrypted: i=1; AJvYcCVyuqYwtCSro+xlz9pJtN7wXfRfWzP2SWuWXcTkF8B79nECjnJW0qRw109PbB9CMutL1rM/YZaVNsRemKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEiMVYNMTOjfk/wzr/KXGHvGLoKDO1g9vkeywDIyZWw29fnrHG
	qTz6MxYkgJ/Iyv+fYwzink/NwSZQDj6k6RPJ3MyOhM3FfBZruSKL6qj1LAkdSAU=
X-Gm-Gg: ASbGncspa+szm6+b308O/VZbrV+DjNHZI05Z3u3OKLNt47VJlE/PCyTulYF3IHOewmP
	FESQd1n7P8l3Ts1Fx7/ueXAlj5hlsY0/FWU7up8u5NlCyY75uSfW2wnR1OLuGZFxYCim3e1D+zf
	nUEQO/Avup45BlAQDoTJG4Kf9vzqGmeRXbQCbWNS2sT5rN5dKuyPERw1a8OhZdZGhp3WtFJfrbR
	bmZfXE98b4j+OZkpqtQpoeRQi7unY//Fw2rx1hDJo/rHOfaB8DJ3jOheMl8Ql9cw7XBWuIx5CGQ
	EJ1Qd5ZJUEWbgbk2wywVdIHuGl5Tyg==
X-Google-Smtp-Source: AGHT+IF187xjpbv8MjESEcHWSW3tQgy/oCc4RlywDfwrTREL9mIvbOFSssZRofy6CqOFM+/0HK3Tag==
X-Received: by 2002:a17:907:d8b:b0:ab6:58e4:4fec with SMTP id a640c23a62f3a-abb7093370fmr369717266b.3.1739791916663;
        Mon, 17 Feb 2025 03:31:56 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb1e1bef3esm554323866b.146.2025.02.17.03.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 03:31:56 -0800 (PST)
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
Subject: [PATCH v3] docs: kconfig: Mention IS_REACHABLE as way for optional dependency
Date: Mon, 17 Feb 2025 12:31:53 +0100
Message-ID: <20250217113153.161476-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several drivers express optional Kconfig dependency with FOO || !FOO,
but for many choices this is not suitable: lack of stubs for !FOO
like in HWMON.  Describe the second, less favorable way of optional
dependency with IS_REACHABLE by moving the code from "imply" chapter to
"Optional dependencies".

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Significant rewrite to mark IS_REACHABLE as less favorable.

Changes in v2:
1. Replace FOO->BAR
2. Instead of referencing earlier "imply", move the code here and add
   more text (Masahiro)
---
 Documentation/kbuild/kconfig-language.rst | 29 ++++++++++++++---------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index 2619fdf56e68..c8c20a34525e 100644
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
 
@@ -588,7 +578,9 @@ uses the slightly counterintuitive::
 	depends on BAR || !BAR
 
 This means that there is either a dependency on BAR that disallows
-the combination of FOO=y with BAR=m, or BAR is completely disabled.
+the combination of FOO=y with BAR=m, or BAR is completely disabled.  The BAR
+module must provide all the stubs for !BAR case.
+
 For a more formalized approach if there are multiple drivers that have
 the same dependency, a helper symbol can be used, like::
 
@@ -599,6 +591,21 @@ the same dependency, a helper symbol can be used, like::
   config BAR_OPTIONAL
 	def_tristate BAR || !BAR
 
+Much less favorable way to express optional dependency is IS_REACHABLE() within
+the module code, useful for example when the module BAR does not provide
+!BAR stubs::
+
+	foo_init()
+	{
+		if (IS_REACHABLE(CONFIG_BAR))
+			bar_register(&foo);
+		...
+	}
+
+IS_REACHABLE() is generally discouraged, because the code will be silently
+discarded, when CONFIG_BAR=m and this code is built-in.  This is not what users
+usually expect when enabling BAR as module.
+
 Kconfig recursive dependency limitations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.43.0


