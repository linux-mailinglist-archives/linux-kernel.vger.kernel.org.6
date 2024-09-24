Return-Path: <linux-kernel+bounces-337228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F68984740
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F551C22984
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A819D1A7AE7;
	Tue, 24 Sep 2024 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuR8yeIQ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC521A76CD;
	Tue, 24 Sep 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186671; cv=none; b=KNGbEK4yVEesmHHwBap1CHUciEEmZqZEYaEzQujJlv0kZeM9uB/Z5gC+f/nJa7D6U2PRhQTpcz2ohZzNbiIdn+09mYolTa1JfsKCacce0L7RwfSxvJbDsQL/DlPilDaCWwYTLKhVUi0KRSYsTlMnRpKOZrECmEYj39mlEi14xw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186671; c=relaxed/simple;
	bh=+cAOnt37wBk+RTdITGT6cW1iNG7rZEAwVnYrUEP31/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DEemu16eK1rzicAxsTpVIzsqSCjP1p/HR7X+KvzCIIs4RDyEjKLhiyX2xIA4XAjMj8KXxpDhE7jf2Eya0ePZCdTVOwxlRJshFHkdp6C/WdeULEkKk2BdN5s6r1zB7rOqVfbImsah7ebo9As4GmyPSfYdOT4AP4P6csqw6Tl/OLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuR8yeIQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2057c6c57b5so33941195ad.1;
        Tue, 24 Sep 2024 07:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727186670; x=1727791470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nx5Xbta+5PnRWKrihSqO2loHlGD3cDUR+R9/JM+v/8=;
        b=YuR8yeIQO+W45nHK+5Hy5uEvYY7HE/TLLfZAQqLftoT8wvwlP1YXIeZ3Fz4k/Ptgrx
         LCgDsZwT46MZd35k2WXMQEr4M+YBi1bnCCDPQSplc9PQApxSsp8z6eU1RmQYlJ+r19QF
         f/Ze21cMW6uAEEM9vue4L4x6OmHBuXqBYIeaGSjh+Ib37YWM7pZBGTSiZQ+zMZ/yxsSB
         LfK2bF/UcfDz1dXUF0ggnyW/75yJoM+16ljtrm6uMY2LB4Goi3023zcovBAXaXClbKm+
         l2polYaAZm7r5ZCBGzw3/06ercf8+XbXgwT4/vWqYChyn7oMTxAVliveHqT0mQ6i682F
         bphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727186670; x=1727791470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nx5Xbta+5PnRWKrihSqO2loHlGD3cDUR+R9/JM+v/8=;
        b=ar9Fz0Jb5IN2oNwIj6JkDh5TzO9jm08S3Y/W1hAt2WqHhwO1tSNkIBGYSETcOsPvo4
         0hL8f9cGlxlZtMkQFZn7N31ReUfEKObexCgXgHDp0zXb9CA/bVJh6iEOQmlph4m3Xb+n
         Q9Eg/8pC1cXQOCsVzdDMz4A72T2FPm9cHrB84MFmFe3p1xPxZFBvtEspR+nOEkd0DRA4
         DemcSNGkT+Nsk9+lX9pcgaJtPgP3u7NbcMqAgCvhTRr/hJ5zK1rcALUdupG23MRdA5Uk
         DPP1X2Qf6pedtId9lG6frBQna+f6fYfmNeHgcltNQ1wuOrJAJY6YP3IWXDD0UfBN8Zvp
         H5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+S/AagqA3Ues+ki3gy97vxHiO0fYR6jh1bL0v91mgj9Bbhp98jTeXwYo29FPmlwjAHRgT0NSgS1m5gcJy@vger.kernel.org, AJvYcCX+p8p2T8LEA0Wa00Iu1gf5ACujZNpKZinhZd32wcjPaswVklgSdQxp2z6wJpSOL7+UoMKAeGN5Hvmm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3seQuzhiXg7izWwqJdRjLJ4xXwT0kvAnXQWj4kMBCluh0EDUV
	ZLihAqAo0wxLj+TdiaCpUBXIttCl5DTzGqLuIRDmq+g+7e/KKp06
X-Google-Smtp-Source: AGHT+IHq5h/XO80kmONWk0SB4WxBpcrYJRobQWQjI/0AHEaOTReNvD49VFdzL/HURKTd1LRSBu7zgw==
X-Received: by 2002:a17:902:d4cf:b0:207:3a4c:8c6f with SMTP id d9443c01a7336-20aed16ee23mr46292545ad.29.1727186669627;
        Tue, 24 Sep 2024 07:04:29 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1821f33sm10678895ad.219.2024.09.24.07.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 07:04:29 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH v1 3/3] ARM: dts: aspeed: minerva: add fru device for other blades
Date: Tue, 24 Sep 2024 22:02:15 +0800
Message-Id: <20240924140215.2484170-4-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
References: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Minerva platform has 16 compute blades and 6 network blades, each with
an EEPROM that can be operated by the CMM. This commit adds support for
each FRU.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 334 ++++++++++++++++++
 1 file changed, 334 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index c915db28a806..468a33f50ef2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -23,6 +23,32 @@ aliases {
 		i2c19 = &imux19;
 		i2c20 = &imux20;
 		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
+		i2c38 = &imux38;
+		i2c39 = &imux39;
+		i2c40 = &imux40;
+		i2c41 = &imux41;
+		i2c42 = &imux42;
+		i2c43 = &imux43;
+		i2c44 = &imux44;
+		i2c45 = &imux45;
+		i2c46 = &imux46;
+		i2c47 = &imux47;
 
 		spi1 = &spi_gpio;
 	};
@@ -493,23 +519,239 @@ temperature-sensor@4b {
 				reg = <0x4b>;
 			};
 		};
+
+		imux22: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux23: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
 	};
 };
 
 &i2c3 {
 	status = "okay";
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9545";
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+	};
 };
 
 &i2c4 {
 	status = "okay";
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9545";
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux28: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux29: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux30: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux31: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+	};
 };
 
 &i2c5 {
 	status = "okay";
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9545";
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux32: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux33: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux34: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux35: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+	};
 };
 
 &i2c6 {
 	status = "okay";
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9545";
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux36: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux37: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux38: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux39: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+	};
 };
 
 &i2c7 {
@@ -536,10 +778,102 @@ rtc@51 {
 
 &i2c12 {
 	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9545";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux40: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux41: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux42: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux43: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
 };
 
 &i2c13 {
 	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9545";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux44: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux45: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux46: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux47: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
 };
 
 &i2c14 {
-- 
2.34.1


