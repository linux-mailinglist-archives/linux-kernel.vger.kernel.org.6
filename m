Return-Path: <linux-kernel+bounces-231878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668B6919FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3B628612B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE894F20C;
	Thu, 27 Jun 2024 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXsYebu9"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24E4D8CB;
	Thu, 27 Jun 2024 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471626; cv=none; b=XDyE6B08oByvJdyyIkY0Yy5A4qi/in/op33O1Ci5+2yEJ4ZvW9wZdeGKmYr8yLxqQfl9qR05hv5FgoLPPdRhaEoHKfyeiS9JC5v2xZlhuLuC9dBZoKjVLlWBD02k0DzC2RcFyz7ZiRyzir9iU/4Ks2Hlkc88eiiWw0ASi9F0W8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471626; c=relaxed/simple;
	bh=7DMtgvXyEYSd5og+rkKXuSUpVPmKdcLRSQ+zKw8jz9s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+13TjsQe047j4wY0pvpTZahj8Fb9vemb24kpg1OcWZBYqeTomXSnsQdj+yA4QPoVOmZwQZ9Un7tkRD4dK3qxMXPScTsTexqmOKUynwcyorKeEigZA9bpUBBC4jXlgI4rAVUwkGPR+XGChJY6DccgT8t9jwYvpDaiUADEnbwusE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXsYebu9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f9b523a15cso10558095ad.0;
        Thu, 27 Jun 2024 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719471625; x=1720076425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9P/6thWhyAhLlnTSORgZONADXz1PJKmrKN+CX9/Zsos=;
        b=eXsYebu9TS3pUaJig0uaEWp2405j/HifF91P1oyDZZdcfY22aOZ3roEWoi1aihe50y
         9QwUrUENT/cWbqIWeWWirQ1R+KIfbgmEeF57daOlRjRIFnIXkX84m6u2w5ArbMBkMKZL
         s5clLmbFxJK3pvUahkY5oqAwilaZdKWy1Shv2cRNOJIPhKhXBz01W6ENuO/IPlsuD8sF
         9c1KOfZ3MJ9Xr0d3Bj4ugHHbxtQaYMeDqqz2eUYiDJ7xx10tQM4oUT15JvsR20N/IbQO
         xADDyKB0XI/XmgWTX7TdtDkBZFackqdho13Ut6WrvXMpCAiX1vNZ/YiXlA9NJooaSFvH
         jT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471625; x=1720076425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9P/6thWhyAhLlnTSORgZONADXz1PJKmrKN+CX9/Zsos=;
        b=Ad1U9GhwT9UJ7HT8NVHSp/L7Cvl+ZhjmLAT8APtUvjhPK+GxZ3SoSyrjoG6vK0a6yI
         cW4/JAxJKUvrtlKR+CbWd9BQy7wSROtO1M8GxBKZC/W1i2EMAhU8DxVghPJWzG/Avhyt
         VCUdgZRLCXhfEbi3vWuAopr/CkiA1tHXAAWeC62ZU+ySIn6Hp1QOQ+oHIFSjnVj7GdS5
         0kW9wyEn+nVokYtCOq95NFckx6DFvFqJBh/ShbA5Nx+xEg43YqplCamGcQOZJ5sTpw9x
         Cz6JZeSopgl1MYiDWqwxuxY96eiAYwpjG9Z1JZw1EtI3FBmW08HV47a5lEg2E8uF1TSC
         UdRA==
X-Forwarded-Encrypted: i=1; AJvYcCUS8Sx69jfBWaCHMLEpILb/v4ixxUzlDgPegdkEleBCfOYjxIdlMfgOAoj1Oq6RkrObgD4sAxOa4GKhkN8tWZU5heUNnlA7vregYqusOYrOJum9yNh+Ak50O3l9rtfz+HqmYCUhXw64/g==
X-Gm-Message-State: AOJu0YyVAXyKGSkjc+ppbeigD0IAZSVxDTe1TgWyEEyZSZGdCvQ0skEP
	Z7OJsWk/WKzmL7B0vYhBTCWh6dt6NKMmMvvJF/qfcMyWJWtmMv1o
X-Google-Smtp-Source: AGHT+IEpk77phzTSqlAlmA5v27j5vJIbiA+vsz+SpeqBvWB618Go6G9fPBLxaOIqyfW/UwLFFfhDDw==
X-Received: by 2002:a17:903:1104:b0:1fa:97ec:3a4 with SMTP id d9443c01a7336-1fa97ec057emr42416765ad.8.1719471624571;
        Thu, 27 Jun 2024 00:00:24 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e306-713d-05da-7754-dfb7-477a.emome-ip6.hinet.net. [2001:b400:e306:713d:5da:7754:dfb7:477a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997ed1sm5962145ad.211.2024.06.27.00.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:00:24 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	amithash@meta.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] ARM: dts: aspeed: Harma: add VR device
Date: Thu, 27 Jun 2024 15:00:04 +0800
Message-Id: <20240627070013.2509150-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
References: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add isl69260, xdpe152c4 device

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406170350.zQo7bJdX-lkp@intel.com/
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index d99fba321379..8fb30029e46c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -398,6 +398,30 @@ imux28: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			power-monitor@61 {
+				compatible = "isil,isl69260";
+				reg = <0x61>;
+			};
+			power-monitor@62 {
+				compatible = "isil,isl69260";
+				reg = <0x62>;
+			};
+			power-monitor@63 {
+				compatible = "isil,isl69260";
+				reg = <0x63>;
+			};
+			power-monitor@64 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x64>;
+			};
+			power-monitor@66 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x66>;
+			};
+			power-monitor@68 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x68>;
+			};
 		};
 		imux29: i2c@1 {
 			#address-cells = <1>;
-- 
2.25.1


