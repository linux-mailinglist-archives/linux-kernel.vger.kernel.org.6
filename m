Return-Path: <linux-kernel+bounces-213388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D190747C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC2F1B23FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B07B14430E;
	Thu, 13 Jun 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVKYbjMH"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE80144312
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287209; cv=none; b=FZQktiNOY0C3tNSanZcZyzvh2Ld51sdXyWZeUMp2A93unwoM0WEZ28TEkHRKHOUXllitskMsHitpRaFHv8jMYHcsvL4ek32e6rTr+lCamIYw8+8U3DJFvZsJ1b9hAjH1hXM1X3vES/yxh3A9W24CU/UTAFPSRO0nOX5B6GLuFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287209; c=relaxed/simple;
	bh=iebgPsxTODLUA0ZXcTqHjXyMBp8XIPW3O3ru3tyh/5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PNcaRMlVeasB8x0gQVo5HkDxD2AjzxPfMC1S/Cn7AOBEjb7gk9xESkdD7J23zTF9MaZ8be5S4XaJel1BWRKlO0gf6FBXZPKy6Y//ixqR0hzR3wVw9eN/R1Wfj+PFV8IeBkyzMJ1i1EdyDqCyxgZpXjj+mpPx+N94syHlrFIsfyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVKYbjMH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5295eb47b48so1379641e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718287205; x=1718892005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F2RDidzm7GpI6kx4jm5uYVlPtBVF5KxxK5vmQkl3iB0=;
        b=QVKYbjMHsFoc8i5pRKI6g14+cjhcFO3VcBYwQYnB8/hKL9XVnnqtOmyli9ny8wbOaw
         hY0w9sQZUOxB8LmK3C0OMHY0y6tqqN7v+5dorSKJCUVuVyE98Zs9caygFJJbCqhAspmt
         ItCeUDfPS+jbeaWsdoxVX6iGcwAuTybmBth6Ypj+KBApNxtzVBEt1xTktSOLLh69JSjT
         3Qqho2nCFRU1Tz8XMMACynn5bCfTyss5JQGGWJLQroaYSKqYgXMsGDPIplJkZV7HxjHj
         CF5oNAEFvUlaBzv4ksFY1cJxeNC/dApOSq5PNCwbJmDqgTiNpdrT2AtAyJhxFClBm1js
         dnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718287205; x=1718892005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2RDidzm7GpI6kx4jm5uYVlPtBVF5KxxK5vmQkl3iB0=;
        b=tXbBP3bS6VxpXl5eP1GdjHQ5VDSC7uq6AAzCaikHeLS4nyZblV1TKFHKfbttIA6lei
         ginrXOMxChbjIEOkWwx/OS2YJYzugQd1qTTbwB6gVbTvtBGEPK2KguSacDN26Cae4FGR
         lkR0ySloYQHspLoTvIiG6oSxp5OHJnC28oAMglg1RaDlFIK3POwWff3OBEHn5fpg3yHl
         K7nrhlQil6yOu70X+mIpL+kgOCeDOckY58zmuu/P17bYTAvRvm2b/ljwyex3qUQqCIeY
         QFCqaG2mG5qN9MA9ZEKqo14Fcktw/qvx7vW3m7blGaOn9t0w8eg/UdeVru92UG8Gno+K
         xg4g==
X-Forwarded-Encrypted: i=1; AJvYcCU7wilKRAHdCrkjW3u1uGpSFygBtFkoTXHsuDEuzwHFJ8VdQP+o6Ab1aCRp9o4Zk4EeHuRmZ4nqAjrODQcelM3ajjbtkK6cj/xxXj9i
X-Gm-Message-State: AOJu0YwU5BU7Qk2K0yNHxRvvEs0FL9XDbNhBUKp++YyqmqDPX41D3brM
	aJXK6WYuL2XQfUEuQXv/anXkzB86Tzv54U1Lr+DLXeOAYKLuaBkrE23AlByJTK4=
X-Google-Smtp-Source: AGHT+IG3A84sUkMMQsZJo4N+iSVC0jvNEqXBxVLO3aeIjcOTK4qYHH0z+w7CeXo0QEtY4uBZFdeLyw==
X-Received: by 2002:a05:6512:108e:b0:52c:7f12:61d1 with SMTP id 2adb3069b0e04-52c9a3b972dmr4185902e87.1.1718287205201;
        Thu, 13 Jun 2024 07:00:05 -0700 (PDT)
Received: from krzk-bin.monzoon.net (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33ccesm25578295e9.3.2024.06.13.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:00:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: arm@kernel.org,
	soc@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonas Jensen <jonas.jensen@gmail.com>
Subject: [PATCH] MAINTAINERS: ARM: moxa: add Krzysztof Kozlowski as maintainer
Date: Thu, 13 Jun 2024 15:59:56 +0200
Message-ID: <20240613135956.8899-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no maintainers entry for the ARM MOXA ART SoC, thus patches end
up nowhere.  Add such entry, because even if platform is orphaned and on
its way out of the kernel, it is nice to take patches if someone sends
something.

I do not plan to actively support/maintain MOXA but I can take odd fixes
now and then.

Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Jonas,
If you want to maintain it instead, please go ahead. I send this patch
only because it looks abandoned.
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60f2815f0453..fde9ef6f3f0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2555,6 +2555,15 @@ F:	arch/arm/boot/dts/socionext/milbeaut*
 F:	arch/arm/mach-milbeaut/
 N:	milbeaut
 
+ARM/MOXA ART SOC
+M:	Krzysztof Kozlowski <krzk@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/arm/moxart.yaml
+F:	Documentation/devicetree/bindings/clock/moxa,moxart-clock.txt
+F:	arch/arm/boot/dts/moxa/
+F:	drivers/clk/clk-moxart.c
+
 ARM/MStar/Sigmastar Armv7 SoC support
 M:	Daniel Palmer <daniel@thingy.jp>
 M:	Romain Perier <romain.perier@gmail.com>
-- 
2.43.0


