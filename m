Return-Path: <linux-kernel+bounces-568433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2707A69560
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872023B7CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8611E5710;
	Wed, 19 Mar 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3QPq8BF"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35C1E32D5;
	Wed, 19 Mar 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402995; cv=none; b=G4WM9l/dypFeIEzz1lkyfDjb9zjsRjk3hLdrfacdXo0Kh+DzBSPhj/E+34CeCDo4wpeBsXblpSaoscxxAfYza9/a15ETYL6vWVd/6b3PJXD++gx9wplAlyJhZY9nom4P88cGQ+iqzh7GjNnF3w7lY6Sj8Lx2xmSc4M5j3Fx7daA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402995; c=relaxed/simple;
	bh=abmTlOlW8yHuHGZo8Vfx2BNiu7X70YAM3VxyVW2QeUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ky+oc0uADM0B6yL9i+UZeNWNsP+jSBmbjUTVyTBeYA8NEFO19USH83Hnk+wvRu/pfrznEebbKMdJdLcFoqADv4yC/MYED1hWlrImbf0dCyc6POin0T4Ufyu90LEF0cNNbfc3pzSc8o1/aVzHVAiC7o2CD97SBUMvlLPDvDAZQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3QPq8BF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so6306155a91.1;
        Wed, 19 Mar 2025 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742402993; x=1743007793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyUIVOLZhlVIcgING8aBn5z7brc7JiCZIt0y5wEI684=;
        b=V3QPq8BFlCj5WNJOCqMw5RXVS119qzM02oTcsK2xVCxJWkMRxDTR0gVxVs+rRfIFcD
         NjWWLuNKKSquVgzFkiMZ4tzQjdkmqJphJ/5s1YR8DGCeeY4aazNUsnXegDoDRzS+rU1U
         1z7qbeBdH40eMd6Eoykq3/chXQvqOiHJXZTahcj59+s6gUsRmurXX8JbYILJAAm2oZNA
         t6B06OO/ogyeNtOExW4jPdbxiNl6Tr2Mdjo0e+Db7QJKbUpRwqICf8nb1bwGnlO3b8YF
         XrFep3L7fi3yChODTN0OxXCrP83RAd5ELlEZgtW4mihczv1unHJ6lURSbOjH3e0NPZsy
         UhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402993; x=1743007793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyUIVOLZhlVIcgING8aBn5z7brc7JiCZIt0y5wEI684=;
        b=XQX1vQMrsl/yrHlzoyv1bZYBMx1aTeTWW/FaQFKvvv4m2QL+IfILiaW8HY5gWbDn0k
         M9eX+XN3nydOAbNgr2oqU7f3dMKY9OrDau4ONyi7OrCUOCTfKl9glgTxIEG3YkX13JTA
         D8r8JKS62F6Oe6U8WN1AMf0TeIo0W7Q4xlLHHe8tbjZsBA+xZzk32sloNHxh+HESbM1g
         IiRXGE3I0Q23y/NPFSc86lt0QBvyoRt/lMGQ7Ex1fSp4PFRCz6N9O8cIdmb3DTrB40yR
         7zg7/RiEo3nTIg4vhStvNtnfR3bxG4bomnYe2xyHgP59e4UV3RJvxMHJKaXl+NE8GIg/
         C3VA==
X-Forwarded-Encrypted: i=1; AJvYcCWTxBzS1u2SNooYQ1ewRk2pNTpuA27px2+thU8UMfmStGhcHwHSjySIIyhJp7t5NqIKUouHddZ1zw0GzlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCzPu62sDwUXNUB/2YzTKwIOXIGzcs51dBjM+qkBWWOVl99TTo
	c+jCuNpaQfFSCS3msmkLu1Hg/NnUjkBkfWyJeG93KPvAXjjCtlp8
X-Gm-Gg: ASbGncsH9JJoDxH8ElCRB5sobic9uZiXxJzRnn3J+6r8qNXwPZOZAtNmoV5DMeVkPkU
	cloRn6yZXjx4/asrCkBYlphUQmYmy6av5L2qQhx16Pg3oxBXdOFebHDzkO6Xcg6KvH4T3zFvTX/
	ck581V5WgNJyYbfsJhgHze0scd3fvYjOQ91Mjw9KX9VprVWv8HzfU8nX6SwQIWYBzInZqpL7o+u
	ZGyyp66FSehSTg3/Ov6h8r+ZDAUMnZoT85hbFFBxQvfGyXTfecH054UH00YRv1QQPhdqK06aMlW
	HX045Pd/AoD+VCnFbtLV0nZyG15gsuG/XSNWn1m1VIHMZuY0F57Lwf3GFMjw4zbKdMNRh/gQ5ls
	RMNq3KEbeAtx+N2sgj3+gCbgua365qQb+
X-Google-Smtp-Source: AGHT+IHhdqRvGiRnM02XFEBX0cT/Yyoc/AZdF4bSUHhB9t9As2aIDMWD+63C8qtFZMUEBd6evCXPOw==
X-Received: by 2002:a17:90b:268a:b0:2fe:9e6c:add9 with SMTP id 98e67ed59e1d1-301bde76a0cmr6126690a91.18.1742402993479;
        Wed, 19 Mar 2025 09:49:53 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:49:53 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:22 +0800
Subject: [PATCH v4 1/8] ARM: dts: aspeed: catalina: Add IO Mezz board
 thermal sensor nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-1-7c34b8139014@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=1855;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=abmTlOlW8yHuHGZo8Vfx2BNiu7X70YAM3VxyVW2QeUw=;
 b=AmSie4wj+dx1uYqkqheVZm6XmYA2naDZizT1XoSzDVfNXANH9iEsSE+cuwJPhKnXlARR5KtMO
 rDRQS0FYu2gDx54jdp4YhRlS4Nnm9oDcaEvqWKEXcTvCS/FKw4BTONI
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add thermal sensor nodes for the IO Mezzanine (IO Mezz) board in the
Catalina platform device tree. These nodes enable temperature monitoring
for the backend NIC, improving thermal management and monitoring
capabilities.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 3822bb3c9243..75c3906d9654 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -190,6 +190,12 @@ i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			// IOB0 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux0ch1: i2c@1 {
 			#address-cells = <1>;
@@ -200,6 +206,12 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			// IOB0 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux0ch3: i2c@3 {
 			#address-cells = <1>;
@@ -361,6 +373,12 @@ i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			// IOB1 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux3ch1: i2c@1 {
 			#address-cells = <1>;
@@ -371,6 +389,12 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			// IOB1 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux3ch3: i2c@3 {
 			#address-cells = <1>;

-- 
2.31.1


