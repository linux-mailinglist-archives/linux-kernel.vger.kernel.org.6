Return-Path: <linux-kernel+bounces-211654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1777E9054EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95500280DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB02B17E445;
	Wed, 12 Jun 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UP2RRHXv"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9C537F8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201869; cv=none; b=OI+pkzLqhbJ3l+1ywt/ESc5KyiPtlQcDWKoiqJKch7Eu8ns/r9O7u92SgDhHntCc9klV/16o1Z/2H40SopvNzt/gOuv8zqLKqmEGr6+bOhYHR1d4K2hIU+UvqAKcz0XVS44gA+BUrYoEhMSVsai9J4VEYIdIwcC0gKfqe0uwucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201869; c=relaxed/simple;
	bh=ATkFqYSEubTLKl2ilLKSe/ndq4Xwg9dhvcKMyEPYaEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWc0/2xyyUhsibNQ6/iknbfN6vOGUZSGIjbVFwwhRb3yZPHotEQhDP8LTfTUK0tbF9aiggN5ytU4onAviiAKQzFobYGWjsvuKgIaZt+wcJU2FwAwAdho7aHiJckY58NWyjhSLkGjb83oYVM2zNznQylxzI/KrbfgnoyGvL71a0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UP2RRHXv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so9168015a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718201865; x=1718806665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ra/aultLLqSMqirFger1rlz2sqaFfvVtkgbMOB08yYg=;
        b=UP2RRHXvD+iuC5zlCx2wDECZEpodQXKVAAAt+XeaOTkWVtIfbrJbBsTSmws8myKCEI
         sITJxaaQqXHqp1OdbrQg/eQIY6R+o3dw6pkYYCFszvSRkk4dxT4a1C5+nzXkbTmplJ5/
         J4LPKxiTu7q2jnjEu8DkOavps3qh4Z4Bs/Z/UHDzCSfdIfOTSG6xTvIntRlBM1P7lCZx
         MEigM2TtQ4WI6DUevoeh/P8J3OVSpjwjXDIKGkD7MxiUMATw8F39qP4tRCj80YYLU3Qz
         r3aOkriIkoXA7v9FcHgKfSi+kW8p0YoM5lra6/NQQ20LYTzJGc01937YmCGTRkX/hUzF
         EWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201865; x=1718806665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ra/aultLLqSMqirFger1rlz2sqaFfvVtkgbMOB08yYg=;
        b=Jah7OiTYYB3fwq5D5n3PJjg2MBaX5ZZAhIBJH9RmYkyycYCHWa0bg9xFJ8aqKEJfFe
         gufGJccAu3fL5UoD7kYoG3xz2CS1OBpAVS352UkbDFHrtnvRMboWT/5LmevLwf4BqpDl
         yuSIW32EqqrwCjWzIfV9hFeOutOY7/A0dWQRRq8WmRe2w5foo//l+3WqAIK+STH1KbM6
         8FlY8om05fAYDDcQqWgjVck1qPgU+h8arK+css+Rpf7xfUl6XJ+8sMgUMi/lXFcQy5fl
         GJFVJWnS6H3erL/KVmUllOrNqWtESZCBy7j/MQHXtZZCHrnkEpfZ5gcJtrMg+tRZGu5k
         4+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBXGPvvk0YuFO6nuQagAQaqAD8Q1KD8Z4809zmrWk4M3i5pzy4zBlp6uo9rQ6ujr8eJ93iOZxuTKYQNnGic+NdHzDmlqjex6S84UPb
X-Gm-Message-State: AOJu0YxNIrgFF8oHAsHsCCNpqd3mP3DynyxhsNMzn2LIot5UDns6gCFc
	wtLLu9+sReaESEiss3drtVamqYpu5H5LYLQPRkBsdyxPfNbmWyLL1tbD5+snw9Y=
X-Google-Smtp-Source: AGHT+IE9mBpInZsubvG3jOv3n1DIXRtg2c6jpbSypFQqfzQG15LBL3RZwuI1ajhdr9B0yz1D9TroLw==
X-Received: by 2002:a17:906:12d6:b0:a6f:1378:1325 with SMTP id a640c23a62f3a-a6f47d1e38amr128483566b.9.1718201864711;
        Wed, 12 Jun 2024 07:17:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f11e88ccbsm517639466b.133.2024.06.12.07.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:17:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arm@kernel.org,
	soc@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Daniel Tang <dt.tangr@gmail.com>,
	Andrew Davis <afd@ti.com>
Subject: [PATCH] MAINTAINERS: ARM: nspire: add Krzysztof Kozlowski as maintainer
Date: Wed, 12 Jun 2024 16:17:40 +0200
Message-ID: <20240612141740.8470-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently there was never a maintainers entry for the ARM Texas
Instruments Nspire SoC, thus patches end up nowhere.  Add such entry,
because even if platform is orphaned and on its way out of the kernel,
it is nice to take patches if someone sends something.

I do not plan to actively support/maintain Nspire platform but I can
take odd fixes now and then.

Cc: Daniel Tang <dt.tangr@gmail.com>
Cc: Andrew Davis <afd@ti.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 647233a62f50..4b262cb060b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3048,6 +3048,15 @@ F:	Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
 F:	arch/arm64/boot/dts/ti/Makefile
 F:	arch/arm64/boot/dts/ti/k3-*
 
+ARM/TEXAS INSTRUMENTS NSPIRE ARCHITECTURE
+M:	Krzysztof Kozlowski <krzk@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/*/*/ti,nspire*
+F:	Documentation/devicetree/bindings/*/ti,nspire*
+F:	Documentation/devicetree/bindings/arm/ti/nspire.yaml
+F:	arch/arm/boot/dts/nspire/
+
 ARM/TOSHIBA VISCONTI ARCHITECTURE
 M:	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.43.0


