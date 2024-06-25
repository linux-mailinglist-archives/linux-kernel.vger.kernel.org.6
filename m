Return-Path: <linux-kernel+bounces-228834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EBC9167A2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5751C228C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7B9158872;
	Tue, 25 Jun 2024 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ946K/E"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347B1581E5;
	Tue, 25 Jun 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318070; cv=none; b=VRIJOPv8MBwRotiWfcCMuUDTLSlr6/cpwcufEwuRzV0WJFBphfaKJDXnXsrsynZGBuJGyVH0ZewbpZCyy0vW6OSEV+TTVA8qGEhA4gTz46fBMqEPO7QZX/yP4VSmrzsS8u4n3KIwgQke9ZRd4j3wGFYxjXgQH50hIy6l+vJ2/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318070; c=relaxed/simple;
	bh=si+QcG6m2C7oEN8bRk2delYbedXnGccQI3/h8D8tJe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JQbhEmQBXk8agsgxCRJ/HA+5IpPInLQR3ijYqvuPNRGaYums1Z/b7kF6KhiitpLWyqfFAg/HFYIedDYSM6ufJm2+tqptMtNet53JkQpfkyx2meVGn9p6oEfBsvvyFUy4JCG9zVrR0aVJPKwL/XdiwZxqjpYWGIG0RC1dHcohjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJ946K/E; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36dd6110186so21259195ab.0;
        Tue, 25 Jun 2024 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318068; x=1719922868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx72SI7/2IoQxOX1b/fnYis0HzPlfSdpK4NVpZfxV7Q=;
        b=FJ946K/EwKY/ZwX6H0tgwRrc8Q3Uc+6WJ6DetJw+/loNyZ3yEm3MbUE+8FE7XnQ50b
         n/4D18JyjKxmgPADvuzB7bwtE47ARvI6Ek1Oaxe19rgCBo+xUKOXjgi3enCbjv0WseoJ
         EiBk2tSpkljSTlK1GixarnecOEdL5cfoVDikuOIdGcHKYWdne6EBYxs0XLL974SgFlxC
         47KVjd9Tbx0e9VQCJis/YHbh4bMeVjQFoPIW6CWFs6WfCoRWD9qsioP6WhrBgidMTUGl
         smPcGy19SRiTxqrVIVoDg3P2AHSKlBrdamR6OOBFO27whHgQltUyV0aPYSMbcLm9Ryjj
         9Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318068; x=1719922868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zx72SI7/2IoQxOX1b/fnYis0HzPlfSdpK4NVpZfxV7Q=;
        b=VQM4LDVwWu6updFYz0AS8uP63Q0l0V8UdEOflYTSfJmphXdw+hhmDPM0oEVNnMGiRv
         GOlu/EUKGhSfwy5RFgoGU+1ExlSYsaPq19mgOKBMK9spp4gytMm3NOp0UGLXKucSXTsC
         PlIAf3m00O3ougpqDTFKBvNBYlRu7nafpChYJkaoQ3LyW23YOHhrHHHhf0BpvPSIWkCh
         +fsKDZBXkWbQ/6S+uydaGvzpu/bgZOHmM/oK71EVm+wPTL8qTE3iazb3CrhzHgAs+m6k
         Ca5MWP/GgyDVA5WPmJSFGI5nVyYZgRpBacoQHChPTnDqjMjprqv4woTePeGPFl8Q7zJk
         JQrw==
X-Forwarded-Encrypted: i=1; AJvYcCXgcyBe5T2KUwLt0DnxWoVqQ9nH2oHdRGu6YI615xl8PZ+88JXFkYcBTKhPp99IHu2lJtSvPk+rifBIe09o9qXwghBYzcsPsiYZzOgSQuQEBOtvJJ+/WvqTTzd1wAR1WEDq/bVb8bnuQw==
X-Gm-Message-State: AOJu0Yy8DtRVqYGiZcnkwy4Za98DjTQybjfjfrbgDHHg22IquDvXs/p4
	UHxdYbrN7AxOQvcduyTnVxNTb2FcnvChr4keXBSy53j2PbavzjvB
X-Google-Smtp-Source: AGHT+IHOZoufCr8RHeLNcTuCCK9wtsYm/Zv5j+dnx22Bzhr+SOZilu3p95OTzvWMtGuQrrJqvyzVsQ==
X-Received: by 2002:a05:6e02:1d0f:b0:375:b57b:877b with SMTP id e9e14a558f8ab-3763f60dc49mr91838265ab.10.1719318067752;
        Tue, 25 Jun 2024 05:21:07 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:21:07 -0700 (PDT)
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
Subject: [PATCH 13/17] ARM: dts: minerva: add power monitor xdp710
Date: Tue, 25 Jun 2024 20:18:31 +0800
Message-Id: <20240625121835.751013-14-yangchen.openbmc@gmail.com>
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

Add HSC xdp710 on i2c bus0.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 7f6df8750953..dd8240279ed4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -175,6 +175,11 @@ power-monitor@68 {
 		reg = <0x68>;
 	};
 
+	power-monitor@43 {
+		compatible = "infineon,xdp710";
+		reg = <0x43>;
+	};
+
 	leds_gpio: gpio@19 {
 		compatible = "nxp,pca9555";
 		reg = <0x19>;
-- 
2.34.1


