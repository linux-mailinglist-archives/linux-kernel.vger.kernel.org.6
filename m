Return-Path: <linux-kernel+bounces-340016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50783986D58
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1637C2824E3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56646192B85;
	Thu, 26 Sep 2024 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAN+Pa1m"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774FC190693;
	Thu, 26 Sep 2024 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334850; cv=none; b=Si+ZRbw/JO4WImQxGqI+NE5ucTTw7Aj1oHMnoYhnOYY+f/93ERFPA6MWbHsIppSF9EoNKk0iiiqfHDPfzFzzgeUo0LLnnzfCJCMqQadR92tAGZpik0Y2jou7nk0NFZuy0R4uDn9ecW4x6UCOk0MwycQDFwUtNYF4dtCpSpvPs34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334850; c=relaxed/simple;
	bh=0V6FLE+281a37oceNMtY2U44AQDVLVbnwlBShqJIfHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlvekCq21B3khDH/Gv7VbVG0avZtFsAt2XMcfTlInCm3ifoBGbmwgPI/rjJTs5FkiFASSut7G2AlXieVH146Fi480cZqtHYLJfuYnx1GB9VVQgf0ZvtwE571U49E66OAXIXQzSEnc/ZSvuTSgVq2E8y0fiI4qYs5vScI10H8r70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAN+Pa1m; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-206bd1c6ccdso5435355ad.3;
        Thu, 26 Sep 2024 00:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727334849; x=1727939649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0br9xx+1hI12eeylaPicMIvQh3OEXvDraYoSk45RdRg=;
        b=FAN+Pa1mYbwskrE/v7mcRHgN+9fQt6GIVkcgnq0vP94wtYCqwzC1La9HFu6DUtSiCm
         ZF0eJ00M66Ts8VGpcbstQSBb2/lxnSpWHqu7wAAiRWZpIk/7LdtJMj5cBTnWdcMqAXTX
         1EfC0dc6kSczmw8pAqNjz0QCI4tkU6FL0XHRtnGNBFrmcoetRQGH3HAdAHBCychRkm4r
         ias53cDvLKvS0wrq/N3X7NbXuycl0MxxwcdS7kIG0/iDPGcndPAOtgOisGHquddHxZVi
         I0+BG4U46VNoSOHxFpFWgIy2FocNulfkCwTJ4CDzYynBDJvPnG9nOVwNlgLWnDAxzPPP
         G6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727334849; x=1727939649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0br9xx+1hI12eeylaPicMIvQh3OEXvDraYoSk45RdRg=;
        b=Hc3ze9O2B63EmS7s/C8INrED1hoU6YohE4X35s3ihexNzKSEyeCm4uHDXFaonMdL1q
         4E6hYPtuuwGvjAoFp60EDe1pDJS8D6SL4NZg4YcxqlWzEI5/M+Wo3Q5dMpXH+J3HHLA6
         wMLQ91VBBzjWCINxRipiEZaT0LWMgnigqZP7pCE4GU7grsSTkE4VY5z8xSkMT+A6vak1
         sf8giiR09gb6ms4x7j7hdcRn9DwvFW0LQ9xz1khsSizfKjczsAxZOkG4+DoII/qK4EhJ
         nyvwCe/GiT+57fa4m1LYTAZEtpIjZs8j49dNeDEbAeiJl/ogcAAVYTbwFfLwPtwXbPDX
         msZw==
X-Forwarded-Encrypted: i=1; AJvYcCW+/bMbVa1Lnrc1/zdUAI5MxVnjTqNSOQ7BC+M23PgBOoFofReNWMN/ctVHRSVRaVo8T6qdggwHpzkExaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeH5vTGl5l+Zit2y/oMuZt+b9b1RRzKFKh5Scdwm4qkReRP1sP
	+RNNxsnIyiRZO9z2MFdocRUB53k2ZZSBb8rv8/QnI+XlHzK1guLA
X-Google-Smtp-Source: AGHT+IGT9OKPl5lRL+by+mzm0cbQ+9A5WLrLoLDoEAWmMG8YT88P6yuMnUfWS9wkVwna4rdG+ZJ6TQ==
X-Received: by 2002:a17:90a:c794:b0:2e0:9275:b4a8 with SMTP id 98e67ed59e1d1-2e09275b4ebmr2359982a91.11.1727334848898;
        Thu, 26 Sep 2024 00:14:08 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d3e79sm2662906a91.27.2024.09.26.00.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:14:08 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 26 Sep 2024 15:10:46 +0800
Subject: [PATCH v2 3/3] ARM: dts: aspeed: catalina: update NIC1 fru address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-catalina-evt-dvt-system-modify-v2-3-a861daeba059@gmail.com>
References: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
In-Reply-To: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727334839; l=751;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=0V6FLE+281a37oceNMtY2U44AQDVLVbnwlBShqJIfHk=;
 b=/KusJNCpvze1qMVWT1zgxWylSTjPwplzIUaPlkXMWaDr2lQP2HQOs/1jhHwb4x8ay9eDIiVQD
 pnpOYdPA/uCC6FEH9mid+pbfr67O+F3ICVhSoKYZxVvTCE2G9IlFgJo
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update NIC1 FRU EEPROM address to 0x52 based on EVT changes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 9502d483e738..ac3e57e9c99e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -849,9 +849,9 @@ temperature-sensor@1f {
 	};
 
 	// OCP NIC1 FRU EEPROM
-	eeprom@50 {
+	eeprom@52 {
 		compatible = "atmel,24c64";
-		reg = <0x50>;
+		reg = <0x52>;
 	};
 };
 

-- 
2.31.1


