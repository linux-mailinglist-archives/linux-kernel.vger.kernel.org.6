Return-Path: <linux-kernel+bounces-228824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00742916783
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CC11C20F56
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D21D158D92;
	Tue, 25 Jun 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyKqXHM7"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BFA158875;
	Tue, 25 Jun 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318047; cv=none; b=bxgCkW7stGISoqhywV5iua+aLXfeSKxwMxGgYGSoUZxDFbmFs3xsc8dSVC8pr3hKUwOYzsQf73xjvZf/pFbPhV/SQNlMTuD6zZiGmN3ola99OmDZIqN2nl9K6J15mn2OSGO3yTUFgMe48qLo7zfsqdcexcyGaW6mA/ukl+/kjvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318047; c=relaxed/simple;
	bh=qbm+zw4cghJrdfRu8H6624V4tnFLWrPxShcEBi7n0V0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKI4+3vdsRmHochFQU3p3hI0OIOoo2JH/ilV0tE6gvQ8XEfJhf0EDjxAvu93DgBi+C3QAra8RRe1bA+N24lNsdFa8mQPQ0EXo93hIzp1YBvKmg2gBZnLnF1q/pTa1OpjrEg6o9PNTu6Pd8T9EQUiLm0n2UCAhNiFqv83zbyttbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyKqXHM7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7067435d376so1703713b3a.0;
        Tue, 25 Jun 2024 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318046; x=1719922846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjV6Pheu2FSQvjGbirH3830/CoM3xL8kwQXPtOnBj6U=;
        b=LyKqXHM7ejQa0Kjqs1MXTCff+nL8KbAtCPj+hmv4LH1YoqXv8pgrPUHUDdXN7G3J/U
         Ub5pdxc3QnCmRocGREorE4Bp0I8HId3D5koCSnEMrcDft9XYYl1f6HzwbQBT5r/HGpV9
         Sts1QsNqeAWqOMJw4m0r6J2RmkLUyMUeOtot+suouU64+vOotDayxoa6NpR4crzPEen6
         47vH0D7OXrTykfkgWEjE8L0E34/TvbY0XLpIZ0DDi1+7YpxwNuuIfN/ylpu2mjim4dPa
         hrpYpO+vIgqB3XIiQQBCaUfVmp7J2VCXkAPlnqSs5CudEkRuKn3NFopi/nH5pUZdfdlZ
         FQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318046; x=1719922846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjV6Pheu2FSQvjGbirH3830/CoM3xL8kwQXPtOnBj6U=;
        b=JVrqk7gwJSPINT4UV6EdFxjeJDVeXRopiwGKq17DAf5k3S6LsjnPYGOoH6RFvdYqDQ
         G9GOL9oQ0i8gbwriG2CBSJs5bpFuLTCjA93gx2i1tK9lIK9FymhZPJqfi+IKrMUUSrC+
         elAEbv66zEQTYf1F5kbF2DZp+dVkg8L28KSOFVRyoG9KbjVljZjeFNB3jvwFo12DC1JK
         EzFCAg6QeVaUcQKokJPEHL2JbYyJXis5bYb9MCAecL17Ucx+91xsdM1+nlwMVCa+/hv6
         3qGSsACW8v9PcDcAHQ6ufJhhoE4jjWom0FxdNX/kYMtG+UO+kIkP+49+ar3KdYy+XpFZ
         /4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXE6xU0f9Pmbv2wzTkYpASApeGMYFpxGBigou0KN88axnRYBSvE+xnlfyetrE2cOVRMi0zwa+rZpXi++4/e/l/HJtD570B/npsgCNHZmBCjz8v0xDIPKMaf8MonWnM75a/KTa3ghwmiaA==
X-Gm-Message-State: AOJu0YzZUc9mm2wSwA+BUdAZxIN5w/+P2oygQrCiTGoQdVduKp25hQZX
	ywDmTh+V6nC+GW1eGuzkVP/aViWLmy3OPgfOe9OTme4jPnjxi4XbEefDqUY1
X-Google-Smtp-Source: AGHT+IFFdhHpU4jgClNAV3bAEMz5uJjZCp8aQ05nPpNWUjp8BsCdyY1VjPzpmn21fY2A//VF6V6sWQ==
X-Received: by 2002:a05:6a20:c303:b0:1bc:bb05:e0db with SMTP id adf61e73a8af0-1bd13c08ba5mr4344543637.23.1719318045723;
        Tue, 25 Jun 2024 05:20:45 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:20:45 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH 03/17] ARM: dts: aspeed: minerva: change aliases for uart
Date: Tue, 25 Jun 2024 20:18:21 +0800
Message-Id: <20240625121835.751013-4-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Chen <yang.chen@quantatw.com>

Change and add aliases name for uart interface.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 7d96a3638448..b0643d1d549b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -11,7 +11,8 @@ / {
 	compatible = "facebook,minerva-cmc", "aspeed,ast2600";
 
 	aliases {
-		serial5 = &uart5;
+		serial4 = &uart5;
+		serial5 = &uart6;
 		/*
 		 * PCA9548 (2-0077) provides 8 channels connecting to
 		 * 6 pcs of FCB (Fan Controller Board).
-- 
2.34.1


