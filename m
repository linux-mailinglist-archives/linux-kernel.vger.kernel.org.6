Return-Path: <linux-kernel+bounces-265307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F89393EF54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F69282127
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1211B13C821;
	Mon, 29 Jul 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gvzjSWcT"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DC913A868
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240080; cv=none; b=ZeIqHNeWHh8SIM6DSFxpaTkrcI2dcSKTfNw2mdLJV5mL0ngDP6QEb8e/05/s5N0OhXuXxKtPrRcnivZrMoF08Byd5j/8/Su65+vZQPXkRJv5Zd7IzO/3Vjd0i2h4uEQtoLUwT9YaGN44v/ErXVeZ1dlbkLo8MamsVvbqHy9uMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240080; c=relaxed/simple;
	bh=Ws5NM+P7MDrdFopIXmvse5S24KmyyD/4+cTZxJM/IqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsRZ7vYOeiZHL0p3DehtTA6++/vXUTi2qfbNs5Plxbv8GxjqhWuehlR9Gn88K8Ooy7Yb7cZmynYpdpk0NhrHdBYz+T1PxBg+OYsV889QkaSS7wDLV/QtLJURE2kd+i0nAVN/C7PO4TlDZOItzewt7T+K2OO0fC+nWdUd+um39eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gvzjSWcT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso12641205e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722240077; x=1722844877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU8YPDGhfgyNA8aWOgCS08s+SEmwnZ36/MbZAdv9Jy0=;
        b=gvzjSWcT6vfSd53Z1VcrNcXFcdBbrUWGjiIOM5bkH8L/yV9oWYRUGg38K2bJj9pkmW
         7j4ivAknfnMT31aADaNghNMi0SAIBYsM9AEKIlooqs+jq1UsKFgX4ZwRDSQihcOH3Z1n
         K1DxIygfhPgB2w8pQ4RgtlxKJQVgX1cKOkVfvxsvVXy562TBHczLt1aBzOSBkmZ1L9Fn
         S/SdvqKoGgpPME+SpKZRGReQJIlfJTH66nJUNiOLLe3GXSlwNo6Wmc+tm+R6URsIuTfH
         WpeKy8sAEIDGG18OX5Xrln+j1dQho7iBPRtxHPh7OUZ7ZWNYn0v7/dau8x2/3mF9rZYh
         4TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240077; x=1722844877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU8YPDGhfgyNA8aWOgCS08s+SEmwnZ36/MbZAdv9Jy0=;
        b=F7okpMZ/pzHm9mIbaRdfe7dDWBtXW/7rTM0dcEqjNKtsJ32ydayXENvWtkW0pXGkJU
         Z6BcD32vb5IAn82brhBLcCuY9a1VMimm1c4Gm9UzSxkLj2Zr8EATDzIpzJ0+5BL3sN3t
         wEpH7Lg0U/1s8O6AaK1wJSnN0bVwDdgSuMfuU7ur5IoAp2XMGF4gSvVcGBNrEdhVXVDk
         EA/HhoOmdFLrCRB6bZhNWTZy+p9Ko7Sbw6/B13cEgp3OBl/RP8TXfPlLVzR8bbKBzVvg
         M5kyVJY5mh5h211RaKrvF9GwBzBgha3y1ZB3dA8rB60/2SkKzcui+r7M3gptUxUoc5Ec
         jRng==
X-Forwarded-Encrypted: i=1; AJvYcCXqw5esjWOidcYmuNKnHJ8AXPJIxvSNbhjVVW0IQqQdj/PVvB9E61pjLdCErQ9tOi5Pi88ySGT23R2PXRwx01suLGSkQ3cuIFYcAh8m
X-Gm-Message-State: AOJu0YzA1OXOdGa0BwiegOTxf7NWklFaCQd4BJxYEwqUyfyIkLImBuIT
	4svYAjnHfIiQl3B7AOYlU+4+4whIJlzW4SpkDBdVsCqDhVQRuCRbJdwUpHRESYE=
X-Google-Smtp-Source: AGHT+IEzvxgrlq2sVwdVFU/d76RGHkKf/FL9gxRWixH14NbnUpqsy79WU0duVX8v51Y9Flhr4p4u/w==
X-Received: by 2002:a05:600c:3c95:b0:426:5dde:627a with SMTP id 5b1f17b1804b1-42811dd48f9mr43960815e9.23.1722240077554;
        Mon, 29 Jul 2024 01:01:17 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42819d9a007sm45452635e9.1.2024.07.29.01.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:01:17 -0700 (PDT)
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
Subject: [PATCH v2 5/6] arm64: dts: ti: k3-am62a: Add partial-io wakeup sources
Date: Mon, 29 Jul 2024 10:01:00 +0200
Message-ID: <20240729080101.3859701-6-msp@baylibre.com>
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

In Partial-IO mode there are a number of possible wakeup sources. Add
the list of phandles to these wakeup sources.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a.dtsi b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
index b1b884600293..5c13851c29ec 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
@@ -123,3 +123,7 @@ cbass_wakeup: bus@b00000 {
 #include "k3-am62a-main.dtsi"
 #include "k3-am62a-mcu.dtsi"
 #include "k3-am62a-wakeup.dtsi"
+
+&dmsc {
+	ti,partial-io-wakeup-sources = <&mcu_mcan0>, <&mcu_mcan1>, <&mcu_uart0>, <&wkup_uart0>;
+};
-- 
2.45.2


