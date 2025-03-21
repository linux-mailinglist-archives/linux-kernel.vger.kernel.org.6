Return-Path: <linux-kernel+bounces-570821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C46A6B502
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D914675A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C00B1EFFB9;
	Fri, 21 Mar 2025 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbWbXp9g"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF61EFF96;
	Fri, 21 Mar 2025 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542119; cv=none; b=nCBPQJKosHOpzFdxWCXUzJZCa+x1fdYQZ8oTEiUzcfnGBvXCaUFnTTZwxupeAOnONxvTQXONmB6GrfRqhf9L48pEVurySJhQx5r2lgqU1HwfrfxNJMk8+tDoKJxhgeHgaDG8S457TIUxNe6LN8Qe1gCsc4n7zFlUe2lDfDIXmPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542119; c=relaxed/simple;
	bh=ulbtp+kTE7qMNV9lUn4Tys8j+TjW1Jo7Lvsg5SrWzbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlGbt4cNW6RuFnO0rVLIocM7KrUul94cItpf1IJf1e312NCd91HQdicPH+7vpIUHHJZk4kPwSjReEdGqVRxC1p5OZIZimzkEp8TOjtuoIM1TeRhms0wAToUKSfoQZ9Nlqfz/Snzp1RdaC4Ns2V8bkd10JXwhZ6GgOII/c4WgBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbWbXp9g; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22423adf751so32868315ad.2;
        Fri, 21 Mar 2025 00:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542117; x=1743146917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKGzggxqR/JI7t8XueEDBWptW6/F6u3t8TVX1C7g4ps=;
        b=mbWbXp9gIqP4/lr65fn7fTXHSLLcqytvdlI+yoK0maXdbbvd4fE5XId6vILEi0zUS0
         JWaFC0qHaF9klJxQG0BxS0XqvLOUtzNMBITfRSl+tFQKRIL9W6XhzOrfAProiUDLDL7i
         aJclSvjCZER1vD5YMSIUXnNmNFPHUPce1R6qK2b/s/PM9uXlbCmeHQAsWPPTMboXPLVx
         TDuIg4WphqLzGfZBPMs2oM4wC2Ap9DOjtti01+AdfFlDHpQKwsiurccICKFtU8avcJfD
         jZ8WFQ4J0CNc9qBXSDq51a6wRYcU1q0BVvb7Qimg5rFDvkIhEZCFKcO75Is/NXLd262d
         R60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542117; x=1743146917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKGzggxqR/JI7t8XueEDBWptW6/F6u3t8TVX1C7g4ps=;
        b=hI3XfVVdI+hAw8m/xwuMt6a93wGlq7lbU5w41lD/YxZtvNVnULQR920I69KJJuZ1ju
         2Ii29rtFFXxCP+awglmtRdBt+HgeZs9ibhvlEI1gG7cc1z1AncA5jMxuach4P3ff6Gv7
         03ZRpMBeVDTtLuqkSbMOtLuVr5+uASL7fSGoYb74zepYciw2mPYjr4Bp4aO4gk21ofR0
         578pQwhFm1nclVhrFO5zhUZseLE9nJ39opAqB0P1vo/NX25tkenTUzMXc8IFzAucrFt7
         +MyOmfgjVoC/ZyIJS0xrVyeimV+rp+4SfjR1Ym4CwZKC2fMrvWE5Zr7IqUB7Gc9IyDcZ
         iT1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgdmJ7xDVCebTDOour/F52zTp80e9rN5/zxbPAT0HtnQsWZ/R5LJ5eDc250ZwRK74IJR/3gcerY5kSMYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsg7eF0L9zaTsehnS9SjkNtwXkcXOFmB4lcJW4oroJcPm1bVaF
	Abyi8heMhs/XJiC6KgK4QpDteJyJAOHXAHEv9akg9L1DbpffcUHo
X-Gm-Gg: ASbGncv/rHxdX/GWBQ9+dIxNX+Zw31nbnKuvftzKsxqSfcl7wj9te1KkG7YnLPSb0Zz
	BkBeU+tfU1fv/5cwn7hmIjLKCpmh1zxZoXZKegQGK5Q/JpfehqeUI8PRWleaQFgJLPttnTORvPp
	pMhwiCLIXvz/hiPB8oRXbjfqiKlpo51X16kj0G8ApxCfwMFKojAxNJagugHAOPSdmCVNw4Emll5
	hpsMoSZ1XaHjzSr+hVdLzIvfGMYI8GddsFozYECw/dP2LdSJXfkH9rv6tqvorzXpBCXSevYoF0v
	C09B7JiP9KvBkAHmys3LxjaCAKBvyGRWndx4hyqp/BqOvtUmDKhag7+nSC+4fCHpS3ZCDbFoJ+Z
	9Hy6d4pnRH9vYI1c7EfrSOw==
X-Google-Smtp-Source: AGHT+IG4Ey9POVcNaA5EGYOeSpcSkXZH34RORqBkMDNOebesXmi/pjhykauo5+xRwD9ve+EX6szv5w==
X-Received: by 2002:a17:902:ef49:b0:224:24d3:60f4 with SMTP id d9443c01a7336-22780c786c8mr40390675ad.15.1742542116766;
        Fri, 21 Mar 2025 00:28:36 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:36 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:05 +0800
Subject: [PATCH v6 04/10] ARM: dts: aspeed: catalina: Add fan controller
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-4-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=1059;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=ulbtp+kTE7qMNV9lUn4Tys8j+TjW1Jo7Lvsg5SrWzbM=;
 b=JffdhqzDNi+p7Ljhq9yTdsOYOGNKOk8fYUlvKqY8GbPQyJNDTlH0oW4aQKk2VDjnBCxsfBLX0
 xEZpBXbA+R3DaTWCTvQUw+39xUt7EswRSzrHKgKWxD6u5I2ABVAvK4q
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the MAX31790 fan controllers on the Power
Distribution Board (PDB). These nodes enable fan speed control and
monitoring, improving thermal management and system reliability.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index f5f47245796a..792b739b1103 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -466,6 +466,15 @@ i2c1mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x2>;
+
+			fanctl0: fan-controller@21{
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+			};
+			fanctl1: fan-controller@27{
+				compatible = "maxim,max31790";
+				reg = <0x27>;
+			};
 		};
 		i2c1mux0ch3: i2c@3 {
 			#address-cells = <1>;

-- 
2.31.1


