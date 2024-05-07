Return-Path: <linux-kernel+bounces-171589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B488BE619
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36A81C21D14
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E584915F40C;
	Tue,  7 May 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFu4SFwy"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30DC154BFC;
	Tue,  7 May 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092568; cv=none; b=J8Szs3/2Tj8ctOJ+Ro15/NGGmX+2DaEXuX7U5zVrMeXHiChd79T7Y6nCpOFsTp7XUr6dgbGbvN5iuTc+HyAHKQ2aeL9KgzIeZyYxvgtoU90jkrF5Jlkh2KwzcOoA9C17uaO4lH1vNMD2W0J7QY98uFGOIinVmAn+5OmVY9TkgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092568; c=relaxed/simple;
	bh=OTjMBZ+MwP+QZ3qrHxyCTvxPfkh9ukS1LO64DlNpS7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mFWueRdqvUU8ddr1rGu1CwpGZuQ8rY0HH5bjOSHMQLUp6EHPyQicQEa2ryEkPNLAGvFyrWm9yxF2rgOIq1fBxvLOYBdYrF0y16MnwllnP+FSSfrujiToYC5YaZswTJMfXfe3XF+IuzppgIo9YhnE59COTKA/f4hU74aBiDa9Fgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFu4SFwy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso22668775ad.0;
        Tue, 07 May 2024 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715092566; x=1715697366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4sE/TPSmc70RJaChbU/e2Q4/04mDKoGHf4Df/fOCQVg=;
        b=BFu4SFwyjlgTRg29RhVjMQH9Fnugh3WBSmJz60fZ2X3NbWHGYxORrU2fhzE79O4ssJ
         saFT+Fv/DHfJzoCNM1ON709ALWc3sCy8+Ncw+YTpw55vwc2cz/EGh9O7BRUCOUvxK+qE
         iIZPuM1tVtORm26WOCjeFyWZXMQWu4TVlUVDiVfl8i3bQ3gQa95utQiPAvGx9GruWJ4r
         DNRR48xohOVsZCP4gkx2rEWFiS29M4YBWn75GyfP87OdwQrVv2kQ1i9MpUr29SqPpJvT
         yl6OsPRtzPMv7O3SIpqhVzIWsQJJmCNj7VAI5gEb4d/nZpfub9xgpqCg9e4wHHwhBiLh
         R74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715092566; x=1715697366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sE/TPSmc70RJaChbU/e2Q4/04mDKoGHf4Df/fOCQVg=;
        b=r7JyJHiu6cLVY5VC5ko2YCVxzEPwsaQfgbIyNJalMg9mJDzzGJpbPEnVvEdkT+gFo2
         nGs/gFj8pHww3TTrgBksuQzhVvSTFDN6Xo8zKv4vASnMAUW6CfIL1XHMoNVH1SSzGURV
         1ycToeESfSsq3+mijfMQtRRDGuuzKYCotxh6yN3Mgd4BRGpq6EFZeA9VLaG0D488WIi0
         rhHRWxf7l7i0nkrZr3FGu6vX07DE54qd4PYADXT987RvAdE3VAGTZGYptapYzsYcj1RQ
         FGqlXrnT54KevPe9f1o7YjBZk87dS1gzlWZ+d6QKb0zZT2nFopzztkukyqnWzL3vk9yw
         ZScw==
X-Forwarded-Encrypted: i=1; AJvYcCWAqzFljN+QEFdLJLEiaBqXmkYVcbWmlK/EVUrtZ5e2xhh/LOCoTikfNC/+XBprovDk97yO1nIJKxLuRqq3szMYeBR/zc7DtSyPqih28tsMQxSdaGRj5rUORUKGjkIzEpEhZ3JD4iCpvQ==
X-Gm-Message-State: AOJu0YwyLUcYRGZWDB12qSFNicV6+NgdhZyMhl+EOpEQkvMl7KuJcXJG
	oPt3snHl9ot3QgoET1YCwBUJfczmibR3ZYi45msAx/iqPUSKMU/6
X-Google-Smtp-Source: AGHT+IF8UDVWK4Skk4ZlNGshwxW7PJ/6S/WIVk0uQs5wZ/EnneK9HcykXPYay7T6RrHB7WIfQNx9QA==
X-Received: by 2002:a17:903:947:b0:1e2:a31e:2062 with SMTP id ma7-20020a170903094700b001e2a31e2062mr18166406plb.53.1715092566069;
        Tue, 07 May 2024 07:36:06 -0700 (PDT)
Received: from joaog-nb.. ([189.78.25.116])
        by smtp.gmail.com with ESMTPSA id b11-20020a170903228b00b001e3c01dfaf5sm10105124plh.24.2024.05.07.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:36:05 -0700 (PDT)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: freescale: imx8mm-verdin: Fix GPU speed
Date: Tue,  7 May 2024 11:35:55 -0300
Message-Id: <20240507143555.471025-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

The GPU clock was reduced on iMX8MM SOC device tree to prevent boards
that don't support GPU overdrive from being out of specification. However,
this caused a regression in GPU speed for the Verdin iMX8MM, which does
support GPU overdrive. This patch fixes this by enabling overdrive mode
in the SOM dtsi.

Fixes: 1f794d3eed53 ("arm64: dts: imx8mm: Reduce GPU to nominal speed")
Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 4768b05fd765..0d9abca58821 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/phy/phy-imx8-pcie.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "imx8mm.dtsi"
+#include "imx8mm-overdrive.dtsi"
 
 / {
 	chosen {
-- 
2.34.1


