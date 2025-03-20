Return-Path: <linux-kernel+bounces-569940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6710FA6A9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F1D189503D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA55225A38;
	Thu, 20 Mar 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY87dEu6"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD57C22424C;
	Thu, 20 Mar 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484296; cv=none; b=NE5ZwTAKG/7/AImc1tK2gneM3xyR0P4hnvQdGaCFta3pOtFq+ARy4rmMhHYkChYsEjm265UL64o7amdOJRpRzCSBQ7HuTPy3+39YTumI1hf+B8ebu4Evi/gSTN76uJwZJzjyu/lnP1Vuvw7vDEUz9FVEHJgGKNytwTN9qMuXryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484296; c=relaxed/simple;
	bh=8Sc7+TmNtcYLYM8RQCVTgjvfsStUP1z0J+a5AZtpYRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3UtqjBHGZ86wMlxVZztb/UvvAwpvESgBme7Al8/q5vyqrVIOdoGW/CiaJrSjgf4RXOkceheQx4yHCY3DIFFT+m6IkV8+1XbQ7qKg9ARBDltc9EZIqFf+vSfYN+n+FIfuwcY+NEbk2mIXGnriR+XwpsrmzgIyk13d3Yj/l5pq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY87dEu6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223a7065ff8so28684635ad.0;
        Thu, 20 Mar 2025 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484293; x=1743089093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kb43eZp0bmT9XV4NUKBfJXCRO8FE0/kL/olt+g/XIUA=;
        b=AY87dEu6BydK9oQMbdQ+YYpHfhGwJb2yZ+AMWOSIEjM3WBzDl96KGf9n0vWmYwLI7O
         wxOTZxWBoC60YdNcK424zU0a+rrK5IM+RWjx2CnhEO6l8XRfM1Ovzv2RJxOzujMfMzp0
         sPsXXYgYgwPZhuFOQ9AUBfuKnA4jyzvCdzYQ1viqe9e/LGRKklgn7vtVL0UsFOBIZpHU
         fOuyK4cdzBrgWnJ+wEdcOTp00Zk7GS7HAa9IOeUugseqe5/swZ9Zd2bcPYq5HoQhGLnr
         spls0hOeRnzA1SYOEveRn6ZMjehkMFwlkpsgoxpf/Y+zM7lz0KdACJ4kNHopZqk6iYRB
         qoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484293; x=1743089093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kb43eZp0bmT9XV4NUKBfJXCRO8FE0/kL/olt+g/XIUA=;
        b=ZKVs29UG0Itq8Yq//rw1OVJfpfVUdbovNp/jCDxiBJxfnEa6btOwEZ1uQYIdnZUrd0
         Z5LuT7nYFnHKFgfCP7raA9igubNG3QXqURD+6b+ZwWx5MAFaBkbw67Wda98+rWJqhMnl
         /uFZ51VPCD6TDERALvxg0DJAuHeyzfFTymnMW4cJUT4G8JkKKyk+aI1YyjAaABb4ppEb
         +Vrz6bGw2BDkz56dRuuPOR+VmQj4OKE2eHlnHCQ7BmZKh1oDOZVR1817zoXRmghJv9fm
         8/EmjMHpqbsX2ElHbzy2kpwbtE7P5Q3GWAsdRMAbe///kUTtFq8YvXYBn75hRpSUhEJ/
         3mhw==
X-Forwarded-Encrypted: i=1; AJvYcCVGWKtKJJyM9zP7Anp2dDdDhAciAote3U4uw6ftfx0De4tdcaMam+GeKpEMOoKRf+K4q4uPevG8Ef2RYI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxDsDhk0Xkv3jXLHAn0UC747Az9UDBbzqpYlmZFaQR2YBsjrP2
	CBuXG4YsdbJ3mxE6ziY9Ho90GowdPwSo69FQZnV1pfCSg129rfHh
X-Gm-Gg: ASbGncvbQzFCGBs4d5yWP4N2nA7JCvWaDZzh9xSW2DMJlRWbAihUOnipPKIe+AL0RQt
	beljK9IgOvZ9YeOR58EoMRg9BNNaAJ7zYxFD/5Q/02nvY6zPK5zE9cyVvPHICfnjToz5kLqHu1s
	KrPcvqlVE+17MzKF3eHLJg5udfDOVODpFl7+DcPk4P3lVwE67EFBaIRsF2U25iWtHVF9hz5VEfb
	zaDqlNGH30WugIy7kLFwPWMKXlYV6w1z7OmOO0jtwPblRT4ZeJU7qhEsGZHy5/TUrUmGRDgc05z
	cONwSLQDGK6/KoRH3+sbL/WeKOpVrINjZrpiYr/C+aXFzkZuY1N+uzIxxeHqLN+9eEW0fr+4b6B
	h7Kb9XjTioNYzzZcNG8drOZwCsk3UUrls
X-Google-Smtp-Source: AGHT+IHE92AmQP6pSQe4X5Gxq1K0w/g80wdi5cdppZrIPKVLtb+T7vCPI1VmndKmWdZXwXBLIpl/jg==
X-Received: by 2002:a17:902:c40a:b0:21f:7a8b:d675 with SMTP id d9443c01a7336-2264981d956mr117086675ad.4.1742484292652;
        Thu, 20 Mar 2025 08:24:52 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:52 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:59 +0800
Subject: [PATCH v5 09/10] ARM: dts: aspeed: catalina: Update CBC FRU EEPROM
 I2C bus and address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-9-e161be6583a7@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=1195;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=8Sc7+TmNtcYLYM8RQCVTgjvfsStUP1z0J+a5AZtpYRA=;
 b=/KhOPweORghlVtVjwU/eucupg8Thf8Xswg+01HtHScRvBcJV0CZqRNHJSG6xuAj/O2DZIQnHJ
 rpNwnn+DS2/C6KpcDvLKNTwchNFSz2tpuQnjFoOO6ZxJd3a+vsSPb70
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Revise the I2C bus and address for the Cable Backplane Cartridge (CBC)
FRU EEPROM in the Catalina device tree.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index abf15d322605..653afacc7af4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -822,6 +822,12 @@ eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
+
+	// Secondary CBC FRU EEPROM
+	eeprom@54 {
+		compatible = "atmel,24c02";
+		reg = <0x54>;
+	};
 };
 
 &i2c13 {
@@ -834,18 +840,12 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
-	// Left CBC FRU EEPROM
+	// Primary CBC FRU EEPROM
 	eeprom@54 {
 		compatible = "atmel,24c02";
 		reg = <0x54>;
 	};
 
-	// Right CBC FRU EEPROM
-	eeprom@55 {
-		compatible = "atmel,24c02";
-		reg = <0x55>;
-	};
-
 	// HMC FRU EEPROM
 	eeprom@57 {
 		compatible = "atmel,24c02";

-- 
2.31.1


