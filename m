Return-Path: <linux-kernel+bounces-228837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704D19167A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B840281C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B87158D75;
	Tue, 25 Jun 2024 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKSo9kjr"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3A316F83E;
	Tue, 25 Jun 2024 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318076; cv=none; b=keGT/mEa2RA7IxGKmb3W7Hbk4PqV0hLFS9mIrx6Fk91rsqBWYoyrfst61Sv0doHRxmxf1xjfN2YAtD8Am8ozWRINGImiFc9xNsHE0Lkm0H12jE+oCM8n5sEMGufshyfwmRzOQHTwXWfZloVkHcV5AQlyaCos46WMEAyelW/6oCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318076; c=relaxed/simple;
	bh=61J0V77pGsOARz/UKhb6ICu6SXBr2OEvo5lBJ112B7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=us0lu62mlsi1V8Hrpzd0MxfDd0kMjtktWNx5d7YmHVs66bC6BtGLGTmTrhrXddELryyCvEcuclY2I0Kg+coexstzqu+ut81Ls2Z6rte84C+Ix7dSLqEQg6FvdX2rJUpe/4/c0dE5mxarX53IhNRk5DxWGoK4j4+nnBrOgJDKC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKSo9kjr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70679845d69so1748175b3a.1;
        Tue, 25 Jun 2024 05:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318074; x=1719922874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQQJMKc5pwaISrJte7FnhWZFwpzsNSJyBnkbk9/BOc8=;
        b=dKSo9kjrfo/ovGasCEqbTs3w8jA30nd1trkiDdeEep0fpigG5Ky8yesowktbeAroD8
         7ue3cufR7HfWFGYygR7IgJDYp1ymCj14w3Q459Yn2WEJStLPAghMr/yVcqO2v6gJQzfs
         cacMKWWInAqXvzFMLC9sGTWIwfeFRZihhgkLAFfddsNqwacgetNW77tBCO7G+i2YbabY
         /AIn8WrMZLv49hZgXDCNVVJ/divt7JiBBPBZKfH8Wko1uGyATlnnE81fhqhwmTQmD3hB
         2lVi4pHPAm/io7DT8P2o9OzgQE4d1p+pmjdL9aB8WpUCW8p5cKkjPkrqTNc5qepogo8m
         x1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318074; x=1719922874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQQJMKc5pwaISrJte7FnhWZFwpzsNSJyBnkbk9/BOc8=;
        b=CxtQyla2UR3venzGhNH3FF+XgN3vZ2RMCw83gYRLLqMUH0pohqMtQWGbfharXlnjbv
         qMwXh4wuTGJlQ5GZbNylMkiger/jyEIqOzXNxVFBqjjN7eaNgQ/Zs+12rKn3CIstnEII
         2rSDjVifaZfcmKNlqtzcUhrp7nWRRbRv9vu/xVPmsL2jGLb8xxKBfD+bavuJNwW2K3Zu
         oGxZQhRhYjvp0iVeNEupyvbVYUQm/NUNnEDDoARy8o52ZwYqxXfcQSNVh0nIpv0cj2xL
         37qQ87sm+w4dBv3+maKtwC1kQkbO1HfPlAfP+wgXUnjtvJdbg4HVzf6V6jX1lRW90slS
         KAUQ==
X-Forwarded-Encrypted: i=1; AJvYcCURmYDztOnZngzjgzrI5h5ob5hWjWRtAba578oUTrttH4KNeHRViFe0qzTmLCwiVGGZrCtzPI3B2ywprWYhxa8Vb+cZEqO4s3qJUjkl88sCMGp5AhH9cIEOyUmS1NdgNQ68gMo1VZc0XQ==
X-Gm-Message-State: AOJu0YwQyUj+VKAaY0FExhc0mDoeHWLbVixsOgGQfYFiNv12v2Znv7ac
	meafw0z4ABB3DHLsNy4xvMGVSU1jTRSNs+OIO8sgFA0B8cEOWXM/
X-Google-Smtp-Source: AGHT+IHuC5Cksz3HgmWz6HbqABAZAwsPRe5VrgqQz/iIA0Dgrph3x8gvPVvzvgAM8V48U1SA/+xHTQ==
X-Received: by 2002:a05:6a20:1e55:b0:1b7:b55:c87a with SMTP id adf61e73a8af0-1bcf7ff997amr5431513637.53.1719318074441;
        Tue, 25 Jun 2024 05:21:14 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:21:14 -0700 (PDT)
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
Subject: [PATCH 16/17] ARM: dts: aspeed: minerva: remove unused power device
Date: Tue, 25 Jun 2024 20:18:34 +0800
Message-Id: <20240625121835.751013-17-yangchen.openbmc@gmail.com>
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

Remove unused power device.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts    | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 8dd2bbb15576..288d4ba06b99 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -165,16 +165,6 @@ power-monitor@41 {
 		shunt-resistor = <1000>;
 	};
 
-	power-monitor@67 {
-		compatible = "adi,ltc2945";
-		reg = <0x67>;
-	};
-
-	power-monitor@68 {
-		compatible = "adi,ltc2945";
-		reg = <0x68>;
-	};
-
 	power-monitor@43 {
 		compatible = "infineon,xdp710";
 		reg = <0x43>;
-- 
2.34.1


