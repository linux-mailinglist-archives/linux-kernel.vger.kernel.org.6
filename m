Return-Path: <linux-kernel+bounces-202971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778FE8FD3E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D987B26FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123D13A3EF;
	Wed,  5 Jun 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfejK15P"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A9138493;
	Wed,  5 Jun 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608119; cv=none; b=Gi9emqDBJx9ExZ95jxJ5XMzr6Hv+xo9Jcm6YNA+TTA6g7LC8xGXwSpPQv+hf5KFfowz5/ur/0Of8ga68THPCBNoLhBHyL+aWt+2jxI+zIfDteTpm4PaXteE4xjBI4o5VI6XLegwrI/TaT6UQGwHBbuH5dTnsvgz3dsDmkxcoeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608119; c=relaxed/simple;
	bh=ZQNd/I5dWnCXUigyzoAZF1pwJulE7kVfYEjlNVca/dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbIPP4dhdFGYJjYE38qZtukflGyiXO0FIsfg2NGNrN5KHhHov8pm6ZYNU0OnZmsVaY1279Y5CK9Tbc7hlY7K2LyarTAAdcInObJPCZfO1JT7Mw0B66QYlf67P735f3iIMUGaprmPEMPk+en3Z9R2t1AIXGwQhyo4vg/Atnok5No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfejK15P; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so79581a12.0;
        Wed, 05 Jun 2024 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608117; x=1718212917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uLyMpvLQ2nfxB85Lbnpwtsih80slOvRMVa14hvwXO8=;
        b=gfejK15PKkBJtOUxUnQTq54HSC27CsjJf8IRUW+n9us+2dwQWX7KE82hEfdhJCNc/b
         s2X/6RDvZ+KeH2VykQ9jycrekmitJ63KZrdaoFpamJSbw/WlDHOqrWcK1+Bqnu8RUXdb
         LIpXoB3wIT4pWQz59eObr7shkOxLfXt8J4itB3FALZk9wPyBhKyKp9uG05UTFcITvu1e
         HLTSwO/yr5VuD1s+JQRO9Y/K5RJgvI48wrkdNDptjNw9sa+ij8L2VxHidDB5NuftGBA/
         wD7vD2lRyBUB80Yw/F2Qyu+BV0+Q2LiRGUILTcnj6nq7pXvNZdO5mkJWcWkN32S1Eh/6
         GDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608117; x=1718212917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uLyMpvLQ2nfxB85Lbnpwtsih80slOvRMVa14hvwXO8=;
        b=p41VjcjedJDiIl1uyxRcEyA9ktD1xHgW3q01zXA17HoISc1nDKZmC2MNwLC3tDOa8X
         rRBlW5fdcSvfAZoaJBTM8gvDDteeVvPV9vIap4kkPdJrAvk2Hpej3G9Opc9BJ+hVXYaG
         QQWpg+XyBEkLtZkyX1H7a3KH9bggdBCv2m3PdPLU0Efec1M1cgzqlwWMUi2Hwqnj1h/e
         jG75YIDZPUdJ6p1Kyn7+ZjH0Gaj3tgzs71oBVmJaKPiHfPO9gtB8K2jhpeX7QOMfC8md
         qIIAxHuXEW4BHTusiWZZlq7IpapkMRTICN/tGSUhjzd8xLEs4BYarLeq2gb8OE8zHHXZ
         Ky0w==
X-Forwarded-Encrypted: i=1; AJvYcCVUsXPmv2DYeER6wynvITBnC2jkSxVGevxs+HIRa4fCD9C+r27BkSEB39blxLdEnBvQLqsrJZK6jJfeyVTED/UY88Y4675+tzrPKg131LorKuVxLs8qtegzMp3Y3BErJwTDYquygFfi2aLeaTJB0k60pFjdnBqWy86mvByELLLKcqdmEA==
X-Gm-Message-State: AOJu0Yw6bp9eqGcMHcFqNfNqJYdiA95yBz0ToLr7E1SkJ9SEiQFvL334
	e4PX0yLA0W2CDcbl2IXYpfZIFbkxCyJ4m9pJxKXgfUYSF2+zBfk=
X-Google-Smtp-Source: AGHT+IFkm6pEpa9c2BG9XpvddS6f3Lcy8uCRCwbthZdPaQvv53wnHkEA6vJp2EvgKZQRyYTeaPcaKQ==
X-Received: by 2002:a50:aa93:0:b0:57a:212a:a21b with SMTP id 4fb4d7f45d1cf-57a8b68797fmr2102682a12.7.1717608116812;
        Wed, 05 Jun 2024 10:21:56 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:34f:df25:1c86:f2e7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d594sm9666663a12.69.2024.06.05.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:21:56 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 1/3] dt-bindings: clock: rk3128: Add HCLK_SFC
Date: Wed,  5 Jun 2024 19:21:52 +0200
Message-ID: <20240605172154.193047-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605172154.193047-1-knaerzche@gmail.com>
References: <20240605172154.193047-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a clock id for SFC's AHB clock.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
NB: I've added the new id at the top of existing HCLK's, since adding it at
the bottom would change CLK_NR_CLKS and therefore the ABI and there is
plenty of "free" ids between PCLK_MIPIPHY and HCLK_SPDIF.

 include/dt-bindings/clock/rk3128-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
index 1be455ba4985..a6bd7f13d7f8 100644
--- a/include/dt-bindings/clock/rk3128-cru.h
+++ b/include/dt-bindings/clock/rk3128-cru.h
@@ -119,6 +119,7 @@
 #define PCLK_MIPIPHY		370
 
 /* hclk gates */
+#define HCLK_SFC		439
 #define HCLK_SPDIF		440
 #define HCLK_GPS		441
 #define HCLK_USBHOST		442
-- 
2.45.2


