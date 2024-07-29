Return-Path: <linux-kernel+bounces-265305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD74B93EF4E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAB02829B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E6613AD32;
	Mon, 29 Jul 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qy9hhOBt"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0FF138490
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240079; cv=none; b=PJseRu8k0/K0HzmoGBmsUkfgm6CfWgZF93mZZycR6aH8A84INBsGyCf10anAluCq3e0zcIKjssMJa4GhRGZnPAdaeJVdStV3oqDszV9ZNUfZm01uqI5tjEA0ltdDgV0/hIRUajGmpKXonWoj5dnnP+k7SQ0ux2FIRDjeUiLOkX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240079; c=relaxed/simple;
	bh=53f9JH01fR+1+uKpHwhb0lHI7XimsByJJ1fOG30/dPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA+aRfufo2DpS8la3QgLZt4SNBqH8wzWrZsiZeii0KOU64gChuEp6aelj+2OSRamMBrGDEHhsmEjgj9vAYaab3t391dIVY9KgYccxDpTx8lY8GNpYb+asPBWJFDJn/g2fJcf+MNHYF8cq+IaGV3eO8rqu3HuIu/NiSbtkOPwNEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Qy9hhOBt; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f0271b0ae9so40593101fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722240076; x=1722844876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qwj4fJ5PcTIVxTcnKoK6Sn5Sy7ClPbtzG5l0PUGLdrw=;
        b=Qy9hhOBtudUvBX79A3IfBjQ/H6JTU3EYToP+t70GXt5u+Ums7uG335Nukq/NvLiGya
         YRh9TmV005khxxdQBDe/cdIxPcP7DnvVNBNrys5ySnBkzmN15ryjKXFq8YQ3ECd9RwXA
         EZj9NKZyoLEZIUPAVmWL5g+Z/l4KCgEBgTx+RUEkK+1T3cUyK8052AbNn3S+Eh0FeCYq
         yQZyQPTxf36cFf3hR+vgN0Eij5n1eP0nluBC47AHaCb8UDTsEhpF6RRjcTax3mLjOBHa
         jiz1yUs+wy/99whDdvI3El2iqSckzHeQea30KkbNI5mLTZXz6gp0/0MRgtvXumXFxhU+
         UdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240076; x=1722844876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qwj4fJ5PcTIVxTcnKoK6Sn5Sy7ClPbtzG5l0PUGLdrw=;
        b=k+5EEQxcXQfv2Mm/wUmU7J59nMGTcSTm+vrZvxCX1lR77kJJCApogRztdCs3Wy2Yv2
         U5VS893wiw1R8awcu8cf3VTD3LZjgBb+h73WQIfQFnMLzu4IFa6bEP0dmDp2PGyLMPk8
         2lNAKcW6tpUl/NW9XlfKbnKovZuqWtyO0r0C/uneSy+uOod0w+bLTidrxslqHjGxsi7N
         WmsuWD3QyO+mP/NMjP86oUTkqHHl9zhRB1NqGWitqIKG2Tqo2ajKAz5Cn++G9faXXuvT
         Gj3/FzdwKBZTwh1iNXI8qMiIB56lmgjkcjxuaVmu33jFqAeGFsM6liTssuRfvUMBWzsy
         FaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmn/riTHVt67UsGwtUKKCmjizC5Jl0a7lghlIaEzU8BGeX/yj2484iYIAlCUuLdkGoeNtBFkT4bmEL9n6db4fpxtPdtmmWw2E893YE
X-Gm-Message-State: AOJu0Yy61i9UWU59iEjzam2DPsr3wD4bBEZ5sl/MIkN6R2Qbmu1/Yp+X
	Zxwq/C70oMPyipcSu3k5zBO3XB11wBRPhOj0aodp4IP1Rfcpx9ou53t6UX1UCpw=
X-Google-Smtp-Source: AGHT+IGk+Ma28FqZivTy+Lwf3ij5OpU/7rZpCibyXnynu0+yv9j7Y81EKKbkk1ve4///COt/muKc4Q==
X-Received: by 2002:a05:651c:102a:b0:2ef:2d58:2de5 with SMTP id 38308e7fff4ca-2f12ecd1b89mr39762381fa.11.1722240075632;
        Mon, 29 Jul 2024 01:01:15 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42819d9a007sm45452635e9.1.2024.07.29.01.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:01:15 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 3/6] arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
Date: Mon, 29 Jul 2024 10:00:58 +0200
Message-ID: <20240729080101.3859701-4-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729080101.3859701-1-msp@baylibre.com>
References: <20240729080101.3859701-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WKUP_EN is a flag to enable pin wakeup. Any activity will wakeup the SoC
in that case.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-pinctrl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index 22b8d73cfd32..dd4d53e8420a 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -12,6 +12,7 @@
 #define PULLTYPESEL_SHIFT	(17)
 #define RXACTIVE_SHIFT		(18)
 #define DEBOUNCE_SHIFT		(11)
+#define WKUP_EN_SHIFT		(29)
 
 #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
 #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
@@ -38,6 +39,8 @@
 #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
 #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
 
+#define WKUP_EN			(1 << WKUP_EN_SHIFT)
+
 /* Default mux configuration for gpio-ranges to use with pinctrl */
 #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)
 
-- 
2.45.2


