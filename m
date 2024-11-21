Return-Path: <linux-kernel+bounces-416504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE99D45F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E214283E28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B2D19D8B4;
	Thu, 21 Nov 2024 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmbieKGs"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A219CD1D;
	Thu, 21 Nov 2024 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157629; cv=none; b=DXj0Mg4Btm3PMnbyq83HkkzD22PhcXXsq/W9DBiDweVSW/QlLHGginw5IrUBLNcxA4RCl2Me+jhtANO8BAp2xC/mMw/JO+lIb+KQTeIBu+ZJ3gfkv30meVxbJCkbNu69oljtl9Hwbi8U92M11/yxpjvHc7dZkD/gAlrxi4hdrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157629; c=relaxed/simple;
	bh=OSaV9yhfaiRJQCqUOYO4E35IP2OS3XtBR3isnThTRXg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WkR75bhcl+S4kR5S56PGcfy7vge1dXYNTxVWu18fsS5kcvocJqrHGbE91YA/WLx9Tdqjyh81JueWXlTTOSeQYEooqqHAp6oTV1L2spSfX9szsMMdoDw479IkUSuRHyqy1dR6av/MKhkMJlMLdQ+d0vl641pvOWxcQDPqbAlqrm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmbieKGs; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-296252514c2so385331fac.3;
        Wed, 20 Nov 2024 18:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157627; x=1732762427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dXl5oVn1MSHtvZwlH+NvQIwSyHnFTQpHuAwir1q04Y=;
        b=OmbieKGsXRt7c5+CzUMto5sNoMlNbmQzIUB7/8OdFz5m5Lh7M2MVHg3VlzXze6eCHj
         Q6vBP13S3jAnGA5TCdSPglEugvrGZO8iQRn1qnG96XFQ43CuWvDduLusguiEXqwkojK3
         s+2FSLXlLLaUSBqJRpXYXSSLOUTB7uLH8pmO+Xko6YeTWY8UwHIsS8LOVrvCCk+LIYrk
         ngsQ8EZeKaM00jyBZIEBIyg3B4wjJ5eV5phhMTI8Ine8s84iiTQkXbmGVarbV0ifdiNu
         +1+gJADt1iQ8xex2YJNO6FC0wu06JofMW1wA3nrGlK+CQe7AI3gnwI5ocmTGOQJ4simE
         dZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157627; x=1732762427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dXl5oVn1MSHtvZwlH+NvQIwSyHnFTQpHuAwir1q04Y=;
        b=eDSMWKPSFSn5h+R26GlWZi0mU/HGEml1YYoBTKj01IFe2qKS2wrzEWU+DmzNwcmOzh
         mRLZT0xbOZRz1GiS9bXFhbTs0n12BiG3qDNnqClZf3+S7zat5vxBrjSvoTvUNK1bKTy4
         +sUhFKnTkY2KGd6XFEfhiHrjDTofJ+ePVn6+Ghx1p04N2o66yRnV/M1BnU/8Bo/5wJrL
         mBU6TW9s/gcOUcyQOzdFR+5xbpyVFsQtnp7SuNlHyO2T03sGxUkOJntIhhVT9x0v7nh4
         GC24hV4vDdbIsWBs1MRwR7y7s/GjQARxHgBqw/wdPreXag7lfzXhCtu98pa+OAB4Rw+y
         ipcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxgtmBqa9L6UBgZhrc2ArA8NAL+Y7NOUcnu+KTYUfHyvQTSAsxTKShyxx2BSztdy5i6o2c5iOdMMuCIyvp@vger.kernel.org, AJvYcCXZjmxK8WMZ7f1VtCDSCmpSTYjwI5FC+9iSH113Y1gvgDrHKwVzwqFgKh1byVy1b6q+DNG91n3MOQ3P@vger.kernel.org
X-Gm-Message-State: AOJu0Yz85iEZxlpUf38M+xOTxzWbG2EY/37e83CFuSYT0z01FXmOgkOX
	/FcVvtiyx5aqnL/SPJ2+Gkv89c8v7T+ilhjnI9bsRpDEDhR+9h7R
X-Google-Smtp-Source: AGHT+IGfUxN+yNPBtbcXbTFe/qYk+jbA7fDrMhXuaqkExtEYuXDRgyQhDfpiy7nwzeimN/QIstDcWQ==
X-Received: by 2002:a05:6870:d24b:b0:270:1fc6:18 with SMTP id 586e51a60fabf-296d9a6957dmr5514274fac.3.1732157626867;
        Wed, 20 Nov 2024 18:53:46 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:46 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ARM: dts: aspeed: Harma: add adc128d818
Date: Thu, 21 Nov 2024 10:53:23 +0800
Message-Id: <20241121025323.1403409-7-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ADC128D818 to bus 22 and bus 23 for voltage monitoring.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-harma.dts   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 58eba5fb6262..947622ead349 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -529,6 +529,19 @@ eeprom@54 {
 				compatible = "atmel,24c64";
 				reg = <0x54>;
 			};
+
+			adc@1d {
+				compatible = "ti,adc128d818";
+				reg = <0x1d>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
 		};
 		imux30: i2c@2 {
 			#address-cells = <1>;
-- 
2.25.1


