Return-Path: <linux-kernel+bounces-337180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00EE984674
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6A81C22EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE8A149C54;
	Tue, 24 Sep 2024 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wu/BQr0R"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B891B85DD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727183337; cv=none; b=LnRhla3iFx5FirnCo21zql/ixtHAlRUuOTfa6UQJEPnrWNFu2UiIW1CmzN6my/WZIas4wRbDqoBavAO7N24IhAur9uqATLnlNlp7/ibXM3/OsRSyssGf1r+/+vuxFHoOd2TZ34Fh81/OrXhZbmWITdAh6EjtM1mx43XwVIM5wGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727183337; c=relaxed/simple;
	bh=20VESlFAgLL/DdDPQj1cUy8T9pMhfk2LyD0wWgYxzK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aprDY1HHA+DiYaJmUk+AMF7KqeN/1Q2NrEy0XdMEMLgfFRN6x/UTpTKXBxJ2d86VeqjuIB6fZVlxboqVGDFOHyevyrF+gvpZ2QMkO46MjbpwbLj7sVNUtjBb2jCFp9ukh2aJztUdqIFsfqg293piIeOmxKM7rN52vnhSlPJkE1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wu/BQr0R; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a87c7c68dso63873566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727183334; x=1727788134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBqAdCr/Tagnq8w6gUFIkMYJLmwI/sDayqKEKgevhjY=;
        b=Wu/BQr0RfeIYKgOXvOStMxolcZCPwKfFVaXknUs5/qUfucm8PwanGI9X2Vzus6PxV7
         Qe/vIZMT4nYMaEez9ToG6NDA3ShmGfOXyaJGadc8vNAMgTvECmwAgFUljVllhgYDhGWW
         ZFxAiM2lhZ3aX9ldR9Rr6Sjdck/kCRHSkBvUo2C6eHXfljFJRh9k1tJ4txaExK9zM3HL
         GJqzu6p1gkkF+bXQKG+H12oo4DuY1Ga8TPxqpqLvJPA1TOdZV3EPo/TT0U63MPpyrN52
         nTDluP5Q9G+zFtbGmhXE4m34tVjqBvqGMMdkq0qt4yj+y31ZAJ63qQI3tNGIeJ4UO2t4
         8/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727183334; x=1727788134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBqAdCr/Tagnq8w6gUFIkMYJLmwI/sDayqKEKgevhjY=;
        b=wZuvCbhDu8blb1Ew641mgFJrd2fxI8WUOAEuOpSMyihReOOWT0ME8g2BvFMofuzBoJ
         rHsZu5fI33gTZyBeua8efhKv3JPD+6V0cKuf3wZmo0OJe0CenPdg0A63ZAbrOJ9Onhpt
         foRPYWS9J0Pf8gycxsgsBCvuKtPzDBylXY7XG7uNBsUqJCIEt09qYBIJMs1d0mpItjJJ
         BT5j2PsJl5pXL8uBdURJXyAHVOiolVuBA/weltApJyZ+u6m+xbAfTDEBkRbmcVtO8piP
         JZEGzBLLqDnAG3VTKKJybx5dIKfRQW9+JyMxDcakG6oluXz3wXNW0wIcf4XuCE8KjQK8
         JPBg==
X-Forwarded-Encrypted: i=1; AJvYcCXBMifbmiIUaEYqk9q048/i20SEQJWdScXH1DlrGDL43JgYIdoxDCmAluEG+9ch7WChj8Cx3PJv8AukJmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5zY/cBnQhQ+lqAUkUxiaJ8D8NzIEs7ZkG/ZXLeVhKfRzttZRd
	PVMDXU1JPous+pAESMMhlz7gCmBLDoEzZv2xiK+V09OjaYEAqLuFjfAZyInjk8k=
X-Google-Smtp-Source: AGHT+IG141L2UlovN7HIS3we1HyzW+NcX2RskLqTWDHr34a9VPY4jl2ref868d0s1ndXxBhKwv/sJA==
X-Received: by 2002:a17:906:dc8f:b0:a8d:2de6:cb59 with SMTP id a640c23a62f3a-a90d4fc3661mr716363766b.3.1727183333891;
        Tue, 24 Sep 2024 06:08:53 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f8440sm82236666b.182.2024.09.24.06.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:08:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	soc@kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Will Deacon <will@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH] Documentation/process: maintainer-soc: clarify submitting patches
Date: Tue, 24 Sep 2024 15:08:31 +0200
Message-ID: <20240924130831.38861-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patches for SoCs are expected to be picked up by SoC submaintainers.
The main SoC maintainers should be addressed only in few cases.

Rewrite the section about maintainer handling to document above
expectation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Will Deacon <will@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Conor Dooley <conor@kernel.org>
Cc: Heiko Stübner <heiko@sntech.de>

---

During our LPC ad-hoc BoF, we discussed improving Maintainer SoC docs
and I think I volunteered to write something.  The trouble is that
whatever I won't write in my notes, escapes my memory.

I believe this is what we discussed.  Was there anything more to
write/document?
---
 Documentation/process/maintainer-soc.rst | 42 +++++++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/maintainer-soc.rst b/Documentation/process/maintainer-soc.rst
index 12637530d68f..dc0136e8d852 100644
--- a/Documentation/process/maintainer-soc.rst
+++ b/Documentation/process/maintainer-soc.rst
@@ -30,10 +30,13 @@ tree as a dedicated branch covering multiple subsystems.
 The main SoC tree is housed on git.kernel.org:
   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/
 
+Maintainers
+-----------
+
 Clearly this is quite a wide range of topics, which no one person, or even
 small group of people are capable of maintaining.  Instead, the SoC subsystem
-is comprised of many submaintainers, each taking care of individual platforms
-and driver subdirectories.
+is comprised of many submaintainers (platform maintainers), each taking care of
+individual platforms and driver subdirectories.
 In this regard, "platform" usually refers to a series of SoCs from a given
 vendor, for example, Nvidia's series of Tegra SoCs.  Many submaintainers operate
 on a vendor level, responsible for multiple product lines.  For several reasons,
@@ -43,14 +46,43 @@ MAINTAINERS file.
 
 Most of these submaintainers have their own trees where they stage patches,
 sending pull requests to the main SoC tree.  These trees are usually, but not
-always, listed in MAINTAINERS.  The main SoC maintainers can be reached via the
-alias soc@kernel.org if there is no platform-specific maintainer, or if they
-are unresponsive.
+always, listed in MAINTAINERS.
 
 What the SoC tree is not, however, is a location for architecture-specific code
 changes.  Each architecture has its own maintainers that are responsible for
 architectural details, CPU errata and the like.
 
+Submitting Patches for Given SoC
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+All usual platform related patches should be sent via SoC submaintainers
+(platform-specific maintainers.  This includes also changes to per-platform or
+shared defconfigs (scripts/get_maintainer.pl might not provide correct
+addresses in such case).
+
+Submitting Patches to the Main SoC Maintainers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The main SoC maintainers can be reached via the alias soc@kernel.org only in
+following cases:
+
+1. There are no platform-specific maintainers.
+
+2. Platform-specific maintainers are unresponsive.
+
+3. Introducing a completely new SoC platform after community review.  Such new
+   SoC work should be sent first to common mailing lists, pointed out by
+   scripts/get_maintainer.pl, for community review.  After positive community
+   review, work should be sent in one patchset containing new arch/foo/Kconfig
+   entry, DTS files, MAINTAINERS file entry and optionally initial drivers with
+   their Devicetree bindings.  The MAINTAINERS file entry should list new
+   platform-specific maintainers, who are going to be responsible for handling
+   patches for the platform from now on.
+
+Note that the soc@kernel.org is not a place to discuss the patches, thus work
+sent to this address should be already considered as acceptable by the
+community.
+
 Information for (new) Submaintainers
 ------------------------------------
 
-- 
2.43.0


