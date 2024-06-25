Return-Path: <linux-kernel+bounces-228828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B75916796
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E305E289672
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C7E169AD0;
	Tue, 25 Jun 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmBvHMwd"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A633161939;
	Tue, 25 Jun 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318056; cv=none; b=dlMHS2C5cYHQl6ONHniMQA8k/ss5Mcwis0AlNpZR3PzhbfcesB3zGj6QRFia0I+3Y/jQ3fDZmwLuGnBohvbhknM+loRDkeICUHUsdLsGci/EDZYdpFicQaZHVN2KJYwrcWKxm8eA9ePjv7U3nQb6aTEDVY5NPJ0LKDOTkD8WTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318056; c=relaxed/simple;
	bh=P73M8VpHWi6rWtNMNmB91WVVJyjeCDL6mZ5Ab6UtVh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLFEgIMd8C8xrjXF7Iq+NgthxPOeIjaBk+y/KKGgtRe8ABvg9aE+ov8glTNLLarn+rn1LjmjZCDeqwY5lF//mnQVBmIX/VGv/3rRgxEIbsys2runyzL7OlXoiZ+f1273fFZ6hgN7PO/9Lv/DLjS083w108luEL9xIhcnqfzW8Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmBvHMwd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7067435d376so1703801b3a.0;
        Tue, 25 Jun 2024 05:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318055; x=1719922855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnsLFvvKnkuLIEYBYSGcmnnHIoHb+QjNTsPSZ0S+a3o=;
        b=kmBvHMwdTlzGd/F9FtBQs7gedK0hvLifeK8PvLc5hs6oo+4MXR8KeYB9uDvk1d/CCP
         6ZA8kvi8gkzrMN1xp4Doct9xnmlX7fUufgX9IrrUwxGez25o74a4feXZH1L2h3wrxlPZ
         BuGOFYskYTK3Zxf5/Ec07I+GfUWxpCcRFVgsRfEfaySwMyB0xtfjK80rQZw1VOLiycW2
         7CeV2jQR3Y8xJQm8L+sQpldMyS95xTvD7HrYPy3H5ANDej8Ib1it4UnTPd5fE9pIQBQ3
         pP+UPl4uICArHUIU9o2BVgHI6rh+mYcNBB1T2zeQ4AtIFEWVokEZtFF/DkzVOqnwaG2t
         dcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318055; x=1719922855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnsLFvvKnkuLIEYBYSGcmnnHIoHb+QjNTsPSZ0S+a3o=;
        b=vL3Cor0WBiH1E0KEK82aeKyebZSOdosf0+ifuS5u+W76VnpaE/73XOaXgWnn/XfykN
         8ImBlPl8zQAmVenwZET51wQwWn6ETAVICdzwf7gmNaacjKEmQJTtr2aXHa23Dwj5LPnq
         FXXjII4CTlMkfQ/WpDihprLW3Kc1WxaqoOJlMoFL3dFQUm15R3LBuKaoM8KE6HuuM+yv
         ZlUjybprzb0E3VJ3acpiXz+31Hx4H3ZAjQdzhP9U13fhMT0G+J8gpMwm+d/guqADyOH0
         0XlhnjP7+gF9818A0CNXQpMihdXFetBp4zw0eYq42n47J3WKNMrObC5n0E38mm1UhEeC
         dppQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvNncvAxM2cwOqSJ/VyFQfR7avMry11qXjCiNXCsYBguZoNeH9O4ACqNIHRoqSYIlSXtk9A3nVgW9hobVEKCvOk1kc43IgAQvqfyGB2Rnd3jyyykV8HolsN/OvU+20FJ5CV5py6Q5cEQ==
X-Gm-Message-State: AOJu0YwpN8F8QRxCVUdzd7jQe1+cGO6w9ZsVnzu6iQrn4PX1+nk9sEIa
	7+2le4YPIIToIM6UU8e3CtqaXfiYMzduSE0p6Kd8gFsELfa4xAdU
X-Google-Smtp-Source: AGHT+IFG02b15F29ywDsOysrQbOuQkofJIJGxS0Uwd9bSBE8/lC5gO/YXSe8CYc3kdE6bpQiugt1hQ==
X-Received: by 2002:a05:6a00:1d8d:b0:706:79fa:37d1 with SMTP id d2e1a72fcca58-7069145a734mr4696954b3a.17.1719318054585;
        Tue, 25 Jun 2024 05:20:54 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:20:54 -0700 (PDT)
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
Subject: [PATCH 07/17] ARM: dts: aspeed: minerva: remove unused bus and device
Date: Tue, 25 Jun 2024 20:18:25 +0800
Message-Id: <20240625121835.751013-8-yangchen.openbmc@gmail.com>
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

Remove unused bus and device.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 4d67ef29023c..a80c46c1962d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -336,10 +336,6 @@ rtc@51 {
 	};
 };
 
-&i2c10 {
-	status = "okay";
-};
-
 &i2c12 {
 	status = "okay";
 };
-- 
2.34.1


